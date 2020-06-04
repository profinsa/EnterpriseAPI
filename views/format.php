<?php
/*
     Name of Page: format

     Method: format numbers for text representation

     Date created: Nikita Zaharov, 16.03.2016

     Use: used by grid, edit, new and view forms for converting internal values to text representaion
     
     For example we have -10000.030 value, after format this value will be -10,000.03

     Input parameters:
     text
     Output parameters:
     text

     Called from:
     views(grid, new, edit and view forms)

     Calls:
     nothing, only  preg(Perl Compatible Regular Expressions)

     Last Modified: 16.03.2016
     Last Modified by: Nikita Zaharov
*/

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}
function formatField($typeDef, $value){
    $match;
    if(key_exists("format", $typeDef)){
        if(preg_match('/(.*)\{\s?0\s?\:\s?(\w)(\d?)\s?\}(.*)/', $typeDef["format"], $match)){
            switch($match[2]){
            case 'D' :
            case 'd' :
                break;

            case 'N' :
            case 'n' :
                $afterdot = 2;
                if($match[3])
                    $afterdot = $match[2];
                if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts)){
                    return $match[1] . numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot) . $match[4];
                }else
                    return numberToStr($value);
                break;
            }
        }
        else
            return $value;
    }
    else
        return $value;
}
?>