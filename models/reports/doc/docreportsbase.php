<?php
class docReportsBase{
    public function getUser(){
        $user = Session::get("user");
        //        $user["company"] = DB::select("SELECT * from companies WHERE CompanyID='" . $user["CompanyID"] ."' and DivisionID='" . $user["DivisionID"] . "' and DepartmentID='" . $user["DepartmentID"] . "'", array())[0];

        //     $public_prefix = public_prefix();
        //       $user["company"]->CompanyLogoUrl = "$public_prefix/uploads/{$user["company"]->Logo}";
        //$user["company"]->CompanyLogoUrl = "http://www.stfb.com/stfblogoemail.jpg";
        return $user;
    }

    public function getCurrencySymbol(){
        $user = $_SESSION["user"];

        $result =  $GLOBALS["capsule"]::select("select I.CurrencyID, C.CurrenycySymbol from {$this->tableName} I, CurrencyTypes C WHERE I.CurrencyID=C.CurrencyID and I.{$this->keyField}=? and I.CompanyID=? and C.CompanyID=? and I.DivisionID=? and C.DivisionID=? and C.DepartmentID=? and C.DepartmentID=?", array($this->id, $user["CompanyID"], $user["CompanyID"], $user["DivisionID"], $user["DivisionID"], $user["DepartmentID"], $user["DepartmentID"]));

        return [
            "id" => count($result) ? $result[0]->CurrencyID : "USD",
            "symbol" => count($result) ? $result[0]->CurrenycySymbol : "$"
        ];
    }
}
?>