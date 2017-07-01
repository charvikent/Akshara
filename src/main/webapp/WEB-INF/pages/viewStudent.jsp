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
				<div class="page-title">View Student</div>
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


				    					 <div class="blog-body" id="view_list">
										<form:form  commandName="packCmd" method="post" class="form-horizontal" id="student-form" enctype="multipart/form-data">
										
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">	
												<div class="form-group">
											    	<label for="inputEmail3" class="col-sm-4 control-label">Student Name</label>
											    	<div class="col-sm-8">
														<form:input path="name" placeholder="Enter Student Name" class="form-control" tabindex="1" />
													</div>
											  	</div>
											</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
										  		<div class="form-group">
										    		<label for="inputPassword3" class="col-sm-4 control-label">Board Name</label>
										    		<div class="col-sm-8">
														<form:select path="boardName" class="form-control" tabindex="2"  onchange="searchStudent(),classNameFilter()">
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
														<form:select path="className" class="form-control" tabindex="3"   onchange="searchStudent(),sectionFilter()">
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
										    		<label for="inputPassword3" class="col-sm-4 control-label">Section</label>
										    		<div class="col-sm-8">
														<form:select path="section" class="form-control" tabindex="4" onchange="searchStudent(),mediumFilter()" >
															<form:option value="">-- Choose Section --</form:option>
															<form:options items="${allSection}"></form:options>
														</form:select>
													</div>
										  		</div>
										  	</div>
										  	<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
										  		<div class="form-group">
										    		<label for="inputPassword3" class="col-sm-4 control-label">Medium</label>
										    		<div class="col-sm-8">
														<form:select path="medium" class="form-control" tabindex="5"  onchange="searchStudent()">
															<form:option value="">-- Choose Medium --</form:option>
															<form:options items="${mediam}"></form:options>
														</form:select>
													</div>
										  		</div>
										  	</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
										  		<div class="form-group">
										    		<label for="inputPassword3" class="col-sm-4 control-label">Roll Number</label>
										    		<div class="col-sm-8">
														<form:input path="rollNum" placeholder="Enter Roll Number" class="form-control" tabindex="6" />
													</div>
										  		</div>
										  	</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
										  		<div class="form-group">
										    		<label for="inputPassword3" class="col-sm-4 control-label">Admission No.</label>
												    <div class="col-sm-8">
														<form:input path="admissionNum" placeholder="Enter Admission Number" class="form-control" tabindex="7" />
													</div>
										  		</div>
										  	</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
										  		<div class="form-group">
										    		<label for="inputPassword3" class="col-sm-4 control-label">Mobile</label>
										    		<div class="col-sm-8">
														<form:input path="mobile" placeholder="Enter Contact Number" class="form-control" tabindex="8"/>
													</div>
										  		</div>
										  	</div>
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
										  		<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Email</label>
												    <div class="col-sm-8">
														<form:input path="email" placeholder="Enter Email-Id" class="form-control" tabindex="9"/>
													</div>
										  		</div>
										  	</div>
										</div>
										<div class="row">
											<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
												<div class="form-group">
												    <label for="inputPassword3" class="col-sm-4 control-label">Caste</label>
												    <div class="col-sm-8">
														<form:select path="caste" tabindex="10" class="form-control">
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
										</div>
										<div class="row">
											<div class="col-sm-8 col-sm-offset-4">
												<form:hidden path="id" /><br>
										  		<div class="form-group">
												  	<div class="col-sm-8 col-sm-offset-2">
														<input type="button" class="btn btn-success" value="Search" onclick="searchStudent()" tabindex="11"/>
														<input type="reset" class="btn btn-danger" id="cancel" tabindex="12"/>
													</div>
										   		</div>
										   	</div>
										</div>
										</form:form>
					
									</div>
									<div id="showData" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<input type ="hidden" value="${baseUrl }" id="baseUrl1">
									</div>
								</div>
							</div>
						</div>
						<!-- Row Ends -->
						
						<!-- Row Starts -->
						<div class="row" id="view_list1">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="blog">
									<div class="blog-header">
										<h4>List of Students</h4>
									</div>
									<div class="blog-body">
										<div class="table-responsive">
											<div id="basicExample_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
												<div class="row">
													<div class="col-sm-12">
 														<table id="basicExample" class="table table-striped table-condensed table-bordered no-margin dataTable" role="grid" aria-describedby="basicExample_info">
															<thead>
																<tr role="row">
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

var serviceUnitArray = {};
var baseUrl2 =$("#baseUrl1").val();
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
    $('#rollNum').val("");
    $('#admissionNum').val("");
    $('#fatherName').val("");
    $('#address').val("");
    $('#fee').val("");
    $("#student-form").addClass('form-horizontal');
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
								serviceUnitArray[orderObj.studentId] = orderObj;
								var id = '"' + orderObj.studentId + '"';
								var tblRow = "<tr align='center' role='row' class='odd'>" + "<td'><a id='"
										+ orderObj.studentId
										+ "' href='javascript:forOrderDetails("
										+ orderObj.studentId
										+ ")' style='font-color:red'>"
										+ orderObj.studentId
										+ "</a></td>"
										+ "<td title='"+orderObj.studentName+"'>"
										+ orderObj.studentName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs'><img style='width: 65px;height: 65px;' src='"+baseUrl2+"/"+orderObj.imagePath+"'/>"
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
										+ "<td align='center'>"
										+ '<a onclick=getApplicant('+orderObj.studentId+')>'
										+ '<i style="cursor: pointer;color: blue;" class="fa fa-file-text"></i></a>' 
										+ '</td>'
										+ '</tr>';
								$(tblRow).appendTo("#basicExample");
								
								//$("#imageId1").attr('src', "@Url.Content("~/Content/images/ajax_activity.gif)")
							});
	}  
 	
	function searchStudent(){
		var studentName = $("#name").val();
		var boardName = $("#boardName").val();
		var admissionNum = $('#admissionNum').val();
		var medium = $('#medium').val();
		var caste = $('#caste').val();
		var email = $('#email').val();
		var studentName = $('#name').val();
		var className = $('#className').val();
		var section = $('#section').val();
		var mobile = $("#mobile").val();
		$.ajax({
			type : "POST",
			url : "getStudetnDetails.json",
			dataType : "json",
			data : "boardName=" + boardName+"&admissionNum="+admissionNum +"&medium="+medium+"&caste="+caste+"&email="+email+"&studentName="+studentName+"&className="+className+"&section="+section+"&mobile="+mobile+"&studentName="+studentName,
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
	
 	var dob = null; dob = serviceUnitArray[id].dob;
 	if(dob == null || dob == ""){dob = "---";}
	
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
	
	var tblRow = "<div class='row'>"
				+	"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"
				+		"<div class='form-group'>"
				+			"<input id='printbtn' class='btn btn-default' type='button' value='Print' onclick=PrintElem('#showData') />"
				+			"<a style='cursor: pointer;color: red;float: right;' onclick='getBack()'><i class='fa fa-2x fa-times'></i></a>&nbsp;&nbsp;"
				+		"</div>"
				+	"</div>"
				+"</div>"
				
				+"<div class='row' style='font-family: sans-serif;'>"
				+	"<div class='col-lg-4 col-md-4 col-sm-6 col-xs-6'>"
				+		"<img style='float: right;width: 100px;height: 120px;' src='"+image+"'/>"
				+	"</div>"
				+	"<div class='col-lg-8 col-md-8 col-sm-6 col-xs-6'>"
				+		"<div class='row'>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>1. Name of the Student: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+name+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>2. Board: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+board+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>3. Class: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+clas+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>4. Section: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+section+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>5. Medium: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+medium+"</span></div>"
				+				"</div>"
				+			"</div>"
				/* +			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>6. Fees: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+gender+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>7. Discount: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+gender+"</span></div>"
				+				"</div>"
				+			"</div>" */
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>6. Roll Number: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+rno+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>7. Admission Number: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+adno+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>8. Father Name: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+fname+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>9. Mobile: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+mob+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>10. Alternate Mobile: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+alt+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>11. Email: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+email+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>12. Blood Group: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+bg+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>13. Gender: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+gender+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>14. Date of Birth: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+dob+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>15. Religion: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+rel+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>16. Address: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+add+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>17. Previous Institute: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+pre+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>18. Caste: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+caste+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>19. Accommodation: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+acc+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>20. Bus Facility: &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+bus+"</span></div>"
				+				"</div>"
				+			"</div>"
				+			"<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='line-height: 2em'>"
				+				"<div class='form-group'>"
				+					"<div class='' style='font-size: 20px;'>21. Bus Route &nbsp;&nbsp;&nbsp;&nbsp;<span style='font-size: 20px;'>"+busrt+"</span></div>"
				+				"</div>"
				+			"</div>"
				+		"</div>"
				+	"</div>"
// 				+	"<div class='col-lg-4 col-md-4 col-sm-6 col-xs-6'>"
// 				+		"<img style='float: right;width: 100px;height: 120px;' src='"+image+"'/>"
// 				+	"</div>"
				+"</div>"
		
		/* "<table class='table no-margin' style=''>"
			+"<tr>"
			+	"<td style='border: none;'>"
			+		"<a style='cursor: pointer;' onclick='getBack()'><i class='fa fa-2x fa-reorder'></i></a>&nbsp;&nbsp;"
			+		"<input id='printbtn' class='btn btn-default' type='button' value='Print' onclick=PrintElem('#showData') />"
			+	"</td>"
			+	"<td style='border: none;'>"
			+	"</td><td style='border: none;'><img style='float: right;width: 65px;height: 65px;' src='"+image+"'/></td>"
			+"</tr>"
			
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
			
			+"</table>"; */
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

function PrintElem(elem)
{
	$("#printbtn").hide();
    Popup($(elem).html());
}

function Popup(data)
{
    var mywindow = window.open('', 'new div');
    mywindow.document.write('<html><head><title>Student Application</title>');
    /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="css/main.css" type="text/css" />');
    mywindow.document.write('</head><body >');
    mywindow.document.write(data);
    mywindow.document.write('</body></html>');
    mywindow.print();
    mywindow.close();
    $("#printbtn").show();
    return true;
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
