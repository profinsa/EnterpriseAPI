<?php
    if(isset($_FILES['file'])){
        $errors = array();
        
        $files = "[";

        $count = count($_FILES['file']['name']);
        for ($i=0; $i<$count; $i++) {
            $file_name = $_FILES['file']['name'][$i];
            $file_size = $_FILES['file']['size'][$i];
            $file_tmp = $_FILES['file']['tmp_name'][$i];
            $file_type = $_FILES['file']['type'][$i];
            $file_ext = strtolower(end(explode('.',$_FILES['file']['name'][$i])));
            
            $expensions= array("jpeg","jpg","png");
            if(in_array($file_ext,$expensions)=== false){
                $errors[] = "extension not allowed, please choose a JPEG or PNG file.";
            }

            if($file_size > 10485760) {
                $errors[] = 'File size must be less than 10 MB';
            }

            $date = new DateTime();
            if(empty($errors) == true) {
                move_uploaded_file($file_tmp, __DIR__ . "/uploads/" . $date->getTimestamp() . "_" . $file_name);
            }
            if ($i == 0) {
                $files .= "\"" .$date->getTimestamp() . "_" . $file_name . "\"";
            } else {
                $files .= ",\"" .$date->getTimestamp() . "_" . $file_name . "\"";
            }
        }

        $files .= "]";

        if(empty($errors) == true) {
            echo "{ \"message\" : \"ok\", \"data\" : ". $files . "}";
        }else{
            http_response_code(400);
            echo "{ \"message\" : \"error\", \"data\" : ". json_encode($errors) . "}";
        }
    }
?>
