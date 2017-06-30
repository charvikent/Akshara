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

function serviceFilter(id){
	var vendorId = $("#parentCategory1").val();
	$.ajax({
		type : "POST",
		url : "getServicesForCategory.json",
		data : "parentCategoryId=" + vendorId,
		dataType : "json",
		success : function(response) {
			/* alert(response); */ 
			var optionsForClass = "";
			optionsForClass = $("#serviceId").empty();
			optionsForClass.append(new Option("--Select--", ""));
			$.each(response, function(i, tests) {
				var id=tests.id;
				var name=tests.name;
				optionsForClass.append(new Option(name, id));
			});
			$('#serviceId').trigger("chosen:updated");
		},
		error : function(e) {
		},
		statusCode : {
			406 : function() {
		
			}
		}
	});
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
								<label>Mother Category<span style="color: red">*</span></label>
								<form:select path="parentCategory1" onchange="serviceFilter(this.id);"  cssClass="some-select"
									 onfocus="removeBorder(this.id)" tabindex="1">
									<form:option value="">--Select--</form:option>
									<form:options items="${cateogrys}"></form:options>
								</form:select>
							</div>
							<%-- <div class="block-input">
								<label>Mother Cateogry2<span style="color: red">*</span></label>
								<form:select path="parentCategory2" 
									 onfocus="removeBorder(this.id)" tabindex="2">
									<form:option value="">--Select--</form:option>
									<form:options items="${cateogrys}"></form:options>
								</form:select>
							</div> --%>
							<div class="block-input">
								<label>Sub Cateogry<span style="color: red">*</span></label>
								<form:select path="subCategory1" id="serviceId" cssClass="some-select" multiple="multiple">
									<form:option value="">--Select--</form:option>
									<form:options items="${Services}"></form:options>
								</form:select>
							</div>
							<div class="block-input last">
								<label>Qualification<span style="color: red">*</span></label>
								<form:input path="qualification" onfocus="removeBorderChose(this.id)" tabindex="3" />
							</div>
							<div class="block-input">
								<label>License No</label>
								<form:input path="certifications" maxlength="30"
									autocomplete="off" onkeypress="removeBorder(this.id)"
									tabindex="4" />

							</div>
							<div class="block-input">
								<label>Company Name<span style="color: red">*</span></label>
								<form:input path="company" cssClass="Box"
									onfocus="removeBorderChose(this.id)" tabindex="5" />
							</div>


							<div class="block-input last">
								<label>No of Employees</label>
								<form:input path="employees" id="employeesId" cssClass="Box"
									onfocus="removeBorderChose(this.id)" tabindex="6" />
							</div>
					 	<div class="block-input">
								<label>portfolio Files</label>
								<form:input type="file" path="portfolio" tabindex="7"
									class="Box" />
							</div>
							<div class="block-input">
								<label>video Files</label>
								<form:input type="file" path="videos" tabindex="8"
									class="Box" />
							</div>
							<div class="block-input last">
								<label>Mou</label>
								<form:input type="file" path="moufiles" tabindex="9"
									class="Box" />
							</div>
							<div class="block-input">
								<label>Commercials</label>
								<form:input type="file" path="commercialsfiles" tabindex="10"
									class="Box" />
							</div> 
						</div>
			</div>

		</div>
	</div>
</body>
</html>