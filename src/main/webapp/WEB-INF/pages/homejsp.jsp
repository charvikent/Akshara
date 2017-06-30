<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
				<div class="page-title">Class Creation</div>
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
									<div class="blog-body">
<%-- 									<%${message} %> --%>
			
									<form:form action="addclass.htm" commandName="packCmd" method="post" id="cls-form" class="form-horizontal">
									<div class="row">
										<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											<div class="form-group">
											    <label for="inputEmail3" class="col-sm-4 control-label">Board Name</label>
											    <div class="col-sm-8">
												    <form:select path="boardId" tabindex="1" class="form-control" required="true">
														<form:option value="">-- Choose Board --</form:option>
														<form:options items="${board}"></form:options>
													</form:select>
													<span class="boardId_error" id="boardId_error"></span>
												</div>
											</div>
										</div>
										<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											<div class="form-group">
											    <label for="inputEmail3" class="col-sm-4 control-label">Medium</label>
											    <div class="col-sm-8">
												    <form:select path="mediumId" tabindex="2" class="form-control" required="true">
														<form:option value="">-- Choose Medium --</form:option>
														<form:options items="${mediam}"></form:options>
													</form:select>
													<span class="mediumId_error" id="mediumId_error"></span>
												</div>
											</div>
										</div>
										<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											<div class="form-group">
											    <label for="inputEmail3" class="col-sm-4 control-label">Class</label>
											    <div class="col-sm-8">
												    <form:select path="className" tabindex="3" class="form-control" required="true">
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
												    <form:select path="section" tabindex="4" class="form-control" required="true">
														<form:option value="">-- Choose Section --</form:option>
														<form:options items="${allSection}"></form:options>
													</form:select>
													<span class="section_error" id="section_error"></span>
												</div>
											</div>
										</div>
										<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
											<div class="form-group">
											    <label for="inputEmail3" class="col-sm-4 control-label">Fees</label>
											    <div class="col-sm-8">
													<form:input path="fee" class="form-control numericOnly" tabindex="5" placeholder="Enter Fee for the Class" required="true"/>
													<span class="fee_error" id="fee_error"></span>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-8 col-sm-offset-4">
											<form:hidden path="id"/>
											<div class="form-group">
												<div class="col-sm-8 col-sm-offset-2">
													<input type="submit" class="btn btn-success" tabindex="6"/>
													<button type="button" class="btn btn-danger" id="cancel" tabindex="7">Reset</button>
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
										<h4>List of Classes</h4>
									</div>
									<div class="blog-body">
										<div class="table-responsive">
											<div id="basicExample_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
												<div class="row">
													<div class="col-sm-12">
 														<table id="basicExample" class="table table-striped table-condensed table-bordered no-margin dataTable" role="grid" aria-describedby="basicExample_info">
															<thead>
																<tr role="row">
																	<th class="sorting_asc" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending">Board</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending">Medium</th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending">Class</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending">Section</th>
																	<th class="sorting hidden-sm hidden-xs" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Start date: activate to sort column ascending">Fees</th>
																	<th class="sorting" tabindex="0" aria-controls="basicExample" rowspan="1" colspan="1" aria-label="Salary: activate to sort column ascending">Action</th>
																</tr>
															</thead>
															<!-- <tfoot>
																<tr><th rowspan="1" colspan="1">Board</th><th rowspan="1" colspan="1">Medium</th><th rowspan="1" colspan="1">Class</th><th rowspan="1" colspan="1">Section</th><th rowspan="1" colspan="1">Fees</th><th rowspan="1" colspan="1">Action</th></tr>
															</tfoot> -->
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


$( document ).ready(function() {
    $("#fee").val("");
});
$("#cls-form").validate(
		{
			errorElement: 'span',
		    errorClass: 'has-error',
			rules:
			{
				boardId: {required: true},
			    mediumId: {required: true},
				className: {required: true},
			    section: {required: true},
			    fee: {required: true, number: true},
			},
			messages:
			{
				boardId: {required: 'Please Choose Board'},
				mediumId: {required: 'Please Choose Medium'},
				className: {required: 'Please Choose Class'},
				section: {required: 'Please Choose Section'},
				fee: {required: 'Please Enter Fee Amount', number: 'Please Enter Numeric Characters'},
			},
			errorPlacement: function(error, element)
			{
			      if(element.attr("name") == "className")
			        error.insertAfter(".className_error").css("color", "red");
			      else if(element.attr("name") == "boardId")
			        error.insertAfter(".boardId_error").css("color", "red"); 
			       else if(element.attr("name") == "mediumId")
			        error.insertAfter(".mediumId_error").css("color", "red");
			       else if(element.attr("name") == "section")
			        error.insertAfter(".section_error").css("color", "red");
			       else if(element.attr("name") == "fee")
				        error.insertAfter(".fee_error").css("color", "red");
			      else
			        error.insertAfter(element);
			}	
		});

			  $('#cancel').click(function () {
			    $("#cls-form").validate().resetForm();
			    $("#cls-form").removeClass("has-error");
			    $("#boardId").val('');
			    $("#mediumId").val('');
			    $("#className").val('');
			    $("#section").val('');
			    $("#fee").val('');
			    $("#cls-form").addClass('form-horizontal');
			  });

			  $( document ).ready(function() {
				  $("#fee").val("");
				  $("#boardId").val('');
				    $("#mediumId").val('');
				    $("#className").val('');
				    $("#section").val('');
// 					$("#messagesDiplayId").text("");
// 					$('#mediumId').trigger("chosen:updated");
				    console.log( "ready!" );
				    var listOrders1 = ${allOrders1};
					if (listOrders1 != "") {
						displayTable(listOrders1);
					}else{
						$("#emptyMessageId").val("No Results Found");
					}
				});


	

	function displayTable(listOrders) {
			$("#basicExample tr td").remove();
			$("#basicExample td").remove();
			serviceUnitArray = {};
			$
					.each(
							listOrders,
							function(i, orderObj) {
								serviceUnitArray[orderObj.classId] = orderObj;
								var id = '"' + orderObj.classId + '"';
								var tblRow = "<tr align='center' role='row' class='odd'>" + "<td'><a  id='"
										+ orderObj.classId
										+ "' href='javascript:forOrderDetails("
										+ id
										+ ")' style='font-color:red'>"
										+ orderObj.orderId
										+ "</a></td>"
										+ "<td  title='"+orderObj.bordName+"'>"
										+ orderObj.bordName
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.medium+"'>"
										+ orderObj.medium
										+ "</td>"
										+ "<td title='"+orderObj.cname+"'>"
										+ orderObj.cname
										+ "</td>"
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.sname+"' >"
										+ orderObj.sname
										+ "<td class='hidden-sm hidden-xs' title='"+orderObj.fee+"' >"
										+ orderObj.fee
										+ "/-</td>"
										+ "<td>"
										+ '<a href="javascript:void(0)" onclick=editPack('
										+ orderObj.classId + ')'
										+ '  ><i style="color: green;" class="fa fa-edit"></i></a>' + '&nbsp; | &nbsp;'
										+ '<a style="color: red;" href="javascript:void(0)" onclick=deleteClass('
										+ orderObj.classId + ')'
										+ '  ><i class="fa fa-trash-o"></i></a>' + '</td>'
									
										+ '</tr>';
								$(tblRow).appendTo("#basicExample");
							});
	}
	function editPack(id) {
		var transactionId = serviceUnitArray[id].classId;
		$("#id").val(serviceUnitArray[id].classId)
		$('#boardId').val(serviceUnitArray[id].borderId);
		$('#boardId').trigger("chosen:updated");
		$('#className').val(serviceUnitArray[id].className);
		$('#className').trigger("chosen:updated");
		$('#mediumId').val(serviceUnitArray[id].mediamId);
		$('#mediumId').trigger("chosen:updated");
		$('#section').val(serviceUnitArray[id].section);
		$('#section').trigger("chosen:updated");
		$('#fee').val(serviceUnitArray[id].fee);
	}
	
	
	function deleteClass(id){
		var classId = id;
		var count = 0;
		var checkstr =  confirm('Are you sure you want to delete this?');
		if(checkstr == true){
		  // do your code
		  
		  $.ajax({
					type : "POST",
					url : "deleteClass.json",
					data : "classId=" + classId ,
					success : function(response) {
						displayTable(response);
						window.location.href='HomeControl1';
					},
					error : function(e) {
					}
				});
		
		/* 	$.ajax({
				type : "POST",
				url : "deleteClass.htm",
				data : "classId=" + classId ,
				dataType : "json",
				success : function(response) {
					alert(response);
					if (response != "") {
						displayTable(response);
					}
				
				},
				error : function(e) {
				}
			}); */
			
		}else{
		return false;
		}
	}
	
	
	
	
</script>
