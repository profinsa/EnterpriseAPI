<div class="container-fluid">
    <?php
        if($ascope["interfaces"]["description"][$ascope["interface"]]["interface"] == "default")
            require './views/uiItems/dashboard.php';
        else
            require __DIR__ . '/../interfaces/' . $ascope["interfaces"]["description"][$ascope["interface"]]["interface"] . '/breadcrumbs.php';
        require __DIR__ . '/../format.php';
    ?>

    <div style="<?php echo $ascope["interfaces"]["description"][$ascope["interface"]]["interface"] == "simple" ? "background-color:#e8eced; padding:15px" : ""; ?>">
        <div class="row">
	    <div class="col-md-12">
	        <div>
                    <?php require "blocks/todayTasks.php"; ?>
	        </div>
	    </div>
        </div>
    </div>
</div>
