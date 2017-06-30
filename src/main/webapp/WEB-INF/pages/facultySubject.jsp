<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.3.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
	<script src="js/dropdownsearch.js"></script>
	<link href="css/dropdownsearch.css"/>
	
		<!-- Dashboard Wrapper starts -->
		<div class="dashboard-wrapper">

			<!-- Top Bar starts -->
			<div class="top-bar">
				<div class="page-title">Add Faculty Subject</div>
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
									<!-- <div class="blog-header">
										<h5 class="blog-title">Add Faculty</h5>
									</div> -->
									<div class="blog-body">
										<form:form action="addFacultySubjects.htm" commandName="packCmd" method="post" class="form-horizontal" id="sub-form">
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Faculty Name</label>
												    <div class="col-sm-8">
														<form:select path="facultyId" tabindex="1" onchange="serviceFilter()" class="form-control" required="true">
															<form:option value="" >-- Choose Faculty --</form:option>
															<form:options items="${faculty}"></form:options>
														</form:select>
														<span class="facultyId_error" id="facultyId_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Board Name</label>
												    <div class="col-sm-8">
														<form:select path="boardName" tabindex="2" onchange="classNameFilter()" class="form-control" required="true">
															<form:option value="">-- Choose Board --</form:option>
															<form:options items="${board}"></form:options>
														</form:select>
														<span class="boardName_error" id="boardName_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Class</label>
												    <div class="col-sm-8">
														<form:select path="className" tabindex="4" class="form-control" onchange="sectionFilter()" required="true">
															<form:option value="">-- Choose Class --</form:option>
															<form:options items="${allClasses}"></form:options>
														</form:select>
														<span class="className_error" id="className_error"></span>
													</div>
												</div>
											</div>
												<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Section</label>
												    <div class="col-sm-8">
														<form:select path="section" tabindex="5" class="form-control" onchange="mediumFilter()" required="true">
															<form:option value="">-- Choose Section --</form:option>
															<form:options items="${allSection}"></form:options>
														</form:select>
														<span class="section_error" id="section_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Medium</label>
												    <div class="col-sm-8">	
														<form:select path="medium" tabindex="3"   class="form-control"  required="true">
															<form:option value="">-- Choose Medium --</form:option>
															<form:options items="${mediam}"></form:options>
														</form:select>
														<span class="medium_error" id="medium_error"></span>
													</div>
												</div>
											</div>
											
										
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Subject</label>
												    <div class="col-sm-8">
														<form:select path="subject" tabindex="6" class="form-control" required="true">
															<form:option value="">-- Choose Subject --</form:option>
															<form:options items="${subject}"></form:options>
														</form:select>
														<span class="subject_error" id="subject_error"></span>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-8 col-sm-offset-4">
													<form:hidden path="id"/>
													<div class="form-group">
													  	<div class="col-sm-8 col-sm-offset-2">
														<input type="submit" class="btn btn-success" tabindex="7"/>
														<button type="button" class="btn btn-danger" id="cancel" tabindex="8">Reset</button>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-8 col-sm-offset-4">
													<div class="form-group">
														<div class="col-sm-8 col-sm-offset-2">
														<%
															String message = null;
															message=(String)session.getAttribute("message");
													        if(message!=null)
													        {
																out.println("<span class='' style='color: red;'>"+message+"</span>");
																session.setAttribute("message", null);
															}
												        %>
														</div>
													</div>
												</div>
											</div>
										</form:form>
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
										<h4>List of Faculty-Subjects</h4>
									</div>
									<div class="blog-body">
										<div class="table-responsive">
											<div id="basicExample_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
												<div class="row">
													<div class="col-sm-12">
 														<table id="basicExample" class="table table-striped table-condensed table-bordered no-margin dataTable" role="grid" aria-describedby="basicExample_info">
															<thead>
																<tr role="row">
																	<th class="sorting_asc" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">Name</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Board</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Medium</th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">Class</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending">Section</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending">Subject</th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Salary: activate to sort column ascending">Action</th>
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

 jQuery.validator.addMethod('lettersonly', function(value, element) {
    return this.optional(element) || /^[a-z. áãâäàéêëèíîïìóõôöòúûüùçñ]+$/i.test(value);
}, "Please Enter Valid Name");

jQuery.validator.addMethod("mobileNO", function(phone_number, element) {
   phone_number = phone_number.replace(/\s+/g, ""); 
 return this.optional(element) || phone_number.length > 9 &&
   phone_number.match(/^[7-9]\d+$/);
}, "Invalid Mobile Number");
   
$("#sub-form").validate({
    errorElement: 'span',
    errorClass: 'has-error',
	rules:
	{
		facultyId:{required: true},
        boardName:{required:true},
	    medium:{required:true},
	    className:{required:true},  
	    section:{required:true},
        subject:{required:true},
	},
	messages:
   	{
		facultyId:{required: 'Please Choose Faculty'},
		boardName:{required:'Please Choose Board'},
	    medium:{required:'Please Choose Medium'},
	    className:{required:'Please Choose Class'},
	    section:{required:'Please Choose Section'},
        subject:{required:'Please Choose Subject'},
	},
  });

  $('#cancel').click(function () {
    $("#sub-form").validate().resetForm();
    $("#sub-form").removeClass("has-error");
    $("#facultyId").val('');
    $("#medium").val('');
    $("#subject").val('');
    $("#sub-form").addClass('form-horizontal');
     });
	 var listOrders1 = ${allOrders1};
	if (listOrders1 != "") {
		displayTable(listOrders1);
	}

 	function displayTable(listOrders) {
		if (listOrders != null) {
			$("#basicExample tr td").remove();
			$("#basicExample td").remove();
			serviceUnitArray = {};
			$
					.each(
							listOrders,
							function(i, orderObj) {
								
// 								contactNumber":"wertewrt","mediumId":"16","subjectId":"","name":"0","boardid":"1","gender":null,"className":"","qualifaction":"ewrt","section":""
								serviceUnitArray[orderObj.id] = orderObj;
								var id = '"' + orderObj.id + '"';
								var tblRow = "<tr align='center'>" + "<td'><a  id='"
										+ orderObj.id
										+ "' href='javascript:forOrderDetails("
										+ id
										+ ")' style='font-color:red'>"
										+ orderObj.id
										+ "</a></td>"
										+ "<td id='"+orderObj.id+"'apdate"+" title='"+orderObj.facultyName+"'>"
										+ orderObj.facultyName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.boardName+"'>"
										+ orderObj.boardName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.mediumName+"' >"
										+ orderObj.mediumName
										+ "</td>"
										+ "<td title='"+orderObj.className+"'>"
										+ orderObj.className
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.sectionName+"' >"
										+ orderObj.sectionName
										+ "</td>"
										+ "<td title='"+orderObj.subjectName+"' >"
										+ orderObj.subjectName
										+ "</td>"
										+ "<td>"
										+ '<a href="javascript:void(0)" onclick=editPack('
										+ orderObj.id + ')'
										+ '  ><i style="color: green;" class="fa fa-edit"></i></a>' + '&nbsp; | &nbsp;'
										+ '<a style="color: red;" href="javascript:void(0)" onclick=deletefacultysubject('
										+ orderObj.id + ')'
										+ '  ><i class="fa fa-trash-o"></i></a>' + '</td>'
										
										+ '</tr>';
								$(tblRow).appendTo("#basicExample");
							});
		} else {
			//alert('no data to display..');
		}
	}  
 	function editPack(id) {
		var transactionId = serviceUnitArray[id].id;
		$("#id").val(serviceUnitArray[id].id);
		$("#facultyId").val(serviceUnitArray[id].facultyId);
		$('#facultyId').trigger("chosen:updated");
		$('#boardName').val(serviceUnitArray[id].boardId);
		$('#boardName').trigger("chosen:updated");
		$('#medium').val(serviceUnitArray[id].mediumId);
		$('#medium').trigger("chosen:updated");
		$('#className').val(serviceUnitArray[id].classId);
		$('#className').trigger("chosen:updated");
		$('#section').val(serviceUnitArray[id].sectionId);
		$('#section').trigger("chosen:updated");
		$('#subject').val(serviceUnitArray[id].subjectId);
		$('#subject').trigger("chosen:updated");
	} 
	
	function serviceFilter(id){
		var borderId = $("#boardName").val();
		$.ajax({
			type : "POST",
			url : "getBordName.json",
			data : "borderId=" + borderId,
			dataType : "json",
			success : function(response) {
				var optionsForClass = "";
				optionsForClass = $("#medium").empty();
				optionsForClass.append(new Option("--Select--", ""));
				$.each(response, function(i, tests) {
					var id=tests.id;
					var name=tests.name;
					optionsForClass.append(new Option(name, id));
				});
				$('#medium').trigger("chosen:updated");
			},
			error : function(e) {
			},
			statusCode : {
				406 : function() {
			
				}
			}
		});
	} 
 	function deletefacultysubject(id){
 		var facultySubject = id;
		var count = 0;
		var checkstr =  confirm('Are you sure you want to delete this?');
		if(checkstr == true){
		  // do your code
		  
		  $.ajax({
					type : "POST",
					url : "deleteFacultySubject.json",
					data : "facultySubject=" + facultySubject ,
					success : function(response) {
// 						alert(response);
						displayTable(response);
						window.location.href='facultySubject';
					},
					error : function(e) {
					}
				});
			
		}else{
		return false;
		}
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
// 				  alert(response);  
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
