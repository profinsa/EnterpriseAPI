<script>
 function memorizeClicked(){
     $.post("index.php?page=grid&action<?php  echo $scope->action ;  ?>&procedure=true&name=Memorize",{
         "id" : "<?php echo $scope->item; ?>",
	 "Memorize" : "<?php echo $item["Memorize"]; ?>"
      })
         .success(function(data) {
             onlocation(window.location);
         })
         .error(function(xhr){
             alert(xhr.responseText);
         });
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="memorizeClicked()">
    <?php
    if(!$item["Memorize"])
	echo $translation->translateLabel("Memorize");
    else
	echo $translation->translateLabel("UnMemorize");
    ?>
</a>
