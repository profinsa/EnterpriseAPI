<script>
/*
  this is actions for FixedAssetsList page.
  only client side logic. Sending request to stored procedures and handling result
 */
 function depreciateAll(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/Depreciation_PostAll",{})
      .success(function(data) {
          onlocation(window.location);
      })
      .error(function(err){
          alert('Something goes wrong');
      });
 }
</script>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="depreciateAll()">
    <?php
    echo $translation->translateLabel("Depreciate All");
    ?>
</a>
