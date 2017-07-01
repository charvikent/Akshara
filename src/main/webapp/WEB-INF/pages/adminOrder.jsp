<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Orders</title>
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
		/* chosenDropDown();   */
		
		$("#emailId").val("");
		$("#phoneNumId").val("");
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
		<!-- SET: CONTAINER -->
		<div class="container">
			<div class="main_content">
			
			 <div class="block">
						<h2>
							<span class="icon1">&nbsp;</span>
							<span>Admin Order</span>
							
						</h2>
						<!-- End Box Head -->
						<form:form action="" commandName="adminCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small categery-topbox block-box-top-header-dept">
								
								<div class="block-input">
											<label>Service<!-- <span
												style="color: red;">*</span> --></label>
											 <form:select path="serviceId"  cssClass="some-select" tabindex="1" onchange="selectOrders();">
											<form:option value="">--Select--</form:option>
											<form:options items="${services}"></form:options>
											</form:select>	</div>
											
											
											 <div class="block-input"> 
											<label>Phone Number </label>
											<form:input path="contactNo" id="phoneNumId" onkeyup="searchPhoneNumber();"/>
											</div> 
											<div class="block-input last"> 
											<label>Email </label>
											<form:input path="contactEmail" id="emailId" onblur="searchEmail();"/>
											</div>
												<form:select path="vendorId"   cssClass="some-select" tabindex="1" onchange="selectOrders();">
											<form:option value="">--Select--</form:option>
											<form:options items="${vendors}"></form:options>
											</form:select>	
											<form:select path="assign" 	cssClass="some-select" tabindex="1"	id="statusId">
															<form:option value="">--Select--</form:option>
															<form:options items="${status}"></form:options>
											</form:select>				
								<%-- <form:errors path="categoryDesc" /> --%>
							</div>
							<div class="block-footer">
							</div>
						</form:form>
					</div> 
			
				<form:form action="" commandName="adminCmd" method="post"
					id="editForm" cssClass="form-horizontal">

					<div class="block">
						<div class="head-box">
							<h2>
								<span class="icon2">&nbsp;</span>Admin Order Details
							</h2>
						</div>
						<div
							class="block-box-deptpurchaser purchase-downbox block-box-last-deptpurchaser"
							id="divheader">
							<ul class="table-list">
								<li class="two-boxxx">Order No
									<ul>
										<li><a class="top" href="#">&nbsp;</a></li>
										<li><a class="bottom" href="#">&nbsp;</a></li>
									</ul>
								</li>
								<li class="two-boxxx">Booked Date
									<ul>
										<li><a class="top" href="#">&nbsp;</a></li>
										<li><a class="bottom" href="#">&nbsp;</a></li>
									</ul>
								</li>
								<li class="two-boxxx">Contact No
									<ul>
									</ul>
								</li>
								<li class="two-boxxx">Contact Email
									<ul>
									</ul>
								</li>
								<li class="two-boxxx">NetAmount
									<ul>
									</ul>
								</li>
									<li class="two-boxxx">Status
									<ul>
									</ul>
								</li>
								<li class="two-boxxx">Vendor
									<ul>
									</ul>
								</li>
								<li class="two-boxxx">Change Status
									<ul>
									</ul>
								</li>
								<li class="two-boxxx last">Update Status
									<ul>
									</ul>
								</li>

							</ul>
							<div class="table-list-blk purchase-tablelis paginationParentDiv"
								id="userdata">
								<div id="itemContainer">

									<%-- <c:choose>
										<c:when test="${not empty OrderList }">
											<c:forEach var="orderList" items="${OrderList }">
												<ul>
													<li class="two-boxxx"><a href='javascript:void(0)'
														id='${orderList.orderId }'
														onclick='forStockDetails(this.id)'
														class='ico del colorbox'><c:out
																value="${fn:substring(orderList.orderId, 0, 8)}"></c:out></a></li>
													<li class="two-boxxx" id="${orderList.orderId }date"><c:out
															value="${orderList.bookedDate }" /></li>
													<li class='two-boxxx' id="${orderList.orderId }contactno"><c:out
															value="${orderList.contactNo }"></c:out></li>
													<li class='two-boxxx' id="${orderList.orderId }email"><c:out
															value="${orderList.contactEmail }"></c:out></li>
													<li class='two-boxxx' id="${orderList.orderId }status"><c:out
															value="${orderList.statusName }"></c:out></li>
															<li class='two-boxxx' id="${orderList.orderId }netAmt"><c:out
															value="${orderList.netAmount }"></c:out></li>
													<li class='two-boxxx'><form:select path="vendorId"
															cssClass="some-select" tabindex="1"
															id="${orderList.orderId }vendor">
															<form:option value="">--Select--</form:option>
															<form:options items="${vendors}"></form:options>
														</form:select></li>
													<li class='two-boxxx last'><a href="orderAssign.htm?orderId='<c:out value="${orderList.orderId }"/>'&vendorId=''">Assign</a></li>
													<li class='two-boxxx last'><a id="${orderList.orderId }" onclick="formSubmit(this.id)">Assign</a></li>
													<form:hidden path="orderId" value="${orderList.orderId }"
														id="hiddenId" />
													<li class='two-boxxx'><form:select path="assign"
															cssClass="some-select" tabindex="1"	id="${orderList.orderId }assign">
															<form:option value="">--Select--</form:option>
															<form:options items="${status}"></form:options>
														</form:select></li>
														<li class='ten-box last'><input type="button" id="${orderList.orderId }" value="Assign" onclick="formSubmit(this.id);"></li>
												</ul>
											</c:forEach>
										</c:when>
									</c:choose> --%>

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
				</form:form>


			</div>

		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		$("#vendorId").hide();//for hide
		$("#statusId").hide();//for hide
		var vendorDropDown = $("#vendorId").html();
		var statusDrop= $("#statusId").html();
		var listOrders =${orderListJson};
		if(listOrders != ""){
			$.each(listOrders, function(i, orderObj) {
				//var orderid = orderObj.orderId.substr(0,6);
				var tblRow = "<ul>"
						+ "<li class='two-boxxx'>"	+ orderObj.orderId.substr(0,6)+ "</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'date"+">"+orderObj.bookedDate+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'phone"+">"+orderObj.contactNo+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'email"+">"+orderObj.contactEmail+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'netAmount"+">"+orderObj.netAmount+"</li>"
						+"<li class='two-boxxx' id='"+orderObj.orderId+"'status"+">"+orderObj.statusName+"</li>"
						+"<li class='two-boxxx' >"+"<select name='vendorId' id='"+orderObj.orderId+"vendorId'"+" value= >'"+vendorDropDown+"'</select>"+"</li>"
						+"<li class='two-boxxx' >"+"<select name='statusId' id='"+orderObj.orderId+"status'"+"  value= >'"+statusDrop+"'</select>"+"</li>"
						+"<li class='ten-boxxx last' >"+"<input type='button' id='"+orderObj.orderId+"' value='update' onclick='formSubmit(this.id)' ></li>"
						+ '</ul>';
				$(tblRow).appendTo("#itemContainer");
				
			});
		}else{
		
		};
		paginationTable(10);
	});
	
	 function selectOrders(){
		 var serviceId = $("#serviceId").val();
		 // alert(serviceId); 
		$("#userdata ul").remove();
		$("#userdata ul li").remove();
		$("#vendorId").hide();//for hide
		$("#statusId").hide();//for hide
		var vendorDropDown = $("#vendorId").html();
		var statusDrop= $("#statusId").html();
		 $.ajax({
				type : "POST",
				url : "getServiceOrders.json",
				data : "serviceId=" + serviceId,
				dataType : "json", 
				success : function(response) {
					if(response != ""){
						$.each(response, function(i, orderObj) {
										
							var tblRow = "<ul>"
									+ "<li class='two-boxxx'>"	+ orderObj.orderId.substr(0,6)+ "</li>"
									+"<li class='two-boxxx' id='"+orderObj.orderId+"'date"+">"+orderObj.bookedDate+"</li>"
									+"<li class='two-boxxx' id='"+orderObj.orderId+"'phone"+">"+orderObj.contactNo+"</li>"
									+"<li class='two-boxxx' id='"+orderObj.orderId+"'email"+">"+orderObj.contactEmail+"</li>"
									+"<li class='two-boxxx' id='"+orderObj.orderId+"'netAmount"+">"+orderObj.netAmount+"</li>"
									+"<li class='two-boxxx' id='"+orderObj.orderId+"'status"+">"+orderObj.statusName+"</li>"
									+"<li class='two-boxxx' id='"+orderObj.orderId+"'vendorId"+">"+"<select name='vendorId'  value= >'"+vendorDropDown+"'</select>"+"</li>"
									+"<li class='two-boxxx' id='"+orderObj.orderId+"'status"+">"+"<select name='statusId' id='status"+i+"' value= >'"+statusDrop+"'</select>"+"</li>"
									+"<li class='ten-boxxx last'>"+"<input type='button' id='"+orderObj.orderId+"' value='update' onclick='formSubmit(this.id)' ></li>"
									+ '</ul>';
							$(tblRow).appendTo("#itemContainer");
						});
					}
					resetStatus(serviceId);	
					paginationTable(10);
				},
				error : function(e) {
				}
			});
	 }

	 function formSubmit(id) {
			 var orderId=id;
			var vendorId = $("#" + id + "vendorId").val();
		 	var statusId= $("#" + id + "status").val();
			alert(vendorId+statusId);
		$.ajax({
			type : "GET",
			url : "assignToAdmin.htm",
			data : "vendorId=" + vendorId + "&orderId=" + orderId + "&statusId="+ statusId,
			/* dataType : "json", */
			success : function(response) {
				alert(response);
				if (response == "Success") {

				} else {
				}
			},
			error : function(e) {
			}
		});
	}
	
	 function resetStatus(id){
		 var serviceid = $("#" + id).val();
		 
			$.ajax({
				type : "POST",
				url : "forStatus.json",
				data : "serviceId=" + id,
				dataType : "json",
				success : function(response) {
					
					var optionsForClass = "";
					//optionsForClass = $("#orderStatusId").empty();
					alert(response);
					
				for(var i=0;i<$('[name="statusId"]').length;i++){
					optionsForClass = $("#status"+i).empty();
					optionsForClass.append(new Option("--Select--", ""));
					$.each(response, function(i, tests) {
						alert(tests.name);
						optionsForClass.append(new Option(tests.name,tests.id));
					});
				}
				},
				error : function(e) {
				},
				statusCode : {
					406 : function() {
						jAlert('page not found', 'Alert Box');
					}
				}
			});
		}
	function searchPhoneNumber(){
		var phoneNumberId = $("#phoneNumId").val();
		var phoneNumberLength = $("#phoneNumId").val().length;
		if(phoneNumberLength == 10)
			{
			 $('#addForm').attr('action',"<c:url value='/phoneNumSearch.htm'/>");
				$("#addForm").submit();											
				event.preventDefault();
			}
	}
	function searchEmail(){
		 var val=$('#emailId').val();
		 var regex=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    if((regex.test(val))){
	    	//alert((regex.test(val)));
	    	$('#emailId').css('color','red');
		    $("#emailId").css("border-color","red");
		    
		    $('#addForm').attr('action',"<c:url value='/emailSearch.htm'/>");
			$("#addForm").submit();											
			event.preventDefault();
	    	return false;
	    	}
	}
	</script>
</body>
</html>
