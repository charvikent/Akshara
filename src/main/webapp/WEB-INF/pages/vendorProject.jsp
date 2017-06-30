<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<title>Vendor Project</title>
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

	<!-- SET: WRAPPER -->
	<div class="wrapper">
		<!-- SET: CONTAINER -->
		<div class="container">

			<div class="main_content">
				<c:if test="${empty clientEdit}">
					<form:form name="cf_form" method="post" id="addForm"
						class="form-horizontal" action="#" commandName="vendorCmd"
						enctype="multipart/form-data">
						<div class="block-box2 client-topbox">
							<!-- block-box-top-header -->
							<div class="block-input">
								<label>Image or Video</label>
								<form:input type="file" path="pimagervideo" tabindex="11"
									class="Box" />
							</div>

							<div class="block-input ">
								<label>Description<span style="color: red">*</span></label>
								<form:textarea path="pDescription" id="cityId" maxlength="30"
									class="Box alphabetValid" onblur="checkLength(this.id)"
									onfocus="removeBorder(this.id)" tabindex="5" />
							</div>
							<input class="btn" name="" value="ADD"  type="submit" id="submitId" tabindex="13">	
						</div>
					</form:form>
				</c:if>
				
			</div>
		</div>
	</div>
</body>
</html>