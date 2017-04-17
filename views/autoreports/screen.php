<h3 class="col-md-12">
    <?php echo $_GET["title"]; ?>
</h3>
<div class="table-responsive col-md-12">
    <?php
    $tableData = $data->getData();
    ?>
    <?php if(count($tableData)): ?>
	<table class="table table-bordered">
	    <thead>
		<tr>
		    <?php
		    foreach($tableData[0] as $key=>$value)
			echo "<th>" . $translation->translateLabel($key) . "</th>";
		    ?>
		</tr>
	    </thead>
	    <tbody>
		<?php
		foreach($tableData as $row){
		    echo "<tr>";
		    foreach($row as $key=>$value)
			echo "<td>" . $value . "</td>\n";
		    echo "</tr>\n";
		}
		?>
	    </tbody>
	</table>
    <?php endif; ?>
</div>

