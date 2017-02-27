<!doctype html>
<html>
    <head>
        <title>Integral Accounting NewTech</title>
	<link href="<?php echo $public_prefix; ?>/assets/css/newtechcrm-vertical.css" rel="stylesheet">
	<link href="<?php echo $public_prefix; ?>/assets/css/style.css" rel="stylesheet">
	<script src="<?php echo $public_prefix; ?>/dependencies/plugins/bower_components/jquery/dist/jquery.min.js"></script>
	<script src="<?php echo $public_prefix; ?>/dependencies/assets/bootstrap/dist/js/bootstrap.min.js"></script>
        <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
        <meta content="utf-8" http-equiv="encoding">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-capable" content="yes">
	<!--    <link rel="shortcut icon" sizes="196x196" href="../client/img/favicon196x196.png">
             <link rel="icon" href="../client/img/favicon.ico" type="image/x-icon">
             <link rel="shortcut icon" href="../client/img/favicon.ico" type="image/x-icon"> -->
    </head>
    <body>
	<div class="container content">
	    <div class="col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2">
		<div id="login" class="panel panel-default">
		    <div class="panel-heading">
			<div class="logo-container">
			    <!-- <h3><?php echo $translation->translateLabel("Sign In"); ?></h3> -->
			    <img src="" class="logo">
			</div>
		    </div>
		    <div class="panel-body">
			<div>
			    <form id="loginform">
				<?php echo csrf_field(); ?>
				<div class="form-group">
				    <div class="row">
 					<div class="col-xs-6">
					    <label class="dropdown-label pull-left"><?php echo $translation->translateLabel("Company"); ?>:</label>
					</div>
					<div class="col-xs-6">
					    <select name="company" id="icompany" class="form-control pull-right row b-none" onchange="companySelect(event);">
						<option>DEFAULT</option>
					    </select>
					</div>
				    </div>
				</div>
				<div class="form-group">
				    <div class="row">
 					<div class="col-xs-6">
					    <label class="dropdown-label pull-left"><?php echo $translation->translateLabel("Division"); ?>:</label>
					</div>
					<div class="col-xs-6">
					    <select name="division" id="idivision" class="form-control pull-right row b-none">
						<option>DEFAULT</option>
					    </select>
					</div>
				    </div>
				</div>
				<div class="form-group">
				    <div class="row">
 					<div class="col-xs-6">
					    <label class="dropdown-label pull-left"><?php echo $translation->translateLabel("Department"); ?>:</label>
					</div>
					<div class="col-xs-6">
					    <select name="department" id="idepartment" class="form-control pull-right row b-none">
						<option>DEFAULT</option>
					    </select>
					</div>
				    </div>
				</div>
				<div class="form-group">
				    <div class="row">
 					<div class="col-xs-6">
					    <label class="dropdown-label pull-left"><?php echo $translation->translateLabel("Language"); ?>:</label>
					</div>
					<div class="col-xs-6">
					    <select name="language" class="form-control pull-right row b-none" onchange="changeLanguage(event);">
						<option><?php echo $user["language"]; ?></option>
						<?php
						foreach($translation->languages as $value)
						    if($value != $user["language"])
							echo "<option>" . $value . "</option>";
						?>
					    </select>
					</div>
				    </div>
				</div>
				<div class="form-group">
				    <label for="name"><?php echo $translation->translateLabel("User Name"); ?></label>
				    <input name="name" id="iname" class="form-control" type="text" required="">
				</div>
				<div class="form-group">
				    <label for="password"><?php echo $translation->translateLabel("Password"); ?></label>
				    <input name="password" id="ipassword" class="form-control" type="password" required="">
				</div>
				<div class="form-group">
				    <div class="row">
					<div class="col-xs-6">
					    <input name="captcha" id="icaptcha" class="form-control" type="text" required placeholder="<?php echo $translation->translateLabel("Enter captcha"); ?>">
					</div>
					<div class="col-xs-6">
					    <img id="captcha" src="<?php echo $captchaBuilder->inline(); ?>" />
					</div>
				    </div>
				</div>
				<div>
				    <a href="javascript:" class="btn btn-link pull-right" data-action="passwordChangeRequest">Forgot Password?</a>
				    <button type="submit" class="btn btn-primary" id="btn-login"><?php echo $translation->translateLabel("Log In"); ?></button>
				</div>
			    </form>
			</div>
		    </div>
		</div>
	    </div>
	</div>
	<script>
	 var loginform = $('#loginform');
	 loginform.submit(function(e){
	     var req = $.post("login", loginform.serialize(), null, 'json')
			.success(function(data) {
			    window.location = "index";
			})
			.error(function(err){
			    var res = err.responseJSON;
			    if(res.wrong_captcha)
				$("#icaptcha").addClass("has-error");
			    else
				$("#icaptcha").removeClass("has-error");
			    document.getElementById('captcha').src = res.captcha; 
			});
	     return false;
	 });
	 var companies = <?php echo json_encode($companies->companies); ?>;
	 $(document).ready(function(){
	     var companiesList = {},
		 companies_options = '',
		 icompany = $("#icompany")[0],
		 ind;

	     for(ind in companies)
		 companiesList[companies[ind].CompanyID] = true;
	     for(ind in companiesList)
		 companies_options += '<option>' + ind + '</option>';

	     icompany.innerHTML = companies_options;
	 });
	 
	 function companySelect(event){
	     var idivision = $("#idivision")[0],
		 ideparment = $("#idepartments")[0],
		 division_options = '',
		 department_options = '',
		 ind,
		 divisions = {},
		 departments = {},
		 company = event.target.value;

	     for(ind in companies){
		 if(companies[ind].CompanyID == company){
		     divisions[companies[ind].DivisionID] = true;
		     departments[companies[ind].DepartmentID] = true;
		 }
	     }

	     for(ind in divisions)
		 division_options += '<option>' + ind + '</option>';
	     for(ind in departments)
		 department_options += '<option>' + ind + '</option>';
	     
	     idivision.innerHTML = division_options;
	     idepartment.innerHTML = department_options;
	 }
	 
	 function changeLanguage(event){
	     $.getJSON("laguage/" + event.target.value)
	      .success(function(data) {
		  location.reload();
	      })
	      .error(function(err){
		  console.log('something going wrong');
	      });
	 }

	</script>
    </body>
</html>
