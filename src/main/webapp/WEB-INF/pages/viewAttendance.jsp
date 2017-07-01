<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>


	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.3.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
		<!-- Dashboard Wrapper starts -->
		<div class="dashboard-wrapper">

			<!-- Top Bar starts -->
			<div class="top-bar">
				<div class="page-title">View Attendance</div>
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
								<div class="blog">
									<!-- <div class="blog-header">
										<h5 class="blog-title">Class Creation</h5>
									</div> -->
				    				<div class="blog-body">
										<form:form  commandName="packCmd" method="post" class="form-horizontal" id="student-form" >
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">	
											  	<div class="form-group">
											    	<label for="inputEmail3" class="col-sm-4 control-label">Student Name</label>
											    	<div class="col-sm-8">
														<form:input path="name" placeholder="Enter Student Name" class="form-control" tabindex="2" />
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
											    	<label for="inputPassword3" class="col-sm-4 control-label">Board</label>
											    	<div class="col-sm-8">
														<form:select path="boardName" class="form-control" tabindex="3" onchange="searchStudent(),classNameFilter()" >
															<form:option value="" >-- Choose Board --</form:option>
															<form:options items="${board}"></form:options>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Class</label>
												    <div class="col-sm-8">
														<form:select path="className" class="form-control" tabindex="3" onchange="searchStudent(),sectionFilter()" >
															<form:option value="" >-- Choose Class --</form:option>
															<form:options items="${allClasses}"></form:options>
														</form:select>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Section</label>
												    <div class="col-sm-8">
														<form:select path="section" class="form-control" tabindex="6"  onchange="searchStudent(),mediumFilter()">
															<form:option value="">-- Choose Section --</form:option>
															<form:options items="${allSection}"></form:options>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Medium</label>
												    <div class="col-sm-8">
														<form:select path="medium" tabindex="4" onchange="searchStudent();" class="form-control" required="true">
															<form:option value="">-- Choose Medium --</form:option>
															<form:options items="${mediam}"></form:options>
														</form:select>
														<span class="medium_error" id="medium_error"></span>
													</div>
												</div>
												<form:hidden path="id" />
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Medium</label>
												    <div class="col-sm-8">
														<input id="dob1" type="text">
														<span class="medium_error" id="medium_error"></span>
													</div>
												</div>
											</div>
											
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Medium</label>
												    <div class="col-sm-8">
														<input id="dob2" type="text">
														<span class="medium_error" id="medium_error"></span>
													</div>
												</div>
												<form:hidden path="id" />
											</div>
										</div>
										<div class="row">
											<div class="col-sm-8 col-sm-offset-4">
											  	<div class="form-group">
												  	<div class="col-sm-8 col-sm-offset-2">
														<input type="button" class="btn btn-success" value="Search" onclick="searchStudent()" tabindex="22"/>
														<input type="reset" class="btn btn-danger" id="cancel" tabindex="23"/>
													</div>
											   	</div>
											 </div>
										</div>
										</form:form>
										</div>
									</div> 
								</div>
							</div>
						</div>
						<!-- Row Ends -->
						
						<!-- Row Starts -->
						<div class="row gutter">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="blog">
									<div class="blog-header">
										<h4>Students Attendance List
										&nbsp;&nbsp;
											<button type="button" id="delbtn" onclick="multipledeleteStudent()" style="display: none;border: none;"><i class="fa fa-trash" style="color: red;"></i></button>
										</h4>
									</div>
									<div class="blog-body">
										<div class="table-responsive">
											<div id="basicExample_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
												<div class="row">
													<div class="col-sm-12">
 														<table id="basicExample" class="table table-striped table-condensed table-bordered no-margin dataTable" role="grid" aria-describedby="basicExample_info">
															<thead>
																<tr role="row">
																	<th class="sorting_asc" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">Student</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Board</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Class</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">Section</th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending">Attendance<br>(AM | PM)</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending">Message</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending">Absent on</th>
																</tr>
															</thead>
															<tbody>
																
															</tbody>
														</table>
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


	 var listOrders1 = ${allOrders1};
	if (listOrders1 != "") {
		displayTable(listOrders1);
	}

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
								var tblRow = "<tr align='center' role='row' class='odd'>" 
										+ "<td title='"+orderObj.studentName+"'>"
										+ orderObj.studentName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs title='"+orderObj.boardName+"' >"
										+ orderObj.boardName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs title='"+orderObj.className+"'>"
										+ orderObj.className
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs title='"+orderObj.sectionName+"'>"
										+ orderObj.sectionName
										+ "</td>"
										+ "<td title='"+orderObj.absentSection+"'>"
										+ orderObj.absentSection
										+ "</td>"
										+ "<td title='"+orderObj.message+"'>"
										+ orderObj.message
										+ "</td>"
										+ "<td title='"+orderObj.absentDate+"'>"
										+ orderObj.absentDate
										+ "</td>"
										+ '</tr>';
								$(tblRow).appendTo("#basicExample");
								
								//$("#imageId1").attr('src', "@Url.Content("~/Content/images/ajax_activity.gif)")
							});
	}  
 	
	
	function searchStudent(){
		var studentName = $("#name").val();
		var boardName = $("#boardName").val();
		var className = $('#className').val();
		var section = $('#section').val();
		var name = $('#name').val();
		var medium =$("#medium").val();
		var dob1 =$("#dob1").val();
		var dob2 =$("#dob2").val();
		$.ajax({
			type : "POST",
			url : "filterAttendance.json",
			data : "boardName=" + boardName+"&studentName="+studentName+"&className="+className+"&section="+section+"&name="+name+"&medium="+medium+"&dob1="+dob1+"&dob2="+dob2,
			success : function(response) {
// 				 alert(response); 
				 displayTable(response);
			},
			error : function(e) {
			},
			statusCode : {
				406 : function() {
			
				}
			}
		});
	}

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
</script>
