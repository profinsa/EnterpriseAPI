<script>
 function Inventory_Transfer(){
     console.log(JSON.stringify(getCurrentPageValues(), null, 3));
     serverProcedureCall('Inventory_Transfer', getCurrentPageValues(), true);
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="Inventory_Transfer()">
    <?php
	echo $translation->translateLabel("Transfer");
    ?>
</a>

