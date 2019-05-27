<?php
    $companyStatus = $data->CompanyAccountsStatus();
?>
<div class="white-box">
    <h3 class="box-title"><?php echo $translation->translateLabel("Company Status"); ?></h3>
    <div id="morris-donut-chart" class="ecomm-donute" style="height: 317px;"></div>
    <ul class="list-inline m-t-30 text-center">
	<?php
	    $colors = ["#0074D9", "#FF4136", "#2ECC40", "#FF851B", "#7FDBFF", "#B10DC9", "#FFDC00", "#001f3f", "#39CCCC", "#01FF70", "#85144b", "#F012BE", "#3D9970", "#111111", "#AAAAAA"];
	    while (true) {
		$colors[] = '#' . substr(str_shuffle('ABCDEF0123456789'), 0, 6);
		if(count($colors) == 10000)
		    break;
	    }
	    $colorInd = 0;
	    
	    foreach($companyStatus as $row)
	    echo "<li class=\"p-r-20\"><h5 class=\"text-muted\"><i class=\"fa fa-circle\" style=\"color: " . $colors[$colorInd++] . ";\"></i>" . $row->GLAccountName  ."</h5><h4 class=\"m-b-0\">" . formatField(["format"=>"{0:n}"], $row->Totals) . "</h4></li>";

	?>
    </ul>
</div>
