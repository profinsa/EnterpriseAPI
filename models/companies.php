<?php
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