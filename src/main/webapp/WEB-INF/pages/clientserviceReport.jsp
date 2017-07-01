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
		$("#startdate").datepicker({
			changeDate : true,
			changeMonth : true,
			changeYear : true,
			showButtonPanel : false,
			dateFormat : 'yy-mm-dd'
		});

	});
	$(function() {
		$("#enddate").datepicker({
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
			
		} 
	});
	function displayTable(listOrders){
		$("#ulId").show();
		if (listOrders != null){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			var m =0;
			var dummybookeddate = null;
			var total=0;
			$.each(listOrders, function(i, orderObj) {
					//totalMoney = totalMoney + parseInt(orderObj.totalNetAmount);
				if(orderObj.totalNetAmount==null){
					orderObj.totalNetAmount=0.00;
				}
				if(i==0){
					 total=total+parseInt(orderObj.totalOrders);
				 }
				if(i != 0){
				if(dummybookeddate ==  orderObj.bookedDate){
					total=total+parseInt(orderObj.totalOrders);
				}else{
					tblRow= "<ul>"
						+ "<li  class='two-boxxxxxx' style='background-color: #009899;width: 342px;'>Total</li>"
						  + "<li class='two-boxxx'style='background-color: #009899;'>"+total+"</li>"
							+ '</ul>';
					$(tblRow).appendTo("#itemContainer");
					total = 0;
					total=total+parseInt(orderObj.totalOrders);
				}
				}
					var tblRow = "<ul>"
							+ "<li class='two-boxxx'>"+orderObj.userName+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.serviceName+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.bookedDate+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.totalOrders+"</li>"
							+ '</ul>';
					$(tblRow).appendTo("#itemContainer");
					m++;
					dummybookeddate=orderObj.bookedDate;
					//$("#tamountId").text("Total Amount:"+totalMoney)
				});
				$("#totalId").text("Total months #"+m)
				tblRow= "<ul>"
							+ "<li  class='two-boxxxxxx' style='background-color: #009899; width: 342px;'>Total</li>"
							  + "<li class='two-boxxx' style='background-color: #009899;'>"+total+"</li>"
								+ '</ul>';
						$(tblRow).appendTo("#itemContainer");
						total = 0;
				paginationTable(18);
		}else{
			//alert('no data to display..');
		}
	}
	function formSubmit(){
		var startdate = $("#startdate").val();
		var enddate=$('#enddate').val();
		$.ajax({
			type : "POST",
			url : "ServiceReportFilter.json",
			dataType : "json",
			data : {
				startdate : startdate,
				enddate :enddate,
			},
			success : function(response) {
				alert(response);
				displayTable(response);
				if(response == null || response =="" ){
					$("#itemContainer ul li").remove();
					$("#itemContainer ul").remove();
				}
			
			}
		});
	}
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
								onclick='addPack()'> Filter Data</a>
							<!-- <div class="block-footer-right1 fail">
								

							</div> -->
						</h2>
						<!-- End Box Head -->
						<form:form action="" commandName="packCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small package-topbox block-box-top-header-dept" style= "height: 50px !important" >
                               
                               <div class="block-input ">
								<label>Start Date<span style="color: red;">*</span></label> 
									<input  id="startdate" onkeydown="removeBorder(this.id)"  tabindex="1"/>
                               </div>
                               <div class="block-input ">
								<label>End Date<span style="color: red;">*</span></label> 
									<input  id="enddate" onkeydown="removeBorder(this.id)"   tabindex="2"/>
                               </div>
                              
							</div>
							<div class="block-footer">
							<!-- <span> <input class = "buttonproperty " type="button"  value="Status" onclick="status()" tabindex="4"> </span>&nbsp;&nbsp;&nbsp; --> 
							<!--  <span><input class = "buttonproperty net_un" type="button"  value="NetAmount" onclick="findTotalAmount()"></span>&nbsp;&nbsp;&nbsp;&nbsp; -->
							<span><input class = "buttonproperty search_un" type="button"  value="Search Orders" onclick="formSubmit()" tabindex="3"></span>
							</div>

						</form:form>
						</div>
				</c:if>


			</div>
			<!--Edit Box End  -->
			<div class="block">
						<div class="head-box">
							<h2>
							<p> <b id='noOrdrs'></b>   <b id='totalId'></b></p>
							 
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
							<ul class="table-list" style="width:127%;   font-weight: 600;" id="ulId">
								<li class="two-boxxx">Client</li>
								<li class="two-boxxx">Service Name</li>
								<li class="two-boxxx">Day</li>
								<li class="two-boxxx">Total Orders</li>
								
							</ul>
								<div id="itemContainer" style="width: 127%">
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
