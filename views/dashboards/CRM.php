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
                <?php require "blocks/CRM/status.php"; ?>
            </div>
        </div>
        <!--row -->
        <div class="row">
            <div class="col-md-6">
                <div>
                    <div>
                        <?php require "blocks/top10Leads.php"; ?>
                        <?php require "blocks/companyDailyActivity.php"; ?>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div>
                    <div>
                        <?php require "blocks/Customer/receivables.php"; ?>
                        <?php require "blocks/top10OrdersInvoices.php"; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
