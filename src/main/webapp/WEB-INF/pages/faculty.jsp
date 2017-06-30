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
				<div class="page-title">Add Faculty</div>
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
										<form:form action="facultySubmit.htm" commandName="packCmd" method="post" class="form-horizontal" id="fac-form">
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Faculty Name</label>
												    <div class="col-sm-8">											
														<form:input path="name" tabindex="1" placeholder="Enter Faculty Name" class="form-control  onlyCharacters" required="true"/>
														<span class="name_error" id="name_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Gender</label>
												    <div class="col-sm-8">
													    <form:select path="gender" tabindex="2" class="form-control" required="true">
															<form:option value="">-- Choose Gender --</form:option>
															<form:option value="Male"> Male</form:option>
															<form:option value="Female">Female</form:option>
														</form:select>
														<span class="gender_error" id="gender_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Qualification</label>
												    <div class="col-sm-8">
														<form:input path="qualification" tabindex="3" placeholder="Enter Qualification" class="form-control onlyCharacters" required="true"/>
														<span class="qualification_error" id="qualification_error"></span>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Contact Number</label>
												    <div class="col-sm-8">
														<form:input path="contactNumber" tabindex="4" placeholder="Enter Contact Mobile Number" class="form-control numericOnly" required="true" maxlength="10"/>
														<span class="contactNumber_error" id="contactNumber_error"></span>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-8 col-sm-offset-4">
												<form:hidden path="id"/>
												<div class="form-group">
												  	<div class="col-sm-8 col-sm-offset-2">
													<input type="submit" class="btn btn-success" tabindex="5"/>
													<button type="button" class="btn btn-danger" id="cancel" tabindex="6">Reset</button>
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
										<h4>List of Faculty</h4>
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
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Gender</th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">Qualification</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending">Mobile</th>
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
   
$("#fac-form").validate({
    errorElement: 'span',
    errorClass: 'has-error',
	rules:
	{
    	name:{required: true,lettersonly:true},
        gender:{required: true},
        /* boardName:{required:true},
	    medium:{required:true},
	    className:{required:true},  
	    section:{required:true},
        subject:{required:true}, */
        qualification:{required: true,lettersonly:true},
        contactNumber:{required:true, number:true, mobileNO:true, minlength:10, maxlength:10},
	},
	messages:
   	{
		name:{required: 'Please Enter Faculty Name'},
		gender:{required:'Please Choose Gender'},
		/* boardName:{required:'Please Choose Board'},
	    medium:{required:'Please Choose Medium'},
	    className:{required:'Please Choose Class'},
	    section:{required:'Please Choose Section'},
        subject:{required:'Please Choose Subject'}, */
        qualification:{required:'Please Enter Qualification'},
        contactNumber:{required:'Please Enter Contact Number',number:'Please Enter only numbers'},
	},
	errorPlacement: function(error, element){
	      if(element.attr("name") == "gender")
	        error.insertAfter(".gender_error").css("color", "red");
	      else
	          error.insertAfter(element);
	}
  });

  $('#cancel').click(function () {
    $("#fac-form").validate().resetForm();
    $("#fac-form").removeClass("has-error");
    $("#name").val('');
    $("#subject").val('');
    $("#qualification").val('');
    $("#contactNumber").val('');
    $("#fac-form").addClass('form-horizontal');
     });
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
								serviceUnitArray[orderObj.id] = orderObj;
								var id = '"' + orderObj.id + '"';
								var tblRow = "<tr align='center' role='row' class='odd'>" + "<td'><a  id='"
										+ orderObj.id
										+ "' href='javascript:forOrderDetails("
										+ id
										+ ")' style='font-color:red'>"
										+ orderObj.id
										+ "</a></td>"
										+ "<td id='"+orderObj.id+"'apdate"+" title='"+orderObj.facutltyName+"'>"
										+ orderObj.facutltyName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.gender+"'>"
										+ orderObj.gender
										+ "</td>"
										+ "<td  title='"+orderObj.qualifaction+"'>"
										+ orderObj.qualifaction
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.contactNumber+"'>"
										+ orderObj.contactNumber
										+ "</td>"
										+ "</td>"
										+ "<td>"
										+ '<a href="javascript:void(0)" onclick=editPack('
										+ orderObj.id + ')'
										+ '  ><i style="color: green;" class="fa fa-edit"></i></a>'+ '&nbsp; | &nbsp;'
										+ '<a style="color: red;" href="javascript:void(0)" onclick=deleteFaculty('
										+ orderObj.id + ')'
										+ '  ><i class="fa fa-trash-o"></i></a>' + '</td>' + '</tr>';
								$(tblRow).appendTo("#basicExample");
							});
	}  
 	
 	function editPack(id) {
		var transactionId = serviceUnitArray[id].id;
		$("#id").val(serviceUnitArray[id].id);
		$("#name").val(serviceUnitArray[id].facutltyName);
		$('#gender').val(serviceUnitArray[id].gender);
		$('#gender').trigger("chosen:updated");
		$('#contactNumber').val(serviceUnitArray[id].contactNumber);
		$('#qualification').val(serviceUnitArray[id].qualifaction);
	} 
	
	function serviceFilter(id){
		var borderId = $("#boardName").val();
		$.ajax({
			type : "POST",
			url : "getBordName.json",
			data : "borderId=" + borderId,
			dataType : "json",
			success : function(response) {
				/* alert(response); */ 
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
/* 	function mediumFilter(id){
		var mediumId = $("#medium").val();
		$.ajax({
			type : "POST",
			url : "getMedium.json",
			data : "mediumId=" + mediumId,
			dataType : "json",
			success : function(response) {
				 alert(response);  
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
	} */
	
	function deleteFaculty(id){
		var facultyId = id;
		var count = 0;
		var checkstr =  confirm('Are you sure you want to delete this?');
		if(checkstr == true){
		  // do your code
		  
		  $.ajax({
					type : "POST",
					url : "deleteFaculty.json",
					data : "facultyId=" + facultyId ,
					success : function(response) {
// 						alert(response);
						displayTable(response);
						window.location.href='addFaculty';
						if(response == null || response == ""){
							$("#emptyMessageId").val("No Results Found");
						}
					},
					error : function(e) {
					}
				});

			
		}else{
		return false;
		}
	}
	
</script>
