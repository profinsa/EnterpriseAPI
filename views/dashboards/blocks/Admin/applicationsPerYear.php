<?php
    $applications = $data->adminGetApplicationsPerYear();
    $colors = [];
    while (true) {
        $colors[] = '#' . substr(str_shuffle('ABCDEF0123456789'), 0, 6);
        if(count($colors) == 10000)
            break;
    }
    $colorInd = 0;
?>
<div class="white-box">
    <h3 class="box-title">Applications Per Month</h3>
    <ul class="list-inline text-center">
        <?php foreach($applications["labels"] as $label): ?>
            <li>
                <h5><i class="fa fa-circle m-r-5" style="color: <?php echo $colors[$colorInd++]; ?>"></i><?php echo $label; ?></h5>
            </li>
        <?php endforeach; ?>
    </ul>

    <div id="ApplicationsPerYear" style="height: 370px;"></div>
</div>
<script>
 var applications = <?php echo json_encode($applications) ?>;
 console.log(JSON.stringify(applications, null, 4));
 var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
 Morris.Area(
     {
         element: 'ApplicationsPerYear',
         data: applications.data,
         xkey: 'period',
         ykeys: applications.labels,
         labels: applications.labels,
         pointSize: 0,
         fillOpacity: 0.4,
         pointStrokeColors: <?php echo json_encode($colors) ?>,
         behaveLikeLine: true,
         gridLineColor: '#e0e0e0',
         lineWidth: 0,
         smooth: true,
         hideHover: 'auto',
         lineColors: <?php echo json_encode($colors) ?>,
         resize: true,
         xLabelFormat: function(x) { // <--- x.getMonth() returns valid index
             var month = months[x.getMonth()];
             return month;
         },
         dateFormat: function(x) {
             var month = months[new Date(x).getMonth()];
             return month;
         },
     });
 /* Morris.Area({
    element: 'morris-area-chart2',
    data: [
    {
    period: '2010',
    iMac: 0,
    iLon : 2,
    iPhone: 0,         
    ],
    xkey: 'period',
    ykeys: ['iLon', 'iMac', 'iPhone'],
    labels: ['iMac', 'iPhone'],
    pointSize: 0,
    fillOpacity: 0.4,
    pointStrokeColors:['#b4becb', '#01c0c8'],
    behaveLikeLine: true,
    gridLineColor: '#e0e0e0',
    lineWidth: 0,
    smooth: true,
    hideHover: 'auto',
    lineColors: ['#b4becb', '#01c0c8'],
    resize: true
    
    });*/
</script>
