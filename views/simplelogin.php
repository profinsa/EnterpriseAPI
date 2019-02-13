<!DOCTYPE html>  
<html lang="en">
    <?php
	require 'interfaces/default/header.php';
    ?>
    <body>
	<style>
	 .label {
	     font-size : 12pt !Important;
	 }
	 .form-control {
	     font-size : 12pt !Important;
	 }
	 .has-error {
	     border : 1px solid red !Important;
	 }
	</style>
	<!-- Preloader -->
	<div id="chooseDepartmentDialog" class="modal fade  bs-example-modal-lg" tabindex="-1" role="dialog">
	    <div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
		    <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">
			    <?php echo $translation->translateLabel("Choose Company"); ?>
			</h4>
		    </div>
		    <div class="modal-body">
			<form id="companyform">
			    <div class="form-group">
				<div class="row">
 				    <div class="col-xs-6">
					<label class="dropdown-label pull-left"><?php echo $translation->translateLabel("Company"); ?>:</label>
				    </div>
				    <div class="col-xs-6">
					<select name="company" id="icompany" class="form-control pull-right row b-none" onchange="companySelect(event.target.value);">
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
					<select name="division" id="idivision" class="form-control pull-right row b-none" onchange="divisionSelect(event.target.value);">
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
			</form>
		    </div>
		    <div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal" id="chooseDepartment">
			    <?php echo $translation->translateLabel("Ok"); ?>
			</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">
			    <?php echo $translation->translateLabel("Cancel"); ?>
			</button>
		    </div>
		</div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<div class="preloader">
	    <div class="cssload-speeding-wheel"></div>
	</div>
	<section id="wrapper" class="login">
	    <div class="login-box login-box-position" style="margin-top:10%">
		<div class="white-box">
		    <form id="loginform" class="form-horizontal form-material" method="POST">
			<input type="hidden" name="language" value="English">
			<input type="hidden" name="page" value="login">
			<div class="row" style="padding-bottom:20px">
			    <div class="col-md-4"></div>
			    <div class="col-md-4">
				<img src="assets/images/stfb-logo.gif" alt="Logo">			
			    </div>
			    <div class="col-md-4"></div>
			</div>
			<div class="form-group ">
			    <div class="col-xs-12">
				<input name="name" id="iname" class="form-control" type="text" required="" placeholder="<?php echo $translation->translateLabel("User Name"); ?>">
			    </div>
			</div>
			<div  id="user_wrong_message" style="color:red; padding-bottom:20px; display:none">
			    <strong>These credentials do not match our records.</strong>
			</div>
			<div class="form-group">
			    <div class="col-xs-12">
				<input name="password" id="ipassword" class="form-control" type="password" required="" placeholder="<?php echo $translation->translateLabel("Password"); ?>">
			    </div>
			</div>
			<div class="form-group">
			    <div class="row">
				<div class="col-xs-6">
				    <input name="captcha" id="icaptcha" class="form-control" type="text" required placeholder="<?php echo $translation->translateLabel("Enter captcha"); ?>">
				</div>
				<div class="col-xs-6">
				    <img id="captcha" src="<?php echo $scope->captchaBuilder->inline(); ?>" />
				</div>
			    </div>
			    <div class="form-group text-center m-t-20">
				<div class="col-xs-12">
				    <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light" type="submit"><?php echo $translation->translateLabel("Log In"); ?></button>
				</div>
			    </div>
			</div>
		    </form>
		</div>
	    </div>
	</section>
	<script>
	 var loginform = $('#loginform');
	 var companies, company, division;
	 loginform.submit(function(e){
	     var req = $.post("index.php?page=login&loginform=<?php echo $config["loginForm"]; ?>", loginform.serialize(), null, 'json')
			.success(function(data) {
			    companies = data.companies;
			    var companies_options = '',
				icompany = $("#icompany")[0],
				ind;

			    for(ind in companies)
				companies_options += '<option>' + ind + '</option>';

			    icompany.innerHTML = companies_options;
			    var companyName = Object.keys(companies)[0],
				divisionName = Object.keys(companies[companyName])[0];
			    
			    companySelect(companyName);
			    divisionSelect(divisionName);
			    if(Object.keys(companies).length == 1 &&
			       Object.keys(companies[companyName]).length &&
			       Object.keys(companies[companyName][divisionName]).length
			    )
				loginAfterCompanyChoose();
			    else
				$('#chooseDepartmentDialog').modal('show');
			    //			    console.log(data);
			    //			    window.location = "index.php#/?page=dashboard";
			})
			.error(function(err){
			    var res = err.responseJSON;
			    if(res.wrong_captcha)
				$("#icaptcha").addClass("has-error");
			    else
				$("#icaptcha").removeClass("has-error");
			    if(res.wrong_user){
				$("#iname").addClass("has-error");
				$("#ipassword").addClass("has-error");
				$("#user_wrong_message").css("display", "block");
			    }else{
				$("#iname").removeClass("has-error");
				$("#ipassword").removeClass("has-error");
				$("#user_wrong_message").css("display", "none");
			    }
			    document.getElementById('captcha').src = res.captcha; 
			});
	     return false;
	 });

	 function loginAfterCompanyChoose(){
	     var loginform = $('#loginform'),
		 companyform = $('#companyform');
	     console.log(companyform.serialize());
	     var req = $.post("index.php?page=login<?php echo key_exists("config", $_GET) ? "&config={$_GET["config"]}" : ""; ?>", loginform.serialize() + "&" + companyform.serialize(), null, 'json')
			.success(function(data) {
			    window.location = "index.php#/?page=dashboard";
			});
	     //		 console.log($('#departmentID').val());
	     //serverProcedureCall('CreateDepartment', {
	     //		 "DepartmentID": $('#departmentID').val()
	     //	     }, true, undefined, true);
	 }
	 
	 function companySelect(value){
	     var idivision = $("#idivision")[0],
		 division_options = '',
		 ind,
		 divisions;

	     company = value;
	     divisions = companies[company];

	     for(ind in divisions)
		 division_options += '<option>' + ind + '</option>';
	     
	     idivision.innerHTML = division_options;

	     divisionSelect(Object.keys(companies[company])[0]);
	 }

	 function divisionSelect(value){
	     var ideparment = $("#idepartments")[0],
		 department_options = '',
		 ind,
		 departments;

	     division = value;
	     departments = companies[company][division];
	     
	     for(ind in departments)
		 department_options += '<option>' + ind + '</option>';
	     idepartment.innerHTML = department_options;
	 }
	 
	 $('#chooseDepartment').click(loginAfterCompanyChoose);
	</script>
	<?php
	    require 'interfaces/default/footer.php';
	?>
    </body>
</html>
