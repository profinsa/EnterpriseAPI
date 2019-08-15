<?php
    $rows = [
        [
            "new" => 5,
            "expiring" => 10,
            "expired" => 2
        ]
    ];
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Customers Status"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("New Customers"); ?></th>
                    <th><?php echo $translation->translateLabel("Expiring Customers"); ?></th>
                    <th><?php echo $translation->translateLabel("Expired Customers"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($rows as $row){
                        echo "<tr><td>{$row["new"]}</td><td>{$row["expiring"]}</td><td>{$row["expired"]}</td></tr>";
                    }
                ?>
            </tbody>
        </table>
    </div>
</div>
