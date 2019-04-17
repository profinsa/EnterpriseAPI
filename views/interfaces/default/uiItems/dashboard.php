<div class="row bg-title">
    <div class="col-md-8">
	<div class="col-md-6 page-title" style="font-size:13pt; font-weight:400"><?php echo $scope->dashboardTitle ?></div>
	<?php if(isset($ascope) && key_exists("mode", $ascope) && isset($data) && method_exists($data, "lockedBy") &&  $ascope["mode"] == "view"): ?>
	    <?php
		$lockedBy = $data->lockedBy($ascope["item"]);
	    ?>
	    <?php if($lockedBy): ?>
		<div class="col-md-6 page-title" style="display: inline-block; float: right; color: red;">
		    Locked By <?php echo $lockedBy->LockedBy; ?> at <?php echo $lockedBy->LockTS; ?>
		</div>
	    <?php endif; ?>
	<?php endif; ?>
    </div>
    <div class="col-md-4 pull-right">
	<ol class="breadcrumb" style="margin-top:0px">
	    <li><a href="index.php#/?page=dashboard&category=GeneralLedger">Dashboard</a></li>
	    <li class="active"><?php echo $scope->breadCrumbTitle ?></li>
	</ol>
    </div>
    <!-- /.col-lg-12 -->
</div>
