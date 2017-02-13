<?php
class users{
    protected $db = false;

    public function __construct($database){
        $this->db = $database;
    }
    
    public function search($company, $name, $password, $division, $department){
        $result = mysqli_query($this->db, "SELECT * from payrollemployees WHERE CompanyID='" . $company . "' AND EmployeeUserName='". $name ."' AND EmployeePassword='" . $password . "' AND DivisionID='" . $division . "' AND DepartmentID='" . $department . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        if(!($ret = mysqli_fetch_assoc($result)))
            $ret = false;

        mysqli_free_result($result);
        if($ret){
            $result = mysqli_query($this->db, "INSERT INTO auditlogin(CompanyID,DivisionID,DepartmentID,EmployeeID,LoginDateTime,IPAddress) values('" . $ret["CompanyID"] . "','" . $ret["DivisionID"] ."','" . $ret["DepartmentID"] . "','" . $ret["EmployeeID"] . "',CURDATE(),'" . $_SERVER['REMOTE_ADDR'] ."')")  or die('mysql query error: ' . mysqli_error($this->db));
            
            mysqli_free_result($result);            
            $result = mysqli_query($this->db, "SELECT * FROM accesspermissions WHERE CompanyID='" . $ret["CompanyID"] . "' AND DivisionID='" . $ret["DivisionID"] ."' AND DepartmentID='" . $ret["DepartmentID"] . "' AND EmployeeID='" . $ret["EmployeeID"] . "'")  or die('mysql query error: ' . mysqli_error($this->db));
            
            $ret["accesspermissions"] = mysqli_fetch_assoc($result);
            mysqli_free_result($result);            
        }
        
        return $ret;
    }

}
?>