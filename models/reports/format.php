<?php

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

function formatCurrency($value){
    $afterdot = 2;
    if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
        return numberToStr($numberParts[1]) . '.' . (strlen(substr($numberParts[2], 0, $afterdot)) == 1 ? substr($numberParts[2], 0, $afterdot) . '0' : substr($numberParts[2], 0, $afterdot));
    else
        return numberToStr($value) . ".00";

}

function gridFormatFields($stmt, $result){
    if(count($result)){
        $meta = [];
        $mcounter = 0;
        foreach($result[0] as $key=>$value){
            $meta[$key] = $stmt->getColumnMeta($mcounter++);
        }
        
        //formatting data
        foreach($result as $rkey=>$row){
            foreach($row as $key=>$value){
                $result[$rkey][$key . "Original"] = $value;
                if($meta[$key]["native_type"] == "NEWDECIMAL" || $meta[$key]["native_type"] == "DECIMAL" || $meta[$key]["native_type"] == "LONGLONG" || preg_match('/^\d+\.\d+/', $value)){
                    $afterdot = 2;
                    if($meta[$key]["native_type"] == "LONGLONG")
                        $result[$rkey][$key] = numberToStr($value) . ".00";
                    else if(preg_match('/([-+\d]+)\.(\d+)/', $value, $numberParts))
                        $result[$rkey][$key] = numberToStr($numberParts[1]) . '.' . (strlen(substr($numberParts[2], 0, $afterdot)) == 1 ? substr($numberParts[2], 0, $afterdot) . '0' : substr($numberParts[2], 0, $afterdot));
                }
                if($meta[$key]["native_type"] == "TIMESTAMP" || $meta[$key]["native_type"] == "DATETIME")
                    if($value != "")
                        $result[$rkey][$key] = date("m/d/y", strtotime($value));
            }
        }
    }
    return $result;
}

?>