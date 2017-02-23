<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

require __DIR__ . "/../Models/translation.php";
require __DIR__ . "/../Models/companies.php";
//require __DIR__ . "/../Models/users.php";

class _app{
    public $title = "Integral Accounting New Tech PHP";
}

class _translation{
    public function translateLabel($label){
        return $label;
    }
}

class Login extends BaseController
{
    //use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    public function show(){
        return view("login", [ "app" => new _app,
                               "translation" => new \App\Models\translation("english"),
                               "companies" => new \App\Models\companies,
                               //                             "translation" => new \App\Models\users
        ]);
    }
}

?>