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
            <div class="item-header-label" style="padding-left:20px;">
                From: <a href="mailto:<?php echo $item["CustomerId"]; ?>"><?php echo $item["CustomerId"]; ?></a>
            </div>
            <div class="item-header-label" style="padding-left:20px; padding-bottom:10px">
                Request ID: <?php echo $item["UniqID"]; ?></a>
            </div>
        </div>
    </div>
<?php endif; ?>
