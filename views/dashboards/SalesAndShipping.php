<div class="container-fluid">
    <?php
	if($ascope["interface"] == "default")
	    require './views/uiItems/dashboard.php';
	else
	    require __DIR__ . '/../interfaces/' . $ascope["interface"] . '/breadcrumbs.php';
	require __DIR__ . '/../format.php';
    ?>

    <div style="<?php echo $ascope["interface"] == "simple" ? "background-color:#e8eced; padding:15px" : ""; ?>">
	<div class="row">
	    <?php require "blocks/systemWideMessage.php"; ?>
	    <!--row -->
	</div>
	<div class="row">
	    <div class="col-md-6">
		<div>
		    <div>
 			<?php
			    require "blocks/calendar.php";
			?>
		    </div>
		</div>
	    </div>
	    <div class="col-md-6">
		<div>
		    <div>
			<?php require "blocks/topOrders.php"; ?>
 			<?php require "blocks/todayTasks.php"; ?>
 			<?php require "blocks/leadFollowUp.php"; ?>
		    </div>
		</div>
	    </div>
	</div>
    </div>
