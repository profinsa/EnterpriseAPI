<?php
    $prefferedProducts = $data->adminGetPrefferedProducts();
?>
<div class="white-box">
    <h3 class="box-title"><?php echo $translation->translateLabel("Preffered Products"); ?></h3>
    <div id="preffered-products-chart" class="ecomm-donute" style="height: 317px;"></div>
    <ul class="list-inline m-t-30 text-center">
        <?php
            $colors = ["#0074D9", "#FF4136", "#2ECC40", "#FF851B", "#7FDBFF", "#B10DC9", "#FFDC00", "#001f3f", "#39CCCC", "#01FF70", "#85144b", "#F012BE", "#3D9970", "#111111", "#AAAAAA"];
            while (true) {
                $colors[] = '#' . substr(str_shuffle('ABCDEF0123456789'), 0, 6);
                if(count($colors) == 10000)
                    break;
            }
            $colorInd = 0;
            
            foreach($prefferedProducts as $row)
            echo "<li class=\"p-r-20\"><h5 class=\"text-muted\"><i class=\"fa fa-circle\" style=\"color: " . $colors[$colorInd++] . ";\"></i>" . $row["name"]  ."</h5><h4 class=\"m-b-0\">" . formatField(["format"=>"{0:n}"], $row["numbers"]) . "</h4></li>";

        ?>
    </ul>
</div>
<script> 
 Morris.Donut({
     element: 'preffered-products-chart',
     data: [
         <?php
             foreach($prefferedProducts as $row)
             echo "{ label : \"" . $row["name"] . "\", value : \"" .  $row["numbers"] . "\"},";
         ?>
     ],
     resize: true,
     colors: <?php echo json_encode($colors); ?>
 });
</script>
