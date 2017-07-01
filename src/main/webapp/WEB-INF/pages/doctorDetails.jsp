<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Doctor</title>
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
	var categoryList = ${CatList};
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
		$.each(categoryList,
						function(i, catObj) {
							var tblRow = "<ul>"
								 + "<li class='dept-box'>"
									+ catObj.categoryName
									+ "</li>"
									+ "<li class='eleven-box '>"
									+ '<a href="editCat.htm?categoryId='
									+ catObj.categoryId
									+ '" class="">Edit</a>'
									+ '</li>'
									+ "<li class='ten-box last'>"
									+ "<a href='javascript:void(0)' id='"
									+ catObj.categoryId
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
		                $('#categoryName').focus();
		                $('#categoryDesc').val('');
						$('#addSearchId').val('');
						 chosenDropDown(); 
						//AddForm Validations
						
								 $('#submitId').click(function(e){
												  
												$('#submitId').css('border', 'solid 3px #862ab7');												    
												if( $('#categoryDesc').val().length == 0){												   
												
											    if($('#categoryDesc').val().length == 0 ) {
												    $('#categoryDesc').css('color','red');
												    $("#categoryDesc").css("border-color","red");
												    $("#categoryDesc").attr("placeholder","Please Enter Category");
												    $('#categoryDesc').addClass('your-class');
												    }												     
												    return false;												  
												    } 
												    
											$('#addForm').attr('action',"<c:url value='/doctorAdd.htm'/>");
											$("#addForm").submit();											
											event.preventDefault();
											document.getElementById("dupMessage").style.display = "none";
						});

						$('#updateId').click(function(event) {
											
											$('#updateId').css('border', 'solid 3px #862ab7');										    
										    if($('#categoryName').val().length == 0){										   
										    
										    if($('#categoryName').val().length == 0 ) {
										       $('#categoryName').css('color','red');
										       $("#categoryName").css("border-color","red");
										       $("#categoryName").attr("placeholder","Please Enter Category");
										       $('#categoryName').addClass('your-class');
										    }										     
										    return false;										  
										    } 
										    var val=$('#categoryName').val().charCodeAt(0);
										    var val1=$('#categoryName').val();
										    var regex=new RegExp("^[a-zA-Z0-9][a-zA-Z0-9._& ]+$");
										    if(val==32 || val==95||val==38||val==46||$('#categoryName').val().length <3 )
										    	{
										    	if(val==32 || val==95||val==38||val==46){c3();}
										    	else{c2();}										    	
										    	$('#categoryName').focus();
										    	return false;
										    }
										    if(!(regex.test(val1))){c1();									    	
						    					return false;
						    				}
											$('#editForm').attr('action',"<c:url value='/catUpdate.htm'/>");
											$("#editForm").submit();
											event.preventDefault();
										});
								});
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
						url : "deleteCat.htm",
						data : "deleteId=" + deleteId,
						dataType : "json",
						success : function(CatList) {
							//alert("CatList is:"+CatList);
							if (CatList == "") {
								$('#noSortData').show();
								$('#legend2').hide();
								$('.holder').hide();
							} else {
								$('#noSortData').hide();
								$('#legend2').show();
								$('.holder').show();
								$.each(CatList,function(i, categoryObj) {
													if (categoryObj.sMsg == "Success" && count == 0) {
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
															+ categoryObj.categoryName
															+ "</li>"
															+ "<li class='eleven-box '>"
															+ '<a href="editCat.htm?categoryId='
															+ categoryObj.categoryId
															+ '" class="">Edit</a>'
															+ '</li>'
															+ "<li class='ten-box last'>"
															+ "<a href='javascript:void(0)' id='"
															+ categoryObj.categoryId
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
		jAlert('please enter category', 'Alert Box');
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
	 $('#categoryDesc').val("");
	  removeBorder('categoryDesc');
	  $("#categoryDesc").attr("placeholder","");
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
				<c:if test="${empty catEdit}">
					<div class="block">
						<h2>
							<span class="icon1">&nbsp;</span>
							Upload File
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
						<form:form action="doctorAdd.htm" commandName="doctorCmd" method="post"
							id="addForm" cssClass="form-horizontal" enctype="multipart/form-data">
							<div class="block-box-small categery-topbox block-box-top-header-dept">
								
								<div class="block-input">
											<label>Upload CVS File<span
												style="color: red;">*</span></label>
											<form:input path="csvFilePath" id="categoryDesc" type="file"  onkeyup="duplicateChecks()" class="alphaNumericValid1" 
												maxlength="30" autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="1"/>
										</div>								
								<%-- <form:errors path="categoryDesc" /> --%>
							</div>
							<div class="block-footer">
								<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: block;">
										<c:forEach var="success" items="${param.AddSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Doctor
												<spring:message code="label.saveSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.saveSuccess" /> 
												Doctor
												 <spring:message code="label.saveFail" /> 
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: block;">
										<c:forEach var="success" items="${param.UpdateSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Doctor
												<spring:message code="label.updateSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="upfail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">	
							             	<aside class="block-footer-left fail">
												<spring:message code="label.error" /> Doctor
												<spring:message code="label.updateFail" />
											</aside>
										</c:forEach>
									</div>
									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Doctor
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Doctor
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Doctor already Exists. Please try Some Other</aside>
									</div>

								</aside>
								<aside class="block-footer-right">
									<input type="button"
										class="btn-cancel"
										value="<spring:message code="label.clear" />" id="cancelId" tabindex="4"  onclick="dataClear();"/>
									<input type="submit" class="btn-save"
										value="Upload" id="" tabindex="3"/>
								</aside>
							</div>
						</form:form>
					</div>					
				</c:if>
			</div>
			<c:if test="${not empty catEdit }">
			<div class="block">
						
				<!-- <div class="head-box"> -->
					<h2>
						<span class="icon1">&nbsp;</span>
							<spring:message code="label.editCategory"></spring:message>
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
				
				<form:form action="" commandName="doctorCmd" method="post"
					id="editForm" cssClass="form-horizontal">
					<div class="block-box-small categery-topbox block-box-top-header-dept">
						<form:hidden path="csvFilePath" />
						
						<div class="block-input last">
								<label>Image</label>
								<form:input type="file" path="imageRVideo" tabindex="11"
									class="Box" />
							</div>
					</div>
					<div class="block-footer">
					<div class="alert-danger" id="dupEditMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Doctor already Exists. Please try Some Other</aside>
									</div>
						 
						<aside class="block-footer-right">
							<a href="doctorHome.htm"><input type="button" class="btn-cancel"
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
						<span class="icon2">&nbsp;</span>Current Categories
					</h2>
					<form:form action="searchCat.htm" commandName="doctorCmd" method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt" onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="6"/>
							<%-- <form:input path="categoryName" id="addSearchId" 
								autocomplete="off" class="search-input" maxlength="30" tabindex="5"/> --%>
						</aside>
					</form:form>
					<!-- <aside class="search-box">
								<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> -->
				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept">
					<ul class="table-list">
						<li class="dept-box">Category Name
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