<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<script type="text/javascript" src="js/js/csvDownload1.js"></script>
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

	$(document).ready(function(){
		//$("#vendorId").hide();//for hide
		//$("#statusId").hide();//for hide
		var listOrders1 =${allOrders1};
		if(listOrders1 != ""){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			displayTable(listOrders1);
			
		} 
	});
	function displayTable(listOrders){
		$("#ulId").show();
		if (listOrders != null){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			var k = 0;
			$.each(listOrders, function(i, orderObj) {
					//totalMoney = totalMoney + parseInt(orderObj.totalNetAmount);
				if(orderObj.netAmount==null){
					orderObj.netAmount=0.00;
				}

					var tblRow = "<ul>"   
					 + "<li class='two-boxxx'>"+orderObj.clientName+"</li>"
						    + "<li class='two-boxxx'>"+orderObj.weekending+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.orders+"</li>"
							 + "<li class='two-boxxx'>"+orderObj.fixedCharge+"</li>"
							 + "<li class='two-boxxx'>"+orderObj.goodscharge+"</li>"
							 + "<li class='two-boxxx'>"+orderObj.marginvalue+"</li>"
							 + "<li class='two-boxxx'>"+orderObj.vendorCharge+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.netAmount+"</li>"
							+ '</ul>';
					$(tblRow).appendTo("#itemContainer");
					k++;
				});
			$("#totalId").text("total weeks #"+k);
				paginationTable(18);
				
		}else{
			//alert('no data to display..');
		}
	}
</script>

</head>
<body>

	<div class="wrapper">
		<div class="container">
			<!--Edit Box End  -->
			<div class="block">
						<div class="head-box">
							<h2>
							<p> <b id='noOrdrs'></b>   <b id='totalId'></b></p>
							 
								<span class="icon2">&nbsp;</span>Admin Order Details
							</h2>
							<a href="#" class="export" style="color: yellow;">Export Table data into CSV</a>
							<div  id="dupMessage" style="color: red;"></div>
							<div  id="upsus" style="color: green;"></div>
						</div>
						<div
							class="block-box-deptpurchaser purchases-downbox block-box-last-deptpurchaser"
							id="divheader">
							<div class="table-list-blk purchase-tablelist paginationParentDiv itemContainer"
								id="userdata" style="overflow-x: scroll;overflow-y: hidden; ">
							<ul class="table-list" style="width:100%;   font-weight: 600;" id="ulId">
							<li class="two-boxxx">ClientName</li>
							<li class="two-boxxx">Date</li>
							<li class="two-boxxx">Total Orders</li>
							<li class="two-boxxx">Total Fixed Charge</li>
							<li class="two-boxxx">Total Goods Charge</li>
							<li class="two-boxxx">Total Marginvalue</li>
							<li class="two-boxxx">Total Vendor Charge</li>
							<li class="two-boxxx">Total Net Amount</li>
								
							</ul>
								<div id="itemContainer" class="itemContainer" style="width: 100%">
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
</html>
