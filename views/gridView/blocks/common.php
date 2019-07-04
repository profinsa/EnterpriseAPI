<?php
function renderGridValue($linksMaker, $ascope, $data, $gridFields, $drill, $row, $key, $value){
	switch($gridFields[$key]["inputType"]){
    case "checkbox" :
		return $value ? "True" : "False";
		break;
    case "timestamp" :
    case "datetime" :
		return date("m/d/y", strtotime($value));
		break;
    case "text":
		$outValue = "";
		if(key_exists("formatFunction", $gridFields[$key])){
		    $formatFunction = $gridFields[$key]["formatFunction"];
		    $outValue = $data->$formatFunction($row, "gridFields", $key, $value, false);
		}
		else
		    $outValue = formatField($gridFields[$key], $value);
		switch($key){
        case "QtyOnOrder" :
			return $drill->getLinkWarehouseForPurchases($linksMaker, $row["ItemID"], $outValue);
        case "QtyCommitted" :
			return $drill->getLinkWarehouseForOrders($linksMaker, $row["ItemID"], $outValue);
        default :
			return $outValue;
		}
		break;
    case "dateTimeFull" :
		return $value;
		break;
    case "dropdown":
		switch($key){
        case "CustomerID" :
			return $drill->getLinkByField($key,$value);
			break;
        case "VendorID" :
			return $drill->getLinkByField($key,$value);
			break;
        case "OrderNumber" :
			return $drill->getReportLinkByOrderNumber($value, $ascope["pathPage"]);
			break;
        case "InvoiceNumber" :
			return $drill->getReportLinkByInvoiceNumber($value, $ascope["pathPage"]);
			break;
        default:
			if(key_exists("formatFunction", $gridFields[$key])){
			    $formatFunction = $gridFields[$key]["formatFunction"];
			    return $data->$formatFunction($row, "gridFields", $key, $value, false);
			}
			else
			    return formatField($gridFields[$key], $value);
			break;
		}
	}
}

function renderInput($ascope, $data, $gridFields, $item, $key, $value, $keyString, $current_row){
	$renderedString = "";
	switch($gridFields[$key]["inputType"]){
    case "text" :
		//renders text input with label
		$renderedString = "<input style=\"display:inline\" type=\"text\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" onchange=\"gridChangeItem(this, '$key', '$current_row');\" class=\"form-control\" value=\"";
		if(key_exists("formatFunction", $gridFields[$key])){
		    $formatFunction = $gridFields[$key]["formatFunction"];
		    $renderedString .=  $data->$formatFunction($item, "editCategories", $key, $value, false);
		}
		else
		    $renderedString .=  formatField($gridFields[$key], $value);

		$renderedString .=  "\" " . ( (key_exists("disabledEdit", $gridFields[$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view"))  || (key_exists("disabledNew", $gridFields[$key]) && $ascope["mode"] == "new") ? "readonly" : "")
                        .">";
		break;

    case "datetime" :
		//renders text input with label
		$renderedString .=  "<input type=\"text\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" onchange=\"gridChangeItem(this, '$key', '$current_row');\" class=\"form-control fdatetime\" value=\"" . ($value == 'now' || $value == "0000-00-00 00:00:00" || $value == "CURRENT_TIMESTAMP"? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
                        ( (key_exists("disabledEdit", $gridFields[$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view"))  || (key_exists("disabledNew", $gridFields[$key]) && $ascope["mode"] == "new") ? "readonly" : "")
                        .">";
		break;

    case "checkbox" :
		//renders checkbox input with label
		$renderedString .=   "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
		$renderedString .=   "<input class=\"grid-checkbox\" type=\"checkbox\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" onchange=\"gridChangeItem(this, '$key', '$current_row');\" class=\"form-control\" value=\"1\" " . ($value ? "checked" : "") ." " .
                        ( (key_exists("disabledEdit", $gridFields[$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view")) || (key_exists("disabledNew", $gridFields[$key]) && $ascope["mode"] == "new") ? "disabled" : "")
                        .">";
		break;

    case "dialogChooser":
		$dataProvider = $gridFields[$key]["dataProvider"];
		if(!key_exists($dataProvider, $GLOBALS["dialogChooserTypes"]))
		    $GLOBALS["dialogChooserTypes"][$dataProvider] = "hophop";
		$GLOBALS["dialogChooserInputs"][$key] = $dataProvider;
		$renderedString .=  "<input type=\"text\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"$value\" onchange=\"gridChangeItem(this, '$key', '$current_row');\">";
		break;

    case "dropdown" :
		//renders select with available values as dropdowns with label
		$renderedString .=  "<select class=\"form-control subgrid-input\" name=\"" . $key . "\" id=\"{$keyString}___" . $key . "\" onchange=\"gridChangeItem(this, '$key', '$current_row');\">";
		$method = $gridFields[$key]["dataProvider"];
		if(key_exists("dataProviderArgs", $gridFields[$key])){
		    $args = [];
		    foreach($gridFields[$key]["dataProviderArgs"] as $argname)
                $args[$argname] = $item[$argname];
		    $types = $data->$method($args);
		}
		else
		    $types = $data->$method();
		if($value)
		    $renderedString .= "<option value=\"" . $value . "\">" . (key_exists($value, $types) ? $types[$value]["title"] : $value) . "</option>";
		else
		    $renderedString .= "<option></option>";

		foreach($types as $type)
            if(!$value || $type["value"] != $value)
                $renderedString .=  "<option value=\"" . $type["value"] . "\">" . $type["title"] . "</option>";
		echo"</select>";
		break;
	}
	return $renderedString;
}

?>