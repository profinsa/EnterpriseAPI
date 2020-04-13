<script>
 function postClicked(){
     if("<?php echo $ascope["mode"]; ?>" == "new"){
	 alert("<?php echo $translation->translateLabel("Please save Transaction!"); ?>");
	 return;
     }
     
     $.post("index.php?page=grid&action=<?php  echo $scope->path ;  ?>&procedure=PostManual",{
         "GLTransactionNumber" : "<?php echo $item["GLTransactionNumber"]; ?>"
     })
      .success(function(data) {
	  onlocation(window.location);
      })
      .error(function(xhr){
	  alert(xhr.responseText);
      });
 }
 
 function memorizeClicked(){
     if("<?php echo $ascope["mode"]; ?>" == "new"){
	 alert("<?php echo $translation->translateLabel("Please save Transaction!"); ?>");
	 return;
     }
     
     $.post("index.php?page=grid&action=<?php  echo $scope->path ;  ?>&procedure=Memorize",{
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
<a class="btn btn-info" href="javascript:;" onclick="postClicked()">
    <?php echo $translation->translateLabel("Post"); ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="memorizeClicked()">
    <?php
    if(!$item["Memorize"])
	echo $translation->translateLabel("Memorize");
    else
	echo $translation->translateLabel("UnMemorize");
    ?>
</a>
