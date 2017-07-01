<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
.table-list-blk tr td.three-boxxx {
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

	});

	$(document).ready(function(){
		//$("#vendorId").hide();//for hide
		//$("#statusId").hide();//for hide
		var listOrders1 =${allOrders1};
		if(listOrders1 != ""){
			/* $("#itemContainer tr td").remove();
			$("#itemContainer ul").remove(); */
			displayTable(listOrders1);
			
			 
		} 
		
	});
	
	function displayTable(listOrders){
		$("#ulId").show();
		if (listOrders != null){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			$("#noOrdrs").text("# " + listOrders.length);
			var totalAmount = 0;
			var totalOrders = 0;
			$.each(listOrders, function(i, orderObj) {
				if(orderObj.totalNetAmount==null){
					orderObj.totalNetAmount=0.00;
				}
				if(orderObj.avgNetamout==null){
					orderObj.avgNetamout=0.00;
				}
				var tblRow = "<ul>"
					+ "<li class='two-boxxx'>"+orderObj.month+"-"+orderObj.year+"</li>"
					+ "<li class='two-boxxx'>"+orderObj.userName+"</li>"
					+ "<li class='two-boxxx'>"+orderObj.totalOrders+"</li>"
					+ "<li class='two-boxxx'>"+orderObj.totalNetAmount+"</li>"
					+ "<li class='two-boxxx'>"+orderObj.avgNetamout+"</li>"
					+ "<li class='two-boxxx'>"+orderObj.averageOrders+"</li>"
						+ '</ul>';
				$(tblRow).appendTo("#itemContainer");
				if(orderObj.totalNetAmount != null && orderObj.totalNetAmount != ""){
					totalAmount = totalAmount + parseInt(orderObj.totalNetAmount) ;
				}
				totalOrders = totalOrders + parseInt(orderObj.totalOrders);
			});
			$("#totalRevenuId").text(totalAmount);
			$("#totalOrdersId").text(totalOrders);
			paginationTable(11);
		}else{
			//alert('no data to display..');
		}
	}
	
	
	
	
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#serviceId').css("display","none");
		$('#serviceId').multiselect({
		    placeholder: 'Select Services',
		    search: true,
		    selectAll: true,
		});
	});
</script>
<script type="text/javascript">

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
	
	
	function submitForm(){
		var userId="";
		var statusId="";
		var serviceId="";
		var locationId="";
		 var serviceId = [];
	        $(':checkbox:checked').each(function(i){
	        	serviceId[i] = $(this).val();
	        });
		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val();
		 statusId = $("#status").val();
		 userId = $("#userId").val();
		// serviceId = $("#serviceId").val();
		locationId = $("#locationId").val();
		$.ajax({
			type : "POST",
			url : "revenueReportDatebetwen.json",
			data : "serviceId=" + serviceId+"&statusId="+statusId+"&userId="+userId+"&startdate="+startdate+"&enddate="+enddate+"&locationId="+locationId,
				/* {
				startdate : startdate,
				enddate : enddate,
				statusId:statusId,
				userId:userId,
				serviceId:serviceId
			}, */
			success : function(response) {
				displayTable(response);
			
			}
		});
		
	}
	
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
							<span>Revenue Report Details</span>
						</h2>
						<!-- End Box Head -->
						<form:form action="" commandName="revenueReportCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block-box-small orders-topbox block-box-top-header-dept" style="width: 346px;padding: 10px 15px;  height: 451px !important;  overflow-y: scroll;">
								<div class="block-input" style="  margin: 1px 54px 10px 0;   ">
											<label>Service</label>
											  <form:select path="serviceId" style="height:0px; display:none "  multiple="multiple" tabindex="1" onchange="submitForm();">
											<form:options items="${services}"></form:options>
											</form:select> 	</div>
											<div class="block-input">
											<label>Status</label>
											 <form:select path="statusId" style="height:0px;" id="status"  cssClass="some-select" multiple="multiple" onchange="submitForm();" tabindex="2">
											<form:options items="${status}"></form:options>
											</form:select>	</div>
											
										<div class="block-input "> 
											<label>Partner </label>
											<form:select path="userId" id="userId" cssClass="some-select"
												 onchange="submitForm();"  multiple="multiple" tabindex="3">
											<form:option value="">--Select--</form:option>
											<form:options items="${users}"></form:options>	
												
												</form:select>
											</div>
											
											<div class="block-input "> 
											<label>Location </label>
											<form:select path="locationId" id="locationId" cssClass="some-select"
												 onchange="submitForm();"  multiple="multiple" tabindex="4">
											<form:option value="">--Select--</form:option>
											<form:options items="${locations}"></form:options>	
												
												</form:select>
											</div>
											<div class="block-input ">
								<label>Start Date<span style="color: red;">*</span></label> 
									<input  id="startdate" onkeydown="removeBorder(this.id)"  tabindex="5"/>
                               </div>
                               <div class="block-input ">
								<label>End Date<span style="color: red;">*</span></label> 
									<input  id="enddate" onkeydown="removeBorder(this.id)"   tabindex="6"/>
                               </div>
                               <p class="total_revenue">Total Revenue  : <span id ="totalRevenuId"></span></b> </p>
							<p class="total_order">Total Orders   :<span id ="totalOrdersId"></span></p>
											 
							</div>
							<div class="block-footer">
							<span>&nbsp;&nbsp;&nbsp;  <input  type="button"  value="Revenue Report" onclick="submitForm()"> </span>
							</div>
						</form:form>
					</div> 
					</td>
					<td style="  padding-left: 5px;height: 422px !important;">
			<div class="block" style="width: 68%;">
				<form:form action="" commandName="revenueReportCmd" method="post"
					id="addForm" cssClass="form-horizontal">

					
						<div class="head-box" style="width: 796px">
							<h2>
								<span class="icon2">&nbsp;</span>	<a href="#" class="export" style="color: yellow;">Export Table data into Excel</a>
								<span  id="dupMessage" style="color: red;margin-left: 122px;"></span><span  id="upsus" style="color: green;"></span>
							</h2>
							
							
							
							<!-- <div  id="upsus" style="color: green;"></div> -->
						</div>
						<div	class="block-box-deptpurchaser1 purchases-downbox block-box-last-deptpurchaser1"
							id="divheader" style="height:470px !important;   /*width: 503px !important;*/">
							<div class="table-list-blk paginationParentDiv itemContainer"
								id="userdata" style=" overflow-x: scroll;overflow-y: hidden; height:470px !important ;  width: 796px;">
						<ul class="table-list" style="width:320%;  font-weight: 600; ">
								 <li class="two-boxxx">month -year</li>
							    <li class="two-boxxx">userName</li>
							    <li class="two-boxxx">totalOrders</li>
								<li class="two-boxxx">totalNetAmount</li> 
								<li class="two-boxxx">avgNetamout</li>
								<li class="two-boxxx">averageOrders</li> 
							</ul>
								<div id="itemContainer" class="itemContainer"  style="width: 147%">
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
	
	
