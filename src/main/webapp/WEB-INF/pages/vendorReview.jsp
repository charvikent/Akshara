<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<title>Vendor Review</title>
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
						<div class="block-box3 client-topbox">
							<!-- block-box-top-header -->
							<div class="block-input">
								<label>First Name<span style="color: red">*</span></label>

								<form:input path="rFirstName" id="deptIds"
									onchange="getClient(),searchClients(this.id)"
									onfocus="removeBorderChose(this.id)" tabindex="1" />

							</div>

							<div class="block-input">
								<label>Last Name<span style="color: red">*</span></label>
								<form:input path="rLastName" id="themeId" cssClass="Box"
									onfocus="removeBorderChose(this.id)" tabindex="3" />
							</div>

							<div class="block-input last">
								<label>Contact Number<span style="color: red">*</span></label>
								<form:input path="contactNumber" id="contactNoId" maxlength="13"
									onblur="checkLengthM(this.id)" class="Box numberValid"
									onfocus="removeBorder(this.id)" tabindex="8" />
							</div>
							<div class="block-input">
								<label>Email<span style="color: red">*</span></label>
								<form:input path="email" id="emailId" maxlength="30"
									onfocus="removeBorder(this.id)" class="Box"
									onblur="validateEmail(this.id)" tabindex="9" />
							</div>

							<div class="block-input">
								<label>Review Date<span style="color: red">*</span></label>
								<form:input path="reviewDate" id="emailId" maxlength="30"
									onfocus="removeBorder(this.id)" class="Box"
									onblur="validateEmail(this.id)" tabindex="9" />
							</div>
							<div class="block-input last">
								<label>Description<span style="color: red">*</span></label>
								<form:input path="rDescription" id="cityId" maxlength="30"
									class="Box alphabetValid" onblur="checkLength(this.id)"
									onfocus="removeBorder(this.id)" tabindex="5" />
							</div>

							<div class="block-input">
								<label>Image or Video</label>
								<form:input type="file" path="imageRVideo" tabindex="11"
									class="Box" />
							</div>
							<div class="block-input">
								<label>Happy Percentage<span style="color: red">*</span></label>

								<form:select path="rHappyPercentage" id="deptIds"
									onchange="getClient(),searchClients(this.id)"
									onfocus="removeBorderChose(this.id)" tabindex="1">
									<form:option value="">--Select--</form:option>
									<form:options items="${categoryList}"></form:options>
								</form:select>
							</div>

							<div class="block-input last">
								<label>Service Type<span style="color: red">*</span></label>

								<form:select path="serviceType" id="deptIds"
									onchange="getClient(),searchClients(this.id)"
									onfocus="removeBorderChose(this.id)" tabindex="1">
									<form:option value="">--Select--</form:option>
									<form:options items="${categoryList}"></form:options>
								</form:select>
							</div>
						</div>
					</form:form>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>