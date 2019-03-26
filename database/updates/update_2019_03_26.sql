update databaseinfo set value='2019_03_26',lastupdate=now() WHERE id='Version';
alter table currencytypes MODIFY COLUMN CurrencyRateLastUpdate datetime NULL DEFAULT NULL;
alter table currencytypes MODIFY COLUMN CurrenycySymbol varchar(3);
