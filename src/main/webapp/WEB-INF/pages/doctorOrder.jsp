<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aurospaces</title>
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

<style>
.your-class::-webkit-input-placeholder {
    color: red;
}
.default-class::-webkit-input-placeholder {
    color: red;
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
    <div class="header1">
        <div class="container-main">
            <div class="logo">
                <a href="auroHome.htm">
                    <img src="${baseUrl}/images/logo.png" width="70" height="63" alt="logo image" />
                    <div class="name">
                        <h3>Aurospaces</h3>
                        <div class="clearfix"></div>
                        <p>One space for all services</p>
                    </div>
                </a>
            </div>
        </div>

    </div>

    <div class="container-main">
        <div class="col-md-5 col-sm-5 left-section hidden-xs">
            <img src="${baseUrl}/nbdimages/images/img-1.jpg" alt="doctor image" class="img-responsive"/>
            <h3>We guarantee Best Doctors and Specialists at your location</h3>
            <p>  No more waiting for long hours in Clinics</p>
            <p> No more wasting time in Traffic</p>
            <p> No more ignoring of your health for time, company confusion.</p>

        </div>



      <!------------------------1st message-------------------------------->
  <div class="col-md-7 col-sm-7 right-content step0" id="message">
  
    <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
      <div class="clearfix">&nbsp;</div>
      <img src="${baseUrl}/nbdimages/images/img-1.jpg" alt="doctor image" alt="nursing image" class="img-responsive" />
       <h3>We guarantee Best Doctors and Specialists at your location</h3>
            <p>  No more waiting for long hours in Clinics</p>
            <p> No more wasting time in Traffic</p>
            <p> No more ignoring of your health for time, company confusion.</p>
    </div> 
  <div class="row no-mar wizardstep">
      <div class="stepwizard-row">
        <div class="stripebar2"></div>
        <div class="col-md-2 col-sm-2 col-xs-2 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 stage">
          <div class="list active firststep" >1</div>
          <p>Doctor Type</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list secondstep">2</div>
          <p>Symptoms</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list thirdstep">3</div>
          <p>Date & Time</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fourthstep">4</div>
          <p>Contact Info</p>
        </div>
         <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fifthstep">5</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
     
    <!--end of progress bar-->
    <div class="forms">
    <div class="block-content">
    <div class="clearfix hidden-xs">&nbsp;</div>
     <div class="clearfix hidden-xs">&nbsp;</div>
    						 	<input type="hidden" id="serviceId"  value="${serviceId}"/>
								<input type="hidden" id="locationId"  value="${locationId}"/>
     							<input type ="hidden" value="${baseUrl }" id="baseUrl">
   				 <c:choose>  
								<c:when test="${not empty doctorTypes }">
								<c:forEach var="eachType" items="${doctorTypes}">
								<div class="row no-marg">
     							 <div class="col-md-4 col-sm-4 col-md-offset-4 col-sm-offset-4">
								<span><input class="btn btn-lg btn-block btn-date listDoctorTypesBtn"   id="${eachType.name }" type="button"  
									value="${eachType.name}" />
								<input type="hidden" name="listDoctorTypes"  value="${eachType.name}"/>
								<input type="hidden" name="listDoctorTypesId"  value="${eachType.id}"/></span>
								</div>
       							</div>
								<div class="clearfix">&nbsp;</div>
								</c:forEach>
								</c:when>
				</c:choose>
     
        
      </div>
      <div class="alert-danger " id="doctorMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"> </div>
      <div class="col-md-12 col-xs-12 col-lg-12 no-pad"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block " id="btn0" type="submit">Next</a></div>
    </div>
    <!--end of message section--> 
  </div>
  <!-- end of message section--> 
  <!------------------------2nd message-------------------------------->
  <div class="col-md-7 col-sm-7 right-content step1" id="timings">
  
   <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
      <div class="clearfix">&nbsp;</div>
      <img src="${baseUrl}/nbdimages/images/img-1.jpg" alt="doctor image" alt="nursing image" class="img-responsive" />
       <h3>We guarantee Best Doctors and Specialists at your location</h3>
            <p>  No more waiting for long hours in Clinics</p>
            <p> No more wasting time in Traffic</p>
            <p> No more ignoring of your health for time, company confusion.</p>
    </div> 
   <div class="row no-mar wizardsteps">
     <div class="stepwizard-row">
        <div class="stripebar2"></div>
        <div class="col-md-2 col-sm-2 col-xs-2 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 stage">
          <div class="list firststep" >1</div>
          <p>Doctor Type</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list active secondstep">2</div>
          <p>Symptoms</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list thirdstep">3</div>
          <p>Date & Time</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fourthstep">4</div>
          <p>Contact Info</p>
        </div>
         <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fifthstep">5</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
     
    <!--end of progress bar-->
    
    <div class="forms dates">
   			          <c:if test="${not empty listSymptoms }">
   			          <div class="block-content">
						<c:forEach var="symptom" items="${listSymptoms}"  varStatus="status">
						   <c:if test="${status.index ==0 || status.index ==4}">
						     <div class="row no-marg">
						   </c:if>
						  <div class="col-md-3 col-sm-3">
							<span><input class="btn btn-lg btn-block btn-date  listSymptomsBtn"   id="${symptom.id }" type="button"  value="${symptom.name}" onclick="listSymptomsClick(this.id);"  />
							<input type="hidden" name="${symptom.id }"  value="${symptom.name }"/></span>
		 				  </div>
		 				   <c:if test="${status.index !=3 || status.index !=7}">
		 				    <div class="clearfix visible-xs">&nbsp;</div>
		 				   </c:if>
		 				  <c:if test="${status.index ==3 || status.index ==7}">
						     </div>
						     
						     <div class="clearfix">&nbsp;</div>
						     <c:if test="${ status.index == 7}">
						      <div class="col-md-12"> <textarea maxlength="250" id="symptomsTextId" rows="4" placeholder="Please Enter Problem Description upto 250 characteres" class="form-control"> </textarea></div>
						     <div class="clearfix">&nbsp;</div> 
						     <div class="clearfix">&nbsp;</div> 
      							 <div class="col-md-12 col-xs-12 col-lg-12 no-pad"> <a href="javascript:;" id="btn1"  class="btn btn-primary btn-lg btn-block" type="submit">Next</a></div>
						      </c:if>
						   </c:if>
						 </c:forEach>
					  
					   </c:if>
					   </div>
      </div>
    </div>
    <!--end of message section--> 
  <!-- </div> -->
  <!-- end of timings section--> 
  <!------------------------3rd message-------------------------------->
  <div class="col-md-7 col-sm-7 right-content step2 " id="info">
      <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
      <div class="clearfix">&nbsp;</div>
      <img src="${baseUrl}/nbdimages/images/img-1.jpg" alt="doctor image" alt="nursing image" class="img-responsive" />
       <h3>We guarantee Best Doctors and Specialists at your location</h3>
            <p>  No more waiting for long hours in Clinics</p>
            <p> No more wasting time in Traffic</p>
            <p> No more ignoring of your health for time, company confusion.</p>
    </div>  
   <div class="row no-mar wizardsteps">
     <div class="stepwizard-row">
        <div class="stripebar2"></div>
        <div class="col-md-2 col-sm-2 col-xs-2 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 stage">
          <div class="list firststep">1</div>
          <p>Doctor Type</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list secondstep">2</div>
          <p>Symptoms</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list active thirdstep">3</div>
          <p>Date & Time</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fourthstep">4</div>
          <p>Contact Info</p>
        </div>
         <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fifthstep">5</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
 
    <!--end of progress bar-->
    
    <div class="forms dates">
  <div class="block-content">
      <div class="row no-marg">
        <h3>Pick a day</h3>
        <div class="clearfix">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
          <span><input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date   scheduleDateBtn" value="Today">
          <input type="hidden" name="scheduleDate"  value="0"/></span>
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
         <span> <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date   scheduleDateBtn" value="Tomorrow">
         <input type="hidden" name="scheduleDate"  value="1"/></span>
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
          <span><input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date  scheduleDateBtn" value="Day After">
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
      </div>
      <div class="clearfix visible-xs">&nbsp;</div>
      <div class="alert-danger" id="dupMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
       <div class="col-md-12 col-xs-12 col-lg-12 no-pad"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block " id="btn2" type="submit">Next</a></div>
    </div>
    <!--end of message section--> 
  </div>
  <!-- end of inputs section--> 
  <!------------------------4th message-------------------------------->
  <div class="col-md-7 col-sm-7 right-content step3" id="details">
     <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
      <div class="clearfix">&nbsp;</div>
      <img src="${baseUrl}/nbdimages/images/img-1.jpg" alt="doctor image" alt="nursing image" class="img-responsive" />
       <h3>We guarantee Best Doctors and Specialists at your location</h3>
            <p>  No more waiting for long hours in Clinics</p>
            <p> No more wasting time in Traffic</p>
            <p> No more ignoring of your health for time, company confusion.</p>
    </div>
  
   <div class="row no-mar wizardsteps">
     <div class="stepwizard-row">
        <div class="stripebar2"></div>
        <div class="col-md-2 col-sm-2 col-xs-2 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 stage">
          <div class="list firststep">1</div>
          <p>Doctor Type</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list secondstep">2</div>
          <p>Symptoms</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list thirdstep">3</div>
          <p>Date & Time</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list active fourthstep">4</div>
          <p>Contact Info</p>
        </div>
         <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fifthstep">5</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
    
    <!--end of progress bar-->
   <%@include file="contactForm.jsp" %> 
    
    <!--end of message section--> 
    
    
    
    
    
    
    
    
  </div>
  <!-- end of book section--> 
  <!------------------------5th message-------------------------------->
  <div class="col-md-7 col-sm-7 right-content step4" id="conformation">
  <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
      <div class="clearfix">&nbsp;</div>
      <img src="${baseUrl}/nbdimages/images/img-1.jpg" alt="doctor image" alt="nursing image" class="img-responsive" />
       <h3>We guarantee Best Doctors and Specialists at your location</h3>
            <p>  No more waiting for long hours in Clinics</p>
            <p> No more wasting time in Traffic</p>
            <p> No more ignoring of your health for time, company confusion.</p>
    </div>
     <div class="clearfix visible-xs">&nbsp;</div> 
   <div class="stepwizard-row">
        <div class="stripebar2"></div>
        <div class="col-md-2 col-sm-2 col-xs-2 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 stage">
          <div class="list firststep">1</div>
          <p>Doctor Type</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list secondstep">2</div>
          <p>Symptoms</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list thirdstep">3</div>
          <p>Date & Time</p>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list fourthstep">4</div>
          <p>Contact Info</p>
        </div>
         <div class="col-md-2 col-sm-2 col-xs-2 stage">
          <div class="list active fifthstep">5</div>
          <p>Booking</p>
        </div>
      </div>
     <div class="clearfix"></div>
    <div class="forms dates">
    <div class="block-content">
      <div class="row no-marg">
        <div class="col-md-4 col-sm-4 col-xs-12 text-left">
          <label>Doctor</label>
        </div>
        <div class="col-md-8 col-sm-8 col-xs-12 text-left">
          <p id="doctorCatageryId"></p>
        </div>
      </div>
      <div class="clearfix">&nbsp;</div>
      <div class="row no-marg">
        <div class="col-md-4 col-sm-4 col-xs-12 text-left">
          <label>Symptoms</label>
        </div>
        <div class="col-md-8 col-sm-8 col-xs-12 text-left">
          <p  id="symptomsId"></p>
        </div>
      </div>
      <div class="clearfix">&nbsp;</div>
      <div class="row no-marg">
        <div class="col-md-4 col-sm-4 col-xs-12 text-left">
          <label>Schedule</label>
        </div>
        <div class="col-md-8 col-sm-8 col-xs-12 text-left">
          <p id="dayAndTime"></p>
        </div>
      </div>
      <div class="clearfix">&nbsp;</div>
      <div class="row no-marg">
        <div class="col-md-4 col-sm-4 col-xs-12 text-left">
          <label>Contact</label>
        </div>
        <div class="col-md-8 col-sm-8 col-xs-12 text-left">
          <p id="contactNoId"></p>
          <p id="contactNameId"></p>
          <p id="addressId"></p>
        </div>
      </div>
      <!--  <div class="clearfix">&nbsp;</div> -->
      <div class="row no-marg">
        <div class="col-md-4 col-sm-4 col-xs-12 text-left">
          <label>Price</label>
        </div>
        <div class="col-md-8 col-sm-8 col-xs-12 text-left">
          <p id="priceId"></p>
        </div>
      </div>
      <div class="row no-marg">
        <div class="col-md-4 col-sm-4 col-xs-12 text-left">
          <label>OTP</label>
        </div>
        <div class="col-md-8 col-sm-8 col-xs-12 text-left">
          <p><input type="text" class="otp" placeholder="Enter OTP " id="otpId" size="35"></p>
        </div>
      </div>
      <div class="row no-marg">
                <div class="col-md-4 col-sm-8 col-xs-12 text-left">
                        <label>Couponcode</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p><input type="text" class="coupon" name="couponcode" id="couponcodeId" placeholder ="couponcode" size="35"><button class="btn btn-success sucess" >Apply</button></p>
                    </div>
       </div>
      </div>
      <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div> 
      <div id="otpMessageId"></div>
     <div class="clearfix visible-sm visible-xs">&nbsp;</div>
      <div class="col-md-6 col-sm-6"> <a href="./" class="btn btn-primary btn-lg cancel btn-block" type="submit">Cancel</a></div><div class="clearfix visible-xs">&nbsp;</div>
      <div class="col-md-6 col-sm-6"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block " id="btn4" type="submit">Book Now</a></div>
    </div>
    <!--end of message section--> 
  </div>
  <!-- end of conformation section--> 
		
		
		<div class="col-md-7 col-sm-7 right-content step5" id="conformation1" style="display: none;">
            <div class="wizardsteps">&nbsp;</div>
            <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
                <div class="clearfix">&nbsp;</div>
                <img  src="${baseUrl}/nbdimages/images/img-1.jpg" alt="nursing image" class="img-responsive imageName" />
               <h3>We guarantee Best Doctors and Specialists at your location</h3>
            <p>  No more waiting for long hours in Clinics</p>
            <p> No more wasting time in Traffic</p>
            <p> No more ignoring of your health for time, company confusion.</p>

            </div>
            <div class="forms">
                <div class="clearfix">&nbsp;</div>
               <P align="center"> Thanks for booking. Your request is being processed.<br> 
				                  Will keep you posted. For any enquiries <br>
				                  whatsapp us@974 255 7757 Email to <a>care@aurospaces.com</a></p>
                    
                    <div class="clearfix">&nbsp;</div>
                    <div class="clearfix">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>
                    <div class="clearfix hidden-xs">&nbsp;</div>

                    <div class="col-md-4 col-sm-4"> <a href="./" class="btn btn-primary btn-lg btn-block" type="submit">No Thanks</a></div>
                    <div class="clearfix visible-xs">&nbsp;</div>
                    <div class="col-md-8 col-sm-8"> <a href="./" class="btn btn-primary btn-lg btn-block " id="btn6" type="submit">Book another service &nbsp; <i class="fa fa-arrow-right"></i></a></div>
            </div><!--end of message section-->
        </div><!-- end of conformation section-->
		


    </div>
    <div class="clearfix">&nbsp;</div>
    <div class="clearfix">&nbsp;</div>
    <div class="footer pos">
        <div class="container-main">
            <div class="col-md-4 col-sm-4 col-xs-4 no-pad col-md-offset-4 col-sm-offset-4 text-center">
                <a href="javascript:;">&copy; 2014 Aurospaces </a>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-8 text-center">
                <a href="${baseUrl}/terms&condititons.html"> Terms&amp;Conditions </a> &nbsp; &nbsp;
                <a href="${baseUrl}/privacypolicy.html"> Privacy Policy </a>
            </div>

        </div>
    </div>  <!--end of footer-->
    
    
    
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${baseUrl}/js/bootstrap.min.js"></script>
    <script  src="${baseUrl}/js/formValidation.js"></script>
      <script src="${baseUrl}/Branding/js/MntValidator.js"></script>
      <script src="${baseUrl}/js/jqueryblockui.js"></script>  
        <script src="${baseUrl}/js/doctorOrder.js"></script> 
    <script>
        $(document).ready(function () {
        	$("#symptomsTextId").val("");
        	$("#contactAddr").val("");
            for (var i = 1; i < 5; i++) {
                $(".step" + i).hide();
            }
            // alert("hi");

            $("#btn0").click(function () {
            	selectDocterClick();
            });
            $("#btn1").click(function () {
            	getSymptomsText();
            });
            $("#btn2").click(function () {
            	getContactInfo();
            });
            $("#btn3").click(function () {
            	getContactDetails();
            });
             $("#btn4").click(function () {
            	 otp();
            	
            }); 


            
        });
       
        
        $(document).on('click', '.firststep', function(){
       	 $(".step0").show();
       	 $(".step1").hide();
       	 $(".step2").hide();
       	 $(".step3").hide();
         $(".step4").hide();
         $(".step5").hide();
       	
       }); 
        
        $(document).on('click', '.secondstep', function(){
        	selectDocterClick();
        	if($(this).hasClass("action")){
             	 $(".step0").hide();
             	 $(".step1").show();
             	 $(".step2").hide();
             	 $(".step3").hide();
               $(".step4").hide();
               $(".step5").hide();
           	}
        	
        });
        
        $(document).on('click', '.thirdstep', function(){
        	selectDocterClick();
        	if($('.secondstep').hasClass("action")){
        		getSymptomsText();
        	}
        	if($(this).hasClass("action")){
             	 $(".step0").hide();
             	 $(".step1").hide();
             	 $(".step2").show();
             	 $(".step3").hide();
                 $(".step4").hide();
                 $(".step5").hide();
        	}
        	
        });
        
        $(document).on('click', '.fourthstep', function(){
        	selectDocterClick();
        	if($('.secondstep').hasClass("action")){
        		getSymptomsText();
        		getContactInfo();
        	}
        	if($(this).hasClass("action")){
             	 $(".step0").hide();
             	 $(".step1").hide();
             	 $(".step2").hide();
             	 $(".step3").show();
                 $(".step4").hide();
                 $(".step5").hide();
           	}
        	
        });
        
        $(document).on('click', '.fifthstep', function(){
        	selectDocterClick();
        	if($('.secondstep').hasClass("action")){
        		getSymptomsText();
        		getContactInfo();
        	}
        	if($('.fourthstep').hasClass("action")){
        		getContactDetails();
        	}
        	if($(this).hasClass("action")){
             	 $(".step0").hide();
             	 $(".step1").hide();
             	 $(".step2").hide();
             	 $(".step3").hide();
                 $(".step4").show();
                 $(".step5").hide();
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
        $('.fifthstep').hover(function() {
            $(this).css('cursor','pointer');
        });

    </script>

</body>
</html>

