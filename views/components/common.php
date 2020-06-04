<?php
/*
  Common functions and classes for all views. 
  Something like general purpose library for views in the project
*/
    
function makeId($id){
    return preg_replace("/[\s\$\&]+/", "", $id);
}

function formatValue($data, $fieldsDefinition, $values, $key, $value){
    switch($fieldsDefinition[$key]["inputType"]){
    case "checkbox" :
        echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
        break;
    case "timestamp" :
    case "datetime" :
        echo date("m/d/y", strtotime($value));
        break;
    case "dialogChooser":
    case "text":
    case "dropdown":
        if(key_exists("formatFunction", $fieldsDefinition[$key])){
            $formatFunction = $fieldsDefinition[$key]["formatFunction"];
            echo $data->$formatFunction($values, "editCategories", $key, $value, false);
        }
        else
            echo formatField($fieldsDefinition[$key], $value);
        break;
    }
}
?>