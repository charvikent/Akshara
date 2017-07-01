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

<!-- Bootstrap -->
<link href="css/css/bootstrap.css" rel="stylesheet">
<link href="css/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="http://fortawesome.github.io/Font-Awesome/assets/font-awesome/css/font-awesome.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="header">
  <div class="container-main">
    <div class="logo"> <a href="javascript:;"> <img src="images/logo.png" alt="logo image" />
      <div class="name">
        <h3>Aurospaces</h3>
        <div class="clearfix"></div>
        <p>Enablers in your neighbourhood</p>
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
          <div class="list active">1</div>
          <p>Pathology Tests</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">2</div>
          <p>Date & Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list ">4</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
    <!--end of progress bar--> 
  </div>
    <div class="clearfix">&nbsp;</div>
    <div class="clearfix">&nbsp;</div>
   <input type="text" class="form-control search-text" autocomplete="off" id="testName" placeholder="Enter Pathology Test Name Here " onkeyup="getFilteredByName(this.id)" style= "color:#00000">
    <div class="alert-danger " id="testTypeMessage"></div>
  </div>
  <!-- end of message section-->

    <div class="clearfix">&nbsp;</div>
  <div class="col-md-12 as-pathalagy step0">
    <div class="col-md-10">
      <table class="table table-bordered as-table">
        <tbody>
          <tr>
            <th>Vendor Name</th>
            <th>Test Name</th>
            <th>Test Price</th>
            <th>Discount</th>
            <th>You Pay</th>
            <th>&nbsp;</th>
            <!-- <input class="deleteSelectedItem btn as-but-greay as-but-pathalogy  white button-gradient package"  id="delete" type="button" value="delete"/> --> 
            
          </tr>
          
           </tbody >
         <tbody id="itemContainer">
          
        </tbody>
      </table>
    </div>
 


    <div class="col-md-2 as-but-verticalSpace text-left">
      <div>
        <input class="btn btn-success btn-lg btn-block as-but-pathalogy special" type="button" id="selected_list"  value="Selected" onclick="showSelectedList()">
      </div>
      <div style="padding:5px"></div>
      <div>
        <input class="btn as-but btn-lg btn-block as-but-pathalogy general btn0" type="button" value="Book Now" >
      </div>
      <div class="as-divider"> </div>
      <h3 class="filter">Filters</h3>
       <input class="btn as-but-greay btn-lg btn-block as-but-pathalogy  white button-gradient package" id="package" type="button" name="" value="Packages" onclick="getFiltered(this.id);">
      <div class="clearfix">&nbsp;</div>
      
     				<c:choose>  
								<c:when test="${not empty pathologyTypeList }">
								<c:forEach var="pathologyTypeList" items="${pathologyTypeList}">
								<input class="btn as-but-greay btn-lg btn-block as-but-pathalogy  white button-gradient"   id="${pathologyTypeList.testTypeId }" type="button" name="" value="${pathologyTypeList.testTypeName }" onclick="getFiltered(this.id);"/>
								<div class="clearfix">&nbsp;</div>
								</c:forEach>
								</c:when>
					</c:choose>
     
     
      <div class="clearfix">&nbsp;</div>
    </div>
    				<input type="hidden" id="serviceId"  value="<%= request.getParameter("serviceId") %>"/>
                    <input type="hidden" id="locationId"  value="<%= request.getParameter("location") %>"/>
    <!-- /.col-md-12 --> 
  </div>
<div class="clearfix">&nbsp;</div>

<!---2nd section start--->
<div class="container-fluid step1">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> <img src="images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p><i class="fa fa-dot-circle-o "> </i> Auro brings to you At Home Pathology Tests.</p>
    <p><i class="fa fa-dot-circle-o "> </i> Now you can get your samples collected at the comfort of your home/office</p>
    <p><i class="fa fa-dot-circle-o "> </i> NABL Certified Laboratories</p>
    <p><i class="fa fa-dot-circle-o "> </i> Get test reports emailed to you right away</p>
    <p><i class="fa fa-dot-circle-o "> </i> Hard copies of test reports are couriered</p>
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content step1">
  <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">1</div>
          <p>Pathology Tests</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list active">2</div>
          <p>Date &amp; Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list ">4</div>
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
                 <input type="hidden" name="scheduleDate"  value="Today"/></span>
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
          <span> <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date scheduleDateBtn" value="Tommorow">
                 <input type="hidden" name="scheduleDate"  value="Tomorrow"/></span>
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
         <div class="clearfix visible-xs">&nbsp;</div>
           <span><input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date scheduleDateBtn" value="Day After">
                 <input type="hidden" name="scheduleDate"  value="Day After"/></span>
        </div>
      </div>
      <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div>
      <div class="row no-marg">
        <h3>Pick time slot</h3>
        
          			<c:choose>  
											<c:when test="${not empty timeSlotList }">
											<c:forEach var="timeSlotList" items="${timeSlotList}" varStatus="loop">
											<div class="col-md-4 col-sm-4">
											<span><input class="btn btn-lg btn-block btn-date scheduleTimeBtn"   id="${loop.index}" type="button"  value="${timeSlotList.slotLabel }"  />
											<input type="hidden" name="scheduleTimeId" value="${timeSlotList.slotId }"/>
											<input type="hidden" name="scheduleTime" value="${timeSlotList.slotLabel }"/>
											<input type="hidden" name="hour" id= "hour" value="${timeSlotList.hour }"/></span>
											</div>
											 <div class="clearfix visible-xs">&nbsp;</div>
											</c:forEach>
											</c:when>
				</c:choose>
        
        <!-- <div class="col-md-4 col-sm-4">
          <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date" value="Morning(8-12)">
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
          <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date" value="Afternoon(12-4PM)">
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
          <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date" value="Evening(4-7PM)">
        </div> -->
      </div>
      <div class="alert-danger " id="dupMessage"
										style="display: none; padding-top: 32px;  background-color: rgb(228, 230, 225);  width: 88%;">
										<aside class="block-footer-left fail">
											Please select day and time</aside>
									</div>
       <div class="clearfix">&nbsp;</div>
      </div>
      <div class="col-md-4 col-sm-4 col-md-offset-4 col-sm-offset-4"> <a href="javascript:;" class="btn btn1 btn-primary btn-lg btn-block" type="submit">Next</a></div>
    </div>
    </div>
    
  </div>
<!---2nd section end--->

<!---3rd section start--->
<div class="container-fluid step2">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> <img src="images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p><i class="fa fa-dot-circle-o "> </i> Auro brings to you At Home Pathology Tests.</p>
    <p><i class="fa fa-dot-circle-o "> </i> Now you can get your samples collected at the comfort of your home/office</p>
    <p><i class="fa fa-dot-circle-o "> </i> NABL Certified Laboratories</p>
    <p><i class="fa fa-dot-circle-o "> </i> Get test reports emailed to you right away</p>
    <p><i class="fa fa-dot-circle-o "> </i> Hard copies of test reports are couriered</p>
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
  <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">1</div>
          <p>Pathology Tests</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list ">2</div>
          <p>Date &amp; Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list active ">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list ">4</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
   <div class="forms dates" id="contactFormId">
                <h3>Tell us about yourself</h3>
                <input type="text" autocomplete="off" maxlength="13" id="contactNum" name="phone number" placeholder="Enter your Phone number" class="form-control" onkeyup="getCustomerDetails(this.id),removeBorder(this.id)"  onblur="mobileValidation();" onkeypress='return onlyNos(event,this);'>
                <div class="clearfix">&nbsp;</div>
                <input type="password" maxlength="13"  autocomplete="off" id="password" name="PAssword" placeholder="Enter your Password" class="form-control" onkeyup="removeBorder(this.id)" onblur="passwordValidation();">
                <input id="customerId" type="hidden">
                <div class="clearfix">&nbsp;</div>
                <input type="text" autocomplete="off" id="emailId" name="Email" placeholder="Enter your Email" class="form-control"  onkeyup="removeBorder(this.id)" onblur="emailValidation();">
                <div class="clearfix">&nbsp;</div>
                <textarea rows="3" id="contactAddr" placeholder="Enter your address" class="form-control" onfocus="removeBorder(this.id)"> </textarea>
                <div class="clearfix">&nbsp;</div>
                 <div class="alert-danger " id="contactMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
                <div class="col-md-12 col-xs-12 col-lg-12 no-pad"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block btn2" id="message-btn" type="submit">Next</a></div>
            </div><!--end of message section-->
            
            
            
            <div class="forms" id="signUpId">
		    <div class="block-content">
		    <div class="sign-form">
            <h3>Sign In</h3>
            <div class="sign-details ">
               <input id="phone" type="text" class="form-control" autocomplete="off" placeholder="Phone Number"  onfocus="removeBorder(this.id)">
                 <div class="clearfix">&nbsp;</div>
               <input id="passwordId" maxlength="13"  type="password" autocomplete="off" class="form-control" placeholder="Enter Password"  onfocus="removeBorder(this.id)">
               <div class="clearfix">&nbsp;</div> 
                <div class="alert-danger" id="passMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div> 
               </div>
            </div>    
            </div>
      <div class="clearfix visible-xs">&nbsp;</div>
      
      				<div class="col-md-6 col-sm-6">
      				<input class="btn btn-primary btn-lg btn-block"  type="button" value="Sign in" onclick="validateCustomer()">
      				</div>
                    <div class="clearfix visible-xs">&nbsp;</div>
                    <div class="col-md-6 col-sm-6"> 
                    <input class="btn btn-primary btn-lg btn-block" type="button" value="Forgot Password" onclick="forgotPassword()">
                     </div>
      
      
     <!--  <div class="col-md-12">
      <input class="btn btn-primary btn-lg btn-block" type="button" value="Sign in" onclick="validateCustomer()">
      </div> -->
       <!-- <a href="javascript:;" class="btn btn-primary btn-lg btn-block btn5" type="submit">Next &nbsp; <i class="fa fa-arrow-right"></i></a></div> -->
    </div>
            
            
            
   <div class="forms" id="resetId">
   <div class="block-content">
   <div class="sign-form">
            <h3>Reset</h3>
            <div class="sign-details ">
               <input id="pnum" type="text" autocomplete="off" class="form-control" placeholder="Enter Email or Phone Number">
                 <div class="clearfix">&nbsp;</div>
               <input id="rpassword" maxlength="13"  type="password" autocomplete="off" class="form-control" placeholder="Enter New Password" onkeyup="removeBorder(this.id),resetValidation();">
               <div class="clearfix">&nbsp;</div> 
                <div class="alert-danger " id="resetmessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"> </div>
               </div>
            </div>
            </div>
           
      <div class="clearfix visible-xs">&nbsp;</div> 
      <input class="btn btn-primary btn-lg btn-block" type="button" value="Reset" onclick="resetPassword()">
    </div>
    
    </div>
    
  </div>
<!---3rd section end--->

<!---4th section start--->
<div class="container-fluid step3">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> <img src="images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p><i class="fa fa-dot-circle-o "> </i> Auro brings to you At Home Pathology Tests.</p>
    <p><i class="fa fa-dot-circle-o "> </i> Now you can get your samples collected at the comfort of your home/office</p>
    <p><i class="fa fa-dot-circle-o "> </i> NABL Certified Laboratories</p>
    <p><i class="fa fa-dot-circle-o "> </i> Get test reports emailed to you right away</p>
    <p><i class="fa fa-dot-circle-o "> </i> Hard copies of test reports are couriered</p>
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
  <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">1</div>
          <p>Pathology Tests</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">2</div>
          <p>Date &amp; Time </p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list">3</div>
          <p>Contact Info</p>
        </div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list active">4</div>
          <p>Booking</p>
        </div>
      </div>
    </div>
  <div class="forms dates no-pad">
    <div class="block-content">
    <h2 class="text-center">Your Order Summary</h2>
     <table class="table table-bordered as-table" style="margin-bottom: 0px;">
                                          <tbody><tr>
                                          		<th>Sno</th>
                                          		<th>Test Name</th>
                                          		<th style="width: 12%;">Test Price</th>
                                          		<th>Discount</th>
                                          		<th style="width: 14%;">Net Amount</th>
                                          		<th>Delete</th>
                                          </tr>
                                            </tbody>
                                             <tbody id="itemContainerSum">
                                              
                                            </tbody>
                                            <tbody><tr style="background-color: #2184be">
                                              <td colspan="2">Total</td>
                           					 <td id="totalPriceId">Rs.1450</td>
                           					 <td id="totalDiscountId">50.00%</td>
                           					 <td id="totalNetAmountId">Rs.725</td>
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
      <div class="col-md-4 col-sm-4 col-md-offset-4 col-sm-offset-4"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block btn3" type="submit">Book Now</a></div>
      <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div>
      
    
    </div>
    </div>
    </div>
  </div>
<!---4th section end--->

<!------------------------5th message-------------------------------->
 
		<div class="col-md-7 col-sm-7 right-content step4" id="conformation1">
            <div class="wizardsteps">&nbsp;</div>
            <div class="col-md-5 col-sm-5 left-section visible-xs text-left">
                <div class="clearfix">&nbsp;</div>
                <img  src="nbdimages/images/img-1.jpg" alt="nursing image" class="img-responsive imageName" />
                <h3 class = "textContentId"> gfdsgfh</h3>
                <p class = "textContentId1"> fghdfgh  </p>
                <p class = "textContentId2"> dfghdfgh  </p>
                <p class = "textContentId3">  fdghdfgh </p>
                <p class = "textContentId4"> dfghdfghfdh  </p>

            </div>
            <div class="forms">
                <div class="clearfix">&nbsp;</div>
                <p>
                    Thanks for booking. Your request is being processed. Will keep you posted. For any enquiries whatsapp us @974 255 7757
                    Email to  <a href="javascript:;">care@aurospaces.com</a>
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
                    <div class="col-md-8 col-sm-8"> <a href="./" class="btn btn-primary btn-lg btn-block btn4" type="submit">Book another service &nbsp; <i class="fa fa-arrow-right"></i></a></div>
            </div><!--end of message section-->
        </div><!-- end of conformation section-->
		






<div class="clearfix">&nbsp;</div>
<div class="footer">
  <div class="container-main">
    <div class="col-md-4 col-sm-4 col-xs-4 no-pad col-md-offset-4 col-sm-offset-4 text-center"> <a href="javascript:;">&copy; 2014 Aurospaces </a> </div>
    <div class="col-md-4 col-sm-4 col-xs-8 text-center"> <a href="javascript:;"> Terms&amp;Conditions </a> &nbsp; &nbsp; <a href="javascript:;"> Privacy Policy </a> </div>
  </div>
</div>
<!--end of footer--> 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/js/bootstrap.min.js"></script> 
<script src="js/formValidation.js"></script> 
<script src="Branding/js/MntValidator.js"></script> 
<script src="js/jqueryblockui.js"></script> 
<script>
        $(document).ready(function () {
            for (var i = 1; i < 8; i++) {
                $(".step" + i).hide();
            }
            // alert("hi");

            $(".btn0").click(function () {
            	showContent();
               /*  $(".step0").hide();
                $(".step1").show(); */
            });
            $(".btn1").click(function () {
            	aboutYourSelfShow();
              /*   $(".step1").hide();
                $(".step2").show(); */
            });
            $(".btn2").click(function () {
            	getContactDetails();
            });
            $(".btn3").click(function () {
                $(".step3").hide();
                $(".step4").show();
            });
			$(".btn4").click(function () {
                $(".step4").hide();
                $(".step5").show();
            });
			$(".btn5").click(function () {
                $(".step5").hide();
                $(".step6").show();
            });
			


        });
    </script>
</body>
</html>



    <script type="text/javascript">
        $( document ).ready(function() {
            $("#contactAddr").val("");
        });
        var pathologyTestsSelectedTotalArray = [];
		var pathologyTestsSchedueDate;
		var pathologyTestsSchedueTime;
		var pathologyTestsSchedueTimeId;
		var contactNumber;
		var contactAddress;
		var emailId;
		var password;
		var globalArray = [];
		var totalPrice=0;
		var totalDiscount=0;
		var totalNetAmount=0;
		var serviceId=$("#serviceId").val();
		var locationId=$("#locationId").val();
		var isPackageID=false;
		var isOthersID=false; 
		var packgeIds = [];
		var othersIds = [];
		var pthId ="";
		/* var vendor =""; */
		var cTime = $("#hour").val();
		var tDate = new Date();
		/* var cTime = tDate.getHours(); */
		//alert(cTime);
		if(cTime > 16 ){
			$('#todayBtn').attr("disabled","disabled");
		}
		
		function globalFuction(listPathologyTests){
			packgeIds=[];
			othersIds=[];
			
			if (listPathologyTests == "") {
				$("#itemContainer").html("");
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
					
						
					$.each(pathologyTestsSelectedTotalArray,function(ind,val){
					   if(val.pathologyTestId == itemSelectedInfo.testId)
						   count =count+1;
					});
					//alert(itemSelectedInfo.testName.split("-"));
					  /* foreach(retval in itemSelectedInfo.testName.split("-")) {
						console.log('retval : ' + retval);
			      }   */
			      
			    /*   var array = itemSelectedInfo.testDesc.split("-");
					var finalarray = null;
					$.each(array,function(ind,val){
						if(finalarray == null){
							finalarray =  array[ind]+"\n";
						}else{
							finalarray = finalarray+ array[ind]+"\n";	
						}
					});  */
			      
					if(pthId=='package')
					  packgeIds.push(itemSelectedInfo.testId);
					else
					  othersIds.push(itemSelectedInfo.testId);
					//alert(itemSelectedInfo.testDesc);
					resultDiscount= itemSelectedInfo.price*(itemSelectedInfo.discount/100);
					youPay=(itemSelectedInfo.price)-resultDiscount;
					totlAmount=(parseInt(itemSelectedInfo.price))- (parseInt(itemSelectedInfo.price))*(( parseInt(itemSelectedInfo.discount)/100));
									var testRowId = $( "#itemContainer tr" ).length+1;
									var tblRow ="<tr  id ='testSelected_"+ testRowId + "' name='test' >"
									/*  + "<td id='"
										+ itemSelectedInfo.testId
										+ "' >"+testRowId+"</td>" */
										+ "<td id='"
										+ itemSelectedInfo.testId
										+ "'>"
										+ itemSelectedInfo.firstName
										+ "</td>"
										+ "<td id='"
											+ itemSelectedInfo.testId
											+ "'><b>"
											+ itemSelectedInfo.testName
											+ "</b><br>"+itemSelectedInfo.testDesc.split('-')+"<br></td>"
											+ "<td style='display:none;' >"
											+ itemSelectedInfo.testDesc
											+ "</td>"
											+ "<td style='display:none;'>"
											+ itemSelectedInfo.price
											+ "</td>"
											+ "<td style='display:none;'>"
											+ itemSelectedInfo.discount
											+ "</td>" 
											+ "<td >"+" Rs. "
											+ itemSelectedInfo.price
											+ "</td>"
											+ "<td>"+itemSelectedInfo.discount+" %"
											+ "</td>"
											+ "<td>"+" Rs. "
											+ youPay
											+ "</td>" ;
											/* + "<td >"
											+ totlAmount
											+ "</td>" */
										  if(count>0){
											tblRow+= "<td  style='width:1px'> <input type='button' value='Select'  class='btn as-select-btn suc-active testSelect'>"
											+ "</td>"
											+ '</tr>';		
										  }else{
											  tblRow+= "<td  style='width:1px'> <input type='button' value='Select'  class='btn as-select-btn testSelect'>"
													+ "</td>"
													+ '</tr>';	
										  }
											
												
												
											tempTotalPrice=tempTotalPrice+ parseInt(itemSelectedInfo.price);
											//tempToralDiscount=tempToralDiscount+ parseInt(itemSelectedInfo.pathologoyDiscount);	alert(tempToralDiscount);
											tempTotalNetAmout=tempTotalNetAmout+totlAmount;
											discount=tempTotalPrice-tempTotalNetAmout;
											tempTotalDiscount=((100*discount))/tempTotalPrice;
											totalPrice=tempTotalPrice;
											totalDiscount=tempTotalDiscount;
											totalNetAmount=tempTotalNetAmout;
									$(tblRow).appendTo("#itemContainer");
								});
			}

		
		}
		$( document ).ready(function() {
			 $('#contactNum').val("");
			 $('#contactAddr').val("");
			$('#password').val("");
			pathologyTestSelection();
		});
			function pathologyTestSelection(){
				pthId = "package";
				$.ajax({
					type : "GET",
					url : "pathologyTests.htm",
					dataType:'json',
					success : function(listPathologyTests) {
						globalFuction(listPathologyTests);
					}
				});
				
			}
			
			
			
			function createPathologyTestInfoJson(pathologyTestId,vendorName, pathologoyTestName, pathologoyDescription, pathologoyPrice, pathologoyDiscount) {
				var item = {};
				if (pathologyTestId != "" && pathologyTestId != null) {
				        item ["pathologyTestId"] = pathologyTestId;
				        item ["vendorName"] = vendorName;
				        item ["pathologoyTestName"] = pathologoyTestName;
				        item ["pathologoyDescription"] = pathologoyDescription;
				        item ["pathologoyPrice"] = pathologoyPrice;
				        item ["pathologoyDiscount"] = pathologoyDiscount;
				        console.log('item : ' + item);
				}
				return item;
			}
			
			

			$(document).on('click', '.testSelect', function(){
				
				document.getElementById("testTypeMessage").style.display = "none";
				var pathologoyId = $(this).closest( "tr" ).find("td:first").attr("id");
				var vendorName = $(this).closest( "tr" ).find("td:nth-child(1)").text();
				
				var isThroCareSel = false;
				var isHeltNestSel = false;
				
				$.each(pathologyTestsSelectedTotalArray,function(key,vl){
					
					if(vl.vendorName == 'Thyrocare')
						isThroCareSel = true;
					else if(vl.vendorName == 'HealthNest')
						isHeltNestSel =  true;
				});
				
				if(vendorName == 'HealthNest' && isThroCareSel){
					return;
				}else if(vendorName == 'Thyrocare' && isHeltNestSel){
					return;
				}
				
				if(packgeIds.indexOf(pathologoyId)!= -1){
					if(isOthersID){
						//
						return;
					}else{
						isPackageID=true;
					}
				}else if(isPackageID){
					//
					return;
				}else if(othersIds.indexOf(pathologoyId)!= -1){
					isOthersID=true;
				}
				
				if($(this).hasClass("suc-active")){
					$(this).removeClass("suc-active");
					pathologyTestsSelectedTotalArray=pathologyTestsSelectedTotalArray
		               .filter(function (el) {
		                        return el.pathologyTestId !== pathologoyId ;
		                       });
	           
			if(pathologyTestsSelectedTotalArray.length<=0){
				isOthersID = false;
				isPackageID = false;
			}
					 var length =pathologyTestsSelectedTotalArray.length;
				        $("#selected_list").attr('value', 'Selected '+length);
				}else{
					$(this).addClass("suc-active");
					vendor = vendorName;
					//alert(vendor);
					if(vendor == "Thyrocare"){
						$('#1').attr("disabled","disabled");
						$('#2').attr("disabled","disabled");
					}
					var pathologoyTestName = $(this).closest( "tr" ).find("td:nth-child(2)").text();
					var pathologoyDescription = $(this).closest( "tr" ).find("td:nth-child(3)").text();
					var pathologoyPrice = $(this).closest( "tr" ).find("td:nth-child(4)").text();
					var pathologoyDiscount = $(this).closest( "tr" ).find("td:nth-child(5)").text();
					/* alert("id"+pathologoyId);
					alert("pname"+pathologoyTestName);
					alert("pdesc"+pathologoyDescription);
					alert("pprice"+pathologoyPrice);
					alert("pdisc"+pathologoyDiscount); */
					var pathologyTestInputAsJSON = {};
					pathologyTestInputAsJSON = createPathologyTestInfoJson(pathologoyId,vendorName, pathologoyTestName, pathologoyDescription, pathologoyPrice, pathologoyDiscount);
						console.log('pathologyTestsArray : ' + JSON.stringify(pathologyTestInputAsJSON));
						/* $.ajax({
						type : "POST",
						url : "pathologyTestAddToCart.htm",
						data: JSON.stringify(pathologyTestInputAsJSON),
						contentType: "application/json; charset=utf-8",
						dataType:'json',
						success : function(e) {
							pathologyTestsSelectedTotalArray.push(pathologyTestInputAsJSON);
							 var length =pathologyTestsSelectedTotalArray.length;
						        $("#selected_list").attr('value', 'Selected List '+length);
						},
						error : function(e) {
						}
					});  */
					
						pathologyTestsSelectedTotalArray.push(pathologyTestInputAsJSON);
						 var length =pathologyTestsSelectedTotalArray.length;
					        $("#selected_list").attr('value', 'Selected '+length);
				}
			});
			
				
		
			
			
		
			
			
			/*select schedule date -- start*/
			
			 $(document).on('click', '.scheduleDateBtn', function(){
				 document.getElementById("dupMessage").style.display = "none";
	 $('.scheduleDateBtn').removeClass("suc-active");
	var scheduleDate1 = $(this).parent( "span" ).find('input[type="hidden"][name="scheduleDate"]').val();
	$(this).addClass("suc-active");
	pathologyTestsSchedueDate= scheduleDate1;
	
	//alert(scheduleDate1);
		if(scheduleDate1 == "Today"){
			if(cTime > 9 ){
				pathologyTestsSchedueTime = "";
				$('.scheduleTimeBtn').removeClass("suc-active");
				$('#0').attr("disabled","disabled");
			}
			if(cTime > 13 ){
				pathologyTestsSchedueTime = "";
				$('.scheduleTimeBtn').removeClass("suc-active");
				$('#0').attr("disabled","disabled");
				$('#1').attr("disabled","disabled");
			}
			if(cTime > 16 ){
				pathologyTestsSchedueTime = "";
				$('.scheduleTimeBtn').removeClass("suc-active");
				$('#0').attr("disabled","disabled");
				$('#1').attr("disabled","disabled");
				$('#2').attr("disabled","disabled");
			}
		}
		 if(scheduleDate1 == "Tomorrow"){
				 $('#0').removeAttr('disabled');
				$('#1').removeAttr('disabled');
				$('#2').removeAttr('disabled');
				if(vendor == "Thyrocare"){
					 $('#1').attr("disabled","disabled");
						$('#2').attr("disabled","disabled");
				 }
		} 
		if(scheduleDate1 == "Day After"){
			
			$('#0').removeAttr('disabled');
			$('#1').removeAttr('disabled');
			$('#2').removeAttr('disabled');
			if(vendor == "Thyrocare"){
				 $('#1').attr("disabled","disabled");
					$('#2').attr("disabled","disabled");
			 }
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
				//alert(scheduleTime+scheduleTimeId);
				console.log('scheduleTime: ' + pathologyTestsSchedueTime);
			}); 
			/*select schedule Time -- end*/
			
		/* }); */
		
		function showContent(){
			if(pathologyTestsSelectedTotalArray.length!=0)
				{
			/* $("#orderDiv").hide();
			$("#selectionId").hide();
			$("#searchId").hide();
			showhideprogresscontainer(2); */
			 $(".step0").hide();
            $(".step1").show();
			
		
		}
			else{
				$("#testTypeMessage").text("Please select atleast one test");
				return false;
			}
		}
		
		
		/*delete select pathology test -- start*/
		$(document).on('click', '.deleteSelectedItem', function(){
			var testIdToDelete = $(this).closest( "tr" ).find("td:first").attr("id");
			console.log('testid: ' + testIdToDelete);
			
			 $.each(pathologyTestsSelectedTotalArray,function(i, itemSelectedInfo) {
				console.log('id: ' + itemSelectedInfo.pathologyTestId);
				var itemId = itemSelectedInfo.pathologyTestId;
				if (itemId == testIdToDelete) {
					pathologyTestsSelectedTotalArray.splice(i, 1);
					return false;
				}
			 
			});
			 $(this).closest('tr').remove();
			var length =pathologyTestsSelectedTotalArray.length;
	        $("#selected_list").attr('value', 'Selected '+length);
	        if(pathologyTestsSelectedTotalArray.length<=0){
	        	isOthersID = false;
	        	isPackageID = false;
	        }
	        showSelectedListCalulateAmount();
	       
		});
		/*delete select pathology test -- end*/

function showSelectedList(){ 
	
	if (pathologyTestsSelectedTotalArray.length > 0) {
		//alert("hai");
		$("#itemContainer").html("");
		$.each(pathologyTestsSelectedTotalArray,function(i, itemSelectedInfo) {
			var youPay=  itemSelectedInfo.pathologoyPrice - (itemSelectedInfo.pathologoyPrice*(itemSelectedInfo.pathologoyDiscount/100));
			///alert(itemSelectedInfo.pathologoyTestName );
							var testRowId = $( "#itemContainer tr" ).length + 1;
							var tblRow ="<tr  id ='testSelected_"+ testRowId + "' name='test' >"
							
									/* + "<td id='"
									+ itemSelectedInfo.pathologyTestId
									+ "'>"+testRowId+"</td>" */	
									+ "<td  id='"
									+ itemSelectedInfo.pathologyTestId
									+ "'>"
									+ itemSelectedInfo.vendorName
									+ "</td>"
									+ "<td style='width: 65%;'  id='"
									+ itemSelectedInfo.pathologyTestId
									+ "'>"
									+ itemSelectedInfo.pathologoyTestName 
									+ "</td>"
									/* + "<td >"
									+ itemSelectedInfo.pathologoyDescription
									+ "</td>" */
									+ "<td >"
									+ itemSelectedInfo.pathologoyPrice
									+ "</td>"
									+ "<td >"
									+ itemSelectedInfo.pathologoyDiscount+"%"
									+ "</td>" 
									+ "<td >"
									+" Rs."+ youPay
									+ "</td>" 
									 + "<td >"
									/* + "<input type='button' value='delete' class='deleteSelectedItem' />" */
									+"<img src='nbdimages/images/cross1.png' class='deleteSelectedItem' alt='logo' style='width: 70%;'>"
									+ "</td>" 
									+ '</tr>';
							$(tblRow).appendTo("#itemContainer");
						});
	} else {
		isOthersID = false;
		isPackageID = false;
		$("#itemContainer").html("");
		$("#itemContainerSum").html("");
	}
}
		
function showSelectedListCalulateAmount(){ 
	if (pathologyTestsSelectedTotalArray.length > 0) {
		showhideprogresscontainer(4);
		//$("#itemContainer").html("");
		$("#itemContainerSum").html("");
		var totlAmount=0;
		var tempTotalPrice=0;
		var tempTotalDiscount=0;
		var tempTotalNetAmout=0;
		var discount=0;
		$.each(pathologyTestsSelectedTotalArray,function(i, itemSelectedInfo) {
			var resultDiscount=0;
			var youPay=0;
			resultDiscount= itemSelectedInfo.pathologoyPrice*(itemSelectedInfo.pathologoyDiscount/100);
			youPay=(itemSelectedInfo.pathologoyPrice)-resultDiscount;
			//alert(youPay);
			totlAmount=(parseInt(itemSelectedInfo.pathologoyPrice))- (parseInt(itemSelectedInfo.pathologoyPrice))*(( parseInt(itemSelectedInfo.pathologoyDiscount)/100));
							var testRowId = $( "#itemContainerSum tr" ).length+1;
							var tblRow ="<tr  id ='testSelected_"+ testRowId + "' name='test' >"
							 + "<td id='"
								+ itemSelectedInfo.pathologyTestId
								+ "' >"+testRowId+"</td>"	
								+ "<td  id='"
									+ itemSelectedInfo.pathologyTestId
									+ "'>"
									+ itemSelectedInfo.pathologoyTestName
									+ "</td>"
									+ "<td style='display:none;' >"
									+ itemSelectedInfo.pathologoyDescription
									+ "</td>"
									+ "<td style='display:none;'>"
									+ itemSelectedInfo.pathologoyPrice
									+ "</td>"
									+ "<td style='display:none;'>"
									+ itemSelectedInfo.pathologoyDiscount +"%"
									+ "</td>" 
									+ "<td >"+" Rs. "
									+ itemSelectedInfo.pathologoyPrice
									+ "</td>"
									+ "<td>"+itemSelectedInfo.pathologoyDiscount+"%"
									+ "</td>"
									+ "<td>"+" Rs. "
									+ youPay
									+ "</td>" 
									/* + "<td >"
									+ totlAmount
									+ "</td>" */
									+ "<td style='width:11%;'>"
									/* + "<input type='button' value='delete' class='btn btn-success as-but-pathalogys deleteSelectedItem' />" */
									+"<img src='nbdimages/images/cross1.png' class='deleteSelectedItem' alt='logo' style='width: 40%;'>"
									+ "</td>"
									+ '</tr>';
									tempTotalPrice=tempTotalPrice+ parseInt(itemSelectedInfo.pathologoyPrice);
									//tempToralDiscount=tempToralDiscount+ parseInt(itemSelectedInfo.pathologoyDiscount);	alert(tempToralDiscount);
									tempTotalNetAmout=tempTotalNetAmout+totlAmount;
									discount=tempTotalPrice-tempTotalNetAmout;
									tempTotalDiscount=((100*discount))/tempTotalPrice;
									totalPrice=tempTotalPrice;
									totalDiscount=tempTotalDiscount;
									totalNetAmount=tempTotalNetAmout;
							$(tblRow).appendTo("#itemContainerSum");
						});
		$("#totalPriceId").text("Rs."+totalPrice);
		$("#totalDiscountId").text(totalDiscount.toFixed(2)+"%");
		$("#totalNetAmountId").text("Rs."+totalNetAmount);
		//schedule  details..
		$("#scheduleDateDisplayId").text(pathologyTestsSchedueDate+","+pathologyTestsSchedueTime);
		//$("#scheduleTimeDisplayId").text(pathologyTestsSchedueTime);
		
		//contact details..
		$("#contactNumberDisplayId").text(contactNumber);
		$("#emailID").text(emailId);
		$("#addressID").text(contactAddress);
		//$("#contactEmail").text(emailId);
		//$("#addressDisplayId").text(contactAddress);
	
	} else {
		$("#itemContainer").html("");
		$("#itemContainerSum").html("");
		$("#totalPriceId").hide();
		$("#totalDiscountId").hide();
		$("#totalNetAmountId").hide();
	}
}
	
	


var packgeIds = [];
var othersIds = [];
function getFiltered(id){
	var testTypeId = id;
	pthId = id;
	 $("#itemContainer tr").remove();
	$.ajax({
		type : "POST",
		url : "getFilterTestType.htm",
		data: "testTypeId="+testTypeId,
		dataType:'json',
		success : function(listPathologyTests) {
			           globalFuction(listPathologyTests);
			
					}
		});
		
}


function getFilteredByName(id){
	var testName =$("#testName").val();
	$("#itemContainer").html("");
	$("#itemContainerSum").html("");
	$.ajax({
		type : "POST",
		url : "getFilterTestName.htm",
		data: "testName="+testName,
		dataType:'json',
		success : function(response) {
			//isOthersID = true;
			pthId='others';
			globalFuction(response);
			}
		});
}

function pathologyBookingNow(){
	$('#book').prop('disabled', true);
	 if(pathologyTestsSelectedTotalArray.length >0){
		 $('#cancel').prop('disabled', true);
			 showhideprogresscontainer(4);
			$("#yourOrderSummaryId").hide();
			$("#thanksId").show();
	 		var json = JSON.stringify(pathologyTestsSelectedTotalArray);
	 		var customerId = $("#customerId").val();
	 		//alert(customerId);
	 		if(customerId == null || customerId==""  ){
	 		}else{
	 			//password = null;
	 		}
	 		$.ajax({
					type : "POST",
					url  : "allPathologyBookData.htm",
		            data: {pathologyTestsSelectedArray:json,
		            	pathologyTestsSchedueDate:pathologyTestsSchedueDate,
		            	contactNumber:contactNumber,
		            	contactAddress:contactAddress,
		            	totalPrice:totalPrice,
		            	totalDiscount:totalDiscount,
		            	totalNetAmount:totalNetAmount,
		            	pathologyTestsSchedueTimeId:pathologyTestsSchedueTimeId,
		            	pathologyTestsSchedueTime:pathologyTestsSchedueTime,
		            	emailId:emailId,
		            	serviceId:serviceId,
		            	locationId:locationId,
		            	password:password,
		            	customerId:customerId,
		            	isPackageID:isPackageID,
		            	isOthersID:isOthersID,
		            	},
					success : function(response) {
						if (response != "" && response == "success") {	
							
						} else {
						}
					},
					error : function(e) {
					}
				});                                         
	 	}else{
	 		$("#bookMessage").text("Please select atleast one test");
	 	} 
}


function getContactDetails(){
	if($('#contactNum').val().length == 0 || $('#password').val().length == 0 || $('#emailId').val().length == 0 || $('#contactAddr').val().length == 0){
		if($('#contactNum').val().length == 0 ) {
		    $('#contactNum').css('color','red');
		    $("#contactNum").css("border-color","red");
		    $("#contactNum").attr("placeholder","Please Enter contact number");
		    $('#contactNum').addClass('your-class');
		       }
		if($('#password').val().length == 0 ) {
		    $('#password').css('color','red');
		    $("#password").css("border-color","red");
		    $("#password").attr("placeholder","Please Enter password");
		    $('#password').addClass('your-class');
		       }
		if($('#emailId').val().length == 0 ) {
		    $('#emailId').css('color','red');
		    $("#emailId").css("border-color","red");
		    $("#emailId").attr("placeholder","Please Enter Email");
		    $('#emailId').addClass('your-class');
		       }
		if($('#contactAddr').val().length == 0 ) {
		    $('#contactAddr').css('color','red');
		    $("#contactAddr").css("border-color","red");
		    $("#contactAddr").attr("placeholder","Please Enter Address");
		    $('#contactAddr').addClass('your-class');
		       }
		
		return false;
	}
		 var val3=$('#contactNum').val();
		 val3 = val3.slice(-10);
		 var val5=$('#contactNum').val().length;
		 var val4=$('#emailId').val();
		
		 var regex1=new RegExp("^[0-9 ]+$");
		 var regex2=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		 
		 if($('#contactNum').val().length != 0 || $('#password').val().length >= 6 || $('#emailId').val().length != 0 || $('#contactAddr').val().length != 0){
			 $('#contactNum').css('color','black');
				contactNum=$("#contactNum").val();
				if(contactNum.charAt(0) == '+'){
					m_pat=/^[6-9,+][0-9]{12}$/;
					if(!m_pat.test(contactNum))
					{
						$("#contactMessage").text("Enter valid mobile number");
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
	    	//alert("enter valid email");
	    	 $("#contactMessage").text("Enter valid email");
	    	$('#emailId').css('color','red');
		    $("#emailId").css("border-color","red");
		   
	    	return false;
	    	} 
	    if($('#password').val().length<6){
	    	$("#contactMessage").fadeIn(1000);
	    	$("#contactMessage").text("password should be 6 charcters");
	    	 $("#contactMessage").fadeOut(5000);
	    	return false;
	    }
		 } 
		 $(".fourthstep").addClass("action");
		 	$(".step0").hide();
		 	$(".step1").hide();
			$(".step2").hide();
			$(".step3").show();
			$(".step4").hide();
		 
	//alert(contactNumber.slice(-10 ));
	contactNumber = $('#contactNum').val();
	contactNumber = contactNumber.slice(-10);
	contactAddress = $('#contactAddr').val();
	password = $('#password').val();
	//alert(password);
	emailId =$("#emailId").val();
	showSelectedListCalulateAmount();
}

function aboutYourSelfShow(){
		
		if((pathologyTestsSchedueDate==null || pathologyTestsSchedueDate=="")||(pathologyTestsSchedueTime==null || pathologyTestsSchedueTime=="")){
			document.getElementById("dupMessage").style.display = "block";
			$("#dupMessage").text("please enter date and time");
			return false;
		}else{
			$(".step1").hide();
            $(".step2").show();
		 $("#signUpId").hide();
		$("#resetId").hide();
		}
	}
function showhideprogresscontainer(id){
	$("#multistepform-container2").hide();
	$("#multistepform-container3").hide();
	$("#multistepform-container4").hide();
	$("#multistepform-container5").hide();
	$("#multistepform-container"+id).show();
	
}
function  getCustomerDetails(id){
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
		url : "validate.htm",
		success : function(response) {
			$.unblockUI();
			if(response == "fail"){
				$("#passMessage").fadeIn(1000);
				$("#passMessage").text("Please enter valid password");
				$("#passMessage").fadeOut(5000);
			}else {
				$("#contactNum").attr("disabled","disabled");
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

/* $(document).ready(function(){
	
    $.multistepform({
        container:'multistepform-example-container',
        form_method:'GET',
    });
}); */
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
	//	alert("enter phone number");
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
//	alert(password);
	//alert(pnum);
	$.ajax({
		type : "POST",
		data:"password="+password+"&pnum="+pnum,
		url : "resetPassword.htm",
		/* dataType : "json", */
		success : function(response) {
			$.unblockUI();
				//alert(response);
			if (response = "sucess") {
				$("#resetId").hide();
				$("#aboutYourSelfId").show();
				$("#contactNum").val("");
				$("#password").val("");
				$("#emailId").val("");
				$("#contactAddr").val("");
			}
		}
		});
	
}

</script>
