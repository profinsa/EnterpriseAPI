<!DOCTYPE html>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><?php echo $app->title; ?></title>
 	<?php
	if(isset($header))
	    require __DIR__ . "/../../header.php";
	?>
	<meta name="csrf-token" content="<?php echo  csrf_token();?>">
	<meta content="utf-8" http-equiv="encoding">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="description" content="">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
    </head>
    <body style="padding-top:10px; font-family: Arial;">
	<?php require __DIR__ . "/../../footer.php"; ?>
	<div id="content" class="container-fluid" style="background: #ffffff; padding-bottom:10px;">
	    <?php
	    if(isset($content))
		require __DIR__ . "/" . $content;
	    ?>
	</div>
	<script>
	</script>
    </body>
</html>
