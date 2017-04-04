<script>
 function closeYear(){
     $.post("index.php?page=grid&action=<?php  echo $scope->action ;  ?>&procedure=CloseYear",{})
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
