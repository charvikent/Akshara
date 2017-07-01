<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Begin Inspectlet Embed Code -->
<script type="text/javascript" id="inspectletjs">
window.__insp = window.__insp || [];
__insp.push(['wid', 26443257]);
(function() {
function ldinsp(){if(typeof window.__inspld != "undefined") return; window.__inspld = 1; var insp = document.createElement('script'); insp.type = 'text/javascript'; insp.async = true; insp.id = "inspsync"; insp.src = ('https:' == document.location.protocol ? 'https' : 'http') + '://cdn.inspectlet.com/inspectlet.js'; var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(insp, x); };
setTimeout(ldinsp, 500); document.readyState != "complete" ? (window.attachEvent ? window.attachEvent('onload', ldinsp) : window.addEventListener('load', ldinsp, false)) : ldinsp();
})();
</script>
<!-- End Inspectlet Embed Code -->

<meta name="description" content="${service.description }">
<meta name="keywords" content="${service.keywords }">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Aurospace</title>
<link rel="shortcut icon" href="${baseUrl}/images/ico/favicon.ico"> 

<!-- Bootstrap -->
<link href="${baseUrl}/css/bootstrap.css" rel="stylesheet">
<link href="${baseUrl}/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="http://fortawesome.github.io/Font-Awesome/assets/font-awesome/css/font-awesome.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
</head>
<body>
<div class="header1">
  <div class="container-main">
    <div class="logo"> <a href="${baseUrl}"> <img src="${baseUrl}/images/logo.png" width="70" height="63" alt="logo image" />
      <div class="name">
        <h3>Aurospaces</h3>
        <div class="clearfix"></div>
        <p>One space for all services</p>
      </div>
      </a> </div>
  </div>
</div>
<div class="container-main  step0">
  <div class="col-md-6 col-sm-6 col-md-offset-3 col-sm-offset-3 right-content step0" id="message">
    <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list active firststep">1</div>
          <p>Select Your Packages</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list secondstep">2</div>
          <p>Date & Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list thirdstep">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list fourthstep">4</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
    <!--end of progress bar--> 
  </div>
    <div class="clearfix">&nbsp;</div>
    <div class="clearfix">&nbsp;</div>
 <input type="text" class="form-control search-text" autocomplete="off" id="testName" placeholder="Filter packages"  
 		style= "color:#00000"     onkeyup="filterByName()" >
 
 	<div class="// alert-danger " id="testTypeMessage" style="color: #FF0000;background-color: white;font-weight: bold;"></div>
  </div>
  <!-- end of message section-->
  <div class="clearfix">&nbsp;</div>
  <div class="col-md-12 as-pathalagy step0" >
    <div class="col-md-10 tab-adj">
      <table class="table table-bordered as-table table-responsive">
        <tbody>
          <tr>
            <!-- <th align="center">Vendor Name</th> -->

 
            <th style="text-align:center;">Service Name</th>
            <th style="text-align:center;">Price</th>
             <th style="text-align:center;"> Discount</th>
             <th style="text-align:center;">You Pay</th>

            <th>&nbsp;</th>
            <!-- <input class="deleteSelectedItem btn as-but-greay as-but-pathalogy  white button-gradient package"  id="delete" type="button" value="delete"/> --> 
            
          </tr>
        </tbody>
        
        <tbody id="itemContainer">
          
        </tbody>
      
      </table>
    </div>
 


    <div class="col-md-2 as-but-verticalSpace text-left">
      <div>
        <input class="btn  btn-lg btn-block as-but-pathalogy special" type="button" id="selected_list"  value="Selected" onclick="showSelectedList(this.id)">
      </div>
      <div style="padding:5px"></div>
      <div>
        <input class="btn as-but btn-lg btn-block as-but-pathalogy general " id="btn0" type="button" value="Book Now" style="background: #dbbc23;position:static;">
      </div>
      <div class="as-divider"> </div>
			<c:choose>  
						<c:when test="${not empty labelMap }">
      <h3 class="filter">Filters</h3>


						<c:forEach var="label" items="${labelMap}">
						<input class="btn as-but-greay btn-lg btn-block as-but-pathalogy  white button-gradient suc-active"  
							id="${label.value}" type="button" name="" value="${label.key}" onclick="filterAndRedraw(this.id);"/>
						<div class="clearfix">&nbsp;</div>
						</c:forEach>
						</c:when>
			</c:choose>
      <div class="clearfix">&nbsp;</div>
      				<%-- <input type="hidden" id="serviceId"  value="<%= request.getParameter("serviceId") %>"/>
                    <input type="hidden" id="locationId"  value="<%= request.getParameter("locationId") %>"/> --%>
                    <input type ="hidden" value="${baseUrl }" id="baseUrl">
    </div>
    <!-- /.col-md-12 --> 
  </div>
<div class="clearfix">&nbsp;</div>


<!---2nd section start--->
<div class="container-fluid step1">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> 
${service.displayText }
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content step1">
  
      
      <div class="col-md-5 col-sm-5 left-section visible-xs">
          <div class="clearfix">&nbsp;</div>
					${service.displayText }
  </div>
  
      <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list firststep">1</div>
          <p>Select Your Packages</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list active secondstep">2</div>
          <p>Date &amp; Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list thirdstep">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list fourthstep">4</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
      
  <div class="forms dates">
    <div class="block-content">
      <div class="row no-marg">
        <h3>Pick a day</h3>
        <div class="clearfix">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
         <span> <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date scheduleDateBtn" value="Today">
                 <input type="hidden" name="scheduleDate"  value="0"/></span>
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
         <span> <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date scheduleDateBtn" value="Tomorrow">
                 <input type="hidden" name="scheduleDate"  value="1"/></span>
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
         <div class="clearfix visible-xs">&nbsp;</div>
          <span><input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date scheduleDateBtn" value="Day After">
                 <input type="hidden" name="scheduleDate"  value="2"/></span>
        </div>
      </div>
      <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div>
      <div class="row no-marg">
        <h3>Pick time slot</h3>
        
       		 <c:choose>  
											<c:when test="${not empty timeSlotList }">
											<c:forEach var="timeSlot" items="${timeSlotList}" varStatus="loop">
											<div class="col-md-4 col-sm-4">
											<span><input class="btn btn-lg btn-block btn-date scheduleTimeBtn"   id="s_${loop.index}" type="button"  value="${timeSlot.label }"  />
											<input type="hidden" name="scheduleTimeId" value="${ timeSlot.id }"/>
											<input type="hidden" name="scheduleTime" value="${ timeSlot.label }"/>
											<input type="hidden" name="hour" id= "hour" value="${ timeSlot.hour }"/></span>
											</div>
											 <div class="clearfix visible-xs">&nbsp;</div>
											</c:forEach>
											</c:when>
				</c:choose>
        
      </div>
     
       <div class="clearfix">&nbsp;</div>
       <div class="// alert-danger" id="dupMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
      </div>
      <div class="col-md-12 col-xs-12 col-lg-12 no-pad">  <a href="javascript:;" id="btn1" class="btn btn-primary btn-lg btn-block" type="submit">Next</a></div>
    </div>
    </div>
    
  </div>
<!---2nd section end--->
<!---3rd section start--->
<div class="container-fluid step2">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> 
${service.displayText }
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
  
       <div class="col-md-5 col-sm-5 left-section visible-xs"> 
            <div class="clearfix">&nbsp;</div>
						${service.displayText }
  </div>
      <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list firststep">1</div>
          <p>Select Your Packages</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list secondstep">2</div>
          <p>Date &amp; Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list active thirdstep">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list fourthstep">4</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
      
   <%@include file="contactForm.jsp" %> 
    <%@ page import="java.io.FileInputStream" %>
   <%@ page import="java.io.File" %>
   <%@page import="java.util.Properties" %>
   <%@page import="java.io.InputStream" %>   
    
<%/* 
String sPropFilePath = pageContext.getRealPath("Resources"+ File.separator + "DataBase.properties");
if (StringUtils.isNotBlank(sPropFilePath)) {
	Properties objProperties = new Properties();
	InputStream objStream = new FileInputStream(sPropFilePath);
	objProperties.load(objStream);
	String servicetax = objProperties.getProperty("serviceTax");
	objSession.setAttribute("servicetax", servicetax);
	String sbses=objProperties.getProperty("sbcease");
	objSession.setAttribute("sbses", sbses);
	 */
	
	 InputStream fis = application.getResourceAsStream("Resources"+ File.separator + "DataBase.properties");

    Properties p = new Properties();
    p.load(fis);
    String servicetax = p.getProperty("serviceTax");
    String sbcease = p.getProperty("sbcease");
    String sbkktax = p.getProperty("sbkktax");
	
	
	 /* InputStream stream = application.getResourceAsStream("/some.properties");
	    Properties props = new Properties();
	    props.load(stream); */
	%>    
    
    
    
    </div>
    
  </div>
<!---3rd section end--->
<!---4th section start--->
<div class="container-fluid step3">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> 
${service.displayText }
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
  
       <div class="col-md-5 col-sm-5 left-section visible-xs"> 
            <div class="clearfix">&nbsp;</div>
						${service.displayText }
  </div>
  
  <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list firststep">1</div>
          <p>Select Your Packages</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list secondstep">2</div>
          <p>Date &amp; Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list thirdstep">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list active fourthstep">4</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
  
  <div class="forms dates no-pad">
    <div class="block-content1">
    <h2 class="text-center">Your Order Summary</h2>
     <table class="table table-bordered as-table" style="margin-bottom: 0px;">
                                          <tbody><tr>
                                          		<th>Sno</th>
                                          		<th>Service Name</th>
                                          		<th style="width: 12%;">Price</th>
                                          		<th>Delete</th>
                                          </tr>
                                            </tbody>
                                             
                                            <tbody id="itemContainerSum">
                                              
                                            </tbody>
                                            <tbody>
                                            <tr>
	            		<td></td>
						<td>Your discount</td>
						<td id="totalDiscountId"></td>
	            		</tr> </tbody>
	            		<tbody>
                                            <tbody>
                                            <tr>
	            		<td></td>
						<td>Service Tax(14%)</td>
						<td id="servicetaxId"></td>
	            		</tr> </tbody>
	            		<tbody>
                                            <tr>
	            		<td></td>
						<td>SB Cess(0.5%)+KK Cess(0.5%)</td>
						<td id="sbceasesId"></td>
	            		</tr> </tbody>
                                            <tbody><tr style="background-color: #2184be">
                                              <td colspan="2">Total</td>
                           					 <td id="totalNetAmountId"></td>
                         					 </tr>
                         				
                              </tbody></table>
       
      </div>
       <div class="col-md-12 text-left">
       <label>Schedule :</label><span id="scheduleDateDisplayId"></span> 
       <div class="clearfix"></div>
       <label>Contact :</label><span id="contactNumberDisplayId"> </span>
       <span id="emailID"></span>
       <div class="clearfix"></div>
        <span id="addressID"></span>
      <div class="clearfix"></div>
                <div class="col-md-4 col-sm-8 col-xs-12 text-left">
                        <label>OTP</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left ">
                        <p><input type="text" class="otp" name="otp" id="otpId" placeholder ="Enter OTP" size="35"></p>
                    </div>
                    <div class="col-md-4 col-sm-8 col-xs-12 text-left ">
                        <label>Couponcode</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p><input type="text" class="coupon" name="couponcode" id="couponcodeId" placeholder ="coupon code if any optional" size="35" ><button class="btn btn-success sucess" onclick="CouponCode();"  >Apply</button></p>
                        <p ><div style="display:none; color: #FF0000;" id="invalidId">Invalid coupon code</div></p>
                        <p ><div style="display:none;" id ="validId">Coupon code applied success</div></p>
                    </div>
                </div>
      <div id="bookMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
      <div class="col-md-6 col-sm-6"> <a href="${baseUrl }" class="btn btn-primary btn-lg cancel btn-block" type="submit">Cancel</a></div><div class="clearfix visible-xs">&nbsp;</div>
      <div class="col-md-6 col-sm-6"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block " id="btn4" type="submit">Book Now</a></div>
      <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div>
      
    
    </div>
    </div>
    </div>
  </div>
<!---4th section end--->
<!---5th section start--->
<div class="container-fluid step4">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> 
${service.displayText }
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
   
       <div class="col-md-5 col-sm-5 left-section visible-xs"> 
            <div class="clearfix">&nbsp;</div>
						${service.displayText }
  </div>
      
  <div class="forms dates">
    <div class="block-content">      
      <div class="clearfix">&nbsp;</div>
        
        <P align="center"> Thanks for booking. Your request is being processed.<br> 
				                  Will keep you posted. For any enquiries <br>
				                  whatsapp us@974 255 7757 Email to <a>care@aurospaces.com</a></p>
      <div class="clearfix">&nbsp;</div>
      </div>
     <div class="col-md-4 col-sm-4"> <a href="${baseUrl }" class="btn btn-primary btn-lg btn-block" type="submit">No Thanks</a></div>
      <div class="clearfix visible-xs">&nbsp;</div>
     <div class="col-md-8 col-sm-8"> <a href="${baseUrl }" class="btn btn-primary btn-lg btn-block " id="btn5" type="submit">Book another service &nbsp; <i class="fa fa-arrow-right"></i></a></div>
    </div>
    <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div>
       <div class="clearfix">&nbsp;</div>
    </div>
    
  </div>
   <!-- <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div>
       <div class="clearfix">&nbsp;</div>
       <div class="clearfix">&nbsp;</div> -->
<!---5th section end--->
<div class="clearfix">&nbsp;</div>
<div class="footer">
  <div class="container-main">
    <div class="col-md-4 col-sm-4 col-xs-4 no-pad col-md-offset-4 col-sm-offset-4 text-center"> <a href="javascript:;">&copy; 2014 Aurospaces </a> </div>
    <div class="col-md-4 col-sm-4 col-xs-8 text-center"> <a href="${baseUrl}/terms&condititons.html"> Terms&amp;Conditions </a> &nbsp; &nbsp; <a href="${baseUrl}/privacypolicy.html"> Privacy Policy </a> </div>
  </div>
</div>
<!--end of footer--> 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="${baseUrl}/js/bootstrap.min.js"></script> 
<script src="${baseUrl}/js/formValidation.js"></script> 
<script src="${baseUrl}/Branding/js/MntValidator.js"></script> 
<script src="${baseUrl}/js/jqueryblockui.js"></script> 

<script>
 var pathologyTestsSelectedTotalArray = [];
	var isCoupon = false;
 var ALL_BITS = 0x07;
 var FILTER_TEXT = 0x01;
 var FILTER_LABEL = 0x02; 
 var FILTER_SELECTED = 0x04;
		var pathologyTestsSchedueDate;
		var pathologyTestsSchedueTime;
		var globalPathologyTests;
		var dateDisplay;
		var pathologyTestsSchedueTimeId;
		var contactNumber;
		var contactAddress;
		var emailId;
		var password;
		var globalArray = [];
		var totalPrice=0;
		var totalDiscount=0;
		var totalNetAmount=0;
		var serviceId = ${serviceId};
		var locationId = ${locationId};
		var isPackageID=false;
		var isOthersID=false; 
		var vendorId = 0;
		var labelMap = new Array();
		var labelList = new Array();
		var baseUrl =$("#baseUrl").val();
		var othersIds = [];
		var pthId ="";
		var isAddress= false;
		var otpIsCreated = false;
		var  customerDiscout =0;
		var noOfcustomers = 0;
		var isDiscount = false;
		var existingCustomerDiscount;
		var globalCurstomrDisocunt;
		var serviceTax = <%=servicetax%>;
		var sbcease=<%=sbkktax%>;
function getHour()
{
  var d = new Date(<%= System.currentTimeMillis() %>);
  var n = d.getHours();
  return n;
}
var images = $('.imageName').attr('src');
$('.imageName').attr("src", baseUrl+"/"+images);
		var cTime = ${hour};
		if(cTime > 16 ){
			$('#todayBtn').attr("disabled","disabled");
		}
	
	/* This will use the globalLabel to load each row */
/* This function will be only showing the data the 1st time around. After that
we shold simply be using show() or hide() for the filter */
// alert("3");
		function updatePageContent(){
				$("#itemContainer").html("");
				$("#itemContainerSum").html("");
				for(var labelName in labelList)
				{
					var tempVar	 = labelList[labelName];
					if((!tempVar) || (tempVar == "0"))
					{
						continue;
					}
					listPathologyTests = labelMap[labelName];
					$.each(listPathologyTests,function(i, itemSelectedInfo) {
						var resultDiscount=0;
						var youPay=0;
						var count = 0;
						var firstName = null;
						var finalPrice=0;
						finalPrice=itemSelectedInfo.finalPrice;
						finalPrice=Number(finalPrice).toFixed(2);
						if (itemSelectedInfo.lastName == null || itemSelectedInfo.lastName == ""){
							firstName = itemSelectedInfo.firstName;
						}else{
							firstName = itemSelectedInfo.firstName+" "+itemSelectedInfo.lastName; 
						}
										var testRowId = $( "#itemContainer tr" ).length+1;
										/* we no longer use the above testRowId */
										var tblRow =  "<tr id ='testSelected_" + itemSelectedInfo.testId + "' name='test' >"
											 + "<td style='display:none;' id='"
											+ itemSelectedInfo.testId
											+ "'>"
											+ firstName
											+ "</td>" 
											+ "<td id='"
												+ itemSelectedInfo.testId
												+ "'><b>"
												+ itemSelectedInfo.testName
												+ "</b><br>"+itemSelectedInfo.desc+"<br></td>"
												+ "<td style='display:none;'>"+" Rs. "
												+ itemSelectedInfo.desc
												+ "</td>"
												+ "<td >"+" Rs. "
												+ itemSelectedInfo.price
												+ "</td>"
												+ "<td >"
												+ parseInt(itemSelectedInfo.discount)+" %"
												+ "</td>"
												+ "<td >"+" Rs. "
												+ finalPrice
												+ "</td>"
												 + "<td style='display:none;'>"
												+ itemSelectedInfo.couponCodeDiscount
												+ "</td>"
												+ "<td style='display:none;'>"
												+ itemSelectedInfo.finalPrice
												+ "</td>"
												/*+ "<td style='display:none;'>"
												" Rs. "
												+ itemSelectedInfo.youPay
												+ "</td>"  */
												/* +"<td id='unique'>"+itemSelectedInfo.unique_id+"</td>" */
												+"<td style='display:none;' id='v_"+itemSelectedInfo.testId+"' >"+itemSelectedInfo.vendor_id+"</td>"
												if(count>0){
												tblRow+= "<td  style='width:1px'> <input type='button' value='Select'   class='btn as-select-btn suc-active testSelect'>"
												+ "</td>"
												+ '</tr>';		
												}else{
													tblRow+= "<td  style='width:1px'> <input type='button' value='Select' id = 'r_"+itemSelectedInfo.testId+"'  class='btn as-select-btn testSelect'>"
														+ "</td>"
														+ '</tr>'
												}
												totalPrice=	itemSelectedInfo.price;
												totalDiscount=(itemSelectedInfo.price*itemSelectedInfo.discount)/100;
												totalNetAmount=itemSelectedInfo.finalPrice;
													
													
										 $(tblRow).appendTo("#itemContainer");
									//	containerHtml = containerHtml  + tblRow;
									});
					// $("#itemContainer").html(containerHtml);
				}
			}
// alert("4");
		
		
			function fetchAllPackages(serviceId,locationId){
				
				$.ajax({
					type : "GET",
					url : baseUrl+"/getServiceUnits.json?serviceId=" + serviceId + "&locationId=" + locationId,
					dataType:'json',
					success : function(serverResp) {
						populateUiMatrix(serverResp);
						updatePageContent();
					}
				});
				
			}
// alert("5");
			
			function createJsUnitObj(pathologyTestId,vendorName, pathologoyTestName, pathologoyDescription, pathologoyPrice, pathologoyDiscount,pathologynetamount,couponCodeDiscount) {
				var item = {};
				if (pathologyTestId != "" && pathologyTestId != null) {
				        item ["unitId"] = pathologyTestId;
				        item ["vendorName"] = vendorName;
				        item ["name"] = pathologoyTestName;
				       // item ["vendorId"] = vendorId;
				        item ["description"] = pathologoyDescription;
				        item ["price"] = pathologoyPrice;
				        item ["discount"] = pathologoyDiscount;
								totlAmount=(parseInt(item.price))- (parseInt(item.price))*(( parseInt(item.discount)/100));
				        item ["netAmount"] = pathologynetamount;
				        item ["couponCodeDiscount"] = couponCodeDiscount;
				}
				return item;
			}
			function createPathologyTestInfoJson(pathologyTestId,vendorName, pathologoyTestName, pathologoyDescription, pathologoyPrice, pathologoyDiscount,pathologynetamount,couponCodeDiscount) {
				var item = {};
				if (pathologyTestId != "" && pathologyTestId != null) {
				        item ["pathologyTestId"] = pathologyTestId;
				        item ["vendorName"] = vendorName;
				        item ["pathologoyTestName"] = pathologoyTestName;
				        item ["pathologoyDescription"] = pathologoyDescription;
				        item ["pathologoyPrice"] = pathologoyPrice;
				        item ["pathologoyDiscount"] = pathologoyDiscount;
				        item ["pathologynetamount"] =pathologynetamount;
				        item ["couponCodeDiscount"] = couponCodeDiscount;
				        /* item ["uniqueId"] = uniqueId; */
				        // console.log('item : ' + item);
				}
				return item;
			}
// alert("6");
			
			
			$(document).on('click', '.testSelect', function(){
				$("#testTypeMessage").text("");
				var unitId = $(this).closest( "tr" ).find("td:first").attr("id");
				var pathologoyId = $(this).closest( "tr" ).find("td:first").attr("id");
				var vendorName = $(this).closest( "tr" ).find("td:nth-child(1)").text();
				//alert(vendorName);
				
				 vendorId = $("#v_"+unitId).text();
				/* In case of multiple vendors , disable other vendors when one is selected
				CHIDDU TODO
				*/
				$.each(globalPathologyTests,function(i, eachRow) {
					var vendor = eachRow.vendor_id;
					if(vendorId == vendor){
						//alert(vendorNamed );
					}else{
						$('#r_'+eachRow.testId).attr("disabled","disabled");
					}
					
					});
				
				
				if($(this).hasClass("suc-active")){
					$(this).removeClass("suc-active");
					pathologyTestsSelectedTotalArray=pathologyTestsSelectedTotalArray
		               .filter(function (el) {
		                        return el.unitId !== pathologoyId ;
		                       });
					flagSelected(pathologoyId, false);
			if(pathologyTestsSelectedTotalArray.length<=0){
				$.each(globalPathologyTests,function(i, eachRow) {
				$('#r_'+eachRow.testId).removeAttr('disabled');
				});
				$(".secondstep").removeClass("action");
				$("#testTypeMessage").text("");
			}
					 var length =pathologyTestsSelectedTotalArray.length;
				        $("#selected_list").attr('value', 'Selected '+length);
				}else{
					$(this).addClass("suc-active");
					vendor = vendorName;
					flagSelected(pathologoyId, true);
					if(vendor == "Thyrocare"){
						$('#1').attr("disabled","disabled");
						$('#2').attr("disabled","disabled");
					}
					
					
					function disableAltVendors(ve)
					{
						
					}
					var pathologoyTestName = $(this).closest( "tr" ).find("td:nth-child(2)").text();
					var pathologoyDescription = $(this).closest( "tr" ).find("td:nth-child(3)").text();
					var pathologoyPrice = $(this).closest( "tr" ).find("td:nth-child(4)").text();
					var pathologoyDiscount = $(this).closest( "tr" ).find("td:nth-child(5)").text();
					var pathologynetamount=$(this).closest( "tr" ).find("td:nth-child(6)").text();
					 var couponCodeDiscount = $(this).closest( "tr" ).find("td:nth-child(7)").text(); 
					var pathologyTestInputAsJSON = {};
					pathologyTestInputAsJSON = createJsUnitObj(pathologoyId,vendorName, pathologoyTestName, pathologoyDescription, pathologoyPrice, pathologoyDiscount,pathologynetamount,couponCodeDiscount);
						// console.log('pathologyTestsArray : ' + JSON.stringify(pathologyTestInputAsJSON));
					
						pathologyTestsSelectedTotalArray.push(pathologyTestInputAsJSON);
						 var length =pathologyTestsSelectedTotalArray.length;
					        $("#selected_list").attr('value', 'Selected '+length);
				}
			});
			
				
// alert("6");
		
			
			
		
			
			
			/*select schedule date -- start*/
			
			 $(document).on('click', '.scheduleDateBtn', function(){
				 document.getElementById("dupMessage").style.display = "none";
	 $('.scheduleDateBtn').removeClass("suc-active");
	var scheduleDate1 = $(this).parent( "span" ).find('input[type="hidden"][name="scheduleDate"]').val();
	$(this).addClass("suc-active");
	pathologyTestsSchedueDate= scheduleDate1;
	
	//// alert(scheduleDate1);
		if(scheduleDate1 == "0"){
			if(cTime > 9 ){
				pathologyTestsSchedueTime = "";
				$('.scheduleTimeBtn').removeClass("suc-active");
				$('#s_0').attr("disabled","disabled");
				if(vendor == "Thyrocare"){
					 $('#s_1').attr("disabled","disabled");
						$('#s_2').attr("disabled","disabled");
				 }
			}
			if(cTime > 13 ){
				pathologyTestsSchedueTime = "";
				$('.scheduleTimeBtn').removeClass("suc-active");
				$('#s_0').attr("disabled","disabled");
				$('#s_1').attr("disabled","disabled");
			}
			if(cTime > 16 ){
				pathologyTestsSchedueTime = "";
				$('.scheduleTimeBtn').removeClass("suc-active");
				$('#s_0').attr("disabled","disabled");
				$('#s_1').attr("disabled","disabled");
				$('#s_2').attr("disabled","disabled");
			}
		}
		 if(scheduleDate1 == "1"){
				 $('#s_0').removeAttr('disabled');
				$('#s_1').removeAttr('disabled');
				$('#s_2').removeAttr('disabled');
				if(vendor == "Thyrocare"){
					 $('#s_1').attr("disabled","disabled");
						$('#s_2').attr("disabled","disabled");
				 }
		} 
		if(scheduleDate1 == "2"){
			
			$('#s_0').removeAttr('disabled');
			$('#s_1').removeAttr('disabled');
			$('#s_2').removeAttr('disabled');
			if(vendor == "Thyrocare"){
				 $('#s_1').attr("disabled","disabled");
					$('#s_2').attr("disabled","disabled");
			 }
		}
		
		
		if (scheduleDate1 == 0) {
			dateDisplay = "Today"
		}
		if (scheduleDate1 == 1) {
			dateDisplay = "Tomorrow"
		}
		if (scheduleDate1 == 2) {
			dateDisplay = "Day After"
		}
	
});
			/*select schedule date -- end*/
			
			/*select schedule Time -- start*/
			 $(document).on('click', '.scheduleTimeBtn', function(){
				 document.getElementById("dupMessage").style.display = "none";
				 $('.scheduleTimeBtn').removeClass("suc-active");
				var scheduleTimeId = $(this).closest( "span" ).find('input[type="hidden"][name="scheduleTimeId"]').val();
				var scheduleTime = $(this).closest( "span" ).find('input[type="hidden"][name="scheduleTime"]').val();
				$(this).addClass("suc-active");
				pathologyTestsSchedueTime = scheduleTime;
				pathologyTestsSchedueTimeId = scheduleTimeId;
				//// alert(scheduleTime+scheduleTimeId);
				// console.log('scheduleTime: ' + pathologyTestsSchedueTime);
			}); 
			/*select schedule Time -- end*/
			
		/* }); */
		
		function showContent(){
			$(".secondstep").removeClass("action");
			if(pathologyTestsSelectedTotalArray.length!=0)
				{
			/* $("#orderDiv").hide();
			$("#selectionId").hide();
			$("#searchId").hide();
			showhideprogresscontainer(2); */
			$(".secondstep").addClass("action");
			 $(".step0").hide();
            $(".step1").show();
            $(".step2").hide();
            $(".step3").hide();
            $(".step4").hide();
			
		
		}
			else{
				$(".secondstep").removeClass("action");
				$("#testTypeMessage").text("Please select atleast one package");
				return false;
			}
		}
		
		
isSelected = false;
function showSelectedList(id){ 
	
	if($("#"+id).hasClass("suc-active"))
	{
		$("#"+id).removeClass("suc-active");
	}else{
		$("#"+id).addClass("suc-active");
	}
	
	if(isSelected)
	{
		isSelected = false;
	}
	else
	{
		isSelected = true;
	}
	showSelected(isSelected);
}
	
	
var packgeIds = [];
/* If it is unselected, then select, else don't select */
function getFiltered(id){
	var testTypeId = id;
	if(labelList[id] == "1")  
	{
		labelList[id] = "0";
		$("#" + id).removeClass("suc-active");
		return false;
	}
	else
	{
		labelList[id] = "1";
		$("#" + id).addClass("suc-active");
		return true;
	}
	return true;
		
}
function displayRow(selectedRow)
{
				var itemId = selectedRow.testId;
				var rowId =  'testSelected_'+ itemId ;
	if(selectedRow.toDisplay ==  ALL_BITS)
	{
//		 alert("Showing "  + selectedRow.toDisplay  + "   ==== " + selectedRow.desc )
		$('#' + rowId).show();
	}
	else
	{
//		 alert("Hiding "  + selectedRow.toDisplay  + "   ==== " + selectedRow.desc )
		$('#' + rowId).hide();
	}
}
function refreshByLabel(label, toShow)
{
			 $.each(labelMap[label],function(i, eachRow) {
				var itemId = eachRow.testId;
			
				var rowId =  'testSelected_'+ itemId ;
				var oldDisplay =  eachRow.toDisplay ;
				if(!toShow)
				{
					eachRow.toDisplay = oldDisplay & ~FILTER_LABEL;
				}
				else
				{
					eachRow.toDisplay = oldDisplay | FILTER_LABEL;
				}
				//alert(itemId);
				displayRow(eachRow);
			});
}
function showSelected(onlySelFlag)
{
			 $.each(globalPathologyTests,function(i, eachRow) {
				var itemId = eachRow.testId;
			
				var rowId =  'testSelected_'+ itemId ;
				var oldDisplay =  eachRow.toDisplay ;
				if(onlySelFlag)
				{
					if(eachRow.isSelected)
					{
						eachRow.toDisplay = oldDisplay | FILTER_SELECTED;
					}
					else
					{
						eachRow.toDisplay = oldDisplay  & ~FILTER_SELECTED;
					}
				}
				else
				{
						eachRow.toDisplay = oldDisplay | FILTER_SELECTED;
				}
				displayRow(eachRow);
			});
}
/* id is the name of the label. Enable or disable the label,
and based on the state, go through call the rows and show/hide the row 
*/
function filterAndRedraw(id)
{
	var toShow = getFiltered(id);
	 refreshByLabel(id, toShow);
}
function showRow(testName)
{
	$.each(globalPathologyTests, function(i, selectInfo)  {
		var oldDisplay = selectInfo.toDisplay ;
		if(testName == "")
		{
			selectInfo.toDisplay =  oldDisplay | FILTER_TEXT;
		}
		else
		{
			var idOf = selectInfo.desc.toLowerCase().indexOf(testName.toLowerCase());
			var idof1=selectInfo.testName.toLowerCase().indexOf(testName.toLowerCase());
			var idof2=selectInfo.price.toLowerCase().indexOf(testName.toLowerCase());
			if(idof1 != -1  || idOf != -1 || idof2!= -1 )
			{
				selectInfo.toDisplay =  oldDisplay | FILTER_TEXT;
			}
			else
			{
				selectInfo.toDisplay = oldDisplay & ~FILTER_TEXT;
			}
			// console.log(selectInfo.desc + " radax  =====  " + idOf);
		}
	
		//alert(selectInfo.testId);
		displayRow(selectInfo);
	});
}
function filterByName()
{
	var testName =$("#testName").val();
	//Showingalert(testName);
	showRow(testName.trim());
}
function aboutYourSelfShow(){
	$('.thirdstep').removeClass("action");
		if((pathologyTestsSchedueDate==null || pathologyTestsSchedueDate=="")||(pathologyTestsSchedueTime==null || pathologyTestsSchedueTime=="")){
			document.getElementById("dupMessage").style.display = "block";
			$("#dupMessage").text("please enter date and time");
			return false;
		}else{
			$('.thirdstep').addClass("action");
			$(".step1").hide();
            $(".step2").show();
            $(".step3").hide();
            $(".step4").hide();
            $(".step5").hide();
		// $("#signUpId").hide();
		//  $("#resetId").hide();
		}
	}
function showhideprogresscontainer(id){
	$("#multistepform-container2").hide();
	$("#multistepform-container3").hide();
	$("#multistepform-container4").hide();
	$("#multistepform-container5").hide();
	$("#multistepform-container"+id).show();
	
}
// alert("10");
function getCustomerDetails(id) {
	var phoneNo = $("#" + id).val();
	if ((phoneNo != "" && phoneNo != null) && phoneNo.length >= 10) {
		phoneNo = phoneNo.slice(-10);
		$.ajax({
			type : "POST",
			data : "phoneNo=" + phoneNo,
			url : baseUrl+"/getCustomerDetails.json",
			success : function(response) {
				// alert(response);
				if (response == -1) {
					$("#customerId").val("");
				} else {
					$("#customerId").val(response);
					// alert("exist");
				}
			},
			error : function(e) {
			}
		});
	}
}
function validateCustomer(){
	var phone= 	$("#phone").val();
	var passwordId = $("#passwordId").val();
	if(phone == null || phone ==""){
		if($('#phone').val().length == 0 ) {
		    $('#phone').css('color','red');
		    $("#phone").css("border-color","red");
		    $("#phone").attr("placeholder","Please enter phone number");
		    $('#phone').addClass('your-class');
		       }
		return false;
	}
	if(passwordId == null || passwordId ==""){
		if($('#passwordId').val().length == 0 ) {
		    $('#passwordId').css('color','red');
		    $("#passwordId").css("border-color","red");
		    $("#passwordId").attr("placeholder","Please enter password");
		    $('#passwordId').addClass('your-class');
		       }
		return false;
	}
	$.blockUI({
	    message: 'Please Wait',
	        css: {
	        	left:'25%',
	        }
	    });
	$.ajax({
		type : "POST",
		data:"mobileOrEmail="+phone+"&password="+passwordId,
		url : baseUrl+"/validate.htm",
		success : function(response) {
			$.unblockUI();
			if(response == "fail"){
				$("#passMessage").fadeIn(1000);
				$("#passMessage").text("Please enter valid password");
				$("#passMessage").fadeOut(5000);
			}else {
				$("#contactNum").attr("disabled","disabled");
				$("#password").attr("disabled","disabled");
			$("#signUpId").hide();
			$("#contactFormId").show();
			$.each(jQuery.parseJSON(response),function(i, customerInfo) {
				$("#contactNum").val(customerInfo.mobileNumber);
				$("#emailId").val(customerInfo.email);
				$("#contactAddr").val(customerInfo.address1);
				$("#password").val(customerInfo.password);
				$("#customerId").val(customerInfo.customerId);
			});
		} 
	},
		error : function(e) {
		}
	});
}
function resetClick(){
	 document.getElementById("resetForm").reset();
}
function forgotPassword(){
	$("#signUpId").hide();
	$("#resetId").show();
}
function addElement(labelMap, itemSelectedInfo)
{
	if(!itemSelectedInfo.label)
	{
		label = "Default";
	}
	else
		label = itemSelectedInfo.label.replace(/ /g, "_");
	tempObj = labelMap[label];
	if(!tempObj)
	{
		tempObj = new Array();
		labelMap[label] = tempObj;
	}
	tempObj.push(itemSelectedInfo);
	labelList[label] = "1";
}
</script>




<script>
function showSelectedListCalulateAmount(){ 
	if (pathologyTestsSelectedTotalArray.length > 0) {
		showhideprogresscontainer(4);
		//$("#itemContainer").html("");
		$("#itemContainerSum").html("");
		var totlAmount=0.0;
		var tempTotalPrice=0.0;
		var tempTotalDiscount=0;
		var tempTotalNetAmout=0;
		var discount=0;
		var tempTotalDiscount1=0;
		var servicetax=0;
		var totaldiscount=0;
		var tempTotalPrice1=0;
		var tempTotalNetAmout1=0;
		$.each(pathologyTestsSelectedTotalArray,function(i, itemSelectedInfo) {
							var testRowId = $( "#itemContainerSum tr" ).length+1;
							var tblRow ="<tr  id ='testSelected_"+ testRowId + "' name='test' >"
							 + "<td id='"
								+ itemSelectedInfo.unitId
								+ "' >"+testRowId+"</td>"	
								+ "<td  id='"
									+ itemSelectedInfo.unitId
									+ "'>"
									+ itemSelectedInfo.name
									+ "</td>"
									+ "<td style='display:none;' >"
									+ itemSelectedInfo.description
									+ "</td>"
									+ "<td>"
									+ itemSelectedInfo.price
									+ "</td>"
									+ "<td style='display:none;'>"
									+ itemSelectedInfo.discount +"%"
									+ "</td>" 
									+ "<td style='display:none;'>"
									+ itemSelectedInfo.netAmount
									+ "</td>" 
									+ "<td style='width:11%;'>"
									+"<img src='"+baseUrl+"/nbdimages/images/cross1.png' class='deleteSelectedItem' alt='logo' style='width: 40%;'>"
									+ "</td>"
									+ '</tr>';
									//alert(itemSelectedInfo.price);
									tempTotalPrice1=parseFloat((itemSelectedInfo.price).slice(4));
									tempTotalPrice = tempTotalPrice+tempTotalPrice1;
									//alert(tempTotalPrice);
									tempTotalNetAmout1=parseFloat((itemSelectedInfo.netAmount).slice(4));
									tempTotalNetAmout=tempTotalNetAmout+tempTotalNetAmout1;
									//alert(tempTotalNetAmout);
									tempTotalDiscount=parseFloat(itemSelectedInfo.discount);
									totaldiscount=totaldiscount+(tempTotalPrice1-tempTotalNetAmout1);
									//alert(tempTotalDiscount);
							$(tblRow).appendTo("#itemContainerSum");
						});
		
		
									
									tempTotalDiscount1=Math.ceil(tempTotalPrice*tempTotalDiscount)/100;
									//alert(tempTotalDiscount1);
									totalPrice=tempTotalPrice;
									totalDiscount=Math.ceil(tempTotalDiscount1);
									var serviceTax1=(tempTotalNetAmout*serviceTax)/100;
									serviceTax1=Math.ceil(serviceTax1);
									var sbceases1=(tempTotalNetAmout*sbcease)/100;
									sbceases1=Math.ceil(sbceases1);
									totalNetAmount=tempTotalNetAmout+serviceTax1+sbceases1;
									totalNetAmount=Math.ceil(totalNetAmount);
									
									$("#totalPriceId").text("Rs."+tempTotalPrice);
		$("#totalDiscountId").text("Rs."+totaldiscount.toFixed(2));
		$("#servicetaxId").text("Rs."+serviceTax1);
		$("#sbceasesId").text("Rs."+sbceases1);
		$("#totalNetAmountId").text("Rs."+totalNetAmount);
		//schedule  details..
		$("#scheduleDateDisplayId").text(dateDisplay+","+pathologyTestsSchedueTime);
		
		//contact details..
		$("#contactNumberDisplayId").text(contactNumber);
		$("#emailID").text(emailId);
		$("#addressID").text(contactAddress);
		$("#totalNetAmountId").show();
	} else {
		//$("#itemContainer").html("");
		$("#itemContainerSum").html("");
		$("#totalPriceId").hide();
		$("#totalDiscountId").hide();
		$("#totalNetAmountId").hide();
	}
	
}
    </script>


    <script type="text/javascript">
        $( document ).ready(function() {
        	 /* if ($.browser.msie  && parseInt($.browser.version, 10) === 9 && window.location.href.indexOf("%20")) 
        	    {
        	        document.location.href = String( document.location.href ).replace( /%20/, "" );
        	    }
        	    return false; */
        });
       
        $(document).on('click', '.firststep', function(){
       	 $(".step0").show();
       	 $(".step1").hide();
       	 $(".step2").hide();
       	 $(".step3").hide();
         $(".step4").hide();
       	
       }); 
        
        $(document).on('click', '.secondstep', function(){
        	showContent();
    	if($(this).hasClass("action")){
    		$(".step0").hide();
    		$(".step1").show();
    		$(".step2").hide();
    		$(".step3").hide();
    	    $(".step4").hide();
    	}
    	
    }); 
	
        $(document).on('click', '.thirdstep', function(){
        	showContent();
	 if($('.secondstep').hasClass('action')){
		 
			 aboutYourSelfShow();
	
		if($(this).hasClass("action")){
			$(".step0").hide();
			$(".step1").hide();
			$(".step2").show();
			$(".step3").hide();
		    $(".step4").hide();
		}
	 }
}); 
        $(document).on('click', '.fourthstep', function(){
        	
        	showContent();
    	 if($('.secondstep').hasClass('action')){
    		 aboutYourSelfShow();
    		 if($('.thirdstep').hasClass('action')){
    			 getContactDetails();
    		 }
    		 if($(this).hasClass("action")){
    			 $(".step0").hide();
    				$(".step1").hide();
    				$(".step2").hide();
    				$(".step3").show();
    			    $(".step4").hide();othersIds
    		 }
    	 }
    }); 
        
        
        
        $('.firststep').hover(function() {
            $(this).css('cursor','pointer');
        });
        $('.secondstep').hover(function() {
            $(this).css('cursor','pointer');
        });
        $('.thirdstep').hover(function() {
            $(this).css('cursor','pointer');
        });
        $('.fourthstep').hover(function() {
            $(this).css('cursor','pointer');
        });
function pathologyBookingNow(){
	$('#btn4').prop('disabled', true);
	var couponcodeId = null;
	var admin = false;
	var aurodiscountamount=0;
//alert(pathologyTestsSelectedTotalArray.length);
	 if(pathologyTestsSelectedTotalArray.length >0){
		 $('#cancel').prop('disabled', true);
			 showhideprogresscontainer(4);
			$("#yourOrderSummaryId").hide();
			$("#thanksId").show();
	 		var json = JSON.stringify(pathologyTestsSelectedTotalArray);
	 		var packageId = pathologyTestsSelectedTotalArray.map(function(i) {
	 			  return i.discount;
	 			});
	 		var packageId1 = globalPathologyTests.map(function(i) {
	 			  return i.discount;
	 			});
	 		var customerId = $("#customerId").val();
	 		if(customerId == null || customerId==""  ){
	 		}else{
	 			//password = null;
	 		}
	 		if(isCoupon){
	 			couponcodeId = $("#couponcodeId").val(); 
	 		}else{
	 			$("#couponcodeId").val(""); 
	 			couponcodeId = null;
	 		}
	 		$.ajax({
					type : "POST",
					url  :baseUrl+"/bookPackages.json",
		            data: {selectedTests:json,
		            	dateId:pathologyTestsSchedueDate,
		            	contactNumber:contactNumber,
		            	contactAddress:contactAddress,
		            	totalPrice:totalPrice,
		            	totalDiscount:totalDiscount,
		            	totalNetAmount:totalNetAmount,
		            	timeId:pathologyTestsSchedueTimeId,
		            	pathologyTestsSchedueTime:pathologyTestsSchedueTime,
		            	emailId:emailId,
		            	serviceId:serviceId,
		            	locationId:locationId,
		            	password:password,
		            	customerId:customerId,
		            	isPackageID:isPackageID,
		            	isOthersID:isOthersID,
		            	vendorId:vendorId,
		            	couponcodeId:couponcodeId,
		            	admin:admin,
		            	},
					success : function(response) {
						if (response != "" && response == "success") {	
							
						} else {
						}
					},
					error : function(e) {
					}
				});
	 		 $(".step3").hide();
	 	     $(".step4").show();
	 	}else{
	 		$("#bookMessage").text("Please select atleast one package");
	 		//alert();
	 			$(".step0").hide();
				$(".step1").hide();
				$(".step2").hide();
				$(".step3").show();
			    $(".step4").hide();
			    $(".step5").hide();
	 	} 
	
}
		function showContent(){
			$(".secondstep").removeClass("action");
			if(pathologyTestsSelectedTotalArray.length!=0)
				{
			/* $("#orderDiv").hide();
			$("#selectionId").hide();
			$("#searchId").hide();
			showhideprogresscontainer(2); */
			$(".secondstep").addClass("action");
			 $(".step0").hide();
            $(".step1").show();
            $(".step2").hide();
            $(".step3").hide();
            $(".step4").hide();
			
		
		}
			else{
				$(".secondstep").removeClass("action");
				$("#testTypeMessage").text("Please select atleast one package");
				return false;
			}
		}
		
		
		/*delete select pathology test -- start*/
		$(document).on('click', '.deleteSelectedItem', function(){
			var testIdToDelete = $(this).closest( "tr" ).find("td:first").attr("id");
			// // console.log('testid: ' + testIdToDelete);
			
			 $.each(pathologyTestsSelectedTotalArray,function(i, itemSelectedInfo) {
				// console.log('id: ' + itemSelectedInfo.unitId);
				//alert(itemSelectedInfo.itemId);
				var itemId = itemSelectedInfo.unitId;
				if (itemId == testIdToDelete) {
					pathologyTestsSelectedTotalArray.splice(i, 1);
					$("#r_"+itemSelectedInfo.unitId).removeClass("suc-active");
					//return false;
				}
			 
			});
			 $(this).closest('tr').remove();
			 getContactDetails();
			var length =pathologyTestsSelectedTotalArray.length;
	        $("#selected_list").attr('value', 'Selected '+length);
	        if(pathologyTestsSelectedTotalArray.length<=0){
	        	$.each(globalPathologyTests,function(i, eachRow) {
					$('#r_'+eachRow.testId).removeAttr('disabled');
					});
	        	isOthersID = false;
	        	isPackageID = false;
	        }
	        showSelectedListCalulateAmount();
	        getContactDetails();
		});
		/*delete select pathology test -- end*/
	
function getContactDetails(){
	 $(".fourthstep").removeClass("action");
	if($('#contactNum').val().length == 0 ||  $('#emailId').val().length == 0 || $('#contactAddr').val().length == 0 ){
		if($('#contactNum').val().length == 0 ) {
		    $('#contactNum').css('color','red');
		    $("#contactNum").css("border-color","red");
		    $("#contactNum").attr("placeholder","Please enter phone number");
		    $('#contactNum').addClass('your-class');
		       }
		
		if($('#emailId').val().length == 0 ) {
		    $('#emailId').css('color','red');
		    $("#emailId").css("border-color","red");
		    $("#emailId").attr("placeholder","Please enter email");
		    $('#emailId').addClass('your-class');
		       }
		if($('#contactAddr').val().length == 0 ) {
		    $('#contactAddr').css('color','red');
		    $("#contactAddr").css("border-color","red");
		    $("#contactAddr").attr("placeholder","Please enter address");
		    $('#contactAddr').addClass('your-class');
		       }
		
		return false;
		
	}
		 var val3=$('#contactNum').val();
		 val3 = val3.slice(-10);
		 var val5=$('#contactNum').val().length;
		 var val4=$('#emailId').val();
		
		 var regex1=new RegExp("^[0-9 ]+$");
		 var regex2= /^[_a-z0-9]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/;
		 
		 if($('#contactNum').val().length != 0 ||  $('#emailId').val().length != 0 || $('#contactAddr').val().length != 0 ){
			 $('#contactNum').css('color','black');
				contactNum=$("#contactNum").val();
				if(contactNum.charAt(0) == '+'){
					m_pat=/^[6-9,+][0-9]{12}$/;
					if(!m_pat.test(contactNum))
					{
						$("#contactMessage").text("Enter valid phone number");
					//	$("#contactNum").focus();
						 $('#contactNum').css('color','red');
						    $("#contactNum").css("border-color","red");
					return false;
					}else{
						$("#contactMessage").text(" ");
					}
				}
				contactNum = contactNum.slice(-10);
				m_pat=/^[6-9,+][0-9]{9}$/;
				if(!m_pat.test(contactNum))
				{
					$("#contactMessage").text("Enter valid mobile number");
					//$("#contactNum").focus();
					 $('#contactNum').css('color','red');
					    $("#contactNum").css("border-color","red");
				return false;
				}else{
					$("#contactMessage").text(" ");
				}
 		    
	    if(!(regex2.test(val4))){
	    	//// alert("enter valid email");
	    	 $("#contactMessage").text("Enter valid email");
	    	$('#emailId').css('color','red');
		    $("#emailId").css("border-color","red");
		   
	    	return false;
	    	} 
		
		 } 
		 
		/*  if (!isAddress) {
				$("#contactMessage").text("Please enter valid full address");
			} else {
				$("#contactMessage").text(" ");
			}
			if (!isTrue) {
				$("#contactMessage").text("Please enter valid Email");
			} else {
				$("#contactMessage").text(" ");
			} */
			/* if (isTrue && isAddress) { */
				 $(".fourthstep").addClass("action");
				    $(".step0").hide();
				    $(".step1").hide();
				    $(".step2").hide();
				    $(".step3").show();
				    $(".step4").hide();
					
				  var phoneNo =  $("#contactNum").val();
				  if (!otpIsCreated) {
				        if((phoneNo != "" && phoneNo != null) && phoneNo.length >= 10){
				        	
				          phoneNo = phoneNo.slice(-10);
				          $.ajax({
				            type : "GET",
				            data:"phoneNo="+phoneNo,
				            url : baseUrl+"/createOtp.json",
				            success : function(response) {
				            	otpIsCreated = true;
				            }
				 
				          });
				          otpIsCreated = true;
				        }
					
				  } 
				  /* var tblRow1 ="";
				  phoneNo = phoneNo.slice(-10);
				  isDiscount= false;
				  $.ajax({
			            type : "GET",
			            data:"phoneNo="+phoneNo,
			            url : baseUrl+"/customerExist.json",
			            success : function(response) {
			            	//alert(response.sCustomerDiscount);
			            	//alert(response.noOfcustomers);
			            	globalCurstomrDisocunt = response;
			            	 customerDiscout = parseInt(response.sCustomerDiscount);
			            	//alert(customerDiscout);
			            	noOfcustomers = response.noOfcustomers;
			            	if(noOfcustomers == 0){
			            		if(!isDiscount){
			            		tblRow1 ="<tr >"
				            		 +"<td></td>"
									 + "<td>"+"your discount"+"</td>"	
									 + "<td>"+aurodiscountamount+"</td>"
				            		+"</tr>";
				            		$(tblRow1).appendTo("#itemContainerSum"); 
				            		totalNetAmount = parseInt(totalNetAmount) - customerDiscout;
				            		if(totalNetAmount<=0){
				            			totalNetAmount = 0;
				            		}
				            		$("#totalNetAmountId").text("Rs."+totalNetAmount);
				            		isDiscount = true;
			            		}
			            	}else{
			            		existingCustomerDiscount = response.existingCustomerDiscount;
			            		if(!isDiscount){
			            			tblRow1 ="<tr >"
					            		 +"<td></td>"
										 + "<td>"+"your discount"+"</td>"	
										 + "<td>"+aurodiscountamount+"</td>"
					            		+"</tr>";
					            		$(tblRow1).appendTo("#itemContainerSum"); 
					            		totalNetAmount = parseInt(totalNetAmount) - existingCustomerDiscount;
					            		if(totalNetAmount<=0){
					            			totalNetAmount = 0;
					            		}
					            		$("#totalNetAmountId").text("Rs."+totalNetAmount);
					            		isDiscount = true;
			            	}
			            } 
			            }
			            	
			            }); */
							contactNumber = $('#contactNum').val();
							contactNumber = contactNumber.slice(-10);
							contactAddress = $('#contactAddr').val();
							//// alert(password);
							emailId =$("#emailId").val();
							showSelectedListCalulateAmount();
			/* } */
	}
/* function  getCustomerDetails(id){
	var phoneNo = $("#"+id).val();
	if((phoneNo != "" && phoneNo != null) && phoneNo.length >= 10){
	phoneNo = phoneNo.slice(-10);
	$.ajax({
		type : "POST",
		data:"phoneNo="+phoneNo,
		url : "getCustomerDetails.htm",
		success : function(response) {
			if (response == "exist") {
				$("#contactFormId").hide();
				$("#signUpId").show();
				$("#phone").val(phoneNo);
				$("#pnum").val(phoneNo);
				$('#phone').prop('disabled', true);
				$('#pnum').prop('disabled', true);
				$("#passwordId").val("");
				$("#rpassword").val("");
			} else {
			}
		},
		error : function(e) {
		}
	});
	}
} */
function CouponCode(){
	var couponcodeId = $("#couponcodeId").val();
	if(couponcodeId !=""){
	var aurodiscount=null;
	var aurodiscountamount=0;
	var totalauronetamount=0;
	var servicetax=0;
	var sbcease1=0;
	var totalprice1=0;
	var discountprice=0;
	var packageId = pathologyTestsSelectedTotalArray.map(function(i) {
		  return i.discount;
		});
	
	$.ajax({
		 type : "POST",
		    data:"couponcodeId="+couponcodeId+"&serviceId="+serviceId,
		    url : baseUrl+"/validateCouponcode.json",
		    success : function(response) {
		    	//alert(response);
		    	//aurodiscount= parseInt(response);
		    	$("#trid").remove(); 
		      if(response == false){
		    	/*   
		    	  tblRow1 ="<tr id='trid'>"
	            		 +"<td></td>"
						 + "<td>"+"your discount"+"</td>"	
						 + "<td>"+aurodiscountamount+"</td>"
	            		+"</tr>";
	            		$(tblRow1).appendTo("#itemContainerSum");  */
	            		
		        document.getElementById("validId").style.display = "none";
		        document.getElementById("invalidId").style.display = "block";
		      }else{
		    	  isCoupon = true;
		    	 $.each(pathologyTestsSelectedTotalArray, function(i,discountpackage){
		    	  aurodiscountamount= aurodiscountamount+(((discountpackage.price).slice(4))*discountpackage.couponCodeDiscount)/100;
		    	  console.log(discountpackage.price+" "+discountpackage.couponCodeDiscount);
		    	  discountprice=discountprice+(discountpackage.price-discountpackage.netamount);
		    	  
		    	 }),
		    	
		    		aurodiscountamount=Math.ceil(aurodiscountamount);
		    	 totalauronetamount=totalPrice-aurodiscountamount;
		    	 servicetax=(totalauronetamount*serviceTax)/100;
		    	 servicetax=Math.ceil(servicetax);
		    	 sbcease1=(totalauronetamount*sbcease)/100;
		    	 sbcease1=Math.ceil(sbcease1);
		    	 totalprice1=totalauronetamount+servicetax+sbcease1;
		    	 $("#totalPriceId").text("Rs."+totalPrice);
		    	 if(aurodiscountamount == 0){
		    		 document.getElementById("validId").style.display = "none";
				        document.getElementById("invalidId").style.display = "block";
		    		 return false ;
		    	 }{
		    		 $("#totalDiscountId").text("Rs."+aurodiscountamount);
		    	 }
		 		$("#totalDiscountId").text("Rs."+aurodiscountamount);
		 		$("#servicetaxId").text("Rs."+servicetax);
		 		$("#sbceasesId").text("Rs."+sbcease1);
		 		totalDiscount = aurodiscountamount;
		 		totalNetAmount=Math.ceil(totalprice1);
		 		totalNetAmount=totalNetAmount.toFixed(2);
		 		$("#totalNetAmountId").text("Rs."+totalNetAmount);
			    document.getElementById("validId").style.display = "block";
			    document.getElementById("invalidId").style.display = "none";
		      }
		    }
	});
	}
} 
function validateCustomer(){
	var phone= 	$("#phone").val();
	var passwordId = $("#passwordId").val();
	if(phone == null || phone ==""){
		if($('#phone').val().length == 0 ) {
		    $('#phone').css('color','red');
		    $("#phone").css("border-color","red");
		    $("#phone").attr("placeholder","Please enter phone number");
		    $('#phone').addClass('your-class');
		       }
		return false;
	}
	if(passwordId == null || passwordId ==""){
		if($('#passwordId').val().length == 0 ) {
		    $('#passwordId').css('color','red');
		    $("#passwordId").css("border-color","red");
		    $("#passwordId").attr("placeholder","Please enter password");
		    $('#passwordId').addClass('your-class');
		       }
		return false;
	}
	$.blockUI({
	    message: 'Please Wait',
	        css: {
	        	left:'25%',
	        }
	    });
	$.ajax({
		type : "POST",
		data:"mobileOrEmail="+phone+"&password="+passwordId,
		url : baseUrl+"/validate.htm",
		success : function(response) {
			$.unblockUI();
			if(response == "fail"){
				$("#passMessage").fadeIn(1000);
				$("#passMessage").text("Please enter valid password");
				$("#passMessage").fadeOut(5000);
			}else {
				$("#contactNum").attr("disabled","disabled");
				$("#password").attr("disabled","disabled");
			$("#signUpId").hide();
			$("#contactFormId").show();
			$.each(jQuery.parseJSON(response),function(i, customerInfo) {
				$("#contactNum").val(customerInfo.mobileNumber);
				$("#emailId").val(customerInfo.email);
				$("#contactAddr").val(customerInfo.address1);
				$("#password").val(customerInfo.password);
				$("#customerId").val(customerInfo.customerId);
			});
		} 
	},
		error : function(e) {
		}
	});
}
function resetClick(){
	 document.getElementById("resetForm").reset();
}
function forgotPassword(){
	$("#signUpId").hide();
	$("#resetId").show();
}
function resetPassword(){
	var pnum = $("#pnum").val();
	var password = $("#rpassword").val();
	if(pnum == null || pnum == ""){
		return false;
	}
	if(password == null || password == ""){
		if($('#rpassword').val().length == 0 ) {
		    $('#rpassword').css('color','red');
		    $("#rpassword").css("border-color","red");
		    $("#rpassword").attr("placeholder","Please enter new password");
		    $('#rpassword').addClass('your-class');
		       }
		return false;
	}
	if(password.length < 6)
	 {
	 $("#resetmessage").text("Warning:password should be 6 charcters");
		$("#rpassword").focus();
		 $('#rpassword').css('color','red');
		    $("#rpassword").css("border-color","red");
	 return false;
	 }else{
		 $("#resetmessage").text(" ");
	 }
	$.blockUI({
	    message: 'Please Wait',
	        css: {
	        	left:'25%',
	        }
	    });
	//// alert(pnum);
	$.ajax({
		type : "POST",
		data:"password="+password+"&pnum="+pnum,
		url : baseUrl+"/resetPassword.htm",
		/* dataType : "json", */
		success : function(response) {
			$.unblockUI();
			if (response = "sucess") {
				$("#resetId").hide();
				$("#signUpId").show();
				$("#contactNum").val("");
				$("#password").val("");
				$("#passwordId").val("");
				$("#emailId").val("");
				$("#contactAddr").val("");
				$("#passwordId").val("");
			}
		}
		});
	
}
function addressIsValid() {
	// alert();
	var address = $("#contactAddr").val();
	if (address != 0) {
		isAddress = false;
		$.blockUI({
	           message: 'Please Wait',
	               css: {
	                       left:'25%',
	               }
	           });
		$.ajax({
			type : "POST",
			data : "address=" + address,
			url : baseUrl+"/addressIsValid.json",
			success : function(response) {
				$.unblockUI(); 
				// alert(response);
				if (response) {
					
					$("#contactMessage").text(" ");
					isAddress = true;
				} else {
					// alert();
					$("#contactMessage").text("Please enter valid full address");
					$('#contactAddr').css('color', 'red');
					$("#contactAddr").css("border-color", "red");
					isAddress = false;
					return false;
					
				}
			}
		});
	}
}
 function emailValidation(){
	email=$("#emailId").val();
	e_pat=/^[_a-z0-9]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/;
	if(!e_pat.test(email))
	{
		$("#contactMessage").text("Enter valid email");
		//$("#emailId").focus();
		 $('#emailId').css('color','red');
		    $("#emailId").css("border-color","red");
	return false;
	}else{
		$("#contactMessage").text(" ");
	}
	 /* if($('#emailId').val().length != 0){
		  isTrue = false;
		  $.blockUI({
	           message: 'Please Wait',
	               css: {
	                       left:'25%',
	               }
	           });
	    	$.ajax({
				type : "POST",
				data:"email="+email,
				url : "emailIsValid.json",
				success : function(response) {
					//// alert(response);
					$.unblockUI();
					if (response) {
						isTrue = true;
						}else{
							$("#contactMessage").text("Enter valid email");
							 $('#emailId').css('color','red');
							    $("#emailId").css("border-color","red");
							    isTrue = false;
							return false;
						}
					
					}
			});	
	    	
	    } */
	    
} 
function addElement(labelMap, itemSelectedInfo)
{
	if(!itemSelectedInfo.label)
	{
		label = "Default";
	}
	else
		label = itemSelectedInfo.label.replace(/ /g, "_");
	tempObj = labelMap[label];
	if(!tempObj)
	{
		tempObj = new Array();
		labelMap[label] = tempObj;
	}
	tempObj.push(itemSelectedInfo);
	labelList[label] = "1";
}
		function populateUiMatrix(listPathologyTests){
		globalPathologyTests = listPathologyTests;
			labelMap = new Array();
			
			if (listPathologyTests == "") {
				/* $("#itemContainer").html(""); */
				$("#itemContainerSum").html("");
			} else {
				var totlAmount=0;
				var tempTotalPrice=0;
				var tempTotalDiscount=0;
				var tempTotalNetAmout=0;
				var discount=0;
				var retval = {};
				$.each(listPathologyTests,function(i, itemSelectedInfo) {
					var resultDiscount=0;
					var youPay=0;
					var count = 0;
					
					addElement(labelMap, itemSelectedInfo);
			/* Modify the test description from "-" to <br/>" */
					var array = itemSelectedInfo.testDesc.split("-");
					itemSelectedInfo.isSelected = false;
					var desc = '';
					$.each(array,function(ind,val)
					{
						if(desc == "")
						{
						}
						else
						{
							desc = desc + '<br>';
						}
							desc = desc + val;
					}); 
					
					itemSelectedInfo.desc = desc;
					/* The following flag is to check if it has to be displayed or not .
					When we type the label, we check on the current state of the row and based on that
					further filter */
					itemSelectedInfo.toDisplay = ALL_BITS;
					resultDiscount= itemSelectedInfo.price*(itemSelectedInfo.discount/100);
					youPay=(itemSelectedInfo.price)-resultDiscount;
					itemSelectedInfo.youPay = youPay;
				});
			}
		
		}
</script>



<script>
		
$(document).ready(function () {
    for (var i = 1; i < 8; i++) {
        $(".step" + i).hide();
    }
    $("#btn0").click(function () {
    	showContent();
    });
    $("#btn1").click(function () {
    	aboutYourSelfShow();
    });
    $("#btn3").click(function () {
    	getContactDetails();
    });
    $("#btn4").click(function () {
    	otp();
    });
	$("#btn5").click(function () {
        $(".step4").hide();
        $(".step5").show();
    });
	
});
    </script>




    <script type="text/javascript">
        $( document ).ready(function() {
        });
       
        $(document).on('click', '.firststep', function(){
       	 $(".step0").show();
       	 $(".step1").hide();
       	 $(".step2").hide();
       	 $(".step3").hide();
         $(".step4").hide();
       	
       }); 
        
        $(document).on('click', '.secondstep', function(){
        	showContent();
    	if($(this).hasClass("action")){
    		$(".step0").hide();
    		$(".step1").show();
    		$(".step2").hide();
    		$(".step3").hide();
    	    $(".step4").hide();
    	}
    	
    }); 
	
        $(document).on('click', '.thirdstep', function(){
        	showContent();
	 if($('.secondstep').hasClass('action')){
		 
			 aboutYourSelfShow();
	
		if($(this).hasClass("action")){
			$(".step0").hide();
			$(".step1").hide();
			$(".step2").show();
			$(".step3").hide();
		    $(".step4").hide();
		}
	 }
}); 
        $(document).on('click', '.fourthstep', function(){
        	
        	showContent();
    	 if($('.secondstep').hasClass('action')){
    		 aboutYourSelfShow();
    		 if($('.thirdstep').hasClass('action')){
    			 getContactDetails();
    		 }
    		 if($(this).hasClass("action")){
    			 $(".step0").hide();
    				$(".step1").hide();
    				$(".step2").hide();
    				$(".step3").show();
    			    $(".step4").hide();
    		 }
    	 }
    }); 
        
        
        
        $('.firststep').hover(function() {
            $(this).css('cursor','pointer');
        });
        $('.secondstep').hover(function() {
            $(this).css('cursor','pointer');
        });
        $('.thirdstep').hover(function() {
            $(this).css('cursor','pointer');
        });
        $('.fourthstep').hover(function() {
            $(this).css('cursor','pointer');
        });
		$( document ).ready(function() {
			fetchAllPackages(serviceId,locationId);
		});
function otp(){
  var otp= $("#otpId").val();
  $.ajax({
    type : "GET",
    data:"otp1="+otp
      +"&phoneNo="+contactNumber,
    url : baseUrl+"/showOtp.htm",
    success : function(response) {
    //  // alert(response);
      if(response == "success"){
        pathologyBookingNow();
        /* $(".step3").hide();
        $(".step4").show(); */
        /* $("#bookMessage").text(" "); */
      }else{
        $(".step3").show();
        $(".step4").hide();
        $("#bookMessage").text("Please enter valid otp").css('color','red');
        return false;
      }
      //// alert(response);
      }
  });
}
function flagSelected(testId, flag)
{
	$.each(globalPathologyTests, function(i, selectInfo)  {
			if(selectInfo.testId == testId)
			{
				selectInfo.isSelected = flag;
			}
	
	});
}
    
function applyCouponCode(){
	var coupon = $("#couponcodeId").val();
	$.ajax({
		 type : "POST",
		    data:"couponCode="+coupon,
		    url : baseUrl+"/validateCoupon.json",
		    success : function(response) {
		    	//alert(response);
		      if(response == null || response == ""){
		        document.getElementById("validId").style.display = "none";
		        document.getElementById("invalidId").style.display = "block";
		      }else{
		    	  isCoupon = true;
			    document.getElementById("validId").style.display = "block";
			    document.getElementById("invalidId").style.display = "none";
		      }
		    }
	});
} 
</script>
</body>
</html>
