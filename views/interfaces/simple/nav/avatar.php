<div id="change-avatar-dialog" class="modal" tabindex="-1" role="dialog">
<div class="modal-dialog" role="document" style="display:table; width: 400px !important">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Change Avatar</h4>
    </div>
    <div class="modal-body">
        <div style="margin-top:10px;"></div>
        <form class="form-material form-horizontal m-t-30">
        <div class="row">
        <div class="col-md-6 col-xs-6">
            <img id="avatar_preview" class="img-responsive user-photo" src="<?php echo $user['PictureURL'] ? 'uploads\\' . $user['PictureURL'] : 'assets/images/avatar_2x.png'; ?>">
        </div>
        <div class="col-md-6 col-xs6">
            <!-- <input class="file_attachment" type="hidden" name="profile_image_input" id="profile_image_input" value="" /> -->
            <input onchange="previewAvatar(this);" type="file" id="avatar_attachment" name="avatar_attachment" class="form-control" value="" />
        </div>
        </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveAvatar()">
        <?php echo $translation->translateLabel("Save"); ?>
        </button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">
        <?php echo $translation->translateLabel("Cancel"); ?>
        </button>
    </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
    function changeAvatarOpen() {
        $('#change-avatar-dialog').appendTo('body').modal('show');
        var avatar = $('#avatar_attachment');
        avatar.val("");
        // $('#avatar_preview')
        //             .attr('src', "assets/images/avatar_2x.png")
        //             .width(176)
        //             .height(176);
    }
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#avatar_preview')
                    .attr('src', e.target.result)
                    .width(176)
                    .height(176);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
    function saveAvatar() {
        var attachments = $("input[type=file]");

        var formData = new FormData();

        formData.append('filename', "<?php echo $user["CompanyID"] ?>_<?php echo $user["DivisionID"] ?>_<?php echo $user["DepartmentID"] ?>_<?php echo $user["EmployeeID"] ?>");

        for (var i = 0; i < attachments.length; i++) {
        formData.append('file[]', attachments[i].files[0]);
        }
        $.ajaxSetup({
            headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
            });
        $.ajax({
        url : 'upload.php',
        type : 'POST',
        data : formData,
        processData: false,  // tell jQuery not to process the data
        contentType: false,  // tell jQuery not to set contentType
        success : function(e) {
            var res;
            res = JSON.parse(e).data;
            // var file_attachments = $(".file_attachment");
            $.post("<?php echo $linksMaker->makeProcedureLink("Payroll/EmployeeSetup/ViewEmployees", "changePictureURL"); ?>",{
                "PictureURL" : res[0],
            "EmployeeID" : "<?php echo $user["EmployeeID"] ?>",
            "CompanyID" : "<?php echo $user["CompanyID"] ?>",
            "DivisionID" : "<?php echo $user["DivisionID"] ?>",
            "DepartmentID" : "<?php echo $user["DepartmentID"] ?>"
            })
            .success(function(data) {
                // onlocation(window.location);
                $('#change-avatar-dialog').modal('hide');
                var timestamp = new Date().getTime();
                $('#mini_avatar')
                            .attr('src', "'uploads/'?>" + res[0] + '?' +timestamp );

            })
            .error(function(err){
                alert('Something goes wrong');
            });
            // for (var i = 0; i < res.length; i++) {
            //     file_attachments.val(res[i]);
            // }
            // }catch(e){
            // }
        }
        });
    }
</script>
