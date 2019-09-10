<link href="dependencies/assets/css/style.css" rel="stylesheet"> <!-- style from default interface for icons and other -->
<script src="dependencies/assets/js/moment.min.js"></script>
<script src="dependencies/assets/js/jquery.min.js"></script>
<script src="dependencies/assets/js/bootstrap.min.js"></script>
<script src="dependencies/assets/js/fullcalendar.min.js"></script>
<script src="dependencies/assets/js/bootstrap-datetimepicker.min.js"></script>

<link href="assets/css/simple/bootstrap-custom.css" rel="stylesheet">
<!--<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">-->
<!-- morris CSS -->
<link href="dependencies/assets/css/morris.css" rel="stylesheet">
<link href="dependencies/assets/css/fullcalendar.min.css" rel="stylesheet">
<link href="dependencies/assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<!-- <link href="dependencies/assets/css/fullcalendar.print.min.css" rel="stylesheet"> -->
<!--Morris JavaScript -->
<link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="dependencies/assets/js/raphael-min.js"></script>
<script src="dependencies/assets/js/morris.js"></script>
<script src="assets/js/bootstrap-datepicker.min.js"></script>
<link type="text/css" rel="stylesheet" media="all" href="assets/css/simple/colors/default-dark-theme.css" id="theme_css" />
<script>
 var currentTheme = localStorage.getItem('theme');
 if (currentTheme) {
     setTimeout(function() {
         $('#theme_css').attr('href', 'assets/css/simple/colors/' + currentTheme + '.css');
         $('.' + currentTheme).addClass('working');
     }, 0);
 } else {
     localStorage.setItem("theme", "default-theme");
     setTimeout(function() {
         $('#theme_css').attr('href', 'assets/css/simple/colors/default-theme.css');
         $(".default-theme").addClass('working');
     }, 0);
 }
</script>
<link href="assets/css/simple/style.css" rel="stylesheet">
<!-- <script type="text/javascript" src="assets/js/jspdf.min.js"></script>
     <script type="text/javascript" src="assets/js/standard_fonts_metrics.js"></script>
     <script type="text/javascript" src="assets/js/split_text_to_size.js"></script>
     <script type="text/javascript" src="assets/js/from_html.js"></script>
-->
