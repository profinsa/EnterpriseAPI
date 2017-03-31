<script>
 function disposeClicked(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/DisposalPost",{
	 "AssetID" : "<?php echo $item["AssetID"]; ?>"
     })
      .success(function(data) {
	  //	  onlocation(window.location);
      })
      .error(function(err){
	  alert("Something goes wrong");
      });
 }
 function depreciateClicked(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/DepreciationPost",{
	 "AssetID" : "<?php echo $item["AssetID"]; ?>"
     })
      .success(function(data) {
	  //	  onlocation(window.location);
      })
      .error(function(err){
	  alert("Something goes wrong");
      });
 }
 function bookassetClicked(){
     alert('depreciate');
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
<a class="btn btn-info" href="javascript:;" onclick="disposeClicked()">
    <?php 
    echo $translation->translateLabel("Dispose");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="depreciateClicked()">
    <?php 
    echo $translation->translateLabel("Depreciate");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="bookassetClicked()">
    <?php 
    echo $translation->translateLabel("Book Asset");
    ?>
</a>
