<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('DisposalPost', { AssetID : '<?php echo $item["AssetID"]; ?>' }, true);">
    <?php 
    echo $translation->translateLabel("Dispose");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('DepreciationPost', { AssetID : '<?php echo $item["AssetID"]; ?>' }, true);">
    <?php 
    echo $translation->translateLabel("Depreciate");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('FixedAsset_Post', { AssetID : '<?php echo $item["AssetID"]; ?>' }, true);">
    <?php 
    echo $translation->translateLabel("Book Asset");
    ?>
</a>
