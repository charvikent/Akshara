<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	
		
		
	
	
	
	
</script>
</head>newOrderList
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
							<div class="block-box-small orders-topbox block-box-top-header-dept" style="hieght:66px">
								<%-- <div class="block-input">
											<label>Service</label>
											 <form:select path="serviceId"  cssClass="some-select" tabindex="1" onchange="selectOrders();">
											<form:option value="">--Select--</form:option>
											<form:options items="${services}"></form:options>
											</form:select>	</div> --%>
											<div class="block-input">
											<label>Status</label>
											 <form:select path="statusId" id="status"  cssClass="some-select" tabindex="2">
											<form:option value="">--Select--</form:option>
											<form:options items="${status}"></form:options>
											</form:select>	</div>
											<%--  <div class="block-input last"> 
											<label>Phone Number </label>
											<form:input path="contactNo" id="phoneNumId"  maxlength="13"/>
											</div>  --%>
											<div class="block-input "> 
											<label>Email </label>
											<form:input path="contactEmail" id="emailId"  />
											</div>
										<div class="block-input "> 
											<label>OrderId </label>
											<form:input path="orderId" id="searchOrderId"  />
											</div>


											<form:hidden path="timeSlotName" value="${timeSlots}"/>
															
							</div>
							<div class="block-footer">
							<aside class="block-footer-right">
									<input type="reset"
										class="btn-cancel"
										value="<spring:message code="label.clear" />" id="cancelId" tabindex="4"  onclick="dataClear();"/>
									<input type="button" class="btn-save"  onclick="selectOrders()"
										value="Search" id="submitId" tabindex="3"/>
								</aside>
								
							</div>
							
						</form:form>
					</div> 
			
				<form:form action="" commandName="adminCmd" method="post"
					id="addForm" cssClass="form-horizontal">

					<div class="block">
						<div class="head-box">
							<h2>newOrderList
								<span class="icon2">&nbsp;</span>Admin Order Details
							</h2>
							<div  id="dupMessage" style="color: red;"></div>
							<div  id="upsus" style="color: green;"></div>
						</div>
						<div
							class="block-box-deptpurchaser purchases-downbox block-box-last-deptpurchaser"
							id="divheader" style="height:350px !important">
							<div class="table-list-blk paginationParentDiv"
								id="userdata" style="overflow-x: scroll;overflow-y: hidden; height:322px !important">
							<ul class="table-list" style="width:202%;  font-weight: 600; ">
								<li class="two-boxxx">Order No</li>
								<li class="two-boxxx">Location</li>
								<li class="two-boxxx">Service</li>
								<li class="two-boxxx">Booked Date</li>
								<li class="two-boxxx">Schedule Date</li>
								<li class="two-boxxx">Schedule Time</li>
								<li class="two-boxxx">Contact No</li>
								<li class="two-boxxx">Contact Email</li>
								<li class="two-boxxx">Status</li>
								<li class="two-boxxx">Customer Discount</li>
								<li style="width:70px;">B2C Price</li>
								<li style="width:70px;">Discount %</li>
								<li style="width:70px;">NetAmount</li>
								<li class="two-boxxx">PickDate</li>
								<li class="two-boxxx">PickTime</li>	
								<li style='width:175px'>Vendor</li>
								<li style='width:175px'>Vendor Details</li>
								<li class="two-boxxx">Change Status</li>
								<li class="two-box last">Update</li>
							</ul>
								<div id="itemContainer" style="width: 202%">
								</div>
							</dstatusiv>
							<div align="center">
								<h4 id="noSortData" style="display: none">No Data Found</h4>
							</div>
						</div>
						<div class="block-footer">
							<aside class="block-footer-left">
								<div id="legend2" class="savmarup"></div>newOrderList
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
	var statusNames;
	var timeSlotDrop = $("#timeSlotName").val();
	$(document).ready(function(){
		//$("#vendorId").hide();//for hide
		//$("#statusId").hide();//for hide
		var listOrders ="${orderListJson}";
		if(listOrders != ""){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			displayTable(listOrders);
			$.each(listOrders, function(i, orderObj) {
			});
		}else{
		
		};
		//paginationTable(8);
	});
	function displayTable(listOrders){
		//var vendorDropDown = $("#vendorId").html();
		//var statusDrop= $("#statusId").html();
		//var timeSlotDrop = $("#timeSlotId").html();
		if (listOrders != null){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			$.each(listOrders, function(i, orderObj) {
				var id='"'+orderObj.orderId+'"';newOrderList
				if(orderObj.totalPrice == null){
					orderObj.totalPrice =0;
				}
				if(orderObj.customerDiscount == null){
					orderObj.customerDiscount =0;
				}
				if(orderObj.totalDiscount == null){
					orderObj.totalDiscount =0;
				}
				if(orderObj.netAmount == null){
					orderObj.netAmount =0;
				}
				var netamountvalue =  orderObj.netAmt;
				if(netamountvalue==0 || netamountvalue=='' || netamountvalue==null){
					netamountvalue = parseInt(orderObj.totalPrice)-(parseInt(orderObj.totalPrice)*(parseInt(orderObj.totalDiscount)/100))-parseInt(orderObj.customerDiscount); 
				//alert(netamountvalue);
				}
				if(parseFloat(netamountvalue)<=0){
					netamountvalue=0;
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
						+"<li class='two-boxxx' >"+orderObj.customerDiscount+"</li>"
						+"<input type='hidden' id='"+orderObj.orderId+"cdisc'  value='"+orderObj.customerDiscount+"'>"
						//+"<li style='width:70px;' ><input style='width: 53px;' type='text' name='b2b' id='"+orderObj.orderId+"b2b' value='"+orderObj.totalPrice+"'></input></li>"
						+"<li style='width:70px;' ><input style='width: 53px;' type='text' name='b2c' id='"+orderObj.orderId+"b2c' value='"+orderObj.totalPrice+"' onkeypress='return onlyNos(event,this);' onblur='calculateNetAmount(this.id);' ></input></li>"
						+"<li style='width:70px;' ><input style='width: 53px;' type='text' name='desc' id='"+orderObj.orderId+"desc' value='"+orderObj.totalDiscount+"' onblur='calculateNetAmount(this.id);' onkeypress='return onlyNos(event,this);'></input></li>"
						+"<li style='width:70px;' ><input style='width: 53px;' type='text' name='netAmt' id='"+orderObj.orderId+"netAmt' disabled value='"+netamountvalue+"' ></input></li>"
						+"<li class='two-boxxx' >"+"<select name='dateId' id='"+orderObj.orderId+"dateId'><option value=''>--Select--</option></select>"+"</li>"
						+"<li class='two-boxxx' ><input type='hidden' name='timeSlotHid"+i+"'  value='"+orderObj.appointmentSlotId+"'/><input name='timeSlotNameHid' type='hidden' id='"+orderObj.orderId+"timeName'"+"><select  name='timeSlotNameId' id='"+orderObj.orderId+"timeId'"+" ></select>"+"</li>"   /* value= >'"+timeSlotDrop+"'  */
						+"<li style='width:175px' ><input type='hidden' name='vendorHid"+i+"' value='"+orderObj.vendorId+"'><select onchange='repalceName(this.id, null)' name='vendorNameId' id='"+orderObj.orderId+"vendorId'"+" ></select>"+"</li>"
						+"<input type='hidden' id='vname' name='vendorName"+i+"'  value='"+orderObj.vendorName+"'/>"
						+"<li style='width:175px' id='"+orderObj.orderId+"vendorInfo'"+" ></li>"
						+"<li class='two-boxxx' ><input type='hidden' name='statusHid"+i+"'  value='"+orderObj.statusName+"'/><select class='statusSelect' name='statusNameId' onChange='statusNamee(this)' id='"+orderObj.orderId+"status'"+" ></select></li>"
						+"<li class='ten-boxxx last' >"+"<input type='button' id='"+orderObj.orderId+"' value='Update' onclick='formSubmit(this.id)' ></li>"
						+ '</ul>';
				$(tblRow).appendTo("#itemContainer");
			});
			paginationTable(8);
		}else{
			//alert('no data to display..');
		}
	}
	newOrderList
	function statusNamee(name){
		var text = name.options[name.selectedIndex].text;
		statusNames = text;
	}
	
	function forVendorDetails(id) {
		 $.blockUI({ message: 'Please Wait' });
		//alert(id);
		//$("#vendor").css("background-color","silver");
		  $('#dial table').remove();
			var vendorId = id;
		
			$.ajax({
						type : "POST",
						url : "vendorDetails.json",
						data : "vendorId=" + vendorId,
						dataType : "json",
							success : function(productHisInfo) {
								$.unblockUI(); 
							  if (productHisInfo == "" || productHisInfo==null) {
								} else {
									var  popuptitle=null;
										 var stockInformation1 ="<table id='stockInformationTable' border='1'>" 
									 		+"<th style=width:19%;>Vendor Name </th>"
									 		+"<th>Address </th>"
									 		+"<th>MobileNo </th>"
									 		+"</table>";
								$(stockInformation1).appendTo("#dial");
									
										  popuptitle=productHisInfo.firstName;
										 var stockInformation2 ="<tr>"+"<td>"+productHisInfo.firstName+"</td>"
											 		+"<td>"+"<center>"+productHisInfo.address+"</center>"+"</td>"
											 		+"<td>"+"<center>"+productHisnewOrderListInfo.mobileNumber+"</center>"+"</td>"
											 		+"</tr>";
										 $(stockInformation2).appendTo("#stockInformationTable");
										
										 		
									 $('#dial').dialog({width:799,title:popuptitle,modal: true}).dialog('open');
								};  
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					}); 
			
			}
	
	function repalceName(id, val){
		//alert(id);
		$("#dupMessage").text('');
		if(val == null){
			id=id.replace("vendorId",'');
		}else{
			id = val;	
		}
		var temp=$('#'+id+'vendorId').find('option:selected').text();
		var tempVal=$('#'+id+'vendorId').find('option:selected').val();
		if(temp !="--Select--"){
			var vid="'"+id+"'";
			tempVal="'"+tempVal+"'";
			var htStr='<a href="javascript:forVendorDetails('+tempVal+')" id="vendor" >'+temp+'</a>';
			$('#'+id+'vendorInfo').html(htStr);	
		}else{
			$('#'+id+'vendorInfo').html("");
		}
		
	}
	
	 function selectOrders(){
		 $.blockUI({ message: 'Please Wait' });
		 var serviceId = $("#serviceId").val();
		 var phoneNumberId = $("#phoneNumId").val();
		 var emailId = $("#emailId").val();
		 var orderid = $("#searchOrderId").val();
		 var statid = $("#status").val();
		$("#itemContainer ul").remove();
		$("#itemContainer ul li").remove(); 
		$("#vendorId").hide();//for hide
		$("#statusId").show();//for hide
		 $.ajax({
				type : "POST",
				url : "getServiceOrders.json",
				data : "serviceId=" + serviceId+"&phoneNo="+phoneNumberId +"&emailId="+emailId+"&orderId="+orderid+"&statusId="+statid,
				dataType : "json", 
				success : function(response) {
					/* alert(response); */
					$.unblockUI(); 
					if(response != ""){
						$("#itemContainer ul li").remove();
						$("#itemContainer ul").remove();newOrderList
						displayTable(response);
					}
					resetStatus(serviceId);
					resetVendor(serviceId);
					
				},
				error : function(e) {
				}
			});
	 }
	 function formSubmit(id) {
			 var orderId=id;
			var vendorId = $("#" + id + "vendorId").val();
			var dateId = $("#"+id+"dateId").val();
			var timeId= $("#"+id+"timeId").val();
			var netAmtId = $("#"+id+"netAmt").val();
			var b2bId =$("#"+id+"b2b").val();
			var b2cId =$("#"+id+"b2c").val();
			var disc =$("#"+id+"desc").val();
		 	var statusId= $("#" + id + "status").val();
		 	var timeSlotName=$('#'+id+'timeName').val();
		 	var customerDisc=$('#'+id+'cdisc').val();
		 	var vname = $('#vname').val();
		 	if(statusId != 4 ){
		 		if(vendorId == '' || vendorId == null){
			 		$("#" + id + "vendorId").focus();
			 		$("#dupMessage").text("Enter vendor name");
			 		//alert("enter vendor");
			 		return false;
			 	}
		 	}
		 	
		 	if(netAmtId == '' || netAmtId == null){
		 		$("#" + id + "netAmt").focus();
		 		$("#dupMessage").text("Enter NetAmout");
		 		//alert("enter netAmount");
		 		return false;
		 	}
		 	
		 	$.blockUI({ message: 'Please Wait'});
		 	//alert(vendorId.length+dateId+timeId+netAmtId+b2bId+b2cId+disc);
			
		$.ajax({
			type : "POST",
			url : "assignToAdmin.htm",
			/* dataType:"json", */
			data : "vendorId=" + vendorId +
			"&orderId=" + orderId +
			"&statusId="+ statusId+
			"&pickdate="+ dateId+
			"&timeSlotId="+ timeId+
			"&netAmt="+ netAmtId+
			"&b2bId="+ b2bId+
			"&b2cId="+ b2cId+
			"&disc="+ disc+
			"&timeSlotName="+ timeSlotName+
			"&statusName="+statusNames,
			
			/* dataType : "json", */
			success : function(response) {
					/* document.getElementById("upsus").style.display = "block"; */
					$("#upsus").text("status updated succes	sfully").fadeIn(1000);
					$("#upsus").text("status updated successfully").fadeOut(8000);
				$.unblockUI(); 
				if (response != "" &&  response == "succ") {
			
					//$("#itemContainer ul li").remove();
					//$("#itemContainer ul").remove();
					//displayTable(response);
			
			 $("#" + id + "vendorId").val(vendorId);
			// $("#"+id+"dateId").val(dateId);
			/* var timeId= $("#"+id+"timeId").val(); */
			 $("#"+id+"netAmt").val(netAmtId);
			//$("#"+id+"b2b").val();
			//$("#"+id+"b2c").val(b2cId);
			$("#"+id+"desc").val(disc);
			$("#statusId").show();
		 	 $("#" + id + "statusid").text(statusNames);
		 	$("#" + id + "status").val(statusId);
		 	//var timeSlotName=$('#'+id+'timeName').val();
		 	//$('#'+id+'cdisc').val(customerDisc);
		 	 $('#vname').val(vname);
					
					//
					//selectOrders();
				} else {
					alert("error in operation");
				}
				 var serviceId = $("#serviceId").val();
				 /* resetStatus(serviceId); */ 
				/*resetVendor(serviceId); */
			},
			error : function(e) {
			}
		});
			}
	
	
	 function resetStatus(id){
		 //var serviceid = $("#" + id).val();
		   $.blockUI({ message: 'Please Wait' });
			$.ajax({
				type : "POST",
				url : "forStatus.json",
				data : "serviceId=" + id,
				dataType : "json",
				success : function(response) {
					$.unblockUI(); 
					var optionsForClass = "";
				for(var i=0;i<$('[name="statusNameId"]').length;i++){
					var tempSlotValue=document.getElementsByName("timeSlotHid"+i)[0].value;
					 var tempSlotId=document.getElementsByName("timeSlotNameId")[i].id;
					 var tempSlotNameId=document.getElementsByName("timeSlotNameHid")[i].id;
					// $("#"+tempSlotNameId).val('');
						optionsForClass = $("#"+tempSlotId).empty();
						optionsForClass.append(new Option("--Select--", ""));
						$.each(JSON.parse(timeSlotDrop), function(i, tests) {
							if(tempSlotValue==tests.id){
								var opt=new Option(tests.name,tests.id);
							    opt.setAttribute("selected","selected");
							    optionsForClass.append(opt);
							    $("#"+tempSlotNameId).val(tests.name);
							}else
								optionsForClass.append(new Option(tests.name,tests.id));
						});
					
					var todayDate = new Date();
					var appDate = new Date(document.getElementById("appDate"+i).value);
					var tempDateId=document.getElementsByName("dateId")[i].id;
					optionsForClass = $("#"+tempDateId).empty();
					var opt=new Option("---Select----","");
				    opt.setAttribute("selected","selected");
				    optionsForClass.append(opt);
				    var opt=new Option("Today","today");
				    optionsForClass.append(opt);
				    var opt=new Option("Tommorow","tmrw");
				    optionsForClass.append(opt);
				    var opt=new Option("Day After","dayafter");
				    optionsForClass.append(opt);
					/* if(todayDate.getDate() == appDate.getDate() && todayDate.getFullYear() == appDate.getFullYear() ){
						
						var opt=new Option("Today","today");
					    opt.setAttribute("selected","selected");
					    optionsForClass.append(opt);
					    var opt=new Option("Tommorow","tmrw");
					    optionsForClass.append(opt);
					    var opt=new Option("Day After","dayafter");
					    optionsForClass.append(opt);
					    
					}else{
						todayDate.setDate(todayDate.getDate()+1);
						if(todayDate.getDate() == appDate.getDate()  && todayDate.getFullYear() == appDate.getFullYear()){
							var opt=new Option("Today","today");
						    optionsForClass.append(opt);
						    var opt=new Option("Tommorow","tmrw");
						    opt.setAttribute("selected","selected");
						    optionsForClass.append(opt);
						    var opt=new Option("Day After","dayafter");
						    optionsForClass.append(opt);	
						}else{
							todayDate.setDate(todayDate.getDate()+1);
							if(todayDate.getDate() == appDate.getDate()  && todayDate.getFullYear() == appDate.getFullYear()){
							var opt=new Option("Today","today");
						    optionsForClass.append(opt);
						    var opt=new Option("Tommorow","tmrw");
						    optionsForClass.append(opt);
						    var opt=new Option("Day After","dayafter");
						    opt.setAttribute("selected","selected");
						    optionsForClass.append(opt);
							}else{
								if(todayDate.getDate() == appDate.getDate()  && todayDate.getFullYear() == appDate.getFullYear()){
									var opt=new Option("---Select----","---Select---");
								    opt.setAttribute("selected","selected");
								    optionsForClass.append(opt);
								    var opt=new Option("Today","today");
								    optionsForClass.append(opt);
								    var opt=new Option("Tommorow","tmrw");
								    optionsForClass.append(opt);
								    var opt=new Option("Day After","dayafter");
								    optionsForClass.append(opt);
								}else{
									var opt=new Option("","--select--");
									opt.setAttribute("selected","selected");
								}
								
								
								
								resetStatus 
							}
						} 
					}*/
						
					var tempId=document.getElementsByName("statusNameId")[i].id;
					var tempValue=document.getElementsByName("statusHid"+i)[0].value;
					optionsForClass = $("#"+tempId).empty();
					optionsForClass.append(new Option("--Select--", ""));
					$.each(response, function(i, tests) {
					//alert(tempValue);
					//alert(tests.name);
						if(tempValue==tests.name){
							var opt=new Option(tests.name,tests.id);
						    opt.setAttribute("selected","selected");
						    optionsForClass.append(opt);
						}else
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
	 
	 function resetVendor(id){
		 $.blockUI({ message: 'Please Wait' });
			$.ajax({
				type : "POST",
				url : "forVendor.json",
				data : "serviceId=" + id,
				dataType : "json",
				success : function(response) {
					$.unblockUI(); 
					var optionsForClass = "";
					//optionsForClass = $("#orderStatusId").empty();
					for(var i=0;i<$('[name="vendorNameId"]').length;i++){
					var tempId=document.getElementsByName("vendorNameId")[i].id;
					var tempVal=document.getElementsByName("vendorHid"+i)[0].value;
					optionsForClass = $("#"+tempId).empty();
					optionsForClass.append(new Option("--Select--", ""));
					$.each(response, function(i, tests) {
						if(tempVal == tests.id){
							var opt=new Option(tests.name,tests.id);
						    opt.setAttribute("selected","selected");
						    optionsForClass.append(opt);
						}else{
							optionsForClass.append(new Option(tests.name,tests.id));
						}
						 
					});
					
					  repalceName(tempId,null);
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
	
	//for order info details..
	 function forOrderDetails(id){
			//alert(id);
			 $.blockUI({ message: 'Please Wait' });
			$('#dial table').remove();
			var orderId = id;
			$.ajax({
						type : "POST",
						url : "orderDetails.json",
						data : "orderId=" + orderId,
						dataType : "json",
							success : function(productHisInfo) {
								$.unblockUI(); 
							  if (productHisInfo == "" || productHisInfo==null) {
								} else {
									/* var  popuptitle=null;
										 var stockInformation1 ="<table id='stockInformationTable' border='1'>" 
									 		+"<tr><th>OrderId </th>"
									 		+"<th>Schedule Date </th>"
									 		 +"<th>Booked Date </th>"
									 		+"<th>Schedule Time </th>"
									 		+"<th>Contact Number </th>"
									 		+"<th>Email Id </th>"
									 		+"<th>service Name </th>"
									 		+"<th>Contact Address </th>" 
									 		+"</table>";
								$(stockInformation1).appendTo("#dial"); */
								 var  popuptitle=null;
								 var stockInformation1 ="<table id='stockInformationTable' border='1'>" 
								 		+"<tr><th>OrderId </th>"
								 		+"<th>service Name </th>"
								 		+"<th>Booked Date </th>"
								 		+"<th>Schedule Date </th>"
								 		+"<th>Schedule Time </th>"
								 		+"<th>Contact Number </th>"
								 		+"<th>Contact Email </th>"
								 		+"<th>Contact Address </th>" 
								 		+"<th>Order Description</th>" 
								 		+"<th>Tests</th>" 
								 		+"<th>Symtems</th>" 
								 		+"</table>";
							$(stockInformation1).appendTo("#dial");
									 $.each(productHisInfo,function(i, stockObj) {
										 var MyDate_String_Value = "/Date("+stockObj.bookedDate+")/"
											 var bookedDate = new Date(stockObj.bookedDate);
											             /* (
											                  parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
											             ); */
											                  
								             var MyDate_String_Value1 = "/Date("+stockObj.appointmentDate+")/"
											 var appointmentDate = new Date
											             (
											                  parseInt(MyDate_String_Value1.replace(/(^.*\()|([+-].*$)/g, ''))
											             );
											                  /* alert(value);
											 var dat = value.getMonth() + 
											                          1 + 
											                        "/" + 
											            value.getDate() + 
											                        "/" + 
											        value.getFullYear();
											// alert(dat); */
										  
										 
										 
										 
										//alert(stockObj.serviceName);
										serviceName = stockObj.serviceName;
										 popuptitle=serviceName;
										 if(stockObj.tests == "" || stockObj.tests == null){
											 stockObj.tests = "---";
										 }
										 if(stockObj.description == "" || stockObj.description == null){
											 stockObj.description = "---";
										 }
										 if(stockObj.symtoms == "" || stockObj.symtoms == null){
											 stockObj.symtoms = "---";
										 }
										 var stockInformation2 ="<tr><td>"+stockObj.generatedId+"</td>"
										 			+"<td>"+"<center>"+stockObj.serviceName+"</center>"+"</td>"
										 			 +"<td>"+"<center>"+bookedDate+"</center>"+"</td>"
											        +"<td>"+"<center>"+appointmentDate+"</center>"+"</td>"
											 		+"<td>"+"<center>"+stockObj.appointTimeName+"</center>"+"</td>"
											 		 +"<td>"+"<center>"+stockObj.contactNumber +"</center>"+"</td>"
											 		+"<td>"+"<center>"+stockObj.contactEmail+"</center>"+"</td>"
											 		+"<td>"+"<center>"+stockObj.address+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+stockObj.description+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+stockObj.tests+"</center>"+"</td>"
											 		+"<td>"+"<center>"+stockObj.symtoms+"</center>"+"</td>"
											 		+"</tr>";
										 $(stockInformation2).appendTo("#stockInformationTable");
										/* if(serviceName == "Pathology"){
											 var sSchedueDate = sArray[1];
											 var  sBookedDate = sArray[2];
											 var sContactNumber = sArray[3];
											 var sTimeName = sArray[4];
											 var totalPrice = sArray[5];
											 var totalDiscount = sArray[6];
											 var totalNetAmount = sArray[7];
											 var sContactAddress = sArray[8];
											// alert(sContactAddress);
											 var sEmailId = sArray[9];
											var pathologyArray =  sArray[10];
										 var stockInformation1 ="<table id='stockInformationTable' border='1'>" 
										 		+"<tr><th>OrderId </th>"
										 		+"<th>Schedule Date </th>"
										 		 +"<th>Booked Date </th>"
										 		+"<th>Schedule Time </th>"
										 		+"<th>Contact Number </th>"
										 		+"<th>Email Id </th>"
										 		+"<th>service Name </th>"
										 		+"<th>Contact Address </th>" 
										 		+"<th>Total Price </th>" 
										 		+"<th>Total Discount </th>" 
										 		+"<th> NetAmount</th>" 
										 		+"<th>Tests</th>" 
										 		+"</table>";
									$(stockInformation1).appendTo("#dial");
									
										 var stockInformation2 ="<tr><td>"+stockObj.orderId+"</td>"
											        +"<td>"+"<center>"+sSchedueDate+"</center>"+"</td>"
											        +"<td>"+"<center>"+sBookedDate+"</center>"+"</td>"
											 		+"<td>"+"<center>"+sTimeName+"</center>"+"</td>"
											 		 +"<td>"+"<center>"+sContactNumber +"</center>"+"</td>"
											 		+"<td>"+"<center>"+sEmailId+"</center>"+"</td>"
											 		+"<td>"+"<center>"+serviceName+"</center>"+"</td>"
											 		+"<td>"+"<center>"+sContactAddress+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+totalPrice+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+totalDiscount+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+totalNetAmount+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+pathologyArray+"</center>"+"</td>"
											 		+"</tr>";
										 $(stockInformation2).appendTo("#stockInformationTable");
										}
								 */		/* if(serviceName == "Doctor"){
											 var sSchedueDate = sArray[1];
											 var sContactNumber = sArray[2];
											 var sTimeName = sArray[3];
											 var totalPrice = sArray[4];
											 var totalDiscount = sArray[5];
											 var totalNetAmount = sArray[6];
											 var sContactAddress = sArray[7];
											 var sEmailId = sArray[8];
											 var sBookedDate = sArray[9];
											 var doctorType =  sArray[10];
										 var stockInformation1 ="<table id='stockInformationTable' border='1'>" 
										 		+"<tr><th>OrderId </th>"
										 		+"<th>Schedule Date </th>"
										 		+"<th>Booked Date </th>"
										 		+"<th>Schedule Time </th>"
										 		+"<th>Contact Number </th>"
										 		+"<th>Email Id </th>"
										 		+"<th>service Name </th>"
										 		+"<th>Doctor Type</th>"
										 		+"<th>Contact Address </th>" 
										 		+"<th>Total Price </th>" 
										 		+"<th>Total Discount </th>" 
										 		+"<th> NetAmount</th>" 
										 		+"</table>";
									$(stockInformation1).appendTo("#dial");
									
										 var stockInformation2 ="<tr><td>"+stockObj.orderId+"</td>"
											        +"<td>"+"<center>"+sSchedueDate+"</center>"+"</td>"
											        +"<td>"+"<center>"+sBookedDate+"</center>"+"</td>"
											 		+"<td>"+"<center>"+sTimeName+"</center>"+"</td>"
											 		 +"<td>"+"<center>"+sContactNumber +"</center>"+"</td>"
											 		+"<td>"+"<center>"+sEmailId+"</center>"+"</td>"
											 		+"<td>"+"<center>"+serviceName+"</center>"+"</td>"
											 		+"<td>"+"<center>"+doctorType+"</center>"+"</td>"
											 		+"<td>"+"<center>"+sContactAddress+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+totalPrice+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+totalDiscount+"</center>"+"</td>" 
											 		+"<td>"+"<center>"+totalNetAmount+"</center>"+"</td>" 
											 		+"</tr>";
										 $(stockInformation2).appendTo("#stockInformationTable");
										} */
									}); 	 		
									 $('#dial').dialog({width:1199,title:popuptitle,modal: true}).dialog('open');
								}  
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
			
			
		} 
	
	//
	function calculateNetAmount(id){
		if(id.indexOf('desc') != -1){
			id = id.replace("desc", '');		
		}else{
			id = id.replace("b2c", '');
		}
   
   var b2c = $("#" + id + "b2c").val();
   var desc = $("#"+id+"desc").val();
   //var net = $("#"+id+"netAmt").val();
	var cdis = $("#"+id+"cdisc").val();
	var netAmount = 0.00;
	if(cdis == null || cdis == ""){
		cdis = 0;
	}
	netAmount = cdis;
   
     netAmount = parseFloat(b2c*((100-desc)/100))-parseFloat(netAmount); 
   if(netAmount < 0){
	   $("#"+id+"netAmt").val(0);
   }else{
	   $("#"+id+"netAmt").val(netAmount);
   }
   
  }
	//
	 /* function calculateNetAmount(id){
			id = id.replace("desc", '');
			var b2c = $("#" + id + "b2c").val();
			var desc = $("#"+id+"desc").val();
			var net = $("#"+id+"netAmt").val();
			var cdisc = $("#"+id+"cdisc").val();
			var netAmount =0;
			if(net.indexOf('-') != -1){
				 netAmount = parseInt(b2c*((100-desc)/100))+parseInt(net);	
			}else{
				if( net == 0){
					netAmount = b2c*((100-desc)/100);	
				}
			}
			$("#"+id+"netAmt").val(netAmount);
		} */
	function onlyNos(e, t) {
         try {
             if (window.event) {
                 var charCode = window.event.keyCode;
             }
             else if (e) {
                 var charCode = e.which;
             }
             else { return true; }
             if (charCode > 31 && (charCode<48||charCode>57)) {
                 return false;
             }
             return true;
         }
         catch (err) {
             /* alert(err.Description); */
         }
     }
		$(document).ready(function() {
			chosenDropDown(); 
			var list = ${newOrderList};
			displayTable(list);
			$("#emailId").val("");
			$("#phoneNumId").val("");
		});
	
	</script>
	<div id="dial"></div>