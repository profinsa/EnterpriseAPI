<?php
function doDirectory($directory){
    //echo "scanning $directory\n";
    $models = scandir($directory);
    foreach($models as $file){
        if($file != "." && $file != ".."){
            //echo "current file: $file \n";
            if(is_dir($directory . "/" . $file))
                doDirectory($directory . "/" . $file);
            else{
                $content = file_get_contents($directory . "/" . $file);
                //old logic
                if(preg_match("/(class gridData )/", $content) == 1){
                    preg_match("/(.+)(\.php\~?)/", $file, $matches);
                    echo "matched file: " . $matches[1] . "\n";
                    $newcontent = preg_replace("/class gridData /", "class $matches[1] ", $content);
                    file_put_contents($directory . "/" . $file, $newcontent); 
                }
            }
        }
    }
}

doDirectory("../models");
                 
?>