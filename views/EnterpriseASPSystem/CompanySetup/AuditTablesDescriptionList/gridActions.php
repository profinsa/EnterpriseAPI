<script>
/*
  this is actions for AuditTablesDescription page.
  only client side logic. Sending request to stored procedures and handling result
 */
 function regenerateSelectedTriggers(){
     var tableNames = [], ind;
     for(ind in gridItemsSelected)
         tableNames.push(gridItemsSelected[ind].TableName);

     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "RegenerateSelectedTriggers"); ?>",{
             "TableNames" : tableNames.join(',')
      })
           .success(function(data) {
               onlocation(window.location);
           })
           .error(function(err){
               alert('Something goes wrong');
           });
 }

 function regenerateAllTriggers(){
     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "RegenerateAllTriggers"); ?>",{})
           .success(function(data) {
               onlocation(window.location);
           })
           .error(function(err){
               alert('Something goes wrong');
           });
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="regenerateSelectedTriggers()">
    <?php
	echo $translation->translateLabel("Regenerate Selected Triggers");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="regenerateAllTriggers()">
    <?php
	echo $translation->translateLabel("Regenerate All Triggers");
    ?>
</a>
