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
            <div class="row">
                <div class="col-md-12">
                    <?php require "blocks/Sales/status.php"; ?>
                </div>
            </div>
            <div class="col-md-6">
                <div>
                    <div>
                        <script>
                         var ordersByDate = {};
                         function calendarOnSelect(start, end){
                             if(ordersByDate.hasOwnProperty(datetimeToISO(start._d)))
                                 location.href = "<?php echo $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders"); ?>" + "&ShipDate=" + datetimeToISO(start._d);
                             else
                                 location.href = "<?php echo $linksMaker->makeGridLink("Payroll/EmployeeSetup/ViewTaskList"); ?>" + "&from=" + datetimeToISO(start._d);
                             //     console.log(start._d,end);
                         }   
                         function calendarOnClick(calEvent, jsEvent, view){
                             //console.log(calEvent.start._i);
                             //console.log("<?php echo $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrdersByShipDate"); ?>" + "&ShipDate=" + calEvent.start._i);
                             location.href = "<?php echo $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders"); ?>" + "&ShipDate=" + calEvent.start._i;
                         }
                         function calendarDataSource(){
                             var orders = <?php echo json_encode($data->getShipmentsForCalendar(), JSON_PRETTY_PRINT); ?>,
                                 ind, ordersCounters = {}, shipDate;
                             for(ind in orders){
                                 shipDate = datetimeToISO(orders[ind].ShipDate);
                                 if(ordersCounters.hasOwnProperty(shipDate))
                                     ordersCounters[shipDate]++;
                                 else
                                     ordersCounters[shipDate] = 1;
                             }

                             orders = [];
                             for(ind in ordersCounters)
                                 orders.push({
                                     title : ordersCounters[ind],
                                     start : ind,
                                     end : ind
                                 });
                             ordersByDate = ordersCounters;
                             return orders;
                         }
                        </script>
                        <?php
                            $calendarTitle = "Shipments Calendar";
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
</div>
