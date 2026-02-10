# Spark FAQ — Detailed, Layman-Friendly Answers (with PySpark examples)

This document answers common Spark questions in plain language and includes small PySpark examples and configuration tips.

----

## Contents
- 1. How does Spark decide whether a transformation causes a shuffle?
- 2. Narrow vs wide transformations
- 3. DAG Scheduler vs Task Scheduler
- 4. What happens when you call `show()` on a DataFrame
- 5. How Spark decides join strategy
- 6. Accumulators and broadcast variables
- 7. How Spark recovers from failed tasks
- 8. Adaptive Query Execution (AQE)
- 9. Serialization in Spark
- 10. Why excessive caching can slow jobs
- 11. Identifying bottlenecks with Spark UI
- 12. `map` vs `mapPartitions` vs `foreach`
- 13. Catalyst Optimizer
- 14. Writing DataFrames to Delta/Parquet
- 15. Safe schema evolution in PySpark
- 16. Reprocessing without duplication
- 17. Executor memory spill and tuning
- 18. Handling uneven partition sizes after joins (skew)
- 19. Validating large-scale data transformations

----

### 1) How does Spark decide whether a transformation causes a shuffle?

- Plain language: A shuffle happens when Spark needs to move rows between machines so that related rows end up on the same machine (for example, all rows with the same key). If rows can be processed where they already live, there's no shuffle.
- Common shuffle-causing operations: `groupBy`, `reduceByKey` (map-side combine reduces cost), `join` (most joins), `distinct`, `repartition(n)`, `sortBy`.
- No shuffle: `map`, `filter`, `flatMap`, `mapPartitions`, and `coalesce(n, shuffle=false)`.
- Tip: prefer `reduceByKey` vs `groupByKey` to reduce network I/O.

Example (PySpark):

```python
# No shuffle
ds.map(lambda x: x+1)

# Causes shuffle: keys must move to be collocated
ds.map(lambda x: (x['user_id'], x))\
  .groupByKey()
```

----

### 2) What is the difference between narrow and wide transformations internally?

- Narrow: each output partition depends on a small number of input partitions (often one). Tasks can be pipelined in the same stage. Examples: `map`, `filter`, `mapPartitions`.
- Wide: output partition depends on many input partitions, forcing a shuffle. Examples: `groupByKey`, `join`, most aggregations that require key co-location.
- Internal difference: narrow ops execute in a single stage; wide ops create stage boundaries and write/read shuffle files, causing disk and network I/O.

Practical effect: wide transformations are more expensive and form natural boundaries for parallel task scheduling.

----

### 3) How does Spark’s DAG Scheduler differ from the Task Scheduler?

- DAG Scheduler: builds the execution plan, breaks work into stages using shuffle boundaries, and decides stage-level dependencies.
- Task Scheduler: takes a single stage and launches tasks on executors (asks the cluster manager to start tasks), handles locality, retries, and task bookkeeping.

Flow: user action → DAG Scheduler splits into stages → Task Scheduler launches tasks for each stage.

----

### 4) What happens internally when you call `show()` on a DataFrame?

- `show()` is an action that triggers planning and execution. Spark builds logical and physical plans with Catalyst, generates tasks, runs them across executors, fetches up to the requested number of rows to the driver, and prints them.
- Important: `show()` executes the plan (even if it only returns 20 rows), so expensive reads/joins/filters will run when you call `show()`.

Example:

```python
df.filter("age > 30").select("name").show(10)
```

This will run the entire pipeline to produce the top 10 matching rows.

----

### 5) How does Spark decide which join strategy to use by default?

- Strategies: broadcast hash join (broadcast one small side), sort-merge join (shuffle both sides and sort), shuffle-hash join (less common in modern Spark).
- Default decision: if one side is smaller than `spark.sql.autoBroadcastJoinThreshold` (default ~10MB), Spark prefers broadcast join. Otherwise it uses sort-merge join. With AQE enabled, Spark can change the strategy at runtime.

Config example:

```python
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", 10 * 1024 * 1024)  # 10 MB
```

Force broadcast explicitly:

```python
from pyspark.sql.functions import broadcast
df.join(broadcast(small_df), "id")
```

----

### 6) What are accumulators and broadcast variables, and when should you avoid them?

- Accumulators: write-only variables tasks update; driver reads final value. Useful for counters/metrics. Avoid relying on them for business logic because retries/speculation can cause double increments.
- Broadcast variables: read-only objects sent to executors to avoid shipping the same data repeatedly (useful for small lookup maps). Avoid broadcasting huge objects because they consume executor memory.

When to avoid:
- Don't use accumulators to build important state (they're eventually-consistent counters for monitoring).
- Don't broadcast very large or frequently changing objects.

Example:

```python
from pyspark import SparkContext
sc = SparkContext.getOrCreate()
acc = sc.accumulator(0)
rdd.foreach(lambda x: acc.add(1))
print(acc.value)

bc = sc.broadcast({'a':1, 'b':2})
```

----

### 7) How does Spark recover from a failed task without recomputing everything?

- Spark tracks lineage: the series of transformations used to produce an RDD/DataFrame. To recompute a lost partition, Spark re-executes only the necessary upstream transformations for that partition.
- Shuffle outputs are stored on executors; if lost, the map tasks that produced them are re-run. Spark retries failed tasks a few times and recomputes only what’s needed.
- For long pipelines, use checkpointing to truncate lineage and reduce recompute cost.

----

### 8) What is Adaptive Query Execution (AQE) and how does it improve performance?

- AQE: runtime optimization that changes the physical plan using statistics collected during execution.
- Benefits:
  - Switch join strategies (shuffle → broadcast) if actual sizes are smaller than estimated.
  - Coalesce small shuffle partitions to reduce task overhead.
  - Handle skew by splitting large partitions.

Enable AQE:

```python
spark.conf.set("spark.sql.adaptive.enabled", "true")
```

AQE improves robustness when compile-time estimates are wrong.

----

### 9) How does Spark handle serialization, and why does it matter?

- Spark sends functions and data between driver and executors and writes shuffle files to disk — serialization impacts CPU, memory, and network usage.
- Options:
  - Java serialization (default for Java/Scala objects) — easy but heavy and slow.
  - Kryo serialization — faster and more compact (recommended for user classes).
  - Spark SQL's internal binary format (Tungsten) for `InternalRow` — very efficient for SQL workloads.

Best practice:

```python
spark.conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
```

- Avoid capturing large objects in closures — they get serialized for each task and cause large network transfers or memory pressure.

----

### 10) Why can excessive caching actually slow down a Spark job?

- Caching uses executor memory. If you cache too much, Spark will evict cached blocks, cause GC pressure, or spill to disk — all slowing jobs.
- Also, caching serialized data can add CPU overhead (serialize/deserialize) if the storage level uses serialization.

Guidelines:
- Cache only datasets that are reused.
- Use appropriate storage level (e.g., `MEMORY_ONLY` vs `MEMORY_AND_DISK`).
- `df.unpersist()` when no longer needed.

----

### 11) How do you identify performance bottlenecks using Spark UI?

- Key places to look:
  - Jobs/Stages: long-running stages, heavy shuffle stages.
  - Tasks: task duration distribution (long tails mean skew).
  - SQL tab: operator metrics (shuffle read/write, input size).
  - Executors: memory & GC time, disk I/O, lost tasks.
  - Storage: cached RDD/DataFrame sizes.

Common causes revealed by UI:
- High shuffle bytes → network bottleneck
- High GC time → memory pressure
- Wide variance in task times → data skew

Use Spark History Server to analyze completed runs.

----

### 12) What is the difference between `map`, `mapPartitions`, and `foreach`?

- `map`: transformation applied per element; returns new RDD/column.
- `mapPartitions`: transformation applied once per partition; receives an iterator — useful to initialize expensive resources once per partition.
- `foreach`: action for side effects (e.g., write to DB) — runs on executors, no result returned to driver; be careful about retries and duplicates.

Example:

```python
# map
rdd.map(lambda x: x*2)

# mapPartitions - open DB connection once per partition
def proc_part(iter):
    conn = open_conn()
    for r in iter:
        yield process(r, conn)
    conn.close()

rdd.mapPartitions(proc_part)

# foreach - side effect
rdd.foreach(lambda r: write_out(r))
```

----

### 13) How does Spark optimize queries using the Catalyst Optimizer?

- Phases:
  - Analysis: resolve columns/types
  - Logical optimization: rule-based rewrites (predicate pushdown, constant folding, projection pruning)
  - Physical planning: produce alternative physical plans (e.g., broadcast vs shuffle join)
  - Cost-based optimization (CBO): pick cheapest plan based on statistics
  - Code generation: `WholeStageCodegen` compiles parts of the plan for speed

Tips: collect table statistics (`ANALYZE TABLE`) to help CBO.

----

### 14) What happens when you write a DataFrame to Delta/Parquet?

- Parquet: columnar files with metadata and footers. Spark writes temporary files and then atomically renames them to final filenames.
- Delta: uses Parquet files under the hood but maintains a transaction log in `_delta_log` (JSON + checkpoints). Delta provides ACID transactions, schema enforcement, and time travel.

Example writes:

```python
# Parquet
df.write.mode("overwrite").parquet("/tmp/out")

# Delta (requires delta package)
df.write.format("delta").mode("append").save("/delta/table")
```

----

### 15) How do you handle schema evolution safely in PySpark pipelines?

- Approaches:
  - Use `unionByName(..., allowMissingColumns=True)` to combine slightly different schemas.
  - For Parquet: read with `mergeSchema=true` (costly).
  - For Delta: use `mergeSchema` when writing (careful governance).
  - Maintain a canonical schema registry and add new columns with defaults.

Example:

```python
df1.unionByName(df2, allowMissingColumns=True)

df.write.option("mergeSchema", "true").format("delta").mode("append").save(path)
```

----

### 16) How do you design PySpark jobs to handle reprocessing without duplication?

- Best practices:
  - Use idempotent writes or upserts (Delta `MERGE`) keyed by a unique id.
  - Deduplicate by unique keys and highest timestamp: window + `row_number()`.
  - For streaming, rely on checkpoints to avoid reprocessing.
  - Add a job-run id and use it to detect or avoid double-appends in sinks.

Example (Delta upsert):

```python
from delta.tables import DeltaTable
target = DeltaTable.forPath(spark, "/delta/table")
target.alias("t").merge(
    source_df.alias("s"), "t.id = s.id")\
  .whenMatchedUpdateAll()\
  .whenNotMatchedInsertAll()\
  .execute()
```

----

### 17) What causes executor memory spill, and how do you tune it?

- Causes: insufficient memory for shuffle, caching, or aggregations; very large partitions; many cached datasets.
- Symptoms: frequent spills to disk, long GC pauses, slow tasks.

Tune using:

```python
spark.conf.set("spark.memory.fraction", "0.6")
spark.conf.set("spark.memory.storageFraction", "0.3")
spark.conf.set("spark.sql.shuffle.partitions", "200")
spark.conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
```

- Other fixes: increase executor memory, repartition to more partitions, or reduce cached data.

----

### 18) How do you deal with uneven partition sizes after joins?

- Problem: some keys dominate (hot keys), creating a few huge partitions.
- Solutions:
  - Salting: add a random suffix to the join key for heavy keys to spread them across partitions, then remove salt after join.
  - Broadcast the small side if applicable.
  - Use AQE to split skewed partitions automatically.
  - Pre-aggregate large keys before join.

Salting concept (PySpark sketch):

```python
from pyspark.sql.functions import floor, rand
n = 8
big = big.withColumn("salt", floor(rand()*n))
small = small.withColumn("salt", floor(rand()*n))
big.join(small, on=[big.key == small.key, big.salt == small.salt])
```

Note: salting increases data volume and complexity — use only when needed.

----

### 19) How do you validate large-scale data transformations efficiently?

- Strategies:
  - Automated checks: counts, null checks, uniqueness, distributions.
  - Sampling: run full logic on representative samples to catch logic errors quickly.
  - Data quality libraries: Deequ, Great Expectations.
  - Checksums/hashes by partition or key to compare before/after.
  - Unit tests on small data, integration tests in staging with full data slices.

Quick example checks:

```python
cnt = df.count()
null_ids = df.filter(df.id.isNull()).count()
assert cnt > 0
assert null_ids == 0
```

----

## Final notes and tips

- Prefer simpler operations and fewer shuffles.
- Use `spark.sql.shuffle.partitions` to tune parallelism for your cluster size.
- Use Kryo serialization for custom classes and enable AQE for many workloads.
- For production pipelines use Delta (or another transactional format) for safe writes and upserts.

If you want, I can also:
- produce a one-page printable cheat sheet, or
- create runnable PySpark example scripts and a small `README.md` showing how to run them locally.
