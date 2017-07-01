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

<script type="text/javascript">
	$(function() {
		$("#dateOfBirthh").datepicker({
			changeDate : true,
			changeMonth : true,
			changeYear : true,
			yearRange: "-100:+0",
			showButtonPanel : false,
			dateFormat : 'yy-mm-dd'
		});

	});
	 function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah')
                    .attr('src', e.target.result)
                    .width(100)
                    .height(100);
            };

            reader.readAsDataURL(input.files[0]);
        }
    } 
</script>

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
					<label>First Name<span style="color: red">*</span></label>
					<form:input path="firstName"  maxlength="30"
						class="Box" onfocus="removeBorder(this.id)" tabindex="1" />
				</div>
				<div class="block-input">
					<label>Last Name<span style="color: red">*</span></label>
					<form:input path="lastName" cssClass="Box"
						onfocus="removeBorderChose(this.id)" tabindex="2" />
				</div>
				<div class="block-input last">
					<label>Father Name</label>
					<form:input path="fatherName"  cssClass="Box"
						onfocus="removeBorderChose(this.id)" tabindex="3" />
				</div>
				<div class="block-input">
				<label>Gender<span style="color: red">*</span></label>
								<form:select path="gender" id="genderid" tabindex="4">
								<form:option value="">--Select--</form:option>
								<option value="Male">Male</option>
								<option value="Female">Female</option>
								</form:select>
							</div>

				<div class="block-input">
					<label>Date Of Birth</label>
					<form:input type="text" path="dateOfBirthh" Class="Box"
						tabindex="5" />
				</div>
				
				<div class="block-input last">
					<label>Education<span style="color: red">*</span></label>
					<form:input path="education"  cssClass="Box"
						onfocus="removeBorderChose(this.id)" tabindex="6" />
				</div>
				<div class="block-input">
					<label>Address<span style="color: red">*</span></label>
					<form:textarea type="text" path="address" tabindex="7" class="Box" />
				</div>
				<div class="block-input">
					<label>City<span style="color: red">*</span></label>
					<form:input path="city"  maxlength="30" class="Box"
						onfocus="removeBorder(this.id)" tabindex="8" />
				</div>
				<div class="block-input last">
					<label>Pin<span style="color: red">*</span></label>
					<form:input path="pin"  maxlength="6"
						onfocus="removeBorder(this.id)" tabindex="9" />
				</div>
				<div class="block-input">
					<label>State<span style="color: red">*</span></label>
					<form:select path="state"  style="width:218px"
						cssClass="some-select Box" onfocus="removeBorder(this.id)"
						tabindex="10">
						<form:option value="">--Select--</form:option>
						<form:options items="${states}"></form:options>
					</form:select>
				</div>
				<div class="block-input">
					<label>Land Mark</label>
					<form:input path="landMark" id="landMarkId" maxlength="30"
						onfocus="removeBorder(this.id)" tabindex="11" />
				</div>
				<div class="block-input last">
					<label>PAN No</label>
					<form:input path="panNumber"  maxlength="10"
						class="Box numberValid" onfocus="removeBorder(this.id)"
						tabindex="12" />
				</div>
				<div class="block-input">
					<label>Mobile No<span style="color: red">*</span></label>
					<form:input path="mobileNumber"  maxlength="13"
						minlength="10" onfocus="removeBorder(this.id)" class="Box"
						tabindex="13" />
				</div>
				<div class="block-input">
					<label>Reference No</label>
					<form:input path="referenceNumber" 
						maxlength="13" minlength="10" onfocus="removeBorder(this.id)"
						class="Box" tabindex="14" />
				</div>
				<div class="block-input last">
					<label>Email<span style="color: red"></span></label>
					<form:input path="email"  maxlength="50" cssclass="Box"
						onfocus="removeBorder(this.id)" tabindex="15" />
				</div>
				<div class="block-input">
					<label>Languages Known<span style="color: red">*</span></label>
					<form:input path="languagesKnown" 
						maxlength="50" cssclass="Box" onfocus="removeBorder(this.id)"
						tabindex="16" />
				</div>
				<div class="block-input">
					<label>Native State</label>
					<form:select path="nativeState" cssClass="some-select Box"
						onfocus="removeBorder(this.id)" tabindex="17">
						<form:option value="">--Select--</form:option>
						<form:options items="${states}"></form:options>
					</form:select>
				</div>

				<div class="block-input last">
					<label>Photograph</label> <img width="100" height="100" id = "blah"
						src="http://media.monsterindia.com/monster_2012/girl_100x100.jpg">
					<form:input type="file" path="image" tabindex="18" class="Box" onchange="readURL(this);" />
				</div>
				<div class="block-input">
					<label>Pan</label>
					<form:select path="idProof" style="width: 66px">
						<form:option value="">--Select--</form:option>
						<option value="Yes">Yes</option>
						<option value="No">No</option>
						<input type="file" tabindex="19" style="width: 80px" />
					</form:select>
				</div>
				<div class="block-input">
					<label>Address proof</label>
					<form:select path="addressProof"  style="width: 66px">
						<form:option value="">--Select--</form:option>
						<option value="Yes">Yes</option>
						<option value="No">No</option>
						<input type="file" tabindex="20" style="width: 80px" />
					</form:select>
				</div>
</div>
			</div>

		</div>
	</div>
</body>
</html>