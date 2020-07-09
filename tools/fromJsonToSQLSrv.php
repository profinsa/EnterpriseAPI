<?php
include '../init.php';



$query = "select TOP(1) * from orderheader";
//$query = "select * from orderheader limit 1";
echo json_encode(DB::select($query), JSON_PRETTY_PRINT);
//echo json_encode(DB::describe("OrderHeader"), JSON_PRETTY_PRINT);
?>
