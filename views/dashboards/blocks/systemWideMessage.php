<?php
    $systemWideMessages = $data->CompanySystemWideMessage();
?>
<div class="col-md-12 col-xs-12">
    <div class="white-box">
	<h3 class="box-title m-b-0"><?php echo $translation->translateLabel("System Wide Messages"); ?></h3>
	<!-- 	<p class="text-muted">this is the sample data</p> -->
	<div class="table-responsive">
	    <table class="table">
		<tbody>
		    <?php
			foreach($systemWideMessages as $row)
			echo "<tr><td>" . $row->SystemMessage . "</td>";
		    ?>
		</tbody>
	    </table>
	</div>
    </div>
</div>
