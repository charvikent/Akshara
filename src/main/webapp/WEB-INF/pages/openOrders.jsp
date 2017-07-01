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
		$("#ulId").show();
		if (listOrders != null){
			$("#itemContainer ul li").remove();
			$("#itemContainer ul").remove();
			$("#noOrdrs").text("# " + listOrders.length);
			$.each(listOrders, function(i, orderObj) {
				var id='"'+orderObj.orderId+'"';
				if(orderObj.totalPrice == null){
					orderObj.totalPrice =0;
				}
				if(orderObj.customerDiscount == null){
					orderObj.customerDiscount =0;
				}
				if(orderObj.clientlog == null){
					orderObj.clientlog ="";
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
						+"<input type='hidden' id='"+orderObj.orderId+"gid' value='"+orderObj.gid+"' >"
						+"<input type='hidden' id='"+orderObj.orderId+"userId' value='"+orderObj.userId+"' >"
						+"<li class='two-boxxx' style='width:250px;'><textarea id='"+orderObj.orderId+"aurocomment'  name='comment' style='width:250px;'>"+orderObj.clientlog+"</textarea> </li>"
						+ '</ul>';
				$(tblRow).appendTo("#itemContainer");
			});
			paginationTable(18);
		}else{
			//alert('no data to display..');
		}
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
	
	
	function formSubmit(){
		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val();
		var id = 4;
		if( startdate.length == 0 || enddate.length == 0 ){												   
			
	    if(startdate.length == 0 ) {
		    $('#startdate').css('color','red');
		    $("#startdate").css("border-color","red");
		    $("#startdate").attr("placeholder","Please enter start date");
		    $('#startdate').addClass('your-class');
		    }	
	    if(enddate.length == 0 ) {
		    $('#enddate').css('color','red');
		    $("#enddate").css("border-color","red");
		    $("#enddate").attr("placeholder","Please enter end date");
		    $('#enddate').addClass('your-class');
		    }	
		    return false;												  
		    } 
		$.ajax({
			type : "POST",
			url : "datebetweenSearch.json",
			dataType : "json",
			data : {
				startdate : startdate,
				enddate : enddate,
				id :id,
			},
			success : function(response) {
				displayTable(response);
				if(response == null || response =="" ){
					$("#itemContainer ul li").remove();
					$("#itemContainer ul").remove();
				}
			
			}
		});
	}
	
	/* function findTotalAmount(){
		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val();
		$.ajax({
			type : "POST",
			url : "datebetweenTotalAmount.json",
			dataType : "json",
			data : {
				startdate : startdate,
				enddate : enddate,
			},
			success : function(response) {
				$("#tamountId").text("Total Amount :"+response);
				//displayTable(response);
			
			}
		});
	} */
	function status(){
		
		var startdate = $("#startdate").val();
		var enddate = $("#enddate").val();
		$.ajax({
			type : "POST",
			url : "statusopenBetween.json",
			dataType : "json",
			data : {
				startdate : startdate,
				enddate : enddate,
			},
			success : function(response) {
				$("#itemContainer ul li").remove();
				$("#itemContainer ul").remove();
				$.each(response, function(i, orderObj) {
					$("#ulId").hide();
					var tblRow = "<ul>"
							+ "<li class='two-boxxx'>"+orderObj.numberOfOrders+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.statusName+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.userName+"</li>"
							+ '</ul>';
					$(tblRow).appendTo("#itemContainer");
				});
				paginationTable(18);
			
			}
		});
		
		
		
		/* $.ajax({
			type : "POST",
			url : "monthlyAmount.json",
			dataType : "json",
			data : {
			},
			success : function(response) {
				$("#itemContainer ul li").remove();
				$("#itemContainer ul").remove();
				var totalMoney = 0;
				$.each(response, function(i, orderObj) {
					$("#ulId").hide();
					totalMoney = totalMoney + parseInt(orderObj.totalNetAmount);
					var tblRow = "<ul>"
							+ "<li class='two-boxxx'>"+orderObj.month+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.year+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.totalNetAmount+"</li>"
							+ "<li class='two-boxxx'>"+orderObj.totalOrders+"</li>"
							+ '</ul>';
					$(tblRow).appendTo("#itemContainer");
					$("#tamountId").text("Total Amount:"+totalMoney)
				});
				paginationTable(14);
			
			}
		}); */
		
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
							<span> <input class = "buttonproperty " type="button"  value="Status" onclick="status()" tabindex="4"> </span>&nbsp;&nbsp;&nbsp; 
							 <!-- <span><input class = "buttonproperty net_un" type="button"  value="NetAmount" onclick="findTotalAmount()"></span>&nbsp;&nbsp;&nbsp;&nbsp; -->
							<span><input class = "buttonproperty search_un" type="button"  value="Search Orders" onclick="formSubmit()" tabindex="3"></span>
							</div>

						</form:form>
						</div>
				</c:if>


			</div>
		
		
		
			<!--Edit Box End  -->
			<div class="block block_un">
						<div class="head-box">
							<h2>
							<p>Total Orders : <b id='noOrdrs'></b>   <b id='tamountId'></b></p>
							 
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
							<ul class="table-list" style="width:127%;   font-weight: 600;" id="ulId">
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
							</ul>
								<div id="itemContainer" class="itemContainer" style="width: 127%">
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
