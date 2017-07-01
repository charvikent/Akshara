<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<link href="css/style.css" rel="stylesheet">
<title>Services</title>
<style>
.your-class::-webkit-input-placeholder {
	color: red;
}

.default-class::-webkit-input-placeholder {
	color: red;
}
</style>

<style>
.table-list-blk ul li.three-boxxx {
	width: 186px;
	text-align: center;
}
.table-list-blk ul li.forth-boxxxstatus {
	width: 127px;
}
.table-list-blk ul li.one1-box {
	width: 202px;
}
/* .table-list-blk ul li.quantity-boxxx{
width: 175px;
text-align:center;
} */
.table-list-blk ul li.one-boxxx {
	width: 235px;
}
.one-boxxx {
	width: 235px;
}
.two-boxxx {
	width: 100px;
}
.three-boxxx {
	width: 100px;
	text-align: center;
}
.colorbox {
	color: #800000;
}
.forth-boxxxstatus {
	width: 127px;
}
.stock-pcode-boxnew {
	width: 175px;
}
.table-list-blk ul li.eleven-box {
	width: 37px;
}
.one {
	width: 102px;
	text-align: center;
}
.quantity-boxxx {
	width: 175px;
	text-align: center;
}
.one-boxx {
	width: 362px
}
.one-boxu {
	width: 50px;
	text-align: center;
}
.ten-boxq {
	width: 50px;
}
.butsave {
	cursor: pointer;
}
/* mouse over link */
.changeColor {
	
}
a:hover {
	color: #800000;
}
</style>
 

<script type="text/javascript">
	$(document).ready(function() {
		chosenDropDown();

	});
	$(function() {
		$("#dateId").datepicker({
			changeDate : true,
			changeMonth : true,
			changeYear : true,
			showButtonPanel : false,
			dateFormat : 'yy-mm-dd'
		});

	});
	$(function() {
		$("#bookedDateId").datepicker({
			changeDate : true,
			changeMonth : true,
			changeYear : true,
			showButtonPanel : false,
			dateFormat : 'yy-mm-dd'
		});

	});
	$(document).ready(function(){
		//$("#vendorId").hide();//for hide
		//$("#statusId").hide();//for hide
		var listOrders1 =${allOrders1};
		if(listOrders1 != ""){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			displayTable(listOrders1);
			
			 /*  $.each(listOrders1, function(i, orderObj) {
				  if(i==1){
					  resetStatus(orderObj.serviceId);
					  resetVendor(orderObj.serviceId); 
				  }
			});  */
		} 
		//paginationTable(8);
	});
	function displayTable(listOrders){
		//var vendorDropDown = $("#vendorId").html();
		//var statusDrop= $("#statusId").html();
		//var timeSlotDrop = $("#timeSlotId").html();
		
		if (listOrders != null){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			$("#noOrdrs").text("# " + listOrders.length);
			$.each(listOrders, function(i, orderObj) {
				var id='"'+orderObj.orderId+'"';
				if(orderObj.totalPrice == null){
					orderObj.totalPrice =0;
				}
				
				if(orderObj.clientlog == null){
					orderObj.clientlog ="";
				}
				if(orderObj.aurolog == "null" || orderObj.aurolog == null){
					orderObj.aurolog ="";
				}
				
				
				
				var tblRow = "<ul>"
					+"<input type='hidden' id='appDate"+i+"' value='"+orderObj.appointmentDate+"'/>"
						+ "<li class='two-boxxx'><a  id='"+orderObj.orderId+"' href='javascript:forOrderDetails("+id+")' style='font-color:red'>"+orderObj.orderId+"</a></li>"
						+ "<li class='two-boxxx'>"+orderObj.locationName+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'service"+" title='"+orderObj.serviceName+"'>"+orderObj.serviceName+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'date"+" title='"+orderObj.bookedDate+"'>"+orderObj.bookedDate+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'apdate"+" title='"+orderObj.appointmentDate+"'>"+orderObj.appointmentDate+"</li>"
						+"<li class='two-boxxx'  title='"+orderObj.slotLabel+"'>"+orderObj.slotLabel+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'phoneNo"+" title='"+orderObj.contactNo+"'>"+orderObj.contactNo+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'email"+" title='"+orderObj.contactEmail+"' >"+orderObj.contactEmail+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"statusid'"+">"+orderObj.statusName+"</li>"
						+"<input type='hidden' id='"+orderObj.orderId+"gid' value='"+orderObj.gid+"' >"
						+"<input type='hidden' id='"+orderObj.orderId+"userId' value='"+orderObj.userId+"' >"
						+"<li class='two-boxxx' style='width:250px;'><textarea id='"+orderObj.orderId+"clientcomment'  name='comment' style='width:250px;'>"+orderObj.clientlog+"</textarea> </li>"
						+"<li class='two-boxxx' style='width:250px;'><textarea id='"+orderObj.orderId+"aurocomment' disabled name='comment' style='width:250px;'>"+orderObj.aurolog+"</textarea> </li>"
						+"<li class='ten-boxxx last' >"+"<input type='button' id='"+orderObj.orderId+"' value='Update' onclick='formSubmit(this.id)' ></li>"
						+ '</ul>';
				$(tblRow).appendTo("#itemContainer");
			});
			paginationTable(18);
		}else{
			//alert('no data to display..');
		}
	}
	
	function formSubmit(id){
		var orderid= id;
		var gid = $("#"+orderid+"gid").val();
		var clientComments = $("#"+orderid+"clientcomment").val();
		var userId = $("#"+orderid+"userId").val();
		 $.blockUI({
				message : 'Please Wait',
				css : {
					left : '25%',
				}
			}); 
		$.ajax({
			type : "POST",
			url : "clientcommentUpdate.json",
			data : {
				orderid : orderid,
				clientComments : clientComments,
				gid : gid,
				userId:userId,
		
			},
			success : function(response) {
				 $.unblockUI();
				displayTable(response);
			
			}
		});
		
		
	}
	
	
	
	
	
	
	
	var selectedArray = [];
	var totalPrice = 0;
	var tempTotalPrice = 0;
	var totalDiscount = 0;
	var tempTotalDiscount = 0;
	var tempTotalNetAmout = 0;
	var totalNetAmount = 0;
	var discount = 0;
	var totlAmount = 0.0;

	function addPack() {
		$('#descriptionId').val('');
		$('#nameId').val('');
		$('#priceId').val('');
		$('#discountId').val('');
		$('#labelId').val('');
		$('#packId').val('0');
	}

	function selectClick(id) {
		$("#t" + id).css({
			"background-color" : "red"
		});
		$('#descriptionId').val(serviceUnitArray[id].description);
		$('#nameId').val(serviceUnitArray[id].name);
		$('#priceId').val(serviceUnitArray[id].price);
		$('#discountId').val(serviceUnitArray[id].discount);
		$('#labelId').val(serviceUnitArray[id].label);
		$('#packId').val(id);

		var item = {};
		item["unitId"] = id;
		/* item ["vendorName"] = vendorName; */
		item["name"] = serviceUnitArray[id].name;
		/*  item ["vendorId"] = vendorId; */
		item["description"] = serviceUnitArray[id].description;
		item["price"] = serviceUnitArray[id].price;
		item["discount"] = serviceUnitArray[id].discount;
		totlAmount = (parseInt(serviceUnitArray[id].price))
				- (parseInt(serviceUnitArray[id].price))
				* ((parseInt(serviceUnitArray[id].discount) / 100));
		item["netAmount"] = totlAmount;

		tempTotalPrice = tempTotalPrice + parseFloat(item.price);
		totalPrice = tempTotalPrice;
		//alert(tempTotalPrice);
		tempTotalNetAmout = tempTotalNetAmout + item.netAmount

		discount = tempTotalPrice - tempTotalNetAmout;
		tempTotalDiscount = ((100 * discount)) / tempTotalPrice;

		totalPrice = tempTotalPrice;
		totalDiscount = tempTotalDiscount;
		totalNetAmount = tempTotalNetAmout;
		alert("Total price: " + totalPrice);
		item["totalPrice"] = totalPrice;
		selectedArray.push(item)
	}

	function submitForm() {
		var contactNumber = $('#phoneNumId').val();
		var contactAddress = $('#addressId').val();
		var emailId = $('#emailId').val();
		var serviceId = $('#serviceId').val();
		var locationId = 24;
		var userId1 = $("#userId1").val();
		//alert(contactNumber);
		//var vendorId = $('#vendorId').val();
		//alert(vendorId);
		/* alert( $('#packId').val()); */
		var dateId = $('#dateId').val();
		var bookedDateId =$("#bookedDateId").val()
		var timeId = $('#timeId').val();
		var clientOrderId = $('#clientId').val();
		var cname = $('#cname').val();
		var sdiscription = $('#sdiscription').val();
		var priorityId =$('#priorityId').val();
		var wlocationId =$('#wlocationId').val();
		var json = JSON.stringify(selectedArray);
		//alert(totalNetAmount);
		var couponcodeId = $('#couponcodeId').val(); 
		var admin = true;
		
			
		 												    
					if(userId1.length == 0 || contactNumber.length == 0 || contactAddress.length == 0 || serviceId.length == 0 || emailId.length == 0 || dateId.length == 0 || timeId.length == 0 || clientOrderId.length == 0 || cname.length == 0 || sdiscription.length == 0){												   
						if(userId1.length == 0 ) {
					    	$('#userId1').css('color','red');
							$("#userId1_chosen").find('.chosen-single').css("border","1px solid red");
							$("#userId1").css("border-color","red");
							$('#userId1').addClass('your-class');
						    }
						if(contactNumber.length == 0 ) {
					    $('#phoneNumId').css('color','red');
					    $("#phoneNumId").css("border-color","red");
					    $("#phoneNumId").attr("placeholder","Please enter contact number");
					    $('#phoneNumId').addClass('your-class');
					    }
				    if(contactAddress.length == 0 ) {
					    $('#addressId').css('color','red');
					    $("#addressId").css("border-color","red");
					    $("#addressId").attr("placeholder","Please enter address");
					    $('#addressId').addClass('your-class');
					    }	
				    if(serviceId.length == 0 ) {
				    	$('#serviceId').css('color','red');
						$("#serviceId_chosen").find('.chosen-single').css("border","1px solid red");
						$("#serviceId").css("border-color","red");
						$('#serviceId').addClass('your-class');
					    }
				    if(emailId.length == 0 ) {
					    $('#emailId').css('color','red');
					    $("#emailId").css("border-color","red");
					    $("#emailId").attr("placeholder","Please enter email");
					    $('#emailId').addClass('your-class');
					    }	
				    if(dateId.length == 0 ) {
					    $('#dateId').css('color','red');
					    $("#dateId").css("border-color","red");
					    $("#dateId").attr("placeholder","Please enter date");
					    $('#dateId').addClass('your-class');
					    }
				    if(timeId.length == 0 ) {
				    	$('#timeId').css('color','red');
						$("#timeId_chosen").find('.chosen-single').css("border","1px solid red");
						$("#timeId").css("border-color","red");
						$('#timeId').addClass('your-class');
					    }	
				    if(clientOrderId.length == 0 ) {
					    $('#clientId').css('color','red');
					    $("#clientId").css("border-color","red");
					    $("#clientId").attr("placeholder","Please enter Client orderID");
					    $('#clientId').addClass('your-class');
					    }
				    if(cname.length == 0 ) {
					    $('#cname').css('color','red');
					    $("#cname").css("border-color","red");
					    $("#cname").attr("placeholder","Please enter Customer name");
					    $('#cname').addClass('your-class');
					    }	
				    if(sdiscription.length == 0 ) {
					    $('#sdiscription').css('color','red');
					    $("#sdiscription").css("border-color","red");
					    $("#sdiscription").attr("placeholder","Please enter Description");
					    $('#sdiscription').addClass('your-class');
					    }	
	 				    return false;												  
					    } 
				/* 	  
				  $('#addForm').attr('action',"<c:url value='/statusAdd.htm'/>");
				$("#addForm").submit();											
<<<<<<< HEAD
				event.preventDefault(); */



		 $.blockUI({
			message : 'Please Wait',
			css : {
				left : '25%',
			}
		});  
		$.ajax({
			type : "POST",
			url : "bookPackages.htm",
			data : {
				selectedTests : json,
				dateId : dateId,
				contactNumber : contactNumber,
				contactAddress : contactAddress,
				totalPrice : totalPrice,
				timeId : timeId,
				emailId : emailId,
				serviceId : serviceId,
				locationId : locationId,
				totalNetAmount : totalNetAmount,
				totalDiscount : totalDiscount,
				couponcodeId : couponcodeId,
				admin : admin,
				clientOrderId:clientOrderId,
				cname:cname,
				sdiscription:sdiscription,
				priorityId:priorityId,
				wlocationId:wlocationId,
				userId1:userId1,
				bookedDateId:bookedDateId,
			},
			success : function(response) {
				$.unblockUI();
				alert(response);					
					 location.reload();
					//paginationTable(8);
				if (response != "" && response == "success") {

				} else {
				}
			},
			error : function(e) {
			}
		});
	}

	function packageFilter(id) {
		var serviceId = $("#" + id).val();
		var vendorId = $("#vendorId").val();
		if (vendorId == "" && vendorId == null) {
			return false;
		}
		$.ajax({
			type : "POST",
			url : "searchPackage1.htm",
			data : "vendorId=" + vendorId + "&serviceId=" + serviceId,
			dataType : "json",
			success : function(response) {
				console.log(response);
				if (response == "") {
					selectedArray = [];
					$("#userdata ul").remove();
					$("#userdata ul li").remove();
					$('#noSortData').show();
					$('#legend2').hide();
					$('.holder').hide();
				} else {
					serviceUnitArray = {};
					$('#noSortData').hide();
					$('#legend2').show();
					$('.holder').show();
					showData(response);
				}
				;

			}
		});
	}

	function showData(response) {
		$("#userdata ul").remove();
		$("#userdata ul li").remove();
		$.each(response, function(i, catObj) {

			serviceUnitArray[catObj.id] = catObj;

			var tblRow = "<ul id ='t"+catObj.id+"'>" + "<li class='nine-box'>"
					+ catObj.name + "</li>" + "<li class='zero-box12'>"
					+ catObj.description + "</li>" + "<li class='two-box'>"
					+ catObj.price + "</li>" + "<li class='two-box'>"
					+ catObj.discount + "</li>" + "<li class='ten-box last'>"
					+ '<a href="javascript:void(0)" onclick=selectClick('
					+ catObj.id + ')' + ' class="" >Select</a>' + '</li>'
					/* + "<li class=' last'>"
					+ "<a href='javascript:void(0)' id='"
					+ catObj.id
					+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
					+ '</li>' */
					+ '</ul>';
			$(tblRow).appendTo("#itemContainer");

		});
		paginationTable(10);
	}

	function serviceFilter(id) {
		var vendorId = $("#" + id).val();
		$.ajax({
			type : "POST",
			url : "getServicesForVendors.json",
			data : "vendorId=" + vendorId,
			dataType : "json",
			success : function(response) {
				var optionsForClass = "";
				optionsForClass = $("#serviceId").empty();
				optionsForClass.append(new Option("--Select--", ""));
				$.each(response, function(i, tests) {
					id = tests.serviceId;
					var name = tests.serviceName;
					optionsForClass.append(new Option(name, id));
				});
				$("#serviceId").trigger("chosen:updated");
			},
			error : function(e) {
			},
			statusCode : {
				406 : function() {

				}
			}
		});
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						document.getElementById("dupMessage").style.display = "none";

						$('#submitId')
								.click(
										function(e) {
											$('#addForm')
													.attr('action',
															"<c:url value='/packageAdd.htm'/>");
											$("#addForm").submit();
											event.preventDefault();
											document
													.getElementById("dupMessage").style.display = "none";
										});
						$('#updateId')
								.click(
										function(e) {
											$('#editForm')
													.attr('action',
															"<c:url value='/packageUpdate.htm'/>");
											$("#editForm").submit();
											event.preventDefault();
										});
					});
</script>


</head>
<body>

	<div class="wrapper">
		<div class="container">
			<div class="main_content">
				<c:if test="${empty servEdit}">
					<div class="block">
						<h2>
							<span class="icon1">&nbsp;</span> <a href='javascript:void(0)'
								onclick='addPack()'> Order Booking</a>
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
						<form:form action="" commandName="packCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div>
							<div style="background-color: #eee;padding: 29px 0 0px 21px;margin-top: 17px;font-size: 13px;font-family: open_sansregular;">
									<label>Coupon Code</span></label> &nbsp;&nbsp;&nbsp;<input id="couponcodeId"
										maxlength="30" 
										onkeydown="removeBorder(this.id)" tabindex="7" style="margin-left: 24px;width: 211px;height: 18px;"/>
								</div>
								</div>
							<div class="block-box-small package-topbox block-box-top-header-dept" style= "height: 165px !important" >
								<div class="block-input">
									<label>Partner <span style="color: red;">*</span></label>
									<%-- <c:out value="${sessionScope.cacheUserBean.userName }"></c:out> --%>
									<%-- <c:choose>
												
													<c:when test="${not empty sessionScope.cacheUserBean.userName}">
													<form:select path="userId"  
												  cssClass="some-select" 
												 tabindex="1">
														<c:set var="admin" scope="session" value="${sessionScope.cacheUserBean.userName }" />
														<form:options items="${users}"></form:options>
														</form:select>
													</c:when>

													<c:otherwise>
													<form:select path="userId"  
												  cssClass="some-select" disabled="true"
												 tabindex="1">
														<form:option value="">--Select--</form:option>
														<form:options items="${users}"></form:options>
														</form:select>
													</c:otherwise>
												</c:choose> --%>
									<c:choose>
										<c:when
											test="${sessionScope.cacheUserBean.userName  eq  'admin' }">
											<form:select path="userId" id="userId1" cssClass="some-select"
												tabindex="1">
												<c:choose>
													<c:when
														test="${not empty sessionScope.cacheUserBean.userId}">
														<c:set var="cId" scope="session"
															value="${sessionScope.cacheUserBean.userId }" />
														<form:option value="">--Select--</form:option>
														<form:options items="${users}"></form:options>
													</c:when>

													<c:otherwise>
														<form:option value="">--Select--</form:option>
														<form:options items="${users}"></form:options>
													</c:otherwise>
												</c:choose>
											</form:select>
										</c:when>
										<c:otherwise>
											<form:select path="userId" id ="userId1" disabled="true"
												cssClass="some-select" onfocus="removeBorder(this.id)">
												<c:choose>
													<c:when
														test="${not empty sessionScope.cacheUserBean.userId}">
														<c:set var="cId" scope="session"
															value="${sessionScope.cacheUserBean.userId }" />
														<form:options items="${users}"></form:options>
													</c:when>
													<c:otherwise>
														<form:options items="${users}"></form:options>
													</c:otherwise>
												</c:choose>
											</form:select>
										</c:otherwise>
									</c:choose>
								</div>

								<%-- <div class="block-input">
									<label>Vendor Name<span style="color: red;">*</span></label>
									<form:select path="vendorName" cssClass="some-select"
										id="vendorId" tabindex="1" onchange="serviceFilter(this.id);">
										<form:option value="">--Select--</form:option>
										<form:options items="${vendors1}"></form:options>
									</form:select>
								</div> --%>
								
								<div class="block-input ">
									<label>Service Name<span style="color: red;">*</span></label>
									<form:select path="serviceName" id='serviceId' cssClass="some-select" tabindex="2" onchange="selectOrders();">
										<form:option value="">--Select--</form:option>
										<form:options items="${services}"></form:options>
									</form:select>
								</div>
								<div class="block-input last">
											<label>Client order ID<span	style="color: red;">*</span></label>
											<input  id="clientId"  
												 onkeydown="removeBorder(this.id)"  tabindex="5"/>
										</div>	
										<div class="block-input ">
											<label>Customer Name<span	style="color: red;">*</span></label>
											<input  id="cname"  
												 onkeydown="removeBorder(this.id)"  tabindex="5"/>
										</div>
								<div class="block-input">
									<label>Phone Number <span style="color: red;">*</span></label>
									<input id="phoneNumId"
										onkeydown="removeBorder(this.id)" tabindex="3" />
								</div>
								
								<div class="block-input last">
									<label>Address<span style="color: red;">*</span></label> <input
										id="addressId" onkeydown="removeBorder(this.id)" tabindex="5" />
								</div>
								<div class="block-input">
									<label>Schedule Date<span style="color: red;">*</span></label> 
									<input  id="dateId"  
												 onkeydown="removeBorder(this.id)"  tabindex="5"/>
										
								</div>

								<div class="block-input">
									<label>Time slot<span style="color: red;">*</span></label> 
									<select	id="timeId" class="some-select">
										<option value="">--Select--</option>
										<option value="1">Morning</option>
										<option value="2">Afternoon</option>
										<option value="3">Evening</option>
									</select>
								</div>
								<!-- <div class="block-input last">
											<label>Service Description<span	style="color: red;">*</span></label>
											<input  id="sdiscription"  onkeydown="removeBorder(this.id)"  tabindex="5"/>
										</div> -->
								<div class="block-input">
									<label>Email Id<span style="color: red;">*</span></label> <input
										id="emailId" 
										onkeydown="removeBorder(this.id)" tabindex="4" />
								</div>
								
										
								<div class="block-input">
									<label>Booked Date<span style="color: red;">*</span></label> 
									<input  id="bookedDateId" onkeydown="removeBorder(this.id)"  tabindex="5"/>
                               </div>
                               
                               <!-- <div class="block-input last">
								<label>WhatsApp Location</label> 
									<input  id="wlocationId"  onkeydown="removeBorder(this.id)"  tabindex="5"/>
                               </div> -->
							</div>
							<div class="block-footer">
								<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: none;">
										<div class="alert-success">
											<spring:message code="label.success" />
											Package
											<spring:message code="label.saveSuccess" />
										</div>
									</div>
									<div id="addfail" style="display: block;">
										<c:forEach var="fail" items="${param.AddFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" />
												Package
												<spring:message code="label.saveFail" />
											</aside>

										</c:forEach>
									</div>
									<div id="upsus" style="display: none;">

										<div class="alert-success">
											<spring:message code="label.success" />
											Package
											<spring:message code="label.updateSuccess" />
										</div>

									</div>
									<div id="upfail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">
											<aside class="block-footer-left fail">
												<spring:message code="label.error" />
												Service
												<spring:message code="label.updateFail" />
											</aside>
										</c:forEach>
									</div>
									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Package
											<spring:message code="label.deleteSuccess" />
										</aside>
									</div>
									<div id="deleteMsgFail" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.deleteFail" />
											Package
											<spring:message code="label.deleteFail" />
										</aside>
									</div>
									<div class="alert-danger " id="dupMessage"
										style="display: none;">
										<aside class="block-footer-left fail">Warning :
											Package already Exists. Please try Some Other</aside>


									</div>

								</aside>
								<aside class="block-footer-right">
									<input type="button" class="btn-cancel"
										value="<spring:message code="label.clear" />" id="cancelId"
										tabindex="4" onclick="dataClear();" />
									<!-- input type="submit" class="btn-save"
										value="<spring:message code="label.save"/>" id="submitId0" tabindex="3"/ -->
									<input type="button" class="btn-cancel"
										value="<spring:message code="label.save"/>" id="submitId0"
										onclick="submitForm()" tabindex="3" />
								</aside>
							</div>

						</form:form>
				</c:if>


			</div>

			<!--Edit Box End  -->
			<div class="block" style="margin-top:10px;">
						<div class="head-box">
							<h2>
								<span class="icon2">&nbsp;</span>Admin Order Details
							</h2>
							<div  id="dupMessage" style="color: red;"></div>
							<div  id="upsus" style="color: green;"></div>
						</div>
						<div
							class="block-box-deptpurchaser purchases-downbox block-box-last-deptpurchaser"
							id="divheader">
							<div class="table-list-blk purchase-tablelist paginationParentDiv"
								id="userdata" style="overflow-x: scroll;overflow-y: hidden; ">
							<ul class="table-list" style="width:150%;   font-weight: 600;">
								<li class="two-boxxx">Order No</li>
								<li class="two-boxxx">Location</li>
								<li class="two-boxxx">Service</li>
								<li class="two-boxxx">Booked Date</li>
								<li class="two-boxxx">Schedule Date</li>
								<li class="two-boxxx">Schedule Time</li>
								<li class="two-boxxx">Contact No</li>
								<li class="two-boxxx">Contact Email</li>
								<li class="two-boxxx">Status</li>
								<li class="two-boxxx" style="width:250px;">Client comments</li>
								<li class="two-boxxx" style="width:250px;">Auro comments</li>
								<li class="two-box last">Update</li>
							</ul>
								<div id="itemContainer" style="width: 150%">
								</div>
							</div>
							<div align="center">
								<h4 id="noSortData" style="display: none">No Data Found</h4>
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
							<aside></aside>
						</div>
					</div>
							</div>
		<!-- End Content -->
	</div>
</body>
<script type="text/javascript">
function selectOrders(){
	 $.blockUI({ message: 'Please Wait' });
	 var serviceId = $("#serviceId").val();
	
	
	
	$("#itemContainer ul").remove();
	$("#itemContainer ul li").remove(); 
	$("#vendorId").hide();//for hide
	$("#statusId").show();//for hide
	 $.ajax({
			type : "POST",
			url : "getServiceOrders.json",
			data : "serviceId=" + serviceId,
			dataType : "json", 
			success : function(response) {
				/* alert(response); */
				$.unblockUI(); 
				if(response != ""){
					$("#itemContainer ul li").remove();
					$("#itemContainer ul").remove();
					displayTable(response);
				}
			},
			error : function(e) {
			}
		});
}
</script>

</html>
