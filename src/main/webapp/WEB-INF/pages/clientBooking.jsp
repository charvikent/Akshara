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
			
.hide{

visibility: hidden

}
/* input {
    text-align:right;
} */
</style>
<script type="text/javascript">
$(document).ready(function() {
	chosenDropDown(); 
	$("#orderBooking").hide();
	$("#vendorstatus").hide();
	$("#statusId").hide();
	var statusNames;
	$("#timeslotDate").hide();
});
var orderId = 0;
$(document).ready(function(){
	//$("#vendorId").hide();//for hide
	//$("#statusId").hide();//for hide
	var listOrders1 =${allOrders1};
	if(listOrders1 != ""){
		$("#itemContainer ul li").remove();
		$("#itemContainer ul").remove();
		displayTable(listOrders1);
		$("#allOrders").hide();	
		$("#orderBooking").show();
		
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
	//var vendorDropDown = $("#vendorId").html();
	//var statusDrop= $("#statusId").html();
	//var timeSlotDrop = $("#timeSlotId").html();
	
	if (listOrders != null){
		$("#itemContainer ul li").remove();
		$("#itemContainer ul").remove();
		
		serviceUnitArray = {};
		var rowcount = 0;
		$.each(listOrders, function(i, orderObj) {
			if(orderObj.locationId == orderObj.vendorcity){
				 rowcount ++;
			serviceUnitArray[orderObj.gid] = orderObj;
			var id='"'+orderObj.orderId+'"';
			if(orderObj.totalPrice == null){
				orderObj.totalPrice =0;
			}
			
			if(orderObj.clientlog == null){
				orderObj.clientlog ="";
			}
			if(orderObj.aurolog == "null" || orderObj.aurolog == null){
				orderObj.aurolog ="";
			}
			
			
			
			var tblRow = "<ul>"
				+"<input type='hidden' id='appDate"+i+"' value='"+orderObj.appointmentDate+"'/>"
				+"<li><input class='checkboxedit' type='checkbox' style='width: 21px;' value='"+orderObj.gid+"' ></li>"
					+ "<li class='two-boxxx'><a  id='"+orderObj.orderId+"' style='font-color:red'>"+orderObj.orderId+"</a></li>"
					+ "<li class='two-boxxx'>"+orderObj.locationName+"</li>"
					+"<li class='two-boxxx'><select  id='"+orderObj.orderId+"service'"+" ></select>"+"</li>"
					+"<li class='two-boxxx'><input class ='bookeddate' id='"+orderObj.orderId+"date' value='"+orderObj.bookedDate+"' onclick='$('#"+orderObj.orderId+"date').datepicker();$('#"+orderObj.orderId+"date').datepicker('show');'></li>"
					+"<li class='two-boxxx'><input class ='appoinmentdate' id='"+orderObj.orderId+"apdate' value='"+orderObj.appointmentDate+"' onclick='$('#"+orderObj.orderId+"apdate').datepicker();$('#"+orderObj.orderId+"apdate').datepicker('show');' ></li>"
					+"<li class='two-boxxx'><select  name='timeSlotNameId' id='"+orderObj.orderId+"timeId'"+" ></select>"+"</li>"
					+"<li class='two-boxxx'><input id='"+orderObj.orderId+"phoneNo' value='"+orderObj.contactNo+"'></li>"
					+"<li class='two-boxxx'><input id='"+orderObj.orderId+"email' value='"+orderObj.contactEmail+"' ></li>"
					+"<li class='two-boxxx'><select  id='"+orderObj.orderId+"status'"+" ></select>"+"</li>"
					+"<input type='hidden' id='"+orderObj.orderId+"gid' value='"+orderObj.gid+"' >"
					+"<input type='hidden' id='"+orderObj.orderId+"userId' value='"+orderObj.userId+"' >"
					+"<li class='two-boxxx' style='width:250px;'><textarea id='"+orderObj.orderId+"clientcomment'  name='comment' style='width:250px;'>"+orderObj.clientlog+"</textarea> </li>"
					+"<li class='two-boxxx' style='width:250px;'><textarea id='"+orderObj.orderId+"aurocomment' disabled name='comment' style='width:250px;'>"+orderObj.aurolog+"</textarea> </li>"
					+ '</ul>';
			$(tblRow).appendTo("#itemContainer");
			$("#"+orderObj.orderId+"timeId").append("<option value=''>--select--</option>");
			$("#"+orderObj.orderId+"timeId").append("<option value='1'>morning</option>");
			$("#"+orderObj.orderId+"timeId").append("<option value='2'>afternoon</option>");
			$("#"+orderObj.orderId+"timeId").append("<option value='3'>evening</option>");
			$("#"+orderObj.orderId+"timeId").val(orderObj.timeSlotId);
			var status = $("#statusId").html();
			$("#"+orderObj.orderId+"status").html(status);
			$("#"+orderObj.orderId+"status").val(orderObj.statusId);
			
			var services = $("#serviceId").html();
			$("#"+orderObj.orderId+"service").html(services);
			$("#"+orderObj.orderId+"service").val(orderObj.serviceId);
		}
		});
		$("#noOrdrs").text("# " + rowcount);
		paginationTable(11);
	}else{
		//alert('no data to display..');
	}
}
function selectOrders(){
	 $.blockUI({ message: 'Please Wait' });
	 var serviceId = $("#serviceId").val();
	// alert(serviceId);
	 var phoneNumberId = $("#phoneNumId").val();
	 var emailId = $("#emailId").val();
	 var orderid = $("#searchOrderId").val();
	 var statid = $("#status").val();
	 var clientId = $("#clientId").val();
	 var startDate = $("#startDate").val();
	 var endDate = $("#endDate").val();
	$("#itemContainer ul").remove();
	$("#itemContainer ul li").remove(); 
	$("#vendorId").hide();//for hide
	$("#statusId").hide();//for hide
	$("#allOrders").show();	
	$("#orderBooking").hide();	
	 $.ajax({
			type : "POST",
			url : "getServiceOrders.json",
			data : "serviceId=" + serviceId+"&phoneNo="+phoneNumberId +"&emailId="+emailId+"&orderId="+orderid+"&statusId="+statid+"&clientId="+clientId+"&startDate="+startDate+"&endDate="+endDate,
			dataType : "json", 
			success : function(response) {
				/* alert(response); */
				$.unblockUI(); 
				if(response != ""){
					$("#itemContainer ul li").remove();
					$("#itemContainer ul").remove();
					displayTable(response);
				}
				//resetStatus(serviceId);
				//resetVendor(serviceId);
				
			},
			error : function(e) {
			}
		});
}
$(function() {  
	$("#startDate").datepicker({
		changeDate : true,
		changeMonth : true,
		changeYear : true,
		showButtonPanel : false,
		dateFormat : 'yy-mm-dd'
	});

});
$(function() {
	$("#endDate").datepicker({
		changeDate : true,
		changeMonth : true,
		changeYear : true,
		showButtonPanel : false,
		dateFormat : 'yy-mm-dd'
	});

});
$(function() {
	$(".appoinmentdate").datepicker({
		changeDate : true,
		changeMonth : true,
		changeYear : true,
		showButtonPanel : false,
		dateFormat : 'yy-mm-dd'
	});

});
$(function() {
	$(".bookeddate").datepicker({
		changeDate : true,
		changeMonth : true,
		changeYear : true,
		showButtonPanel : false,
		dateFormat : 'yy-mm-dd'
	});

});
 function newOrder(){
/* $('#neworderId').click(function(){ */
	$("#headerdId").text("New Order");
$("#allOrders").hide();	
$("#orderBooking").show();
$('#phoneNumIdOrder').val("");
$('#addressId').val("");
$('#emailIdOrder').val("");
$('#userId1').trigger("chosen:updated");
$('#scheduledateId').val("");
$('#bookedDateId').val("");
$('#timeId').val("");
$('#timeId').trigger("chosen:updated");
$('#cname').val("");
$('#sdiscription').val("");
$('#wlocationId').val("");
$('#couponcodeId').val("");
$("#bhkid").val("");
$("#clientIdOrder").val("");
$("#completionDateId").val("");
$("#ownernameId").val("");
$("#clientCommentsId").val("");

$("#billingId").trigger("chosen:updated");

$("#serviceIdOrder").val("");
$("#orderIdHeaderDisplay").hide();

orderId =0;
$("#logsDisplayId").hide();
               
}
function editOrder(){
	 var id = $('input:checkbox:checked').val();
	 if ($('.checkboxedit').is(':checked')) {
	$("#headerdId").text("Edit");
	$("#allOrders").hide();	
	$("#orderBooking").show();
	/* var matches = [];
	$(".checkboxedit:checked").each(function() {
	    matches.push(this.value);
	});
	 */
	$('#phoneNumIdOrder').val( serviceUnitArray[id].customerMobile);
	$('#addressId').val( serviceUnitArray[id].customerAddress);
	$('#emailIdOrder').val( serviceUnitArray[id].contactEmail);
	var service = eval(serviceUnitArray[id].serviceId)
	$('#serviceIdOrder').val(service);
	 $('#serviceIdOrder').trigger("chosen:updated");
	$('#userId1').val( eval(serviceUnitArray[id].userId));
	$('#userId1').trigger("chosen:updated");
	$('#scheduledateId').val( serviceUnitArray[id].appointmentDate);
	$('#bookedDateId').val( serviceUnitArray[id].bookedDate);
	var timeslot = eval(serviceUnitArray[id].timeSlotId)
	$('#timeId').val( timeslot);
	$('#timeId').trigger("chosen:updated");
	$('#cname').val( serviceUnitArray[id].customerName);
	$('#sdiscription').val( serviceUnitArray[id].orderDescription);
	$('#wlocationId').val( serviceUnitArray[id].customerMobile);
	$("#locationNameId").val(serviceUnitArray[id].locationId);
	$('#locationNameId').trigger("chosen:updated");
	$('#couponcodeId').val( serviceUnitArray[id].couponcode);
	var ownername  = serviceUnitArray[id].ownername;
	if(ownername != null || ownername !=""){
		$("#ownernameId").val(serviceUnitArray[id].ownername);
	}
	var clientId  = serviceUnitArray[id].clientId;
	if(clientId != null || clientId !=""){
		$("#clientIdOrder").val(serviceUnitArray[id].clientId);
	}
	var completionDate  = serviceUnitArray[id].completionDate;
	if(completionDate != null || completionDate !=""){
		$("#completionDateId").val(serviceUnitArray[id].completionDate);
	}
	var watsuplocation = serviceUnitArray[id].watsuplocation;
	if(watsuplocation != null || watsuplocation !=""){
		$("#wlocationId").val(serviceUnitArray[id].watsuplocation);
	}
	$("#locationNameId").val(serviceUnitArray[id].locationId);
	$('#locationNameId').trigger("chosen:updated");
	var billingto  = serviceUnitArray[id].billingto;
	if(billingto != null && billingto !=""){
		$("#billingId").val(serviceUnitArray[id].billingto);
	}
	var nobhk  = serviceUnitArray[id].nobhk;
	if(nobhk != null || nobhk !=""){
		$("#bhkid").val(serviceUnitArray[id].nobhk);
	}
	var clientlog  = serviceUnitArray[id].clientlog;
	if(clientlog != null || clientlog !=""){
		$("#clientCommentsId").val(serviceUnitArray[id].clientlog);
	}
	orderId = id;
	 }else{
		 alert("please select check box");
	 }
	 $("#orderIdHeaderDisplay").text(serviceUnitArray[id].orderId);
	 logs(id);

}
function  cloneOrder() {
	
	/* var matches = [];
	$(".checkboxedit:checked").each(function() {
	    matches.push(this.value);
	}); */
	var id = $('input:checkbox:checked').val();
	if ($('.checkboxedit').is(':checked')) {		 
		 $("#headerdId").text("Clone");
			$("#allOrders").hide();	
			$("#orderBooking").show(); 
	$('#phoneNumIdOrder').val( serviceUnitArray[id].customerMobile);
	$('#addressId').val( serviceUnitArray[id].customerAddress);
	$('#emailIdOrder').val( serviceUnitArray[id].contactEmail);
	var service = eval(serviceUnitArray[id].serviceId)
	$('#serviceIdOrder').val(service);
	 $('#serviceIdOrder').trigger("chosen:updated");
	$('#userId1').val( eval(serviceUnitArray[id].userId));
	$('#userId1').trigger("chosen:updated");
	$('#scheduledateId').val( serviceUnitArray[id].appointmentDate);
	$('#bookedDateId').val( serviceUnitArray[id].bookedDate);
	var timeslot = eval(serviceUnitArray[id].timeSlotId)
	$('#timeId').val( timeslot);
	$('#timeId').trigger("chosen:updated");
	var billingto  = serviceUnitArray[id].billingto;
	if(billingto != null && billingto !=""){
		$("#billingId").val(serviceUnitArray[id].billingto);
	}
	$('#billingId').trigger("chosen:updated");
	var completionDate  = serviceUnitArray[id].completionDate;
	if(completionDate != null || completionDate !=""){
		$("#completionDateId").val(serviceUnitArray[id].completionDate);
	}
	var nobhk  = serviceUnitArray[id].nobhk;
	if(nobhk != null || nobhk !=""){
		$("#bhkid").val(serviceUnitArray[id].nobhk);
	}
	var ownername  = serviceUnitArray[id].ownername;
	if(ownername != null || ownername !=""){
		$("#ownernameId").val(serviceUnitArray[id].ownername);
	}
	$('#cname').val( serviceUnitArray[id].customerName);
	$('#sdiscription').val( serviceUnitArray[id].orderDescription);
	$('#wlocationId').val( serviceUnitArray[id].customerMobile);
	$('#couponcodeId').val( serviceUnitArray[id].couponcode);
	var clientId  = serviceUnitArray[id].clientId;
	if(clientId != null || clientId !=""){
		$("#clientIdOrder").val(serviceUnitArray[id].clientId);
	}
	var clientlog  = serviceUnitArray[id].clientlog;
	if(clientlog != null || clientlog !=""){
		$("#clientCommentsId").val(serviceUnitArray[id].clientlog);
	}
	var watsuplocation = serviceUnitArray[id].watsuplocation;
	if(watsuplocation != null || watsuplocation !=""){
		$("#wlocationId").val(serviceUnitArray[id].watsuplocation);
	}
	orderId = 0;
	}else{
		alert("please select check box");
	}
	 $("#orderIdHeaderDisplay").text(serviceUnitArray[id].orderId);
	 logs(id);
}
function logs(id){
	$("#logsDisplayId").show();
	 var orderId = serviceUnitArray[id].orderId;
	 $.ajax({
			type : "POST",
			url : "logsDetails.json",
			dataType : "json",
			data : {
				orderId : orderId,
			},
			success : function(response) {
				//alert(response);	
				$.each(response,function(i, stockObj) {
					 var logsData = stockObj.listClientOrder;
					 if(logsData != null && logsData != ""){
						 var desc = '';
						  $.each(logsData,function(ind,logObj){
							  if(desc == ""){
								  
								}else{
									desc = desc + "<br>";
									}
								desc = desc + new Date(logObj.updatedTime).toUTCString()+" : "+logObj.clientLog;
									}); 
							  stockObj.clientLog = desc;
							  $("#clientlogId").text(stockObj.clientLog);
					 } else{
						 stockObj.clientLog = 'Logs not available';
						 $("#clientlogId").text(stockObj.clientLog);
					 }
					 
					 var logsData1 = stockObj.listAuroOrder;
					 if(logsData1 != null && logsData1 != ""){
						 var desc1 = '';
						  $.each(logsData1,function(ind,logObj){
							  if(desc1 == ""){
								  
								}else{
									desc1 = desc1 + "<br>";
									}
								desc1 = desc1 + new Date(logObj.updatedTime).toUTCString()+" : "+logObj.auroLog;
									}); 
							  stockObj.auroLog = desc1;
							  $("#aurologId").text(stockObj.auroLog);
					 } else{
						 stockObj.auroLog = 'Logs not available';
						 $("#aurologId").text(stockObj.auroLog);
					 }
					 
					 
				});
			},
			error : function(e) {
			}
		});
}
$(function() {
	$("#scheduledateId").datepicker({
		changeDate : true,
		changeMonth : true,
		changeYear : true,
		showButtonPanel : false,
		dateFormat : 'yy-mm-dd'
	});

});
  $(function() {
		$("#completionDateId").datepicker({
			changeDate : true,
			changeMonth : true,
			changeYear : true,
			showButtonPanel : false,
			dateFormat : 'yy-mm-dd'
		});

	});
	  $(function() {
			$("#bookedDateId").datepicker({
				changeDate : true,
				changeMonth : true,
				changeYear : true,
				showButtonPanel : false,
				dateFormat : 'yy-mm-dd'
			});

		});
function submitForm() {
	
	var contactNumber = $('#phoneNumIdOrder').val();
	var contactAddress = $('#addressId').val();
	var emailId = $('#emailIdOrder').val(); 
	var serviceId = $('#serviceIdOrder').val();
	serviceId = JSON.stringify(serviceId);
	var locationId = $('#locationNameId').val();
	var userId1 = $("#userId1").val();
	var scheduledateId = $('#scheduledateId').val();
	var bookedDateId =$("#bookedDateId").val()
	var timeId = $('#timeId').val();
	var clientOrderId = $('#clientIdOrder').val();
	var cname = $('#cname').val();
	var sdiscription = $('#sdiscription').val();
	var wlocationId =$('#wlocationId').val();
	var couponcodeId = $('#couponcodeId').val();
	var ownernameId=$('#ownernameId').val();
	var bhkid=$('#bhkid').val();
	var clientCommentsId=$('#clientCommentsId').val();
	var completionDateId=$('#completionDateId').val();
	var billingId=$('#billingId').val();
	var admin = true;
	if(userId1.length == 0 || contactNumber.length == 0 || contactAddress.length == 0 || serviceId == "null" || scheduledateId.length == 0 || bookedDateId.length == 0 || timeId.length == 0 || locationId.length==0){												   
		if(userId1.length == 0 ) {
	    	$('#userId1').css('color','red');
			$("#userId1_chosen").find('.chosen-single').css("border","1px solid red");
			$("#userId1").css("border-color","red");
			$('#userId1').addClass('your-class');
		    }
		 if(contactNumber.length == 0 ) {
	    $('#phoneNumIdOrder').css('color','red');
	    $("#phoneNumIdOrder").css("border-color","red");
	    $("#phoneNumIdOrder").attr("placeholder","Please enter phone number");
	    $('#phoneNumIdOrder').addClass('your-class');
	    }
		  if(contactAddress.length == 0 ) {
	    $('#addressId').css('color','red');
	    $("#addressId").css("border-color","red");
	    $("#addressId").attr("placeholder","Please enter address");
	    $('#addressId').addClass('your-class');
	    }	
		 if(serviceId == "null") {
    	$('#serviceIdOrder').css('color','red');
		//$("#serviceIdOrder_chosen").find('.chosen-single').css("border","1px solid red");
		$("#serviceIdOrder").css("border-color","red");
		$('#serviceIdOrder').addClass('your-class');
	    }
    if(scheduledateId.length == 0 ) {
	    $('#scheduledateId').css('color','red');
	    $("#scheduledateId").css("border-color","red");
	    $("#scheduledateId").attr("placeholder","Please enter date");
	    $('#scheduledateId').addClass('your-class');
	    }
    if(bookedDateId.length == 0 ) {
	    $('#bookedDateId').css('color','red');
	    $("#bookedDateId").css("border-color","red");
	    $("#bookedDateId").attr("placeholder","Please enter date");
	    $('#bookedDateId').addClass('your-class');
	    }
    if(timeId.length == 0 ) {
    	$('#timeId').css('color','red');
		$("#timeId_chosen").find('.chosen-single').css("border","1px solid red");
		$("#timeId").css("border-color","red");
		$('#timeId').addClass('your-class');
	    }	
    if(locationId.length==0 ) {
    	$('#locationNameId').css('color','red');
		$("#locationNameId_chosen").find('.chosen-single').css("border","1px solid red");
		$("#locationNameId").css("border-color","red");
		$('#locationNameId').addClass('your-class');
	    }
   
		    return false;												  
	    } 
	$.blockUI({ message: 'Please Wait' });
	$.ajax({
		type : "POST",
		url : "clientBooking1.htm",
		data : {
			bookedDateId : bookedDateId,
			contactNumber : contactNumber,
			contactAddress : contactAddress,
			timeId : timeId,
			emailId : emailId,
			serviceId : serviceId,
			locationId : locationId,
			couponcodeId : couponcodeId,
			admin : admin,
			clientOrderId:clientOrderId,
			cname:cname,
			sdiscription:sdiscription,
			wlocationId:wlocationId,
			userId1:userId1,
			scheduledateId:scheduledateId,
			orderId:orderId,
			ownernameId:ownernameId,
			bhkid:bhkid,
			clientCommentsId:clientCommentsId,
			completionDateId:completionDateId,
			billingId:billingId,
			
			
		},
		success : function(response) {
			$.unblockUI(); 

			alert(response);	
			document.location.reload();

			

		},
		error : function(e) {
		}
	});
}
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#blah')
                .attr('src', e.target.result)
                .width(100)
                .height(100);
        };

        reader.readAsDataURL(input.files[0]);
    }
} 

function onlyNos(e, t) {
    try {
        if (window.event) {
            var charCode = window.event.keyCode;
        }
        else if (e) {
            var charCode = e.which;
        }
        else { return true; }
        if (charCode > 31 && (charCode<42||charCode>57)) {
            return false;
        }
        return true;
    }
    catch (err) {
        alert(err.Description);
    }
}
function updateOrder(){
	var id = $('input:checkbox:checked').val();
	if ($('.checkboxedit').is(':checked')) {
	var generateId = serviceUnitArray[id].orderId;
	var serviceId = $("#"+generateId+"service").val();
	var bookeddate =$("#"+generateId+"date").val();
	var appointmentDate =$("#"+generateId+"apdate").val();
	var stime =$("#"+generateId+"timeId").val();
	var phoneNo =$("#"+generateId+"phoneNo").val();
	var email =$("#"+generateId+"email").val();
	var status =$("#"+generateId+"status").val();
	var clientcomment =$("#"+generateId+"clientcomment").val();
	$.ajax({
		type : "POST",
		url : "clientUpdateStatus.htm",
		data : {
			id:id,
			serviceId:serviceId,
			bookeddate:bookeddate,
			appointmentDate:appointmentDate,
			stime:stime,
			phoneNo:phoneNo,
			email:email,
			status:status,
			clientcomment:clientcomment,
		},
				success : function(responce) {
					if(responce != ""){
						alert("sucess update");
						$.each(responce, function(i, orderObj) {
						$("#"+orderObj.orderId+"phoneNo").val(orderObj.contactNo);
						$("#"+orderObj.orderId+"service").val(orderObj.serviceId);
						$("#"+orderObj.orderId+"status").val(orderObj.statusId);
						$("#"+orderObj.orderId+"email").val(orderObj.contactEmail);
						$("#"+orderObj.orderId+"clientcomment").val(orderObj.clientlog);
						$("#"+orderObj.orderId+"date").val(orderObj.bookedDate);
						$("#"+orderObj.orderId+"apdate").val(orderObj.appointmentDate);
						
						});
					}
					
				}
	});
	}else{
		alert("please select check box");
	}
}
function forOrderDetails(id){
	//alert(id);
	$('#dial1').text('');
	 $.blockUI({ message: 'Please Wait' });
	
	var orderId = id;
	orderId = orderId.replace('clientcomment','');
	$.ajax({
				type : "POST",
				url : "orderDetails.json",
				data : "orderId=" + orderId,
				dataType : "json",
					success : function(response) {
						//alert(response);
						$.unblockUI(); 
					  if (response == "" || response==null) {
						} else {
							 var  popuptitle=null;
							 var stockInformation1 = null;
						 /* $.each(response,function(j, finalObj){
							 var productHisInfo = finalObj[j]; */
							$.each(response,function(i, stockObj) {
								 //$('#gpby').val(stockObj.goodPaidBy);
								//for cliet log ..
								 var logsData = stockObj.listClientOrder;
								 if(logsData != null && logsData != ""){
									 var desc = '';
									  $.each(logsData,function(ind,logObj){
										  if(desc == ""){
											  
											}else{
												desc = desc + '<br>';
												}
											desc = desc + new Date(logObj.updatedTime).toUTCString()+" : "+logObj.clientLog;
												}); 
										  stockObj.clientLog = desc;
								 } else{
									 stockObj.clientLog = 'Logs not available';
								 }
								 
								//for auro log ..
									 		  stockInformation1 =
												      +" <section id='sec1' class='abc' style='height: 378px;width: 49%;float:left;border-left: 2px solid black;height: 100%;'>"
												      +"<b style='padding-left: 75px;'><u>Client Log</u></b>"
												      +"<div id='clientlog'>"+stockObj.clientLog+"</div>"
												      +"</section></div>"
								 $(stockInformation1).appendTo("#dial1");
							});
							
							 $('#dial1').dialog({width:1199,height:600,title:popuptitle,modal: true}).dialog('open');
						}  
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
	
	
} 
	function allOrdersDisplay(){
	$("#allOrders").show();	
	$("#orderBooking").hide();
	}
</script>
<!-- <script type="text/javascript" src="Branding/js/alladminOrders.js"> -->
<!--

//-->
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
								<div style="height: 44px; width: inherit;">
								<img alt="Image!" id="neworderId" onclick="newOrder()"   src="images/newbookin.png">
								<img alt="Image!"    src="images/editbtn.png" onclick="editOrder()">
								<img alt="Image!"    src="images/clonebtn1.png" onclick="cloneOrder()">
								<img alt="Image!"    src="images/updatebtn.png" onclick="updateOrder()">
								<img alt="Image!"    src="images/allorderbtn.png" onclick="allOrdersDisplay()">
								<!-- <input type="button" value="Edit" onclick="editOrder();">
								<input type="button" value="Clone" onclick="cloneOrder();">
								<input type="button" value="Update" onclick="updateOrder();">
								<input type="button" value="Delete" onclick="">
								<input type="button" value="All orders" onclick="selectOrders();"> -->
								</div>
								<div class="block-input" style="  margin: 1px 54px 10px 0;   ">
											<label>Service</label>
											 <form:select path="serviceId" style="height:0px;" cssClass="some-select" multiple="multiple" tabindex="22" onchange="selectOrders();">
											<%-- <form:option value="">--Select--</form:option> --%>
											<form:options items="${services}"></form:options>
											</form:select>	</div>
											<div class="block-input">
											<label>Status</label>
											 <form:select path="statusId" style="height:0px;" id="status"  cssClass="some-select" multiple="multiple" onchange="selectOrders();" tabindex="23">
											<form:options items="${status}"></form:options>
											</form:select>	</div>
											 <div class="block-input last"> 
											<label>Phone Number </label>
											<form:input path="contactNo" id="phoneNumId"  maxlength="13"  tabindex="24"/>
											</div> 
											<div class="block-input last"> 
											<label>Email </label>
											<form:input path="contactEmail" id="emailId"  tabindex="25" />
											</div>
										<div class="block-input last"> 
											<label>Auro OrderId </label>
											<form:input path="orderId" id="searchOrderId"  tabindex="26" />
											</div>
											<div class="block-input last"> 
											<label>Client OrderId </label>
											<form:input path="orderId" id="clientId"   tabindex="27"/>
											</div>
										
											<div class="block-input last"> 
											<label>Start Date </label>
											<form:input path="bookedDate" id="startDate"   tabindex="29"/>
											</div>
											<div class="block-input last"> 
											<label>End Date </label>
											<form:input path="bookedDate" id="endDate"   tabindex="30"/>
											</div>
											<div style="display: none;">
											<form:select path="vendorstatus" id="vendorstatus">
											<form:option value="">--Select--</form:option>
											<form:options items="${venstatus}"></form:options>	
											</form:select>
												
											<form:select path="statusId">
											<form:option value="">--Select--</form:option>
											<form:options items="${status}"></form:options>	
												</form:select>
												
												<form:select path="timeSlotName" id="timeslotDate">
											<form:option value="">--Select--</form:option>
											<form:options items="${timeSlots}"></form:options>	
												</form:select>
												</div>
											<form:hidden path="vendorServicebased" value="${vendorServicebased}"/>
															
							</div>
							<div class="block-footer" style="  width: 375px;">
							<aside class="block-footer-right">
									<input type="reset" class="btn-cancel" value="<spring:message code="label.clear" />" id="cancelId" tabindex="32"  onclick="dataClear();"/>
									<input type="button" class="btn-save"  onclick="selectOrders()" value="Search" id="submitId" tabindex="31"/>
							</aside>
							</div>
						</form:form>
					</div> 
					</td>
		<td style="  padding-left: 5px;height: 422px !important;" id="allOrders">
			<div class="block" style="width: 68%;">
			<div >
				<form:form action="" commandName="adminCmd" method="post"
					id="addForm" cssClass="form-horizontal">

					
						<div class="head-box" style="width: 796px">
							<h2>
								<span class="icon2">&nbsp;</span>Admin Order Details
							</h2>
							<p class="total_orders">Total Orders : <b id='noOrdrs'></b> </p>
							<div  id="dupMessage" style="color: red;"></div>
							<div  id="upsus" style="color: green;"></div>
						</div>
						<div	class="block-box-deptpurchaser1 purchases-downbox block-box-last-deptpurchaser1"
							id="divheader" style="height:470px !important;   /*width: 503px !important;*/">
							<div class="table-list-blk paginationParentDiv"
								id="userdata" style=" overflow-x: scroll;overflow-y: hidden; height:470px !important ;  width: 598px; padding-right: 199px;">
							<ul class="table-list" style="width:280%;  font-weight: 600; ">
							<li style="width: 21px;"></li>
								<li class="two-boxxx">Order No</li>
								<li class="two-boxxx">Location</li>
								<li class="two-boxxx">Service</li>
								<li class="two-boxxx">Booked Date</li>
								<li class="two-boxxx">Schedule Date</li>
								<li class="two-boxxx">Schedule Time</li>
								<li class="two-boxxx">Contact No</li>
								<li class="two-boxxx">Email</li>
								<li class="two-boxxx">Client Status</li>
								<li class="two-boxxx" style="width:250px;">Client comments</li>
								<li class="two-boxxx" style="width:250px;">Auro comments</li>
							</ul>
								<div id="itemContainer" style="width: 280%">
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
				</div>
				</td>
				
				
				
		<td style="  padding-left: 5px; height: 451px;" id="orderBooking">
			
			
			<form:form action="" commandName="adminCmd" method="post"
							id="addForm" cssClass="form-horizontal">
							<div class="block" style="width: 100%;height: 528px;" >
							
				<div class="head-box" style="width: 796px;margin-bottom: 10px;">
							<h2>
								<span class="icon2">&nbsp;</span><span id="headerdId"> </span>
							</h2>
							<p class="total_orders">Order No : <b id='orderIdHeaderDisplay'></b> </p>
						</div>		
						<div style="padding:25px;">	
								<div class="block-input">
									<label>Partner <span style="color: red;">*</span></label>
									<c:choose>
										<c:when
											test="${sessionScope.cacheUserBean.userName  eq  'admin' ||  sessionScope.cacheUserBean.userName  eq  'operation' || sessionScope.cacheUserBean.userName  eq  'opshyd' || sessionScope.cacheUserBean.userName  eq  'opsban' || sessionScope.cacheUserBean.userName  eq  'opspune' || sessionScope.cacheUserBean.userName  eq  'aurospce'}">
											<form:select path="userId" id="userId1" cssClass="some-select"
												tabindex="1">
												<c:choose>
													<c:when test="${not empty sessionScope.cacheUserBean.userId}">
														<%-- <c:set var="cId" scope="session"
															value="${sessionScope.cacheUserBean.userId }" /> --%>
														<form:option value="">--Select--</form:option>
														<form:options items="${users}"></form:options>
													</c:when>

													<c:otherwise>
														<form:option value="">--Select--</form:option>
														<form:options items="${users}"></form:options>
													</c:otherwise>
												</c:choose>
											</form:select>
										</c:when>
										<c:otherwise>
											<form:select path="userId" id ="userId1" disabled="true"
												cssClass="some-select" onfocus="removeBorder(this.id)" tabindex="1">
												<c:choose>
													<c:when
														test="${not empty sessionScope.cacheUserBean.userId}">
														<%-- <c:set var="cId" scope="session" 
															value="${sessionScope.cacheUserBean.userId }" /> --%>
														<form:options items="${users}"></form:options>
													</c:when>
													<c:otherwise>
														<form:options items="${users}"></form:options>
													</c:otherwise>
												</c:choose>
											</form:select>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="block-input last">
									<label>Location<span style="color: red;">*</span></label>
									<form:select path="locationName" id="locationNameId" cssClass="some-select" tabindex="2">
										<form:option value="">--Select--</form:option>
										<form:options items="${locations}"></form:options>
									</form:select>
								</div>
								<div class="block-input">
									<label>Service Name<span style="color: red;">*</span></label>
									<form:select path="serviceName" id="serviceIdOrder" cssClass="some-select" multiple="multiple" tabindex="3">
										<form:options items="${services}"></form:options>
									</form:select>
								</div>
								
								<div class="block-input last">
											<label>Client order ID</label>
											<input  id="clientIdOrder"  
												 onkeydown="removeBorder(this.id)"  tabindex="4"/>
										</div>
										<div class="block-input">
											<label>Owner Name</label>
											<input  id="ownernameId"  
												 onkeydown="removeBorder(this.id)"  tabindex="5"/>
										</div>	
										<div class="block-input last">
											<label>Customer Name</label>
											<input  id="cname"  
												 onkeydown="removeBorder(this.id)"  tabindex="6"/>
										</div>
								<div class="block-input">
									<label>Phone Number <span style="color: red;">*</span></label>
									<input id="phoneNumIdOrder" onkeypress="return onlyNos(event,this);" maxlength="13"
										onkeydown="removeBorder(this.id)" tabindex="7" />
								</div>
								
								<div class="block-input last">
									<label>Address<span style="color: red;">*</span></label> <input
										id="addressId" onkeydown="removeBorder(this.id)" tabindex="8" />
								</div>
									<div class="block-input">
									<label>Booked Date<span style="color: red;">*</span></label> 
									<input  id="bookedDateId" onkeydown="removeBorder(this.id)"  tabindex="9"/>
                               </div>
								<div class="block-input last">
									<label>Schedule Date<span style="color: red;">*</span></label> 
									<input  id="scheduledateId"  
												 onkeydown="removeBorder(this.id)"  tabindex="10"/>
										
								</div>

								<div class="block-input">
									<label>Time slot<span style="color: red;">*</span></label> 
									<select	id="timeId" class="some-select" tabindex="11">
										<option value="">--Select--</option>
										<option value="1">Morning</option>
										<option value="2">Afternoon</option>
										<option value="3">Evening</option>
									</select>
								</div>
								<div class="block-input last">
											<label>Service Description</label>
											<input  id="sdiscription"  onkeydown="removeBorder(this.id)"  tabindex="12"/>
										</div>
								<div class="block-input">
									<label>Email Id</label> <input
										id="emailIdOrder" 
										onkeydown="removeBorder(this.id)" tabindex="13" />
								</div>
								<div class="block-input last">
									<label>No of BHK</label> <input id="bhkid"
										maxlength="30" 
										onkeydown="removeBorder(this.id)" tabindex="14" />
								</div>
										
                               <div class="block-input">
								<label>WhatsApp Location</label> 
									<input  id="wlocationId"  onkeydown="removeBorder(this.id)"  tabindex="15"/>
                               </div>
                               <div class="block-input last">
									<label>Coupon Code</label> <input id="couponcodeId"
										maxlength="30" 
										onkeydown="removeBorder(this.id)" tabindex="16" />
								</div>
								
								<div class="block-input">
									<label>client Comments</label> <input id="clientCommentsId"
										maxlength="30" tabindex="17" />
								</div>
								<div class="block-input last">
									<label>Completion Date</label> <input id="completionDateId"
										maxlength="30" 
										onkeydown="removeBorder(this.id)" tabindex="18" />
								</div>
                             <div class="block-input">
									<label>Billing to</label> 
									<select	id="billingId" class="some-select" tabindex="19">
										<option value="">--Select--</option>
										<option value="Client">Client</option>
										<option value="Tenant">Tenant</option>
										<option value="Owner">Owner</option>
									</select>
								</div>
								<!-- logs display -->
								<div id ="logsDisplayId">
								<table border="1" width ="100%">
								<tr>
								<th>CLIENT LOG</th>
								<th>AURO LOG</th>
								</tr>
								<tr>
								<td id ="clientlogId"></td>
								<td id ="aurologId"></td>
								</tr>
								
								</table>
								</div>
							<%--	<div class="block-input">
					 <label>Photograph</label> <img width="100" height="100" id = "blah"
						src="http://media.monsterindia.com/monster_2012/girl_100x100.jpg">
					<form:input type="file" path="image" tabindex="18" class="Box" onchange="readURL(this);" />
				</div> 
							</div>--%>
							</div>
							
</div>
<div class="block-footer" style="width: 796px; margin-top: -29px;">
								<aside class="block-footer-right" >
									<input type="reset" class="btn-cancel"	value="<spring:message code="label.clear" />" id="cancelId"
										tabindex="21"  />
									<input type="button" class="btn-cancel"	value="<spring:message code="label.save"/>" id="submitId0"
										onclick="submitForm()" tabindex="20" />
								</aside>
							</div>
						</form:form>
				</td>	
				</tr></table> 
		</div>
	</div>
	</div>
<div id="dial1"></div>