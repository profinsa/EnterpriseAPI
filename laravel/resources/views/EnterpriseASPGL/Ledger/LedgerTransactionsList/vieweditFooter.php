<br/>
<div class="col-md-12">
    <div id="subgrid" class="col-md-12">
    </div>

    <script>
     var path = new String(window.location);
     path = path.replace(/index\#\//, "");
     path = path.replace(/grid|view|edit|new/g, "subgrid");
     $.get(path + "?partial=true")
      .done(function(data){
	  setTimeout(function(){
	      $("#subgrid").html(data);
	      window.scrollTo(0,0);
	  },0);
      })
      .error(function(xhr){
	  if(xhr.status == 401)
	      window.location = "<?php echo $public_prefix; ?>/login";
	  else
	      alert("Unable to load page");
      });
    </script>
</div>
