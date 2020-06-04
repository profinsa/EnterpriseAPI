update databaseinfo set value='2019_09_17',lastupdate=now() WHERE id='Version';

alter table appinstallations ADD COLUMN CompanyID varchar(36) after CustomerID;
alter table appinstallations ADD COLUMN DivisionID varchar(36) after CompanyID;
alter table appinstallations ADD COLUMN DepartmentID varchar(36) after DivisionID;

update appinstallations SET CompanyID='DINOS', DivisionID='DEFAULT', DepartmentID='DEFAULT' WHERE Clean=0;
