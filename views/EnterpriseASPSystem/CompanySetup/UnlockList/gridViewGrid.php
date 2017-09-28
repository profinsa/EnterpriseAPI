<!--
     Name of Page: grid

     Method: renders content of screen in grid mode. 

     Date created: Nikita Zaharov, 09.14.2017

     Use: used by views/gridView.php for rendering content in grid mode
     Data displayed as table. Each row is item and create and delete actions.

     Input parameters:

     Output parameters:
     html

     Called from:
     views/gridView.php

     Calls:
     translation model
     grid model
     app as model

     Last Modified: 09.28.2017
     Last Modified by: Nikita Zaharov
   -->

<!-- grid -->
<div id="grid_content" class="row">
    <div class="col-md-12">
	<form id="itemData" class="form-material form-horizontal m-t-30">
	    <input type="hidden" name="id" value="<?php echo $ascope["item"]; ?>" />
	    <input type="hidden" name="category" value="<?php echo $ascope["category"]; ?>" />
	    <div class="form-group">
		<label class="col-md-6">
		    <?php echo $translation->translateLabel("Employee ID"); ?>	
		</label>
		<div class="col-md-6">
		    <select name="EmployeeID" class="form-control">
			<?php
			$types = $data->getPayrollEmployees();
			foreach($types as $type)
			    echo "<option value=\"" . $type["value"] . "\">" . $type["title"] . "</option>";
			?>
		    </select>
		</div>
	    </div>
	</form>
	<div class="col-md-12 col-xs-12 row">
	    <div  style="margin-top:10px" class="pull-right">
		<!--
		     renders buttons translated Save and Cancel using translation model
		   -->
		<?php if($security->can("update")): ?>
		    <a class="btn btn-info" onclick="unlockSelected()">
			<?php echo $translation->translateLabel("Unlock selected"); ?>
		    </a>
		    <a class="btn btn-info" onclick="unlockAll()">
			<?php echo $translation->translateLabel("Unlock all"); ?>
		    </a>
		<?php endif; ?>
	    </div>
	</div>
    </div>
    <script>
     function unlockSelected(){
	 var itemData = $("#itemData");
	 $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "unlockSelected"); ?>", itemData.serialize(), null, 'json').success(function(data){
	     console.log(data);
	 })
	  .error(function(data){
	      console.log(data);
	  });
     }
     
     function unlockAll(){
	 var itemData = $("#itemData");
	 $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "unlockAll"); ?>", itemData.serialize(), null, 'json').success(function(data){
	     console.log(data);
	 })
	  .error(function(data){
	      console.log(data);
	  });
     }
    </script>
