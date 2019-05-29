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
	<h3 class="box-title m-b-0"><?php echo $translation->translateLabel($calendarTitle); ?></h3>
	<div id='records-calendar-id' style="margin-top: 15px"></div>
    </div>
</div>
<script>
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
     
     //     console.log(orders);
     //     console.log(orders);
     //   console.log(eventsJson);

     $('#records-calendar-id').fullCalendar({
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
	 select: calendarOnSelect,
	 eventClick : calendarOnClick,
	 editable: true,
	 events: calendarDataSource()
     });
     
 });

</script>
