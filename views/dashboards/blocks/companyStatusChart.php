<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Company Status"); ?></h3>
    <!-- 		    <p class="text-muted">this is the sample data</p> --> 
    <div class="table-responsive">
	<table class="table">
	    <thead>
		<tr>
		    <th><?php echo $translation->translateLabel("Account Type"); ?></th>
		    <th><?php echo $translation->translateLabel("Account Name"); ?></th>
		    <th><?php echo $translation->translateLabel("Account Totals"); ?></th>
		</tr>
	    </thead>
	    <tbody>
		<?php
		    foreach($companyStatus as $row)
		    echo "<tr><td>" . $row->GLAccountType . "</td><td>" . $drill->getLinkByAccountNameAndAccountType($row->GLAccountName,$row->GLAccountType)  . "</td><td>" . formatField(["format"=>"{0:n}"], $row->Totals) . "</td></tr>";
		?>
	    </tbody>
	</table>
    </div>
</div>
<script> 
 Morris.Donut({
     element: 'morris-donut-chart',
     data: [
	 <?php
	     foreach($companyStatus as $row)
	     echo "{ label : \"" . $row->GLAccountName . "\", value : \"" .  $row->Totals . "\"},";
	 ?>
     ],
     resize: true,
     colors: <?php echo json_encode($colors); ?>
 });
</script>
