<!DOCTYPE html>
<html>
    <?php
	require __DIR__ . "/../../header.php";
    ?>
    <body style="height:100%">
	<script src="dependencies/plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
	<?php require __DIR__ . "/../../footer.php"; ?>
	<div id="content" style="background: #ffffff">
	    <?php
	    if(isset($content))
		require __DIR__ . "/" . $content . ".php";
	    ?>
	</div>
    </body>
</html>
