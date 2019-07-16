<script>
 var context = {
     <?php if(isset($ascope) && key_exists("path", $ascope)): ?>
     headerItems : <?php echo json_encode(property_exists($data, "editCategories") && key_exists("...fields", $data->editCategories) ?
                                          ($ascope["mode"] == 'edit' || $ascope["mode"] == 'view' ?
                                           $data->getEditItem($ascope["item"], "...fields") :
                                           $data->getNewItem($ascope["item"], "...fields" )) : []
                                        , JSON_PRETTY_PRINT); ?>,
     path : "<?php echo $ascope["path"]; ?>",
     data :  <?php echo json_encode($data, JSON_PRETTY_PRINT); ?>,
     item : "<?php echo $ascope["item"]; ?>",
     screenId : "<?php echo $ascope["path"]; ?>",
     <?php else: ?>
     path : "",
     screenId : "default"
     <?php endif; ?>
 };
</script>
 
