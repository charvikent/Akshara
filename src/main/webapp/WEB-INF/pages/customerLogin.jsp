<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<html>
<head>
<meta charset="utf-8">
<title>Best Login Page design in html and css</title>
<style type="text/css">
/* body {
	background-color: #f4f4f4;
	color: #5a5656;
	font-family: 'Open Sans', Arial, Helvetica, sans-serif;
	font-size: 16px;
	line-height: 1.5em;
} */
a {
	text-decoration: none;
}

h1 {
	font-size: 1em;
}

h1,p {
	margin-bottom: 10px;
}

strong {
	font-weight: bold;
}

.uppercase {
	text-transform: uppercase;
}

/* ---------- LOGIN ---------- */
#login {
	margin: 50px auto;
	width: 300px;
}

form fieldset input[type="text"],input[type="password"] {
	background-color: #e5e5e5;
	border: none;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	color: #5a5656;
	font-family: 'Open Sans', Arial, Helvetica, sans-serif;
	font-size: 14px;
	height: 50px;
	outline: none;
	padding: 0px 10px;
	width: 280px;
	-webkit-appearance: none;
}

form fieldset input[type="submit"] {
	background-color: #008dde;
	border: none;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	color: #f4f4f4;
	cursor: pointer;
	font-family: 'Open Sans', Arial, Helvetica, sans-serif;
	height: 50px;
	text-transform: uppercase;
	width: 300px;
	-webkit-appearance: none;
}

form fieldset a {
	color: #5a5656;
	font-size: 10px;
}

form fieldset a:hover {
	text-decoration: underline;
}

.btn-round {
	background-color: #5a5656;
	border-radius: 50%;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	color: #f4f4f4;
	display: block;
	font-size: 12px;
	height: 50px;
	line-height: 50px;
	margin: 30px 125px;
	text-align: center;
	text-transform: uppercase;
	width: 50px;
}

.facebook-before {
	background-color: #0064ab;
	border-radius: 3px 0px 0px 3px;
	-moz-border-radius: 3px 0px 0px 3px;
	-webkit-border-radius: 3px 0px 0px 3px;
	color: #f4f4f4;
	display: block;
	float: left;
	height: 50px;
	line-height: 50px;
	text-align: center;
	width: 50px;
}

.facebook {
	background-color: #0079ce;
	border: none;
	border-radius: 0px 3px 3px 0px;
	-moz-border-radius: 0px 3px 3px 0px;
	-webkit-border-radius: 0px 3px 3px 0px;
	color: #f4f4f4;
	cursor: pointer;
	height: 50px;
	text-transform: uppercase;
	width: 250px;
}

.twitter-before {
	background-color: #189bcb;
	border-radius: 3px 0px 0px 3px;
	-moz-border-radius: 3px 0px 0px 3px;
	-webkit-border-radius: 3px 0px 0px 3px;
	color: #f4f4f4;
	display: block;
	float: left;
	height: 50px;
	line-height: 50px;
	text-align: center;
	width: 50px;
}

.twitter {
	background-color: #1bb2e9;
	border: none;
	border-radius: 0px 3px 3px 0px;
	-moz-border-radius: 0px 3px 3px 0px;
	-webkit-border-radius: 0px 3px 3px 0px;
	color: #f4f4f4;
	cursor: pointer;
	height: 50px;
	text-transform: uppercase;
	width: 250px;
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
	<div id="login">
		<h1>
			
		</h1>
		<form:form action="validateCustomer.htm" method="post"
			commandName="cusLoginCmd">
			<fieldset>
				<p>
					<form:input autocomplete="off" type="text"
						value="Email/Mobile" path="mobileOrEmail"
						onBlur="if(this.value=='')this.value='Email/Mobile'"
						onFocus="if(this.value=='Email/Mobile')this.value='' " />
				</p>
				<p>
					<form:input type="password" value="Password" path="password"
						onBlur="if(this.value=='')this.value='Password'"
						onFocus="if(this.value=='Password')this.value='' " />
				</p>

				<p>
					<input type="submit" value="Login">
				</p>
			</fieldset>
		</form:form>
		<!-- <p>
			<span class="btn-round">or</span>
		</p>
		<p>
			<a class="facebook-before"></a>
			<button class="facebook">Login Using Facbook</button>
		</p>
		<p>
			<a class="twitter-before"></a>
			<button class="twitter">Login Using Twitter</button>
		</p> -->
	</div>
	<!-- end login -->
</body>
</html>