<?php
/*
Name of Page: Companies

Method: Companies model, used for getting compani list and work with it

Date created: Nikita Zaharov, 22.02.2016

Use:

Input parameters:
$db: database instance

Output parameters:
$companies: model, which contains available companies and methods to work with

Called from:
+ controllers/login.php

Calls:
DB

Last Modified: 23.02.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Models;

use Illuminate\Support\Facades\DB;

class companies{
    public $companies = [];
    public function __construct(){        
        $this->companies = DB::select('SELECT CompanyID,DivisionID,DepartmentID from companies', array());
    }
}
?>