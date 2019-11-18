update databaseinfo set value='2019_11_18',lastupdate=now() WHERE id='Version';

alter table leadinformation ADD COLUMN UniqID nvarchar(50) after LeadMemo9;
