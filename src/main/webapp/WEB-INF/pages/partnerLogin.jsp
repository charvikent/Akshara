<!doctype html>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<head>
<meta charset="utf8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Neighberhood Platform</title>
<style>
.your-class::-webkit-input-placeholder {
    color: red;
}
.default-class::-webkit-input-placeholder {
    color: red;
}
</style>

<link rel="stylesheet" href="css/logincss.css">
<script src="Branding/js/jquery-1.7.2.js"></script>
<script src="Branding/js/jquery-ui.js"></script>
<script src="Branding/js/Jquery.js" type="text/javascript"></script>
<script src="Branding/js/jPages.min.js" type="text/javascript"></script>
<script src="Branding/js/custompagination.js" type="text/javascript"></script>
<script type="text/javascript" src="Branding/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="Branding/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="Branding/js/MntValidator.js"></script>
<script src="Branding/js/chosen.jquery.js" type="text/javascript"></script>
<script src="Branding/js/jquery.alerts.js" type="text/javascript"></script>
 <script type="text/javascript" src="js/jqueryblockui.js"></script>
<script src="Branding/js/login.js"></script>

<script type="text/javascript" src="Branding/js/jquery.vticker-min.js"></script>

<style type="text/css">
.required {
	color: red;
	font-style: Bold;
}

.error {
	border: 2px solid #f00;
}
</style>
<script type="text/javascript" src="Branding/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="Branding/js/MntValidator.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		               
								 $('#login').click(function(e){
												/* $('#saveIds').css('border', 'solid 3px #862ab7'); */												    
												if($('#email').val().length == 0 || $('#password').val().length == 0){												   
											    if($('#email').val().length == 0 ) {
												    $('#email').css('color','red');
												    $("#email").css("border-color","red");
												    $("#email").attr("placeholder","Please enter email");
												    $('#email').addClass('your-class');
												   
												    }
											     if($('#password').val().length == 0) {
												    $('#password').css('color','red');
												    $("#password").css("border-color","red");
												    $("#password").attr("placeholder","Please enter password");
												    $('#password').addClass('your-class');
												   
												    }	 
											    return false;												  
												    } 
												/* savePartner();
												$('#mobile').removeClass('your-class default-class');
												$('#email').removeClass('your-class default-class');
												$('#password').removeClass('your-class default-class'); */
												 
												   
						});

						
								});
</script>
 <script type="text/javascript">
function removeBorder1(el){
	 $("#"+el).css("border", "2px solid #767676"); 	 
	  $("#"+el).css('color','black');
	  $('#'+el).addClass('default-class'); 
}
function addBorder(el){
	 $("#"+el).css("border", "1px solid #AAA"); 	 
	  $("#"+el).css('color','black');
	  $('#'+el).addClass('default-class'); 
}
</script> 
</head>
<body>
  <section class="container">
    <div class="login">
      <h1>Login to Partner</h1>
      <form method="post" action="partnerLogin.htm">
        <p><input type="text" name="name" id="email" value="" placeholder="Email" onkeydown="removeBorder(this.id)"></p>
        <p><input type="password" name="password" id="password" value="" placeholder="Password" onkeydown="removeBorder(this.id)"></p>
        <p class="submit"><input type="submit" name="commit" id="login" value="Login"></p>
      </form>
    </div>

    <div class="login-help">
      <!-- <p>Forgot your password? <a href="index.html">Click here to reset it</a>.</p> -->
    </div>
  </section>

</body>

</html>