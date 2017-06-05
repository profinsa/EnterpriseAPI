<script>
 function shipSelectedOrders(){
     var orderNumbers = [], ind;

     for(ind in gridItemsSelected)
         orderNumbers.push(gridItemsSelected[ind].OrderNumber);

     $.post("index.php?page=grid&action=<?php  echo $scope->action;  ?>&procedure=Shipped",{
             "OrderNumbers" : orderNumbers.join(',')
      })
           .success(function(data) {
               onlocation(window.location);
           })
           .error(function(err){
               console.log(err);
               alert('Something goes wrong');
           });
 }

 function shipAllOrders(){
     $.post("index.php?page=grid&action=<?php  echo $scope->action;  ?>&procedure=ShipAll",{})
           .success(function(data) {
               onlocation(window.location);
           })
           .error(function(err){
               console.log(err);
               alert('Something goes wrong');
           });
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="shipSelectedOrders()">
    <?php
	echo $translation->translateLabel("Ship Selected Orders");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="shipAllOrders()">
    <?php
	echo $translation->translateLabel("Ship All Orders");
    ?>
</a>
