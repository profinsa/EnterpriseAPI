<script>
 var ordersByDate = {};
 function calendarOnSelect(start, end){
     if(ordersByDate.hasOwnProperty(datetimeToISO(start._d)))
         location.href = "<?php echo $linksMaker->makeGridLink("AccountsPayable/PurchaseScreens/ViewPurchases"); ?>" + "&ShipDate=" + datetimeToISO(start._d);
     else
         location.href = "<?php echo $linksMaker->makeGridLink("Payroll/EmployeeSetup/ViewTaskList"); ?>" + "&from=" + datetimeToISO(start._d);
     //     console.log(start._d,end);
 }
 function calendarOnClick(calEvent, jsEvent, view){
     //console.log(calEvent.start._i);
     location.href = "<?php echo $linksMaker->makeGridLink("AccountsPayable/PurchaseScreens/ViewPurchases"); ?>" + "&ShipDate=" + calEvent.start._i;
 }
 function calendarDataSource(){
     var orders = <?php echo json_encode($data->getReceivingsForCalendar(), JSON_PRETTY_PRINT); ?>,
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
    $calendarTitle = "Receiving Calendar";
    require __DIR__ . "/../calendar.php";
?>
