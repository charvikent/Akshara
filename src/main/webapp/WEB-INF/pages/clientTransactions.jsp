
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Custmer Bank Details </title>
<script type="text/javascript" src="js/js/csvDownload1.js"></script>

</head>
<script type="text/javascript">
$(document).ready(function() {
	var list = ${transactionList};
	showData(list);
	
	
});
</script>
<style>
.table-list-blk-dept ul li.three-box {
    width: 122px;
}
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
		               
								 $('#saveIds').click(function(e){
												/* $('#saveIds').css('border', 'solid 3px #862ab7'); */												    
												if($('#accholderName').val().length == 0 || $('#accountNumber').val().length == 0 ||  $('#bankNameId').val().length == 0 ||  $('#branchNameId').val().length == 0 ||  $('#ifscCodeId').val().length == 0 || $('#amountid').val().length == 0 || $('#dateId').val().length == 0 ){												   
											    
											    if($('#accholderName').val().length == 0 ) {
												    $('#accholderName').css('color','red');
												    $("#accholderName").css("border-color","red");
												    $("#accholderName").attr("placeholder","Please enter A/c Holder Name");
												    $('#accholderName').addClass('your-class');
												   
												    }
											    if($('#accountNumber').val().length == 0 ) {
												    $('#accountNumber').css('color','red');
												    $("#accountNumber").css("border-color","red");
												    $("#accountNumber").attr("placeholder","Please enter A/c Number");
												    $('#accountNumber').addClass('your-class');
												   
												    }
											    if($('#bankNameId').val().length == 0 ) {
												    $('#bankNameId').css('color','red');
												    $("#bankNameId").css("border-color","red");
												    $("#bankNameId").attr("placeholder","Please enter Bank Name");
												    $('#bankNameId').addClass('your-class');
												   
												    }
											    if($('#branchNameId').val().length == 0 ) {
												    $('#branchNameId').css('color','red');
												    $("#branchNameId").css("border-color","red");
												    $("#branchNameId").attr("placeholder","Please enter Branch Name");
												    $('#branchNameId').addClass('your-class');
												   
												    }
											    if($('#ifscCodeId').val().length == 0 ) {
												    $('#ifscCodeId').css('color','red');
												    $("#ifscCodeId").css("border-color","red");
												    $("#ifscCodeId").attr("placeholder","Please enter IFSC Code");
												    $('#ifscCodeId').addClass('your-class');
												   
												    }
											    if($('#amountid').val().length == 0 ) {
												    $('#amountid').css('color','red');
												    $("#amountid").css("border-color","red");
												    $("#amountid").attr("placeholder","Please enter Amount");
												    $('#amountid').addClass('your-class');
												   
												    }
											    if($('#dateId').val().length == 0 ) {
												    $('#dateId').css('color','red');
												    $("#dateId").css("border-color","red");
												    $("#dateId").attr("placeholder","Please enter Date");
												    $('#dateId').addClass('your-class');
												   
												    }
											    return false;												  
												    } 
												//saveUser();
												$('#accholderName').removeClass('your-class default-class');
												$('#accountNumber').removeClass('your-class default-class');
												$('#bankNameId').removeClass('your-class default-class');
												$('#branchNameId').removeClass('your-class default-class');
												$('#ifscCodeId').removeClass('your-class default-class');
												$('#amountid').removeClass('your-class default-class');
												$('#dateId').removeClass('your-class default-class');
												 
												   
						});

						
								});
</script>
<script>
var transactionId= 0;
function editPack(id)
{		 		
	transactionId = serviceUnitArray[id].id;
	$('#accholderName').val( serviceUnitArray[id].achountHolderName);
	 $('#accholderName').trigger("chosen:updated");
	$('#accountNumber').val( serviceUnitArray[id].acountNumber);
	$('#bankNameId').val( serviceUnitArray[id].bankName);
	$('#branchNameId').val( serviceUnitArray[id].branchName);
	$('#ifscCodeId').val( serviceUnitArray[id].ifscCode);
	$('#amountid').val( serviceUnitArray[id].amount);
	$("#dateId").val( serviceUnitArray[id].transactionDate);
}
$(function() {
	$("#dateId").datepicker({
		changeDate : true,
		changeMonth : true,
		changeYear : true,
		showButtonPanel : false,
		dateFormat : 'yy-mm-dd'
	});

});
</script>
<script type="text/javascript">
function saveUser(){
	
	dnr= {};
	dnr.accholderName =$("#accholderName").val();
	dnr.accountNumber =$("#accountNumber").val();
	dnr.bankNameId =$("#bankNameId").val();
	dnr.branchNameId =$("#branchNameId").val();
	dnr.ifscCodeId =$("#ifscCodeId").val();
	dnr.amountid =$("#amountid").val();
	dnr.dateId =$("#dateId").val();
	dnr.id = transactionId;
	$.blockUI({ message: 'Please Wait' });
	$.ajax({
		type:"POST",
		url:"saveClientBankDetails.json",
		data:dnr,
		dataType:"json",
		success:function(response){
			$.unblockUI();
			if(response != null ){
				location.reload();
				showData(response);
				
			}
		}
	});
}
	function onlyNos(e, t) {
	    try {
	        if (window.event) {
	            var charCode = window.event.keyCode;
	        }
	        else if (e) {
	            var charCode = e.which;
	        }
	        else { return true; }
	        if (charCode > 31 && (charCode<45||charCode>57)) {
	        	/* alert("Please enter only numbers"); */
	            return false;
	        }
	        return true;
	    }
	    catch (err) {
	        /* alert(err.Description); */
	    }
	}
	function showData(response){
		$("#userdata ul").remove();
		$("#userdata ul li").remove();
		serviceUnitArray = {};
		$.each(response,
				function(i, catObj) {
				serviceUnitArray[catObj.id] = catObj;
				var tblRow = "<ul>"
					+ "<li class='three-box'>"+catObj.clientName+"</li>"
					+ "<li class='three-box'>"+catObj.acountNumber+"</li>"
					+ "<li class='three-box'>"+catObj.bankName+"</li>"
					+ "<li class='three-box'>"+catObj.branchName+"</li>"
					+ "<li class='three-box'>"+catObj.ifscCode+"</li>"
					+ "<li class='three-box'>"+catObj.amount+"</li>"
					+ "<li class='three-box'>"+catObj.transactionDate+"</li>"
					+ "<li ' class='three-box'>"
					+ '<a href="javascript:void(0)" onclick=editPack('
					+ catObj.id + ')' +  '  >Edit</a>'
					+ '</li>'
						+ '</ul>';
					$(tblRow).appendTo("#itemContainer");
				});
		paginationTable(7);
	}
	/* function editPack(id)
	{
		$('#accholderName').val( serviceUnitArray[id].achountHolderName);
		 $('#accholderName').trigger("chosen:updated");
		$('#accountNumber').val( serviceUnitArray[id].acountNumber);
		$('#bankNameId').val( serviceUnitArray[id].bankName);
		$('#branchNameId').val( serviceUnitArray[id].branchName);
		$('#ifscCodeId').val( serviceUnitArray[id].ifscCode);
		$('#amountid').val( serviceUnitArray[id].amount);
		$('#dateId').val( serviceUnitArray[id].transactionDate);
		
	} */

	function forDelete(id) {
		var count = 0;
		 jConfirm('Do You Want to Delete ?', 'Alert Box',
				 function(r)
				 {
		if (r == true) {
			var deleteId = id;
			$.ajax({
						type : "POST",
						url : "userDelete.json",
						data : "id=" + deleteId,
						dataType : "json",
						success : function(list) {
							document.getElementById("upsus").style.display = "none";
							document.getElementById("addsus").style.display = "none";
							document.getElementById("deleteMsgSus").style.display = "block";
							showData(list);
						}
					});
		};
				 });
		
				 
	}
</script>
</head>
<body>

	<div class="wrapper">
		<div class="container">
			<div class="mainfunction saveUser()_content">

				<div class="block">
					<h2>
						<span class="icon1">&nbsp;</span> <a href='javascript:void(0)'
							onclick='addPack()'> Client Details</a>
						<div class="block-footer-right1 fail">
							<div class="alert-danger" id="errmsg1" style="display: none;">
								please enter atleast 3 characters</div>
							<div class="alert-danger" id="errmsg" style="display: none;">
								Alphanumerics, ., & and _ Are only Allowed</div>
							<div class="alert-danger" id="errmsg2" style="display: none;">
								First Letter Should Be Alphanumeric.</div>

						</div>
					</h2>
					<!-- End Box Head -->
					
						<div
							class="block-box-small package-topbox block-box-top-header-dept"
							style="height: 100px !important;">
							<form:form action="" commandName="clientTransactionCmd" method="post">
							<div class="block-input ">
							<label>Client Name:</label>
											 <form:select path="clientId" id="accholderName"   cssClass="some-select"   tabindex="2">
											 <form:option value="0">--Select--</form:option>
											<form:options items="${users}"></form:options>
											</form:select>	</div>
							<div class="block-input ">
								<label>Account Number<span style="color: red;">*</span></label>
								<input type="text" id="accountNumber"
									placeholder="Please enter Account Number" tabindex="2" />
							</div>

							<div class="block-input last">
								<label>Bank Name<span style="color: red;">*</span></label> <input
									type="text" id="bankNameId" maxlength="13"
									placeholder="Please enter Bank Name" tabindex="3" />
							</div>
							<div class="block-input ">
								<label>Branch Nmae<span style="color: red;">*</span></label> <input
									type="text" id="branchNameId" maxlength="13"
									placeholder="Please enter Branch Name" tabindex="4" />
							</div>
							<div class="block-input">
								<label>IFSC Code<span style="color: red;">*</span></label> <input
									type="text" id="ifscCodeId" maxlength="13"
									placeholder="Please enter IFSC CODE" tabindex="5" />
							</div>
							<div class="block-input last">
								<label>Amount<span style="color: red;">*</span></label> <input
									type="text" id="amountid" maxlength="13"
									placeholder="Please enter Amount" tabindex="6" />
							</div>
							<div class="block-input">
								<label>Date<span style="color: red;">*</span></label> <input
									type="text" id="dateId" maxlength="13"
									placeholder="Please enter Date" tabindex="7" />
							</div>
						</div>
						<div class="block-footer">
							<aside class="block-footer-left sucessfully">
								<div id="addsus" style="display: none;">
									<div class="alert-success">
										<spring:message code="label.success" />
										User
										<spring:message code="label.saveSuccess" />
									</div>
								</div>
								<div id="addfail" style="display: block;">
									<c:forEach var="fail" items="${param.AddFail}">
										<aside class="block-footer-left fail">
											<spring:message code="label.error" />
											User
											<spring:message code="label.saveFail" />
										</aside>

									</c:forEach>
								</div>
								<div id="upsus" style="display: none;">

									<div class="alert-success">
										<spring:message code="label.success" />
										User
										<spring:message code="label.updateSuccess" />
									</div>

								</div>
								<div id="upfail" style="display: block;">
									<c:forEach var="fail" items="${param.UpdateFail}">
										<aside class="block-footer-left fail">
											<spring:message code="label.error" />
											User
											<spring:message code="label.updateFail" />
										</aside>
									</c:forEach>
								</div>
								<div id="deleteMsgSus" style="display: none;">
									<aside class="block-footer-left sucessfully">
										<spring:message code="label.success" />
										User
										<spring:message code="label.deleteSuccess" />
									</aside>
								</div>
								<div id="deleteMsgFail" style="display: none;">
									<aside class="block-footer-left sucessfully">
										<spring:message code="label.deleteFail" />
										User
										<spring:message code="label.deleteFail" />
									</aside>
								</div>
								<div class="alert-danger " id="dupMessage"
									style="display: none;">
									<aside class="block-footer-left fail">Warning : Package
										already Exists. Please try Some Other</aside>
								</div>
							</aside>
							<aside class="block-footer-right">
								<input type="button" class="btn-cancel"
									value="<spring:message code="label.clear" />" id="cancelId"
									tabindex="9" onclick="dataClear();" /> <input type="button"
									class="btn-cancel" value="<spring:message code="label.save"/>"
									id="saveIds" onclick="saveUser()" tabindex="8" />
							</aside>
						</div>
					</form:form>


				</div>
			</div>

			<!--Edit Box End  -->
			<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Client Bank Details
					</h2>
					<a href="#" class="export" style="color: yellow;">Export Table data into CSV</a>
					<form>
						<aside class="search-box">
							<input type="submit" class="search-bnt"
								onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="11" />
						<%-- 	<form:input path="mobile" id="addSearchId" autocomplete="off"
								class="search-input" maxlength="30" tabindex="10" /> --%>
						</aside>
					</form>
					<!-- <aside class="search-box">
								<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> -->
				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept itemContainer"
					style='height: 313px  !important;'>
					<ul class="table-list" style=" font-weight: 600;  ">
								<li class="three-box">A/c Holder Name</li>
							    <li class="three-box">Account No</li>
							    <li class="three-box">bankNameId</li>
								<li class="three-box">Branch Name</li> 
								<li class="three-box">IFSC Code</li>
								<li class="three-box">Amount</li>
								<li class="three-box">Date</li>
								<li class="three-box">Edit</li>
							</ul>
					<div
						class="table-list-blk-dept categery-tablelis data-grid-big paginationParentDiv"
						id="userdata">
						<div id="itemContainer" class="itemContainer"></div>
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
	
</body>
</html>
