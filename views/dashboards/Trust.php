<div class="container-fluid">
    <?php
        if($ascope["interfaces"]["description"][$ascope["interface"]]["interface"] == "default")
            require './views/uiItems/dashboard.php';
        else
            require __DIR__ . '/../interfaces/' . $ascope["interfaces"]["description"][$ascope["interface"]]["interface"] . '/breadcrumbs.php';
        require __DIR__ . '/../format.php';
    ?>

    <div style="<?php echo $ascope["interfaces"]["description"][$ascope["interface"]]["interface"] == "simple" ? "background-color:#e8eced; padding:15px" : ""; ?>">
        <!--row -->
        <div class="row">
            <div class="col-md-12">
                <?php require "blocks/Trust/status.php"; ?>
            </div>
            <div class="col-md-8">
                <div>
                    <div>
                        <?php require "blocks/companyStatusTable.php"; ?>
                        <?php require "blocks/companyStatusChart.php"; ?>
                        <?php require "blocks/topOrdersReceipts.php"; ?>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div>
                    <div>
                        <?php require "blocks/companyDailyActivity.php"; ?>
                        <?php require "blocks/todayTasks.php"; ?>
                        <?php require "blocks/leadFollowUp.php"; ?>
                        <?php require "blocks/collectionsAllerts.php"; ?>
                        <?php require "blocks/helpRequests.php"; ?>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <?php require "blocks/systemWideMessage.php"; ?>
        </div>
    </div>
</div>
