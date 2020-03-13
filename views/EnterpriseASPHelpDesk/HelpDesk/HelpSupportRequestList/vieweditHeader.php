<?php
$item = $data->getEditItem($ascope["item"], "Main");
?>
<?php if($ascope["mode"] == 'edit' || $ascope["mode"] == 'view'): ?>
    <?php
        $header = $data->getEditItem($ascope["item"], "Main");
    ?>
    <div class="row">
        <style>
         .item-header-image {
             padding : 10px;
             width:150px;
             height:150px;
         }
         .item-header-label {
             font-size : 18pt;
             padding-top : 5px;
             font-weight : 500;
         }
        </style>
        <!-- <div class="col-md-2 col-lg-2">
             <img src="" class="item-header-image" />
             </div> -->
        <div class="col-md-6 col-lg-6" style="padding:10px;">
            <div class="item-header-label">
                <span class="glyphicon glyphicon-envelope"></span> <?php echo $item["CustomerId"]; ?>
            </div>
            <div class="item-header-label">
                <?php echo "12:30 02.03.2020"; ?>
            </div>
        </div>
    </div>
<?php endif; ?>
