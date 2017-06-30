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
    <title>Aurospace</title>
    <link rel="shortcut icon" href="images/ico/favicon.ico"> 

    <!-- Bootstrap -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="http://fortawesome.github.io/Font-Awesome/assets/font-awesome/css/font-awesome.css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <!-- Facebook Conversion Code for Aurospaces -->
<script>(function() {
var _fbq = window._fbq || (window._fbq = []);
if (!_fbq.loaded) {
var fbds = document.createElement('script');
fbds.async = true;
fbds.src = '//connect.facebook.net/en_US/fbds.js';
var s = document.getElementsByTagName('script')[0];
s.parentNode.insertBefore(fbds, s);
_fbq.loaded = true;
}
})();
window._fbq = window._fbq || [];
window._fbq.push(['track', '6025511294752', {'value':'0.01','currency':'INR'}]);
</script>
<noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6025511294752&amp;cd[value]=0.01&amp;cd[currency]=INR&amp;noscript=1" /></noscript>
    
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
    <div class="header">
        <div class="container-main">
            <div class="logo">
                <a href="./">
                   <img src="images/logo.png" alt="logo image">
                    <div class="name">
                        <h3>Aurospaces<span class="sub">&nbsp (Beta)</span></h3>
                        <div class="clearfix"></div>
                        <p>The Marketplace for all services</p>
                    </div>
                </a>
            </div>
        </div>

    </div>

    <div class="container-main">
    <input type="hidden" id="serviceId"  value="<%= request.getParameter("serviceId") %>"/>
			<input type="hidden" id="locationId"  value="<%= request.getParameter("locationId") %>"/>
        <div class="col-md-5 col-sm-5 left-section hidden-xs">

${service.displayText }

        </div>



        <!------------------------1st message-------------------------------->
        <div class="col-md-7 col-sm-7 right-content step0" id="message">
         <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
                <div class="clearfix">&nbsp;</div>
                 ${service.displayText }
            </div>
            <div class="row no-mar wizardsteps">
                <div class="stepwizard-row">
                    <div class="stripebar"></div>
                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list active firststep">1</div>
                        <p>Provide Details  </p>
                    </div>

                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list secondstep">2</div>
                        <p>Date & Time  </p>
                    </div>

                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list thirdstep">3</div>
                        <p>Contact Info</p>
                    </div>
                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list fourthstep ">4</div>
                        <p>Booking</p>
                    </div>
                </div>
            </div>
            <!--end of progress bar-->
            <div class="forms">
                <textarea maxlength="250" rows="6" id="problemId" placeholder="Please Enter Problem Description upto 250 characteres" class="form-control" onkeyup="problemDescriptionValidation();"></textarea>
            <div class="alert-danger" id="problemMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>    
                <div class="clearfix">&nbsp;</div>
                <div class="clearfix">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>

                <div class="col-md-12 col-xs-12 col-lg-12 no-pad"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block " id="btn0" type="submit">Next</a></div>
            </div><!--end of message section-->
        </div><!-- end of message section-->
        <!------------------------2nd message-------------------------------->
        <div class="col-md-7 col-sm-7 right-content step1" id="timings">
        
        <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
                <div class="clearfix">&nbsp;</div>
                <!-- <img   src="" alt="nursing image" class="img-responsive imageName" />
                <h3 class = "textContentId"> </h3>
                <p class = "textContentId1">   </p>
                <p class = "textContentId2">   </p>
                <p class = "textContentId3">   </p>
                <p class = "textContentId4">   </p> -->
                ${service.displayText }

            </div>
            <div class="row no-mar wizardsteps">
                <div class="stepwizard-row">
                    <div class="stripebar"></div>
                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list firststep">1</div>
                        <p>Provide Details  </p>
                    </div>

                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list active secondstep">2</div>
                        <p>Date & Time  </p>
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

            <div class="forms dates">
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
                        <span><input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date scheduleDateBtn" value="Day After">
                        <input type="hidden" name="scheduleDate"  value="2"/></span>
                    </div>
                </div>
                <div class="clearfix">&nbsp;</div>
                <div class="clearfix">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>

                <div class="row no-marg">
                    <h3>Pick time slot</h3>
                    <c:choose>
                      <c:when test="${not empty timeSlotList }">
                      <c:forEach var="timeSlot" items="${timeSlotList}" varStatus="loop">
                      <div class="col-md-4 col-sm-4">
                      <span><input class="btn btn-lg btn-block btn-date scheduleTimeBtn"   id="${loop.index}" type="button"  value="${timeSlot.label }"  />
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
				 <div class="alert-danger" id="dupMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
				 <div class="col-md-12 col-xs-12 col-lg-12 no-pad"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block " id="btn2" type="submit">Next</a></div>
            </div><!--end of message section-->
        </div><!-- end of timings section-->
        <!------------------------3rd message-------------------------------->
        <div class="col-md-7 col-sm-7 right-content step2 " id="info">
        <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
                <div class="clearfix">&nbsp;</div>
                <!-- <img  src="" alt="nursing image" class="img-responsive imageName" />
               <h3 class = "textContentId"> </h3>
                <p class = "textContentId1">   </p>
                <p class = "textContentId2">   </p>
                <p class = "textContentId3">   </p>
                <p class = "textContentId4">   </p> -->
                 ${service.displayText }

            </div>
            <div class="row no-mar wizardsteps">
                <div class="stepwizard-row">
                    <div class="stripebar"></div>
                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list firststep">1</div>
                        <p>Provide Details  </p>
                    </div>

                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list secondstep">2</div>
                        <p>Date & Time  </p>
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
            
            <!--end of progress bar-->


   <%@include file="contactForm.jsp" %> 
            
            
            
            
        </div><!-- end of inputs section-->
        <!------------------------4th message-------------------------------->
        <div class="col-md-7 col-sm-7 right-content step3" id="details">
        
         	<div class="col-md-5 col-sm-5 left-section visible-xs text-left">
                <div class="clearfix">&nbsp;</div>
                <!-- <img  src="" alt="nursing image" class="img-responsive imageName" />
              <h3 class = "textContentId"> </h3>
                <p class = "textContentId1">   </p>
                <p class = "textContentId2">   </p>
                <p class = "textContentId3">   </p>
                <p class = "textContentId4">   </p> -->
                 ${service.displayText }

            </div>
            <div class="row no-mar wizardsteps">
                <div class="stepwizard-row">
                    <div class="stripebar"></div>
                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list firststep">1</div>
                        <p>Provide Details  </p>
                    </div>

                    <div class="col-md-3 col-sm-3 col-xs-3 stage">
                        <div class="list secondstep">2</div>
                        <p>Date & Time  </p>
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
             
            <!--end of progress bar-->


            <div class="forms">
                <div class="row no-marg">
                    <div class="col-md-4 col-sm-4 col-xs-12 text-left">
                        <label>Problem Description</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p id="problemDesplayId">fdgh</p>
                    </div>
                </div>
                <div class="clearfix">&nbsp;</div>
                <div class="row no-marg">
                    <div class="col-md-4 col-sm-4 col-xs-12 text-left">
                        <label>Schedule</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p id="dayAndTime">Today,Afternoon(12-4PM)</p>
                    </div>
                </div>
                <div class="clearfix">&nbsp;</div>
                <div class="row no-marg">
                    <div class="col-md-4 col-sm-4 col-xs-12 text-left">
                        <label>Contact</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p id="contactNoId">9874569658</p>
                        <p id="contactNameId">ASDAS@GMAIL.COM </p>
                        <p id="addressId">ASDFASFAS</p>
                    </div>
                </div>
                <div class="clearfix">&nbsp;</div>
                <div class="row no-marg">
                    <div class="col-md-4 col-sm-4 col-xs-12 text-left">
                        <label>You pay</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p>Cash on service</p>
                    </div>
                </div>
                 <div class="clearfix">&nbsp;</div>
                <div class="row no-marg">
                <div class="col-md-4 col-sm-8 col-xs-12 text-left">
                        <label>OTP</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p><input type="text" name="otp" id="otpId" placeholder ="Please enter OTP" size="35"></p>
                    </div>
                </div>
                <div class="row no-marg">
                <div class="col-md-4 col-sm-8 col-xs-12 text-left">
                        <label>Couponcode</label>
                    </div>
                    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                        <p><input type="text" name="couponcode" id="couponcodeId" placeholder ="Enter mobileNumber or couponcode" size="35"></p>
                    </div>
                </div>
                <!-- <div class="clearfix">&nbsp;</div>
                <div class="clearfix">&nbsp;</div> -->
                <div id = "otpMessageId"></div>
               <!--  <div class="clearfix hidden-xs">&nbsp;</div>
                <div class="clearfix hidden-xs">&nbsp;</div>
 -->
                <div class="col-md-6 col-sm-6"> <a href="./" class="btn btn-primary btn-lg btn-block" type="submit">Cancel</a></div><div class="clearfix visible-xs">&nbsp;</div>
                <div class="col-md-6 col-sm-6"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block " id="btn4" type="submit">Book Now</a></div>
            </div><!--end of message section-->
        </div><!-- end of book section-->
        <!------------------------5th message-------------------------------->
        <div class="col-md-7 col-sm-7 right-content step4" id="conformation">
            <div class="wizardsteps">&nbsp;</div>
            <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
                <div class="clearfix">&nbsp;</div>
                <!-- <img  src="" alt="nursing image" class="img-responsive imageName" />
                <h3 class = "textContentId"> </h3>
                <p class = "textContentId1">   </p>
                <p class = "textContentId2">   </p>
                <p class = "textContentId3">   </p>
                <p class = "textContentId4">   </p> -->
                 ${service.displayText }

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
                    <div class="col-md-8 col-sm-8"> <a href="./" class="btn btn-primary btn-lg btn-block " id="btn5" type="submit">Book another service &nbsp; <i class="fa fa-arrow-right"></i></a></div>
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
                <a href="terms&condititons.html"> Terms&amp;Conditions </a> &nbsp; &nbsp;
                <a href="privacypolicy.html"> Privacy Policy </a>
            </div>

        </div>
    </div>  <!--end of footer-->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/formValidation.js"></script>
     <script type="text/javascript" src="js/newServices.js"></script>
      <script src="Branding/js/MntValidator.js"></script>
      <script src="js/jqueryblockui.js"></script>
    <script>
        $(document).ready(function () {
            for (var i = 1; i < 5; i++) {
                $(".step" + i).hide();
            }
            // alert("hi");

            $("#btn0").click(function () {
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
    </script>




<script type="text/javascript">
    

$(document).on('click', '.firststep', function(){
	 $(".step0").show();
	 $(".step1").hide();
	 $(".step2").hide();
	$(".step3").hide();
    $(".step4").hide();
	
}); 


$(document).on('click', '.secondstep', function(){
		getSymptomsText();
	if($(this).hasClass("action")){
		$(".step0").hide();
		$(".step1").show();
		$(".step2").hide();
		$(".step3").hide();
	    $(".step4").hide();
	}
	
}); 

$(document).on('click', '.thirdstep', function(){
			getSymptomsText();
	 if($('.secondstep').hasClass('action')){
	 
		 if($('.secondstep').hasClass('active')){
		getContactInfo();
	}else{
		if($(this).hasClass("action")){
			$(".step0").hide();
			$(".step1").hide();
			$(".step2").show();
			$(".step3").hide();
		    $(".step4").hide();
		}
	}
	}
	
	//getContactInfo();
	
}); 

$(document).on('click', '.fourthstep', function(){
	
		getSymptomsText();
	 if($('.secondstep').hasClass('action')){
		 getContactInfo();
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

</script>
  <style>
.your-class::-webkit-input-placeholder {
    color: red;
}
.default-class::-webkit-input-placeholder {
    color: red;
}
</style>
</body>
</html> 
