alter table inventoryitems add column Picture NvarChar(80) after PictureURL;
alter table inventoryfamilies add column FamilyPicture NvarChar(80) after FamilyPictureURL;
alter table inventorycategories add column CategoryPicture NvarChar(80) after CategoryPictureURL;