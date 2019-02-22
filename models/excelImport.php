<?php
/*
  Name of Page: Excel Import

  Method: provides procedures for working with Excel files, parsing and processing

  Date created: 22/02/2019 Nikita Zaharov

  Use: this model used by other models for working with Excel files

  Input parameters:
  Excel files

  Output parameters:
  arrays with data


  Called from:
  from models which use it for parsing excel files


  Calls:
  simplexls and simplexlsx

  Last Modified: 22/02/2019
  Last Modified by: Zaharov Nikita
*/

require __DIR__ . "/../dependencies/php/simplexls.php";

class excelImport {
    public function getDataFromUploadedFile($correctNames){
        $rowsWithNames = [];
        $errors = array();
        $file_name = $_FILES['file']['name'][0];
        $file_size = $_FILES['file']['size'][0];
        $file_tmp = $_FILES['file']['tmp_name'][0];
        $file_type = $_FILES['file']['type'][0];

        if($file_size > 10485760) 
            $errors[] = 'File size must be less than 10 MB';

        $date = new DateTime();
        $newFilePath = __DIR__ . "/../uploads/" . $date->getTimestamp() . "_" . $file_name;
        if(empty($errors) == true) 
            move_uploaded_file($file_tmp, $newFilePath);

        if ( $xls = SimpleXLS::parse($newFilePath)) {
            $rows = $xls->rows();
            $rowsCount = count($rows);
            $ind = 0;
            while($ind != $rowsCount){
                if($ind != 0){
                    $rowsWithNames[$ind - 1] = [];
                    //echo json_encode($rows[$ind], JSON_PRETTY_PRINT);
                    foreach($rows[$ind] as $key=>$value)
                        $rowsWithNames[$ind - 1][$correctNames[$rows[0][$key]]] = $value;
                    //                        echo json_encode($rowsWithNames, JSON_PRETTY_PRINT);
                }
                $ind++;
            }

            //foreach(
            //print_r($rowsWithNames);
            //                print_r(  ); // dump first sheet
            //                print_r( $xls->rows(1)); /// dump second sheet
        } else {
            echo SimpleXLS::parseError();
        }
        
        return $rowsWithNames;
    }
    
}
?>