<?php
$user = $data->getUser();
?>
<div class="col-md-9 col-xs-9">
    <table class="col-md-12 col-xs-12">
	<tr>
	    <td rowspan="3" style="width:10%">
		<img src="<?php echo  $user["company"]->CompanyLogoUrl;?>">
	    </td>
	    <td style="width:60%; font-size:16pt; font-weight:bold;">
		<?php echo  $user["company"]->CompanyName;?>
	    </td>
	</tr>
	<tr>
	    <td style="width:60%">
		<?php echo  $user["company"]->DivisionID . " / " . $user["company"]->DepartmentID;?>
	    </td>
	</tr>
	<tr>
	    <td style="width:60%">
		Executed By Demo on <?php echo date('m/d/Y'); ?>
	    </td>
	</tr>
    </table>
</div>
