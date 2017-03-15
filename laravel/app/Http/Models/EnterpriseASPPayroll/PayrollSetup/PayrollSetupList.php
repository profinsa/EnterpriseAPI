<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollsetup";
protected $gridFields =["FederalTaxIDNumber","StateTaxIDNumber","CountyTaxIDNumber","GLPayrollCashAccount"];
public $dashboardTitle ="PayrollSetup";
public $breadCrumbTitle ="PayrollSetup";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $editCategories = [
"Main" => [

"FederalTaxIDNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"State" => [
"inputType" => "text",
"defaultValue" => ""
],
"StateTaxIDNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"County" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyTaxIDNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityTaxIDNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"FITRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FITWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICARate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAEmployerPortion" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"FUTARate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FUTAWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"SUTARate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SUTAWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"SITRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SITWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"SDIRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SDIWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"SSIRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SSIWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreatePayroll" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayCommissions" => [
"inputType" => "text",
"defaultValue" => ""
],
"OTAfter" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFITPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFITExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFUTAPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFUTAExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSUTAPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSUTAExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSITPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSITExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSDIPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSDIExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAMedPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFICAMedExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPayrollCashAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLLocalPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSalesPayrollExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLOfficePayrollExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLWarehousePayrollExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLProductionPayrollExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLOvertimePayrollExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLWagesPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPayrollTaxExpenseAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBonusPayrollAccount" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"FederalTaxIDNumber" => "Federal Tax ID Number",
"StateTaxIDNumber" => "State Tax ID Number",
"CountyTaxIDNumber" => "County Tax ID Number",
"GLPayrollCashAccount" => "GL Payroll Cash Account",
"State" => "State",
"County" => "County",
"CityName" => "CityName",
"CityTaxIDNumber" => "CityTaxIDNumber",
"FITRate" => "FITRate",
"FITWageBase" => "FITWageBase",
"FICARate" => "FICARate",
"FICAEmployerPortion" => "FICAEmployerPortion",
"FICAWageBase" => "FICAWageBase",
"FUTARate" => "FUTARate",
"FUTAWageBase" => "FUTAWageBase",
"SUTARate" => "SUTARate",
"SUTAWageBase" => "SUTAWageBase",
"SITRate" => "SITRate",
"SITWageBase" => "SITWageBase",
"SDIRate" => "SDIRate",
"SDIWageBase" => "SDIWageBase",
"SSIRate" => "SSIRate",
"SSIWageBase" => "SSIWageBase",
"FICAMedRate" => "FICAMedRate",
"FICAMedWageBase" => "FICAMedWageBase",
"CreatePayroll" => "CreatePayroll",
"PayCommissions" => "PayCommissions",
"OTAfter" => "OTAfter",
"GLFITPayrollAccount" => "GLFITPayrollAccount",
"GLFITExpenseAccount" => "GLFITExpenseAccount",
"GLFICAPayrollAccount" => "GLFICAPayrollAccount",
"GLFICAExpenseAccount" => "GLFICAExpenseAccount",
"GLFUTAPayrollAccount" => "GLFUTAPayrollAccount",
"GLFUTAExpenseAccount" => "GLFUTAExpenseAccount",
"GLSUTAPayrollAccount" => "GLSUTAPayrollAccount",
"GLSUTAExpenseAccount" => "GLSUTAExpenseAccount",
"GLSITPayrollAccount" => "GLSITPayrollAccount",
"GLSITExpenseAccount" => "GLSITExpenseAccount",
"GLSDIPayrollAccount" => "GLSDIPayrollAccount",
"GLSDIExpenseAccount" => "GLSDIExpenseAccount",
"GLFICAMedPayrollAccount" => "GLFICAMedPayrollAccount",
"GLFICAMedExpenseAccount" => "GLFICAMedExpenseAccount",
"GLLocalPayrollAccount" => "GLLocalPayrollAccount",
"GLSalesPayrollExpenseAccount" => "GLSalesPayrollExpenseAccount",
"GLOfficePayrollExpenseAccount" => "GLOfficePayrollExpenseAccount",
"GLWarehousePayrollExpenseAccount" => "GLWarehousePayrollExpenseAccount",
"GLProductionPayrollExpenseAccount" => "GLProductionPayrollExpenseAccount",
"GLOvertimePayrollExpenseAccount" => "GLOvertimePayrollExpenseAccount",
"GLWagesPayrollAccount" => "GLWagesPayrollAccount",
"GLPayrollTaxExpenseAccount" => "GLPayrollTaxExpenseAccount",
"GLBonusPayrollAccount" => "GLBonusPayrollAccount"];
}?>
