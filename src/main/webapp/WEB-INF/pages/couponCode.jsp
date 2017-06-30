<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Coupon Code</title>
<style>
.your-class::-webkit-input-placeholder {
	color: red;
}

.default-class::-webkit-input-placeholder {
	color: red;
}
</style>
<script type="text/javascript" src="js/dateformat.js"></script>
<script type="text/javascript">
	/* $(document).ready(function() {
		               
								 $('#saveId').click(function(e){
												 $('#saveIds').css('border', 'solid 3px #862ab7'); 												    
												if($('#partnerId').val().length == 0 || $('#baseCodeId').val().length == 0 || $('#displayText1').val().length == 0 || $('#displayText2').val().length == 0 || $('#amount').val().length == 0 || $('#amount').val().length == 0 || $('#numberTimes').val().length == 0 || $('#totalCount').val().length == 0 || $('#expiryTime').val().length == 0){												   
													 if($('#partnerId').val().length == 0 ) {
													    	$('#partnerId').css('color','red');
															$("#partnerId_chosen").find('.chosen-single').css("border","1px solid red");
															$("#partnerId").css("border-color","red");
															$('#partnerId').addClass('your-class');
														    } 
													if($('#baseCodeId').val().length == 0 ) {
												    $('#baseCodeId').css('color','red');
												    $("#baseCodeId").css("border-color","red");
												    $("#baseCodeId").attr("placeholder","Please enter baseCode");
												    $('#baseCodeId').addClass('your-class');
												   
												    }
											     if($('#displayText1').val().length == 0 ) {
												    $('#displayText1').css('color','red');
												    $("#displayText1").css("border-color","red");
												    $("#displayText1").attr("placeholder","Please enter displayText1");
												    $('#displayText1').addClass('your-class');
												   
												    }
											    if($('#displayText2').val().length == 0 ) {
												    $('#displayText2').css('color','red');
												    $("#displayText2").css("border-color","red");
												    $("#displayText2").attr("placeholder","Please enter displayText2");
												    $('#displayText2').addClass('your-class');
												   
												    }	
											    if($('#amount').val() == 0.0 ) {
											    	$('#amount').val("");
												    $('#amount').css('color','red');
												    $("#amount").css("border-color","red");
												    $("#amount").attr("placeholder","Please enter amount");
												    $('#amount').addClass('your-class');
												   
												    }	
											    if($('#numberTimes').val() == 0 ) {
											    	$('#numberTimes').val("");
												    $('#numberTimes').css('color','red');
												    $("#numberTimes").css("border-color","red");
												    $("#numberTimes").attr("placeholder","Please enter numberTimes");
												    $('#numberTimes').addClass('your-class');
												   
												    }	
											    if($('#totalCount').val() == 0 ) {
											    	$('#totalCount').val("");
												    $('#totalCount').css('color','red');
												    $("#totalCount").css("border-color","red");
												    $("#totalCount").attr("placeholder","Please enter totalCount");
												    $('#totalCount').addClass('your-class');
												   
												    }	
											    if($('#expiryTime').val().length == 0 ) {
												    $('#expiryTime').css('color','red');
												    $("#expiryTime").css("border-color","red");
												    $("#expiryTime").attr("placeholder","Please enter expiryTime");
												    $('#expiryTime').addClass('your-class');
												   
												    }	 
											    return false;												  
												    } 
												
												 
												   
						});

						
								}); */
</script>
<script type="text/javascript">
	$(document).ready(function() {
		chosenDropDown();
		$(function() {
			$("#expiryTime").datepicker({
				changeDate : true,
				changeMonth : true,
				changeYear : true,
				showButtonPanel : false,
				dateFormat : 'yy-mm-dd',
				minDate:'0d' 
			});

		});
		var list = ${couponList};
			showData(list);
	});
	
	function editPack(id)
	{
		$('#baseCodeId').val( serviceUnitArray[id].baseCode);
		$('#partnerId').val( serviceUnitArray[id].partnerId);
		$("#partnerId").trigger("chosen:updated");
		$('#displayText1').val( serviceUnitArray[id].displayText1);
		$('#displayText2').val( serviceUnitArray[id].displayText2);
		$('#numberTimes').val( serviceUnitArray[id].numberTimes);
		$('#amount').val( serviceUnitArray[id].amount);
		$('#totalCount').val( serviceUnitArray[id].totalCount);
		$('#expiryTime').val(new Date(serviceUnitArray[id].expiryTime).format("yyyy-mm-dd"));
		$("#id").val(id);
	}
	
function showData(list){
	$("#itemContainer ul li").remove();
	$("#itemContainer ul").remove(); 
	serviceUnitArray ={};
	$.each(list,function(i, locObj) {
		serviceUnitArray[locObj.id] = locObj;
	var tblRow = "<ul>"
	+ "<li class='dept-box' style='width:868px'>"
								+ locObj.code
								+ "</li>"
								+ "<li class='dept-box' style='width:100px'>"
								+ locObj.totalCount
								+ "</li>"
								+ "<li class='eleven-box '>"
								+ '<a href="javascript:void(0)" onclick=editPack('
								+ locObj.id + ')' +  ' class="" >Edit</a>'
								+ '</li>'
								+ "<li class='ten-box last'>"
								+ "<a href='javascript:void(0)' id='"
								+ locObj.id
								+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
								+ '</li>' + '</ul>';
						$(tblRow).appendTo("#itemContainer");
 						paginationTable(10); 
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
        	alert("Please enter only numbers");
            return false;
        }
        return true;
    }
    catch (err) {
        /* alert(err.Description); */
    }
}
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
function forDelete(id) {
	var count = 0;
	 jConfirm('Do You Want to Delete ?', 'Alert Box',
			 function(r)
			 {
	if (r == true) {
		var deleteId = id;
		$.ajax({
					type : "POST",
					url : "couponCodeDelete.json",
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
							class="block-box-small categery-topbox block-box-top-header-dept" style=" height: 85px !important; ">
							<form:hidden path="id"/>
							<div class="block-input">
								<label>Partner<span style="color: red;">*</span></label>
								<form:select path="partnerId"  class="some-select" onchange="partnerCode(this.id)"
									autocomplete="off" onkeydown="removeBorder(this.id)"
									tabindex="2" >
									<form:option value="">--Select--</form:option>
									<form:options items="${partners}"></form:options>
									</form:select>
							</div>
							<div class="block-input">
								<label>Base Code<span style="color: red;">*</span></label>
								<form:input path="baseCode" id="baseCodeId" class="alphaNumericValid1"
									autocomplete="off" onkeydown="removeBorder(this.id)"
									tabindex="2" />
							</div>
							<div class="block-input last">
								<label>Display Text1<span style="color: red;">*</span></label>
								<form:input path="displayText1" class="alphaNumericValid1"
									autocomplete="off"  onkeydown="removeBorder(this.id)"
									tabindex="2" />
							</div>
							<div class="block-input ">
								<label>Display Text2<span style="color: red;">*</span></label>
								<form:input path="displayText2" class="alphaNumericValid1"
									autocomplete="off" onkeydown="removeBorder(this.id)"
									tabindex="3" />
							</div>
							<div class="block-input">
								<label>Amount<span style="color: red;">*</span></label>
								<form:input path="amount" class="alphaNumericValid1" onkeypress="return onlyNos(event,this);"
									autocomplete="off" onkeydown="removeBorder(this.id)"
									tabindex="3" />
							</div>
							<div class="block-input last">
								<label>No.of times<span style="color: red;">*</span></label>
								<form:input path="numberTimes" class="alphaNumericValid1" onkeypress="return onlyNos(event,this);"
									autocomplete="off" onkeydown="removeBorder(this.id)"
									tabindex="3" />
							</div>
							<div class="block-input">
								<label>Total Count<span style="color: red;">*</span></label>
								<form:input path="totalCount" class="alphaNumericValid1" onkeypress="return onlyNos(event,this);"
									autocomplete="off" onkeydown="removeBorder(this.id)"
									tabindex="3" />
							</div>
							<div class="block-input">
							<label>Expiry Date<span style="color: red;">*</span></label>
								<form:input path="expiryTime" class="alphaNumericValid1"
									autocomplete="off" onkeydown="removeBorder(this.id)"
									tabindex="3" />
								
							</div>
							<%-- <form:errors path="categoryDesc" /> --%>
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
				<div class="block-box-dept categery-downbox block-box-last-dept" style="height:285px !important;">
					<ul class="table-list">
						<li class="one-box" style='width:868px' >Base Code
							<ul>
								<li><a class="top" href="#">&nbsp;</a></li>
								<li><a class="bottom" href="#">&nbsp;</a></li>
							</ul>
						</li>
						
						<li class="dept-box" style='width:100px'>NumberOfCoupns
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
		dnr.baseCode =$("#baseCodeId").val();
		dnr.displayText1 =$("#displayText1").val();
		dnr.partnerId =$('#partnerId').val();
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
					 	$("#baseCodeId").val("");
						$("#displayText1").val("");
						$("#displayText2").val("");
						$("#amount").val("");
						$("#numberTimes").val("");
						$("#totalCount").val("");
						$("#expiryTime").val("");
						$("#partnerId").val("");
						$("#partnerId").trigger("chosen:updated");
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