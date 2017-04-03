<br/>
<div class="col-md-12">
    <div id="subgrid" class="col-md-12">
    </div>

    <script>
     function subgridView(cb){
	 var path = new String(window.location);
	 path = path.replace(/index.php\#\//, "index.php");
	 path = path.replace(/grid|view|edit|new/g, "subgrid");
	 $.get(path)
	  .done(function(data){
	      setTimeout(function(){
		  $("#subgrid").html(data);
		  if(cb)
		      cb();
	      },0);
	  })
	  .error(function(xhr){
	      if(xhr.status == 401)
		  window.location = "index.php?page=login";
	      else
		  alert("Unable to load page");
	  });
     }
     subgridView(function(){
	 window.scrollTo(0,0);
     });
    </script>
</div>
