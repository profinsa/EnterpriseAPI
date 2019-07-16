<?php
include './init.php';

$procNames = DB::select("select specific_name, type, param_list, body_utf8, comment, returns, definer, name from mysql.proc WHERE db='enterprise'");

//echo json_encode($stored, JSON_PRETTY_PRINT);
foreach($procNames as $key=>$stored){
    //    $stored = DB::select("select specific_name, type, param_list, body_utf8, comment, returns, definer, name from mysql.proc WHERE db=? AND specific_name=?", ["enterprise", $proc->specific_name])[0];
    $dir = $stored->type == "PROCEDURE" ? "procedures" : "functions";
    //    if($stored->type == "PROCEDURE")
    file_put_contents("../database/$dir/{$stored->specific_name}.sql", "CREATE {$stored->type} {$stored->specific_name} ({$stored->param_list}) {$stored->body_utf8}");
}
    //    echo DB::Select

//echo json_encode(DB::Select("SELECT CONCAT('CREATE PROCEDURE `', specific_name, '`(', param_list, ') AS ') AS `stmt`, body_utf8 FROM `mysql`.`proc` WHERE `db` = 'enterprise' AND specific_name = 'myprocedure';"), JSON_PRETTY_PRINT);// AND specific_name = 'myprocedure';"));
?>