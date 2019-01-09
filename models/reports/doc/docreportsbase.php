<?php
class docReportsBase{
    public function getUser(){
        $user = Session::get("user");
        $user["company"] = DB::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] ."' and DivisionID='" . $user["DivisionID"] . "' and DepartmentID='" . $user["DepartmentID"] . "'", array())[0];

        $public_prefix = public_prefix();
        $user["company"]->CompanyLogoUrl = "$public_prefix/uploads/{$user["company"]->Logo}";
        return $user;
    }
}
?>