<?php
    $rows = [
        [
            "real" => "15,000.00",
            "projected" => "20,000.00",
        ]
    ];
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Monthly Income"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Real"); ?></th>
                    <th><?php echo $translation->translateLabel("Projected"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($rows as $row){
                        echo "<tr><td>{$row["real"]}</td><td>{$row["projected"]}</td></tr>";
                    }
                ?>
            </tbody>
        </table>
    </div>
</div>
