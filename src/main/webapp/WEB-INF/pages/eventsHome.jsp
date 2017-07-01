<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.3.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>

<%
Date date = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(date);  
int hours = cal.get(Calendar.HOUR_OF_DAY);
  System.out.println(hours);
%>
		<!-- Dashboard Wrapper starts -->
		<div class="dashboard-wrapper">

			<!-- Top Bar starts -->
			<div class="top-bar">
				<div class="page-title">Notification</div>
			</div>
			<!-- Top Bar ends -->

			<!-- Main Container starts -->
			<div class="main-container">

				<!-- Container fluid Starts -->
				<div class="container-fluid">

					<!-- Spacer starts -->
					<div class="spacer">
						<!-- Row Starts -->
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="blog" style="border: 1px solid;">
									<div class="blog-header">
										<h5 class="blog-title">Send Notification</h5>
									</div>
									<div class="blog-body">
										<form:form action="" commandName="packCmd" method="post" class="form-horizontal" id="msg-form1">
										<div class="row">
											<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Board Name</label>
												    <div class="col-sm-8">
														<form:select path="boardName"  tabindex="1" onchange="selectOrders(),classNameFilter()" class="form-control" required="true">
															<form:option value="">-- Choose Board --</form:option>
															<form:options items="${board}"></form:options>
														</form:select>
														<span class="boardName_error" id="boardName_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Class</label>
												    <div class="col-sm-8">
														<form:select path="className" tabindex="2" onchange="selectOrders(),sectionFilter()" class="form-control" required="true">
															<form:option value="">-- Choose Class --</form:option>
															<form:options items="${allClasses}"></form:options>
														</form:select>
														<span class="className_error" id="className_error"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Section</label>
												    <div class="col-sm-8">
														<form:select path="section" tabindex="3" onchange="selectOrders(),mediumFilter()" class="form-control" required="true">
															<form:option value="">-- Choose Section --</form:option>
															<form:options items="${allSection}"></form:options>
														</form:select>
														<span class="section_error" id="section_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Medium</label>
												    <div class="col-sm-8">
														<form:select path="medium" tabindex="4" onchange="selectOrders()" class="form-control" required="true">
															<form:option value="">-- Choose Medium --</form:option>
															<form:options items="${mediam}"></form:options>
														</form:select>
														<span class="medium_error" id="medium_error"></span>
													</div>
												</div>
											</div>
										</div>
											<form:hidden path="id" tabindex="1" />
											
										</form:form>
										<!-- <input type="button" value="selectAll" id="selectAll"> -->
									</div>
								</div>
							</div>
						</div>
						<!-- Row Ends -->
						
						<!-- Row Starts -->
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="blog">
									<!-- <div class="blog-header">
										<h5 class="blog-title">Send Message/Email</h5>
									</div> -->
									<div class="blog-body">
										<div id="filterId">
											<%-- <table class="table no-margin">
												<caption style="color: black;"><h4>Send Message/Email</h4></caption>
										        <thead>
										          <tr>
											          <th>#</th>
											          <th class='hidden-sm hidden-xs'>Adm.no</th>
											          <th>Student Name</th>
											          <th class='hidden-sm hidden-xs'>Board</th>
											          <th class='hidden-sm hidden-xs'>Medium</th>
											          <th class='hidden-sm hidden-xs'>Gender</th>
											          <th>Father Name</th>
											          <th class='hidden-sm hidden-xs'>Email</th>
											          <th class='hidden-sm hidden-xs'>Address</th>
											      </tr>
										        </thead>
										        <tbody id="itemContainer">
										        </tbody>
											</table> --%>
											
										<div class="table-responsive">
											<div id="basicExample_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
												<div class="row">
													<div class="col-sm-12">
													checkbox<input id="checkAll" class='checkall' type='checkbox'/>
 														<table id="basicExample" class="table table-striped table-condensed table-bordered no-margin dataTable" role="grid" aria-describedby="basicExample_info" style="width: 100%;">
															<thead>
																<tr role="row">
																	<th></th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">Adm. no</th>
																	<th class="sorting_asc" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">Student</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Board</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Medium</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">Gender</th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending">Father</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending">Email</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending">Address</th>
																</tr>
															</thead>
															<tbody>
																
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
							
											<div class="row">
											<span class="studentId_error" id="studentId_error" style="color: red;margin: 0px;display: block !important;position: absolute;margin-left: 1em;"></span>
												
												<br><br><br>
												<div class="form-group">
											    	<label for="inputEmail3" class="col-sm-4 col-xs-4 control-label" style="text-align: right;">Message: </label>
											    	<div class="col-sm-8 col-xs-8">
														<textarea id="messageId" class="form-control" placeholder="Please Enter Message" style="margin: 0px;height: 75px;" required></textarea>
														<span class="messageId_error" id="messageId_error" style="color: red;"></span>
										            </div>
												</div>
												<br><br><br><br><br>
												
												<div class="clearfix"></div>
												<br>
												<div class="form-group">
											    	<label for="inputEmail3" class="col-sm-4 col-xs-4 control-label" style="text-align: right;">Notify Type: </label>
											    	<div class="col-sm-8 col-xs-8">
														<select id="notificatinId" class="form-control" required="required">
															<option value="">-- Select Notify Type --</option>
															<option value=1>SMS</option>
															<option value=2>Email</option>
															<option value=3>SMS+Email</option>
														</select>
														<span class="notificatinId_error" id="notificatinId_error" style="color: red;"></span>
										            </div>
												</div>
												<br><br><br>
												<div class="clearfix"></div>
												<div class="form-group">
    												<div class="col-sm-8 col-sm-offset-4 col-xs-offset-4">
														<input type="button" class="btn btn-info" value="Send" onclick="sendAttendance()">
														<input type="button" class="btn btn-danger" id="cancel" value="Cancel" onclick="cancelForm()" >
													</div>
												</div>
											</div>
											
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Row Ends -->
						
					</div>
					<!-- Spacer ends -->

				</div>
				<!-- Container fluid ends -->

			</div>
			<!-- Main Container ends -->

		</div>
		<!-- Dashboard Wrapper ends -->

<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script> -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
	$("#filterId").hide();
	var listOrders1 = ${allOrders1};
	if (listOrders1 != null) {
		displayTable(listOrders1);
	}
});

function classNameFilter(id){
	var boardId = $("#boardName").val();
	if(boardId.length !=0){
	$.ajax({
		type : "POST",
		url : "getClassNameFilter.json",
		data : "boardId=" + boardId,
		dataType : "json",
		success : function(response) {
			 /* alert(response); */  
			var optionsForClass = "";
			optionsForClass = $("#className").empty();
			optionsForClass.append(new Option("-- Choose Class --", ""));
			$.each(response, function(i, tests) {
				var id=tests.id;
				var className=tests.className;
				optionsForClass.append(new Option(className, id));
			});
			$('#className').trigger("chosen:updated");
		},
		error : function(e) {
		},
		statusCode : {
			406 : function() {
		
			}
		}
	});
	}
} 
	function sectionFilter(){
	var boardId = $("#boardName").val();
	var classId = $("#className").val();
	if(boardId.length !=0 && classId.length != 0){
	$.ajax({
		type : "POST",
		url : "getSectionFilter.json",
		data : "boardId=" + boardId+"&classId="+classId,
		dataType : "json",
		success : function(response) {
			 /* alert(response); */  
			var optionsForClass = "";
			optionsForClass = $("#section").empty();
			optionsForClass.append(new Option("-- Choose Section --", ""));
			$.each(response, function(i, tests) {
				var id=tests.id;
				var sectionName=tests.sectionName;
				optionsForClass.append(new Option(sectionName, id));
			});
			$('#section').trigger("chosen:updated");
		},
		error : function(e) {
		},
		statusCode : {
			406 : function() {
		
			}
		}
	});
	}
} 
	function mediumFilter(){
	var boardId = $("#boardName").val();
	var classId = $("#className").val();
	var sectionId = $("#section").val();
	if(boardId.length !=0 && classId.length != 0 &&  sectionId.length != 0){
	$.ajax({
		type : "POST",
		url : "getMediumFilter.json",
		data : "boardId=" + boardId+"&classId="+classId+"&sectionId="+sectionId,
		dataType : "json",
		success : function(response) {
			 /* alert(response); */  
			var optionsForClass = "";
			optionsForClass = $("#medium").empty();
			optionsForClass.append(new Option("-- Choose Medium --", ""));
			$.each(response, function(i, tests) {
				var id=tests.id;
				var mediumName=tests.mediumName;
				optionsForClass.append(new Option(mediumName, id));
			});
			$('#section').trigger("chosen:updated");
		},
		error : function(e) {
		},
		statusCode : {
			406 : function() {
		
			}
		}
	});
	}
} 
/* 
$("#msg-form1").validate({
	errorElement: 'span',
    errorClass: 'has-error',
	rules:
    {
		boardName:{required: true},
	 	medium:{required: true},
		className:{required: true},
		section:{required: true},
	},
	messages:
	{
      	boardName:{required: 'Please Choose Board'},
        medium:{required: 'Please Choose Medium'},
		className:{required: 'Please Choose Class'},
		section:{required: 'Please Choose Section'},
	},

	errorPlacement: function(error, element)
	{
       if(element.attr("name") == "boardName")
        error.insertAfter(".boardName_error").css("color", "red"); 
       else if(element.attr("name") == "medium")
        error.insertAfter(".medium_error").css("color", "red");
       else if(element.attr("name") == "className")
        error.insertAfter(".className_error").css("color", "red");
       else if(element.attr("name") == "section")
        error.insertAfter(".section_error").css("color", "red");
      else
        error.insertAfter(element);
	}	
  
  });

  $('#cancel').click(function () {
    $("#msg-form1").validate().resetForm();
    $("#msg-form1").removeClass("has-error");
    $("#boardName").val('');
    $("#medium").val('');
    $("#className").val('');
    $("#section").val('');
    $("#msg-form1").addClass('form-horizontal');
   
  });
 */

	 
 
	function displayTable(listOrders) {
			$("#basicExample tr td").remove();
			$("#basicExample td").remove();
			serviceUnitArray = {};
			$
					.each(
							listOrders,
							function(i, orderObj) {
								
// 								contactNumber":"wertewrt","mediumId":"16","subjectId":"","name":"0","boardid":"1","gender":null,"className":"","qualifaction":"ewrt","section":""
								serviceUnitArray[orderObj.studentId] = orderObj;
								var id = '"' + orderObj.studentId + '"';
								var tblRow = "<tr align='center' role='row' class='odd'>" + "<td'><a id='"
										+ orderObj.studentId
										+ "' href='javascript:forOrderDetails("
										+ orderObj.studentId
										+ ")' style='font-color:red'>"
										+ orderObj.studentId
										+ "</a></td>"
										+"<td><input class='checkall' type='checkbox' name='checkboxName' id='"+orderObj.studentId+"' value='"+orderObj.studentId+"'/></td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.admissionNum+"'>"
										+ orderObj.admissionNum
										+ "</td>"
										+ "<td title='"+orderObj.studentName+"'>"
										+ orderObj.studentName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.boardName+"' >"
										+ orderObj.boardName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.mediumName+"'>"
										+ orderObj.mediumName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.gender+"' >"
										+ orderObj.gender
										+ "</td>"
										+ "<td title='"+orderObj.fatherName+"' >"
										+ orderObj.fatherName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.email+"' >"
										+ orderObj.email
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.address+"' >"
										+ orderObj.address
										+ "</td>"
										+ '</tr>';
								$(tblRow).appendTo("#basicExample");
								
								//$("#imageId1").attr('src', "@Url.Content("~/Content/images/ajax_activity.gif)")
							});
	} 

	

	 function selectOrders(){
		 $("#filterId").show();
		 var boardName = $("#boardName").val();
		// alert(serviceId);
		 var medium = $("#medium").val();
		 var className = $("#className").val();
		 var section = $("#section").val();
// 		$("#basicExample tr").remove();
// 		$("#basicExample tr td").remove(); 
		 $.ajax({
				type : "POST",
				url : "getStudetnDetails.json",
				data : "boardName=" + boardName+"&medium="+medium +"&className="+className+"&section="+section,
				dataType : "json", 
				success : function(response) {
					/* alert(response); */ 
					displayTable(response);
					//resetStatus(serviceId);
					//resetVendor(serviceId);
					
				},
				error : function(e) {
				}
			});
	 }
	 
	
	 
	 function sendAttendance(){
		 
		 $("#studentId_error").text('');
		 $("#messageId_error").text('');
		 $("#notificatinId_error").text('');
		 $("#absentId_error").text('');
			var studentId = [];
			$('input[name=checkboxName]:checked').map(function() {
				studentId.push($(this).val());
			});
			var message=$("#messageId").val();
			var absentId=$("#absentId").val();
			var notificatinId=$("#notificatinId").val();
			if(studentId.length == 0 || message.length ==0 || notificatinId.length == 0  ){
				
				if(studentId.length == 0){
// 					alert("please select student");
					$("#studentId_error").text('Please Select atleast One Student');
				}
				if(message.length == 0){
// 					alert("please select message");
					$("#messageId_error").text('Please Enter Message');
				}
				if(notificatinId.length == 0){
// 					alert("please select notificatinId");
					$("#notificatinId_error").text('Please Choose Type of Notification');
				}
				
			}else{
			
			 $.ajax({
					type : "POST",
					url : "sendEvent.htm",
					data : "studentId=" + studentId+"&message="+message +"&notificatinId="+notificatinId,
					success : function(response) {
						/* alert(response); */ 
						  location.reload();
						
					},
					error : function(e) {
					}
				});
			}
	 }
	 function cancelForm(){
		 /* $("#basicExample tr td").remove();
			$("#basicExample td").remove();
			$("#filterId").hide(); */
		window.location.href="eventsHome";
	 }
	 
	 $("#absentId").click(function () 
		  		{
		  			var value1 = "<%=hours%>";
		  			if(value1 >= 12){
		  	  			$('#absentId').children('option[value="morning"]').attr('disabled', true);
		  	  		}
		  			else if(value1 <= 12){
		  	  			$('#absentId').children('option[value="afternoon"]').attr('disabled', true);
		  	  		}
		  		});
	 $("#checkAll").change(function () {
			$("input:checkbox").prop('checked', $(this).prop("checked"));
			var len=$("[name='checkboxName']:checked").length;
			if(len!=0)
			{
				$('#delbtn').show();
			}
			else
			{
				$('#delbtn').hide();
			}
		});
		$(".checkall").change(function () {
			var len=$("[name='checkboxName']:checked").length;
			if(len!=0)
			{
				$('#delbtn').show();
			}
			else
			{
				$('#delbtn').hide();
			}
		});

</script>
