<?php
    $departments = $data->getDepartments();
    $companyStatus = $data->CompanyAccountsStatus();
    $statusByDepartments = $data->getAccountsStatusesByDepartments();
    $statuses = [];
    foreach($statusByDepartments as $row)
    foreach($row->Status as $row){
        if(!key_exists($row->GLAccountName, $statuses))
            $statuses[$row->GLAccountName] = [$row->Totals];
        else
            $statuses[$row->GLAccountName][] = $row->Totals;
    }    
    $statusesForChart = [];
    foreach($statuses as $key=>$value){
        $statusesForChart[] = [
            "name" => $key,
            "data" => $value
        ];
    }

    /*foreach
       foreach($companyStatus as $row)
       echo "<tr><td>" . $row->GLAccountType . "</td><td>" . $drill->getLinkByAccountNameAndAccountType($row->GLAccountName,$row->GLAccountType)  . "</td><td>" . formatField(["format"=>"{0:n}"], $row->Totals) . "</td></tr>";*/
?>
<div class="white-box">
    <h3 class="box-title"><?php echo $translation->translateLabel("Company Status"); ?></h3>
    <div id="CompaniesHorizontalChart"></div>
</div>
<script>     
 var options = {
     chart: {
         height: 450,
         type: 'bar',
         stacked: true,
     },
     plotOptions: {
         bar: {
             horizontal: true,
         },
         
     },
     stroke: {
         width: 0.5,
         colors: ['#fff']
     },
     series: <?php echo json_encode($statusesForChart); ?>
     ,
     title: {
         //             text: 'Fiction Books Sales'
     },
     xaxis: {
         categories: <?php
                         $names = [];
                         foreach($departments as $row)
                         $names[] = $row->CompanyID . " / " . $row->DivisionID  ." / " . $row->DepartmentID;
                         echo json_encode($names);
                     ?>,
         labels: {
             formatter: function(val) {
                 return currencyFormat(2, val + '.00')
             }
         }
     },
     yaxis: {
         title: {
             text: undefined
         },
         
     },
     tooltip: {
         y: {
             formatter: function(val) {
                 return currencyFormat(2, val + '.00')
             }
         }
     },
     fill: {
         opacity: 1
         
     },
     
     legend: {
         position: 'top',
         horizontalAlign: 'left',
         offsetX: 60
     }
 }

 var chart = new ApexCharts(
     document.querySelector("#CompaniesHorizontalChart"),
     options
 );
 
 chart.render();
</script>
