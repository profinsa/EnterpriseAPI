update databaseinfo set value='2019_11_04',lastupdate=now() WHERE id='Version';

alter table inventoryitems ADD COLUMN ProfileARModule tinyint(1) after VATSupply;
alter table inventoryitems ADD COLUMN ProfileAPModule tinyint(1) after ProfileARModule;
alter table inventoryitems ADD COLUMN ProfileGLModule tinyint(1) after ProfileAPModule;
alter table inventoryitems ADD COLUMN ProfileInventoryModule tinyint(1) after ProfileGLModule;
alter table inventoryitems ADD COLUMN ProfileMRPModule tinyint(1) after ProfileInventoryModule;
alter table inventoryitems ADD COLUMN ProfileCRMModule tinyint(1) after ProfileMRPModule;
alter table inventoryitems ADD COLUMN ProfilePayrollModule tinyint(1) after ProfileCRMModule;
alter table inventoryitems ADD COLUMN ProfileSystemModule tinyint(1) after ProfilePayrollModule;
alter table inventoryitems ADD COLUMN ProfileReportsModule tinyint(1) after ProfileSystemModule;
alter table inventoryitems ADD COLUMN ProfileCARTModule tinyint(1) after ProfileReportsModule;
alter table inventoryitems ADD COLUMN ProfileDefaultInterface varchar(40) after ProfileCARTModule;
alter table inventoryitems ADD COLUMN ProfileInterfaceRTL tinyint(1) after ProfileDefaultInterface;
alter table inventoryitems ADD COLUMN ProfileExpirationDays int after ProfileCARTModule;
