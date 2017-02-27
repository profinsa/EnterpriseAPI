<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <meta name="csrf-token" content="<?php echo csrf_token(); ?>" />  <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
  <title><?php echo $app->title; ?></title>
  <!-- Bootstrap Core CSS -->
  <link href="<?php echo $public_prefix; ?>/dependencies/assets/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- jQuery -->
  <script src="<?php echo $public_prefix; ?>/dependencies/plugins/bower_components/jquery/dist/jquery.min.js"></script>
  <!-- Bootstrap Core JavaScript -->
  <script src="<?php echo $public_prefix; ?>/dependencies/assets/bootstrap/dist/js/bootstrap.min.js"></script>
  <link href="<?php echo $public_prefix; ?>/dependencies/plugins/bower_components/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
  <link href="https://cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" /> 
  <!-- Menu CSS -->
  <!-- <link href="<?php echo $public_prefix; ?>/dependencies/plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet"> -->
  <!-- morris CSS -->
  <link href="<?php echo $public_prefix; ?>/dependencies/plugins/bower_components/morrisjs/morris.css" rel="stylesheet">
  <!-- animation CSS -->
  <link href="<?php echo $public_prefix; ?>/dependencies/assets/css/animate.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link href="<?php echo $public_prefix; ?>/dependencies/assets/css/style.css" rel="stylesheet">
  <link href="<?php echo $public_prefix; ?>/assets/css/style.css" rel="stylesheet">
  <!-- color CSS -->
  <link href="<?php echo $public_prefix; ?>/dependencies/assets/css/colors/gray-dark.css" id="theme"  rel="stylesheet">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
  <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-19175540-9', 'auto');
    ga('send', 'pageview');

  </script>
  <style>
   .dropdown-label {
       padding:10px 0 0 8px;
   }
  </style>
</head>
