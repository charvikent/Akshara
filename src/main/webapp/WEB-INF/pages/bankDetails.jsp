<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<title>Vendor Profile</title>


</head>
<body>

	<!-- SET: WRAPPER -->
	<div class="wrapper">
		<!-- SET: CONTAINER -->
		<div class="container">

			<div class="main_content">
						<div class="block-box123 client-topbox">
							<!-- block-box-top-header -->
							<div class="block-input">
								<label>A/c Holder Name<span style="color: red">*</span></label>
								<form:input path="accholderName"
									onfocus="removeBorderChose(this.id)" tabindex="1" />
							</div>
							<div class="block-input">
								<label>Account No<span style="color: red">*</span></label>
								<form:input path="accountNumber" maxlength="30"
							 onkeypress="removeBorder(this.id)"
									tabindex="2" />

							</div>
							<div class="block-input last">
								<label>Bank Name<span style="color: red">*</span></label>
								<form:input path="bankName" cssClass="Box"
									onfocus="removeBorderChose(this.id)" tabindex="3" />
							</div>


							<div class="block-input">
								<label>Branch Name<span style="color: red">*</span></label>
								<form:input path="branchName" id="branchNameId" cssClass="Box"
									onfocus="removeBorderChose(this.id)" tabindex="4" />
							</div>


							<div class="block-input ">
								<label>IFSC Code<span style="color: red">*</span></label>
								<form:input path="ifscCode" id="ifscCodeId" cssClass="Box"
									onfocus="removeBorderChose(this.id)" tabindex="5" />
							</div>
						</div>
	
				
			</div>
		</div>
	</div>
</body>
</html>