update databaseinfo set value='2019_09_18',lastupdate=now() WHERE id='Version';

alter table accesspermissions ADD COLUMN MetaView tinyint(1) after RTSystemView;
alter table accesspermissions ADD COLUMN MetaAdd tinyint(1) after MetaView;
alter table accesspermissions ADD COLUMN MetaEdit tinyint(1) after MetaAdd;
alter table accesspermissions ADD COLUMN MetaDelete tinyint(1) after MetaEdit;
alter table accesspermissions ADD COLUMN MetaReports tinyint(1) after MetaDelete;
alter table accesspermissions ADD COLUMN ApproveCloudCustomers tinyint(1) after MetaReports;
alter table accesspermissions ADD COLUMN ApproveCustomerRemoval tinyint(1) after ApproveCloudCustomers;

update accesspermissions set MetaView=1, MetaAdd=1, MetaEdit=1, MetaDelete=1, MetaReports=1, ApproveCloudCustomers=1, ApproveCustomerRemoval=1 WHERE EmployeeID='Admin';
update accesspermissions set MetaView=1, MetaAdd=1, MetaEdit=1, MetaDelete=1, MetaReports=1, ApproveCloudCustomers=1, ApproveCustomerRemoval=1 WHERE EmployeeID='Demo';
