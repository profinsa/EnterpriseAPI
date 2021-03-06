<?php
$categories["Payroll"] = [
    [
        "type" => "submenu",
        "id" => "Payroll/EmployeeManagement",
        "full" => $translation->translateLabel('Employee Management'),
        "short" => "Em",
        "data" => [

            [
				"id" => "Payroll/EmployeeManagement/ViewEmployees",
				"full" => $translation->translateLabel('View Employees'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeManagement/EmployeeSecurity",
				"full" => $translation->translateLabel('Employee Security'),
				"href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
				"short" => "Em"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Payroll/EmployeeExpenses",
        "full" => $translation->translateLabel('Employee Expenses'),
        "short" => "Em",
        "data" => [

            [
				"id" => "Payroll/EmployeeExpenses/ExpenseReports",
				"full" => $translation->translateLabel('Expense Reports'),
				"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderList",
				"short" => "Ex"
            ],
            [
				"id" => "Payroll/EmployeeExpenses/ExpenseReportsHistory",
				"full" => $translation->translateLabel('Expense Reports History'),
				"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderHistoryList",
				"short" => "Ex"
            ],
            [
				"id" => "Payroll/EmployeeExpenses/ExpenseReportItems",
				"full" => $translation->translateLabel('Expense Report Items'),
				"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportItemsList",
				"short" => "Ex"
            ],
            [
				"id" => "Payroll/EmployeeExpenses/ExpenseReportReasons",
				"full" => $translation->translateLabel('Expense Report Reasons'),
				"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportReasonsList",
				"short" => "Ex"
            ],
            [
				"id" => "Payroll/EmployeeExpenses/ExpenseReportTypes",
				"full" => $translation->translateLabel('Expense Report Types'),
				"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportTypesList",
				"short" => "Ex"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Payroll/EmployeeSetup",
        "full" => $translation->translateLabel('Employee Setup'),
        "short" => "Em",
        "data" => [

            [
				"id" => "Payroll/EmployeeSetup/ViewEmployees",
				"full" => $translation->translateLabel('View Employees'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/EmployeeTypes",
				"full" => $translation->translateLabel('Employee Types'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeTypeList",
				"short" => "Em"
            ],
            [
				"id" => "Payroll/EmployeeSetup/EmployeePayType",
				"full" => $translation->translateLabel('Employee Pay Type'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayTypeList",
				"short" => "Em"
            ],
            [
				"id" => "Payroll/EmployeeSetup/EmployeePayFrequency",
				"full" => $translation->translateLabel('Employee Pay Frequency'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayFrequencyList",
				"short" => "Em"
            ],
            [
				"id" => "Payroll/EmployeeSetup/EmployeeStatus",
				"full" => $translation->translateLabel('Employee Status'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusList",
				"short" => "Em"
            ],
            [
				"id" => "Payroll/EmployeeSetup/EmployeeDepartment",
				"full" => $translation->translateLabel('Employee Department'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeDepartmentList",
				"short" => "Em"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewTaskList",
				"full" => $translation->translateLabel('View Task List'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskHeaderList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewTaskPriorities",
				"full" => $translation->translateLabel('View Task Priorities'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskPriorityList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewTaskTypes",
				"full" => $translation->translateLabel('View Task Types'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskTypeList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/EmployeeStatusTypes",
				"full" => $translation->translateLabel('Employee Status Types'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusTypeList",
				"short" => "Em"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeeAccruals",
				"full" => $translation->translateLabel('View Employee Accruals'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewAccrualFrequencies",
				"full" => $translation->translateLabel('View Accrual Frequencies'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualFrequencyList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewAccrualTypes",
				"full" => $translation->translateLabel('View Accrual Types'),
				"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualTypesList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewPayrollEmails",
				"full" => $translation->translateLabel('View Payroll Emails'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmailMessagesList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewPayrollInstantMessages",
				"full" => $translation->translateLabel('View Payroll Instant Messages'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollInstantMessagesList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeeEmails",
				"full" => $translation->translateLabel('View Employee Emails'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeEmailMessageList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeeInstantMessages",
				"full" => $translation->translateLabel('View Employee Instant Messages'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeInstantMessageList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeesCalendar",
				"full" => $translation->translateLabel('View Employees Calendar'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCalendarList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeesCurrentlyOn",
				"full" => $translation->translateLabel('View Employees Currently On'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCurrentlyOnList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeesEvents",
				"full" => $translation->translateLabel('View Employees Events'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventsList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeesEventTypes",
				"full" => $translation->translateLabel('View Employees Event Types'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventTypesList",
				"short" => "Vi"
            ],
            [
				"id" => "Payroll/EmployeeSetup/ViewEmployeesTimesheets",
				"full" => $translation->translateLabel('View Employees Timesheets'),
				"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesTimesheetHeaderList",
				"short" => "Vi"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Payroll/PayrollProcessing",
        "full" => $translation->translateLabel('Payroll Processing'),
        "short" => "Pa",
        "data" => [

            [
				"id" => "Payroll/PayrollProcessing/PayEmployees",
				"full" => $translation->translateLabel('Pay Employees'),
				"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollPayEmployees",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollProcessing/PayrollRegister",
				"full" => $translation->translateLabel('Payroll Register'),
				"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollRegisterList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollProcessing/PayrollChecks",
				"full" => $translation->translateLabel('Payroll Checks'),
				"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollChecksList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollProcessing/PayrollCheckTypes",
				"full" => $translation->translateLabel('Payroll Check Types'),
				"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollCheckTypeList",
				"short" => "Pa"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Payroll/PayrollTaxes",
        "full" => $translation->translateLabel('Payroll Taxes'),
        "short" => "Pa",
        "data" => [

            [
				"id" => "Payroll/PayrollTaxes/PayrollItemsMaster",
				"full" => $translation->translateLabel('Payroll Items Master'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollItemsMasterList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollFedTax",
				"full" => $translation->translateLabel('Payroll Fed Tax'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollFedTaxTables",
				"full" => $translation->translateLabel('Payroll Fed Tax Tables'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxTablesList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollStateTax",
				"full" => $translation->translateLabel('Payroll State Tax'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollStateTaxTables",
				"full" => $translation->translateLabel('Payroll State Tax Tables'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxTablesList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollCountyTax",
				"full" => $translation->translateLabel('Payroll County Tax'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollCountyTaxTables",
				"full" => $translation->translateLabel('Payroll County Tax Tables'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxTablesList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollCityTax",
				"full" => $translation->translateLabel('Payroll City Tax'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollTaxes/PayrollCityTaxTables",
				"full" => $translation->translateLabel('Payroll City Tax Tables'),
				"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxTablesList",
				"short" => "Pa"
            ]
        ]
    ],
    [
        "type" => "submenu",
        "id" => "Payroll/PayrollSetup",
        "full" => $translation->translateLabel('Payroll Setup'),
        "short" => "Pa",
        "data" => [

            [
				"id" => "Payroll/PayrollSetup/PayrollSetup",
				"full" => $translation->translateLabel('Payroll Setup'),
				"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollSetupList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollSetup/PayrollItems",
				"full" => $translation->translateLabel('Payroll Items'),
				"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemsList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollSetup/PayrollItemTypes",
				"full" => $translation->translateLabel('Payroll Item Types'),
				"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemTypesList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollSetup/PayrollItemBasis",
				"full" => $translation->translateLabel('Payroll Item Basis'),
				"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemBasisList",
				"short" => "Pa"
            ],
            [
				"id" => "Payroll/PayrollSetup/W2Details",
				"full" => $translation->translateLabel('W2 Details'),
				"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW2DetailList",
				"short" => "W2"
            ],
            [
				"id" => "Payroll/PayrollSetup/W3Details",
				"full" => $translation->translateLabel('W3 Details'),
				"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW3DetailList",
				"short" => "W3"
            ]
        ]
    ]
];
?>