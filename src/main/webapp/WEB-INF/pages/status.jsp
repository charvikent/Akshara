<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Status</title>
<style>
.your-class::-webkit-input-placeholder {
    color: red;
}
.default-class::-webkit-input-placeholder {
    color: red;
}
</style>
<script type="text/javascript">
var statusArray = {};
var statusid=0;
$(document).ready(function() {
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	var statusList = ${StatusList};
	if (statusList == "") {
		$('#tablePagination').remove();
		$("#userdata ul li").remove();
		$('#noSortData').show();
		$('#legend2').hide();
		$('.holder').hide();
	} else {
		$('#noSortData').hide();
		$('#legend2').show();
		$('.holder').show();
	}
	showData(statusList);
	
});
function showData(response){
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	
	$.each(response,
			function(i, catObj) {
		statusArray[catObj.id] = catObj;
				var tblRow = "<ul>"
						+ "<li class='nine-box' title='"+catObj.name+"'>"
						+ catObj.name
						+ "</li>"
						+ "<li class='eleven-box '>"
						+ '<a href="javascript:void(0)" onclick=editPack('+ catObj.id + ')' +  ' class="" >Edit</a>'
						+ '</li>'
						+ "<li class='ten-box last'>"
						+ "<a href='javascript:void(0)' id='"
						+ catObj.id
						+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
						+ '</li>'
						 + '</ul>';
				$(tblRow).appendTo("#itemContainer");
			});
	paginationTable(8);
}


function editPack(id)
{
	statusid=id;
	$('#statusname').val(statusArray[id].name);
	
	//$('#packId').val(id);
}

function submitForm() {
	
	var statusname = $('#statusname').val();
	var admin = true;
	
	$.blockUI({ message: 'Please Wait' });
	$.ajax({
		type : "POST",
		url : "statusAdd.htm",
		data : {
			statusname : statusname,statusid:statusid,
		},
		success : function(response) {
			$.unblockUI(); 
			alert(response);	
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
						url : "deleteStatus.htm",
						data : "deleteId=" + deleteId,
						dataType : "json",
						success : function(StatusList) {
							//alert("StatusList is:"+StatusList);
							if (StatusList == "") {
								$('#noSortData').show();
								$('#legend2').hide();
								$('.holder').hide();
							} else {
								$('#noSortData').hide();
								$('#legend2').show();
								$('.holder').show();
								$.each(StatusList,function(i, statusObj) {
													if (statusObj.sMsg == "Success" && count == 0) {
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
													//alert(i + ": " +statusObj.categotyDesc+""+statusObj.statusId);
													var tblRow = "<ul>"
														+ "<li class='dept-box'>"
															/* + statusObj.deptName
															+ " "  */
															+ statusObj.name
															+ "</li>"
															+ "<li class='eleven-box '>"
															+ '<a href="editService.htm?id='
															+ statusObj.id
															+ '" class="">Edit</a>'
															+ '</li>'
															+ "<li class='ten-box last'>"
															+ "<a href='javascript:void(0)' id='"
															+ statusObj.id
															+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
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
		paginationTable(6);
				 
	}
</script>
<script type="text/javascript">
function searchFunction() {
	var searchId = $('#addSearchId').val();
	if (searchId == "" || searchId == null) {
		jAlert('please enter status', 'Alert Box');
		return false;
	}
	var searchid = $('#searchId').val();
	if(searchid=="" || searchid==""){
		jAlert('please enter the client name', 'Alert Box');
		return false;
	};

}

</script>
<script>
 function dataClear(){
	 
	 $('#cancelId').css('border', 'none');	
	 $('#submitId').css('border', 'none');		
	 $('#statusname').val("");
	  removeBorder('statusname');
	  $("#statusname").attr("placeholder","");
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
				<c:if test="${empty statusEdit}">
					<div class="block">
						<h2>
							<span class="icon1">&nbsp;</span>
							Add New Status
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
						<form:form action="" commandName="statusCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small categery-topbox block-box-top-header-dept">
								<%-- <div class="block-input">
											<label>Services<span
												style="color: red;">*</span></label>
											<form:select path="serviceId"  cssClass="some-select" tabindex="1" onchange="searchBasedOnCateogry()">
											<form:option value="">--Select--</form:option>
											<form:options items="${srevices}"></form:options>
											</form:select>
										</div> --%>
								<div class="block-input">
											<label>Status<span
												style="color: red;">*</span></label>
											<form:input path="name" id="statusname" 
												maxlength="30" autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="1"/>
										</div>								
								<%-- <form:errors path="statusDesc" /> --%>
							</div>
							<div class="block-footer">
								<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: block;">
										<c:forEach var="success" items="${param.AddSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Status
												<spring:message code="label.saveSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" /> 
												Status
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: block;">
										<c:forEach var="success" items="${param.UpdateSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Status
												<spring:message code="label.updateSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="upfail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">	
							             	<aside class="block-footer-left fail">
												<spring:message code="label.error" /> status
												<spring:message code="label.updateFail" />
											</aside>
										</c:forEach>
									</div>
									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Status
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Status
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Status already Exists. Please try Some Other</aside>
									</div>

								</aside>
								<aside class="block-footer-right">
									<input type="button"
										class="btn-cancel"
										value="<spring:message code="label.clear" />" id="cancelId" tabindex="3"  onclick="dataClear();"/>
									<input type="button" class="btn-save"
										value="<spring:message code="label.save"/>" id="submitId" tabindex="2" onclick="submitForm();"/>
								</aside>
							</div>
						</form:form>
					</div>					
				</c:if>
			</div>
			<!--Edit Box End  -->
			<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Current Status
					</h2>
					<form:form action="searchStatus.htm" commandName="statusCmd" method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt" onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="6"/>
							<form:input path="name" id="addSearchId" 
								autocomplete="off" class="search-input" maxlength="30" tabindex="5"/>
						</aside>
					</form:form>
					<!-- <aside class="search-box">
								<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> -->
				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept">
					<ul class="table-list">
						<li class="nine-box">Status Name
							<ul>
								<li><a class="top" href="#">&nbsp;</a></li>
								<li><a class="bottom" href="#">&nbsp;</a></li>
							</ul>
						</li>
						<li class="eleven-box ">Edit</li>
						<li class="ten-box last">Delete</li>
						
					</ul>
					<div class="table-list-blk-dept categery-tablelis data-grid-big paginationParentDiv" id="userdata">
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
		<!-- End Content -->
	</div>
</body>
</html>