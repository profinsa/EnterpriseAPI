<?php
include './init.php';

echo json_encode(DB::select("SELECT * from payrollemployees", array()));
?>

