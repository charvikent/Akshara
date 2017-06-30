<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="js/js/csvDownload1.js"></script>
<script type="text/javascript" src="js/jquery.multiselect.js"></script>
<link href="css/jquery.multiselect1.css" rel="stylesheet"/>
<title>Orders</title>
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
/* input {
    text-align:right;
} */
</style>
<script type="text/javascript">
	$(document).ready(function() {
		chosenDropDown(); 
		
		$("#emailId").val("");
		$("#phoneNumId").val("");
		$("#vendorstatus").hide();
		$("#statusId").hide();
		var statusNames;
		$("#timeslotDate").hide();
		
		$('#serviceId').multiselect({
		    placeholder: 'Select Services',
		    search: true,
		    selectAll: true,
		});
	});
	$(document).ready(function(){
		//$("#vendorId").hide();//for hide
		//$("#statusId").hide();//for hide
		var listOrders1 =${allOrders1};
		if(listOrders1 != ""){
			/* $("#itemContainer ul li").remove();
			$("#itemContainer ul").remove(); */
			displayTable(listOrders1);
			var vendorstatus = $("#vendorstatus").val();
		} 
		//paginationTable(8);
	});
</script>
<script type="text/javascript" src="Branding/js/alladminOrders5.js">
<!--

//-->
</script>
</head>
<body>
	<div class="wrapper">
		<!-- SET: CONTAINER -->
		<div class="container">
			<div class="main_content">
			 <table> <tr><td>
			 <div class="block" style="  width: 375px;">
						<h2 style="width: 355px;">
							<span class="icon1">&nbsp;</span>
							<span>Admin Order</span>
						</h2>
						<!-- End Box Head -->
						<form:form action="" commandName="adminCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small orders-topbox block-box-top-header-dept" style="width: 346px;padding: 10px 15px;  height: 451px !important;  overflow-y: scroll;">
								<div class="block-input" style="  margin: 1px 54px 10px 0;   ">
											<label>Service</label>
											 <form:select path="serviceId" style="height:0px;"   multiple="multiple" tabindex="1" >
											<%-- <form:option value="">--Select--</form:option> --%>
											<form:options items="${services}"></form:options>
											</form:select>	</div>
											<div class="block-input">
											<label>Status</label>
											 <form:select path="statusId" style="height:0px;" id="status"  cssClass="some-select" multiple="multiple" onchange="selectOrders();" tabindex="2">
											<form:options items="${status}"></form:options>
											</form:select>	</div>
											 <div class="block-input last"> 
											<label>Phone Number </label>
											<form:input path="contactNo" id="phoneNumId"  maxlength="13" tabindex="3"/>
											</div> 
											<div class="block-input last"> 
											<label>Email </label>
											<form:input path="contactEmail" id="emailId" tabindex="4" />
											</div>
										<div class="block-input last"> 
											<label>Auro OrderId </label>
											<form:input path="orderId" id="searchOrderId" tabindex="5" />
											</div>
											<div class="block-input last"> 
											<label>Client OrderId </label>
											<form:input path="orderId" id="clientId" tabindex="6" />
											</div>
										<div class="block-input last"> 
											<label>Partner </label>
											<form:select path="userId" id="userId" cssClass="some-select"
												 onchange="selectOrders();"  multiple="multiple" tabindex="7">
											<form:option value="">--Select--</form:option>
											<form:options items="${users}"></form:options>	
												
												</form:select>
											</div>
											<div class="block-input last"> 
											<label>Start Date </label>
											<form:input path="bookedDate" id="startDate" tabindex="8" />
											</div>
											<div class="block-input last"> 
											<label>End Date </label>
											<form:input path="bookedDate" id="endDate" tabindex="9" />
											</div>
											 <div class="block-input">
											<label>Vendor Name</label>
											 <form:select path="vendorId" id="vendorId"  cssClass="some-select" tabindex="10">
											 <form:option value="">--Select--</form:option>
											<form:options items="${vendornames}"></form:options>
											</form:select>	</div> 
											<div class="block-input">
											<label>Vendor Status</label>
											 <form:select path="vendorstatus" id="vendorstatus"  cssClass="some-select" tabindex="11">
											 <form:option value="">--Select--</form:option>
											<form:options items="${venstatus}"></form:options>
											</form:select>	</div> 
											<div style="display: none;">
											<%-- <form:select path="vendorstatus" id="vendorstatus">
											<form:option value="">--Select--</form:option>
											<form:options items="${venstatus}"></form:options>	
											</form:select> --%>
												
											<form:select path="statusId">
											<form:option value="">--Select--</form:option>
											<form:options items="${status}"></form:options>	
												</form:select>
												
												<form:select path="timeSlotName" id="timeslotDate">
											<form:option value="">--Select--</form:option>
											<form:options items="${timeSlots}"></form:options>	
												</form:select>
												
												</div>
                                           <%--  <form:hidden path="vendorstatus" id ="vendorstatus" value="${venstatus}"/> --%>
											<%-- <form:hidden path="timeSlotName" value="${timeSlots}"/> --%>
											<form:hidden path="vendorServicebased" value="${vendorServicebased}"/>
															
							</div>
							<div class="block-footer" style="  width: 375px;">
							<aside class="block-footer-right">
									<input type="reset" class="btn-cancel" value="<spring:message code="label.clear" />" id="cancelId" tabindex="13" />
									<input type="button" class="btn-save"  onclick="selectOrders()" value="Search" id="submitId" tabindex="12"/>
							</aside>
							</div>
						</form:form>
					</div> 
					</td>
					<td style="  padding-left: 5px;height: 422px !important;">
			<div class="block" style="width: 68%;">
				<form:form action="" commandName="adminCmd" method="post"
					id="addForm" cssClass="form-horizontal">

					
						<div class="head-box" style="width: 796px">
							<h2>
								<span class="icon2">&nbsp;</span>Admin Order Details
								<span  id="dupMessage" style="color: red;margin-left: 122px;"></span><span  id="upsus" style="color: green;"></span>
								<a href="#" class="export" style="color: yellow;">Export Table data into Excel</a>
							</h2>
							
							<p class="total_orders">Total Orders : <b id='noOrdrs'></b> </p>
							
							<!-- <div  id="upsus" style="color: green;"></div> -->
						</div>
						<div	class="block-box-deptpurchaser1 purchases-downbox block-box-last-deptpurchaser1"
							id="divheader" style="height:470px !important;   /*width: 503px !important;*/">
							<div class="table-list-blk paginationParentDiv itemContainer"
								id="userdata" style=" overflow-x: scroll;overflow-y: hidden; height:470px !important ;  width: 900px;">
							<ul class="table-list" style="width:320%;  font-weight: 600; ">
								<li><input class="checkboxedit" name="chkbox" type="checkbox" style='width: 21px;'  ></li>
								<li class="two-boxxx">Order No</li>
								<li class="two-boxxx">Customer Name</li>
								<li class="two-boxxx">Client Status</li>
								<li class="two-boxxx">Contact No</li>
								<li class="two-boxxx">Service</li>
								<li class="two-boxxx">BHK</li>
								<li class="two-boxxx">Booked Date</li>
								<li class="two-boxxx">Schedule Date</li>
								<li class="two-boxxx">Completed Date</li>
								<li class="two-boxxx">Schedule Time</li>
								<li class="two-boxxx">Location</li>
								<li class="two-boxxx" style='width:178px'>Vendor</li>
								<li class="two-boxxx" >Vendor Status</li>
								<li class="two-boxxx">Vendor Name</li>
								<li class="two-boxxx">Client Status</li>
								<li style="width:70px;">NetAmount</li>
								<li class="two-boxxx">PickDate</li>
								<li class="two-boxxx">PickTime</li>	
								<li class="two-boxxx">Invoice Date</li>
								<li class="two-boxxx ">Update</li>
								<li class="two-box last">invoice</li> 
							</ul>
								<div id="itemContainer" class="itemContainer" style="width: 320%">
								</div>
							</div>
							<div align="center">
								<h4 id="noSortData" style="display: none">No Data Found</h4>
							</div>
						</div>
						<div class="block-footer" style="width: 796px;">
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
					
				</form:form>
				</div>
				</td></tr></table> 
		</div>
	</div>
	</div>
	
	<div id="dial1"></div>
	<div id="dial"></div>
	
	
