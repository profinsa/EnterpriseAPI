<div class="container-fluid">
    <?php
    require __DIR__ . '/../uiItems/dashboard.php';
    require __DIR__ . '/../format.php';
    ?>
    
    <div class="row">
    </div>
    <!--row -->
    <div class="row">
	<div class="col-md-12">
	    <?php
	    $todaysTasks = $data->TodaysTasks();
	    ?>
	    <div>
		<div class="white-box">
		    <!--  		    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Today Tasks"); ?></h3> -->
		    <!-- <p class="text-muted">this is the sample data</p> -->
		    <div class="table-responsive">
			<table class="table table-hover">
			    <thead>
				<tr>
				    <th><?php echo $translation->translateLabel("Due Date"); ?></th>
				    <th><?php echo $translation->translateLabel("Task"); ?></th>
				</tr>
			    </thead>
			    <tbody>
				<?php
				foreach($todaysTasks as $row)
				    echo "<tr><td>" . date("m/d/y", strtotime($row->DueDate)) . "</td><td>" . $row->Task . "</td></tr>";
				?>
			    </tbody>
			</table>
		    </div>
		</div>
	    </div>
	</div>
    </div>
</div>
