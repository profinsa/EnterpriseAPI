update databaseinfo set value='2019_04_03',lastupdate=now() WHERE id='Version';
-- WEBSITE
alter table inventorycart ADD COLUMN AboutUsPage tinyint(1) after GiftsOrCoupons;
alter table inventorycart ADD COLUMN AboutUsPageContent MEDIUMTEXT after AboutUsPage;
alter table inventorycart ADD COLUMN CustomerService tinyint(1) after AboutUsPageContent;
alter table inventorycart ADD COLUMN CustomerServiceContent MEDIUMTEXT after CustomerService;
alter table inventorycart ADD COLUMN PrivacyPolicy tinyint(1) after CustomerServiceContent;
alter table inventorycart ADD COLUMN PrivacyPolicyContent MEDIUMTEXT after PrivacyPolicy;
alter table inventorycart ADD COLUMN SiteMap tinyint(1) after PrivacyPolicyContent;
alter table inventorycart ADD COLUMN SiteMapContent MEDIUMTEXT after SiteMap;
alter table inventorycart ADD COLUMN Contact tinyint(1) after SiteMapContent;
alter table inventorycart ADD COLUMN ContactContent MEDIUMTEXT after Contact;
alter table inventorycart ADD COLUMN ShippingReturns tinyint(1) after ContactContent;
alter table inventorycart ADD COLUMN ShippingReturnsContent MEDIUMTEXT after ShippingReturns;
alter table inventorycart ADD COLUMN SecureShopping tinyint(1) after ShippingReturnsContent;
alter table inventorycart ADD COLUMN SecureShoppingContent MEDIUMTEXT after SecureShopping;
alter table inventorycart ADD COLUMN InternationalShipping tinyint(1) after SecureShoppingContent;
alter table inventorycart ADD COLUMN InternationalShippingContent MEDIUMTEXT after InternationalShipping;
alter table inventorycart ADD COLUMN Affiliates tinyint(1) after InternationalShippingContent;
alter table inventorycart ADD COLUMN AffiliatesContent MEDIUMTEXT after Affiliates;
alter table inventorycart ADD COLUMN Help tinyint(1) after AffiliatesContent;
alter table inventorycart ADD COLUMN HelpContent MEDIUMTEXT after Help;
alter table inventorycart ADD COLUMN Support tinyint(1) after HelpContent;
alter table inventorycart ADD COLUMN SupportContent MEDIUMTEXT after Support;

-- NEWSLETTERSIGNUP
alter table inventorycart ADD COLUMN ShowNewsletter tinyint(1) after SupportContent;

-- SOCIALS
alter table inventorycart ADD COLUMN Facebook tinyint(1) after ShowNewsletter;
alter table inventorycart ADD COLUMN FacebookUrl NVarChar(128) after Facebook;
alter table inventorycart ADD COLUMN Twitter tinyint(1) after FacebookUrl;
alter table inventorycart ADD COLUMN TwitterUrl NVarChar(128) after Twitter;
alter table inventorycart ADD COLUMN LinkedIn tinyint(1) after TwitterUrl;
alter table inventorycart ADD COLUMN LinkedInUrl NVarChar(128) after LinkedIn;
alter table inventorycart ADD COLUMN GooglePlus tinyint(1) after LinkedInUrl;
alter table inventorycart ADD COLUMN GooglePlusUrl NVarChar(128) after GooglePlus;
alter table inventorycart ADD COLUMN Instagram tinyint(1) after GooglePlusUrl;
alter table inventorycart ADD COLUMN InstagramUrl NVarChar(128) after Instagram;
alter table inventorycart ADD COLUMN YouTube tinyint(1) after InstagramUrl;
alter table inventorycart ADD COLUMN YouTubeUrl NVarChar(128) after Youtube;
-- PAYMENT METHODS
alter table inventorycart ADD COLUMN Visa tinyint(1) after YouTubeUrl;
alter table inventorycart ADD COLUMN Master tinyint(1) after Visa;
alter table inventorycart ADD COLUMN Discover tinyint(1) after Master;
alter table inventorycart ADD COLUMN Amex tinyint(1) after Discover;
alter table inventorycart ADD COLUMN PayPal tinyint(1) after Amex;
alter table inventorycart ADD COLUMN Square tinyint(1) after PayPal;

update inventorycart set AboutUsPage=1, AboutUsPageContent='<b>Test</b>', CustomerService=1, CustomerServiceContent='<b>Test</b>', PrivacyPolicy=1, PrivacyPolicyContent='<b>Test</b>', SiteMap=1, SiteMapContent='<b>Test</b>', Contact=1, ContactContent='<b>Test</b>', ShippingReturns=1, ShippingReturnsContent='<b>Test</b>', SecureShopping=1, SecureShoppingContent='<b>Test</b>', InternationalShipping=1, InternationalShippingContent='<b>Test</b>', Affiliates=1, AffiliatesContent='<b>Test</b>', Help=1, HelpContent='<b>Test</b>', Support=1, SupportContent='<b>Test</b>', ShowNewsletter=1, Facebook=1, FacebookUrl='#facebook', Twitter=1, TwitterUrl='#twitter', LinkedIn=1, LinkedInUrl='#linkedin', GooglePlus=1, GooglePlusUrl='#google', Instagram=1, InstagramUrl='#instagram', YouTube=1, YouTubeUrl='#youtube', Visa=1, Master=1, Discover=1, Amex=1, PayPal=1, Square=1;

