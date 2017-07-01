<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>


	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.3.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
<!-- 	<script src="js/chosen.jquery.js"></script> -->

		<!-- Dashboard Wrapper starts -->
		<div class="dashboard-wrapper">

			<!-- Top Bar starts -->
			<div class="top-bar">
				<div class="page-title">Add Student</div>
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
										<h5 class="blog-title">Class Creation</h5>
									</div> -->

<script>
$(document).ready(function () 
{
	$("#totalFee").val("");
	$("#discountFee1").val("");
	$('input[type=file]').change(function () 
	{
		var val = $(this).val().toLowerCase();
		var regex = new RegExp("(.*?)\.(png)$");
 		if(!(regex.test(val))) 
 		{
			$(this).val('');
			$('#blah').attr('src','upload/default.png');
			alert('Please Select .png format only..!');
		} 
 	});
});
</script>

									<div class="blog-body" id="view_list">
										<form:form action="addStudent.htm" commandName="packCmd" method="post" class="form-horizontal" id="student-form" enctype="multipart/form-data">
											
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputEmail3" class="col-sm-4 control-label">Student Name <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:input path="name" placeholder="Enter Student Name" class="form-control onlyCharacters" tabindex="1" required="true"/>
													</div>
												</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
											    	<label for="inputPassword3" class="col-sm-4 control-label">Board Name <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:select path="boardName" class="form-control" tabindex="2" onchange="classNameFilter()" required="true">
															<form:option value="" >-- Choose Board --</form:option>
															<form:options items="${board}"></form:options>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Class <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:select path="className" class="form-control" tabindex="3" onchange="sectionFilter();" required="true">
															<form:option value="">-- Choose Class --</form:option>
															<form:options items="${allClasses}"></form:options>
														</form:select>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Section <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:select path="section" class="form-control" tabindex="4"  onchange="mediumFilter();" quired="true">
															<form:option value="">-- Choose Section --</form:option>
															<form:options items="${allSection}"></form:options>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
											    	<label for="inputPassword3" class="col-sm-4 control-label">Medium <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:select path="medium" class="form-control" tabindex="5" onchange="getFee();" required="true">
															<form:option value="">-- Choose Medium --</form:option>
															<form:options items="${mediam}"></form:options>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											    <div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Fees <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:input path="totalFee" placeholder="Enter Fee Amount" class="form-control numericOnly" tabindex="6" readonly="true"/>
													</div>
											  	</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											   	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Discount </label>
												    <div class="col-sm-8">
														<form:input path="discountFee1" placeholder="Enter Discount Fee Amount" class="form-control numericOnly" tabindex="7"/>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Roll Number</label>
												    <div class="col-sm-8">
														<form:input path="rollNum" placeholder="Enter Roll Number" class="form-control nospecialCharacter" tabindex="8"/>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Admission No. <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:input path="admissionNum" placeholder="Enter Admission Number" class="form-control nospecialCharacter" tabindex="9" required="true"/>
													</div>
											  	</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Father Name <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:input path="fatherName" placeholder="Enter Father Name" class="form-control onlyCharacters" tabindex="10" required="true"/>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Mobile <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:input path="mobile" placeholder="Enter Contact Number" class="form-control numericOnly" tabindex="11"/>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Alternative Mobile</label>
												    <div class="col-sm-8">
														<form:input path="alternativeMobile" placeholder="Enter Alternate Contact Number" class="form-control numericOnly" tabindex="12"/>
													</div>
											  	</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Email</label>
												    <div class="col-sm-8">
														<form:input path="email" placeholder="Enter Email-Id" class="form-control" tabindex="13"/>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Blood Group</label>
												    <div class="col-sm-8">
														<form:select path="blodgroup" tabindex="14" class="form-control">
															<form:option value="">-- Choose Blood Group --</form:option>
															<form:option value="A+">A+</form:option>
															<form:option value="B+">B+</form:option>
															<form:option value="O+">O+</form:option>
															<form:option value="AB+">AB+</form:option>
															<form:option value="A-">A-</form:option>
															<form:option value="B-">B-</form:option>
															<form:option value="O-">O-</form:option>
															<form:option value="AB-">AB-</form:option>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Gender <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:select path="gender" tabindex="15" class="form-control" required="true">
															<form:option value="">-- Choose Gender --</form:option>
															<form:option value="Male"> Male</form:option>
															<form:option value="Female">Female</form:option>
														</form:select>
														<span class="gender_error" id="gender_error"></span>
													</div>
											  	</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Date of Birth <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<div  id="datetimepicker1" class="input-append input-group dtpicker">
															<form:input path="dob1" data-format="yyyy-MM-dd" placeholder="Enter Date of Birth" class="form-control" tabindex="16" required="true"/>
															<span class="input-group-addon add-on">
					                                        	<i data-time-icon="fa fa-times" data-date-icon="fa fa-calendar" class="fa fa-calendar"></i>
					                                      	</span>
				                                      	</div>
														<span class="dob1_error" id="dob1_error"></span>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											    <div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Religion</label>
												    <div class="col-sm-8">
														<form:select path="religion" tabindex="17" class="form-control">
															<form:option value="">-- Choose Religion --</form:option>
															<form:option value="Hindu">Hindu</form:option>
															<form:option value="Muslim">Muslim</form:option>
															<form:option value="Christian">Christian</form:option>
															<form:option value="Sikh">Sikh</form:option>
															<form:option value="Jain">Jain</form:option>
															<form:option value="Parsi">Parsi</form:option>
															<form:option value="Buddhist">Buddhist</form:option>
															<form:option value="Jewish">Jewish</form:option>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Address <span style="color: red;">*</span></label>
												    <div class="col-sm-8">
														<form:input path="address" placeholder="Enter Address" class="form-control" tabindex="18" required="true"/>
													</div>
											  	</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Previous Institute</label>
												    <div class="col-sm-8">
														<form:input path="previousInstitue" placeholder="Enter Previous Institute Name" class="form-control nospecialCharacter onlyCharacters" tabindex="19" />
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Caste</label>
												    <div class="col-sm-8">
														<form:select path="caste" tabindex="20" class="form-control">
															<form:option value="">-- Choose Caste --</form:option>
															<form:option value="OC">OC</form:option>
															<form:option value="BC">BC</form:option>
															<form:option value="SC/ST">SC/ST</form:option>
															<form:option value="OBC">OBC</form:option>
															<form:option value="Others">Others</form:option>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Accommodation</label>
												    <div class="col-sm-8">
														<form:select path="acomitation" tabindex="21" class="form-control">
															<form:option value="">-- Choose Accommodation --</form:option>
															<form:option value="Hostel">Hostel</form:option>
															<form:option value="Day-Scholar">Day-Scholar</form:option>
														</form:select>
													</div>
											  	</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Bus Facility</label>
												    <div class="col-sm-8">
														<form:select path="buspesility" tabindex="22" class="form-control" >
															<form:option value="">-- Choose Bus Facility --</form:option>
															<form:option value="Yes"> Yes</form:option>
															<form:option value="No">No</form:option>
														</form:select>
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											  	<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Bus Route</label>
												    <div class="col-sm-8">
														<form:input path="busroute" placeholder="Enter Bus Route" class="form-control" tabindex="23" />
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
											    	<label for="inputEmail3" class="col-sm-4 control-label">Student Image</label>
											    	<div class="col-sm-8">
														<img id="blah" src='upload/default.png' alt="Student Image" align="middle" style="border-style: solid;height: 100px;width: 100px;border-bottom-style: none;border-left-style: none;border-top-style: none;">
														<input type="file" name="imageName" tabindex="24" id="imageName" onchange="document.getElementById('blah').src = window.URL.createObjectURL(this.files[0])" accept=".png">
											    	</div>
											  	</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-8 col-sm-offset-4">
												<form:hidden path="id" /><br>
											  	<div class="form-group">
												  	<div class="col-sm-8 col-sm-offset-2">
														<input type="submit" class="btn btn-success" value="Register" tabindex="25"/>
														<input type="button" class="btn btn-danger" id="cancel" value="Reset" tabindex="26"/>
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
									<div id="showData" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									
									</div>
								</div>
							</div>
						</div>
						<!-- Row Ends -->
						
						<!-- Row Starts -->
						<div class="row gutter" id="view_list1">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="blog">
									<div class="blog-header">
										<h4>List of Students
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
																	<th><input id="checkAll" class='checkall' type='checkbox'/></th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">Name</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Image</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Roll No.</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Board</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Medium</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending">Father</th>
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

$(function(){
	$(".dtpicker").datetimepicker({dateFormat: 'dd-M-yyyy'});
});

jQuery.validator.addMethod('lettersonly', function(value, element) {
    return this.optional(element) || /^[a-z. áãâäàéêëèíîïìóõôöòúûüùçñ]+$/i.test(value);
}, "Please Enter Valid Name");

   jQuery.validator.addMethod("mobileNO", function(phone_number, element) {
   phone_number = phone_number.replace(/\s+/g, ""); 
 return this.optional(element) || phone_number.length > 9 &&
   phone_number.match(/^[7-9]\d+$/);
}, "Invalid Mobile Number");


    $("#student-form").validate({
    errorElement: 'span',
    errorClass: 'has-error',
	rules:
	{
	    name:{required:	true, lettersonly: true},
	    boardName:{required: true},
	    medium:{required: true},
	    className:{required: true},  
	    section:{required: true},
	    totalFee: {required: true, number: true},
	    discountFee1: {number: true},
// 	    rollNum:{required: true},
	    admissionNum:{required: true},
	    fatherName:{required: true, lettersonly: true},
	    mobile:{required: true, number: true, mobileNO: true, minlength: 10, maxlength: 10},
	    altmobile:{number: true},
	    email:{email: true},
	    gender:{required: true},
	    dob1:{required: true, date: true},
	    address:{required: true},
	    fee:{required: true},
	    pinstitute:{lettersonly: true},
	    fileImage:{extension: "png"},
/* 	    email:{required: true, email: true},
	    bgroup:{required: true},
	    religion:{required: true},
	    caste:{required: true},
	    accomodation:{required: true},
	    busfacility:{required: true},
	    busroute:{required: true}, */
    },
	messages:
	{
	    name:{required: 'Please Enter Name'},
	    boardName:{required: 'Please Select Board'},
	    medium:{required: 'Please Choose Medium'},
	    className:{required: 'Please Choose Class'},
	    section:{required: 'Please Choose Section'},
	    totalFee: {required: 'Please Choose Fees'},
	    discountFee1: {number: 'Please Enter Discount Fee Amount (Eg: 1000,1500 etc.,)'},
// 	    rollNum:{required: 'Please Enter Roll Number'},
	    admissionNum:{required: 'Please Enter Admission Number'},
	    fatherName:{required: 'Please Enter Father Name'},
	    gender:{required: 'Please Choose Gender'},
	    dob1:{required: 'Please Enter Date Of Birth'},
	    mobile:{required: 'Please Enter Mobile Number', number: 'Please Enter 10 digit mobile number'},
	    address:{required: 'Please Enter Address'},
	    fee:{required: 'Please Enter Fee Amount'},
	    altmobile:{number: 'Please Enter only numbers'},
	    email:{email: 'Please Enter Valid Email'},
	    pinstitute:{lettersonly: 'Please Enter Previous Institute Name'},
	    fileImage:{extension: 'Please Choose Only .png'},
/* 		bgroup:{required: 'Please Enter Blood Group'},
	    religion:{required: 'Please Choose Religion'},
	    caste:{required: 'Please Choose Caste'},
	    accomodation:{required: 'Please Choose Accomodation'},
	    busfacility:{required: 'Please Choose Bus Facility'},  
	    busroute:{required: 'Please Enter Bus route'}, */        
    },
    errorPlacement: function(error, element){
      if(element.attr("name") == "gender")
        error.insertAfter(".gender_error").css("color", "red");
      else if(element.attr("name") == "accomodation")
        error.insertAfter(".accomodation_error").css("color", "red"); 
      else if(element.attr("name") == "dob1")
        error.insertAfter(".dob1_error").css("color","red");   
      else if(element.attr("name") == "busroute")
        error.insertAfter(".busroute_error").css("color","red");
      else if(element.attr("name") == "busfacility")
        error.insertAfter(".busfacility_error").css("color","red"); 
      else if(element.attr("name") == "fileImaged")
        error.insertAfter(".fileImaged_error").css("color","red");          
       else if(element.attr("name") == "fileImage")
        error.insertAfter(".fileImage-error").css("color","red");  
      else
        error.insertAfter(element);
      }
});
    

$('#cancel').click(function () {
   	$('#fileImage').val("");      //image will be cleared if selected
   	$('#blah').attr("src","upload/default.png");
  	$("#student-form").validate().resetForm();
    $("#student-form").removeClass("has-error");
    $('#name').val("");
    $('#boardName').val("");
    $('#medium').val("");
    $('#className').val("");
    $('#section').val("");
    $('#dob1').val("");
//     $('#rollNum').val("");
    $('#admissionNum').val("");
    $('#fatherName').val("");
    $('#address').val("");
    $("#totalFee").val("");
	$("#discountFee1").val("");
    $("#student-form").addClass('form-horizontal');
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
			$.each(listOrders,function(i, orderObj) {
								
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
										+ "<td title='"+orderObj.studentName+"'>"
										+ orderObj.studentName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs'><img style='width: 65px;height: 65px;' src='"+orderObj.imagePath+"'/>"
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.rollNum+"'>"
										+ orderObj.rollNum
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.boardName+"' >"
										+ orderObj.boardName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.mediumName+"'>"
										+ orderObj.mediumName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.fatherName+"' >"
										+ orderObj.fatherName
										+ "</td>"
										+ "<td>"
										+ '<a onclick=getApplicant('
										+ orderObj.studentId + ')'
										+ '  ><i style="color: blue;" class="fa fa-file-text"></i></a>' + '&nbsp; | &nbsp;'
										+ '<a href="javascript:void(0)" onclick=editPack('
										+ orderObj.studentId + ')'
										+ '  ><i style="color: green;" class="fa fa-edit"></i></a>' + '&nbsp; | &nbsp;'
										+ '<a style="color: red;" href="javascript:void(0)" onclick=deleteStudent('
										+ orderObj.studentId + ')'
										+ '  ><i class="fa fa-trash-o"></i></a>' + '</td>'
										+ '</tr>';
								$(tblRow).appendTo("#basicExample");
								
								//$("#imageId1").attr('src', "@Url.Content("~/Content/images/ajax_activity.gif)")
							});
		} else {
			//alert('no data to display..');
		}
	}  
 	function editPack(id) {
		var transactionId = serviceUnitArray[id].studentId;
		$("#id").val(serviceUnitArray[id].studentId);
		$("#acomitation").val(serviceUnitArray[id].acomitation);
		$('#address').val(serviceUnitArray[id].address);
		$('#admissionNum').val(serviceUnitArray[id].admissionNum);
		$('#medium').trigger("chosen:updated");
		$('#alternativeMobile').val(serviceUnitArray[id].alternativeMobile);
		$('#blodgroup').val(serviceUnitArray[id].blodgroup);
		$('#blodgroup').trigger("chosen:updated");
		$('#buspesility').val(serviceUnitArray[id].buspesility);
		$('#busroute').val(serviceUnitArray[id].busroute);
		$('#caste').val(serviceUnitArray[id].caste);
		$('#caste').trigger("chosen:updated");
		$('#email').val(serviceUnitArray[id].email);
		$('#fatherName').val(serviceUnitArray[id].fatherName);
		$('#fee').val(serviceUnitArray[id].fee);
		$('#gender').val(serviceUnitArray[id].gender);
		$('#gender').trigger("chosen:updated");
		$('#dob1').val(serviceUnitArray[id].dob);
		$('#previousInstitue').val(serviceUnitArray[id].previousInstitue);
		$('#religion').val(serviceUnitArray[id].religion);
		$('#religion').trigger("chosen:updated");
		$('#rollNum').val(serviceUnitArray[id].rollNum);
		$('#name').val(serviceUnitArray[id].studentName);
		$('#boardName').val(serviceUnitArray[id].boardId);
		$('#boardName').trigger("chosen:updated");
		$('#medium').val(serviceUnitArray[id].mediumId);
		$('#medium').trigger("chosen:updated");
		$('#className').val(serviceUnitArray[id].classId);
		$('#className').trigger("chosen:updated");
		$('#section').val(serviceUnitArray[id].sectionId);
		$('#section').trigger("chosen:updated");
		$("#mobile").val(serviceUnitArray[id].mobile);
		$("#totalFee").val(serviceUnitArray[id].totalFee);
		$("#discountFee1").val(serviceUnitArray[id].discountFee);
		$('#blah').attr('src',''+serviceUnitArray[id].imagePath+'');
		
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

	function deleteStudent(id){
		
		var studentId = id;
		/* $('input[name=checkboxName]:checked').map(function() {
			studentId.push($(this).val());
		}); */
		var count = 0;
		var checkstr =  confirm('are you sure you want to delete this?');
		if(checkstr == true){
		  // do your code
		  
		  $.ajax({
					type : "POST",
					url : "deleteStudent.json",
					data : "studentId=" + studentId ,
					success : function(response) {
						displayTable(response);
						window.location.href='studentHome';
					},
					error : function(e) {
					}
				});
			
		}else{
		return false;
		}
	}
function multipledeleteStudent(){
		
		var studentId = [];
		$('input[name=checkboxName]:checked').map(function() {
			studentId.push($(this).val());
		});
		var count = 0;
		var checkstr =  confirm('are you sure you want to delete this?');
		if(checkstr == true){
		  // do your code
		  
		  $.ajax({
					type : "POST",
					url : "deleteStudent.json",
					data : "studentId=" + studentId ,
					success : function(response) {
						displayTable(response);
					},
					error : function(e) {
					}
				});
			
		}else{
		return false;
		}
	}
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


function getFee(){
	var boardId = $('#boardName').val();
	var className = $('#className').val();
	var mediumId = $('#medium').val();
	var section = $('#section').val();
	 $.ajax({
			type : "POST",
			url : "getClassFee.json",
			data : "boardId=" + boardId+"&className="+className+"&section="+section+"&mediumId="+mediumId,
			success : function(response) {
				/* alert(response); */
				if(response!=""){
				$("#totalFee").val(response.fee);
				}
			},
			error : function(e) {
			}
		});
}

function getApplicant(id)
{
	var image = null; image = serviceUnitArray[id].imagePath;
	if(image == null || image == ""){image= 'upload/default.png';}
	
	var name = null; name = serviceUnitArray[id].studentName;
	if(name == null || name == ""){name = "---";}
// 	alert(serviceUnitArray[id].studentName);
	
	var board = null; board = serviceUnitArray[id].boardName;
	if(board == null || board == ""){board = "---";}
	
	var medium = null; medium = serviceUnitArray[id].mediumName;
	if(medium == null || medium == ""){medium = "---";}
	
	var clas = null; clas = serviceUnitArray[id].className;
	if(clas == null || clas == ""){clas = "---";}
	
	var section = null; section = serviceUnitArray[id].sectionName;
	if(section == null || section == ""){section = "---";}
	
	var rno = null; rno = serviceUnitArray[id].rollNum;
	if(rno == null || rno == ""){rno = "---";}
	
	var adno = null; adno = serviceUnitArray[id].admissionNum;
	if(adno == null || adno == ""){adno = "---";}
	
	var fname = null; fname = serviceUnitArray[id].fatherName;
	if(fname == null || fname == ""){fname = "---";}
	
	var mob = null; mob = serviceUnitArray[id].mobile;
	if(mob == null || mob == ""){mob = "---";}
	
	var alt = null; alt = serviceUnitArray[id].alternativeMobile;
	if(alt == null || alt == ""){alt = "---";}
	
	var email = null; email = serviceUnitArray[id].email;
	if(email == null || email == ""){email = "---";}
	
	var bg = null; bg = serviceUnitArray[id].blodgroup;
	if(bg == null || bg == ""){bg = "---";}
	
	var gender = null; gender = serviceUnitArray[id].gender;
	if(gender == null || gender == ""){gender = "---";}
	
// 	var dob = null; dob = rs.getvar(15);
// 	if(dob == null || dob == ""){dob = "---";}
	
	var rel = null; rel = serviceUnitArray[id].religion;
	if(rel == null || rel == ""){rel = "---";}
	
	var add = null; add = serviceUnitArray[id].address;
	if(add == null || add == ""){add = "---";}
	
	var pre = null; pre = serviceUnitArray[id].previousInstitue;
	if(pre == null || pre == ""){pre = "---";}
	
	var caste = null; caste = serviceUnitArray[id].caste;
	if(caste == null || caste == ""){caste = "---";}
	
	var acc = null; acc = serviceUnitArray[id].acomitation;
	if(acc == null || acc == ""){acc = "---";}
	
	var bus = null; bus = serviceUnitArray[id].buspesility;
	if(bus == null || bus == ""){bus = "---";}
	
	var busrt = null; busrt = serviceUnitArray[id].busroute;
	if(busrt == null || busrt == ""){busrt = "---";}
	
	var tblRow = "<table class='table no-margin' style='width: 50%;'>"
			+"<tr><td style='border: none;'><a style='cursor: pointer;' onclick='getBack()'><i class='fa fa-2x fa-reorder'></i></a></td><td style='border: none;'></td><td style='border: none;'><img style='width: 65px;height: 65px;' src='"+image+"'/></td></tr>"
			
			+"<tr><th>Name</th><td>:</td><td>"+name+"</td></tr>"
			
			+ "<tr><th>Type of Board</th><td>:</td><td>"+board+"</td></tr>"
			
			+ "<tr><th>Medium</th><td>:</td><td>"+medium+"</td></tr>"
			
			+ "<tr><th>Class</th><td>:</td><td>"+clas+"</td></tr>"
			
			+ "<tr><th>Section</th><td>:</td><td>"+section+"</td></tr>"
			
			+ "<tr><th>Roll No</th><td>:</td><td>"+rno+"</td></tr>"
			
			+ "<tr><th>Admission No</th><td>:</td><td>"+adno+"</td></tr>"
			
			+ "<tr><th>Father Name</th><td>:</td><td>"+fname+"</td></tr>"
			
			+ "<tr><th>Mobile No</th><td>:</td><td>"+mob+"</td></tr>"
			
			+ "<tr><th>Alternative No</th><td>:</td><td>"+alt+"</td></tr>"
			
			+ "<tr><th>Email</th><td>:</td><td>"+email+"</td></tr>"
			
			+ "<tr><th>Blood Group</th><td>:</td><td>"+bg+"</td></tr>"
			
			+ "<tr><th>Gender</th><td>:</td><td>"+gender+"</td></tr>"
			
// 			+ "<tr><th>Date Of Birth</th><td>:</td><td>"+dob+"</td></tr>"
			
			+ "<tr><th>Religion</th><td>:</td><td>"+rel+"</td></tr>"
			
			+ "<tr><th>Address</th><td>:</td><td>"+add+"</td></tr>"
			
			+ "<tr><th>Previous Institute</th><td>:</td><td>"+pre+"</td></tr>"
			
			+ "<tr><th>Caste</th><td>:</td><td>"+caste+"</td></tr>"
			
			+ "<tr><th>Accommodation</th><td>:</td><td>"+acc+"</td></tr>"
			
			+ "<tr><th>Bus facility</th><td>:</td><td>"+bus+"</td></tr>"
			
			+ "<tr><th>Bus Route</th><td>:</td><td>"+busrt+"</td></tr>"
			
			+"</table>";
	$(tblRow).appendTo("#showData");
	$("#view_list").hide();
	$('#view_list1').hide();
}

function getBack()
{
	$('#showData').html('');
	$('#view_list').show();
	$('#view_list1').show();
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
	
	 /* $(document).ready(function(){
	 		$("select").chosen({allow_single_deselect:true});
	 }); */

</script>
