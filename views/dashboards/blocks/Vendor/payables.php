<?php
    $vendorReceivables = $data->vendorReceivables();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Payables"); ?></h3>
    <div id="vendor-receivables-chart" class="ecomm-donute" style="height: 317px;"></div>
    <ul class="list-inline m-t-30 text-center">
	<?php
	    $colors = ["#0074D9", "#FF4136", "#2ECC40", "#FF851B", "#7FDBFF", "#B10DC9", "#FFDC00", "#001f3f", "#39CCCC", "#01FF70", "#85144b", "#F012BE", "#3D9970", "#111111", "#AAAAAA"];
	    while (true) {
		$colors[] = '#' . substr(str_shuffle('ABCDEF0123456789'), 0, 6);
		if(count($colors) == 10000)
		    break;
	    }
	    $colorInd = 0;
	    
	    foreach($vendorReceivables as $row)
	    echo "<li class=\"p-r-20\"><h5 class=\"text-muted\"><i class=\"fa fa-circle\" style=\"color: " . $colors[$colorInd++] . ";\"></i>" . $row["FieldName"]  ."</h5><h4 class=\"m-b-0\">" . formatField(["format"=>"{0:n}"], $row["Totals"]) . "</h4></li>";

	?>
    </ul>
</div>
<script> 
 Morris.Donut({
     element: 'vendor-receivables-chart',
     data: [
         <?php
             foreach($vendorReceivables as $row)
             echo "{ label : \"" . $row["FieldName"] . "\", value : \"" .  $row["Totals"] . "\"},";
         ?>
     ],
     resize: true,
     colors: <?php echo json_encode($colors); ?>
 });
</script>
