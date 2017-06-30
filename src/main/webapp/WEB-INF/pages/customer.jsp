<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Customer</title>
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
	var customerList = ${CusList};
	if (customerList == "") {
		$('#tablePagination').remove();
		$("#userdata ul li").remove();
		$('#noSortData').show();
		$('#legend2').hide();
		$('.holder').hide();
	} else {
		$('#noSortData').hide();
		$('#legend2').show();
		$('.holder').show();
		$.each(customerList,
						function(i, catObj) {
							var tblRow = "<ul>"
								 + "<li class='dept-box'>"
									+ catObj.customerName
									+ "</li>"
									+ "<li class='eleven-box '>"
									+ '<a href="editCustomer.htm?customerId='
									+ catObj.customerId
									+ '" class="">Edit</a>'
									+ '</li>'
									+ "<li class='ten-box last'>"
									+ "<a href='javascript:void(0)' id='"
									+ catObj.customerId
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
		                $('#customerName').focus();
		                $('#customerName').val('');
						$('#addSearchId').val('');
						 chosenDropDown(); 
						//AddForm Validations
						
								 $('#submitId').click(function(e){
												 $('#submitId').css('border', 'solid 3px #862ab7');												    
												 if($('#customernameId').val().length == 0 || $('#mobilenumberId').val().length == 0 || $('#emailId').val().length == 0 || $('#address1Id').val().length == 0 || $('#address2Id').val().length == 0 || $('#cityId').val().length == 0){
													 if($('#customernameId').val().length == 0 ) {
														    $('#customernameId').css('color','red');
														    $("#customernameId").css("border-color","red");
														    $("#customernameId").attr("placeholder","Please Enter Customer");
														    $('#customernameId').addClass('your-class');
														    }
													  if($('#mobilenumberId').val().length == 0 ) {
														    $('#mobilenumberId').css('color','red');
														    $("#mobilenumberId").css("border-color","red");
														    $("#mobilenumberId").attr("placeholder","Please Enter Mobile number");
														    $('#mobilenumberId').addClass('your-class');
														    }
													 if($('#emailId').val().length == 0 ) {
														    $('#emailId').css('color','red');
														    $("#emailId").css("border-color","red");
														    $("#emailId").attr("placeholder","Please Enter Email");
														    $('#emailId').addClass('your-class');
														    }	
													 if($('#address1Id').val().length == 0 ) {
														    $('#address1Id').css('color','red');
														    $("#address1Id").css("border-color","red");
														    $("#address1Id").attr("placeholder","Please Enter Address");
														    $('#address1Id').addClass('your-class');
														    }
													 if($('#address2Id').val().length == 0 ) {
														    $('#address2Id').css('color','red');
														    $("#address2Id").css("border-color","red");
														    $("#address2Id").attr("placeholder","Please Enter Address");
														    $('#address2Id').addClass('your-class');
														    }	
													    if($('#cityId').val().length == 0 ) {
														    $('#cityId').css('color','red');
														    $("#cityId").css("border-color","red");
														    $("#cityId").attr("placeholder","Please Enter City");
														    $('#cityId').addClass('your-class');
														    }
													    if($('#stateId').val().length == 0 ) {
													    	$('#stateId').css('color','red');
															$("#stateId_chosen").find('.chosen-single').css("border","1px solid red");
															$("#stateId").css("border-color","red");
															$('#stateId').addClass('your-class');
														    } 
													     if($('#pincodeId').val().length == 0 ) {
														    $('#pincodeId').css('color','red');
														    $("#pincodeId").css("border-color","red");
														    $("#pincodeId").attr("placeholder","Please Enter pincode");
														    $('#pincodeId').addClass('your-class');
														    }	
													    if($('#passwordId').val().length == 0 ) {
														    $('#passwordId').css('color','red');
														    $("#passwordId").css("border-color","red");
														    $("#passwordId").attr("placeholder","Please Enter password");
														    $('#passwordId').addClass('your-class');
														    }  	
											 return false;
												 }
												 var val3=$('#mobilenumberId').val();
												 var val4=$('#emailId').val();
												 var regex1=new RegExp("^[0-9 ]+$");
												 var regex2=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
												  if(!(regex1.test(val3))){ 
													  $('#mobilenumberId').css('color','red');
													    $("#mobilenumberId").css("border-color","red");
										   			return false;
										  		    } 	
										  		    alert(! regex2.test(val4));
											    if(!(regex2.test(val4))){
											    	$('#emailId').css('color','red');
												    $("#emailId").css("border-color","red");
											    	return false;
											    	}

											$('#addForm').attr('action',"<c:url value='/cusAdd.htm'/>");
											$("#addForm").submit();											
											event.preventDefault();
											document.getElementById("dupMessage").style.display = "none";
						});

						$('#updateId').click(function(event) {
											
											 $('#updateId').css('border', 'solid 3px #862ab7');										    
										    if($('#customerName').val().length == 0){										   
										    
										    if($('#customerName').val().length == 0 ) {
										       $('#customerName').css('color','red');
										       $("#customerName").css("border-color","red");
										       $("#customerName").attr("placeholder","Please Enter Customer");
										       $('#customerName').addClass('your-class');
										    }										     
										    return false;										  
										    } 
										    var val=$('#customerName').val().charCodeAt(0);
										    var val1=$('#customerName').val();
										    var regex=new RegExp("^[a-zA-Z0-9][a-zA-Z0-9._& ]+$");
										    if(val==32 || val==95||val==38||val==46||$('#customerName').val().length <3 )
										    	{
										    	if(val==32 || val==95||val==38||val==46){c3();}
										    	else{c2();}										    	
										    	$('#customerName').focus();
										    	return false;
										    }
										    if(!(regex.test(val1))){c1();									    	
						    					return false;
						    				} 
											$('#editForm').attr('action',"<c:url value='/cusUpdate.htm'/>");
											$("#editForm").submit();
											event.preventDefault();
										});
								});
</script>

<script type="text/javascript">
function compPasswordss()
{
var pwd=$('#passwordId').val();
var cpwd=$('#conpwd').val();
if(pwd.length !="" && cpwd.length !="")
 {
 if(pwd != cpwd)
  {
  document.getElementById("errmsgPass").style.display = "block";
  setTimeout(function(){ $('#errmsgPass').fadeOut(); }, 2000);
  $('#passwordId').focus();
  $('#conpwd').val('');
  $('#passwordId').val(''); 
  return false;
  }else{
 document.getElementById("errmsgPass").style.display = "none";
  return true;
 };
 };
};
	function duplicateChecks() {
		var catname = $('#customerDesc').val();
		$.ajax({
					type : "POST",
					url : "catDuplicate.htm",
					data : "customerName=" + catname,
					success : function(response) {
						
						if (response != "") {
							document.getElementById("addsus").style.display = "none";
							document.getElementById("addfail").style.display = "none";
							document.getElementById("upsus").style.display = "none";
							document.getElementById("upfail").style.display = "none";
							document.getElementById("deleteMsgSus").style.display = "none";
							document.getElementById("deleteMsgFail").style.display = "none";
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
		var catname = $('#customerName').val();
		var customerId = $('#customerId').val();
		$.ajax({
					type : "POST",
					url : "catDuplicate.htm",
					data : "customerName=" + catname + "&customerId="
							+ customerId ,
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
						url : "deleteCustomer.htm",
						data : "deleteId=" + deleteId,
						dataType : "json",
						success : function(CusList) {
							//alert("CatList is:"+CatList);
							if (CusList == "") {
								$('#noSortData').show();
								$('#legend2').hide();
								$('.holder').hide();
							} else {
								$('#noSortData').hide();
								$('#legend2').show();
								$('.holder').show();
								$.each(CusList,function(i, customerObj) {
													if (customerObj.sMsg == "Success" && count == 0) {
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
													//alert(i + ": " +customerObj.categotyDesc+""+customerObj.customerId);
													var tblRow = "<ul>"
														+ "<li class='dept-box'>"
															/* + customerObj.deptName
															+ " "  */
															+ customerObj.customerName
															+ "</li>"
															+ "<li class='eleven-box '>"
															+ '<a href="editCat.htm?customerId='
															+ customerObj.customerId
															+ '" class="">Edit</a>'
															+ '</li>'
															+ "<li class='ten-box last'>"
															+ "<a href='javascript:void(0)' id='"
															+ customerObj.customerId
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
		var catname = $('#customerName').val();
		/* $.ajax({
					type : "POST",
					url : "catDuplicate.htm",
					data : "customerName=" + catname,
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
				}); */
	}
</script>
<script>
 function dataClear(){
	 $('#submitId').css('border', 'none');		
	 $('#customernameId').val("");
	  removeBorder('customernameId');
	  $("#customernameId").attr("placeholder","");
	  $('#mobilenumberId').val("");
	  removeBorder('mobilenumberId');
	  $("#mobilenumberId").attr("placeholder","");
	  $('#emailId').val("");
	  removeBorder('emailId');
	  $("#emailId").attr("placeholder","");
	  $('#address1Id').val("");
	  removeBorder('address1Id');
	  $("#address1Id").attr("placeholder","");
	  $('#address2Id').val("");
	  removeBorder('address2Id');
	  $("#address2Id").attr("placeholder","");
	  $('#cityId').val("");
	  removeBorder('cityId');
	  $("#cityId").attr("placeholder","");
	  $("#stateId").val("");
	  $("#stateId").trigger("chosen:updated");
	  removeBorderChose('stateId');
	  $('#pincodeId').val("");
	  removeBorder('pincodeId');
	  $("#pincodeId").attr("placeholder","");
	  $('#passwordId').val("");
	  removeBorder('passwordId');
	  $("#passwordId").attr("placeholder","");
	  $('#cpasswordId').val("");
	  removeBorder('cpasswordId');
	  $("#cpasswordId").attr("placeholder","");
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
				<c:if test="${empty cusEdit}">
					<div class="block">
						<h2>
							<span class="icon1">&nbsp;</span>
							Add New Customer
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
						<form:form action="" commandName="cusCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small client-topbox-customer block-box-top-header-dept">
								
		<div class="block-input">
		<label>Customer Name</label>

		<form:input path="customerName" id="customernameId" 
			onfocus="removeBorder(this.id)" onkeyup="duplicateChecks()"
			 tabindex="1"/>

			</div>
			
			<div class="block-input">
		<label>Mobile Number</label>
		<form:input path="mobileNumber" maxlength="13" id="mobilenumberId"
		 onfocus="removeBorder(this.id)" tabindex="2" />
	</div>
	<div class="block-input last">
		<label>Email</label>
		<form:input path="email" maxlength="30" id="emailId"
			 onfocus="removeBorder(this.id)" tabindex="3" />
	</div>
									<div class="block-input">
		<label>Address1</label>

		<form:input path="address1" maxlength="36"  id="address1Id"
		onfocus="removeBorder(this.id)"	tabindex="4" />

	</div>

	
	<div class="block-input">
		<label>Address2</label>
		<form:input path="address2" id="address2Id" maxlength="30"
			onfocus="removeBorder(this.id)"
			tabindex="5" />
	</div>
	<div class="block-input last">
		<label>City</label>
		<form:input path="city" id="cityId" maxlength="30"
			onfocus="removeBorder(this.id)" 
		tabindex="6" />
	</div>
	
	
							<div class="block-input ">
								<label>State</label>
								<form:select path="state" id="stateId"
									cssClass="some-select" onfocus="removeBorder(this.id)"
									tabindex="7">
									<form:option value="">--Select--</form:option>
									<form:options items="${states}"></form:options>
								</form:select>
							</div>
							<div class="block-input">
		<label>PIN Code</label>
		<form:input path="pincode" id="pincodeId"
			maxlength="30" onfocus="removeBorder(this.id)"
			tabindex="8" />
	</div>
	<div class="block-input last">
		<label>Password</label>
		<form:input path="password" id="passwordId" onblur="compPasswordss()" type="password"
			maxlength="30" onfocus="removeBorder(this.id)"
			tabindex="9" />
	</div>
	<div class="block-input">
		<label>Confirm Password</label>
		<form:input path="confirmPassword" id="conpwd" onblur="compPasswordss()"
			maxlength="30" onfocus="removeBorder(this.id)" type="password"
			tabindex="9" />
	</div>
	</div>
							<div class="block-footer">
								<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: block;">
										<c:forEach var="success" items="${param.AddSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Customer
												<spring:message code="label.saveSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" /> 
												customer
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: block;">
										<c:forEach var="success" items="${param.UpdateSus}">
											<div class="alert-success">
												<spring:message code="label.success" />
												Customer
												<spring:message code="label.updateSuccess" />
											</div>
										</c:forEach>
									</div>
									<div id="upfail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">	
							             	<aside class="block-footer-left fail">
												<spring:message code="label.error" /> customer
												<spring:message code="label.updateFail" />
											</aside>
										</c:forEach>
									</div>
									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Customer
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Customer
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Categroy already Exists. Please try Some Other</aside>
									</div>

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
			<c:if test="${not empty cusEdit }">
			<div class="block">
						
				<!-- <div class="head-box"> -->
					<h2>
						<span class="icon1">&nbsp;</span>
							Edit Customer
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
				
				<form:form action="" commandName="cusCmd" method="post"
					id="editForm" cssClass="form-horizontal">
					<div class="block-box-small client-topbox-customer block-box-top-header-dept">
						<form:hidden path="customerId" />
						
						<div class="block-input">
		<label>Customer Name</label>

		<form:input path="customerName" 
			onchange="getClient(),searchClients(this.id)" onkeyup="duplicateChecks()"
			onfocus="removeBorderChose(this.id)" tabindex="1"/>

			</div>
			
			<div class="block-input">
		<label>Mobile Number</label>
		<form:input path="mobileNumber" maxlength="13"
			 class="Box numberValid" onfocus="removeBorder(this.id)" tabindex="2" />
	</div>
	<div class="block-input last">
		<label>Email</label>
		<form:input path="email" maxlength="30"
			onfocus="removeBorder(this.id)" class="Box" tabindex="3" />
	</div>
									<div class="block-input">
		<label>Address1</label>

		<form:input path="address1" maxlength="36" class="Box"
			onfocus="removeBorder(this.id)" tabindex="4" />

	</div>
	
	
	<div class="block-input">
		<label>Address2</label>
		<form:input path="address2"  maxlength="30" class="Box alphabetValid"
			onfocus="removeBorder(this.id)" tabindex="5" />
	</div>
	<div class="block-input last">
		<label>City</label>
		<form:input path="city"  maxlength="30"
			class="Box alphabetValid" onfocus="removeBorder(this.id)" tabindex="6" />
	</div>
	<div class="block-input ">
								<label>State</label>
								<form:select path="state" cssClass="some-select Box" 
								onfocus="removeBorder(this.id)" tabindex="7">
									<form:option value="">--Select--</form:option>
									<form:options items="${states}"></form:options>
								</form:select>
							</div>
	<div class="block-input">
		<label>PIN Code</label>
		<form:input path="pincode" class="Box alphabetValid" maxlength="30"
			onfocus="removeBorder(this.id)" tabindex="8" />
	</div>
	<div class="block-input last">
		<label>Password</label>
		<form:input path="password" class="Box alphabetValid" maxlength="30"
			onfocus="removeBorder(this.id)" tabindex="9" />
	</div>
		<div class="block-input">
		<label>Confirm Password</label>
		<form:input path="confirmPassword" 
			maxlength="30" onfocus="removeBorder(this.id)"
			tabindex="9" />
	</div>

					</div>
					<div class="block-footer">
					<div class="alert-danger" id="dupEditMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Customer already Exists. Please try Some Other</aside>
									</div>
						 
						<aside class="block-footer-right">
							<a href="CustomerHome.htm"><input type="button" class="btn-cancel"
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
						<span class="icon2">&nbsp;</span>Current Categories
					</h2>
					<form:form action="searchCustomer.htm" commandName="cusCmd" method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt" onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="13"/>
							<form:input path="customerName" id="addSearchId" 
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
						<li class="dept-box">Customer Name
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