<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class _app{
    public $title = "Integral Accounting New Tech PHP";
}

class Login extends BaseController
{
    //use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    public function show(){
        return view("login", [ "app" => new _app]);
    }
}

?>