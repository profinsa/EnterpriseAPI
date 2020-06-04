update databaseinfo set value='2019_06_20',lastupdate=now() WHERE id='Version';

update purchaseheader set RecivingNumber=PurchaseNumber WHERE RecivingNumber IS NULL OR RecivingNumber='';
