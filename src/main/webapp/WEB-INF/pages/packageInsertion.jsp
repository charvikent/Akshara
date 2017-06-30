<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html >
<html>
<head>
<script type="text/javascript" src="js/js/csvDownload1.js"></script>
<title>Services</title>
<style>
.your-class::-webkit-input-placeholder {
    color: red;
}
.default-class::-webkit-input-placeholder {
    color: red;
}
</style>
 <script type="text/javascript">
$(document).ready(function(){
	chosenDropDown(); 

});


function addPack()
{

	$('#descriptionId').val('' );
	$('#nameId').val('' );
	$('#priceId').val('');
	$('#discountId').val('');
	$('#CdiscountId').val('');
	$('#labelId').val('' );
	$('#packId').val('0');
}

function editPack(id)
{
	$('#descriptionId').val( serviceUnitArray[id].description);
	$('#nameId').val( serviceUnitArray[id].name);
	$('#priceId').val( serviceUnitArray[id].price);
	$('#discountId').val( serviceUnitArray[id].discount);
	$('#CdiscountId').val( serviceUnitArray[id].couponDiscount);
	$('#labelId').val( serviceUnitArray[id].label);
	$('#packId').val(id);
}

function submitForm()
{
		dnr = {};
		dnr.label = $('#labelId').val();
		dnr.discount = $('#discountId').val();
		dnr.couponDiscount = $('#CdiscountId').val();
		dnr.description = $('#descriptionId').val();
		dnr.name = $('#nameId').val();
		dnr.price = $('#priceId').val();
		dnr.vendorId = $('#vendorId').val();
		dnr.serviceId = $('#serviceId').val();
		/* alert( $('#packId').val()); */
		if( $('#packId').val() !=0){
			dnr.id = $('#packId').val();
		}else{
			dnr.id =0;
		}
	$.ajax({
		type : "POST",
		url : "updatePackage.json",
		data : dnr,
		dataType : "json",
		success : function(response) {
			showData(response);
		/* 	alert(dnr.id); */
			if(dnr.id == 0){
				document.getElementById("upsus").style.display = "none";
				document.getElementById("addsus").style.display = "block";
			}else{
				document.getElementById("addsus").style.display = "none";
				document.getElementById("upsus").style.display = "block";
			}	
		}
		});
}

function packageFilter(id){
	
	var vendorId = $("#vendorId").val();
	var serviceId = $("#serviceId").val(); 
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	$.ajax({
		type : "POST",
		url : "searchPackage.htm",
		data : "vendorId=" + vendorId + "&seId=" + serviceId, 
		dataType : "json",
		success : function(response) {
			//alert(packageFilter);
			if (response == "" ) {
				$('#tablePagination').remove();
				/* $("#userdata ul").remove();
				$("#userdata ul li").remove(); */
				$('#noSortData').show();
				$('#legend2').hide();
				$('.holder').hide();
			} else {
			serviceUnitArray = {}
				$('#noSortData').hide();
				$('#legend2').show();
				$('.holder').show();
				showData(response);
			};
			
		}
		});
}

function showData(response){
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	serviceUnitArray = {};
	$.each(response,
			function(i, catObj) {
			serviceUnitArray[catObj.id] = catObj;
				var tblRow = "<ul>"
						+ "<li class='nine-box' title='"+catObj.name+"'>"
						+ catObj.name
						+ "</li>"
						+ "<li class='nine-box' title='"+catObj.description+"'> "
						+ catObj.description
						+ "</li>"
						+ "<li class='nine-box1' ><img height='80px;' id="+catObj.package_vendor_id+" src="+catObj.imgUrl+" onclick='showAllImages(this.id)'  width='300px' >"
						+ "</li>"
						+ "<li class='two-box'>"
						+ catObj.price 
						+ "</li>"
						+ "<li class='two-box'>"
						+ catObj.discount
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
	paginationTable(7);
}

function showAllImages(id){
	var serid =  $("#serviceId").val();
	$("#packageId").val(id);
	$("#serId").val(serid);
	$.ajax({
		type : "POST",
		url : "getPackageImages.json",
		data : "serviceId=" + serid,
		dataType : "json",
			success : function(response) {
			if (response == "" || response==null) {
				} else {
					var  popuptitle="PackageImage";
						 var stockInformation1 ="<table id='stockInformationTable' border='1'>" 
					 		+"<th style=width:19%;>Image </th>"
					 		+"<th style=width:9%;></th>"
					 		+"<th style=width:9%;></th>"
					 		+"</table>";
				$(stockInformation1).appendTo("#dial");
				var stockInformation2 = null;
				$.each(response,function(ind,val){
					var stockInformation2  ="<tr>"+"<td> <img height='150px' width='300px' src='"+val+"'></td>"
					 		+"<td>"+"<center><input type='radio' name='packImg'></center>"+"</td>"
					 		+"<td>"+"<center><input type='button' value='Update' id='"+val+"' onclick='updatePackImage(this.id)'></center>"+"</td>"
					 		+"</tr>";
					 $(stockInformation2).appendTo("#stockInformationTable");
					
				});
					$('#dial').dialog({width:1000,title:popuptitle,modal: true}).dialog('open');
				};  
		},
		
	});
}


function updatePackImage(id){
	var packid = $("#packageId").val();
	var serid = $("#serId").val();
	var url = id;
	$.ajax({
		type : "POST",
		url : "updateImgaesUrl.json",
		data : "packageId=" + packid+"&val="+url+"&serId="+serid,
		dataType : "json",
		success : function(response) {
			 $('#dial').dialog('close');
			 $("#stockInformationTable").remove();
			$("#"+packid).attr("src", url);
		}
	});
	
}
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
    $("#imgUrlId").change(function(){
        readURL(this);
    });
 

    function serviceFilter(id){
    	var vendorId = $("#"+id).val();
    	$.ajax({
    		type : "POST",
    		url : "getServicesForVendors.json",
    		data : "vendorId=" + vendorId,
    		dataType : "json",
    		success : function(response) {
    			/* alert(response); */
    			var optionsForClass = "";
    			optionsForClass = $("#serviceId").empty();
    			optionsForClass.append(new Option("--Select--", ""));
    			$.each(response, function(i, tests) {
    				id=tests.serviceId;
    				var name=tests.serviceName;
    				optionsForClass.append(new Option(name, id));
    			});
    			/* $("#serviceId").val(id); */
    			$("#serviceId").trigger("chosen:updated");
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
<script type="text/javascript">
	
	function forDelete(id) {
		var count = 0;
		 jConfirm('Do You Want to Delete ?', 'Alert Box',
				 function(r)
				 {
		if (r == true) {
			var packageId = id;
			var vendorId=$("#vendorId").val();
			$("#userdata ul").remove();
			$("#userdata ul li").remove();
			$.ajax({
						type : "POST",
						url : "packageDelete.htm",
						data : "packageId="+packageId+"&vendorId="+vendorId,
						dataType : "json",
						success : function(response) {
							//alert("CatList is:"+CatList);
							if (response == "") {
								$('#noSortData').show();
								$('#legend2').hide();
								$('.holder').hide();
							} else {
								$('#noSortData').hide();
								$('#legend2').show();
								$('.holder').show();
								serviceUnitArray = {};
								$.each(response,
										function(i, catObj) {
										serviceUnitArray[catObj.id] = catObj;
											var tblRow = "<ul>"
													+ "<li class='nine-box' title='"+catObj.name+"'>"
													+ catObj.name
													+ "</li>"
													+ "<li class='nine-box' title='"+catObj.description+"'> "
													+ catObj.description
													+ "</li>"
													+ "<li class='nine-box1' ><img height='80px;' id="+catObj.package_vendor_id+" src="+catObj.imgUrl+" onclick='showAllImages(this.id)'  width='300px' >"
													+ "</li>"
													+ "<li class='two-box'>"
													+ catObj.price 
													+ "</li>"
													+ "<li class='two-box'>"
													+ catObj.discount
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
								paginationTable(7);
							};
						},
						
					});
		};
				 });
		
				 
	}
</script>
<script type="text/javascript">
$(document).ready(function() {
	$("#userdata ul").remove();
	$("#userdata ul li").remove();
	paginationTable(3);
});
/* var newwindow;
function popup(url)
{
    newwindow=window.open(url,'getPackageImages','height=400,width=200');   // it takes lotsof more arguments you can use as per your needs
    if (window.focus) {newwindow.focus()}   //to set focus on new opened window
} */

	
	function redirectToImageDisplay(id){
		var newwindow;
		 var serid =  $("#serviceId").val();
		url = 'getPackageImages.htm?packageId='+id+"&serviceId="+serid;
		newwindow=window.open(url,'getPackageImages','height=400,width=500');
		if (window.focus) {newwindow.focus()}
		event.stopPropagation(); // Doesn't work
		  return false; 
}

</script>
  <script type="text/javascript">
	$(document).ready(function() {
						document.getElementById("dupMessage").style.display = "none";

			 	 $('#submitId').click(function(e){
											$('#addForm').attr('action',"<c:url value='/packageAdd.htm'/>");
											$("#addForm").submit();											
											event.preventDefault();
											document.getElementById("dupMessage").style.display = "none";
						});
			 		$('#updateId').click(function(e){
						$('#editForm').attr('action',"<c:url value='/packageUpdate.htm'/>");
						$("#editForm").submit();											
						event.preventDefault();
	});
								});
	 
	
	function searchFunction() {
		var searchId = $('#addSearchId').val();
		if (searchId == "" || searchId == null) {
			jAlert('please enter category', 'Alert Box');
			return false;
		}
		var searchid = $('#searchId').val();
		if(searchid=="" || searchid==""){
			jAlert('please enter the client name', 'Alert Box');
			return false;
		};

	}
</script> 


</head>
<body>

	<div class="wrapper">
		<div class="container">
			<div class="main_content">
				<c:if test="${empty servEdit}">
					<div class="block">
						<h2>
							<span class="icon1">&nbsp;</span>
							<a href='javascript:void(0)' onclick='addPack()' > New Packages</a>
							<div class="block-footer-right1 fail">
									<div class="alert-danger" id="errmsg1" style="display: none;">
										please enter atleast 3 characters
									</div>
									<div class="alert-danger" id="errmsg" style="display: none;">
										Alphanumerics, ., & and _  Are only Allowed
									</div>
									<div class="alert-danger" id="errmsg2" style="display: none;">
										First Letter Should Be Alphanumeric.
									</div>	
																																												
							</div>
						</h2>
						<!-- End Box Head -->
						<form:form action="" commandName="packCmd" method="post"
							id="addForm" cssClass="form-horizontal" enctype="multipart/form-data" >
							<div class="block-box-small package-topbox block-box-top-header-dept">
								<div class="block-input">
											<label>Vendor Name<span
												style="color: red;">*</span></label>
											<form:select path="vendorName"   id="vendorId" tabindex="1" onchange="serviceFilter(this.id)" cssClass="some-select">
											<form:option value="">--Select--</form:option>
											<form:options items="${vendors}"></form:options>
											</form:select>
										</div>
										<div class="block-input">
											<label>Service Name<span
												style="color: red;">*</span></label>
											<form:select path="serviceName" id='serviceId' cssClass="some-select" tabindex="2" onchange="packageFilter(this.id);">
											<form:option value="">--Select--</form:option>
											<form:options items="${servces}"></form:options>
											</form:select>
										</div>
								<div class="block-input last">
											<label>Package Name <span
												style="color: red;">*</span></label>
										<form:input path="name" id="nameId"   
												 autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="3"/>
										</div>	
										<input type=hidden id='packId'  />
										<div class="block-input">
											<label>Description<span
												style="color: red;">*</span></label>
											<form:input path="description" id="descriptionId"   
												 autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="4"/>
										</div>	
								 	 <div class="block-input">
											<label>Price<span
												style="color: red;">*</span></label>
											<form:input path="price" id="priceId"  
												maxlength="30" autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="5"/>
										</div>	
										<div class="block-input last">
											<label>Discount<span
												style="color: red;">*</span></label>
											<form:input path="discount" id="discountId"  
												maxlength="30" autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="6"/>
										</div>		
										<div class="block-input">
											<label>Label<span
												style="color: red;">*</span></label>
											<form:input path="label" id="labelId"  
												maxlength="30" autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="7"/>
										</div>	
										<div class="block-input last">
											<label>Coupon discount<span
												style="color: red;">*</span></label>
											<form:input path="couponDiscount" id="CdiscountId"  
												maxlength="30" autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="6"/>
										</div>		
										<form:hidden path="imgUrl" id="imgUrlId"/>
				<%-- <div class="block-input">
											<label>Label<span
												style="color: red;">*</span></label>
											<form:input path="imgUrl" id="imgUrlId"  
												maxlength="30" autocomplete="off" onkeydown="removeBorder(this.id)"  tabindex="7"/>
										</div>	 --%>													

							</div>
							<div class="block-footer">
								<aside class="block-footer-left sucessfully">
									<div id="addsus" style="display: none;">
											<div class="alert-success">
												<spring:message code="label.success" />
												Package 
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
												Package 
												<spring:message code="label.updateSuccess" />
											</div>
										
									</div>
									<div id="upfail" style="display: block;">
										<c:forEach var="fail" items="${param.UpdateFail}">	
							             	<aside class="block-footer-left fail">
												<spring:message code="label.error" /> Service 
												<spring:message code="label.updateFail" />
											</aside>
										</c:forEach>
									</div>
									<div id="deleteMsgSus" style="display: none;">
										<aside class="block-footer-left sucessfully">
											<spring:message code="label.success" />
											Package 
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
										<aside class="block-footer-left fail">Warning :
											Package  already Exists. Please try Some Other</aside>


									</div>

								</aside>
								<aside class="block-footer-right">
									<input type="button"
										class="btn-cancel"
										value="<spring:message code="label.clear" />" id="cancelId" tabindex="9"  onclick="dataClear();"/>
									<!-- input type="submit" class="btn-save"
										value="<spring:message code="label.save"/>" id="submitId0" tabindex="3"/ -->
									<input type="button" class="btn-cancel"
										value="<spring:message code="label.save"/>" id="submitId0" onclick="submitForm()" tabindex="8"/>
								</aside>
							</div>
						</form:form>


					</div>					
				</c:if>
			</div>
			
			<!--Edit Box End  -->
			<div class="block table-toop-space">
				<div class="head-box">
					<h2>
						<span class="icon2">&nbsp;</span>Current Services
					</h2>
					<a href="#" class="export" style="color: yellow;">Export Table data into CSV</a>
					<form:form action="searchPackageName.htm" commandName="packCmd" method="get">
						<aside class="search-box">
							<input type="submit" class="search-bnt" onclick="return searchFunction()"
								value="<spring:message code="label.search"/>" tabindex="11"/>
							<form:input path="name" id="addSearchId" 
								autocomplete="off" class="search-input" maxlength="30" tabindex="10"/>
						</aside>
					</form:form>
					<!-- <aside class="search-box">
								<input class="search-bnt" name="" value="Search" type="button">
								<input class="search-input" name="" type="text">
							</aside> -->
				</div>
				<div class="block-box-dept categery-downbox block-box-last-dept itemContainer" style='height: 313px !important;'>
					<ul class="table-list">
						<li class="nine-box">Package Name</li>
						<li class="nine-box">Description</li>
						<li class="nine-box1" style='  width: 300px;'>Image</li>
						<li class="two-box">Price</li>
						<li class="two-box">Discount</li>
						<li class="eleven-box ">Edit</li>
						<li class="ten-box last">Delete</li>
						
					</ul>
					<div class="table-list-blk-dept categery-tablelis data-grid-big paginationParentDiv" id="userdata">
						<div id="itemContainer" class="itemContainer"></div>
					</div>
				</div>
					<div class="block-footer">
					  <aside class="block-footer-left"><div id="legend2" class="savmarup"></div></aside>
						<aside class="block-footer-right">
						<div class="pagenation">
							<div class="holder"></div>
							</div>
						</aside> 
				</div>
			</div>
		</div>
		<!-- End Content -->
		<div id='global'><div id="dial"></div></div>
		
		<input type='hidden' id='urlId'>
		 <input type="hidden" id="packageId"  />
		<input type="hidden" id="serId" />
	</div>
</body>
</html>
