<?php
class users{
    protected $db = false;

    protected function user_get_permissions($name){
    }

    protected function user_log($name){
    }
    
    public function __construct($database){
        $this->db = $database;
    }
    
    public function search($company, $name, $password){
        $result = mysqli_query($this->db, "SELECT * from payrollemployees WHERE CompanyID='" . $company . "' AND EmployeeUserName='". $name ."' AND EmployeePassword='" . $password . "'")  or die('mysql query error: ' . mysqli_error($this->db));

        if(!($ret = mysqli_fetch_assoc($result)))
            $ret = false;

        mysqli_free_result($result);
        
        return $ret;
    }

}
?>