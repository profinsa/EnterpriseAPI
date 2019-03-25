<script>
function CreateAssembly(){
    $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "CreateAssembly"); ?>",{
        "ItemID" : "<?php echo $item["AssemblyID"]; ?>",
        "QtyRequired" : "<?php echo $item["NumberOfItemsInAssembly"]; ?>",
        "WarehouseID" : "<?php echo $item["WarehouseID"]; ?>"
    })
    .success(function(data) {
        onlocation(window.location);
    })
    .error(function(err){
        alert(err.responseText);
    });
}

</script>
<a class="btn btn-info" href="javascript:;" onclick="CreateAssembly()">
    <?php
	echo $translation->translateLabel("Create Assembly");
    ?>
</a>
