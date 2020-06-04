CREATE PROCEDURE Shipping_Export_General_All (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ErrorID INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(100);
   DECLARE v_FS INT; 
   DECLARE v_OLEResult INT; 
   DECLARE v_FileID INT;
   DECLARE v_FileName VARCHAR(8000);
   DECLARE v_TextLine VARCHAR(8000);

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrders CURSOR  FOR
   SELECT DISTINCT
   CONCAT(IFNULL(CAST(CustomerName AS CHAR(100)),'NULL'),'^',IFNULL(CAST(CustomerAddress1 AS CHAR(400)),'NULL'),
   '^',IFNULL(CAST(CustomerAddress2 AS CHAR(400)),'NULL'),
   '^',IFNULL(CAST(CustomerCity AS CHAR(100)),'NULL'),
   '^',IFNULL(CAST(CustomerState AS CHAR(100)),'NULL'),'^',IFNULL(CAST(CustomerZip AS CHAR(100)),'NULL'),
   '^',IFNULL(CAST(CustomerCountry AS CHAR(100)),'ULL'),
   '^',IFNULL(CAST(CustomerPhone AS CHAR(100)),'NULL'),
   '^',IFNULL(CAST(CustomerFax AS CHAR(100)),'NULL'),'^',IFNULL(CAST(CustomerEmail AS CHAR(100)),'NULL'))
   FROM	OrderHeader INNER JOIN CustomerInformation ON OrderHeader.CustomerID = CustomerInformation.CustomerID 
   WHERE	OrderHeader.CompanyID = v_CompanyID AND
   OrderHeader.DivisionID = v_DivisionID AND
   OrderHeader.DepartmentID = v_DepartmentID AND
   OrderHeader.OrderNumber = v_OrderNumber AND
   OrderHeader.Shipped = 1;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET v_FileName = 'c:\enterprise\fedex.csv';


   SET v_OLEResult = sp_OACreate('Scripting.FileSystemObject',v_FS);
   IF v_OLEResult <> 0 then

      SET v_ErrorMessage = 'Fail to create FileSystemObject';
      CALL Error_InsertError('DEFAULT','DEFAULT','DEFAULT','Shipping_Export_General',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;	


   SET v_OLEResult = sp_OAMethod(v_FS,'OpenTextFile',v_FileID,v_FileName,2,1);
   IF v_OLEResult <> 0 then

      SET v_ErrorMessage = CONCAT('Fail to open file ',v_FileName);
      CALL Error_InsertError('DEFAULT','DEFAULT','DEFAULT','Shipping_Export_General',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;	

   OPEN cOrders;
   SET NO_DATA = 0;
   FETCH cOrders INTO v_TextLine;
   WHILE NO_DATA = 0 DO
	
      SET v_TextLine = REPLACE(v_TextLine,CHAR(13),'');
      SET v_TextLine = REPLACE(v_TextLine,CHAR(10),'');
	
      SET v_TextLine = REPLACE(v_TextLine,'"','""');
	
      SET v_TextLine = REPLACE(v_TextLine,'^','","');
      SET v_TextLine = CONCAT('"',v_TextLine,'"');
	
	
      SET v_OLEResult = sp_OAMethod(v_FileID,'WriteLine',Null,v_TextLine);
      IF v_OLEResult <> 0 then
	
         SET v_ErrorMessage = CONCAT('Fail to write into file ',v_FileName);
         CALL Error_InsertError('DEFAULT','DEFAULT','DEFAULT','Shipping_Export_General',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;
      end if;
      SET NO_DATA = 0;
      FETCH cOrders INTO v_TextLine;
   END WHILE;

   CLOSE cOrders;



   SET v_OLEResult = sp_OAMethod(v_FileID,'Close');
   SET v_OLEResult = sp_OADestroy(v_FileID);
   SET v_OLEResult = sp_OADestroy(v_FS);


   SET SWP_Ret_Value = 1;
END