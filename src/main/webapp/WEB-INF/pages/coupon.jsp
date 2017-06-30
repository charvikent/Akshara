<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Coupon</title>
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
		var list = ${couponList};
			showData(list);
	});
	function partnerCode(id)	{
		var pid = $("#"+id).val();
		$.ajax({
			type : "POST",
			url : "partnerCoupon.htm",
			data : "id=" + pid,
			dataType : "json",
			success : function(list) {
				showData(list);
			}
		});
	}
function showData(list){
	$("#itemContainer ul li").remove();
	$("#itemContainer ul").remove(); 
	alert(list);
	$.each(list,function(i, locObj) {
		var tblRow = "<ul>"
			+ "<li class='dept-box' style='width:868px'>"
			+ locObj.code
										+ "</li>"
										+ "<li class='dept-box last' style='width:100px'>"
										+ locObj.totalCount
										+ "</li>"
										+'</ul>';
								$(tblRow).appendTo("#itemContainer");
		 						paginationTable(12); 
	});

}

</script>

</head>
<body>
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
						<span class="icon1">&nbsp;</span> Add Coupon Code
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
					<form:form action="#" commandName="couponCmd" method="post"
						id="addForm" cssClass="form-horizontal"
						enctype="multipart/form-data">
						<div
							class="block-box-small categery-topbox block-box-top-header-dept">
							<form:hidden path="id"/>
							
							
							<div class="block-input">
								<label>Partner<span style="color: red;">*</span></label>
											
												<c:choose>
												
													<c:when test="${not empty sessionScope.partnerId}">
													<form:select path="partnerId"  
												onchange="partnerCode(this.id);" disabled="true" cssClass="some-select" 
												 tabindex="1">
														<c:set var="cId" scope="session" value="${sessionScope.partnerId }" />
														<form:options items="${partners}"></form:options>
														</form:select>
													</c:when>

													<c:otherwise>
													<form:select path="partnerId"  
												onchange="partnerCode(this.id);"  cssClass="some-select" 
												 tabindex="1">
														<form:option value="">--Select--</form:option>
														<form:options items="${partners}"></form:options>
														</form:select>
													</c:otherwise>
												</c:choose>
											
										</div> 
							
							<%-- <div class="block-input">
								<label>Partner<span style="color: red;">*</span></label>
								<c:if  test="${partnerId}">
								<form:select path="partnerId" onchange="partnerCode(this.id);">
								<form:option value="">--Select--</form:option>
								<form:options items="${partners }"></form:options>
								</form:select> 
								</c:if>
								
							</div> --%>
						</div>
						<div class="block-footer">
						<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: none;">
											<div class="alert-success">
												<spring:message code="label.success" />
												Coupon 
												<spring:message code="label.saveSuccess" />
											</div>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" /> 
												Coupon 
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: none;">
										
											<div class="alert-success">
												<spring:message code="label.success" />
												Coupon
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
											Coupon 
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Coupon 
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Coupon  already Exists. Please try Some Other</aside>


									</div>

								</aside>
							<aside class="block-footer-right">
								<input type="button" class="btn-cancel"
									value="<spring:message code="label.clear" />" tabindex="5"
									id="cancelId" tabindex="4" onclick="dataClear();" /> <input
									type="button" class="btn-save" value="Save" id="saveId"
									tabindex="6" />
							</aside>
						</div>
					</form:form>
				</div>
			</div>

			<!--Edit Box End  -->
			<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Current Coupon Codes
					</h2>
					<form:form action="searchCat.htm" commandName="couponCmd"
						method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt"
								onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="5" />
						</aside>
					</form:form>

				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept" >
					<ul class="table-list">
						<li class="dept-box">Base Code
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
	$("#saveId").click(function() {
		dnr = {};
		dnr.baseCode =$("#baseCode").val();
		dnr.displayText1 =$("#displayText1").val();
		dnr.displayText2 =$("#displayText2").val();
		dnr.amount =$("#amount").val();
		dnr.numberTimes =$("#numberTimes").val();
		dnr.totalCount =$("#totalCount").val();
		dnr.expiryTime =$("#expiryTime").val();
		dnr.id =$("#id").val();
		$.ajax({
			type : "POST",
			url : "couponCodeAdd.json",
			data : dnr,
			dataType : "json",
			success : function(response) {
				 if(response != null){
					 showData(response);
					 	$("#baseCode").val("");
						$("#displayText1").val("");
						$("#displayText2").val("");
						$("#amount").val("");
						$("#numberTimes").val("");
						$("#totalCount").val("");
						$("#expiryTime").val("");
						$("#id").val("0");
				 }
				 
				if(dnr.id == 0){
					document.getElementById("deleteMsgSus").style.display = "none";
					document.getElementById("upsus").style.display = "none";
					document.getElementById("addsus").style.display = "block";
				}else{
					document.getElementById("deleteMsgSus").style.display = "none";
					document.getElementById("addsus").style.display = "none";
					document.getElementById("upsus").style.display = "block";
				}	 
			}
			});
	});
	
	
	</script>
</body>
</html>