<?php
$_keys = explode("__", $keyString);
if($_keys[0] == $user["CompanyID"] &&
   $_keys[1] == $user["DivisionID"] &&
   $_keys[2] ==$user["DepartmentID"])
    echo "<a href=\"" . $linksMaker->makeGridItemView("SystemSetup/CompanySetup/DepartmentSetup", $keyString) . "\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
