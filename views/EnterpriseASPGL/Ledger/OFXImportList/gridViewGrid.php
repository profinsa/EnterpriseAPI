<!--
     Name of Page: grid

     Method: renders content of screen in grid mode. 

     Date created: Nikita Zaharov, 09.26.2017

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

     Last Modified: 09.26.2017
     Last Modified by: Nikita Zaharov
   -->

<!-- grid -->

<div id="grid_content" class="row">
    <h3 class="box-title m-b-0"><?php echo $data->dashboardTitle ?></h3>
    <p class="text-muted m-b-30"><?php echo $data->dashboardTitle ?></p>
    <div class="col-md-12">
	<form id="itemData" class="form-material form-horizontal m-t-30">
	    <input type="hidden" name="id" value="<?php echo $ascope["item"]; ?>" />
	    <input type="hidden" name="category" value="<?php echo $ascope["category"]; ?>" />
	    <div class="form-group">
		<label class="col-md-6">
		    <?php echo $translation->translateLabel("OFX OR QFX File"); ?>	
		</label>
		<div class="col-md-6">
		    <input class="form-control" name="ofx" type="file" />
		</div>
	    </div>
	</form>
	<div class="col-md-12 col-xs-12 row">
	    <div  style="margin-top:10px" class="pull-right">
		<!--
		     renders buttons translated Save and Cancel using translation model
		   -->
		<?php if($security->can("update")): ?>
		    <a class="btn btn-info" onclick="uploadOFX()">
			<?php echo $translation->translateLabel("Upload File"); ?>
		    </a>
		<?php endif; ?>
	    </div>
	</div>
    </div>
</div>
<script>
 function uploadOFX(){
     var attachments = $("input[type=file]");

     var formData = new FormData();

     for (var i = 0; i < attachments.length; i++) {
	 formData.append('ofx', attachments[i].files[0]);
     }

     $.ajax({
	 url : '<?php echo $linksMaker->makeProcedureLink($ascope["path"], "uploadOFX"); ?>',
	 type : 'POST',
	 data : formData,
	 processData: false,  // tell jQuery not to process the data
	 contentType: false,  // tell jQuery not to set contentType
	 success : function(e) {
	     alert("OFX data is loaded");
	     //console.log(e.data);
	 }
     });
 }
</script>
