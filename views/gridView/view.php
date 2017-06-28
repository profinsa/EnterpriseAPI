<?php
if(key_exists("back", $_GET)){
    $backhref = preg_replace("/\.\.\./", "#", $_GET["back"]) . "&back={$_GET["back"]}";
    $back = "?{$_SERVER["QUERY_STRING"]}";
}else{
    $backhref = $linksMaker->makeGridItemViewCancel($ascope["path"]);
    $back = "";
}
function makeId($id){
    return preg_replace("/[\s\$]+/", "", $id);
}
function makeRowActions($linksMaker, $data, $ascope, $row, $ctx){
    $user = $GLOBALS["user"];
    $keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"] . "__" . $row[$ctx["detailTable"]["keyFields"][0]] . (count($ctx["detailTable"]["keyFields"]) > 1 ? "__" . $row[$ctx["detailTable"]["keyFields"][1]] : "");
    if(!key_exists("editDisabled", $ctx["detailTable"])){
    echo "<a href=\"" . $linksMaker->makeEmbeddedgridItemViewLink($ctx["detailTable"]["viewPath"], $ascope["path"], $keyString, $ascope["item"]);
    echo "\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
    }
    if(!key_exists("deleteDisabled", $ctx["detailTable"]))
    echo "<a href=\"javascript:;\" onclick=\"embeddedGridDelete('$keyString')\"><span class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></a>";
}
?>
<div id="row_viewer">
    <ul class="nav nav-tabs" role="tablist">
    <?php
    //render tabs like Main, Current etc
    //uses $data(charOfAccounts model) as dictionaries which contains list of tab names
    foreach($data->editCategories as $key =>$value)
        if($key != '...fields') //making tab links only for usual categories, not for ...fields, reserved only for the data
        echo "<li role=\"presentation\"". ( $ascope["category"] == $key ? " class=\"active\"" : "")  ."><a href=\"#". makeId($key) . "\" aria-controls=\"". makeId($key) . "\" role=\"tab\" data-toggle=\"tab\">" . $translation->translateLabel($key) . "</a></li>";
    ?>
    </ul>
    <div class="tab-content">
    <?php foreach($data->editCategories as $key =>$value):  ?>
        <div role="tabpanel" class="tab-pane <?php echo $ascope["category"] == $key ? "active" : ""; ?>" id="<?php echo makeId($key); ?>">
        <?php
        $curCategory = $key;
        $item = $data->getEditItem($ascope["item"], $key);
        ?>
        <div class="table-responsive" style="margin-top:10px;">
            <?php if(!property_exists($data, "detailPages") ||
                 !key_exists($curCategory, $data->detailPages)||
                 !key_exists("hideFields", $data->detailPages[$curCategory])):?>
            <table class="table">
                <thead>
                <tr>
                    <th>
                    <?php echo $translation->translateLabel("Field"); ?>
                    </th>
                    <th>
                    <?php echo $translation->translateLabel("Value"); ?>
                    </th>
                </tr>
                </thead>
                <tbody id="row_viewer_tbody">
                <?php
                //renders table, contains record data using getEditItem from model
                $category = $key;
                foreach($item as $key =>$value){
                    if(key_exists($key, $data->editCategories[$category])){
                    echo "<tr><td>" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . "</td><td>";
                    switch($data->editCategories[$category][$key]["inputType"]){
                        case "checkbox" :
                            echo "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
                        break;
                        case "timestamp" :
                        case "datetime" :
                            echo date("m/d/y", strtotime($value));
                        break;
                        case "text":
                        case "dropdown":
                        if(key_exists("formatFunction", $data->editCategories[$category][$key])){
                            $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
                            echo $data->$formatFunction($item, "editCategories", $key, $value, false);
                        }
                        else
                            echo formatField($data->editCategories[$category][$key], $value);
                        break;
                    }
                    echo "</td></tr>";
                    }
                }
                ?>
                </tbody>
            </table>
            <?php endif; ?>
            <?php if(property_exists($data, "detailPages") && key_exists($curCategory, $data->detailPages)):?>
            <div class="col-md-12 col-xs-12">
                <?php
                $getmethod = "get" . makeId($curCategory);
                $deletemethod = "delete" . makeId($curCategory);
                $rows = $data->$getmethod(key_exists("OrderNumber", $item) ? $item["OrderNumber"] : $item[$data->detailPages[$curCategory]["keyFields"][0]]);
                //			echo json_encode($rows);
                $detailTable = $data->detailPages[$curCategory];
                $gridFields = $embeddedgridFields = $detailTable["gridFields"];
                $embeddedgridContext = [
                "item" =>$item,
                "detailTable" => $detailTable
                ];
                $embeddedGridClasses = $newButtonId = "new" . makeId($curCategory);
                require __DIR__ . "/../embeddedgrid.php"; 
                ?>
            </div>
            <div id="<?php echo $newButtonId; ?>" class="row col-md-1">
                <?php if(!key_exists("disableNew", $data->detailPages[$curCategory])): ?>
                <a class="btn btn-info" href="<?php echo $linksMaker->makeEmbeddedgridItemNewLink($data->detailPages[$curCategory]["viewPath"], $ascope["path"], "new", $ascope["item"]) . "&{$data->detailPages[$curCategory]["newKeyField"]}={$embeddedgridContext["item"][$data->detailPages[$curCategory]["newKeyField"]]}" ?>">
                    <?php echo $translation->translateLabel("New"); ?>
                </a>
                <?php endif; ?>
            </div>
            <script>
             //			 if(!datatableInitialized){
             datatableInitialized = true;
             console.log("initializing datatable");
             var table = $('.<?php echo $newButtonId ?>').DataTable( {
                 dom : "<'subgrid-table-header row'<'col-sm-6'l><'col-sm-6'f>><'subgrid-table-content row't><'#footer<?php echo $newButtonId; ?>.row'<'col-sm-4'i><'col-sm-7'p>>"
             });
             //			 }
             setTimeout(function(){
                 var buttons = $('#<?php echo $newButtonId; ?>');
                 var tableFooter = $('#footer<?php echo $newButtonId; ?>');
                 console.log(tableFooter, buttons);
                 tableFooter.prepend(buttons);
             },300);
            </script>
            <?php endif; ?>
        </div>
        </div>
    <?php endforeach; ?>
    </div>
    <?php
    if(file_exists(__DIR__ . "/../" . $PartsPath . "viewFooter.php"))
    require __DIR__ . "/../" . $PartsPath . "viewFooter.php";
    if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditFooter.php"))
    require __DIR__ . "/../" . $PartsPath . "vieweditFooter.php";
    ?>

    <div style="margin-top:10px" class="pull-right">
    <!--
         buttons Edit and Cancel
         for translation uses translation model
         for category(which tab is activated) uses $ascope of controller
       -->
    <?php if($security->can("update")): ?>
        <a class="btn btn-info" href="<?php echo $linksMaker->makeGridItemEdit($scope->action, $scope->item) . $back;?>">
            <?php echo $translation->translateLabel("Edit"); ?>
        </a>
        <?php
        if(file_exists(__DIR__ . "/../" . $PartsPath . "viewActions.php"))
        require __DIR__ . "/../" . $PartsPath . "viewActions.php";
        if(file_exists(__DIR__ . "/../" . $PartsPath . "vieweditActions.php"))
        require __DIR__ . "/../" . $PartsPath . "vieweditActions.php";
        ?>
    <?php endif; ?>
    <a class="btn btn-info" href="<?php echo $backhref; ?>">
        <?php echo $translation->translateLabel("Cancel"); ?>
    </a>
    </div>
</div>
