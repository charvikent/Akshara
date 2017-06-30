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

	<!-- SET: WRAPPER -->
	<div class="wrapper">
		<!-- SET: CONTAINER -->
		<div class="container">

			<div class="main_content">
			
				
						<div class="block-box123 client-topbox">
							<!-- block-box-top-header -->
							<%-- <div class="block-input">
								<label>Country<span style="color: red">*</span></label>
								<form:select path="servingCountry" id="servingcountryId"
									 onfocus="removeBorder(this.id)"
									tabindex="1">
									<form:option value="">--Select--</form:option>
									<form:options items="${states}"></form:options>
								</form:select>
							</div> --%>
							<%-- <div class="block-input">
								<label>State<span style="color: red">*</span></label>
								<form:select path="servingState" id="servingstateId" style="width:218px"
									onfocus="removeBorder(this.id)"
									tabindex="1">
									<form:option value="">--Select--</form:option>
									<form:options items="${states}"></form:options>
								</form:select>
							</div> --%>
							
							<div class="block-input">
								<label>City<span style="color: red">*</span></label>
								<form:select path="locationName" id="locationNameId" style="width:218px" cssClass="some-select Box"
									onfocus="removeBorder(this.id)"
									tabindex="1">
									<form:option value="">--Select--</form:option>
									<form:options items="${locations}"></form:options>
								</form:select>
							</div>
							
							<%-- <div class="block-input">
								<label>City<span style="color: red">*</span></label>
								<form:input path="servingCity" id="servingcityId" maxlength="30"
									class="Box" onfocus="removeBorder(this.id)" tabindex="2"/>
							</div> --%>
							<div class="block-input last">
								<label>Area<span style="color: red">*</span></label>
								<form:input path="servingLocation" id="servinglocationId" maxlength="30"
									class="Box" onfocus="removeBorder(this.id)" tabindex="3" />
							</div>
							<div id="serviceContainer" style="display: none;">
								<table border="1">
									<tr>
										<th>Service Name</th>
										<th>CheckBox</th>
									</tr>
								</table>
							</div>
						</div>
						
			</div>
		</div>
	</div>
</body>
</html>