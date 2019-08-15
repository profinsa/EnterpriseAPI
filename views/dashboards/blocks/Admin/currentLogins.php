<?php
    $rows = [
        [
            "users" => 15,
        ]
    ];
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Number of logged in users"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Users"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($rows as $row){
                        echo "<tr><td>{$row["users"]}</td></tr>";
                    }
                ?>
            </tbody>
        </table>
    </div>
</div>
