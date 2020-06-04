<!-- 
     this is actions for FixedAssetsList page.
     only client side logic. Sending request to stored procedures and handling result
-->
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('Depreciation_PostAll', {}, true);">
    <?php
    echo $translation->translateLabel("Depreciate All");
    ?>
</a>
