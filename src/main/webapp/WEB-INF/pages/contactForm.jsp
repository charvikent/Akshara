
    <div class="forms dates" id="contactFormId">
    <div class="block-content">
      <h3>Tell us about yourself</h3>
      <input type="text" autocomplete="off" maxlength="13" id="contactNum" name="phone number" placeholder="Enter your Phone number" class="form-control" onkeyup="removeBorder(this.id)"  onblur="mobileValidation(), getCustomerDetails(this.id)" onkeypress='return onlyNos(event,this);'>
		 <input type="hidden" id="customerId"/>
      <div class="clearfix">&nbsp;</div>
      <input type="text" autocomplete="off" maxlength="40" id="emailId" name="Email" placeholder="Enter your Email" class="form-control"  onkeyup="removeBorder(this.id)" onblur="emailValidation();">
      <div class="clearfix">&nbsp;</div>
      <textarea maxlength="250" rows="3" id="contactAddr" placeholder="Enter your address" class="form-control" onfocus="removeBorder(this.id)" ></textarea>
      <div class="clearfix">&nbsp;</div>
      </div>
       <div class="alert-danger " id="contactMessage" style="color: #FF0000;background-color: #CCCCCC;font-weight: bold;"></div>
       <div class="col-md-12 col-xs-12 col-lg-12 no-pad"> <a href="javascript:;" class="btn btn-primary btn-lg btn-block "  id="btn3" type="submit">Next</a></div>
    </div>
