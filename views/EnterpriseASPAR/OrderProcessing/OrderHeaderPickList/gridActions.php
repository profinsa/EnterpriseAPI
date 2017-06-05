<script>
 function pickpSelectedOrders(){
     var orderNumbers = [], ind;

     for(ind in gridItemsSelected)
         orderNumbers.push(gridItemsSelected[ind].OrderNumber);

     $.post("index.php?page=grid&action=<?php  echo $scope->action;  ?>&procedure=Picked",{
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

 function pickAllOrders(){
     $.post("index.php?page=grid&action=<?php  echo $scope->action;  ?>&procedure=PickAll",{})
           .success(function(data) {
               onlocation(window.location);
           })
           .error(function(err){
               console.log(err);
               alert('Something goes wrong');
           });
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="pickpSelectedOrders()">
    <?php
	echo $translation->translateLabel("Pick Selected Orders");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="pickAllOrders()">
    <?php
	echo $translation->translateLabel("Pick All Orders");
    ?>
</a>
