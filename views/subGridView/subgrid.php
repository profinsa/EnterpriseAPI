<!--
     Name of Page: subgrid

     Method: renders subgrid grid. 

     Date created: Nikita Zaharov, 3.04.2017

     Use: used by many detail views with subgrid features for rendering page
     Page may renders in four modes:
     + grid
     data is displayed in table mode
     + edit
     same as previous, but record displayed not as text as inputs for edit
     + new
     same as previous, but with default values and record inserted, not updated

     Input parameters:

     Output parameters:
     html

     Called from:
     controllers/GeneralLedger/*.php

     Calls:
     translation model
     grid model
     app as model

     Last Modified: 25.07.2019
     Last Modified by: Nikita Zaharov
-->
<!-- subgrid -->

<?php
    require  './views/gridView/blocks/common.php';
    $gridFields = $data->gridFields;
?>

<div id="grid_content" class="row">
    <div>
        <table id="example23" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <?php if(!property_exists($data, "modes") || in_array("edit", $data->modes)): ?>
                        <th></th>
                    <?php endif; ?>
                    <?php
                        //getting data for table
                        $rows = $data->getPage($ascope["items"]);
                        //renders table column headers using rows data, columnNames(dictionary for corresponding column name to ObjID) and translation model for translation
                        foreach($data->gridFields as $key=>$field)
                        echo "<th>" . $translation->translateLabel($data->columnNames[$key]) . "</th>";
                    ?>
                </tr>
            </thead>
            <tbody>
                <?php
                    //renders table rows using rows, getted in previous block
                    //also renders buttons like edit, delete of row
                    if(count($rows)){
                        foreach($rows as $row){
                            $keyString = '';
                            foreach($data->idFields as $key){
                                $keyString .= $row[$key] . "__";
                            }
                            $keyString = substr($keyString, 0, -2);
                            echo "<tr>";
                            if(!property_exists($data, "modes") || in_array("edit", $data->modes)){
                                echo "<td>";
                                if($security->can("update"))
                                    echo "<span onclick=\"changeSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span>";
                                if($security->can("delete"))
                                    echo "<span onclick=\"deleteSubgridItem('" . $keyString . "')\" class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span>";
                                echo "</td>";
                            }
                            foreach($row as $key=>$value)
                            if(key_exists($key, $data->gridFields)){
                                if($gridFields[$key]["dbType"] == "decimal(19,4)")
                                    $txtalign = "right";
                                else
                                    $txtalign = "center";
                                echo "<td style=\"text-align: $txtalign\">\n";
                                $columnDef = $data->gridFields[$key];
                                $column = $key;
                                if(key_exists("editable", $columnDef) && $columnDef["editable"])
                                    echo renderInput($ascope, $data, $data->gridFields, $columnDef, $column, $row[$column], $keyString, $current_row);
                                else
                                    echo renderGridValue($linksMaker, $ascope, $data, $data->gridFields, $drill, $row, $column, $row[$column]);
                                /*    switch($data->gridFields[$key]["inputType"]){
                                   case "checkbox" :
                                   echo $value ? "True" : "False";
                                   break;
                                   case "timestamp" :
                                   case "datetime" :
                                   echo date("m/d/y", strtotime($value));
                                   break;
                                   case "text":
                                   case "dialogChooser" :
                                   case "dropdown":
                                   if(key_exists("formatFunction", $data->gridFields[$key])){
                                   $formatFunction = $data->gridFields[$key]["formatFunction"];
                                   echo $data->$formatFunction($row, "gridFields", $key, $value, false);
                                   }
                                   else
                                   echo formatField($data->gridFields[$key], $value);
                                   break;
                                   }*/
                                echo "</td>\n";
                            }
                            echo "</tr>";
                        }
                    }
                ?>
            </tbody>
        </table>
    </div>
    <div class="subgrid-buttons col-md-1">
        <?php if((!property_exists($data, "modes") || in_array("new", $data->modes)) && $security->can("insert")): ?>
            <a class="btn btn-info" onclick="newSubgridItem()">
                <?php echo $translation->translateLabel("New"); ?>
            </a>
        <?php endif; ?>
    </div>
    <script>
     //adding buttons to table footer
     setTimeout(function(){
         var buttons = $('.subgrid-buttons');
         var tableFooter = $('.subgrid-table-footer');
         tableFooter.prepend(buttons);
     },300);
     //handler new button. Does xhr request and replace grid content
     function newSubgridItem(){
         if(typeof(newSubgridItemHook) == 'function'){
             if(newSubgridItemHook())
                 return;
         }
         var itemData = $("#itemData");
         $.get("index.php?page=subgrid&action=<?php  echo $scope->action ;  ?>&mode=new&category=Main&item=<?php echo $scope->items; ?>")
          .done(function(data){
              //       setTimeout(function(){
              $("#subgrid").html(data);
              //    },0);
          })
          .error(function(xhr){
              if(xhr.status == 401)
                  window.location = "index.php?page=login";
              else
                  alert("Unable to load page");
          });
     }
     
     //handler change button from rows. Does xhr request and replace grid content
     function changeSubgridItem(item){
         var itemData = $("#itemData");
         $.get("index.php?page=subgrid&action=<?php  echo $scope->action ;  ?>&mode=edit&category=Main&item=" + item)
          .done(function(data){
              //       setTimeout(function(){
              $("#subgrid").html(data);
              //    },0);
          })
          .error(function(xhr){
              if(xhr.status == 401)
                  window.location = "index.php?page=login";
              else
                  alert("Unable to load page");
          });
     }
     //handler delete button from rows. Just doing XHR request to delete item and redirect to grid if success
     function deleteSubgridItem(item){
         if(confirm("Are you sure?")){
             var itemData = $("#itemData");
             $.getJSON("index.php?page=subgrid&action=<?php  echo $scope->action ;  ?>&delete=true&id=" + item)
              .success(function(data) {
                  callRecalc('<?php 
$keyValues = explode("__", $ascope["items"]);
echo $keyValues[count($keyValues) - 1]; 
?>');
              })
              .error(function(err){
                  console.log('wrong');
              });
         }
     }
    </script>
</div>
