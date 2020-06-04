CREATE TABLE databaseinfo (
    id varchar(16),
    value varchar(255),
    lastupdate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

insert into databaseinfo (id, value) values ('Version', '13_03_2019');
alter table inventoryitems add column CartItem tinyint(1) after TaxPercent;
