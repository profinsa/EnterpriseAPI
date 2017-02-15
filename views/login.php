<!DOCTYPE html>  
<html lang="en">
    <?php
    require 'header.php';
    ?>
    <body>
	<!-- Preloader -->
	<div class="preloader">
	    <div class="cssload-speeding-wheel"></div>
	</div>
	<section id="wrapper" class="login">
	    <div class="login-box">
		<div class="white-box">
		    <form id="loginform" class="form-horizontal form-material" method="POST">
			<input type="hidden" name="page" value="login">
			<h3 class="box-title m-b-20"><?php echo $translation->translateLabel("Sign In"); ?></h3>
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
			<div class="form-group ">
			    <div class="col-xs-12">
				<input name="name" id="iname" class="form-control" type="text" required="" placeholder="<?php echo $translation->translateLabel("User Name"); ?>">
			    </div>
			</div>
			<div class="form-group">
			    <div class="col-xs-12">
				<input name="password" id="ipassword" class="form-control" type="password" required="" placeholder="<?php echo $translation->translateLabel("Password"); ?>">
			    </div>
			</div>
			<div class="form-group">
			    <div class="row">
 				<div class="col-xs-6">
				    <label class="dropdown-label pull-left"><?php echo $translation->translateLabel("Language"); ?>:</label>
				</div>
				<div class="col-xs-6">
				    <select name="language" class="form-control pull-right row b-none" onchange="changeLanguage(event);">
					<option><?php echo $scope->user["language"]; ?></option>
					<?php
					foreach($translation->languages as $value)
					    if($value != $scope->user["language"])
						echo "<option>" . $value . "</option>";
					?>
				    </select>
				</div>
			    </div>
			</div>
			<!-- <div class="form-group">
			     <div class="row">
 			     <div class="col-xs-6">
			     <label name="style" class="dropdown-label pull-left">Style:</label>
			     </div>
			     <div class="col-xs-6">
			     <select class="form-control pull-right row b-none">
			     <?php
			     foreach($scope->styles as $value)
			     echo "<option>$value</option>";
			     ?>
			     </select>
			     </div>
			     </div>
			     </div> -->
			<div class="form-group">
			    <div class="row">
				<div class="col-xs-6">
				    <input name="captcha" id="icaptcha" class="form-control" type="text" required placeholder="<?php echo $translation->translateLabel("Enter captcha"); ?>">
				</div>
				<div class="col-xs-6">
				    <img id="captcha" src="<?php echo $scope->captchaBuilder->inline(); ?>" />
				</div>
			    </div>
			    <!--<div class="form-group">
				 <div class="col-md-12">
				 <div class="checkbox checkbox-primary pull-left p-t-0">
				 <input id="checkbox-signup" type="checkbox">
				 <label for="checkbox-signup"> Remember me </label>
				 </div>
				 <a href="javascript:void(0)" id="to-recover" class="text-dark pull-right"><i class="fa fa-lock m-r-5"></i> Forgot pwd?</a> </div>
				 </div>-->
			    <div class="form-group text-center m-t-20">
				<div class="col-xs-12">
				    <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light" type="submit"><?php echo $translation->translateLabel("Log In"); ?></button>
				</div>
			    </div>
			    <!--div class="row">
				 <div class="col-xs-12 col-sm-12 col-md-12 m-t-10 text-center">
				 <div class="social"><a href="javascript:void(0)" class="btn  btn-facebook" data-toggle="tooltip"  title="Login with Facebook"> <i aria-hidden="true" class="fa fa-facebook"></i> </a> <a href="javascript:void(0)" class="btn btn-googleplus" data-toggle="tooltip"  title="Login with Google"> <i aria-hidden="true" class="fa fa-google-plus"></i> </a> </div>
				 </div>
				 </div>
				 <div class="form-group m-b-0">
				 <div class="col-sm-12 text-center">
				 <p>Don't have an account? <a href="register3.html" class="text-primary m-l-5"><b>Sign Up</b></a></p>
				 </div>
				 </div>-->
		    </form>
		    <!--<form class="form-horizontal" id="recoverform" action="index.html">
			 <div class="form-group ">
			 <div class="col-xs-12">
			 <h3>Recover Password</h3>
			 <p class="text-muted">Enter your Email and instructions will be sent to you! </p>
			 </div>
			 </div>
			 <div class="form-group ">
			 <div class="col-xs-12">
			 <input class="form-control" type="text" required="" placeholder="Email">
			 </div>
			 </div>
			 <div class="form-group text-center m-t-20">
			 <div class="col-xs-12">
			 <button class="btn btn-primary btn-lg btn-block text-uppercase waves-effect waves-light" type="submit">Reset</button>
			 </div>
			 </div>
			 </form>-->
			</div>
		</div>
	</section>
	<script>
	 var loginform = $('#loginform');
	 loginform.submit(function(e){
	     var req = $.post("index.php", loginform.serialize(), null, 'json')
			.success(function(data) {
			    window.location = "index.php?page=index";
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
	     $.getJSON("index.php?page=language&setLanguage=" + event.target.value)
	      .success(function(data) {
		  location.reload();
	      })
	      .error(function(err){
		  console.log('something going wrong');
	      });
	 }

	</script>
	<?php
	require 'footer.php';
	?>
    </body>
</html>
