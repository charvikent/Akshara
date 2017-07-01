<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Orders</title>
<style>
.table-list-blk ul li.three-boxxx {
width: 186px;
text-align:center;
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
.table-list-blk ul li.one-boxxx{
width: 235px;
}
.one-boxxx{
width: 235px;
}
.two-boxxx{
width: 100px;
}
.three-boxxx{
width: 100px;
text-align: center;
}
.colorbox{
color: #800000;
}
.forth-boxxxstatus{
width: 127px;
}
.stock-pcode-boxnew{
width: 175px;
}
.table-list-blk ul li.eleven-box{
width: 37px;
}
.one{
width:102px;
text-align:center;
}
 .quantity-boxxx{
width:175px;
text-align:center;
}
.one-boxx{
width:362px
}
.one-boxu{
width:50px;
text-align:center;
}
.ten-boxq{
width:50px;
}
.butsave{
cursor:pointer;
}
/* mouse over link */
.changeColor{

}
a:hover {
    color: #800000;
}
</style>

<!-- <script type="text/javascript">
 $(document).ready(function() {	
	 var OrderListOfVendor = ${OrderListOfVendor};
	
	 if(OrderListOfVendor == ""){
	 }else{
		 $.each(OrderListOfVendor,function(i, purchaseObj) {
			 purchaseOrderId=purchaseObj.orderId;
		 });
		 $('#dial').dialog({width:1123,title:purchaseOrderId,modal: true}).dialog('open');
		 /* $('#popupSubmitId').hide(); */
	  };
	 }); 
		</script> -->
		
<script type="text/javascript">


function formSubmit(id){
	var orderId = id;
	var date = $("#"+id+"date").text();
	var status = $("#"+id+"status").text();
	var qty = $("#"+id+"qty").text();
	var amount = $("#"+id+"netAmt").text();
	var disc = $("#"+id+"disc").text();
	var vendorId =  $("#"+id+"vendor").val();
	/* alert(vendorId); */
	$.ajax({
		type : "GET",
		url : "assignToVendor.htm",
		data:"vendorId="+vendorId+"&orderId="+orderId+"&orderDate="+date+"&orderStatus="+status+"&quantity="+qty+"&netAmount="+amount+"&discount="+disc,
		dataType : "json",
		success : function(serviceList) {
			alert(serviceList+"this is java");
			if (serviceList == "") {
			} else {
			}
		},
		error : function(e) {
		}
	});
}


function forStockDetails(id) {
	alert(id);
	$('#dial table').remove();
	var orderId = id;
	$.ajax({ 
				type : "POST",
				url : "orderDetails.htm",
				data : "orderId=" + orderId,
				dataType : "json",
					success : function(productHisInfo) {
						/* alert(productHisInfo); */
					    if (productHisInfo == "" || productHisInfo==null) {
						} else {
							var  popuptitle=null;
								 var stockInformation1 ="<table id='stockInformationTable' border='1'>" 
							 		+"<tr><th>Order Id </th>"
							 		/* +"<th>Pharmaorderdetails Id </th>" */
							 		+"<th>Medicine Name </th>"
							 		+"<th>Dosage </th>"
							 		+"<th>Brand </th>"
							 		+"<th>TypeId </th>"	
							 		+"<th>Quantity </th>"
							 		+"<th>Mrp </th>"	
							 		+"<th>Discount </th>"	
							 		+"<th>Net Amount </th>"
							 		+"</table>"
							 		+"<table  border='1'>" 
							 		/* +"<tr><th>total </th>" */
							 		+"<th COLSPAN=5>Total </th>"
							 		/* +"<th>Dosage </th>"
							 		+"<th>Quantity </th>" */
							 		/* +"<td>Brand </td>"
							 		+"<td>TypeId </td>"	 */
							 		+"<td>"+"<center>"+"<input type='text' id='tquntity' name='tquntity'  />"+"</center>"+"</td>"
							 		+"<td>"+"<center>"+"<input type='text' id='tmrp' name='tmrp'  />"+"</center>"+"</td>"	
							 		+"<td>"+"<center>"+"<input type='text' id='tdisc' name='tdisc'  />"+"</center>"+" </td>"	
							 		+"<td>"+"<center>"+"<input type='text' id='tnet' name='tnet'  />"+"</center>"+" </td>"
							 		
							 		+"</table>"
							 		+ "<input class='btn-cancel' name='' value='Cance' type='button' onclick='return hidePopup()' >"
									+"<input class='btn-save' name='' value='Add' type='button'  onclick='formDetailSubmit()'>" ;
						$(stockInformation1).appendTo("#dial");
						var count =0;
						var total=0;
						
							 $.each(productHisInfo,function(i, stockObj) {
								 count++;
								
							/* 	var pharmaorderdetailsId=stockObj.pharmaorderdetailsId; */
						/* 	alert("pharmaorderdetailsId-------"+stockObj.pharmaorderdetailsId); */
								 popuptitle=stockObj.customerName;
								 var stockInformation2 ="<tr class='textBoxClass' name='"+stockObj.pharmaorderdetailsId+"'><td id='orderId'>"+stockObj.orderId.substring(1,8)+"</td>"
								   				+"<td id='tnorderIdInPopup' style='display :none;' >"+stockObj.orderId+"</td>"
											 +"<td id='"+count+"pharmaorderdetailsId' style='display :none;'>"+"<center>"+stockObj.pharmaorderdetailsId+"</center>"+"</td>"
											 +"<td id='"+count+"mname'>"+"<center>"+stockObj.medicineName+"</center>"+"</td>"
									 		+"<td id='"+count+"dosage'>"+"<center>"+stockObj.dosage+"</center>"+"</td>"
									 		+"<td id='"+count+"brand'>"+"<center>"+stockObj.brand+"</center>"+"</td>"
									 		+"<td id='"+count+"typeId'>"+"<center>"+stockObj.typeId+"</center>"+"</td>"
									 		+"<td id='"+count+"quantity'>"+"<center>"+stockObj.quantity+"</center>"+"</td>"
									 		+"<td>"+"<center>"+"<input type='text' name='"+count+"' id='"+count+"mrp' onBlur='doMath(this.name);calculateTotalm();' />"+"</center>"+"</td>"
									 		 +"<td>"+"<center>"+"<input type='text' name='"+count+"' id='"+count+"disc' onBlur='doMath(this.name);calculateTotalD();' />"+"</center>"+"</td>"
									 		+"<td>"+"<center>"+"<input type='text'   name='"+count+"' id='"+count+"net' onBlur='calculateTotelN();' readonly />"+"</center>"+"</td>" 
									 		 /* +"<td>"+"<center>"+stockObj.customerName+"</center>"+"</td>"  */
									 		+"</tr>"
									 		
								 $(stockInformation2).appendTo("#stockInformationTable");
								 
								
							}); 
							 var stockInformation2 ="<table id='stockInformationTable' border='1'>" 
							 		+"<tr><th>Order Id </th>"
							 		/* +"<th>Pharmaorderdetails Id </th>" */
							 		+"<th>Medicine Name </th>"
							 		+"<th>Dosage </th>"
							 		+"<th>Quantity </th>"
							 		+"<th>Brand </th>"
							 		+"<th>TypeId </th>"	
							 		+"<th>Mrp </th>"	
							 		+"<th>Discount </th>"	
							 		+"<th>Net Amount </th>"
							 		
							 		+"</table>";
							 $(stockInformation2).appendTo("#stockInformationTable2");
							 
						} 
					   
						$('#dial').dialog({width:799,title:popuptitle,modal: true}).dialog('open'); 
						calculateSum();
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
	
	} 
//calculate the Net ammount
function doMath(id){
	var mrp= $("#"+id+"mrp").val();
	var discount= $("#"+id+"disc").val();
	
	var quantity = $("#"+id+"quantity").text();
	var totalQuntity=0;
	
	/* alert(quantity); */
	if(mrp == null|| mrp == "" && discount==null || discount=="")
		{
	
		}else{
			/* alert(quantity); */
			totalQuntity=totalQuntity+ parseInt(quantity);
			/* alert("total quntity............"+totalQuntity); */
			
			var total=quantity*mrp;
			var dis=(quantity*mrp*discount)/100;
			
			var netAmount= total-dis;
			/* alert(netAmount); */
			 $("#"+id+"net").val(netAmount);

		}
	/* var discount=$("#"+id).val(); */
	/* alert(discount); */
	
	/* var date = $("#"+id+"mrp").val();
	alert(date); */
}
	
function formDetailSubmit(){
	 var counter = $(".textBoxClass").length; 
	 var orderId = $("#tnorderIdInPopup").text();
	/*  alert(orderId); */
	
	var listOfObjects = [];
	var tquntity = $("#tquntity").val();
	var tdisc = $("#tdisc").val();
	var tnet = $("#tnet").val();
	/*  alert(tnet); */ 
	 $("#"+orderId+"qty").text(tquntity);
	 $("#"+orderId+"disc").text(tdisc);
	 $("#"+orderId+"netAmt").text(tnet);
	 var tquntity = $("#tquntity").val();
	/*  alert("total tdisc"+tdisc); */
	
	 for(var id=1; id<= counter; id++){
		 var orderId = $("#tnorderIdInPopup").text();
			var pharmaorderdetailsId = $("#"+id+"pharmaorderdetailsId").text();
			var medicineName = $("#"+id+"mname").text();
			var dosage = $("#"+id+"dosage").text();
			var quantity = $("#"+id+"quantity").text();
			var brand = $("#"+id+"brand").text();
			var typeId = $("#"+id+"typeId").text();
			
			var mrp = $("#"+id+"mrp").val();
			var disc = $("#"+id+"disc").val();
			var netAmount=$("#"+id+"net").val();
			
			 /*  alert(netAmount);  */
			  var a = ["orderId","pharmaorderdetailsId", "medicineName", "dosage", "quantity", "brand","typeId","mrp","disc","netAmount","tquntity","tdisc","tnet"];
			    var singleObj = {};
			    singleObj['orderId'] = orderId;
			    singleObj['pharmaorderdetailsId'] = pharmaorderdetailsId;
			    singleObj['medicineName'] =medicineName;
			    singleObj['dosage'] =dosage;
			 	singleObj['quantity'] = quantity;
			 	singleObj['brand'] = brand;
				singleObj['typeId'] = typeId;
				singleObj['mrp'] = mrp;
				singleObj['disc'] = disc;
				singleObj['netAmount'] = netAmount;
				singleObj['tquntity'] = tquntity;
				singleObj['tdisc'] = tdisc;
				singleObj['tnet'] = tnet;
			 	/*  alert(orderId);  */
			    listOfObjects.push(singleObj); 
	 }
				if(listOfObjects.length >0){
		    		var json = JSON.stringify(listOfObjects);
		    		
		    		$.ajax({
						type : "POST",
						url : "vendorDedatileUpdate.htm",
						dataType:'application/json',
			            data: {temp1:json},
						success : function(response) {
							alert(response);
							if (response != "") {	
								
								document.getElementById("dupEditMessage").style.display = "block";
								$('#updateId').attr('disabled', 'disabled');
								$('#updateId').hide();
							} else {
								alert(sucess);
								document.getElementById("dupEditMessage").style.display = "none";
								$('#updateId').show();
								$('#updateId').removeAttr('disabled');
							}
						},
						error : function(e) {
						}
					});
		    	}else{
		    		return false;
		    	}

	
	/*  alert($("#"+orderId+"qty").text()); */
	/* var tdisc = $("#tdisc").val();
	var tnet = $("#tnet").val();
	var orderId = $("#orderId").text(); */
	
}
function formSave(id){
	

	 var orderId = id;
/* alert(orderId); */
	var conformation= $("#"+id+"conf").val();
	
	
	/* alert(conformation); */
    
    		$.ajax({
				type : "GET",
				url : "vendorOrderConformation.htm",
				dataType:'json',
	            data: "orderId="+orderId+"&conformation="+conformation,
				success : function(response) {
					alert(response);
					if (response != "") {	
						alert(sucess);
						document.getElementById("dupEditMessage").style.display = "block";
						$('#updateId').attr('disabled', 'disabled');
						$('#updateId').hide();
					} else {
						alert(sucess);
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
		<form:form action="" commandName="OrderBean" method="post" id="addForm" cssClass="form-horizontal">
						
						<div class="block">
        						<div class="head-box"><h2><span class="icon2">&nbsp;</span> Order Details </h2>
        						</div>
						<div class="block-box-deptpurchaser purchase-downbox block-box-last-deptpurchaser" id="divheader">
						<ul class="table-list">
						<li class="one-boxxx">Order No
								<ul>
									<li><a class="top" href="#">&nbsp;</a></li>
									<li><a class="bottom" href="#">&nbsp;</a></li>
								</ul></li>
							<li class="two-boxxx">Date
								<ul>
									<li><a class="top" href="#">&nbsp;</a></li>
									<li><a class="bottom" href="#">&nbsp;</a></li>
								</ul></li>
							<li class="two-boxxx">Status
								<ul>
								</ul></li>
							<li class="two-boxxx">Total Quantity
								<ul>
								</ul></li>
							<li class="two-boxxx">Total Discount
								<ul>
								</ul></li>
								<li class="two-boxxx">Total Amount
								<ul>
								</ul></li>
								<li class="two-boxxx">Conformation
								<ul>
								</ul></li>
								<li class="two-boxxx last">Save Status
								<ul>
								</ul></li>
																
						</ul>		
						<div class="table-list-blk purchase-tablelis paginationParentDiv" id="userdata">
						<div id="itemContainer">
						
						<c:choose>
						<c:when test="${not empty OrderList }">
						<c:forEach var="orderList" items="${OrderList }">
						<ul>
						
						<li class="one-boxxx"><a href='javascript:void(0)' id='${orderList.orderId }' onclick='forStockDetails(this.id)' class='ico del colorbox'><c:out value="${fn:substring(orderList.orderId, 1, 8) }"></c:out></a></li>
						<li id='tnorderId' style='display :none;' >${orderList.orderId }</li>
						<%-- <form:input path="orderId" value="${orderList.orderId }" id="oorderId"/> --%> 
						<li class="two-boxxx"  id="${orderList.orderId }date"><c:out value="${orderList.orderDate }"/></li>
						<li class='two-boxxx'  id="${orderList.orderId }status"><c:out value="${orderList.orderStatus }"></c:out></li>
						<li class='two-boxxx' id="${orderList.orderId }qty"><c:out value="${orderList.totalQty }"></c:out></li>
						<li class='two-boxxx' id="${orderList.orderId }disc"><c:out value="${orderList.totalDiscount }"></c:out></li>
						<li class='two-boxxx' id="${orderList.orderId }netAmt"><c:out value="${orderList.totalNetAmount }"></c:out></li>
						<li class='two-boxxx'><form:select path="conformationId" id="${orderList.orderId}conf" cssClass="some-select" tabindex="1" >
											<form:option value="">--Select--</form:option>
											<form:option value="OrderConform">OrderConform</form:option>
											<form:option value="Reject">Reject</form:option>
											<form:option value="Prescription Required">Prescription Required</form:option>
											
											</form:select></li>
						<%-- <li class='two-boxxx last'><a href="orderAssign.htm?orderId='<c:out value="${orderList.orderId }"/>'&vendorId=''">Assign</a></li> --%>
						<li class='two-boxxx last'><a id="${orderList.orderId }" onclick="formSave(this.id)">Save</a></li>
						
						</ul>
						</c:forEach>
						</c:when>
						</c:choose>
						
						</div>
						
							
						</div>				
						<div align="center">
							<h4 id="noSortData" style="display: none">No Data Found</h4>
						</div>
					</div>
					<div class="block-footer">
					  <aside class="block-footer-left"><div id="legend2"  class="savmarup"></div></aside>
						<aside class="block-footer-right">
						<div class="pagenation">
							<div class="holder"></div>
							</div>
						</aside> 
						<aside>
					 </aside>												
				</div>
				</div>				
				</form:form>
				
				<div id="dial" >
				 <form:form commandName="orderBean" action="savePurchaseDetailsAll.htm" method="get">
						<table id='' border='1' class="purchapopup">
						<tr>
						 <th>S.No</th> 
						<th class="purnamewith">Order Id</th>
						<th class="purwith">Medicine Name </th>
						<th class="purwith">Dosage </th> 		
						<th class="purwith">Quantity </th>
						<th>Brand </th>
						<th>TypeId </th>
						<th>MRP </th>
						<th>Discount </th>		
						<th>Net Amount </th></tr>						 
						<c:choose>
							<c:when test="${not empty OrderListOfVendor}">
									<c:forEach var="OrderListOfVendor" items="${OrderListOfVendor}" varStatus="counter">									
										<tr>
											<td> ${counter.count}</td> 								
											<td class="prod-name-boxstret purnamewith">
											<input type="hidden" value="${OrderListOfVendor.orderId }" name="orderId"/>	
											<input type="hidden" value="${OrderListOfVendor.medicineName }" name="${OrderListOfVendor.medicineName }medicineNameId"/>
											<input type="hidden" value="${OrderListOfVendor.quantity }" name="${OrderListOfVendor.quantity}quantityId"/>
											<input type="hidden" value="${OrderListOfVendor.mrp }" name="${OrderListOfVendor.mrp}mrpId"/>
											<%-- <input type="hidden" value="${OrderListOfVendor.discount }" name="${OrderListOfVendor.discount}discountId"/> --%>
											<%-- <input type="hidden" value="${OrderListOfVendor.netAmount }" name="${OrderListOfVendor.netAmount}netAmountId"/>	 --%>					
											<input type="hidden" value="OrderListOfVendor.netAmount" name="OrderListOfVendor.netAmount" id="duplicateId" />
											<label>${OrderListOfVendor.customerName} </label>	
											<tr><td>"+stockObj.orderId+"</td>
								   
								 
								
										  <td id='${OrderListOfVendor.orderId }orderId'>${OrderListOfVendor.orderId }</td>
									 		<td id='${OrderListOfVendor.medicineName }mname'>${OrderListOfVendor.medicineName}</td>
									 		<td id='${OrderListOfVendor.dosage }dosage'>${OrderListOfVendor.dosage }</td>
									 		<td id='${OrderListOfVendor.quantity }quantity'>${OrderListOfVendor.quantity }</td>
									 		<td id='${OrderListOfVendor.brand }brand'>${OrderListOfVendor.brand }</td>
									 		<td id='${OrderListOfVendor.typeId} typeId'>${OrderListOfVendor.typeId }</td>
									 		<td><input type='text' id='${OrderListOfVendor.mrp }mrp' /></td>
									 		 <td><input type='text' id='${OrderListOfVendor.discount }discount' /></td>
									 		<td><input type='text' id='${OrderListOfVendor.netAmount }netAmount' /></td>
									 		  <%-- +"<td>"+"<center>"+stockObj.customerName+"</center>"+"</td>" --%>  
									 		</tr>											
											<%-- <input type="hidden" name="${OrderListOfVendor.mrp}pName" id="${OrderListOfVendor.mrp}mrpspi"
													value="${OrderListOfVendor.mrp}" readonly="readonly"></td> --%>
											<%-- <td class="prod-name-boxstret"></td>
											<td class="prod-name-boxstret"></td>
											<td class="prod-name-boxstret"><input type=text name="${finalorderList.productId}exQuantity"
													value="${finalorderList.existingQuantity}" readonly="readonly"></td>
											<td class="prod-name-boxstret">
											<input type="hidden" value="${finalorderList.purchaseDetailsId }" id="${finalorderList.productId}balpdId">
											<input type="text"
													name="${finalorderList.productId}balance" value="${finalorderList.balance }"  id="${finalorderList.productId}bal" class="numericPop" onclick="getPendingDetails(this.id)" readonly="readonly"></td>				
											<td class="prod-name-boxstret"><input type="text" id="${finalorderList.productId}prices"
													name="${finalorderList.productId}price" value="${finalorderList.price }" class="numericPop" autocomplete="off" onblur="validPrice(this.id)" onkeyup="validPrice(this.id)"></td>
											<td class="prod-name-boxstret"><input type="text" id="${finalorderList.productId}mrps"
													name="${finalorderList.productId}mrp" value="${finalorderList.mrp }" class="numericPop" autocomplete="off" onblur="validMrp(this.id)" onkeyup="validMrp(this.id)"></td>
											<td class="prod-name-boxstret"><input type="text"
													name="${finalorderList.productId}discount" value="${finalorderList.discount }" class="numericPop" autocomplete="off"></td> --%>
										</tr>
									</c:forEach>
							</c:when>
							<c:otherwise>
								<!-- <div class="form">
									<label>There is no records</label>
								</div> -->
							</c:otherwise>
						</c:choose> 
						
						</table>
						<!--  <input class="btn-cancel" name="" value="Cancel" type="button" onclick="return hidePopup()" >
						<input class="btn-save" name="" value="Save" type="button"  onclick="formDetailSubmit()">  -->
				</form:form> 
				<div id="balanceTableDiv"></div>
			</div>
		</div>
		<!-- <div id="dial"></div> -->
		</div>
		</div>
		<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function calculateSum(){
			var counter = $(".textBoxClass").length;
			/* alert(counter); */
				var totalQuantity=0;
				var totalMrp=0;
				var totalDis=0;
				var totalNet
				
				for(var id=1; id<= counter; id++){
					var quantity = $("#"+id+"quantity").text();
					var mrp= $("#"+id+"mrp").val();
					var discount= $("#"+id+"disc").val();
					totalQuantity=totalQuantity+ parseInt(quantity);
					totalMrp=totalMrp+parseInt(mrp);
					totalDis=totalDis+parseInt(discount);
					/* alert(totalQuantity); */
				}
				$("#tquntity").val(totalQuantity);
				
		}
		function calculateTotalm(){
			var counter = $(".textBoxClass").length;
			var totalMrp=0;
			
			/* alert("total.count........"+counter); */
			for(var id=1; id<= counter; id++){
				
				var mrp= $("#"+id+"mrp").val();
				
				if(mrp==null || mrp==""){
					
				}else{
					totalMrp=totalMrp+parseInt(mrp);
				}
			}
			$("#tmrp").val(totalMrp);
			
	
		}
		function calculateTotalD(){
			var counter = $(".textBoxClass").length;
			var totalDis=0;
			
			/* alert("total.count........"+counter); */
			for(var id=1; id<= counter; id++){
				
				var disc= $("#"+id+"disc").val();
				
				if(disc==null || disc==""){
					
				}else{
					totalDis=totalDis+parseInt(disc);
				}
			}
			$("#tdisc").val(totalDis);
		}
		function calculateTotelN(){
			
			var counter = $(".textBoxClass").length;
			var totalNet=0;
			
			/* alert("total.count........"+counter); */
			for(var id=1; id<= counter; id++){
				
				var net= $("#"+id+"net").val();
				
				if(net==null || net==""){
					
				}else{
					totalNet=totalNet+parseFloat(net);
				}
			}
			$("#tnet").val(totalNet);
		}
		</script>
</body>
</html>