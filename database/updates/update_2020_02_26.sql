update databaseinfo set value='2020_02_26',lastupdate=now() WHERE id='Version';
alter table customerinformation ADD COLUMN LeaseRentalAgreement text after PrimaryInterest;
alter table customerinformation ADD COLUMN RentalApplication text after LeaseRentalAgreement;
alter table customerinformation ADD COLUMN HOAInterview text after RentalApplication;
