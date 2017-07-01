<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<script type="text/javascript" src="js/js/csvDownload1.js"></script>
<title>Services</title>
<style>
.your-class::-webkit-input-placeholder {
    color: red;
}
.default-class::-webkit-input-placeholder {
    color: red;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	 chosenDropDown(); 
});
</script>
 <script type="text/javascript">

$(document).ready(function() {
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	var ServiceList = ${ServiceList};
	if (ServiceList == "") {
		$('#tablePagination').remove();
		$("#userdata ul li").remove();
		$('#noSortData').show();
		$('#legend2').hide();
		$('.holder').hide();
	} else {
		$('#noSortData').hide();
		$('#legend2').show();
		$('.holder').show();
		$.each(ServiceList,
						function(i, ServiceListObj) {
							var tblRow = "<ul>"
								 + "<li class='zero-box'>"
									+ ServiceListObj.name
									+ "</li>"
									 + "<li class='two-box'>"
										+ ServiceListObj.pageName
										+ "</li>"
									+ "<li class='eleven-box '>"
									+ '<a href="editService.htm?id='
									+ ServiceListObj.id
									+ '" class="">Edit</a>'
									+ '</li>'
									+ "<li class='ten-box last'>"
									+ "<a href='javascript:void(0)' id='"
									+ ServiceListObj.id
								/* 	+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>" */
									+ '</li>'
									 + '</ul>';
							$(tblRow).appendTo("#itemContainer");
						});
	};
	paginationTable(8);
});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#serviceNameId').val('');
		                $('#serviceNameId').focus();
						$('#addSearchId').val('');
						//AddForm Validations
						
								 $('#submitId').click(function(e){
													    
											$('#addForm').attr('action',"<c:url value='/serviceAdd.htm'/>");
											$("#addForm").submit();											
											event.preventDefault();
											document.getElementById("dupMessage").style.display = "none";
						});

						$('#updateId').click(function(event) {
											$('#updateId').css('border', 'solid 3px #862ab7');										    
										/*     if($('#name').val().length == 0){										   
										    
										    if($('#name').val().length == 0 ) {
										       $('#name').css('color','red');
										       $("#name").css("border-color","red");
										       $("#name").attr("placeholder","Please Enter Service Name");
										       $('#name').addClass('your-class');
										    }										     
										    return false;										  
										    }  */
										 /*    var val=$('#name').val().charCodeAt(0);
										    var val1=$('#name').val();
										    var regex=new RegExp("^[a-zA-Z0-9][a-zA-Z0-9._& ]+$");
										    if(val==32 || val==95||val==38||val==46||$('#name').val().length <3 )
										    	{
										    	if(val==32 || val==95||val==38||val==46){c3();}
										    	else{c2();}										    	
										    	$('#name').focus();
										    	return false;
										    }
										    if(!(regex.test(val1))){c1();									    	
						    					return false;
						    				} */
											$('#editForm').attr('action',"<c:url value='/serviceUpdate.htm'/>");
											$("#editForm").submit();
											event.preventDefault();
										});
								});
</script>
<script type="text/javascript">
	function duplicateChecks() {
		document.getElementById("addsus").style.display = "none";
		document.getElementById("addfail").style.display = "none";
		document.getElementById("upsus").style.display = "none";
		document.getElementById("upfail").style.display = "none";
		document.getElementById("deleteMsgSus").style.display = "none";
		document.getElementById("deleteMsgFail").style.display = "none";
		var serviceName = $('#serviceNameId').val();
		var catId = $('#id').val();
		$.ajax({
					type : "POST",
					url : "serviceDuplicate.htm",
					data : "serviceName=" + serviceName + '&id='+ catId,
					success : function(response) {
						
						if (response != "") {
							document.getElementById("dupMessage").style.display = "block";
							$('#submitId').attr('disabled', 'disabled');
							$('#submitId').hide();
						} else {
							document.getElementById("dupMessage").style.display = "none";							
							$('#submitId').show();
							$('#submitId').removeAttr('disabled');
						}
					},
					error : function(e) {
					}
				});
	}
</script>

<script type="text/javascript">
	function duplicateEditCheck() {
		var serviceName = $('#serviceName').val();
		var serviceId = $('#serviceId').val();
		$.ajax({
					type : "POST",
					url : "serviceDuplicate.htm",
					data : "serviceName=" + serviceName + "&serviceId="
							+ serviceId ,
					success : function(response) {
						if (response != "") {							
							document.getElementById("dupEditMessage").style.display = "block";
							$('#updateId').attr('disabled', 'disabled');
							$('#updateId').hide();
						} else {
							document.getElementById("dupEditMessage").style.display = "none";
							$('#updateId').show();
							$('#updateId').removeAttr('disabled');
						}
					},
					error : function(e) {
					}
				});
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
						url : "deleteService.json",
						data : "id=" + deleteId,
						dataType : "json",
						success : function(serviceList) {
							//alert("CatList is:"+CatList);
							if (serviceList == "") {
								$('#noSortData').show();
								$('#legend2').hide();
								$('.holder').hide();
							} else {
								$('#noSortData').hide();
								$('#legend2').show();
								$('.holder').show();
								$.each(serviceList,function(i, serviceListObj) {
													if (serviceListObj.sMsg == "Success" && count == 0) {
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
														document.getElementById("deleteMsgFail").style.display = "block";
														document.getElementById("addsus").style.display = "none";
														document.getElementById("upsus").style.display = "none";
													}
													//alert(i + ": " +categoryObj.categotyDesc+""+categoryObj.categoryId);
													var tblRow = "<ul>"
														+ "<li class='dept-box'>"
															/* + categoryObj.deptName
															+ " "  */
															+ serviceListObj.name
															+ "</li>"
															+ "<li class='eleven-box '>"
															+ '<a href="editService.htm?id='
															+ serviceListObj.id
															+ '" class="">Edit</a>'
															+ '</li>'
															+ "<li class='ten-box last'>"
															+ "<a href='javascript:void(0)' id='"
															+ serviceListObj.id
															/* + "' onclick='' class='ico del'>Delete</a>" */
															+ '</li>'
															+ '</ul>';
													//alert(tblRow);
													$(tblRow).appendTo(
															"#itemContainer");
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
		paginationTable(8);
				 
	}
	
	function searchBasedOnCateogry(){
		document.getElementById("addsus").style.display = "none";
		document.getElementById("addfail").style.display = "none";
		document.getElementById("upsus").style.display = "none";
		document.getElementById("addfail").style.display = "none";
		document.getElementById("deleteMsgFail").style.display = "none";
		document.getElementById("dupMessage").style.display = "none";
		var catId = $("#parentCategory").val();
		$("#userdata ul li").remove();
		$("#userdata ul").remove();
		$.ajax({
			type : "POST",
			url : "searchBasedOnCateogry.htm",
			data : "id=" + catId,
			dataType : "json",
			success : function(serviceList) {
				if (serviceList == "") {
					$('#tablePagination').remove();
					$("#userdata ul li").remove();
					$('#noSortData').show();
					$('#legend2').hide();
					$('.holder').hide();
				} else {
					$('#noSortData').hide();
					$('#legend2').show();
					$('.holder').show();
					$.each(serviceList,function(i, serviceListObj) {
										var tblRow = "<ul>"
												+ "<li class='dept-box'>"
												+ serviceListObj.name
												+ "</li>"
												+ "<li class='eleven-box '>"
												+ '<a href="editService.htm?id='
												+ serviceListObj.id
												+ '" class="ico edit">Edit</a>'
												+ '</li>'
												+ "<li class='ten-box last'>"
												+ "<a href='javascript:void(0)' id='"
												+ serviceListObj.id
											/* 	+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>" */
												+ '</li>'
												+ '</ul>';
										$(tblRow).appendTo("#itemContainer");
									});
					paginationTable(8);
				}
			},
			error : function(e) {
			}
			
		});
	}
</script>
<script type="text/javascript">
function searchFunction() {
	var searchId = $('#addId').val();
	if (searchId == "" || searchId == null) {
		jAlert('please enter service name', 'Alert Box');
		return false;
	}
	var searchid = $('#searchId').val();
	if(searchid=="" || searchid==""){
		jAlert('please enter the category name', 'Alert Box');
		return false;
	};

}

</script>
<script>
 function dataClear(){
	 $('#submitId').css('border', 'none');		
	 $('#name').val("");
	  removeBorder('serviceName');
	  $("#name").attr("placeholder","");
	  document.getElementById("addsus").style.display = "none";
	  document.getElementById("addfail").style.display = "none";
	  document.getElementById("upsus").style.display = "none";
	  document.getElementById("upfail").style.display = "none";
	  document.getElementById("deleteMsgSus").style.display = "none";
	  document.getElementById("deleteMsgFail").style.display = "none";
	  document.getElementById("dupMessage").style.display = "none";
	  
	    $('#submitId').show();
		$('#submitId').removeAttr('disabled');
}
</script>
<script type="text/javascript">
$(document).ready(function(){
});
</script>

</head>
<body>
<!-- Google Tag Manager -->

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-63399103-1', 'auto');
  ga('send', 'pageview');

</script>
<!-- End Google Tag Manager -->
	<div class="wrapper">
		<div class="container">
			<div class="main_content">
				<c:if test="${empty servEdit}">
					<div class="block">
						<h2>
							<span class="icon1">&nbsp;</span>
							<spring:message code="label.addNewService"></spring:message>
							<div class="block-footer-right1 fail">
									<div class="alert-danger" id="errmsg1" style="display: none;">
										please enter atleast 3 characters
									</div>
									<div class="alert-danger" id="errmsg" style="display: none;">
										Alphanumerics, ., & and _  Are only Allowed
									</div>
									<div class="alert-danger" id="errmsg2" style="display: none;">
										First Letter Should Be Alphanumeric.
									</div>	
																																												
							</div>
						</h2>
						<!-- End Box Head -->
						<form:form action="" commandName="servCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small categery-topbox block-box-top-header-dept" style="height: 74px !important">
								<div class="block-input">
											<label><spring:message code="label.cat" /><span
												style="color: red;">*</span></label>
											 <form:select path="parentCategory"  cssClass="some-select" tabindex="1" onchange="searchBasedOnCateogry()">
											<form:option value="">--Select--</form:option>
											<form:options items="${categorys}"></form:options>
											</form:select> 
										</div>
								<div class="block-input">
											<label><spring:message code="label.services" /><span
												style="color: red;">*</span></label>
											<form:input path="name" id="serviceNameId" onkeyup="duplicateChecks()" class="alphaNumericValid1" 
												 autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="2"/>
										</div>	
										<div class="block-input last">
									<label>Location<span style="color: red;">*</span></label>
									<form:select path="LocationId" id="LocationId" cssClass="some-select" tabindex="2" multiple="multiple">
										<form:option value="">--Select--</form:option>
										<form:options items="${locations}"></form:options>
									</form:select>
								</div>
										<div class="block-input">
											<label>Page<span
												style="color: red;">*</span></label>
											<form:input path="pageName" id="pageNameId" onkeyup="duplicateChecks()" class="alphaNumericValid1" 
												 autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="3"/> 
										</div>	
										<div class="block-input">
											<label>description<span
												style="color: red;">*</span></label>
											<form:input path="description" id="descriptionId"  
												 autocomplete="off" onkIdeydown="removeBorder(this.id)"  tabindex="2"/>
										</div>
										<div class="block-input last">
											<label>keywords<span
												style="color: red;">*</span></label>
											<form:input path="keywords" id="keywordsId" 
												 autocomplete="off" onkIdeydown="removeBorder(this.id)"  tabindex="2"/>
										</div>												
								<%-- <form:errors path="categoryDesc" /> --%>
							</div>
							<div class="block-footer">
								<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: block;">
										<c:forEach var="success" items="${param.AddSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Service 
												<spring:message code="label.saveSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" /> 
												Service 
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: block;">
										<c:forEach var="success" items="${param.UpdateSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Service 
												<spring:message code="label.updateSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="upfail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">	
							             	<aside class="block-footer-left fail">
												<spring:message code="label.error" /> Service 
												<spring:message code="label.updateFail" />
											</aside>
										</c:forEach>
									</div>
									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Service 
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Service 
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Service  already Exists. Please try Some Other</aside>
									</div>

								</aside>
								<aside class="block-footer-right">
									<input type="button"
										class="btn-cancel"
										value="<spring:message code="label.clear" />" id="cancelId" tabindex="4"  onclick="dataClear();"/>
									<input type="submit" class="btn-save"
										value="<spring:message code="label.save"/>" id="submitId" tabindex="3"/>
								</aside>
							</div>
						</form:form>
					</div>					
				</c:if>
			</div>
			<c:if test="${not empty servEdit }">
			<div class="block">
						
				<!-- <div class="head-box"> -->
					<h2>Id
						<span class="icon1">&nbsp;</span>
							<spring:message code="label.editService"></spring:message>
							<div class="block-footer-right1 fail">
									<div class="alert-danger" id="errmsg1" style="display: none;">
										please enter atleast 3 charracters
									</div>
									<div class="alert-danger" id="errmsg" style="display: none;">
										please enter Alphanumerics, ., & and _ only 
									</div>	
									<div class="alert-danger" id="errmsg2" style="display: none;">
										First Letter Should Be Alphanumeric.								
									</div>																																															
							</div>
					</h2>
				<!-- </div> -->
				<!-- End Box Head -->
				
				<form:form action="" commandName="servCmd" method="post"
					id="editForm" cssClass="form-horizontal">
					<div class="block-box-small categery-topbox block-box-top-header-dept" style="height: 74px !important">
						<form:hidden path="id" />
						
						<div class="block-input">
											<label><spring:message code="label.cat" /><span
												style="color: red;">*</span></label>
											<form:select path="parentCategory" disabled="true"  cssClass="some-select"  tabindex="1">
											<form:option value="">--Select--</form:option>
											<form:options items="${categorys}"></form:options>
											</form:select>
										</div>
								<div class="block-input">
											<label><spring:message code="label.services" /><span
												style="color: red;">*</span></label>
											<form:input path="name"  onkeyup="duplicateChecks()"  
												 autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="2"/>
										</div>
										<div class="block-input last">
									<label>Location<span style="color: red;">*</span></label>
									<form:select path="LocationId" id="LocationId" cssClass="some-select" tabindex="2" multiple="multiple">
										<form:option value="">--Select--</form:option>
										<form:options items="${locations}"></form:options>
									</form:select>
								</div>
										<div class="block-input">
											<label>Page<span
												style="color: red;">*</span></label>
											<form:input path="pageName" id="pageNameId" onkeyup="duplicateChecks()" class="alphaNumericValid1" 
												 autocomplete="off" onkIdeydown="removeBorder(this.id)"  tabindex="2"/>
										</div>	
										<div class="block-input">
											<label>description<span
												style="color: red;">*</span></label>
											<form:input path="description" id="descriptionId"  
												 autocomplete="off" onkIdeydown="removeBorder(this.id)"  tabindex="2"/>
										</div>
										<div class="block-input last">
											<label>keywords<span
												style="color: red;">*</span></label>
											<form:input path="keywords" id="keywordsId"  
												 autocomplete="off" onkIdeydown="removeBorder(this.id)"  tabindex="2"/>
										</div>						

					</div>
					<div class="block-footer">
					<div class="alert-danger" id="dupEditMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Service already Exists. Please try Some Other</aside>
									</div>
						 
						<aside class="block-footer-right">
							<a href="serviceHome.htm"><input type="button" class="btn-cancel"
								value="<spring:message code="label.cancel"/>" id="cancelId" tabindex="4"/></a>
							<input type="submit" class="btn-save"
								value="<spring:message code="label.update"/>" id="updateId" tabindex="3"/>
						</aside>
					</div>
				</form:form>
</div>

				<!-- Box -->

			</c:if>
			<!--Edit Box End  -->
			<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Current Services
					</h2>
					<a href="#" class="export" style="color: yellow;">Export Table data into CSV</a>
					<form:form action="searchService.htm" commandName="servCmd" method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt" onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="6"/>
							<form:input path="name" id="addId" 
								autocomplete="off" class="search-input"  tabindex="5"/>
						</aside>
					</form:form>
					 <aside class="search-box">
								<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> 
				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept itemContainer" >
					<ul class="table-list">
						<li class="zero-box">Service Name
							<ul>
								<li><a class="top" href="#">&nbsp;</a></li>
								<li><a class="bottom" href="#">&nbsp;</a></li>
							</ul>Id
						</li>
						<li class="two-box">Page
						<ul>
								<li><a class="top" href="#">&nbsp;</a></li>
								<li><a class="bottom" href="#">&nbsp;</a></li>
							</ul>
						</li>
						<li class="eleven-box ">Edit</li>
						<!-- <li class="ten-box last">Delete</li> -->
						
					</ul>
					<div class="table-list-blk-dept categery-tablelis data-grid-big paginationParentDiv" id="userdata">
						<div id="itemContainer" class="itemContainer"></div>
					</div>
				</div>
					<div class="block-footer">
					  <aside class="block-footer-left"><div id="legend2" class="savmarup"></div></aside>
						<aside class="block-footer-right">
						<div class="pagenation">
							<div class="holder"></div>
							</div>
						</aside> 
				</div>
			</div>
		</div>
		<!-- End Content -->
	</div>
</body>
</html>