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
<title>Customer Orders</title>
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
								
																
						</ul>		
						<div class="table-list-blk purchase-tablelis paginationParentDiv" id="userdata">
						<div id="itemContainer">
						
						<c:choose>
						<c:when test="${not empty OrderList }">
						<c:forEach var="orderList" items="${OrderList }">
						<ul>
						<%-- <li class="one-boxxx"><a href='javascript:void(0)' id='${orderList.orderId }' onclick='forStockDetails(this.id)' class='ico del colorbox'><c:out value="${orderList.orderId }"></c:out></a></li> --%>
						<li class="two-boxxx"  id="${orderList.orderId }date"><c:out value="${orderList.orderDate }"/></li>
						<li class='two-boxxx'  id="${orderList.orderId }status"><c:out value="${orderList.orderStatus }"></c:out></li>
						<li class='two-boxxx' id="${orderList.orderId }qty"><c:out value="${orderList.totalQty }"></c:out></li>
						<li class='two-boxxx' id="${orderList.orderId }disc"><c:out value="${orderList.totalDiscount }"></c:out></li>
						<li class='two-boxxx' id="${orderList.orderId }netAmt"><c:out value="${orderList.totalNetAmount }"></c:out></li>
						</ul>
						</c:forEach>
						</c:when>
						</c:choose>
						
						</div>
						
							
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
				
				
		</div>
		
		</div>
		</div>
</body>
</html>