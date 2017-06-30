<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Doctor type</title>
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
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	var doctortypeList = ${doctortypeList};
	if (doctortypeList == "") {
		$('#tablePagination').remove();
		$("#userdata ul li").remove();
		$('#noSortData').show();
		$('#legend2').hide();
		$('.holder').hide();
	} else {
		$('#noSortData').hide();
		$('#legend2').show();
		$('.holder').show();
		$.each(doctortypeList,
						function(i, doctortypeObj) {
							var tblRow = "<ul>"
								 + "<li class='dept-box'>"
									+ doctortypeObj.doctortypeName
									+ "</li>"
									+ "<li class='eleven-box '>"
									+ '<a href="editDoctorType.htm?doctortypeId='
									+ doctortypeObj.doctortypeId
									+ '" class="">Edit</a>'
									+ '</li>'
									+ "<li class='ten-box last'>"
									+ "<a href='javascript:void(0)' id='"
									+ doctortypeObj.doctortypeId
									+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
									+ '</li>'
									 + '</ul>';
							$(tblRow).appendTo("#itemContainer");

							
						});
	};
	paginationTable(12);
});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		                $('#doctortypeName').focus();
		                $('#doctortypeName').val('');
						$('#addSearchId').val('');
						 chosenDropDown(); 
						//AddForm Validations
						
								 $('#submitId').click(function(e){
												 $('#submitId').css('border', 'solid 3px #862ab7');												    
												  if($('#doctortypeNameId').val().length == 0 || $('#doctortypeDescId').val().length == 0){
													 if($('#doctortypeNameId').val().length == 0 ) {
														    $('#doctortypeNameId').css('color','red');
														    $("#doctortypeNameId").css("border-color","red");
														    $("#doctortypeNameId").attr("placeholder","Please Enter doctortypeName");
														    $('#doctortypeNameId').addClass('your-class');
														    }
													  if($('#doctortypeDescId').val().length == 0 ) {
														    $('#doctortypeDescId').css('color','red');
														    $("#doctortypeDescId").css("border-color","red");
														    $("#doctortypeDescId").attr("placeholder","Please Enter doctortypeDesc");
														    $('#doctortypeDescId').addClass('your-class');
														    }
													
											 return false;
												 }
												 var val=$('#doctortypeNameId').val().charCodeAt(0);
												    var val1=$('#doctortypeNameId').val();
												    var regex=new RegExp("^[a-zA-Z0-9][a-zA-Z0-9._& ]+$");
												    if(val==32 || val==95||val==38||val==46||$('#doctortypeNameId').val().length <3 )
												    	{
												    	document.getElementById("errmsg1").style.display = "block";
												    	setTimeout(function(){ $('#errmsg1').fadeOut(); }, 2000);
												    	if(val==32 || val==95||val==38||val==46){
												    		
												    		}
												    	else{
												    		
												    	}										    	
												    	$('#doctortypeNameId').focus();
												    	return false;
												    }
												    if(!(regex.test(val1))){									    	
								    					return false;
								    				}

											$('#addForm').attr('action',"<c:url value='/doctortypeAdd.htm'/>");
											$("#addForm").submit();											
											event.preventDefault();
											document.getElementById("dupMessage").style.display = "none";
						});

						$('#updateId').click(function(event) {
											
											 $('#updateId').css('border', 'solid 3px #862ab7');										    
										    if($('#doctortypeDesc').val().length == 0){										   
										    
										    if($('#doctortypeName').val().length == 0 ) {
										       $('#doctortypeName').css('color','red');
										       $("#doctortypeName").css("border-color","red");
										       $("#doctortypeName").attr("placeholder","Please Enter doctortype");
										       $('#doctortypeName').addClass('your-class');
										    }										     
										    return false;										  
										    } 
										    /* var val=$('#doctortypeNameId').val().charCodeAt(0);
										    var val1=$('#doctortypeNameId').val();
										    var regex=new RegExp("^[a-zA-Z0-9][a-zA-Z0-9._& ]+$");
										    if(val==32 || val==95||val==38||val==46||$('#doctortypeNameId').val().length <3 )
										    	{
										    	if(val==32 || val==95||val==38||val==46){}
										    	else{}										    	
										    	$('#doctortypeNameId').focus();
										    	return false;
										    }
										    if(!(regex.test(val1))){									    	
						    					return false;
						    				} */
						    				 
											$('#editForm').attr('action',"<c:url value='/doctortypeUpdate.htm'/>");
											$("#editForm").submit();
											event.preventDefault();
										});
								});
</script>



<!-- <script type="text/javascript">
	function duplicateEditCheck() {
		var doctortypeName = $('#doctortypeName').val();
		var doctorTypeId = $('#doctortypeId').val();
		$.ajax({
					type : "POST",
					url : "doctortypeDuplicate.htm",
					data : "doctortypeName=" + catname + "&doctortypeId="
							+ doctorTypeId ,
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
</script> -->

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
						url : "deleteDoctorType.htm",
						data : "deleteId=" + deleteId,
						dataType : "json",
						success : function(doctortypeList) {
							//alert("CatList is:"+CatList);
							if (doctortypeList == "") {
								$('#noSortData').show();
								$('#legend2').hide();
								$('.holder').hide();
							} else {
								$('#noSortData').hide();
								$('#legend2').show();
								$('.holder').show();
								$.each(doctortypeList,function(i, doctortypeObj) {
													if (doctortypeObj.sMsg == "Success" && count == 0) {
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
													//alert(i + ": " +doctortypeObj.categotyDesc+""+doctortypeObj.doctorTypeId);
													var tblRow = "<ul>"
														+ "<li class='dept-box'>"
															/* + doctortypeObj.deptName
															+ " "  */
															+ doctortypeObj.doctortypeName
															+ "</li>"
															+ "<li class='eleven-box '>"
															+ '<a href="editDoctorType.htm?doctorTypeId='
															+ doctortypeObj.doctortypeId
															+ '" class="">Edit</a>'
															+ '</li>'
															+ "<li class='ten-box last'>"
															+ "<a href='javascript:void(0)' id='"
															+ doctortypeObj.doctortypeId
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
		paginationTable(12);
				 
	}
</script>
<script type="text/javascript">
function searchFunction() {
	var searchId = $('#addSearchId').val();
	if (searchId == "" || searchId == null) {
		jAlert('please enter customer', 'Alert Box');
		return false;
	}
	var searchid = $('#searchId').val();
	if(searchid=="" || searchid==""){
		jAlert('please enter the client name', 'Alert Box');
		return false;
	};

}

</script>
 <script type="text/javascript">
	function duplicateChecks() {
		document.getElementById("addsus").style.display = "none";
		document.getElementById("addfail").style.display = "none";
		document.getElementById("upsus").style.display = "none";
		document.getElementById("upfail").style.display = "none";
		document.getElementById("deleteMsgSus").style.display = "none";
		document.getElementById("deleteMsgFail").style.display = "none";
		var doctortypeName = $('#doctortypeNameId').val();
	//	alert(doctortypeName);
		$.ajax({
					type : "POST",
					url : "doctortypeDuplicate.htm",
					data : "doctortypeName=" + doctortypeName,
					success : function(response) {
						//alert(response);	
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
<script>
 function dataClear(){
	 $('#submitId').css('border', 'none');		
	 $('#doctortypeNameId').val("");
	  removeBorder('doctortypeNameId');
	  $("#doctortypeNameId").attr("placeholder","");
	  $('#doctortypeDescId').val("");
	  removeBorder('doctortypeDescId');
	  $("#doctortypeDescId").attr("placeholder","");
	 
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
				<c:if test="${empty editDoctorType}">
					<div class="block">
						<h2>
							<span class="icon1">&nbsp;</span>
							Add New Doctor type
							<div class="block-footer-right1 fail">
									<div class="alert-danger" id="errmsg1" style="display: none;">
										please enter atleast 3 characters
									</div>
									<div class="alert-danger" id="errmsg" style="display: none;">
										Alphanumerics, ., & and _  Are only Allowed
									</div>
									<div class="alert-danger" id="errmsg5" style="display: none;">
										Email id should give properly.
									</div>
									<div class="alert-danger" id="errmsgPass" style="display: none;">
									password and confirm pass should be equal.
									</div>	
																																												
							</div>
						</h2>
						<!-- End Box Head -->
						<form:form action="" commandName="doctortypeCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small categery-topbox block-box-top-header-dept">
				
	 <div class="block-input">
		<label>Doctor type Name</label>

		<form:input path="doctortypeName" id="doctortypeNameId" onkeyup="duplicateChecks()" 
			onfocus="removeBorder(this.id)" 
			 tabindex="1"/>

			</div>
 			
			<div class="block-input">
		<label>Doctor type Desc</label>
		<form:input path="doctortypeDesc" maxlength="13" id="doctortypeDescId" onkeyup="duplicateChecks()" 
		 onfocus="removeBorder(this.id)" tabindex="2" />
	</div>
	
	</div>
							<div class="block-footer">
								<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: block;">
										<c:forEach var="success" items="${param.AddSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Doctor type
												<spring:message code="label.saveSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" /> 
												Doctor type
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: block;">
										<c:forEach var="success" items="${param.UpdateSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Doctor type
												<spring:message code="label.updateSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="upfail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">	
							             	<aside class="block-footer-left fail">
												<spring:message code="label.error" /> Doctor type
												<spring:message code="label.updateFail" />
											</aside>
										</c:forEach>
									</div>
									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Doctor type
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Doctor type
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											doctortype already Exists. Please try Some Other</aside>
									</div>
									<!-- <div class="alert-danger " id="emaildupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Email already Exists. Please try Some Other</aside>
									</div> -->

								</aside>
								<aside class="block-footer-right">
									<input type="button"
										class="btn-cancel"
										value="<spring:message code="label.clear" />" id="cancelId" tabindex="11"  onclick="dataClear();"/>
									<input type="submit" class="btn-save"
										value="<spring:message code="label.save"/>" id="submitId" tabindex="10"/>
								</aside>
							</div>
						</form:form>
					</div>					
				</c:if>
			</div>
			<c:if test="${not empty editDoctorType }">
			<div class="block">
						
				<!-- <div class="head-box"> -->
					<h2>
						<span class="icon1">&nbsp;</span>
							Edit Doctor type
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
				
				<form:form action="" commandName="doctortypeCmd" method="post"
					id="editForm" cssClass="form-horizontal">
					<div class="block-box-small categery-topbox block-box-top-header-dept">
						<form:hidden path="doctortypeId" />
						
						<div class="block-input">
		<label>Doctor type Name</label>

		<form:input path="doctortypeName" 
			onchange="getClient(),searchClients(this.id)" onkeyup=""
			onfocus="removeBorderChose(this.id)" tabindex="1"/>

			</div>
			
			<div class="block-input">
		<label>Doctor type Desc</label>
		<form:input path="doctortypeDesc" maxlength="13"
			 class="Box numberValid" onfocus="removeBorder(this.id)" tabindex="2" />
	</div>
	

					</div>
					<div class="block-footer">
					<div class="alert-danger" id="dupEditMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Doctor type already Exists. Please try Some Other</aside>
									</div>
						 
						<aside class="block-footer-right">
							<a href="doctortypeHome.htm"><input type="button" class="btn-cancel"
								value="<spring:message code="label.cancel"/>" id="cancelId" tabindex="11"/></a>
							<input type="submit" class="btn-save"
								value="<spring:message code="label.update"/>" id="updateId" tabindex="10"/>
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
						<span class="icon2">&nbsp;</span>Current doctortype
					</h2>
					<form:form action="searchDoctorType.htm" commandName="doctortypeCmd" method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt" onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="13"/>
							<form:input path="doctortypeName" id="addSearchId" 
								autocomplete="off" class="search-input" maxlength="30" tabindex="12"/>
						</aside>
					</form:form>
					<!-- <aside class="search-box">
								<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> -->
				</div>
				<div class="block-box-dept categery-downbox-customer block-box-last-dept">
					<ul class="table-list">
						<li class="dept-box">Doctor Type Name
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