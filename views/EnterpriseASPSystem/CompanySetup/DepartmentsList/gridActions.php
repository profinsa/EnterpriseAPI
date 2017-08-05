<div id="createDepartmentDialog" class="modal fade  bs-example-modal-sm" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
	<div class="modal-content">
	    <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">
		    <?php echo $translation->translateLabel("Create Department"); ?>
		</h4>
	    </div>
	    <div class="modal-body">
		<form>
		    <div class="form-group">
			<label for="departmentID" class="control-label">DepartmentID:</label>
			<input type="text" class="form-control" id="departmentID">
		    </div>
		</form>
	    </div>
	    <div class="modal-footer">
		<button type="button" class="btn btn-primary" data-dismiss="modal" id="createDepartment">
		    <?php echo $translation->translateLabel("Create"); ?>
		</button>
		<button type="button" class="btn btn-default" data-dismiss="modal">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</button>
	    </div>
	</div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
 $('#createDepartment').click(function(){
     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "CreateDepartment"); ?>", {
         "DepartmentID": $('#departmentID').val()
     })
      .success(function(data) {
          onlocation(window.location);
      })
      .error(function(xhr){
          alert(xhr.responseText);
      });
 });
 function createDepartment($orderNumber) {
     $('#createDepartmentDialog').modal('show');
}
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="createDepartment()">
    <?php
	echo $translation->translateLabel("Create Department");
    ?>
</a>
