function datpicker1(){
$(function() {  
						$(".invoicedateId").datepicker({
							changeDate : true,
							changeMonth : true,
							changeYear : true,
							showButtonPanel : false,
							dateFormat : 'yy-mm-dd'
						});
					});

}
		
		/**
		 * 
		 */
			var serviceUnitArray = {};
			

			function displayTable(listOrders){
				//var vendorDropDown = $("#vendorId").html();
				//var statusDrop= $("#statusId").html();
				//var timeSlotDrop = $("#timeSlotId").html();
				var vendorServiceBased = JSON.parse($("#vendorServicebased").val());
				if (listOrders != null){
					$("#itemContainer ul li").remove();
					$("#itemContainer ul").remove();
					var rowcount = 0;
				
					$.each(listOrders, function(i, orderObj) {
						
						if(orderObj.vendorcity == orderObj.locationId){
							var netAmount = 0.0;
						serviceUnitArray[orderObj.gid] = orderObj;
						var id='"'+orderObj.orderId+'"';
						if(orderObj.customerName == null || orderObj.customerName == "null" || orderObj.customerName == ""){
							orderObj.customerName = "---";
						}
						
						if(orderObj.nobhk == null || orderObj.nobhk == "null" || orderObj.nobhk == ""){
							orderObj.nobhk = "---";
						}
						var closed = '';
						var vendorInvoice ='';
						if(orderObj.statusName == 'Paid'){
							// closed =  "<li class='ten-boxxx ' id='"+orderObj.orderId+"2' >"+"<input type='button' id='"+orderObj.orderId+"1' value='invoice' onclick='formSubmit1(this.id)' ></li>"  
							 closed =  "<img alt='Image!'  id='"+orderObj.gid+"' onclick='formSubmit1(this.id)'   src='images/auroInvbtn.png' >"
							 vendorInvoice = "<img alt='Image!'  id='"+orderObj.gid+"' onclick='vendorInvoice(this.id)'   src='images/vendorInvBtn.png' >"
							 $( ".checkboxedit" ).prop( "disabled", false );
						}else{
							$( ".checkboxedit" ).prop( "disabled", true );
						}
						if(orderObj.netAmount != null && orderObj.netAmount != "null"){
							netAmount = orderObj.netAmount;
						}
						 /* if(orderObj.statusName == 'Confirmed'){
							  $('#statusid').css('color','green');
							 
							} */
						

						var tblRow = "<ul>"
							+"<li><input class='checkboxedit' name='chkbox' type='checkbox' style='width: 21px;' value='"+orderObj.gid+"' ></li>"
						+"<input type='hidden' id='appDate"+i+"' value='"+orderObj.appointmentDate+"'/>"
								+ "<li class='two-boxxx'><a  id='"+orderObj.orderId+"' href='javascript:forOrderDetails("+id+")' style='font-color:red'>"+orderObj.orderId+"</a></li>"
								+"<li class='two-boxxx' >"+orderObj.customerName+"</li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"statusid'"+">"+orderObj.statusName+"</li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"'phoneNo"+" title='"+orderObj.contactNo+"'>"+orderObj.contactNo+"</li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"'service"+" title='"+orderObj.serviceName+"'>"+orderObj.serviceName+"</li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"'bhk"+" title='"+orderObj.nobhk+"'>"+orderObj.nobhk+"</li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"'date"+" title='"+orderObj.bookedDate+"'>"+orderObj.bookedDate+"</li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"'apdate"+" title='"+orderObj.appointmentDate+"'>"+orderObj.appointmentDate+"</li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"'completionDate"+" title='"+orderObj.completionDate+"'>"+orderObj.completionDate+"</li>"
								+"<li class='two-boxxx'  title='"+orderObj.slotLabel+"'>"+orderObj.slotLabel+"</li>"
								
								+ "<li class='two-boxxx'>"+orderObj.locationName+"</li>"
								+"<li style='width:175px' ><input type='hidden' name='vendorHid"+i+"' value='"+orderObj.vendorId+"'><select onchange='repalceName(this.id, null)' style='width:178px' name='vendorNameId' id='"+orderObj.orderId+"vendorId'"+" ></select>"+"</li>"
								+"<li class='two-boxxx' ><input type='hidden' name='vendorstatusid"+i+"'  value=''/><select class='statusSelect' name='vendorstatusNameId' id='"+orderObj.orderId+"vstatus'"+" ></select></li>"
								+"<li class='two-boxxx' id='"+orderObj.orderId+"vendorInfo'"+" ></li>"
								+"<li class='two-boxxx' ><select class='statusSelect'   id='"+orderObj.orderId+"status'"+" ></select></li>"
								+"<li style='width:70px;' ><input style='width: 53px;' type='text' name='netAmt' id='"+orderObj.orderId+"netAmt' disabled value='"+netAmount+"' ></input></li>"
								+"<li class='two-boxxx' >"+"<select name='dateId' id='"+orderObj.orderId+"dateId'></select>"+"</li>"
								+"<li class='two-boxxx' ><input type='hidden' name='timeSlotHid"+i+"'  value='"+orderObj.appointmentSlotId+"'/><input name='timeSlotNameHid' type='hidden' id='"+orderObj.orderId+"timeName'"+"><select  name='timeSlotNameId' id='"+orderObj.orderId+"timeId'"+" ></select>"+"</li>"   /* value= >'"+timeSlotDrop+"'  */
								
								+"<input type='hidden' id='vname' name='vendorName"+i+"'  value='"+orderObj.vendorName+"'/>"
								
								
								+"<li class='two-boxxx' >"+"<input type='text' name='invoicedateId' id='"+orderObj.orderId+"invoicedateId'  class='invoicedateId' onclick='datpicker1()'>"+"</li>"
								
								+"<img alt='Image!' id='"+orderObj.orderId+"' onclick='formSubmit(this.id)'   src='images/update.png' >"
								/*+"<li class='two-boxxx' >"+"<input type='button' id='"+orderObj.orderId+"' value='Update' onclick='formSubmit(this.id)' ></li>"*/
								+closed
								+vendorInvoice
								+ '</ul>';
								$(tblRow).appendTo("#itemContainer");
							/* $("#"+orderObj.orderId+"b2c").val((orderObj.totalPrice)-(orderObj.vendorCharge) );
							$("#"+orderObj.orderId+"b2b").val(orderObj.vendorCharge); */
								var vs = $("#vendorstatus").html();
								$("#"+orderObj.orderId+"vstatus").html(vs);
								$("#"+orderObj.orderId+"vstatus").val(orderObj.vendorstatus);
								var status = $("#statusId").html();
								$("#"+orderObj.orderId+"status").html(status);
								$("#"+orderObj.orderId+"status").val(orderObj.statusId);
								
								var timeSlotDrop = $("#timeslotDate").html();
								$("#"+orderObj.orderId+"timeId").html(timeSlotDrop);
								$("#"+orderObj.orderId+"timeId").val(orderObj.timeSlotId);
								
								var serLists = [];				
								$("#"+orderObj.orderId+"vendorId").append("<option value=''>--select--</option>");
								
								/*$.each(JSON.parse(vendorServiceBased), function(i, tests) {	
									if(orderObj.serviceId == tests.serviceId){
										$("#"+orderObj.orderId+"vendorId").append("<option value="+tests.vendorId+">"+tests.vendorName+"</option>");
										serLists.push(orderObj.serviceId);
									}
								}); */
								if(orderObj.all_vendorIds != null && orderObj.all_vendorIds != ""){
									if(orderObj.vendorcity == orderObj.locationId){
								var vIds = orderObj.all_vendorIds.split(",");
								console.log(vIds.length);
								rowcount = rowcount+1;
								$.each(vIds, function(i, vid) {
									
									var vid = $.trim(vid);
									var vname = vendorServiceBased[vid];
									if (vname) {
										$("#"+orderObj.orderId+"vendorId").append("<option value="+vid+" >"+ $.trim(vname)+"</option>");
									}
								});
									}
								}
								$('#' + orderObj.vendorId).attr('selected', true);
								
								
								/* }else {
									serLists.push(orderObj.serviceId);
								} */
								$("#"+orderObj.orderId+"vendorId").val(orderObj.vendorId);
								
								$("#"+orderObj.orderId+"dateId").append("<option value=''>--select--</option>");
								$("#"+orderObj.orderId+"dateId").append("<option value='today'>Today</option>");
								$("#"+orderObj.orderId+"dateId").append("<option value='tmrw'>Tommorow</option>");
								$("#"+orderObj.orderId+"dateId").append("<option value='dayafter'>Day After</option>");
								
								var temp=$('#'+orderObj.orderId+'vendorId').find('option:selected').text();
								var tempVal=$('#'+orderObj.orderId+'vendorId').find('option:selected').val();
								if(temp !="--select--"){
									var vid="'"+id+"'";
									tempVal="'"+tempVal+"'";
									var htStr='<a href="javascript:forVendorDetails('+tempVal+')" id="vendor" >'+temp+'</a>';
									$('#'+orderObj.orderId+"vendorInfo").html(htStr);	
								}else{
									$('#'+orderObj.orderId+"vendorInfo").html("");
								}
								
						}	
						
					});
						paginationTable(11);
						$("#noOrdrs").text("# " + rowcount);
				}else{
					//alert('no data to display..');
				}
			}
			
			function statusNamee(name){
				var text = name.options[name.selectedIndex].text;
				statusNames = text;
			}
			

			
			function forVendorDetails(id) {
				 $.blockUI({ message: 'Please Wait' });
				//alert(id);
				//$("#vendor").css("background-color","silver");
				  $('#dial').text("");
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
													 		+"<td>"+"<center>"+productHisInfo.mobileNumber+"</center>"+"</td>"
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
				 
				 var serviceId = [];
			        $(':checkbox:checked').each(function(i){
			        	serviceId[i] = $(this).val();
			        }); 
				 //alert(val[i]);
				// var serviceId = $("#serviceId").val();
				// alert(serviceId);
				 var phoneNumberId = $("#phoneNumId").val();
				 var emailId = $("#emailId").val();
				 var orderid = $("#searchOrderId").val();
				 var statid = $("#status").val();
				 var userId = $("#userId").val();
				 var clientId = $("#clientId").val();
				 var startDate = $("#startDate").val();
				 var endDate = $("#endDate").val();
				 var vendorId=$("#vendorId").val();
				 var vendorstatusId=$("#vendorstatus").val();
				$("#itemContainer ul").remove();
				$("#itemContainer ul li").remove(); 
				$("#vendorId").hide();//for hide
				$("#statusId").hide();//for hide
				 $.ajax({
						type : "POST",
						url : "getServiceOrders.json",
						data : "serviceId=" + serviceId+"&phoneNo="+phoneNumberId +"&emailId="+emailId+"&orderId="+orderid+"&statusId="+statid+"&userId="+userId+"&clientId="+clientId+"&startDate="+startDate+"&vendorId="+vendorId+"&vendorstatusId="+vendorstatusId+"&endDate="+endDate,
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
				 	var vendorstatusId= $("#" + id + "vstatus").val();
				 	var timeSlotName=$('#'+id+'timeName').val();
				 	var customerDisc=$('#'+id+'cdisc').val();
				 	var aurolog=$('#'+id+'aurolog').val();
				 	var vname = $('#vname').val();
				 	var invoiceDate = $('#'+id+'invoicedateId').val(); 
				 	if(statusId != 4 ){
				 		if(vendorId == '' || vendorId == null){"No log available"
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
					"&timeSlotName="+ timeSlotName+  
					"&invoiceDate="+ invoiceDate+ 
					"&vendorstatusId="+vendorstatusId,
					
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
					$("#statusId").hide();
				 	 //$("#" + id + "statusid").text(statusNames);
				 	$("#" + id + "status").val(statusId);
				 	$("#" + id + "vstatus").val(vendorstatusId);
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
			 var allVals = [];
			function formSubmit12(id){
				var res = null;
				var url =  $(location).attr('href');
				var href = $(location).attr("href");
				var dummy = href.substr(href.lastIndexOf('/') +1);
				var userId = serviceUnitArray[id].userId;
				var bookedDate = serviceUnitArray[id].bookedDate;
				var orderId = serviceUnitArray[id].orderId;
				var clientId = serviceUnitArray[id].clientId;
				/*var allVals = [];
				 $('[name=chkbox]:checked').each(function() {
				   allVals.push($(this).val());
				 });
				 var i;
				 for (i = 0; i < allVals.length; ++i) {
					 var id1=allVals[i];
					 var userId = serviceUnitArray[id1].userId;
						var bookedDate = serviceUnitArray[id1].bookedDate;
						var orderId = serviceUnitArray[id1].orderId;
						var clientId = serviceUnitArray[id1].clientId;*/
				
		           
				if(userId == 1 || userId == 3 ){
				 res = href.replace(dummy, "invoiceGenerate.json?orderId="+orderId+"&bookedDate="+bookedDate+"&userId="+userId);
				}else{
				 res = href.replace(dummy, "invoiceGenerate.json?orderId="+clientId+"&bookedDate="+bookedDate+"&userId="+userId);	
				}
				
				window.open(res,"_blank");
			}
			function formSubmit1(id){
				 allVals = [];
				$('[name=chkbox]:checked').each(function() {
					   allVals.push($(this).val());
					 });
				var i;
				for (i = 0; i < allVals.length; ++i) {
					setTimeout(function (){
						
						}, 5000);
					formSubmit12(allVals[i]);
				}
			
			}
			 function resetStatus(id){
				 var sid = id;
				if(sid != "" && sid != null){
					if(id.length > 1){
						  for(var i = 0 ; i < id.length ; i++ ){
							 sid =id[i];
							 globalResetStatus(sid);
						  }   
					 }
					if( sid.length == 1){
						  globalResetStatus(sid);
					  } 
				}
				 
			}
			 
			 function globalResetStatus(id){
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
							$.unblockUI(); 
						},
						statusCode : {
							406 : function() {
								jAlert('page not found', 'Alert Box');
							}
						}
					});
			 }
			 
			 function gloabalResetVendor(id){
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
			 
			 function resetVendor(id){
				 var sid = id;
					if(sid != "" && sid != null){
						if(id.length > 1){
							  for(var i = 0 ; i < id.length ; i++ ){
								 sid =id[i];
								 gloabalResetVendor(sid);
							  }   
						 }
						if( sid.length == 1){
							 gloabalResetVendor(sid);
						  } 
					}
				}
			
			//for order info details..
			 function forOrderDetails(id){
					//alert(id);
					$('#dial1').text('');
					 $.blockUI({ message: 'Please Wait' });
					
					var orderId = id;
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
												 
													var aurologs1 = stockObj.auroLog;
												
													
												     var MyDate_String_Value = "/Date("+stockObj.bookedDate+")/"
													 var bookedDate = new Date(stockObj.bookedDate);
												     bookedDate = bookedDate.toString();
												     bookedDate = bookedDate.substring(0,15);
													 var MyDate_String_Value1 = "/Date("+stockObj.appointmentDate+")/"
													 var appointmentDate = new Date
													             (
													                  parseInt(MyDate_String_Value1.replace(/(^.*\()|([+-].*$)/g, ''))
													             );
													             appointmentDate = appointmentDate.toString();
													             appointmentDate = appointmentDate.substring(0,15);
												serviceName = stockObj.serviceName;
												 popuptitle=serviceName+"   ---   "+stockObj.userName;
												 //$('#gpby').val(stockObj.goodPaidBy);
												 if(stockObj.goodPaidBy != 'null' || stockObj.goodPaidBy != null){
													 $("#gpby option[text='"+stockObj.goodPaidBy+"']").attr("selected","selected"); 
												 }
												 if(stockObj.tests == "" || stockObj.tests == null){
													 stockObj.tests = "---";
												 }
												 if(stockObj.description == "" || stockObj.description == null){
													 stockObj.description = "---";
												 }
												 if(stockObj.symtoms == "" || stockObj.symtoms == null){
													 stockObj.symtoms = "---";
												 }
												 if(stockObj.goodsName == "null" || stockObj.goodsName == null){
													 stockObj.goodsName = "";
												 }
												 if(stockObj.vendorName == "null" || stockObj.vendorName == null){
													 stockObj.vendorName = "---";
												 }
												 if(stockObj.clientOrderId == "null" || stockObj.clientOrderId == null){
													 stockObj.clientOrderId = "---";
												 }
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
												 var logsData1 = stockObj.listAuroOrder;
												 if(logsData1 != null && logsData1 != ""){
													 var desc1 = '';
													  $.each(logsData1,function(ind,logObj){
														  if(desc1 == ""){
															  
															}else{
																desc1 = desc1 + '<br>';
																}
															desc1 = desc1 + new Date(logObj.updatedTime).toUTCString()+" : "+logObj.auroLog;
																}); 
														  stockObj.auroLog = desc1;
												 } else{
													 stockObj.auroLog = 'Logs not available';
												 }

													 		
													 		  stockInformation1 =
													 			  
													 			  
													 			  +"<div>"
													 			  +"<table width='100%' height='100'>"
													 			  +"<tr><th>OrderId</th><td><b>"+stockObj.generatedId+"</b></td> <th>Service</th><td><b>"+stockObj.serviceName+"</b></td> <th>Booked Date</th><td><b>"+bookedDate+"</b></td></tr>"
													 			 +"<tr><th>Schedule Date</th><td><b>"+appointmentDate+"</b></td> <th>Schedule Time</th><td><b>"+stockObj.appointTimeName+"</b></td> <th>Customer Name</th><td><b>"+stockObj.customerName+"</b></td></tr>"
													 			+"<tr><th>Customer e-Mail</th><td><b>"+stockObj.contactEmail+"</b></td> <th>Customer No</th><td><b>"+stockObj.contactNumber+"</b></td> <th>Status</th><td><b>"+stockObj.statusName+"</b></td></tr>"
													 			+"<tr><th>Service Description</th><td><b>"+stockObj.description+"</b></td> <th>Service Packages</th><td><b>"+stockObj.tests+"</b></td><th>Customer Address</th><td><b>"+stockObj.address+"</b></td> </tr>"
													 			+"<tr><th>vendorName</th><td><b>"+stockObj.vendorName+"</b></td><th>ClientId</th><td><b>"+stockObj.clientOrderId+"</b></td> </tr>"
													 			  +"</table>"
													 				 +"</div>"
																 +"<div style='height: 382px;width:100%;border: 2px solid black;'>"
																  +"<div class='koti' style='height: 382px;width:50%;float: left;'>"
																  +"<ul style='margin:15px;'>"
																	/* +"<li style='font-family:sans-serif;font-size: 14px;font-weight: bold;'>Region:<input type='text' id='regionId' style='float: right;'/></li>" */
																	+"<li class='popup'>Vendor Service Charge<input class='text-box-allign' type='text' id='vendorChargeId' value='"+stockObj.vendorServiceCharge.toFixed(2)+"' onkeydown='removeBorder(this.id)' onkeypress='return onlyNos(event,this);'/></li>"
																	+"<li class='popup'>Goods Charge<input class='text-box-allign' type='text' id='goodsId' value='"+stockObj.goodsCharge.toFixed(2)+"' onkeydown='removeBorder(this.id)' onkeypress='return onlyNos(event,this);'/></li>"
																	+"<li class='popup'>Margin Value<input class='text-box-allign' type='text' id='marginId' value='"+stockObj.marginValue.toFixed(2)+"' onkeydown='removeBorder(this.id)' onkeypress='return onlyNos(event,this);'/></li>"
																	+"<li class='popup'>No.of Hours Work<input class='text-box-allign' type='text' id='hoursId' value='"+stockObj.noOfHoursWork+"' onkeydown='removeBorder(this.id)' onkeypress='return onlyNos(event,this);' /></li>"
																	+"<li class='popup'>Transportation Charge<input class='text-box-allign' type='text' id='tchargeId' value='"+stockObj.transportaionCharge.toFixed(2)+"' onkeydown='removeBorder(this.id)' onkeypress='return onlyNos(event,this);'/></li>"
																	+"<li class='popup'>No.Of Visits<input class='text-box-allign' type='text' id='novId' value='"+stockObj.noOfVisits+"' onkeydown='removeBorder(this.id)' onkeypress='return onlyNos(event,this);' /></li>"
																	+"<li class='popup'>Fixed Charge<input class='text-box-allign'type='text' id='fcId' value='"+(stockObj.fixedCharge).toFixed(2)+"' onkeydown='removeBorder(this.id)' onkeypress='return onlyNos(event,this);'/></li>"
																	+"<li class='popup'>What'sApp Location<input type='text' id='watsappId' value='"+stockObj.watsupLocation+"' style='float: right;'/></li>"
																	+"<li class='popup'>Goods Description<input type='text' id='goodsName' value='"+stockObj.goodsName+"' style='float: right;'/></li>"
																	+"<li class='popup'>Goods paid By<select id='gpby' style='float: right;width: 175px;'> <option value=''>--Select--</option> <option value='Client'>Client</option> <option value='Customer'>Customer</option><option value='Company'>Company</option><option value='Vendor'>Vendor</option></select></li>"
																	+"<li class='popup' >Auro log<textarea  style='width:250px;float: right;'  id='aurolog'></textarea></li>"
																	+"<li class='popup'><input class ='auro_sub' type='button' value='Submit' onclick='submitVendorDetails();' ></li>"
																	+"<li class='popup'><input type='hidden' id='oid' value='"+stockObj.oid+"'/></li>"
																	+"</ul>"
																	+"</div>"
																   +"<div class='koti' style='height: 382px;width: 49.3%;float: right;'>"
																      +" <section id='sec1' class='abc' style='height: 378px;width: 49%;float:left;border-left: 2px solid black;height: 100%;'>"
																      +"<b style='padding-left: 75px;'><u>Client Log</u></b>"
																      +"<div id='clientlog'>"+stockObj.clientLog+"</div>"
																      +"</section>"
																      +"<section class='xyz' style='height: 378px;width: 49.6%;float:right;border-left: 2px solid black;height: 100%;'>"
																      +"<b style='padding-left: 75px;'><u>Auro Log</u></b>"
																      +"<div id='aurolog'>"+stockObj.auroLog+"</div>"
																      +"</section></div>"
																+"</div>"
																+"</div>";
												 $(stockInformation1).appendTo("#dial1");
												 if(stockObj.goodPaidBy != 'null' || stockObj.goodPaidBy != null){
													 //$("#gpby option[text='"+stockObj.goodPaidBy+"']").attr("selected","selected"); 
													 $("#gpby").val(stockObj.goodPaidBy);
												 }
											});
											
											 $('#dial1').dialog({width:1199,height:600,title:popuptitle,modal: true}).dialog('open');
										}  
								},
								error : function(e) {
									alert('Error: ' + e);
								}
							});
					
					
				} 
			
			//
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
			function submitVendorDetails(){
				var oid =$("#oid").val();
				var aurolog = $("#aurolog").val();
				/* var regionId = $('#regionId').val(); */
				var vendorChargeId = $('#vendorChargeId').val();
				var goodsId = $('#goodsId').val();
				var marginId = $('#marginId').val();
				var hoursId = $('#hoursId').val();
				var tchargeId = $('#tchargeId').val();
				var novId = $('#novId').val();
				var fcId = $('#fcId').val();
				var watsappId = $('#watsappId').val();
				var fdId = $('#fdId').val();
				var goodsName = $("#goodsName").val();
				var gpby =$("#gpby").val();
				
				$.ajax({
					type : "POST",
					url : "vendorDetailsInsert.json",
					data :{ oid:oid,
						vendorChargeId : vendorChargeId,
						goodsId : goodsId,
						marginId : marginId,
						hoursId : hoursId,
						tchargeId : tchargeId,
						novId : novId,
						fcId : fcId,
						watsappId : watsappId,
						aurolog:aurolog,
						goodsName:goodsName,
						gpby:gpby
						},
					dataType : "json",
						success : function(responce) {
							if(responce != ""){
								alert("sucess insert");
								$.each(responce, function(i, orderObj) {
								$("#"+orderObj.orderId+"netAmt").val(orderObj.netAmount);
								});
							}
							
						}
				});
			}
			
			
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
				 /* function logs(){
					 
				 }  */
			
				function vendorInvoice(id){
					var res = null;
					var url =  $(location).attr('href');
					var href = $(location).attr("href");
					var dummy = href.substr(href.lastIndexOf('/') +1);
					var userId = serviceUnitArray[id].userId;
					var bookedDate = serviceUnitArray[id].bookedDate;
					var orderId = serviceUnitArray[id].orderId;
					var clientId = serviceUnitArray[id].clientId;
					if(userId == 1 || userId == 3 ){
					 res = href.replace(dummy, "vendorInvoice.json?orderId="+orderId+"&bookedDate="+bookedDate+"&userId="+userId);
					}else{
					 res = href.replace(dummy, "vendorInvoice.json?orderId="+clientId+"&bookedDate="+bookedDate+"&userId="+userId);	
					}
					
					window.open(res);
				}
				
				$(document).ready(function() {
					
				});
				