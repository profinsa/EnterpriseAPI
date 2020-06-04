<script>
 var ordersByDate = {};
 function shipmentsCalendarOnSelect(start, end){
     if(ordersByDate.hasOwnProperty(datetimeToISO(start._d)))
         location.href = "<?php echo $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders"); ?>" + "&ShipDate=" + datetimeToISO(start._d);
     else
         location.href = "<?php echo $linksMaker->makeGridLink("Payroll/EmployeeSetup/ViewTaskList"); ?>" + "&from=" + datetimeToISO(start._d);
     //     console.log(start._d,end);
 }   
 function shipmentsCalendarOnClick(calEvent, jsEvent, view){
     //console.log(calEvent.start._i);
     //console.log("<?php echo $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrdersByShipDate"); ?>" + "&ShipDate=" + calEvent.start._i);
     location.href = "<?php echo $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders"); ?>" + "&ShipDate=" + calEvent.start._i;
 }
 function shipmentsCalendarDataSource(){
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
    $calendarOnSelect = "shipmentsCalendarOnSelect";
    $calendarOnClick = "shipmentsCalendarOnClick";
    $calendarDataSource = "shipmentsCalendarDataSource";
    $calendarTitle = "Shipments Calendar";
    $calendarPrefix = 'Shipments';
    require __DIR__ . "/../calendar.php";
?>
