

CREATE TABLE tblIntDataTypes(
	id1 tinyint,
	id2 smallint,
	id3 int,
	id4 bigint
)

insert into tblIntDataTypes(id1) values(0)
insert into tblIntDataTypes(id1) values(255)
insert into tblIntDataTypes(id1) values(-1)
insert into tblIntDataTypes(id1) values(256)


select * from tblIntDataTypes