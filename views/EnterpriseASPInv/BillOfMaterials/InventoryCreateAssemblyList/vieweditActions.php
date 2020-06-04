<script>
 function CreateAssembly(){
     //console.log(JSON.stringify(getCurrentPageValues(), null, 3));
     var currentValues = getCurrentPageValues();
     serverProcedureCall('CreateAssembly', {
         "ItemID" : currentValues.AssemblyID,
         "QtyRequired" : currentValues.NumberOfItemsInAssembly,
         "WarehouseID" : currentValues.WarehouseID
     }, true);     
 }

</script>
<a class="btn btn-info" href="javascript:;" onclick="CreateAssembly()">
    <?php
	echo $translation->translateLabel("Create Assembly");
    ?>
</a>
