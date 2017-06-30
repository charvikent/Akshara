<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<title>Partner Registration</title>
<style>
.your-class::-webkit-input-placeholder {
	color: red;
}

.default-class::-webkit-input-placeholder {
	color: red;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		               
								 $('#saveIds').click(function(e){
												/* $('#saveIds').css('border', 'solid 3px #862ab7'); */												    
												if( $('#mobile').val().length == 0 || $('#email').val().length == 0 || $('#password').val().length == 0 || $('#name').val().length == 0){												   
											    if($('#mobile').val().length == 0 ) {
												    $('#mobile').css('color','red');
												    $("#mobile").css("border-color","red");
												    $("#mobile").attr("placeholder","Please enter mobile");
												    $('#mobile').addClass('your-class');
												   
												    }	
											    if($('#email').val().length == 0 ) {
												    $('#email').css('color','red');
												    $("#email").css("border-color","red");
												    $("#email").attr("placeholder","Please enter email");
												    $('#email').addClass('your-class');
												   
												    }
											    if($('#password').val().length == 0 ) {
												    $('#password').css('color','red');
												    $("#password").css("border-color","red");
												    $("#password").attr("placeholder","Please enter password");
												    $('#password').addClass('your-class');
												   
												    }
											    if($('#name').val().length == 0 ) {
												    $('#name').css('color','red');
												    $("#name").css("border-color","red");
												    $("#name").attr("placeholder","Please enter password");
												    $('#name').addClass('your-class');
												   
												    }
											    return false;												  
												    } 
												savePartner();
												$('#mobile').removeClass('your-class default-class');
												$('#email').removeClass('your-class default-class');
												$('#password').removeClass('your-class default-class');
												$('#name').removeClass('your-class default-class');
												 
												   
						});

						
								});
</script>
<script>
 function dataClear(){
	 
	 $('#cancelId').css('border', 'none');	
	 $('#saveIds').css('border', 'none');		
	 $('#mobile').val("");
	  removeBorder('mobile');
	  $('#mobile').removeClass('your-class default-class');
	 /*  $("#mobile").attr("placeholder",""); */
	  $('#email').val("");
	  removeBorder('email');
	  $('#email').removeClass('your-class default-class');
	  /* $("#email").attr("placeholder",""); */
	  $('#password').val("");
	  $('#name').val("");
	  removeBorder('password');
	  removeBorder('name');
	  
	  $('#password').removeClass('your-class default-class');
	  /* $("#password").attr("placeholder",""); */
	  document.getElementById("addsus").style.display = "none";
	  document.getElementById("addfail").style.display = "none";
	  document.getElementById("upsus").style.display = "none";
	  document.getElementById("upfail").style.display = "none";
	  document.getElementById("deleteMsgSus").style.display = "none";
	  document.getElementById("deleteMsgFail").style.display = "none";
	  document.getElementById("dupMessage").style.display = "none";
	  
	  $('#saveIds').show();
		$('#saveIds').removeAttr('disabled');
}
</script>
<script type="text/javascript">
	function savePartner(){
		dnr= {};
		dnr.email =$("#email").val();
		dnr.mobile =$("#mobile").val();
		dnr.password =$("#password").val();
		dnr.name =$("#name").val();
		dnr.id =$("#id").val();
		$.ajax({
			type:"POST",
			url:"partnerAdd.htm",
			data:dnr,
			dataType:"json",
			success:function(response){
				if(response != null ){
					showData(response);
					document.getElementById("upsus").style.display = "none";
					document.getElementById("addsus").style.display = "block";
					document.getElementById("deleteMsgSus").style.display = "none";
					$("#email").val("");
					$("#mobile").val("");
					$("#password").val("");
					$("#name").val("");
					$("#id").val(0);
				}
			}
		});
	}
	function onlyNos(e, t) {
	    try {
	        if (window.event) {
	            var charCode = window.event.keyCode;
	        }
	        else if (e) {
	            var charCode = e.which;
	        }
	        else { return true; }
	        if (charCode > 31 && (charCode<45||charCode>57)) {
	        	/* alert("Please enter only numbers"); */
	            return false;
	        }
	        return true;
	    }
	    catch (err) {
	        /* alert(err.Description); */
	    }
	}
	function showData(response){
		$("#userdata ul").remove();
		$("#userdata ul li").remove();
		serviceUnitArray = {};
		$.each(response,
				function(i, catObj) {
				serviceUnitArray[catObj.id] = catObj;
					var tblRow = "<ul>"
							+ "<li class='nine-box' style='width: 530px;' title='"+catObj.email+"'>"
							+ catObj.email
							+ "</li>"
							+ "<li class='nine-box' style='width: 497px;' title='"+catObj.mobile+"'> "
							+ catObj.mobile
							+ "</li>"
							+ "<li class='eleven-box '>"
							+ '<a href="javascript:void(0)" onclick=editPack('
							+ catObj.id + ')' +  ' class="" >Edit</a>'
							+ '</li>'
							+ "<li class='ten-box last'>"
							+ "<a href='javascript:void(0)' id='"
							+ catObj.id
							+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
							+ '</li>'
							 + '</ul>';
					$(tblRow).appendTo("#itemContainer");
				});
		paginationTable(10);
	}
	function editPack(id)
	{
		$('#mobile').val( serviceUnitArray[id].mobile);
		$('#email').val( serviceUnitArray[id].email);
		$('#password').val( serviceUnitArray[id].password);
		$('#name').val( serviceUnitArray[id].name);
		$("#id").val(id);
	}

	function forDelete(id) {
		var count = 0;
		 jConfirm('Do You Want to Delete ?', 'Alert Box',
				 function(r)
				 {
		if (r == true) {
			var deleteId = id;
			$.ajax({
						type : "POST",
						url : "partnerDelete.json",
						data : "id=" + deleteId,
						dataType : "json",
						success : function(list) {
							document.getElementById("upsus").style.display = "none";
							document.getElementById("addsus").style.display = "none";
							document.getElementById("deleteMsgSus").style.display = "block";
							showData(list);
						}
					});
		};
				 });
		
				 
	}
</script>
</head>
<body>

	<div class="wrapper">
		<div class="container">
			<div class="mainfunction savePartner()_content">

				<div class="block">
					<h2>
						<span class="icon1">&nbsp;</span> <a href='javascript:void(0)'
							onclick='addPack()'> New Packages</a>
						<div class="block-footer-right1 fail">
							<div class="alert-danger" id="errmsg1" style="display: none;">
								please enter atleast 3 characters</div>
							<div class="alert-danger" id="errmsg" style="display: none;">
								Alphanumerics, ., & and _ Are only Allowed</div>
							<div class="alert-danger" id="errmsg2" style="display: none;">
								First Letter Should Be Alphanumeric.</div>

						</div>
					</h2>
					<!-- End Box Head -->
					<form:form action="#" commandName="partnerCmd" method="post"
						id="addForm" cssClass="form-horizontal"
						enctype="multipart/form-data">
						<div
							class="block-box-small package-topbox block-box-top-header-dept"
							style="height: 50px !important;">
							<form:hidden path="id"/>
							<div class="block-input">
								<label>Partner name<span style="color: red;">*</span></label>
								<form:input path="name" id="name" maxlength="13"  onkeydown="removeBorder(this.id)" placeholder="Enter org/person name"/>
							</div>
							<div class="block-input">
								<label>Partner email<span style="color: red;">*</span></label>
								<form:input path="email" id="email" onkeydown="removeBorder(this.id)" placeholder="Please enter email" />
							</div>
							<div class="block-input last">
								<label>Partner Password<span style="color: red;">*</span></label>
								<form:password path="password" id="password" onkeydown="removeBorder(this.id)" placeholder="Please enter password" />
							</div>
							<div class="block-input">
								<label>Partner mobile<span style="color: red;">*</span></label>
								<form:input path="mobile" id="mobile" maxlength="13" onkeypress="return onlyNos(event,this);" onkeydown="removeBorder(this.id)" placeholder="Please enter mobile"/>
							</div>
						</div>
						<div class="block-footer">
							<aside class="block-footer-left sucessfully">
								<div id="addsus" style="display: none;">
									<div class="alert-success">
										<spring:message code="label.success" />
										Partner
										<spring:message code="label.saveSuccess" />
									</div>
								</div>
								<div id="addfail" style="display: block;">
									<c:forEach var="fail" items="${param.AddFail}">
										<aside class="block-footer-left fail">
											<spring:message code="label.error" />
											Package
											<spring:message code="label.saveFail" />
										</aside>

									</c:forEach>
								</div>
								<div id="upsus" style="display: none;">

									<div class="alert-success">
										<spring:message code="label.success" />
										Partner
										<spring:message code="label.updateSuccess" />
									</div>

								</div>
								<div id="upfail" style="display: block;">
									<c:forEach var="fail" items="${param.UpdateFail}">
										<aside class="block-footer-left fail">
											<spring:message code="label.error" />
											Service
											<spring:message code="label.updateFail" />
										</aside>
									</c:forEach>
								</div>
								<div id="deleteMsgSus" style="display: none;">
									<aside class="block-footer-left sucessfully">
										<spring:message code="label.success" />
										Partner
										<spring:message code="label.deleteSuccess" />
									</aside>
								</div>
								<div id="deleteMsgFail" style="display: none;">
									<aside class="block-footer-left sucessfully">
										<spring:message code="label.deleteFail" />
										Package
										<spring:message code="label.deleteFail" />
									</aside>
								</div>
								<div class="alert-danger " id="dupMessage"
									style="display: none;">
									<aside class="block-footer-left fail">Warning : Package
										already Exists. Please try Some Other</aside>
								</div>
							</aside>
							<aside class="block-footer-right">
								<input type="button" class="btn-cancel"
									value="<spring:message code="label.clear" />" id="cancelId"
									tabindex="9" onclick="dataClear();" /> <input type="button"
									class="btn-cancel" value="<spring:message code="label.save"/>"
									id="saveIds"  tabindex="8" />
							</aside>
						</div>
					</form:form>


				</div>
			</div>

			<!--Edit Box End  -->
			<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Current Services
					</h2>
					<form:form action="#" commandName="partnerCmd" method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt"
								onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="11" />
							<form:input path="mobile" id="addSearchId" autocomplete="off"
								class="search-input" maxlength="30" tabindex="10" />
						</aside>
					</form:form>
					<!-- <aside class="search-box">
								<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> -->
				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept"
					style='height: 313px !important;'>
					<ul class="table-list">
						<li class="nine-box" style='width: 530px;'>Partner Email</li>
						<li class="nine-box"  style='width: 497px;'>Partner Mobile</li>
						<!-- <li class="nine-box1 " style='width: 300px;'>password</li> -->
						<li class="eleven-box ">Edit</li>
						<li class="ten-box last">Delete</li>
					</ul>
					<div
						class="table-list-blk-dept categery-tablelis data-grid-big paginationParentDiv"
						id="userdata">
						<div id="itemContainer"></div>
					</div>
				</div>
				<div class="block-footer">
					<aside class="block-footer-left">
						<div id="legend2" class="savmarup"></div>
					</aside>
					<aside class="block-footer-right">
						<div class="pagenation">
							<div class="holder"></div>
						</div>
					</aside>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		var list = ${pList};
		showData(list);
		$('#mobile').val("");
		$('#email').val("");
		$('#password').val("");
		$("#id").val(0);
	});
	</script>
	
</body>
</html>
