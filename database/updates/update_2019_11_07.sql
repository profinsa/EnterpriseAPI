update databaseinfo set value='2019_11_07',lastupdate=now() WHERE id='Version';

alter table helpsupportrequest ADD COLUMN UniqID nvarchar(50) after SupportApprovedBy;
alter table helpsupportrequest ADD COLUMN EmailConfirmed tinyint(1) after UniqID;
