<a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="callDetailPrint(context.item)">
    <?php
        echo $translation->translateLabel("Print");
    ?>
</a>

<a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="callDetailEmail(context.item)">
    <?php
        echo $translation->translateLabel("Email");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["OrderNumber"]; ?>')">
    <?php
        echo $translation->translateLabel("Recalc");
    ?>
</a>
<?php if(!$headerItem["Posted"]): ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureAnyCall('<?php echo $ascope["path"]; ?>', 'Post', { OrderNumber : '<?php echo $headerItem["OrderNumber"]; ?>'}, function(){callRecalc('<?php echo $headerItem["OrderNumber"]; ?>');});">
        <?php
            echo $translation->translateLabel("Book Order");
        ?>
    </a>    
<?php else: ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('UnPost', { OrderNumber : '<?php echo $headerItem["OrderNumber"]; ?>'}, true);">
        <?php
            echo $translation->translateLabel("UnBook Order");
        ?>
    </a>
<?php endif; ?>


<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Memorize', { id : '<?php echo $ascope["item"]; ?>', Memorize : '<?php echo $headerItem["Memorize"]; ?>'}, true);">
    <?php
        if(!$headerItem["Memorize"])
            echo $translation->translateLabel("Memorize");
        else
            echo $translation->translateLabel("UnMemorize");
    ?>
</a>

