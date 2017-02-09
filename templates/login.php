<!-- Preloader -->
<div class="preloader">
    <div class="cssload-speeding-wheel"></div>
</div>
<section id="wrapper" class="login-register">
    <div class="login-box">
	<div class="white-box">
	    <form id="loginform" class="form-horizontal form-material" method="POST">
		<input type="hidden" name="page" value="login">
		<h3 class="box-title m-b-20">Sign In</h3>
		<div class="form-group">
		    <div class="row">
 			<div class="col-xs-6">
			    <label class="dropdown-label pull-left">Company:</label>
			</div>
			<div class="col-xs-6">
			    <select name="company" class="form-control pull-right row b-none">
				<?php
				foreach($_app->scope["page"]->companies as $value)
				    echo "<option>$value</option>";
				?>
			    </select>
			</div>
		    </div>
		</div>
		<div class="form-group ">
		    <div class="col-xs-12">
			<input name="name" class="form-control" type="text" required="" placeholder="Username">
		    </div>
		</div>
		<div class="form-group">
		    <div class="col-xs-12">
			<input name="password" class="form-control" type="password" required="" placeholder="Password">
		    </div>
		</div>
		<div class="form-group">
		    <div class="row">
 			<div class="col-xs-6">
			    <label class="dropdown-label pull-left">Language:</label>
			</div>
			<div class="col-xs-6">
			    <select name="language" class="form-control pull-right row b-none">
				<?php
				foreach($_app->scope["page"]->languages as $value)
				    echo "<option>$value</option>";
				?>
			    </select>
			</div>
		    </div>
		</div>
		<div class="form-group">
		    <div class="row">
 			<div class="col-xs-6">
			    <label name="style" class="dropdown-label pull-left">Style:</label>
			</div>
			<div class="col-xs-6">
			    <select class="form-control pull-right row b-none">
				<?php
				foreach($_app->scope["page"]->styles as $value)
				    echo "<option>$value</option>";
				?>
			    </select>
			</div>
		    </div>
		</div>
		<div class="form-group">
		    <div class="row">
			<div class="col-xs-6">
			    <input name="captcha" class="form-control" type="text" required placeholder="Enter captcha">
			</div>
			<div class="col-xs-6">
			    <img id="captcha" src="<?php echo $_app->scope["page"]->captchaBuilder->inline(); ?>" />
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
			    <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light" type="submit">Log In</button>
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
		    window.location = "index.php?page=main";
		})
		.error(function(err){
		    console.log(err);
		    //		    var res = JSON.parse(err);
		    document.getElementById('captcha').src = err.responseJSON.captcha; 
		});
     return false;
 });
</script>
