<?php
function numberToStr($strin){
    //			    return preg_replace();
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}
function formatField($typeDef, $value){
    $match;
    if(key_exists("format", $typeDef)){
        if(preg_match('/(.*)\{\s?0\s?\:\s?(\w)(\d?)\s?\}(.*)/', $typeDef["format"], $match)){
            echo $match[1];
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
                    return numberToStr($numberParts[1]) . '.' . substr($numberParts[2], 0, $afterdot);
                }
                break;
            }
            echo $match[4];
        }
        else
            return $value;
    }
    else
        return $value;
}
?>