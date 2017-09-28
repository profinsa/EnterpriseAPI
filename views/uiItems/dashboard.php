<div class="row bg-title">
    <div class="col-md-8">
	<h4 class="page-title"><?php echo $scope->dashboardTitle ?></h4>
	<?php if(isset($ascope) && key_exists("mode", $ascope) && isset($data) && method_exists($data, "lockedBy") &&  $ascope["mode"] == "view"): ?>
	    <?php
	    $lockedBy = $data->lockedBy($ascope["item"]);
	    ?>
	    <?php if($lockedBy): ?>
		<h5 class="page-title" style="display: inline-block; float: right; color: red;">
		    Locked By <?php echo $lockedBy->LockedBy; ?> at <?php echo $lockedBy->LockTS; ?>
		</h5>
	    <?php endif; ?>
	<?php endif; ?>
    </div>
    <div class="col-md-6 pull-right">
	<ol class="breadcrumb">
	    <li><a href="index.php#/?page=dashboard&category=GeneralLedger">Dashboard</a></li>
	    <li class="active"><?php echo $scope->breadCrumbTitle ?></li>
	</ol>
    </div>
    <!-- /.col-lg-12 -->
</div>
