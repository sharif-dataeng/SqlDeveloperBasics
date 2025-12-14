from PIL import Image, ImageDraw, ImageFont
import os
import math

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
IMAGES_DIR = os.path.join(ROOT, "docs", "images")
os.makedirs(IMAGES_DIR, exist_ok=True)

WIDTH, HEIGHT = 1280, 720
BG = "#ffffff"

def load_font(size):
    try:
        return ImageFont.truetype("arial.ttf", size)
    except Exception:
        try:
            return ImageFont.truetype("DejaVuSans.ttf", size)
        except Exception:
            return ImageFont.load_default()

def draw_arrow(draw, x1, y1, x2, y2, color="#333", width=3, head=12):
    draw.line((x1, y1, x2, y2), fill=color, width=width)
    # arrow head
    angle = math.atan2(y1 - y2, x1 - x2)
    sin, cos = math.sin(angle), math.cos(angle)
    hx = x2 + head * cos
    hy = y2 + head * sin
    left = (x2 + head * math.cos(angle + 0.5), y2 + head * math.sin(angle + 0.5))
    right = (x2 + head * math.cos(angle - 0.5), y2 + head * math.sin(angle - 0.5))
    draw.polygon([ (x2,y2), left, right ], fill=color)

def save(img, path):
    img.save(path, optimize=True)

# 1) OLTP diagram: application -> OLTP DB with multiple short transactions
def make_oltp(path):
    img = Image.new("RGB", (WIDTH, HEIGHT), BG)
    d = ImageDraw.Draw(img)
    title_font = load_font(36)
    body_font = load_font(18)

    # title bar
    d.rectangle([0,0,WIDTH,80], fill="#2b6cb0")
    d.text((24,18), "OLTP (Online Transaction Processing)", fill="#fff", font=title_font)

    # application boxes
    app_x = 80
    app_y = 140
    for i,label in enumerate(["Web/API", "Mobile", "POS"]):
        x = app_x + i*220
        d.rectangle([x, app_y, x+180, app_y+90], outline="#2b6cb0", width=4, fill="#f0f7ff")
        d.text((x+14, app_y+36), label, fill="#0b3b66", font=body_font)

    # OLTP DB
    db_x, db_y = 580, 140
    d.ellipse([db_x, db_y, db_x+260, db_y+120], outline="#d69e2e", width=4, fill="#fff7ed")
    d.text((db_x+30, db_y+44), "OLTP\nDatabase\n(Normalized)", fill="#b7791f", font=body_font)

    # arrows (many small transactions)
    for i in range(3):
        sx = app_x + i*220 + 90
        sy = app_y + 90
        ex = db_x + 130
        ey = db_y
        draw_arrow(d, sx, sy, ex, ey, color="#333", width=3)

    # small transaction icons near arrows
    for i in range(6):
        tx = 420 + i*30
        ty = 320 + (i%2)*10
        d.rectangle([tx, ty, tx+18, ty+12], fill="#2b6cb0")

    d.text((60, 420), "Many short, concurrent transactions (ACID). Optimized for fast reads/writes and correctness.", fill="#333", font=body_font)
    save(img, path)

# 2) OLAP diagram: sources -> ETL -> DW (star schema) -> BI/Reports
def make_olap(path):
    img = Image.new("RGB", (WIDTH, HEIGHT), BG)
    d = ImageDraw.Draw(img)
    title_font = load_font(36)
    body_font = load_font(18)

    d.rectangle([0,0,WIDTH,80], fill="#2b6cb0")
    d.text((24,18), "OLAP (Online Analytical Processing)", fill="#fff", font=title_font)

    # source boxes
    sources = ["OLTP\nSystems", "Logs\nStreams", "3rd Party\nFeeds"]
    sx = 60
    for i, s in enumerate(sources):
        x = sx + i*220
        d.rectangle([x, 120, x+180, 200], outline="#238a7e", width=3, fill="#eefbf5")
        d.text((x+10, 140), s, fill="#116b5e", font=body_font)

    # ETL box
    etl_x, etl_y = 340, 240
    d.rectangle([etl_x, etl_y, etl_x+220, etl_y+80], outline="#b7791f", width=3, fill="#fffbe6")
    d.text((etl_x+20, etl_y+24), "ETL / ELT\nTransform & Load", fill="#8a560a", font=body_font)

    # arrows from sources to ETL
    for i in range(3):
        sx = 60 + i*220 + 90
        sy = 200
        ex = etl_x + 110
        ey = etl_y
        draw_arrow(d, sx, sy, ex, ey, color="#333")

    # Data Warehouse box with star schema
    dw_x, dw_y = 620, 120
    d.rectangle([dw_x, dw_y, dw_x+360, dw_y+280], outline="#2b6cb0", width=3, fill="#f6f9ff")
    d.text((dw_x+20, dw_y+12), "Data Warehouse / OLAP", fill="#2b6cb0", font=body_font)

    # star schema inside DW
    fx, fy = dw_x+180, dw_y+140
    d.rectangle([fx-60, fy-30, fx+60, fy+30], outline="#4a5568", width=3, fill="#fff")
    d.text((fx-40, fy-12), "FactSales\n(Measures)", fill="#333", font=body_font)

    # dims as circles
    dims = [("Date", fx-160, fy-100), ("Product", fx-60, fy+110), ("Customer", fx+60, fy+110), ("Store", fx+160, fy-100)]
    for label, cx, cy in dims:
        d.ellipse([cx-36, cy-36, cx+36, cy+36], outline="#718096", width=3, fill="#fff")
        d.text((cx-24, cy-10), label, fill="#333", font=body_font)
        draw_arrow(d, cx, cy, fx-10, fy, color="#718096", width=2)

    # Arrow from ETL to DW
    draw_arrow(d, etl_x+220, etl_y+40, dw_x, dw_y+40, color="#333")

    # BI box
    bi_x, bi_y = 760, 420
    d.rectangle([bi_x, bi_y, bi_x+220, bi_y+80], outline="#2b6cb0", width=3, fill="#eefbf5")
    d.text((bi_x+20, bi_y+24), "BI / Dashboards", fill="#116b5e", font=body_font)
    draw_arrow(d, dw_x+260, dw_y+220, bi_x, bi_y+40, color="#333")

    d.text((60, 440), "Designed for large scans, aggregations and trends. Uses denormalized or pre-aggregated structures for speed.", fill="#333", font=body_font)
    save(img, path)

# 3) Normalization diagram: show denormalized row -> normalized tables
def make_normalization(path):
    img = Image.new("RGB", (WIDTH, HEIGHT), BG)
    d = ImageDraw.Draw(img)
    title_font = load_font(36)
    body_font = load_font(18)

    d.rectangle([0,0,WIDTH,80], fill="#b7791f")
    d.text((24,18), "Normalization (1NF → 3NF)", fill="#fff", font=title_font)

    # denormalized table box
    d.rectangle([60, 120, 520, 220], outline="#c05621", width=3, fill="#fff8f0")
    d.text((80, 130), "Denormalized Orders Table (one row per item with repeated customer info)", fill="#333", font=body_font)
    d.text((80, 160), "OrderID | CustomerName | CustomerEmail | ProductID | ProductName | Qty | Price", fill="#333", font=load_font(14))

    # arrow to normalized
    draw_arrow(d, 520, 170, 620, 170, color="#333")

    # normalized tables
    nx = 680
    # Customers
    d.rectangle([nx, 120, nx+220, 180], outline="#2f855a", width=3, fill="#f0fff4")
    d.text((nx+10, 130), "Customers", fill="#133f2b", font=body_font)
    d.text((nx+10, 150), "CustomerID, Name, Email", fill="#333", font=load_font(14))
    # Products
    d.rectangle([nx, 200, nx+220, 260], outline="#2b6cb0", width=3, fill="#eef2ff")
    d.text((nx+10, 210), "Products", fill="#1e3f66", font=body_font)
    d.text((nx+10, 230), "ProductID, Name, Price", fill="#333", font=load_font(14))
    # Orders & Items
    d.rectangle([nx+260, 120, nx+560, 180], outline="#b7791f", width=3, fill="#fffbe6")
    d.text((nx+270, 130), "Orders", fill="#7a4f12", font=body_font)
    d.text((nx+270, 150), "OrderID, CustomerID, OrderDate", fill="#333", font=load_font(14))
    d.rectangle([nx+260, 200, nx+560, 260], outline="#b7791f", width=3, fill="#fffbe6")
    d.text((nx+270, 210), "OrderItems", fill="#7a4f12", font=body_font)
    d.text((nx+270, 230), "OrderItemID, OrderID, ProductID, Qty, Price", fill="#333", font=load_font(14))

    d.text((60, 360), "Normalization splits repeated data into separate tables so updates happen in one place.", fill="#333", font=body_font)
    save(img, path)

# 4) Denormalization diagram: normalized tables -> flattened summary table
def make_denormalization(path):
    img = Image.new("RGB", (WIDTH, HEIGHT), BG)
    d = ImageDraw.Draw(img)
    title_font = load_font(36)
    body_font = load_font(18)

    d.rectangle([0,0,WIDTH,80], fill="#c05621")
    d.text((24,18), "Denormalization (Flattened / Aggregates)", fill="#fff", font=title_font)

    # normalized tables left
    left_x = 60
    d.rectangle([left_x, 120, left_x+200, 180], outline="#2f855a", width=3, fill="#f0fff4")
    d.text((left_x+10, 130), "Customers", fill="#133f2b", font=body_font)
    d.rectangle([left_x, 200, left_x+200, 260], outline="#2b6cb0", width=3, fill="#eef2ff")
    d.text((left_x+10, 210), "Products", fill="#1e3f66", font=body_font)
    d.rectangle([left_x, 280, left_x+200, 340], outline="#b7791f", width=3, fill="#fffbe6")
    d.text((left_x+10, 290), "Orders / OrderItems", fill="#7a4f12", font=body_font)

    # arrows to flatten
    draw_arrow(d, left_x+200, 150, 520, 150, color="#333")
    draw_arrow(d, left_x+200, 230, 520, 230, color="#333")
    draw_arrow(d, left_x+200, 310, 520, 310, color="#333")

    # flattened table
    d.rectangle([540, 120, 1200, 340], outline="#c05621", width=3, fill="#fff8f0")
    d.text((560, 130), "OrdersFlat (Denormalized)", fill="#9a2d00", font=body_font)
    d.text((560, 160), "OrderID | OrderDate | CustomerName | CustomerEmail | ProductName | Qty | Price", fill="#333", font=load_font(14))

    d.text((60, 380), "Denormalization copies or combines fields to make reads faster at the cost of extra storage and update complexity.", fill="#333", font=body_font)
    save(img, path)

if __name__ == "__main__":
    os.makedirs(IMAGES_DIR, exist_ok=True)
    make_oltp(os.path.join(IMAGES_DIR, "oltp.png"))
    make_olap(os.path.join(IMAGES_DIR, "olap.png"))
    make_normalization(os.path.join(IMAGES_DIR, "normalization.png"))
    make_denormalization(os.path.join(IMAGES_DIR, "denormalization.png"))
    print("Generated diagrams in:", IMAGES_DIR)