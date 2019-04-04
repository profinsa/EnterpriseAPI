<?php
    if(isset($_FILES['imageFile'])){
        $errors = array();
        
        $files = [];

        foreach($_FILES['imageFile']['name'] as $i=>$fileName) {
            $file_name = $_FILES['imageFile']['name'][$i];
            $file_size = $_FILES['imageFile']['size'][$i];
            $file_tmp = $_FILES['imageFile']['tmp_name'][$i];
            $file_type = $_FILES['imageFile']['type'][$i];
            $file_ext = strtolower(end(explode('.',$_FILES['imageFile']['name'][$i])));
            
            $expensions= array("jpeg","jpg","png", "gif");

            //            echo json_encode($_FILES, JSON_PRETTY_PRINT);
            //            echo $_FILES['imageFile']['name'];
            if(in_array($file_ext,$expensions)=== false){
                $errors[] = "extension not allowed, please choose a JPEG, JPG, PNG or GIF file.";
            }

            if($file_size > 10485760) {
                $errors[] = 'File size must be less than 10 MB';
            }

            $date = new DateTime();
            if(empty($errors) == true) {
                move_uploaded_file($file_tmp, __DIR__ . "/uploads/" . $date->getTimestamp() . "_" . $file_name);
            }
            $files[$i] = $date->getTimestamp() . "_" . $file_name;
        }

        if(empty($errors) == true) {
            echo json_encode([
                "message" => "ok",
                "data" => $files,
                //"files" => $_FILES
            ], JSON_PRETTY_PRINT);
        }else{
            http_response_code(400);
            echo "{ \"message\" : \"" . implode("&&", $errors) . "\"}";
        }
    }
?>
