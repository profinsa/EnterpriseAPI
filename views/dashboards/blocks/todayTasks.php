<?php
    $todaysTasks = $data->TodaysTasks();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Today Tasks"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Due Date"); ?></th>
                    <th><?php echo $translation->translateLabel("Task ID"); ?></th>
                    <th><?php echo $translation->translateLabel("Description"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($todaysTasks as $row)
                    echo "<tr><td><a href=\"" . $linksMaker->makeDashboardLink() . "&screen=Tasks\">" . date("m/d/y", strtotime($row->DueDate)) . "</a></td><td><a href=\"" . $linksMaker->makeDashboardLink() . "&screen=Tasks\">" . $row->Task . "</a></td><td>" . $row->Description . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
</div>
