<?php
    $rows = [
        [
            "receivable" => "10,000.99",
            "payable" => "2,500.00"
        ]
    ];
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Receivables / Payable Summary"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Receivable"); ?></th>
                    <th><?php echo $translation->translateLabel("Payable"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($rows as $row){
                        echo "<tr><td>{$row["receivable"]}</td><td>{$row["payable"]}</td></tr>";
                    }
                ?>
            </tbody>
        </table>
    </div>
</div>
