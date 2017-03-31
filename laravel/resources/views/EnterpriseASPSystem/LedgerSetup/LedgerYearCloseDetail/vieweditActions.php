<script>
 function closeYear(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/CloseYear",{})
         .success(function(data) {
             onlocation(window.location);
         })
         .error(function(err){
             alert("Something goes wrong");
         });
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="closeYear()">
    <?php 
    echo $translation->translateLabel("Close Year");
    ?>
</a>
