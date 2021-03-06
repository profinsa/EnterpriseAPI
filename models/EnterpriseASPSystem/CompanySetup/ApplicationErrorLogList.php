<?php
require "./models/gridDataSource.php";
class ApplicationErrorLogList extends gridDataSource{
    public $tableName = "errorlog";
    public $dashboardTitle ="Application Error Log";
    public $breadCrumbTitle ="Application Error Log";
    public $idField ="ErrorID";
    public $idFields = ["timestamp"];
    public $modes = ["grid", "view"];
    public $withoutSql = true;
    public $gridFields = [
        "timestamp" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ],
        /*        "query" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
            ],*/
        "file" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ],
        "message" => [
            "dbType" => "varchar(255)",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "timestamp" => [
                "dbType" => "varchar(255)",
                "inputType" => "text"
            ],
            "query" => [
                "dbType" => "varchar(255)",
                "inputType" => "text"
            ],
            "file" => [
                "dbType" => "varchar(255)",
                "inputType" => "text"
            ],
            "message" => [
                "dbType" => "varchar(255)",
                "inputType" => "text"
            ],
            "code" => [
                "dbType" => "varchar(255)",
                "inputType" => "text"
            ],
            "line" => [
                "dbType" => "varchar(255)",
                "inputType" => "text"
            ]
        ]
    ];
    
    public $columnNames = [
        "timestamp" => "Timestamp",
        "query" => "Query",
        "file" => "File",
        "message" => "Message",
        "code" => "Code",
        "line" => "Line"
    ];
    
    //getting rows for grid
    public function getPage($number){
        $errors = "[" . file_get_contents("error.log");
        $errors = substr($errors, 0, -2) . "]";
        $result = json_decode($errors, true);
        
        return $result;
    }

    public function getEditItem($id, $type){
        $errors = "[" . file_get_contents("error.log");
        $errors = substr($errors, 0, -2) . "]";
        $result = json_decode($errors, true);
        $id = urldecode($id);

        foreach($result as $value)
            if($value["timestamp"] == $id)
                return $value;
    }
}
?>
