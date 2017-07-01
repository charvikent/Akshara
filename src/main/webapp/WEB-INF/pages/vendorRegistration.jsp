<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html >
<html>
<head>
<title>Registration</title>
<!--   <script type="text/javascript" src="Branding/js/jquery-1.3.2.min.js"></script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> -->
<script>
$(document).ready(function() {
	chosenDropDown();
});
	$(function() {
		$("#tabs").tabs();
	});
</script>
<script type="text/javascript">
$(document).ready(function() {
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	var categoryList = ${VendorList};
	display(categoryList);
});

function display(categoryList1){
	var categoryList = categoryList1;
	if (categoryList == "") {
		$('#tablePagination').remove();
		$("#userdata ul li").remove();
		$('#noSortData').show();
		$('#legend2').hide();
		$('.holder').hide();
	} else {
		$('#noSortData').hide();
		$('#legend2').show();
		$('.holder').show();
		$.each(categoryList,function(i, catObj) {
	
							var tblRow = "<ul>"
								 + "<li class='nine-box'>"
									+ catObj.firstName+""+catObj.lastName
									+ "</li>"
									+ "<li class='two-box'>"
									+ catObj.mobileNumber
									+ "</li>"
									+ "<li class='zero-box1'>"
									+ catObj.address
									+ "</li>"
									+ "<li class='eight-box'>"
									+ catObj.city
									+ "</li>"
									+ "<li class='eleven-box '>"
									+ '<a href="editVendor.htm?id='
									+ catObj.id
									+ '" class="">Edit</a>'
									+ '</li>'
									+ "<li class='ten-box last'>"
									+ "<a href='javascript:void(0)' id='"
									+ catObj.id
									+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
									+ '</li>'
									 + '</ul>';
							$(tblRow).appendTo("#itemContainer");

							
						});
	};
	paginationTable(4);
}
function vendorSearch(){
	var vendorNameSearch = $("#vendorNameSearch").val();
	 $.ajax({
			type : "POST",
			url : "vendorNameSearch.json",
			data : "vendorNameSearch=" + vendorNameSearch,
			dataType : "json", 
			success : function(response) {
				/* alert(response); */
				if(response != ""){
					$("#itemContainer ul li").remove();
					$("#itemContainer ul").remove();
					display(response);
				}
				
			},
			error : function(e) {
			}
		});
}
</script>
<script type="text/javascript">
function editClick(){
	$('#addForm').attr('action',"<c:url value='/vendorUpdate.htm'/>");
	$("#addForm").submit();
	event.preventDefault();
}

</script>
<script type="text/javascript">
	
	function forDelete(id) {
		var count = 0;
		 jConfirm('Do You Want to Delete ?', 'Alert Box',
				 function(r)
				 {
		if (r == true) {
			var deleteId = id;
			$("#userdata ul").remove();
			$("#userdata ul li").remove();
			$.ajax({
						type : "POST",
						url : "deleteVendor.htm",
						data : "deleteId=" + deleteId,
						dataType : "json",
						success : function(categoryList) {
							//alert("CatList is:"+CatList);
							if (categoryList == "") {
								$('#noSortData').show();
								$('#legend2').hide();
								$('.holder').hide();
							} else {
								$('#noSortData').hide();
								$('#legend2').show();
								$('.holder').show();
								$.each(categoryList,function(i, catObj) {
													if (catObj.sMsg == "Success" && count == 0) {
														count++;
														document.getElementById("deleteMsgSus").style.display = "block";
														document.getElementById("addsus").style.display = "none";
														document.getElementById("addfail").style.display = "none";
														document.getElementById("upsus").style.display = "none";
														document.getElementById("addfail").style.display = "none";
														document.getElementById("deleteMsgFail").style.display = "none";
														document.getElementById("dupMessage").style.display = "none";

													} else if (count == 0) {
														count++;
														document.getElementById("deleteMsgSus").style.display = "block";
														document.getElementById("addsus").style.display = "none";
														document.getElementById("upsus").style.display = "none";
													}
													//alert(i + ": " +categoryObj.categotyDesc+""+categoryObj.categoryId);
													var tblRow = "<ul>"
														 + "<li class='nine-box'>"
															+ catObj.firstName+""+catObj.lastName
															+ "</li>"
															+ "<li class='two-box'>"
															+ catObj.mobileNumber
															+ "</li>"
															+ "<li class='zero-box1'>"
															+ catObj.address
															+ "</li>"
															+ "<li class='eight-box'>"
															+ catObj.city
															+ "</li>"
															+ "<li class='eleven-box '>"
															+ '<a href="editVendor.htm?id='
															+ catObj.id
															+ '" class="">Edit</a>'
															+ '</li>'
															+ "<li class='ten-box last'>"
															+ "<a href='javascript:void(0)' id='"
															+ catObj.id
															+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
															+ '</li>'
															 + '</ul>';
													$(tblRow).appendTo("#itemContainer");

												});
							};
						},
						error : function(e) {
							jAlert('Error: ' + e, 'Alert Box');
							/* alert('Error: ' + e); */
						},
					});
		};
				 });
		paginationTable(4);
				 
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		                $('#categoryName').focus();
		                $('#categoryDesc').val('');
						$('#addSearchId').val('');
						 chosenDropDown(); 
						//AddForm Validations
						
								

								}); 

	 /* $('#updateId').click(function(event) {
						$('#editForm').attr('action',"<c:url value='/vendorUpdate.htm'/>");
						$("#editForm").submit();
						event.preventDefault();
					}); */
</script>

</head>
<body>

	<div class="wrapper">
		<div class="container" >
			<form:form name="cf_form" method="post" id="addForm"
				class="form-horizontal" action="vendorAdd.htm"
				commandName="vendorCmd" enctype="multipart/form-data">
				<div id="tabs" style="background: #EBEEF0; height: 411px;">
					<ul>
						<li><a href="#tabs-1">Profile</a></li>
						 <li><a href="#tabs-2">Occupational Details</a></li>
						<li><a href="#tabs-3">Service Location</a></li>
						<!-- <li><a href="#tabs-4">Services</a></li> -->
						<li><a href="#tabs-4">Bank Details</a></li> 
					</ul>

					 <div id="tabs-4" style="height: 175px; width: 1170px">
						<jsp:include page="/WEB-INF/pages/bankDetails.jsp"></jsp:include>
					</div> 
					<div id="tabs-1" style="height: 351px; width: 1170px;">
						<jsp:include page="/WEB-INF/pages/vendorProfile.jsp"></jsp:include>
					</div>
					<div id="tabs-2" style="height: 175px; width: 1170px">
						<jsp:include page="/WEB-INF/pages/occupatonalDetails.jsp"></jsp:include>
					</div>
					 <div id="tabs-3" style="height: 175px; width: 1170px">
						<jsp:include page="/WEB-INF/pages/serviceLoction.jsp"></jsp:include>
					</div>
					<%-- <div id="tabs-4" style="height: 175px; width: 1170px">
						<jsp:include page="/WEB-INF/pages/servicesPrice.jsp"></jsp:include>
					</div>  --%>
					
				</div>
				<div class="block-footer">
								<div id="messagesId">

									<div class="alert-danger" id="duplmsg" style="display: none;">
										<aside class="block-footer-left fail">Warning : Vendor
											already Exists. Please try Some Other</aside>
									</div>


									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Vendor
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>


									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left fail">
											<strong><spring:message code="label.error" /> </strong>
											Vendor
											<spring:message code="label.deleteFail" />
										</aside>
									</div>

									<div id="addsus" style="display: block;">
										<c:forEach var="success" items="${param.AddSus}">
											<aside class="block-footer-left sucessfully">
												<spring:message code="label.success" />
												Vendor
												<spring:message code="label.saveSuccess" />
											</aside>
										</c:forEach>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<div>
												<aside class="block-footer-left fail">
													<strong><spring:message code="label.error" /> </strong>
													Vendor
													<spring:message code="label.saveFail" />
												</aside>
											</div>
										</c:forEach>
									</div>
									<div id="upsus" style="display: block;">
										<c:forEach var="success" items="${param.UpdateSus}">

											<aside class="block-footer-left sucessfully">
												<spring:message code="label.success" />
												Vendor
												<spring:message code="label.updateSuccess" />
											</aside>

										</c:forEach>
									</div>
									<div id="updatefail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">
											<div>
												<aside class="block-footer-left fail">
													<spring:message code="label.error" />
													Vendor
													<spring:message code="label.updateFail" />
												</aside>
											</div>
										</c:forEach>
									</div>

									<c:forEach var="success" items="${param.DeleteSus}">
										<div class="alert-success">
											<strong><spring:message code="label.success" /> </strong>
											Vendor
											<spring:message code="label.deleteSuccess" />

										</div>
									</c:forEach>


									<c:forEach var="fail" items="${param.DeleteFail}">
										<div class="alert-danger">
											<strong><spring:message code="label.error" /> </strong>
											Vendor
											<spring:message code="label.deleteFail" />

										</div>
									</c:forEach>

								</div>

								<!--  <aside class="block-footer-left sucessfully">Sucessfully Message</aside> -->



								<!-- <a href="" id="my-button">Preview</a> -->
							  <!--  <input type="submit" class="btn-cancel" formaction="clientPopup.htm" formmethod="post" name="previews" value="Preview"> -->
							  <c:if test="${empty vendorEdit }">
								<aside class="block-footer-right">
									<input class="btn-cancel" name=""
										value="Clear" type="button" tabindex="23" onclick="return dataClear()"> 
										<input class="btn-save" name="" value="Save" type="submit"  id="submitId" onclick="addClick()" tabindex="22">	
								</aside>
								</c:if>
								 <c:if test="${not empty vendorEdit }">
								 <form:hidden path="id"/>
								<aside class="block-footer-right">
									<a href="vendorHome.htm"><input type="button" class="btn-cancel"
								value="<spring:message code="label.cancel"/>" id="cancelId" tabindex="23"/></a>
										<input class="btn-save" value="Update" id="updateId" type="submit" onclick="editClick()" tabindex="22">	
								</aside>
								</c:if>
							</div>
							</form:form>
							<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Current Vendors
					</h2>
						<aside class="search-box">
							<input type="submit" class="search-bnt" tabindex="25" onclick="vendorSearch();"
								value="<spring:message code="label.search"/>" />
							<input type ="text" id ="vendorNameSearch" autocomplete="off" class="search-input" maxlength="30" tabindex="24" />
						</aside>
					<!-- <aside class="search-box">`									<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> -->
				</div>
				<div class="block-box-dept vendor-downbox block-box-last-dept">
					<ul class="table-list">
						<li class="nine-box">Vendor Name
							<ul>
								<li><a class="top" href="#">&nbsp;</a></li>
								<li><a class="bottom" href="#">&nbsp;</a></li>
							</ul>
						</li>
						<li class="two-box ">Mobile NO</li>
						<li class="zero-box1">Address</li>
						<li class="eight-box ">City</li>
						<li class="eleven-box ">Edit</li>
						<li class="ten-box last">Delete</li>
						
					</ul>
					<div class="table-list-blk-dept vendor-tablelis data-grid-big paginationParentDiv" id="userdata">
						<div id="itemContainer"></div>
					</div>
				</div>
					<div class="block-footer">
					  <aside class="block-footer-left"><div id="legend2" class="savmarup"></div></aside>
						<aside class="block-footer-right">
						<div class="pagenation">
							<div class="holder"></div>
							</div>
						</aside> 
						<!-- <p id="legend2"></p>
							<div class="holder"></div> -->
				</div>
			</div>
		</div>
	</div>
</body>
</html>
