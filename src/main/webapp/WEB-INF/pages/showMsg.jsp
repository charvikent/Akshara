
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
</head>
<body>
<div class="header">
  <div class="container-main">
    <div class="logo"> <a href="./"> <img src="images/logo.png" alt="logo image" />
      <div class="name">
        <h3>Aurospaces<span clss="sub">&nbsp &nbsp(Beta)</span></h3>
        <div class="clearfix"></div>
        <p>The Marketplace for all services</p>
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
          <p>Pathology Tests</p>
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
 <input type="text" class="form-control search-text" autocomplete="off" id="testName" placeholder="Enter Pathology Test Name Here " onkeyup="getFilteredByName(this.id)" style= "color:#00000">
 <div class="alert-danger " id="testTypeMessage" style="color: #FF0000;background-color: white;font-weight: bold;"></div>
  </div>
  <!-- end of message section-->

    <div class="clearfix">&nbsp;</div>
  <div class="col-md-12 as-pathalagy step0">
    <div class="col-md-10 tab-adj">
      <table class="table table-bordered as-table table-responsive">
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
        </tbody>
        
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
        <input class="btn as-but btn-lg btn-block as-but-pathalogy general btn0" type="button" value="Book Now" style="background: #dbbc23;">
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
      				<input type="hidden" id="serviceId"  value="<%= request.getParameter("serviceId") %>"/>
                    <input type="hidden" id="locationId"  value="<%= request.getParameter("location") %>"/>
    </div>
    <!-- /.col-md-12 --> 
  </div>
<div class="clearfix">&nbsp;</div>

<!---2nd section start--->
<div class="container-fluid step1">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p> Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p> NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p> Hard copies of test reports are couriered</p>
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content step1">
  
      
      <div class="col-md-5 col-sm-5 left-section visible-xs">
          <div class="clearfix">&nbsp;</div>
          <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p>  Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p> NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p>  Hard copies of test reports are couriered</p>
  </div>
  
      <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list firststep">1</div>
          <p>Pathology Tests</p>
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
                 <input type="hidden" name="scheduleDate"  value="Today"/></span>
        </div>
        <div class="clearfix visible-xs">&nbsp;</div>
        <div class="col-md-4 col-sm-4">
         <span> <input type="button" id="todayBtn" class="btn btn-lg btn-block btn-date scheduleDateBtn" value="Tomorrow">
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
        
      </div>
     
       <div class="clearfix">&nbsp;</div>
       <div class="alert-danger" id="dupMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
      </div>
      <div class="col-md-12 col-xs-12 col-lg-12 no-pad">  <a href="javascript:;" class="btn btn1 btn-primary btn-lg btn-block" type="submit">Next</a></div>
    </div>
    </div>
    
  </div>
<!---2nd section end--->

<!---3rd section start--->
<div class="container-fluid step2">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p> Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p> NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p> Hard copies of test reports are couriered</p>
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
  
       <div class="col-md-5 col-sm-5 left-section visible-xs"> 
            <div class="clearfix">&nbsp;</div>
           <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p> Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p> NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p> Hard copies of test reports are couriered</p>
  </div>
      <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list firststep">1</div>
          <p>Pathology Tests</p>
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
      
  <div class="forms dates"  id="contactFormId">
    <div class="block-content">
      <h3>Tell us about yourself</h3>
     <input type="text" autocomplete="off" maxlength="13" id="contactNum" name="phone number" placeholder="Enter your Phone number" class="form-control" onkeyup="getCustomerDetails(this.id),removeBorder(this.id)"  onblur="mobileValidation();" onkeypress='return onlyNos(event,this);'>
      <div class="clearfix">&nbsp;</div>
      <input type="password" maxlength="13"  autocomplete="off" id="password" name="PAssword" placeholder="Enter your Password" class="form-control" onkeyup="removeBorder(this.id)" onblur="passwordValidation();">
      <input id="customerId" type="hidden">
      <div class="clearfix">&nbsp;</div>
      <input type="text" autocomplete="off" maxlength="40" id="emailId" name="Email" placeholder="Enter your Email" class="form-control"  onkeyup="removeBorder(this.id)" onblur="emailValidation();">
      <div class="clearfix">&nbsp;</div>
      <textarea maxlength="150" rows="3" id="contactAddr" placeholder="Enter your address" class="form-control" onfocus="removeBorder(this.id)" onblur="addressIsValid()"> </textarea>
      <div class="clearfix">&nbsp;</div>
      </div>
       <div class="alert-danger " id="contactMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
     <div class="col-md-12 col-xs-12 col-lg-12 no-pad">  <a href="javascript:;" class="btn btn-primary btn-lg btn-block btn2" type="submit">Next</a></div>
    </div>
    
    
    
    
    
       <div class="forms" id="signUpId" style="display: none;">
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
      				<input class="btn btn-primary btn-lg btn-block" type="button" value="Forgot Password" onclick="forgotPassword()">
      				</div>
                    <div class="clearfix visible-xs">&nbsp;</div>
                    <div class="col-md-6 col-sm-6"> 
                    <input class="btn btn-primary btn-lg btn-block"  type="button" value="Sign in" onclick="validateCustomer()">
                     </div>
      
      
     <!--  <div class="col-md-12">
      <input class="btn btn-primary btn-lg btn-block" type="button" value="Sign in" onclick="validateCustomer()">
      </div> -->
       <!-- <a href="javascript:;" class="btn btn-primary btn-lg btn-block btn5" type="submit">Next &nbsp; <i class="fa fa-arrow-right"></i></a></div> -->
    </div>
    
    <div class="forms" id="resetId" style="display: none;">
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
<div class="col-md-5 col-sm-5 left-section hidden-xs"> <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p> Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p>NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p> Hard copies of test reports are couriered</p>
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
  
       <div class="col-md-5 col-sm-5 left-section visible-xs"> 
            <div class="clearfix">&nbsp;</div>
           <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p> Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p>NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p> Hard copies of test reports are couriered</p>
  </div>
  
  <div class="row no-mar wizardsteps">
      <div class="stepwizard-row">
        <div class="stripebar"></div>
        <div class="col-md-3 col-sm-3 col-xs-3 stage">
          <div class="list firststep">1</div>
          <p>Pathology Tests</p>
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
                           					 <td id="totalPriceId"></td>
                           					 <td id="totalDiscountId"></td>
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
      <div id="bookMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
      <div class="col-md-6 col-sm-6"> <a href="./" class="btn btn-primary btn-lg btn-block" type="submit">Cancel</a></div><div class="clearfix visible-xs">&nbsp;</div>
      <div class="col-md-6 col-sm-6"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block btn3" type="submit">Book Now</a></div>
      <div class="clearfix">&nbsp;</div>
      <div class="clearfix">&nbsp;</div>
      
    
    </div>
    </div>
    </div>
  </div>
<!---4th section end--->
<!---5th section start--->
<div class="container-fluid step4">
<div class="col-md-5 col-sm-5 left-section hidden-xs"> <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p> Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p> NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p> Hard copies of test reports are couriered</p>
  </div>
  <div class="clearfix visible-sm">&nbsp;</div>
  <div class="col-md-7 col-sm-7 col-xs-12 right-content">
   
       <div class="col-md-5 col-sm-5 left-section visible-xs"> 
            <div class="clearfix">&nbsp;</div>
           <img src="nbdimages/images/pathalogy-1.png" alt="nursing image" class="img-responsive">
    <h3>We will not let you waste your valued time in Labs, traffic posts and make multiple rounds of visits for collection of reports</h3>
    <p>  Auro brings to you At Home Pathology Tests.</p>
    <p> Now you can get your samples collected at the comfort of your home/office</p>
    <p> NABL Certified Laboratories</p>
    <p> Get test reports emailed to you right away</p>
    <p> Hard copies of test reports are couriered</p>
  </div>
      
  <div class="forms dates">
    <div class="block-content">      
      <div class="clearfix">&nbsp;</div>
        
        <P align="center"> Thanks for booking. Your request is being processed.<br> 
				                  Will keep you posted. For any enquiries <br>
				                  whatsapp us@974 255 7757 Email to <a>care@aurospaces.com</a></p>
      <div class="clearfix">&nbsp;</div>
      </div>
     <div class="col-md-4 col-sm-4"> <a href="./" class="btn btn-primary btn-lg btn-block" type="submit">No Thanks</a></div>
      <div class="clearfix visible-xs">&nbsp;</div>
     <div class="col-md-8 col-sm-8"> <a href="./" class="btn btn-primary btn-lg btn-block btn4" type="submit">Book another service &nbsp; <i class="fa fa-arrow-right"></i></a></div>
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
    <div class="col-md-4 col-sm-4 col-xs-8 text-center"> <a href="terms&condititons.html"> Terms&amp;Conditions </a> &nbsp; &nbsp; <a href="privacypolicy.html"> Privacy Policy </a> </div>
  </div>
</div>
<!--end of footer--> 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/formValidation.js"></script> 
<script src="Branding/js/MntValidator.js"></script> 
<script src="js/jqueryblockui.js"></script> 
<script src="js/pathologyTemp.js"></script> 
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
    	pathologyBookingNow();
       /*  $(".step3").hide();
        $(".step4").show(); */
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

<br> <br>

The message to print is 

<br>

<c:out value = "${message}" />



</body>
</html>




    <script type="text/javascript">
        $( document ).ready(function() {
            $("#contactAddr").val("");
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


</script>
