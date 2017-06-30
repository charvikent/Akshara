<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
$(document).ready(function(){
	  /* chosenDropDown();   */
});
function forStockDetails(id) {
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
							 		+"<th>Medicine Name </th>"
							 		+"<th>Dosage </th>"
							 		+"<th>Quantity </th>"
							 		+"<th>Brand </th>"
							 		+"<th>TypeId </th>"	
							 		+"<th>Mrp </th>"	
							 		+"<th>Discount </th>"	
							 		+"<th>Net Amount </th>"
							 		+"</table>";
						$(stockInformation1).appendTo("#dial");
							 $.each(productHisInfo,function(i, stockObj) {
								 popuptitle=stockObj.customerName;
								 var stockInformation2 ="<tr><td>"+stockObj.orderId+"</td>"
								   
								 /* if(stockObj.discount==null){
									 +"<td>"+"<center>"+stockObj.discount=='""'+"</center>"+"</td>";
								 } */
											 +"<td>"+"<center>"+stockObj.medicineName+"</center>"+"</td>"
									 		+"<td>"+"<center>"+stockObj.dosage+"</center>"+"</td>"
									 		+"<td>"+"<center>"+stockObj.quantity+"</center>"+"</td>"
									 		+"<td>"+"<center>"+stockObj.brand+"</center>"+"</td>"
									 		+"<td>"+"<center>"+stockObj.typeId+"</center>"+"</td>"
									 		+"<td>"+"<center>"+stockObj.mrp+"</center>"+"</td>"
									 		+"<td>"+"<center>"+stockObj.discount+"</center>"+"</td>"
									 		+"<td>"+"<center>"+stockObj.netAmount+"</center>"+"</td>"
									 		/*  +"<td>"+"<center>"+stockObj.customerName+"</center>"+"</td>" */ 
									 		+"</tr>";
								 $(stockInformation2).appendTo("#stockInformationTable");
								
							}); 	 		
							 $('#dial').dialog({width:799,title:popuptitle,modal: true}).dialog('open');
						}   
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
	
	}

function formSubmit(){
	var id = $("#hiddenId").val();
	var date = $("#"+id+"date").text();
	alert("date"+date);
	var status = $("#"+id+"status").text();
	var qty = $("#"+id+"qty").text();
	var amount = $("#"+id+"netAmt").text();
	var disc = $("#"+id+"disc").text();
	var vendorId =  $("#"+id+"vendor").val();
	$.ajax({
		type : "GET",
		url : "assignToVendor.htm",
		data:"vendorId="+vendorId+"&orderId="+id+"&orderDate="+date+"&orderStatus="+status+"&quantity="+qty+"&netAmount="+amount+"&discount="+disc,
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

</script> -->
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
		<form:form action="" commandName="OrderTrackingBean" method="post" id="addForm" cssClass="form-horizontal">
						
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
							<li class="one-boxxx">Date
								<ul>
									<li><a class="top" href="#">&nbsp;</a></li>
									<li><a class="bottom" href="#">&nbsp;</a></li>
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
								<li class="one-boxxx last">Status
								<ul>
								</ul></li>
								
																
						</ul>		
						<div class="table-list-blk purchase-tablelis paginationParentDiv" id="userdata">
						<div id="itemContainer">
						 <c:choose>
						<c:when test="${not empty OrderTrakingList }">
						<c:forEach var="OrderTrakingList" items="${OrderTrakingList }">
					<ul> 	<li class="one-boxxx"><a href='javascript:void(0)' id='${OrderTrakingList.orderId }' onclick='forStockDetails(this.id)' class='ico del colorbox'><c:out value="${OrderTrakingList.orderId }"></c:out></a></li>
						<li class="one-boxxx"  id="${OrderTrakingList.orderId }date"><c:out value="${OrderTrakingList.updatedDate }"/></li>
						<li class='two-boxxx' id="${OrderTrakingList.orderId }qty"><c:out value="${OrderTrakingList.totalQty }"></c:out></li>
						<li class='two-boxxx' id="${OrderTrakingList.orderId }disc"><c:out value="${OrderTrakingList.totalDiscount }"></c:out></li>
						<li class='two-boxxx' id="${OrderTrakingList.orderId }netAmt"><c:out value="${OrderTrakingList.totalNetAmount }"></c:out></li>
						<li class='one-boxxx last'  id="${OrderTrakingList.orderId }status"><c:out value="${OrderTrakingList.statusId }"></c:out></li>
						
						
						<form:hidden path="orderId" value="${OrderTrakingList.orderId }" id="hiddenId"/>
						
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
				
				<%-- <div id="dial" >
				 <form:form commandName="orderBean" action="savePurchaseDetailsAll.htm" method="get">
						<table id='' border='1' class="purchapopup">
						<tr>
						 <th>S.No</th> 
						<th class="purnamewith">Product Name</th>
						<th class="purwith">Ordered Quantity </th>
						<th class="purwith">Received Quantity </th> 		
						<th class="purwith">Existing Quantity </th>
						<th>Pending </th>
						<th>Price </th>
						<th>MRP </th>
						<th>Discount </th></tr>							 
						<c:choose>
							<c:when test="${not empty finalOrderList}">
									<c:forEach var="finalorderList" items="${finalOrderList}" varStatus="counter">									
										<tr>
											<td> ${counter.count}</td> 								
											<td class="prod-name-boxstret purnamewith">
											<input type="hidden" value="${finalorderList.purchaseOrderId }" name="purId"/>	
											<input type="hidden" value="${finalorderList.purchaseDetailsId }" name="${finalorderList.productId}pdId"/>
											<input type="hidden" value="${finalorderList.purchaseId }" name="${finalorderList.productId}pId"/>
											<input type="hidden" value="${finalorderList.recievedQuantity }" name="${finalorderList.productId}prerecqty"/>
											<input type="hidden" value="${finalorderList.purchaseCode }" name="${finalorderList.productId}pcode"/>
											<input type="hidden" value="${finalorderList.purchaseDetailsCode }" name="${finalorderList.productId}pdcode"/>						
											<input type="hidden" value="" name="" id="duplicateId" />
											<label>${finalorderList.category} ${finalorderList.subcategory} ${finalorderList.productName}</label>												
											<input type="hidden" name="${finalorderList.productId}pName" id="${finalorderList.productId}mrpspi"
													value="${finalorderList.category} ${finalorderList.subcategory} ${finalorderList.productName}" readonly="readonly"></td>
											<td class="prod-name-boxstret"><input type=text name="${finalorderList.productId}ordQuantity" id="${finalorderList.productId}oq"
													value="${finalorderList.orderedQuantity}" readonly="readonly"></td>
											<td class="prod-name-boxstret"><input type="text" class="numericPop numericRecQuantity"
													name="${finalorderList.productId}recQuantity" id="${finalorderList.productId}" autocomplete="off" onblur="testSave(this.id);focusMrp(this.id);" onkeypress="testSave(this.id);" onkeydown="testSave(this.id);" onkeyup="testSave(this.id);"></td>
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
													name="${finalorderList.productId}discount" value="${finalorderList.discount }" class="numericPop" autocomplete="off"></td>
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
						<!-- <input class="btn-cancel" name="" value="Cancel" type="button" onclick="return hidePopup()" >
						<input class="btn-save" name="" value="Save" type="submit" id="popupSubmitId"> -->
				</form:form> 
				<div id="balanceTableDiv"></div>
			</div> --%>
		</div>
		
		</div>
		</div>
</body>
</html>