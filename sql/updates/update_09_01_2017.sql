/*| errorlogdetail                  
| helpproblemreportdetail         |
alter table jointpaymentsdetail add column GLControlNumber NvarChar(36) after ProjectID;
| helpsupportrequestdetail        |*/
alter table ledgertransactionsdetail add column GLControlNumber NvarChar(36) after ProjectID;
alter table bankreconciliationdetail add column GLControlNumber NvarChar(36) after BankRecMemo;
alter table contractsdetail add column GLControlNumber NvarChar(36) after DownloadCount;
alter table contracttrackingdetail add column GLControlNumber NvarChar(36) after ApprovedDate;
alter table expensereportdetail add column GLControlNumber NvarChar(36) after ProjectID;
alter table inventoryadjustmentsdetail add column GLControlNumber NvarChar(36) after ProjectID;
alter table invoicedetail add column GLControlNumber NvarChar(36) after DetailMemo5;
alter table invoicetrackingdetail add column GLControlNumber NvarChar(36) after ApprovedDate;
alter table orderdetail add column GLControlNumber NvarChar(36) after DetailMemo5;
alter table ordertrackingdetail add column GLControlNumber NvarChar(36) after ApprovedDate;
alter table paymentsdetail add column GLControlNumber NvarChar(36) after ProjectID;
alter table payrollemployeesdetail add column GLControlNumber NvarChar(36) after LastPayDate;
alter table payrollemployeestaskdetail add column GLControlNumber NvarChar(36) after TaskDetailCompleteDate;
alter table payrollemployeestimesheetdetail add column GLControlNumber NvarChar(36) after EmployeeTaskID;
alter table payrollregisterdetail add column GLControlNumber NvarChar(36) after GLEmployerCreditAccount;
alter table payrollw2detail add column GLControlNumber NvarChar(36) after Box21;
alter table payrollw3detail add column GLControlNumber NvarChar(36) after MedicareGovtEmp;
alter table projectsdetail add column GLControlNumber NvarChar(36) after ApprovedDate;
alter table purchasecontractdetail add column GLControlNumber NvarChar(36) after DetailMemo5;
alter table purchasedetail add column GLControlNumber NvarChar(36) after DetailMemo5;
alter table purchasereceiptdetail add column GLControlNumber NvarChar(36) after DetailMemo5;
alter table purchasetrackingdetail add column GLControlNumber NvarChar(36) after ApprovedDate;
alter table quotetrackingdetail add column GLControlNumber NvarChar(36) after ApprovedDate;
alter table receiptsdetail add column GLControlNumber NvarChar(36) after DetailMemo5;
alter table taxgroupdetail add column GLControlNumber NvarChar(36) after TaxOnTax;
alter table vehiclesinvoicedetail add column GLControlNumber NvarChar(36) after MemoThree;
alter table vehiclesmaintenancedetail add column GLControlNumber NvarChar(36) after MemoThree;
alter table warehousetransitdetail add column GLControlNumber NvarChar(36) after TransitDetailMemo10;
alter table workorderdetail add column GLControlNumber NvarChar(36) after ManagerSignaturePassword;

