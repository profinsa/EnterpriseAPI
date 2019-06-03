<div class="white-box">
    <div id="add-event-wrapper-id" style="display:none">
	<h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Add Event"); ?></h3>
	<a class="btn btn-info" style="margin-top: 10px" onclick="saveEvent()">
	    <?php echo $translation->translateLabel("Save"); ?>
	</a>
	<a class="btn btn-info" style="margin-top: 10px; float: right" onclick="cancelEvent()">
	    <?php echo $translation->translateLabel("Cancel"); ?>
	</a>
	<div style="margin-top: 20px" >
	    <label for="event-title-id">Event title</label>
	    <input type="text" class="form-control" id="event-title-id">
	</div>
	<div id="one-day-wrapper-id">
	    <div style="margin-top: 15px" >
		<input type="checkbox" id="event-all-day-days-id" onchange="onAllDay(event);">
		<label for="event-all-day-days-id">All Day</label>
	    </div>

	    <div style="margin-top: 15px">
		<div class="form-group">
		    <label for="datetimepicker2">Date</label>
		    <div class='input-group date' id='datetimepicker2'>
			<input type='text' class="form-control" />
			<span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			</span>
		    </div>
		</div>
	    </div>

	    <div id="time-wrapper-id" style="display:none">
		<div style="margin-top: 15px">
		    <div class="form-group">
			<label for="datetimepicker3">Date From</label>
			<div class='input-group date' id='datetimepicker3'>
			    <input type='text' class="form-control" />
			    <span class="input-group-addon">
				<span class="glyphicon glyphicon-time"></span>
			    </span>
			</div>
		    </div>
		</div>

		<div style="margin-top: 15px">
		    <div class="form-group">
			<label for="datetimepicker4">Date To</label>
			<div class='input-group date' id='datetimepicker4'>
			    <input type='text' class="form-control" />
			    <span class="input-group-addon">
				<span class="glyphicon glyphicon-time"></span>
			    </span>
			</div>
		    </div>
		</div>
	    </div>

	</div>
	<div style="margin-top: 15px" >
	    <input type="checkbox" id="event-a-few-days-id" onchange="onFewDays(event);">
	    <label for="event-a-few-days-id">A few days</label>
	</div>
	<div id="few-days-wrapper-id" style="display:none">
	    <div style="margin-top: 15px">
		<div class="form-group">
		    <label for="datetimepicker1">Date From</label>
		    <div class='input-group date' id='datetimepicker1'>
			<input type='text' class="form-control" />
			<span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			</span>
		    </div>
		</div>
	    </div>

	    <div style="margin-top: 15px">
		<div class="form-group">
		    <label for="datetimepicker5">Date To</label>
		    <div class='input-group date' id='datetimepicker5'>
			<input type='text' class="form-control" />
			<span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			</span>
		    </div>
		</div>
	    </div>
	</div>
    </div>
    <div id="calendar-wrapper-id">
	<h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Shipments Calendar"); ?></h3>
	<a class="btn btn-info" style="margin-top: 10px" onclick="addEvent()">
	    <?php echo $translation->translateLabel("Add Event"); ?>
	</a>
	<div id='events-calendar-id' style="margin-top: 15px"></div>
    </div>
</div>
<script>
 function onAllDay() {
     if ($("#event-all-day-days-id").prop("checked")) {
	 $("#time-wrapper-id").hide();
     } else {
	 $("#time-wrapper-id").show();
     }
 }
 function onFewDays(e) {
     if ($("#event-a-few-days-id").prop("checked")) {
	 $("#few-days-wrapper-id").show();
	 $("#one-day-wrapper-id").hide();
     } else {
	 $("#few-days-wrapper-id").hide();
	 $("#one-day-wrapper-id").show();
     }
 }

 function addEvent() {
     $("#calendar-wrapper-id").hide();
     $("#event-all-day-days-id").prop("checked", true);
     $("#event-a-few-days-id").prop("checked", false);
     onFewDays();
     onAllDay();
     $("#add-event-wrapper-id").width('100%');
     $("#add-event-wrapper-id").show();
     
     $('#datetimepicker2').data("DateTimePicker").date(new Date());

     $('#datetimepicker3').data("DateTimePicker").date(new Date());
     $('#datetimepicker4').data("DateTimePicker").date(new Date());

     $('#datetimepicker1').data("DateTimePicker").date(new Date());
     $('#datetimepicker5').data("DateTimePicker").date(new Date());
 }

 function cancelEvent() {
     $("#add-event-wrapper-id").hide();
     // $("#calendar-wrapper-id").height($("#add-event-wrapper-id").height());
     // $("#calendar-wrapper-id").width($("#add-event-wrapper-id").width());
     $("#calendar-wrapper-id").show();
 }

 function saveEvent() {
     if (!$("#event-title-id").val()) {
	 alert('Please enter event title.');
	 return;
     }
     $("#add-event-wrapper-id").hide();
     // $("#calendar-wrapper-id").height($("#add-event-wrapper-id").height());
     // $("#calendar-wrapper-id").width($("#add-event-wrapper-id").width());
     $("#calendar-wrapper-id").show();

     var eventData;

     if ($("#event-a-few-days-id").prop("checked")) {
	 eventData = {
	     title: $("#event-title-id").val(),
	     start: $('#datetimepicker1').data("DateTimePicker").date().startOf('day').format('YYYY-MM-DD'),
	     end: $('#datetimepicker5').data("DateTimePicker").date().add(1, "days").format('YYYY-MM-DD')
	 };
     } else {
	 if ($("#event-all-day-days-id").prop("checked")) {
	     // eventData = {
	     // 	title: $("#event-title-id").val(),
	     // 	start: $('#datetimepicker2').data("DateTimePicker").date().startOf('day').format('YYYY-MM-DD HH:mm:ss'),
	     // 	end: $('#datetimepicker2').data("DateTimePicker").date().add(1, 'days').format('YYYY-MM-DD HH:mm:ss')
	     // };
	     eventData = {
		 title: $("#event-title-id").val(),
		 start: $('#datetimepicker3').data("DateTimePicker").date().format('YYYY-MM-DD'),
		 end: $('#datetimepicker4').data("DateTimePicker").date().format('YYYY-MM-DD')
	     };
	 } else {
	     eventData = {
		 title: $("#event-title-id").val(),
		 start: $('#datetimepicker3').data("DateTimePicker").date().set({
		     'year': $('#datetimepicker2').data("DateTimePicker").date().get('year'),
		     'month': $('#datetimepicker2').data("DateTimePicker").date().get('month'),
		     'date': $('#datetimepicker2').data("DateTimePicker").date().get('date')
		 }).format('YYYY-MM-DD HH:mm:ss'),
		 end: $('#datetimepicker4').data("DateTimePicker").date().set({
		     'year': $('#datetimepicker2').data("DateTimePicker").date().get('year'),
		     'month': $('#datetimepicker2').data("DateTimePicker").date().get('month'),
		     'date': $('#datetimepicker2').data("DateTimePicker").date().get('date')
		 }).format('YYYY-MM-DD HH:mm:ss')
	     };
	 }
     }

     $('#events-calendar-id').fullCalendar('renderEvent', eventData, true);
     $("#event-title-id").val('');
     var eventsJson = localStorage.getItem("calendarevents");
     var buf = eventsJson ? JSON.parse(eventsJson) : [];
     buf.push(eventData);
     localStorage.setItem("calendarevents", JSON.stringify(buf));
 }

 $(document).ready(function() {
     $('#datetimepicker1').datetimepicker({
	 format: 'DD/MM/YYYY'
     });
     $('#datetimepicker5').datetimepicker({
	 format: 'DD/MM/YYYY'
     });

     $('#datetimepicker2').datetimepicker({
	 format: 'DD/MM/YYYY'
     });
     $('#datetimepicker3').datetimepicker({
	 format: 'LT'
     });
     $('#datetimepicker4').datetimepicker({
	 format: 'LT'
     });
     var eventsJson = localStorage.getItem("calendarevents");
     $('#events-calendar-id').fullCalendar({
	 themeSystem: 'bootstrap3',
	 header: {
	     left: 'prev,next today',
	     center: 'title',
	     right: 'month,agendaWeek,agendaDay'
	 },
	 navLinks: true,
	 selectable: true,
	 aspectRatio: 0.9,
	 selectHelper: true,
	 select: function(start, end) {
	     // console.log(start, end);
	     localStorage.setItem("start", start.format('YYYY-MM-DD HH:mm:ss'));
	     localStorage.setItem("end", end.format('YYYY-MM-DDTHH:mm:ss'));
	     $("#calendar-wrapper-id").hide();
	     $("#add-event-wrapper-id").width('100%');
	     $("#add-event-wrapper-id").show();

	     if (end.diff(start) > 86400000) {
		 $("#event-a-few-days-id").prop("checked", true);
		 onFewDays();
	     } else if (end.diff(start) < 86400000) {
		 $("#event-all-day-days-id").prop("checked", false);
		 $("#event-a-few-days-id").prop("checked", false);
		 onFewDays();
		 onAllDay();
	     } else if (end.diff(start) == 86400000) {
		 $("#event-all-day-days-id").prop("checked", true);
		 $("#event-a-few-days-id").prop("checked", false);
		 onFewDays();
		 onAllDay();
	     }

	     
	     $('#datetimepicker2').data("DateTimePicker").date(start);

	     $('#datetimepicker3').data("DateTimePicker").date(start);
	     $('#datetimepicker4').data("DateTimePicker").date(end);

	     $('#datetimepicker1').data("DateTimePicker").date(start);
	     $('#datetimepicker5').data("DateTimePicker").date(end.subtract(1, "days"));

	     // var title = prompt('Please enter event title:');
	     // var eventData;
	     // if (title) {
	     // 	eventData = {
	     // 		title: title,
	     // 		start: start,
	     // 		end: end
	     // 	};
	     // 	$('#events-calendar-id').fullCalendar('renderEvent', eventData, true);

	     // 	var eventsJson = localStorage.getItem("calendarevents");
	     // 	var buf = eventsJson ? JSON.parse(eventsJson) : [];
	     // 	buf.push(eventData);
	     // 	localStorage.setItem("calendarevents", JSON.stringify(buf));
	     // }
	     // $('#events-calendar-id').fullCalendar('unselect');
	 },
	 editable: true,
	 events: eventsJson ? JSON.parse(eventsJson) : []
     });
     
 });

</script>