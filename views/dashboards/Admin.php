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
                <?php require "blocks/Admin/customersStatus.php"; ?>
            </div>
        </div>
        <!--row -->
        <div class="row">
            <div class="col-md-5">
                <div>
                    <div>
                        <?php require "blocks/Admin/prefferedProducts.php"; ?>
                        <?php require "blocks/Admin/monthlyIncome.php"; ?>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div>
                    <div>
                        <?php require "blocks/Admin/applicationsPerYear.php"; ?>
                        <?php require "blocks/Admin/receivablePayable.php"; ?>
                        <?php //require "blocks/Admin/currentLogins.php"; ?>
                     </div>
                </div>
            </div>
        </div>
    </div>
</div>
