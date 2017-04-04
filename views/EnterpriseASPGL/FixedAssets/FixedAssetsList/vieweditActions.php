<script>
 function disposeClicked(){
     $.post("index.php?page=grid&action=<?php echo $scope->action;  ?>&procedure=DisposalPost",{
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
     $.post("index.php?page=grid&action=<?php echo $scope->action;  ?>&procedure=DepreciationPost",{
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
     $.post("index.php?page=grid&action=<?php echo $scope->action;  ?>&procedure=FixedAsset_Post",{
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
