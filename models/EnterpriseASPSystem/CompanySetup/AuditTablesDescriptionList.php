<?php
/*
  Name of Page: AuditTablesDescriptionList model
   
  Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTablesDescriptionList.php It provides data from database and default values, column names and categories
   
  Date created: 02/16/2017  Kenna Fetterman
   
  Use: this model used by views/AuditTablesDescriptionList for:
  - as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
  - for loading data from tables, updating, inserting and deleting
   
  Input parameters:
  $db: database instance
  methods have their own parameters
   
  Output parameters:
  - dictionaries as public properties
  - methods have their own output
   
  Called from:
  created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTablesDescriptionList.php
  used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPSystem\CompanySetup\AuditTablesDescriptionList.php
   
  Calls:
  MySql Database
   
  Last Modified: 21/11/2018
  Last Modified by: Nikita Zaharov
*/

require "./models/gridDataSource.php";
class AuditTablesDescriptionList extends gridDataSource{
    public $tableName = "audittablesdescription";
    public $dashboardTitle ="Audit Description";
    public $breadCrumbTitle ="Audit Description";
    public $idField ="undefined";
    public $idFields = ["TableName"];
    public $features = ["selecting"];
    public $gridFields = [
        "TableName" => [
            "dbType" => "varchar(128)",
            "inputType" => "text"
        ],
        "DocumentType" => [
            "dbType" => "varchar(128)",
            "inputType" => "text"
        ],
        "TransactionNumberField" => [
            "dbType" => "varchar(128)",
            "inputType" => "text"
        ],
        "TransactionLineNumberField" => [
            "dbType" => "varchar(128)",
            "inputType" => "text"
        ],
        "ComplexObject" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ],
        "ApplyAudit" => [
            "dbType" => "tinyint(1)",
            "inputType" => "checkbox",
            "defaultValue" => "0"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "TableName" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "DocumentType" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionNumberField" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "TransactionLineNumberField" => [
                "dbType" => "varchar(128)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "ComplexObject" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ],
            "ApplyAudit" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "defaultValue" => "0"
            ]
        ]
    ];
    
    public $columnNames = [
        "TableName" => "Table Name",
        "DocumentType" => "Document Type",
        "TransactionNumberField" => "Transaction Number Field",
        "TransactionLineNumberField" => "Transaction Line Number Field",
        "ComplexObject" => "Complex Object",
        "ApplyAudit" => "Apply Audit"
    ];

    function regenerateTriggers($TableName, $DocumentType, $TransactionNumberField, $TransactionLineNumberField, $ComplexObject){
        $tables = DB::select("show tables");
        $tableFound = false;
        $Tables_in_database = "Tables_in_" . DB::getDatabaseName();
        foreach($tables as $row)
            if(strtolower($row->$Tables_in_database) == strtolower($TableName))
                $tableFound = true;

        $forbiddenTables = [
            "HelpMessageTopic" => true,
            "HelpMessageHeading" => true
        ];
        if(!$tableFound || key_exists($TableName, $forbiddenTables)){
            echo "||wrong tables $TableName||";
            return;
        }
        
        $columns = DB::select("describe $TableName");
        $keys = 0;
        foreach($columns as $column)
            if($column->Field == "CompanyID" || $column->Field == "DivisionID" || $column->Field == "DepartmentID")
                $keys++;
        if($keys < 3)
            echo "||wrong tables $TableName||";

        $pdo = DB::connection()->getPdo();

        //GENERATE INSERT TRIGGER
        $pdo->exec("DROP TRIGGER IF EXISTS `{$TableName}_Audit_Insert`;");
        $trigger = "CREATE TRIGGER `{$TableName}_Audit_Insert` AFTER INSERT ON `" . strtolower($TableName) . "` FOR EACH ROW SWL_return: \nBEGIN\n DECLARE EXIT HANDLER FOR SQLEXCEPTION RESIGNAL; \n DECLARE EXIT HANDLER FOR SQLWARNING RESIGNAL; \n DECLARE EXIT HANDLER FOR NOT FOUND RESIGNAL; \n";

        $trigger .= "\n CALL AuditInsert(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, " . $pdo->quote($DocumentType) . ", " . ( $TransactionNumberField != "" ? "NEW.$TransactionNumberField" : "NULL") . ", " . ( $TransactionLineNumberField != "" ? "NEW.$TransactionLineNumberField" : "NULL") . ", " . $pdo->quote($TableName) . ", " . ( $TransactionNumberField != "" ? "NEW.$TransactionNumberField" : "NULL") . ", '', " . ( $TransactionNumberField != "" ? "CAST(NEW.$TransactionNumberField AS NCHAR(250))" : "NULL") . ");\n";
        
        $trigger .= "END;";

        echo $trigger;
        try{
            $pdo->exec($trigger);
        }catch(PDOException $e){
            echo $e->getMessage();
        }
        
        //GENERATE UPDATE TRIGGER
        $pdo->exec("DROP TRIGGER IF EXISTS `{$TableName}_Audit_Update`;");
        $trigger = "CREATE TRIGGER `{$TableName}_Audit_Update` AFTER UPDATE ON `" . strtolower($TableName) . "` FOR EACH ROW SWL_return: \nBEGIN\n DECLARE EXIT HANDLER FOR SQLEXCEPTION RESIGNAL; \n DECLARE EXIT HANDLER FOR SQLWARNING RESIGNAL; \n DECLARE EXIT HANDLER FOR NOT FOUND RESIGNAL; \n";
        foreach($columns as $column)
            $trigger .= "\n CALL AuditInsert(NEW.CompanyID, NEW.DivisionID, NEW.DepartmentID, " . $pdo->quote($DocumentType) . ", " . ( $TransactionNumberField != "" ? "NEW.$TransactionNumberField" : "NULL") . ", " . ( $TransactionLineNumberField != "" ? "NEW.$TransactionLineNumberField" : "NULL") . ", " . $pdo->quote($TableName) . ", " . $pdo->quote($column->Field) . ", CAST(OLD.{$column->Field} AS NCHAR(250)), CAST(NEW.{$column->Field} AS NCHAR(250)));\n";
        $trigger .= "END;";

        echo $trigger;
        try{
            $pdo->exec($trigger);
        }catch(PDOException $e){
            echo $e->getMessage();
        }
        
        //GENERATE DELETE TRIGGER
        $pdo->exec("DROP TRIGGER IF EXISTS `{$TableName}_Audit_Delete`;");
        $trigger = "CREATE TRIGGER `{$TableName}_Audit_Delete` AFTER DELETE ON `" . strtolower($TableName) . "` FOR EACH ROW SWL_return: \nBEGIN\n DECLARE EXIT HANDLER FOR SQLEXCEPTION RESIGNAL; \n DECLARE EXIT HANDLER FOR SQLWARNING RESIGNAL; \n DECLARE EXIT HANDLER FOR NOT FOUND RESIGNAL; \n";
        $trigger .= "\n CALL AuditInsert(OLD.CompanyID, OLD.DivisionID, OLD.DepartmentID, " . $pdo->quote($DocumentType) . ", " . ( $TransactionNumberField != "" ? "OLD.$TransactionNumberField" : "NULL") . ", " . ( $TransactionLineNumberField != "" ? "OLD.$TransactionLineNumberField" : "NULL") . ", " . $pdo->quote($TableName) . ", 'Deleted', '', 'Deleted');\n";
        $trigger .= "END;";

        echo $trigger;
        try{
            $pdo->exec($trigger);
        }catch(PDOException $e){
            echo $e->getMessage();
        }
    }
    
    public function RegenerateSelectedTriggers(){
        $user = Session::get("user");

        $names = explode(",", $_POST["TableNames"]);
        $success = true;
        $data = $this->getPage(1);
        $tables = [];
        foreach($names as $name)
            foreach($data as $row)
                if($row["TableName"] == $name)
                    $tables[] = $row;
        
        foreach($tables as $table)
            $this->regenerateTriggers($table["TableName"], $table["DocumentType"], $table["TransactionNumberField"], $table["TransactionLineNumberField"], $table["ComplexObject"]);
    }
    
    public function RegenerateAllTriggers(){
        $user = Session::get("user");

        $tables = $this->getPage(1);
        foreach($tables as $table)
            $this->regenerateTriggers($table["TableName"], $table["DocumentType"], $table["TransactionNumberField"], $table["TransactionLineNumberField"], $table["ComplexObject"]);
    } 
}
?>
