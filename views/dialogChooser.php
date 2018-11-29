<!--
     ui logic for building dialog for choosing items using data models
-->
<?php
function writeValue($data, $desc, $value){
    switch($desc["inputType"]){
	case "checkbox" :
	    return "<input class=\"grid-checkbox\" type=\"checkbox\"  ". ($value ? "checked" : "") . " disabled />";
	    break;
	case "timestamp" :
	case "datetime" :
	    return date("m/d/y", strtotime($value));
	    break;
	case "text":
	case "dialogChooser":
	case "dropdown":
	    if(key_exists("formatFunction", $desc)){
		$formatFunction = $desc["formatFunction"];
		return $data->$formatFunction($item, "editCategories", $key, $value, false);
	    }
	    else
		return formatField($desc, $value);
	    break;
    }
}
?>
<?php foreach($GLOBALS["dialogChooserTypes"] as $key=>$value): ?>
    <?php
    $dialogData = $data->$key();
    ?>
    <script>
     window["dataDialogChooser<?php echo $value["fieldName"]; ?>"] = {
	 data : <?php echo json_encode($dialogData, JSON_PRETTY_PRINT); ?>,
	 desc : <?php echo json_encode($GLOBALS["dialogChooserTypes"][$key], JSON_PRETTY_PRINT); ?>
     };
    </script>
    <div id="<?php echo $key; ?>" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document" style="display:table;">
	    <div class="modal-content">
		<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    <h4 class="modal-title"><?php echo $dialogData["title"]; ?></h4>
		</div>
		<div class="modal-body">
		    <table class="table" id="<?php echo $key; ?>Table">
			<thead>
			    <th></th>
			    <?php foreach($dialogData["desc"] as $dkey=>$desc): ?>
				<th>
				    <?php echo $translation->translateLabel($desc["title"]); ?>
				</th>
			    <?php endforeach; ?>
			</thead>
			<tbody>
			    <?php foreach($dialogData["values"] as $row): ?>
				<tr>
				    <td>
					<a href="javascript:dialogChooserChoose(<?php echo "'$key',  '{$row->{$dialogData["choosedColumn"]}}'"; ?>);" class="btn btn-info">Select</a>
				    </td>
				    <?php foreach($row as $column=>$cvalue)
					echo "<td>" . writeValue($data, $dialogData["desc"][$column], $cvalue) . "</td>";
				    ?>
				</tr>
			    <?php endforeach; ?>
			</tbody>
		    </table>
		</div>
		<div class="modal-footer">
		    <button type="button" class="btn btn-primary" data-dismiss="modal">
			<?php echo $translation->translateLabel("Ok"); ?>
		    </button>
		</div>
	    </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
<?php endforeach; ?>
<script>
 var dialogChooserInputs = <?php echo json_encode($GLOBALS["dialogChooserInputs"]); ?>, ind;
 //dialogChooser modal openner
 var dialogChooserCurrentField;
 for(ind in dialogChooserInputs){
     $('#' + ind).click((function(ind){
	 return function(){
	     console.log('hahaha');
	     dialogChooserCurrentField = ind;
	     $('#' + dialogChooserInputs[ind]).modal('show');
	     if(!$.fn.DataTable.isDataTable("#" + dialogChooserInputs[ind] + "Table"))
		 $("#" + dialogChooserInputs[ind] + "Table").DataTable({});
	 };
     })(ind)
     );
 }
 //handler of customer choose button
 function dialogChooserChoose(dialog, value){
     var values = window['dataDialogChooser' + dialogChooserCurrentField].data.allValues,
	 fields = window['dataDialogChooser' + dialogChooserCurrentField].desc.fieldsToFill,
	 ind;
     for(ind in values){
	 if(values[ind][dialogChooserCurrentField] == value){
	     values = values[ind];
	     break;
	 }
     }

     console.log(values);
     //     console.log(JSON.stringify(window['dataDialogChooser' + dialogChooserCurrentField], null, 3));
     $('#' + dialog).modal('hide');
     $('#' + dialogChooserCurrentField).val(value);
     for(ind in values) //foreach fields for working with fiels transformation array
	 $('#' + ind).val(values[ind]);
 }
</script>
