<script>
 function memorizeClicked(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/Memorize",{
	 "id" : "<?php echo $scope["item"]; ?>",
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
