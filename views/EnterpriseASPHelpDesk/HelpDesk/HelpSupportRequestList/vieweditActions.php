<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Resolve', { id : '<?php echo $ascope["item"]; ?>', SupportStatus : '<?php echo $item["SupportStatus"]; ?>'}, true);">
    <?php
        if($item["SupportStatus"] != "Resolved")
            echo $translation->translateLabel("Resolve");
        else
            echo $translation->translateLabel("Reopen");
    ?>
</a>
