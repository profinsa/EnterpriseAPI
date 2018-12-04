<div class="table-responsive order-entry-header col-md-12 col-xs-12" style="margin-top:20px;">
    <?php 
    $rows = $data->getDetail(key_exists("keyFields",$data->detailTable) ? $headerItem[$data->detailTable["keyFields"][0]] :$headerItem["OrderNumber"]);
    $gridFields = $data->embeddedgridFields;
    $embeddedgridContext = $headerItem;
    function makeRowActions($linksMaker, $data, $ascope, $row, $embeddedgridContext){
	$user = $GLOBALS["user"];
	$keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"] . "__" . $row[$data->detailTable["keyFields"][0]] . (count($data->detailTable["keyFields"]) > 1 ? "__" . $row[$data->detailTable["keyFields"][1]] : "");
	echo "<a href=\"" . $linksMaker->makeEmbeddedgridItemEditLink($data->detailTable["viewPath"], $ascope["path"], $keyString, $ascope["item"]);
	echo "\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
	echo "<a href=\"javascript:;\" onclick=\"orderDetailDelete('$keyString')\"><span class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></a>";
    }
    include __DIR__ . "/../../../../embeddedgrid.php"; 
    ?>
</div>
<div class="subgrid-buttons row col-md-1">
    <?php if(!key_exists("disableNew", $data->detailTable) && $ascope["mode"] != "new"): ?>
	<a class="btn btn-info" href="javascript:;" onclick="orderDetailNew();">
	    <?php echo $translation->translateLabel("New"); ?>
	</a>
    <?php elseif($ascope["mode"] == "new"): ?>
	<a class="btn btn-info" href="javascript:;" onclick="orderDetailNewInNew();">
	    <?php echo $translation->translateLabel("New"); ?>
	</a>
    <?php endif; ?>
</div>
<script>
 datatableInitialized = true;
 var table = $('#example23').DataTable( {
     dom : "<'subgrid-table-header row'<'col-sm-6'l><'col-sm-6'f>><'subgrid-table-content row't><'subgrid-table-footer row'<'col-sm-4'i><'col-sm-7'p>>"
 });
 setTimeout(function(){
     var buttons = $('.subgrid-buttons');
     var tableFooter = $('.subgrid-table-footer');
     tableFooter.prepend(buttons);
 },300);


 //handler new button for detail grid in view and edit mode
 function orderDetailNew(){
     //<?php echo $linksMaker->makeEmbeddedgridItemNewLink($data->detailTable["viewPath"], $ascope["path"], "new", $ascope["item"]) . "&{$data->detailTable["newKeyField"]}={$embeddedgridContext[$data->detailTable["newKeyField"]]}" ?>

     var newLink = linksMaker.makeEmbeddedgridItemNewLink(
	 "<?php echo $data->detailTable["viewPath"]; ?>",
	 "<?php echo  $ascope["path"]; ?>", "new",
	 generateKeyString({ "<?php echo $data->detailTable["newKeyField"]; ?>" : res["<?php echo $data->detailTable["newKeyField"]; ?>"]})) +
		   "&<?php echo $data->detailTable["newKeyField"]; ?>=" + res["<?php echo $data->detailTable["newKeyField"]; ?>"];
     console.log(newLink);
     
     //window.location = newLink;
 }

 //handler new button for detail grid in New mode
 function orderDetailNewInNew(){
     var itemData = $("#itemData");

     if (validateForm(itemData)) {
         $.post("<?php echo $linksMaker->makeGridItemNew($ascope["path"]); ?>", itemData.serialize(), null, 'json')
          .success(function(res) {
	      var newLink = linksMaker.makeEmbeddedgridItemNewLink(
		  "<?php echo $data->detailTable["viewPath"]; ?>",
		  "<?php echo  $ascope["path"]; ?>", "new",
		  generateKeyString({ "<?php echo $data->detailTable["newKeyField"]; ?>" : res["<?php echo $data->detailTable["newKeyField"]; ?>"]}))
			  + "&<?php echo $data->detailTable["newKeyField"]; ?>=" + res["<?php echo $data->detailTable["newKeyField"]; ?>"];
	      //console.log(newLink);
	      //                  console.log('ok');
	      window.location = newLink;
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
 }

 //handler delete button from rows. Just doing XHR request to delete item and redirect to grid if success
 function orderDetailDelete(item){
     if(confirm("Are you sure?")){
	 $.post("<?php echo $linksMaker->makeEmbeddedgridItemDeleteLink($ascope["path"], "");?>" + item, {})
	  .success(function(data) {
	      $.post(localStorage.getItem("autorecalcLink"), JSON.parse(localStorage.getItem("autorecalcData")))
	       .success(function(data) {
		   onlocation(window.location);
	       })
	       .error(function(err){
		   onlocation(window.location);
	       });
	  })
	  .error(function(err){
	      console.log('wrong');
	  });
     }
 }
</script>
