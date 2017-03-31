<script>
 function closePeriod(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/ClosePeriod",{})
         .success(function(data) {
             onlocation(window.location);
         })
         .error(function(err){
             alert("Something goes wrong");
         });
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="closePeriod()">
    <?php 
    echo $translation->translateLabel("Close Period");
    ?>
</a>
