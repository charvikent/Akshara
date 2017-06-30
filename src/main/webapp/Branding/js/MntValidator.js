//jQuery Custom Validations 

/*jQuery.validator.addMethod("alphabets", function(value, element) {
	return this.optional(element)
			|| /^[A-Za-z][A-Za-z0-9!@#$%^&*\/()_+:;?><~.,+=|}{ '"]*$/.test(value);
});

jQuery.validator.addMethod("alphanumeric", function(value, element) {
	return this.optional(element)
			|| /^[A-Za-z][A-Za-z0-9!@#$%^&*\/()_+:;?><~.,+=|}{ '"]*$/.test(value);
});

jQuery.validator.addMethod("specialcharacters", function(value, element) {
	return this.optional(element) || /^[0-9a-zA-Z&_ ]+$/.test(value);
});*/
// Date Pattern Fuction

function calculateCoupons(){
	
	/*var netAmount = document.getElementById("netAmtId").innerHTML;*/
	
	var thousTot = 1000 * document.getElementById("txt_thousand_qty").value;
	document.getElementById("txt_thousand_tot").value = thousTot;


	var fiveHundTot = 500 * document.getElementById("txt_fivehund_qty").value;
	document.getElementById("txt_fivehund_tot").value = fiveHundTot;

	var hundTot = 100 * document.getElementById("txt_hund_qty").value;
	document.getElementById("txt_hund_tot").value = hundTot;

	var fiftyTot = 50 * document.getElementById("txt_fifty_qty").value;
	document.getElementById("txt_fifty_tot").value = fiftyTot;

	var twentyTot = 20 * document.getElementById("txt_twenty_qty").value;
	document.getElementById("txt_twenty_tot").value = twentyTot;

	var tenTot = 10 * document.getElementById("txt_ten_qty").value;
	document.getElementById("txt_ten_tot").value = tenTot;

	var fiveTot = 5 * document.getElementById("txt_five_qty").value;
	document.getElementById("txt_five_tot").value = fiveTot;

	var grandTot = Number(thousTot) + Number(fiveHundTot)  + Number(hundTot) + Number(fiftyTot) + Number(twentyTot)  + Number(tenTot)   + Number(fiveTot);
   
	document.getElementById("txt_grand_tot").value = CurrencyFormat(grandTot);
	document.getElementById("couponTotal").value = grandTot;
	document.getElementById("couponAmtId").innerHTML =grandTot;
	/*document.getElementById("grandTotAmtId").innerHTML = CurrencyFormat(grandTot + Number(netAmount));*/
	
	
	
}

function CurrencyFormat(number)
{
   var decimalplaces = 2;
   var decimalcharacter = ".";
   var thousandseparater = ",";
   if(number!=null && number!="")
	   {
   number = parseFloat(number);
   var sign = number < 0 ? "-" : "";
   var formatted = new String(number.toFixed(decimalplaces));
   if( decimalcharacter.length && decimalcharacter != "." ) { formatted = formatted.replace(/\./,decimalcharacter); }
   var integer = "";
   var fraction = "";
   var strnumber = new String(formatted);
   var dotpos = decimalcharacter.length ? strnumber.indexOf(decimalcharacter) : -1;
   if( dotpos > -1 )
   {
      if( dotpos ) { integer = strnumber.substr(0,dotpos); }
      fraction = strnumber.substr(dotpos+1);
   }
   else { integer = strnumber; }
   if( integer ) { integer = String(Math.abs(integer)); }
   while( fraction.length < decimalplaces ) { fraction += "0"; }
   temparray = new Array();
   while( integer.length > 3 )
   {
      temparray.unshift(integer.substr(-3));
      integer = integer.substr(0,integer.length-3);
   }
   temparray.unshift(integer);
   integer = temparray.join(thousandseparater);
   return sign + integer + decimalcharacter + fraction;
}
}
var specialKeys = new Array();
specialKeys.push(8); //Backspace
$(function  numberValid(){
    $(".numberValid").bind("keypress", function (e) {				
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==13 );
        $(".error").css("display", ret ? "none" : "inline");
        if(ret){
        		document.getElementById("errmsg2").style.display = "none";
        }
        else{
        	f3();
        	$(this).focus();
        	}
        return ret;
    });
});
$(function  numberValid1(){	
    $(".numberValid1").bind("keypress", function (e) {	    	
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==13);
        $(".error").css("display", ret ? "none" : "inline");        
        if(ret){        	
        document.getElementById("errmsg2").style.display = "none";
        }
        else{
        	s2();
        	}
        return ret;
    });
});
$(function  valid(){	
    $(".numeric").bind("keypress", function (e) {	
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==13);						       
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
});
$(function  validPop(){	
    $(".numericPop").bind("keypress", function (e) {   	            
        var val = $(this).val();        
        var regex = /^(\+|-)?(\d*\.?\d*)$/;
        var ret=regex.test(val + String.fromCharCode(e.charCode));
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
});

$(function  validA(){	
    $(".numericA").bind("blur", function (e) {	
    	var val=$(this).val();
    	var regex = new RegExp("^[0-9]+$");
    	var ret=regex.test(val);     
        if(!ret)
        	{
        	$(this).val('');
        	}
        return ret;
    });
});
$(function  valid1(){	
    $(".numeric1").bind("keypress", function (e) {	   	
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==46 || keyCode==13);
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
});
$(function  valiAL(){	
    $(".numericAL").bind("blur", function (e) {	   	      
        var v=$(this).val();
        var v1=$(this).val().length;
        var ret =/^\d*\.?\d*$/;
        if(!ret.test(v)){ 
        	s3();
        		$(this).val('');
        		$(this).focus();        		
        }
        if(v1<1){
        	s1();
        	$(this).focus();
        	}
        else if(v==0){
        	s5();
        	$(this).focus();
        	}
    });
});
$(function  numberValid2(){
    $(".numberValid2").bind("keypress", function (e) {	    	
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==46 || keyCode==13);
        $(".error").css("display", ret ? "none" : "inline");
        
        if(ret){        	
        document.getElementById("errmsgA").style.display = "none";
        }
        else{
        	s3();
           	}
        return ret;
    });
});
$(function  alphaNumericValid(){
    $(".alphaNumericValid").bind("keypress", function (e) {				
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) ||(keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==38 || keyCode==46 || keyCode==95 || keyCode==32 || keyCode==13);
        if(ret){
        	document.getElementById("errmsg1").style.display = "none";
        	}
        else{
        		f2();
        	}
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
});
$(function  alphaNumericValid(){
    $(".alphaNumericValidChe").bind("keypress", function (e) {				
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) ||(keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==32 || keyCode==13);
        if(ret){
        	document.getElementById("errmsg2").style.display = "none";
        	}
        else{
        	document.getElementById("errmsg2").style.display = "block";
        	setTimeout(function(){ $('#errmsg2').fadeOut(); }, 2000);
        	}
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
});
$(function  alphaNumericValid(){
    $(".alphabetsChe").bind("keypress", function (e) {				
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11  || keyCode==32 || keyCode==13);
        if(ret){
        	document.getElementById("errmsg1").style.display = "none";
        	}
        else{
        	document.getElementById("errmsg1").style.display = "block";
        	setTimeout(function(){ $('#errmsg1').fadeOut(); }, 2000);
        	}
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
});
$(function  alphaNumericValidA(){
    $(".alphaNumericValidA").bind("keypress", function (e) {				
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) ||(keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==32 || keyCode==13);
        if(ret){
        	document.getElementById("errmsgB").style.display = "none";
        	}
        else{
        	s4();
        }
        $(".error").css("display", ret ? "none" : "inline");       
        return ret;
    });
});
$(function alphabitValid() {
	$(".alphabetValid").bind("blur", function (e) {
	/*var keyCode = e.which ? e.which : e.keyCode;*/
	var val=$(this).val();
	var v=$(this).val().length;
	var regex = new RegExp("^[a-zA-Z ]+$");
	var ret=regex.test(val);
   /*var ret = ((keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==32 || keyCode==13);
    $(".error").css("display", ret ? "none" : "inline");*/
    if(v>=3)
    	{
    if(ret){
    document.getElementById("errmsg3").style.display = "none";
	}else{
    	f4();
    	$(this).focus();
    }
    	}
    return ret;
	});
});
/*function showhide()	{
	var div = document.getElementById("testDiv");
	if (div.style.display !== "none") {
		div.style.display = "none";
		$(div).dialog().dialog('close');
	}
	else {
		div.style.display = "block";
		 $(div).dialog({width:416,top:139,left: 467,modal: true}).dialog('open');
	}	
}*/
function showhide()	{
	var div = document.getElementById("testDiv");
	if (div.style.display !== "none") {
		div.style.display = "none";
	}
	else {
		div.style.display = "block";
	}	
}
function test(){	
	document.getElementById("testDiv").style.display !== "none";
}
function removeBorder(el){	
	  $("#"+el).css("border", ""); 	
	  $("#"+el).css('color','black');
	  $('#'+el).addClass('default-class');
}
function removeBorderChose(el){
	$("#"+el).css('color','black');
	 $("#"+el+"_chosen").find('.chosen-single').css("border","1px solid #AAA");
	if($("#"+el).val().length > 0 ){
		$("#"+el).css("border", ""); 
		  $("#"+el+"_chosen").find('.chosen-single').css("border","1px solid #AAA");
	}
		 /* else {
			  $("#"+el+"_chosen").find('.chosen-single').css("border","1px solid red");
			  }*/
}
function validateEmail(sEmail) {
	var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
	if (filter.test($('#'+sEmail).val())) {
		document.getElementById("errmsg5").style.display = "none";
	}
	else {
		f5();
			
	}
}
function checkLength(el) {	
	  if ($('#'+el).val().length < 3) {
		  $("#"+el).css('border-color','red');
		  $('#'+el).css('color','red');
	      $('#'+el).addClass('your-class');
	      	f1();
		    	
	  }
	   else{
		   document.getElementById("errmsg").style.display = "none";
		  } 
	}
function checkLengthM(el) {
	var val=$('#'+el).val();
	var regex = new RegExp("^[0-9]+$");
	var ret=regex.test(val);
	if(!ret){
		f3();
		
	}
	  if ($('#'+el).val().length < 10) {
		  $("#"+el).css('border-color','red');
		  $('#'+el).css('color','red');
	      $('#'+el).addClass('your-class');
	      f7();
	      	
	  }	  		
}
function checkLengthBM(el) {
	var val=$('#'+el).val();
	var regex = new RegExp("^[0-9]+$");
	var ret=regex.test(val);
	if(!ret){
		s2();
		}
	  if ($('#'+el).val().length < 10) {
		  $("#"+el).css('border-color','red');
		  $('#'+el).css('color','red');
	      $('#'+el).addClass('your-class');
	      document.getElementById('errmsgE').style.display="block";
	      document.getElementById("errmsgA").style.display = "none";
	  	  document.getElementById("errmsg2").style.display = "none";
	  	  document.getElementById("errmsgB").style.display = "none";
	  	  document.getElementById("errmsg1").style.display = "none";
	      setTimeout(function(){ $('#errmsgE').fadeOut(); }, 2000);
	      	}	  		
}
function validFirstLetter(el) {
	var val=$('#'+el).val();
	var val1=$('#'+el).val().length;
	var val2=$('#'+el).val().charCodeAt(0);
	var regex = new RegExp("^[a-zA-Z][a-zA-Z0-9&._ ]+$");
	var ret=regex.test(val);
	if((val2>47 && val2<58)|| val2==32 || val2==95||val2==38||val2==46 )
	{	
	f6();
	
	return false;
	}
		else if (!ret)
    	{
    	f2();
		
    	}
	if (val1 < 3) {
	  $("#"+el).css('border-color','red');
	  $('#'+el).css('color','red');
	  $('#'+el).addClass('your-class');
    	f1();
	   		
	}	
};
function validateU(el) {
	var val=$('#'+el).val();
	var val1=$('#'+el).val().length;
	var val2=$('#'+el).val().charCodeAt(0);
	var regex = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9&._ ]+$");
	var ret=regex.test(val);
	if(val2==32 || val2==95||val2==38||val2==46 )
	{	
	f6();
	return false;
	}
		else if (!ret)
    	{
    	f2();
		}
	if (val1 < 3) {
	  $("#"+el).css('border-color','red');
	  $('#'+el).css('color','red');
	  $('#'+el).addClass('your-class');
    	f1();
	   	}	
};
$(function  alphaNumericValid1(){
    $(".alphaNumericValid1").bind("keypress", function (e) {			
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) ||(keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==95 || keyCode==46|| keyCode==38 || keyCode==32 || keyCode==13 );
        if(ret)
        	{
        	document.getElementById("errmsg").style.display = "none";
        	}
        else{
        	c1();
        }
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
});
function validFirstLetter2(el) {
	var val=$('#'+el).val();
	var val1=$('#'+el).val().length;
	var val2=$('#'+el).val().charCodeAt(0);
	var regex = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9&._ ]+$");
	var ret=regex.test(val);
	if( val2==32 || val2==95||val2==38||val2==46 )
	{	
	c3();
	
	}
	else if (!ret){
			c1();
			
    	}
	if (val1 < 3) {
			$("#"+el).css('border-color','red');
	  		$('#'+el).css('color','red');
	  		$('#'+el).addClass('your-class');
    		c2();
	    		
		}
	};
function checkLengthE(el) {	
	  if ($('#'+el).val().length < 3) {		 
		  	$("#"+el).css('border-color','red');
		  	$('#'+el).css('color','red');
	      	$('#'+el).addClass('your-class');
	      	s2();
	      		
			 }
	   else {
		   	document.getElementById("errmsg2").style.display = "none";
		   	} 
	}
function validFirstLetter1(el) {
	var val=$('#'+el).val();
	var val1=$('#'+el).val().length;
	var val2=$('#'+el).val().charCodeAt(0);
	var regex = new RegExp("^[a-zA-Z][a-zA-Z0-9&._ ]+$");
	var ret=regex.test(val);
	if(val1<3){
		$("#"+el).css('border-color','red');
		$('#'+el).css('color','red');
		$('#'+el).addClass('your-class');
		c2();
		return false;
		}
	if((val2>47 && val2<58)|| val2==32 || val2==95||val2==38||val2==46 ){
		c3();
		}
	else{	
		if (!ret){
				c1();
		}
		}	
}
/*function hidening(){
	
		$('#submitId').attr('disabled', 'disabled');
		$('#submitId').hide();
		$('#updateId').hide();
		$('#updateId').prop('disabled', true);
		$('#updateId').attr('disabled', 'disabled');	
}
function showing(){
	
		$('#submitId').show();
		$('#submitId').removeAttr('disabled');
		$('#updateId').show();
		$('#updateId').removeAttr('disabled');
	}*/
function  numberValidDec(id){   			
        var v=$("#"+id).val();
        var v1=$("#"+id).val().length;
        var ret =/^\d*\.?\d*$/;
        if(!ret.test(v)){        	
        		s3();
        	}
        if(v1<1){
        		s1();
        		}
        else if(v==0){
        			s5();
        			}
  }
function  numberValidDecc(id){   			
    var v=$("#"+id).val();
   /* var v1=*/$("#"+id).val().length;
    var ret =/^\d*\.?\d*$/;
    if(!ret.test(v)){        	
    		s3();
    }
}
function  numberValidDesc(id){   			
    var v=$("#"+id).val();
    var ret =/^\d*\.?\d*$/;
    if(!ret.test(v)){        	
    		s3();
    		   		
    }
}
function  numberValidDec1(id){	
    var v=$("#"+id).val();
    var regex = new RegExp("^[0-9]+$");
    var v1=$("#"+id).val().length;
    if(v1<1){
		s1();
		return false;
		}
    if(!regex.test(v)){
    			s2();
    			}
    else if(v==0){
		s5();
		}
}
function  numberValidDec2(id){	
    var v=$("#"+id).val();
    var regex = new RegExp("^[0-900]+$");
    if(!regex.test(v) || v==0){
    			s2();   			
    				}
}
function  validSA(el){	
	
	var v=$("#"+el).val();
    var ret =/^\d*\.?\d*$/;
    if(ret.test(v)){
    		}
    	else{
		$('#'+el).focus();	
  	}
 }
function frde(el)
{
	var regex = new RegExp("^[a-zA-Z][a-zA-Z0-9&._]+$");
	if(!(regex.test($('#'+el).val())))
	{
	$('#'+el).css('border-color','red');													
	$('#'+el).addClass('your-class');
	c1();
	$('#'+el).focus();
	return false;
	}	
}
function f1(){
	document.getElementById("errmsg").style.display = "block";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#errmsg').fadeOut(); }, 2000);
}
function f2(){
	document.getElementById("errmsg").style.display = "none";
	document.getElementById("errmsg1").style.display = "block";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#errmsg1').fadeOut(); }, 2000);
}
function f3(){
	document.getElementById("errmsg").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "block";   	
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#errmsg2').fadeOut(); }, 2000);
}
function f4(){
	document.getElementById("errmsg").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg3").style.display = "block";
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#errmsg3').fadeOut(); }, 2000);
}
function f5(){
	document.getElementById("errmsg").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg5").style.display = "block";
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#errmsg5').fadeOut(); }, 2000);
}
function f6(){
	document.getElementById("errmsg").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg6").style.display = "block";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#errmsg6').fadeOut(); }, 2000);
}
function f7(){
	document.getElementById("errmsg").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg7").style.display = "block";
	setTimeout(function(){ $('#errmsg7').fadeOut(); }, 2000);
}
function c1(){
	document.getElementById("errmsg").style.display = "block";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";
	setTimeout(function(){ $('#errmsg').fadeOut(); }, 2000);
}
function c2(){
	document.getElementById("errmsg1").style.display = "block";
	document.getElementById("errmsg").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";
	setTimeout(function(){ $('#errmsg1').fadeOut(); }, 2000);
}
function c3(){
	document.getElementById("errmsg2").style.display = "block";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg").style.display = "none";
	setTimeout(function(){ $('#errmsg2').fadeOut(); }, 2000);
}
function s1(){
	document.getElementById("errmsg1").style.display = "block";
	document.getElementById("errmsg2").style.display = "none";
	document.getElementById("errmsgB").style.display = "none";
	document.getElementById("errmsgA").style.display = "none";
	document.getElementById("errmsg3").style.display="none";
	setTimeout(function(){ $('#errmsg1').fadeOut(); }, 2000);
}
function s2(){
	document.getElementById("errmsg2").style.display = "block";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsgB").style.display = "none";
	document.getElementById("errmsgA").style.display = "none";
	document.getElementById("errmsg3").style.display="none";
	setTimeout(function(){ $('#errmsg2').fadeOut(); }, 2000);
}
function s3(){
	document.getElementById("errmsgA").style.display = "block";
	document.getElementById("errmsg2").style.display = "none";
	document.getElementById("errmsgB").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg3").style.display="none";
	setTimeout(function(){ $('#errmsgA').fadeOut(); }, 2000);
}
function s4(){
	document.getElementById("errmsgB").style.display = "block";
	document.getElementById("errmsg2").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsgA").style.display = "none";
	document.getElementById("errmsg3").style.display="none";
	setTimeout(function(){ $('#errmsgB').fadeOut(); }, 2000);
}
function s5()
{
	document.getElementById("errmsg3").style.display="block";
	document.getElementById("errmsgB").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsgA").style.display = "none";
	setTimeout(function(){ $('#errmsg3').fadeOut(); }, 2000);
}
function selecbrah(){
	document.getElementById("errmsg").style.display = "none";
    document.getElementById("branchmsg").style.display = "block";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#branchmsg').fadeOut(); }, 2000);
}
function deselecbrah(){
	document.getElementById("errmsg").style.display = "none";
    document.getElementById("deselectbranchmsg").style.display = "block";
	document.getElementById("errmsg1").style.display = "none";
	document.getElementById("errmsg2").style.display = "none";   	
	document.getElementById("errmsg5").style.display = "none";
	document.getElementById("errmsg6").style.display = "none";
	document.getElementById("errmsg3").style.display = "none";
	document.getElementById("errmsg7").style.display = "none";
	setTimeout(function(){ $('#deselectbranchmsg').fadeOut(); }, 2000);
}

function removeHeight(){
	$('#billDiv').addClass("newDiv");
	$('#mainform').fadeOut();
	$('#collapse').show();
	$('#expand').hide();
}
function addHeight(){
	$('#billDiv').removeClass("newDiv");
	$('#mainform').fadeIn();
	$('#expand').show();
	$('#collapse').hide();
}
function testPopUp(){
	
	document.getElementById("testPopUpDiv").style.display !== "none";
}
function showPopup()	{
	
	var div = document.getElementById("testPopUpDiv");
	if (div.style.display !== "none") {
		div.style.display = "none";
	}
	else {
		div.style.display = "block";
	}
	
}

function datevalid(el){
	
	var rxDatePattern = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
	var v1=$('#'+el).val();
	if(!(rxDatePattern.test(v1)))
		{
		document.getElementById("errmsg").style.display = "block";
		setTimeout(function(){ $('#errmsg').fadeOut(); }, 2000);
		$('#'+el).focus();
		}
}
function onlyNumerics(){	
	alert('a');
    var keyCode = e.which ? e.which : e.keyCode;
    var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1 || keyCode==9  || keyCode==11 || keyCode==13);
    $(".error").css("display", ret ? "none" : "inline");
    return ret;
}
//function for converting string into indian currency format
function intToFormat(nStr)
{
 nStr += '';
 x = nStr.split('.');
 x1 = x[0];
 x2 = x.length > 1 ? '.' + x[1] : '';
 var rgx = /(\d+)(\d{3})/;
 var z = 0;
 var len = String(x1).length;
 var num = parseInt((len/2)-1);

  while (rgx.test(x1))
  {
    if(z > 0)
    {
      x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    else
    {
      x1 = x1.replace(rgx, '$1' + ',' + '$2');
      rgx = /(\d+)(\d{2})/;
    }
    z++;
    num--;
    if(num == 0)
    {
      break;
    }
  }
 return x1 + x2;
}
/*function changeFormat(id){
	var d = new Date();
	alert(id);
	var input=id;
	var my_date_format = function(input){
	  var d = new Date(Date.parse(input.replace(/-/g, "/")));
	  
	  var month = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

	  var date = d.getDay().toString() + " " + month[d.getMonth().toString()] + ", " +    d.getFullYear().toString();
	  var time = d.toLocaleTimeString().toLowerCase().replace(/([\d]+:[\d]+):[\d]+(\s\w+)/g, "$1$2");
	  return (date + " " + time);  

	};
	return my_date_format;
}*/
$.date = function(dateObject) {
    var d = new Date(dateObject);
    var day = d.getDate();
    var month = d.getMonth() + 1;
    var year = d.getFullYear();
    if (day < 10) {
        day = "0" + day;
    }
    if (month < 10) {
        month = "0" + month;
    }
    var date = day + "-" + month + "-" + year;

    return date;
};
function CurrencyFormate(id){
/*var x=$('#'+id).val();*/
x=id.toString();
var afterPoint = '';
if(x.indexOf('.') > 0)
   afterPoint = x.substring(x.indexOf('.'),x.length);
x = Math.floor(x);
x=x.toString();
var lastThree = x.substring(x.length-3);
var otherNumbers = x.substring(0,x.length-3);
if(otherNumbers != '')
    lastThree = ',' + lastThree;
var res = otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",") + lastThree + afterPoint;
return res;
}
var format = function(num){
	/*alert(id);
	var num=$('#'+id).val();*/
	alert(num);
    var str = num.toString().replace("$", ""), parts = false, output = [], i = 1, formatted = null;
    if(str.indexOf(".") > 0) {
        parts = str.split(".");
        str = parts[0];
    }
    str = str.split("").reverse();
    for(var j = 0, len = str.length; j < len; j++) {
        if(str[j] != ",") {
            output.push(str[j]);
            if(i%3 == 0 && j < (len - 1)) {
                output.push(",");
            }
            i++;
        }
    }
    formatted = output.reverse().join("");
    alert("$" + formatted + ((parts) ? "." + parts[1].substr(0, 2) : ""));
    return("$" + formatted + ((parts) ? "." + parts[1].substr(0, 2) : ""));
};