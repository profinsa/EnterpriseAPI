<?php
$requireModelPath = $argv[1];
$model_path = $argv[2];
$pathinfo = pathinfo($requireModelPath);
//echo $pathinfo['dirname'] . "\n";
//echo json_encode($argv);
if(!is_dir('jsonModels/' . $pathinfo['dirname'])){
// dir doesn't exist, make it
    mkdir('jsonModels/' . $pathinfo['dirname'], 0777, true);
}

if(!file_exists(__DIR__ . '/models/' . $requireModelPath . '.php')){
    echo "not found\n";
    //    $tables[] = 'not found';
}else{
    //        runkit_constant_remove("gridData");
    require __DIR__ . '/models/' . $requireModelPath. '.php';
		    
    if($requireModelPath != $model_path){
        preg_match("/\/([^\/]+)$/", $model_path, $filename);
        $newPath = $filename[1];
        $data = new $newPath;
    }
    else
        $data = new gridData();
    file_put_contents("jsonModels/" . $requireModelPath . "Description.json", json_encode($data, JSON_PRETTY_PRINT));
}
?>