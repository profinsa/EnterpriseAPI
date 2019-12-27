<div id="createCompanyDialog" class="modal fade  bs-example-modal-sm" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">
                    <?php echo $translation->translateLabel("Create Company"); ?>
                </h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="companyID" class="control-label">CompanyID:</label>
                        <input type="text" class="form-control" id="companyID">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="createCompany">
                    <?php echo $translation->translateLabel("Create"); ?>
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <?php echo $translation->translateLabel("Cancel"); ?>
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="renameCompanyDialog" class="modal fade  bs-example-modal-sm" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">
                    <?php echo $translation->translateLabel("Rename Company"); ?>
                </h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="companyID" class="control-label">New CompanyID:</label>
                        <input type="text" class="form-control" id="newCompanyID">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="renameCompany">
                    <?php echo $translation->translateLabel("Rename"); ?>
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <?php echo $translation->translateLabel("Cancel"); ?>
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
 $('#createCompany').click(function(){
     serverProcedureCall('CreateCompany', {
         "CompanyID": $('#companyID').val()
     }, true, undefined, true);
 });
 
 function createCompany() {
     $('#createCompanyDialog').modal({
         backdrop: 'static',
         keyboard: false
     });
 }
 
 function companyRename(CompanyID){
     $('#renameCompanyDialog').modal({
         backdrop: 'static',
         keyboard: false
     });
 }

 $('#renameCompany').click(function(){
     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "RenameCompany"); ?>", {
         "CompanyID": $('#newCompanyID').val()
     })
      .success(function(data) {
          //   alert(data);
          window.location.reload();
      })
      .error(function(xhr){
          alert(xhr.responseText);
      });
 });

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="createCompany()">
    <?php
        echo $translation->translateLabel("Create Company");
    ?>
</a>
