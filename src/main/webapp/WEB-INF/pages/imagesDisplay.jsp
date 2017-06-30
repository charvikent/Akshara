<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function getImageName(id) {
		$('#urlId').val(id);
	}
	function getName() {
		var val = $('#urlId').val();
		var packId = $('#packageId').val();
		opener.location.href = "updateImgaesUrl.htm?packageId=" + packId + "&val="
				+ val;
		/* window.opener.location.reload(); */
		 self.close(); 
	}

	$(document)
			.ready(
					function() {
						var list = ${imageUrlList};
						if (list != null) {
							$
									.each(
											list,
											function(i, itemSelectedInfo) {
												var tblRow = "<tr><td style='padding-top :10px;'><img height='150px' width='300px ' src="+itemSelectedInfo+"></td>"
														+ "<td style='padding-left :10px; '><input type='radio' style='width:30px; height: 45px;' id="
														+ itemSelectedInfo
														+ " onclick='getImageName(this.id);'   name='package' ></td>"
														+ "<td style='padding-left :10px'><input style='width:50px; height:20px;' value='Update' type='button' onclick='getName();'></td></tr>";
												$(tblRow).appendTo(
														"#itemContainer");
											});

						}

					});
</script>
</head>



<div class="wrapper">
	<div class="container">
		<div class="main_content">
				<!-- End Box Head -->
				<form:form action="" commandName="packCmd" method="post"
					id="addForm" cssClass="form-horizontal"
					enctype="multipart/form-data">
					<div
						class="block-box-small client-topbox block-box-top-header-dept"
						style="height: 500px !important; overflow-y:scroll">

						<table id="itemContainer"></table>
						<input type='hidden' id='urlId'> <input type="hidden"
							id="packageId" value="<%=request.getParameter("packageId")%>" />
						<input type="hidden" id="serviceId"
							value="<%=request.getParameter("serviceId")%>" />


					</div>
					<%-- <div class="block-footer">
						<aside class="block-footer-left sucessfully">

							<div class="alert-danger " id="dupMessage" style="display: none;">
								<aside class="block-footer-left fail">Warning :</aside>
							</div>

						</aside>
						<aside class="block-footer-right">
							<input type="button" class="btn-cancel"
								value="<spring:message code="label.clear" />" id="cancelId"
								tabindex="4" onclick="dataClear();" />
							<!-- input type="submit" class="btn-save"
										value="<spring:message code="label.save"/>" id="submitId0" tabindex="3"/ -->
							<input type="button" class="btn-cancel"
								value="<spring:message code="label.save"/>" id="submitId0"
								onclick="submitForm()" tabindex="3" />
						</aside>
					</div> --%>
				</form:form>


		</div>


	</div>
</div>