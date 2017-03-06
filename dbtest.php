<?php
require 'vendor/autoload.php';
use Illuminate\Database\Capsule\Manager as Capsule;
//require 'config/database.php';

//use Illuminate\Support\Facades\DB;
$capsule = new Capsule;

$capsule->addConnection([
    "driver" => "mysql",
    "host" => "localhost",
    "database" => "integralx",
    "username" => "enterprise",
    "password" => "enterprise",
    "charset" => "utf8",
    "collation" => "utf8_unicode_ci",
    "prefix" => ""
]);

$capsule->setAsGlobal();

echo json_encode(Capsule::select("SELECT * from payrollemployees", array()));
?>

