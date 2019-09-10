<?php
    $rows = [
        [
            "real" => "15,000.00",
            "projected" => "20,000.00",
        ]
    ];
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Monthly Income"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div id="monthlyIncome-chart" class="ecomm-donute"  style="height: 300px;"></div>
</div>
<script>
 Morris.Bar({
     element : 'monthlyIncome-chart',
     data: [
	 {
	     y : "Real",
	     a : 20000
	 },
	 {
	     y : "Projected",
	     a : 40000
	 }
     ],
     xkey: 'y',
     ykeys: ['a'],
     labels: ['Total'],
     fillOpacity: 0.6,
     hideHover: 'auto',
     behaveLikeLine: true,
     resize: true,
     pointFillColors: ['#8b0000', '#ff0000', '#ff8c00', '#ffa500', '#ffcc00', '#ffff00', '#00ff00'],
     pointStrokeColors: ['black'],
     lineColors:['gray','red'],
     barColors: function(row, series, type){
	 switch(row.label){
	     case "Real" :
		 return '#00ff00';
	     case "Projected" :
		 return '#0000ff';
 	 }
	 return "black";
     }
 });
</script>
