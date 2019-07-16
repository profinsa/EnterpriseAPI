CREATE PROCEDURE RptListEDISetup (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   EDIActive,
	EDIQualifier,
	EDIID, 
	
	
	EDIInboundOrders,
	EDIOutboundOrders,
	EDIInboundInvoices,
	EDIOutboundInvoices,
	EDIInboundASN,
	EDIOutboundASN,
	EDIInboundUPC,
	EDIOutboundUPC,
	EDIInboundFinancial,
	EDIOutboundFinancial,
	EDIInboundOrderStatus,
	EDIOutboundOrderStatus,
	EDIInboundInventory,
	EDIOutboundInventory
   FROM EDISetup
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END