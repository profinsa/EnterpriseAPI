<script>
 function disposeClicked(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/DisposalPost",{
	 "AssetID" : "<?php echo $item["AssetID"]; ?>"
     })
      .success(function(data) {
	  onlocation(window.location);
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
	  onlocation(window.location);
      })
      .error(function(err){
	  alert("Something goes wrong");
      });
 }
 function bookassetClicked(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/FixedAsset_Post",{
	 "AssetID" : "<?php echo $item["AssetID"]; ?>"
     })
      .success(function(data) {
	  onlocation(window.location);
      })
      .error(function(err){
	  alert("Something goes wrong");
      });
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
