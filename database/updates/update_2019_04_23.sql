update databaseinfo set value='2019_04_23',lastupdate=now() WHERE id='Version';

alter table payrollemployees ADD COLUMN LastSessionUpdateTime datetime after EnteredBy;
