<div id="dialogSaveToStored" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" style="display:table;">
	<div class="modal-content">
	    <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title"><?php echo $translation->translateLabel("The create Stored Account"); ?></h4>
	    </div>
	    <div class="modal-body">
		<form>
		    <div class="form-group">
			<label for="pass1" class="control-label"><?php echo $translation->translateLabel("Industry"); ?>:</label>
			<input type="text" class="form-control" id="Industry">
		    </div>
		    <div class="form-group">
			<label for="pass1" class="control-label"><?php echo $translation->translateLabel("Chart Type"); ?>:</label>
			<input type="text" class="form-control" id="ChartType">
		    </div>
		    <div class="form-group">
			<label for="pass2" class="control-label"><?php echo $translation->translateLabel("Chart Description"); ?>:</label>
			<input type="text    " class="form-control" id="ChartDescription">
		    </div>
		</form>
	    </div>
	    <div class="modal-footer">
		<button type="button" class="btn"onclick="dialogCopy()">
		    <?php echo $translation->translateLabel("Copy"); ?>
		</button>
		<button type="button" class="btn btn-primary" data-dismiss="modal">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</button>
	    </div>
	</div>
    </div>
</div>
<script>
 var oldGLAccountNumber;
 function dialogCopy(){
     $('#dialogSaveToStored').modal('hide');
     
     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "SaveToStored"); ?>",{
	 "GLAccountNumber" : oldGLAccountNumber,
         "Industry" : $("#Industry").val(),
	 "ChartType" : $("#ChartType").val(),
	 "ChartDescription" : $("#ChartDescription").val()
     })
      .success(function(data) {
          onlocation(window.location);
      })
      .error(function(xhr){
          alert(xhr.responseText);
      });
 }
 
 function saveToStored(GLAccountNumber){
     oldGLAccountNumber = GLAccountNumber;
     $('#Industry').val('');
     $('#ChartType').val('');
     $('#ChartDescription').val('');
     $('#dialogSaveToStored').modal('show');
 }
</script>

