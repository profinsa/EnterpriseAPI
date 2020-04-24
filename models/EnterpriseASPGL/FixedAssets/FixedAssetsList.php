<?php
require "./models/gridDataSource.php";

class FixedAssetsList extends gridDataSource{
    public $tableName = "fixedassets";
    public $dashboardTitle ="Fixed Assets";
    public $breadCrumbTitle ="Fixed Assets";
    public $idField ="AssetID";
    public $idFields = ["CompanyID","DivisionID","DepartmentID","AssetID"];
    public $gridFields = [
        "AssetID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AssetName" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "AssetTypeID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AssetStatusID" => [
            "dbType" => "varchar(36)",
            "inputType" => "text"
        ],
        "AssetDescription" => [
            "dbType" => "varchar(50)",
            "inputType" => "text"
        ],
        "AssetBookValue" => [
            "dbType" => "decimal(19,4)",
            "addFields" => "CurrencyID",
            "currencyField" => "CurrencyID",
            "formatFunction" => "currencyFormat",
            "inputType" => "text"
        ]
    ];

    public $editCategories = [
        "Main" => [
            "AssetID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "disableEdit" => true,
                "defaultValue" => ""
            ],
            "AssetName" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetSerialNumber" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetTypeID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "defaultValue" => "",
                "dataProvider" => "getFixedAssetTypes"
            ],
            "AssetStatusID" => [
                "dbType" => "varchar(36)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "VendorID" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetDescription" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetLocation" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetUsedBy" => [
                "dbType" => "varchar(50)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetDepreciationMethodID" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getFixedAssetDepreciationMethods",
                "defaultValue" => ""
            ],
            "DepreciationPeriod" => [
                "dbType" => "varchar(1)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetInServiceDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "CurrencyID" => [
                "dbType" => "varchar(3)",
                "inputType" => "dropdown",
                "dataProvider" => "getCurrencyTypes",
                "defaultValue" => "USD"
            ],
            "CurrencyExchangeRate" => [
                "dbType" => "float",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetOriginalCost" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetUsefulLife" => [
                "dbType" => "smallint(6)",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetSalvageValue" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetSalesPrice" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetPlanedDisposalDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "AssetAcutalDisposalDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "AssetActualDisposalAmount" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "LastDepreciationDate" => [
                "dbType" => "datetime",
                "inputType" => "datetime",
                "defaultValue" => "now"
            ],
            "LastDepreciationAmount" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AccumulatedDepreciation" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "AssetBookValue" => [
                "dbType" => "decimal(19,4)",
                "currencyField" => "CurrencyID",
                "formatFunction" => "currencyFormat",
                "inputType" => "text",
                "defaultValue" => ""
            ],
            "GLFixedAssetAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "GLFixedAccumDepreciationAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "GLFixedDisposalAccount" => [
                "dbType" => "varchar(36)",
                "inputType" => "dropdown",
                "dataProvider" => "getAccounts",
                "defaultValue" => ""
            ],
            "Approved" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "disabledEdit" => true
            ],
            "Posted" => [
                "dbType" => "tinyint(1)",
                "inputType" => "checkbox",
                "disabledEdit" => true
            ]
        ]
    ];
    public $columnNames = [
        "AssetID" => "Asset ID",
        "AssetName" => "Asset Name",
        "AssetTypeID" => "Asset Type ID",
        "AssetStatusID" => "Asset Status ID",
        "AssetDescription" => "Description",
        "AssetBookValue" => "Book Value",
        "AssetSerialNumber" => "AssetSerialNumber",
        "VendorID" => "Vendor ID",
        "AssetLocation" => "Asset Location",
        "AssetUsedBy" => "Asset Used By",
        "AssetDepreciationMethodID" => "Asset Depreciation Method ID",
        "DepreciationPeriod" => "Depreciation Period",
        "AssetInServiceDate" => "Asset In Service Date",
        "CurrencyID" => "Currency ID",
        "CurrencyExchangeRate" => "Currency Exchange Rate",
        "AssetOriginalCost" => "Asset Original Cost",
        "AssetUsefulLife" => "Asset Useful Life",
        "AssetSalvageValue" => "Asset Salvage Value",
        "AssetSalesPrice" => "Asset Sales Price",
        "AssetPlanedDisposalDate" => "Asset Planed Disposal Date",
        "AssetAcutalDisposalDate" => "Asset Acutal Disposal Date",
        "AssetActualDisposalAmount" => "Asset Actual Disposal Amount",
        "LastDepreciationDate" => "Last Depreciation Date",
        "LastDepreciationAmount" => "Last Depreciation Amount",
        "AccumulatedDepreciation" => "Accumulated Depreciation",
        "GLFixedAssetAccount" => "GL Fixed AssetAccount",
        "GLFixedAccumDepreciationAccount" => "GL Fixed Accum Depreciation Account",
        "GLFixedDisposalAccount" => "GLFixed Disposal Account",
        "Approved" => "Approved",
        "ApprovedBy" => "ApprovedBy",
        "ApprovedDate" => "ApprovedDate",
        "EnteredBy" => "EnteredBy",
        "Posted" => "Posted"
    ];

    //getting list of available fixed asset types 
    public function getFixedAssetTypes(){
        $user = $_SESSION["user"];
        $res = [];
        $result = DB::select("SELECT AssetTypeID,AssetTypeDescription from fixedassettype WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->AssetTypeID] = [
                "title" => $value->AssetTypeID,
                "value" => $value->AssetTypeID
            ];
        
        return $res;
    }
    //getting list of available fixed asset depreciation methos 
    public function getFixedAssetDepreciationMethods(){
        $user = $_SESSION["user"];
        $res = [];
        $result = DB::select("SELECT AssetDepreciationMethodID,DepreciationMethodDescription from fixedassetdepreciationmethods WHERE CompanyID='" . $user["CompanyID"] . "' AND DivisionID='". $user["DivisionID"] ."' AND DepartmentID='" . $user["DepartmentID"] . "'", array());

        foreach($result as $key=>$value)
            $res[$value->AssetDepreciationMethodID] = [
                "title" => $value->AssetDepreciationMethodID,
                "value" => $value->AssetDepreciationMethodID
            ];
        
        return $res;
    }

    public function DisposalPost(){
        $user = $_SESSION["user"];

        DB::statement("CALL FixedAssetDisposal_Post('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["AssetID"] . "', @v_PostAsset, @SWP_RET_VALUE)");

        $result = DB::select('select @v_PostAsset as v_PostAsset ,@SWP_RET_VALUE as SWP_RET_VALUE');

        if($result[0]->SWP_RET_VALUE > -1)
            echo "ok";
        else {
            http_response_code(400);
            echo $result[0]->v_PostAsset;
        }
    }
    
    public function DepreciationPost(){
        $user = $_SESSION["user"];

        DB::statement("CALL FixedAssetDepreciation_Post('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["AssetID"] . "', @v_PostAsset, @SWP_RET_VALUE)");

        $result = DB::select('select @v_PostAsset as v_PostAsset ,@SWP_RET_VALUE as SWP_RET_VALUE');

        if($result[0]->SWP_RET_VALUE > -1 && $result[0]->SWP_RET_VALUE != null)
            echo "ok";
        else {
            http_response_code(400);
            echo $result[0]->v_PostAsset;
        }
    }
    
    public function Depreciation_PostAll(){
        $user = $_SESSION["user"];

        DB::statement("CALL FixedAssetDepreciation_PostAll('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "',@v_Result, @SWP_RET_VALUE)");

        $result = DB::select('select @v_Result as v_Result ,@SWP_RET_VALUE as SWP_RET_VALUE');
        
        if($result[0]->SWP_RET_VALUE > -1)
            echo "ok";
        else {
            http_response_code(400);
            echo $result[0]->v_Result;
        }
    }

    public function FixedAsset_Post(){
        $user = $_SESSION["user"];

        DB::statement("CALL FixedAsset_Post('" . $user["CompanyID"] . "','" . $user["DivisionID"] . "','" . $user["DepartmentID"] . "','" . $_POST["AssetID"] . "', @v_PostAsset, @SWP_RET_VALUE)");

        $result = DB::select('select @v_PostAsset as v_PostAsset ,@SWP_RET_VALUE as SWP_RET_VALUE');
        if($result[0]->SWP_RET_VALUE > -1)
            echo "ok";
        else {
            http_response_code(400);
            echo $result[0]->v_PostAsset;
        }
    }
}
?>
