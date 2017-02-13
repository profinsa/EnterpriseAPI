<?php
/*
Name of Page: Companies

Method: Companies model, used for getting compani list and work with it

Date created: Nikita Zaharov, 09.02.2016

Use:

Input parameters:
$db: database instance

Output parameters:
$companies: model, which contains available companies and methods to work with

Called from:
+ controllers/login.php

Calls:
sql

Last Modified: 13.02.2016
Last Modified by: Nikita Zaharov
*/

class companies{
    public $companies = [];
    public function __construct($db){        
        $result = mysqli_query($db, 'SELECT CompanyID,DivisionID,DepartmentID from companies') or die('mysql query error: ' . mysqli_error($db));

        while ($line = mysqli_fetch_assoc($result)) {
            $this->companies[] = $line;
        }
        mysqli_free_result($result);
    }
}
?>