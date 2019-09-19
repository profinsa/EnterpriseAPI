<!-- dialogAlert component, for same purpose as system alert -->
<div id="dialogAlert" class="modal fade  bs-example-modal-sm" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="dialogAlertTitle">
                    test
                </h4>
            </div>
            <div class="modal-body">
                <h4 id="dialogAlertMessage" style="text-align:center;">
                    test
                </h4>                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="dialogAlertOK">
                    <?php echo $translation->translateLabel("OK"); ?>
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
 function dialogAlert(title, message, cb){
     $("#dialogAlertTitle").html(title);
     $("#dialogAlertMessage").html(message);
     var dialog = $("#dialogAlert");
     dialog.modal("show");
     dialog.unbind('hidden.bs.modal');
     if(cb)
         dialog.on('hidden.bs.modal', cb);
 }
</script>
