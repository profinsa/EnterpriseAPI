<!DOCTYPE html>  
<html lang="en">
    <?php
	require 'header.php';
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
	<div class="preloader">
	    <div class="cssload-speeding-wheel"></div>
	</div>
	<section id="wrapper" class="login">
	    <div class="login-box login-box-position" style="margin-top:10%">
		<div class="white-box">
		    <form id="loginform" class="form-horizontal form-material" method="POST">
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
	 loginform.submit(function(e){
	     var req = $.post("index.php?page=login&loginform=<?php echo $config["loginForm"]; ?>", loginform.serialize(), null, 'json')
			.success(function(data) {
			    window.location = "index.php#/?page=dashboard";
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
	</script>
	<?php
	    require 'footer.php';
	?>
    </body>
</html>
