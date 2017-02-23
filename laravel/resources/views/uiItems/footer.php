<footer class="footer">
    <?php
    echo $scope->user["CompanyID"] . ' / ' .
	 $scope->user["DivisionID"] . ' / ' .
	 $scope->user["DepartmentID"] . ' / ' .
	 $scope->user["EmployeeID"];
    ?>
    <div class="pull-right">
	<script>
	 var date = new Date();
	 document.write(date.getFullYear() + '-' +
			 ('0'+date.getMonth()).slice(-2) + '-' +
			 ('0'+date.getDate()).slice(-2) + ' / ' +
			 ('0'+date.getHours()).slice(-2) + ':' +
			 ('0'+date.getMinutes()).slice(-2));
	</script>
    </div>
</footer>
