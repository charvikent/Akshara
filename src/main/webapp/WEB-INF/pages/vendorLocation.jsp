<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Location</title>
<style>
.your-class::-webkit-input-placeholder {
	color: red;
}

.default-class::-webkit-input-placeholder {
	color: red;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		chosenDropDown();
	});
	function getVendorId(id) {
			var vendorId = $("#" + id).val();
			if (vendorId != null && vendorId != "") {
				$
						.ajax({
							type : "POST",
							url : "getvendorAndLocations.json",
							data : "vendorId=" + vendorId,
							dataType : "json",
							success : function(response) {
								//alert(response);
								$("#itemContainer ul li").remove();
								$("#itemContainer ul").remove();
								global(response);
								paginationTable(12);
							}
						});
			}

		}
	
	function getLocation(id)
	{
		var locationId = $("#"+id).val();
	$('.multiple :selected').each(function(i, selected){ 
	  foo[i] = locationId; 
	});
	}
	
	
	function global(response){
		$.each(response,function(i, locObj) {
			var tblRow = "<ul>"
					+ "<li id='"+locObj.locationId+"' class='two-boxxx'>"
					+ locObj.vendorName
					+ "</li>"
					+ "<li id='"+locObj.vendorId+"' class='two-boxxx' style=' width: 909px'>"  
					+ locObj.locationName
					+ "</li>"
					+ "<li class='eleven-box '>"
					+ '<a href="editVendorLocation.htm?id='
					+ locObj.id
					+ '" class="edit">Edit</a>'
					+ '</li>'
					+ "<li class='ten-box last'>"
					+ "<a href='javascript:void(0)' id='"
					+ locObj.id
					+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
					+ '</li>' + '</ul>';
			$(tblRow).appendTo("#itemContainer");
		});
	}
	
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
						url : "deleteVendorLocation.json",
						data : "id=" + deleteId,
						dataType : "json",
						success : function(responce) {
							//alert(responce);
							global(responce);
						}
			});
		}
	});
	}
</script>

</head>
<body>
	<!-- Google Tag Manager -->

	<script>
		(function(i, s, o, g, r, a, m) {
			i['GoogleAnalyticsObject'] = r;
			i[r] = i[r] || function() {
				(i[r].q = i[r].q || []).push(arguments)
			}, i[r].l = 1 * new Date();
			a = s.createElement(o), m = s.getElementsByTagName(o)[0];
			a.async = 1;
			a.src = g;
			m.parentNode.insertBefore(a, m)
		})(window, document, 'script',
				'//www.google-analytics.com/analytics.js', 'ga');

		ga('create', 'UA-63399103-1', 'auto');
		ga('send', 'pageview');
	</script>
	<!-- End Google Tag Manager -->
	<div class="wrapper">
		<div class="container">
		
			<div class="main_content">

				<div class="block">
					<h2>
						<span class="icon1">&nbsp;</span> Add Locations
						<div class="block-footer-right1 fail">
							<div class="alert-danger" id="errmsg1" style="display: none;">
								please enter at least 3 characters</div>
							<div class="alert-danger" id="errmsg" style="display: none;">
								Alphanumerics, ., & and _ Are only Allowed</div>
							<div class="alert-danger" id="errmsg2" style="display: none;">
								First Letter Should Be Alphanumeric.</div>
						</div>
					</h2>
					<!-- End Box Head -->
					<c:if test="${empty locationEdit}">
					<form:form action="insertVendorLocation.htm" commandName="vendorLocationCmd" method="post"
						id="addForm" cssClass="form-horizontal"
						enctype="multipart/form-data">
						<div
							class="block-box-small categery-topbox block-box-top-header-dept">

							<div class="block-input">
								<label>Vendors<span style="color: red;">*</span></label>
								<form:select path="vendorsId" tabindex="1" cssClass="some-select"
									onchange="getVendorId(this.id)">
									<form:option value="">--Select--</form:option>
									<form:options items="${vendors}"></form:options>
								</form:select>
							</div>
							<div class="block-input">
								<label>Locations<span style="color: red;">*</span></label>
								<form:select path="locationsId"  tabindex="1" cssClass="some-select multiple"
									  multiple>
									<form:option value="">--Select--</form:option>
									<form:options items="${locations}"></form:options>
								</form:select>
							</div>
							
							<%-- <form:errors path="categoryDesc" /> --%>
						</div>
						<div class="block-footer">
						<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: none;">
											<div class="alert-success">
												<spring:message code="label.success" />
												Location 
												<spring:message code="label.saveSuccess" />
											</div>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" /> 
												Location 
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: none;">
										
											<div class="alert-success">
												<spring:message code="label.success" />
												Location 
												<spring:message code="label.updateSuccess" />
											</div>
										
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
											Location 
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Location 
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Location  already Exists. Please try Some Other</aside>


									</div>

								</aside>
							<aside class="block-footer-right">
								<input type="button" class="btn-cancel"
									value="<spring:message code="label.clear" />" tabindex="5"
									id="cancelId" tabindex="4" onclick="dataClear();" /> <input
									type="submit" class="btn-save" value="Save" 
									tabindex="6" />
							</aside>
						</div>
					</form:form>
					</c:if>
					
					
					
					<c:if test="${not empty locationEdit}">
					<form:form action="updateVendorLocation.htm" commandName="vendorLocationCmd" method="post"
						id="editForm" cssClass="form-horizontal"
						enctype="multipart/form-data">
						<div
							class="block-box-small categery-topbox block-box-top-header-dept">

							
							<div class="block-input">
								<label>Vendors<span style="color: red;">*</span></label>
								<form:select path="vendorsId" tabindex="1" cssClass="some-select"
									onchange="getVendorId(this.id)">
									<form:option value="">--Select--</form:option>
									<form:options items="${vendors}"></form:options>
								</form:select>
								<form:hidden path="id"/>
							</div>
							<div class="block-input">
								<label>Locations<span style="color: red;">*</span></label>
								<form:select path="locationsId"  tabindex="1" cssClass="some-select multiple"
									   multiple="multiple">
									<form:option value="">--Select--</form:option>
									<form:options items="${locations}"></form:options>
								</form:select>
							</div>
							
							<%-- <form:errors path="categoryDesc" /> --%>
						</div>
						<div class="block-footer">
						<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: none;">
											<div class="alert-success">
												<spring:message code="label.success" />
												Location 
												<spring:message code="label.saveSuccess" />
											</div>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" /> 
												Location 
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: none;">
										
											<div class="alert-success">
												<spring:message code="label.success" />
												Location 
												<spring:message code="label.updateSuccess" />
											</div>
										
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
											Location 
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Location 
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Location  already Exists. Please try Some Other</aside>


									</div>

								</aside>
							<aside class="block-footer-right">
								<input type="button" class="btn-cancel"
									value="<spring:message code="label.clear" />" tabindex="5"
									id="cancelId" tabindex="4" onclick="dataClear();" /> <input
									type="submit" class="btn-save" value="update" 
									tabindex="6" />
							</aside>
						</div>
					</form:form>
					</c:if>
					
					
					
				</div>
			</div>

			<!--Edit Box End  -->
			<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Current Locations
					</h2>
					<form:form action="searchCat.htm" commandName="locationCmd"
						method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt"
								onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="5" />
						</aside>
					</form:form>

				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept">
					<ul class="table-list">
						<li class="two-boxxx">Vendor
							<ul>
								<li><a class="top" href="#">&nbsp;</a></li>
								<li><a class="bottom" href="#">&nbsp;</a></li>
							</ul>
						</li>
						<li class='two-boxxx' style='width: 909px'>Locaiton
							<ul>
								<li><a class="top" href="#">&nbsp;</a></li>
								<li><a class="bottom" href="#">&nbsp;</a></li>
							</ul>
						</li>
						<li class="eleven-box ">Edit</li>
						<li class="ten-box last">Delete</li>
					</ul>
					<div
						class="table-list-blk-dept categery-tablelis data-grid-big paginationParentDiv"
						id="userdata">
						<div id="itemContainer"></div>
					</div>
				</div>
				<div class="block-footer">
					<aside class="block-footer-left">
						<div id="legend2" class="savmarup"></div>
					</aside>
					<aside class="block-footer-right">
						<div class="pagenation">
							<div class="holder"></div>
						</div>
					</aside>
				</div>
			</div>
		</div>

	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		var list =${list};
		global(list);
	}); 
	
	</script>
</body>
</html>