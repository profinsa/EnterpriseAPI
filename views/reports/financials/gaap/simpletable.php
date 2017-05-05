<table class="col-md-12 col-xs-12 table-striped">
    <thead>
        <tr class="row-header">
	    <?php if(count($currentGridData)): ?>
		<?php
		foreach($currentGridData[0] as $key=>$item)
		    echo "<th style=\"border-right:1px solid white; text-align:center\">$key</th>";
		?>
	    <?php else: ?>
		<th></th>
	    <?php endif; ?>
	</tr>
    </thead>
    <tbody>
	<?php if(count($currentGridData)): ?>
	    <?php 
	    foreach($currentGridData as $row){
		echo "<tr style=\"height:10px;\">";
		foreach($row as $key=>$item)
		    echo "<td>" . $drill->getLinkByField($key,$item) . "</td>";
		echo "</tr>";
	    }
	    ?>
	<?php else: ?>
	    <tr style="height:10px;">
		<td colspan="8" style="text-align:center;">
		    There is no records available.
		</td>
	    </tr>
	<?php endif; ?>
    </tbody>
</table>
