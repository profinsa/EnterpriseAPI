<!DOCTYPE html>
<html>
    <!-- <title><?php echo $app->title; ?></title> -->
    <?php
	require __DIR__ . "/../header.php";
    ?>
    <body style="height:100%">
	<script src="dependencies/plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
	<?php require __DIR__ . "/../footer.php"; ?>
	<div id="content" style="background: #ffffff">
	    <?php
	    if(isset($content))
		require __DIR__ . "/" . $content . ".php";
	    ?>
	</div>
	<script>
	 var windowh = window.innerHeight
		    || document.documentElement.clientHeight
		    || document.body.clientHeight;
	 document.getElementById("content").style.height = windowh + "px";
//	 console.log('dfdfdfd', document.getElementById("content"), windowh);
	</script>
    </body>
</html>
