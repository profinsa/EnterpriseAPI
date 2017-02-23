<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

//login page
Route::get('/login', "Login@show");
Route::post('/login', "Login@login");
Route::get('/ByPassLogin', "Login@ByPassLogin");

//Language settings

Route::get('/language/{lang}', "Language@set");

//index page
Route::get('/index', "Index@index");

//
//Route::get('/grid', "Grid@grid");