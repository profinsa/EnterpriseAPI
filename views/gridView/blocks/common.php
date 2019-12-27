<?php
    function myurlencode($keystring) {
        return str_replace("%2F", "+++", urlencode($keystring));
    }
    
    function renderGridValue($linksMaker, $ascope, $data, $gridFields, $drill, $row, $key, $value){
        switch($gridFields[$key]["inputType"]){
            case "checkbox" :
                return $value ? "True" : "False";
                break;
            case "timestamp" :
            case "datetime" :
                return date("m/d/y", strtotime($value));
                break;
            case "dialogChooser":
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
		    case "TransactionNumber" :
			if(key_exists("TransactionType", $row))
			    return $drill->getViewLinkByTransactionNumberAndType($value, $row["TransactionType"]);
			else
			    return $value;
			break;
		    case "CVID" :
			if(key_exists("TransactionType", $row))
			    return $drill->getLinkByCVID($row["TransactionType"], $value);
			else
			    return $value;
			break;
                    default :
                        return (key_exists("currencySymbol", $gridFields[$key])) ? $data->getCurrencySymbol()["symbol"] . $outValue : $outValue;
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
                    default:
                        if(key_exists("dataProvider",$gridFields[$key])){ 
                            $method = $gridFields[$key]["dataProvider"];
                            $types = $data->$method();

                            if($value && key_exists($value, $types))
                                return $types[$value]["title"];
                        }else
                        return $value;
                        /*if(key_exists("formatFunction", $gridFields[$key])){
                           $formatFunction = $gridFields[$key]["formatFunction"];
                           return $data->$formatFunction($row, "gridFields", $key, $value, false);
                           }
                           else
                           return formatField($gridFields[$key], $value);*/
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
                $renderedString .=  "<input type=\"text\" id=\"{$keyString}___". $key ."\" name=\"" .  $key. "\" class=\"form-control\" value=\"$value\" onchange=\"gridChangeItem(this, '$key', '$current_row');\" " . ( (key_exists("disabledEdit", $gridFields[$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view")) || (key_exists("disabledNew", $gridFields[$key]) && $ascope["mode"] == "new") ? "disabled" : "") . ">";
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
                $renderedString .= "</select>";
                break;
        }
        return $renderedString;
    }

    function renderGridRow($ascope, $security, $PartsPath, $linksMaker, $drill, $data, $keyString, $row){
        $_html = "";
	$_html .= "<tr>";
	//disabling or enabling selecting feature in grid(used by grid actions, for example in General Ledger-> Ledger -> Transactions Closed for selecting transactions and click on Copy Selected to History)
	//this feature enabled in data model, if model has features propery
	if(property_exists($data, "features") && in_array("selecting", $data->features))
	    $_html .= "<td><input type=\"checkbox\" onchange=\"gridSelectItem(event, '" . $current_row . "')\"></td>";
	/*
	   this column contains row actions like edit, remove, print etc.
	   Each action may be any html code. For now usually we have two type actions:
	   - action link
	   just link, no javascript login. Example - edit action is just link to edit page. Link contains $keyString for accurate pointing to edited item
	   - javascript action
	   some code react on click and does job. Example - delete button. In end of this file we have
	   ngridDeleteItem function which called on click and just does XHR delete request and reload
	   page content after receiving result
	 */
	if(!property_exists($data, "modes") || count($data->modes) != 1 || !in_array("grid", $data->modes) || file_exists(__DIR__ . "/../" . $PartsPath . "gridRowActions.php")){
	    $_html .= "<td>";
	    //edit action, just link on edit page. Showed if user has select permission
	    if($security->can("select") && (!property_exists($data, "modes") || in_array("view", $data->modes)))
		$_html .= "<a href=\"" . (property_exists($data, "onlyEdit") ? $linksMaker->makeGridItemEdit($ascope["path"], urlencode($keyString)) : $linksMaker->makeGridItemView($ascope["path"], urlencode($keyString))) ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
	    /*delete action, call javascript function with keyString as parameter then function call XHR
	       delete request on server
	       It is showed only if not disabled by modes property of data model and user has delete permission
	     */
	    if(!property_exists($data, "modes") || in_array("delete", $data->modes)){
		if($security->can("delete"))
		    $_html .= "<span onclick=\"gridDeleteItem('" . myurlencode($keyString) . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
	    }

	    /*
	       Each grid page(each screen) can have own row actions.
	       Like actions above it is just a html. It can have javascript or not
	       $PartsPath is path part what depends of current screen on which the user is located
	       For example, we want to add some actions to Account Receivable -> Order Processing -> View Orders
	       then we need create file gridRowActions on that path: resources/view/EnterpriseASPAR/OrderProcessing/OrderHeaderList/gridRowActions.php and add to it some html
	     */
	    //including custom row actions
	    if(file_exists(__DIR__ . "/../" . $PartsPath . "gridRowActions.php"))
		require __DIR__ . "/../" . $PartsPath . "gridRowActions.php";

	    $_html .= "</td>";
	}
	/*
	   Output values. Each value just a text inside td.
	   Value can be formatted if it needed by its type. For example datetime prints as month/day/year
	   Also here is the formatting using formatFunction. This feature used by formatting Currency fields
	 */
	foreach($data->gridFields as $column =>$columnDef){
	    $_html .= "<td>\n";
	    if(key_exists("editable", $columnDef) && $columnDef["editable"])
		$_html .= renderInput($ascope, $data, $data->gridFields, $columnDef, $column, $row[$column], $keyString, $current_row);
	    else
		$_html .= renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, $column, $row[$column]);
	    $_html .= "</td>\n";
	}
	$_html .= "</tr>";
        
        return $_html;
    }
?>
