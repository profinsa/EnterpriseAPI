alter table inventoryitems add column VATItem tinyint(1) after TaxPercent;
alter table inventoryitems add column VATItemType NvarChar(36) after VATItem;
alter table inventoryitems add column VATExcluded tinyint(1) after VATItemType;
alter table inventoryitems add column VATInvestibleItem tinyint(1) after VATExcluded;
alter table inventoryitems add column VATCreditingRight tinyint(1) after VATInvestibleItem;
alter table inventoryitems add column VATSupply tinyint(1) after VATCreditingRight;


alter table inventoryitems add column Picture NvarChar(80) after PictureURL;
alter table inventoryfamilies add column FamilyPicture NvarChar(80) after FamilyPictureURL;
alter table inventorycategories add column CategoryPicture NvarChar(80) after CategoryPictureURL;
