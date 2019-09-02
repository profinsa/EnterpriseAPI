CREATE TABLE AppInstallations(
    CustomerID nvarchar(50),
    SoftwareID nvarchar(50),
    ConfigName nvarchar(100),
    InstallationName nvarchar(100),
    InstallationDate datetime,
    ExpirationDate datetime,
    Active tinyint(1),
    LoggedIn int
);

/*
CustomerID nvarchar 50 DINOS
SoftwareID nvarchar 45 EnterpriseX Trial
InstallationName nvarchar 50 dinos
InstallationDate datetime 5 september 2019
ExpirationDate datetime 5 october 2019
Active tinyint(1) //Logged in or of
LoggedIn
*/
