<script>
 function Inventory_Transfer(){
     serverProcedureCall('Inventory_Transfer', getCurrentPageValues(), true);
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="Inventory_Transfer()">
    <?php
	echo $translation->translateLabel("Transfer");
    ?>
</a>

