$(document).ready(function(){
	getAppointments();

	//new button activity
  	$("#btnNew").click(function(){
		$("#btnNew").hide();	
		$('#hiddenDiv').show();					   
  	});	


	var todayDate = new Date().toISOString().slice(0,10);
	$("#txtDate").attr("min", todayDate);
	
	// validating date
	$("#txtDate").focusout(function(){
	var inputDate = Date.parse(($("#txtDate").val()));
		var currentDate=new Date().getFullYear() + "-"+ parseInt(new Date().getMonth()+1)+"-"+parseInt(new Date().getDate()-1);
		if(inputDate<Date.parse(currentDate)){
			$("#lblDate").html("Please enter correct date");
			$("#btnAdd").prop('disabled', true);
		}
		else{
			$("#lblDate").html("");
			$("#btnAdd").prop('disabled', false);
		}
	});
  
  	//cancel button activity
  	$("#btnCancel").click(function(){
		$('#hiddenDiv').hide();	
		$("#btnNew").show();						   
  	});
  
  	//search button activity and loading data in JSON format
  	$("#btnSearch").click(function(){
		getAppointments();
  	});

	//loading data for appointments in JSON format
	function getAppointments(){
		var searchData=$("#txtSearch").val();
		$.ajax('bin/searchData.pl',{
			"type": "POST", 
			// dataType:"JSON",		
			"data": {searchData:searchData},
			"success":loadDetails,
			"error":failure
		});
	}

	//Function to display appointments after success of loading from getAppointments()
	function loadDetails(data){
		if(data.length==0){
 			failure();
		}
		
		else { 
    		var tableData='<table border="1" class="table table-striped"><thead class="thead-inverse"><tr class="bg-info"><th>Date</th><th>Time (24 Hr)</th><th>Description</th></tr></thead>';		
			$.each(data,function(index,item){
				var datetime = data[index].datetime.split(' ');
				tableData+='<tr>';
				tableData+='<td>'+datetime[0]+'</td>';
				tableData+='<td>'+datetime[1]+'</td>';
				tableData+='<td>'+item.description+'</td>';
				tableData+='</tr>';
			});
			tableData+='</table>';
			$('#displayAppointment').html(tableData);
  		}
	}	

	//if data is not loaded from database or database table is empty
	function failure(){
		var tableDataError='***No appointments***';		
		$('#displayAppointment').html(tableDataError);
	}

});