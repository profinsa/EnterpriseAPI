<script>
 function memorizeClicked(){
     alert('memorized');
     /*     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/Memorize",{
	"GLTransactionNumber" : "haha",
	lom : 12
	})
	.success(function(data) {
	onlocation(window.location);
	//	  alert("Memorized");
	})
	.error(function(err){
	console.log('wrong');
	});*/
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
