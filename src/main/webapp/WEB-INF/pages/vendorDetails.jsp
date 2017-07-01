<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="js/js/csvDownload1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Orders</title>
<style>
.table-list-blk ul li.three-boxxx {
	width: 186px;
	text-align: center;
}

.table-list-blk ul li.forth-boxxxstatus {
	width: 127px;
}

.table-list-blk ul li.one1-box {
	width: 202px;
}
/* .table-list-blk ul li.quantity-boxxx{
width: 175px;
text-align:center;
} */
.table-list-blk ul li.one-boxxx {
	width: 235px;
}

.one-boxxx {
	width: 235px;
}

.two-boxxx {
	width: 100px;
}

.three-boxxx {
	width: 100px;
	text-align: center;
}

.colorbox {
	color: #800000;
}

.forth-boxxxstatus {
	width: 127px;
}

.stock-pcode-boxnew {
	width: 175px;
}

.table-list-blk ul li.eleven-box {
	width: 37px;
}

.one {
	width: 102px;
	text-align: center;
}

.quantity-boxxx {
	width: 175px;
	text-align: center;
}

.one-boxx {
	width: 362px
}

.one-boxu {
	width: 50px;
	text-align: center;
}

.ten-boxq {
	width: 50px;
}

.butsave {
	cursor: pointer;
}
/* mouse over link */
.changeColor {
	
}

a:hover {
	color: #800000;
}
</style>
 

</head>
<body>

	<div class="wrapper">
		<!-- SET: CONTAINER -->
		<div class="container">
			<div class="main_content">
				<form:form action="vendorDetails.htm" commandName="vendorCmd" method="get"
					id="addForm" cssClass="form-horizontal">

					<div class="block">
						<div class="head-box">
							<h2>
								<span class="icon2">&nbsp;</span>Admin Order Details
							</h2>
							<a href="#" class="export" style="color: yellow;">Export Table data into CSV</a>
							<div  id="dupMessage" style="color: red;"></div>
							<div  id="upsus" style="color: green;"></div>
						</div>
						<div
							class="block-box-deptpurchaser purchases-downbox block-box-last-deptpurchaser"
							id="divheader">
							<div class="table-list-blk purchase-tablelist paginationParentDiv itemContainer"
								id="userdata" style="overflow-x: scroll;overflow-y: hidden; ">
							<ul class="table-list" style="width:202%;   font-weight: 600;">
								<li class="two-boxxx">Vendor Name</li>
								<li class="two-boxxx">Address</li>
								<li class="two-boxxx">City</li>
								<li class="two-boxxx">Mobile Number</li>
								<!-- <li class="two-boxxx">Schedule Date</li>
								<li class="two-boxxx">Schedule Time</li>
								<li class="two-boxxx">Contact No</li>
								<li class="two-boxxx">Contact Email</li>
								<li class="two-boxxx">Status</li>
								<li class="two-boxxx">Customer Discount</li>
								<li style="width:70px;">B2C Price</li>
								<li style="width:70px;">Discount %</li>
								<li style="width:70px;">NetAmount</li>
								<li class="two-boxxx">PickDate</li>
								<li class="two-boxxx">PickTime</li>	
								<li style='width:175px'>Vendor</li>
								<li style='width:175px'>Vendor Details</li>
								<li class="two-boxxx">Change Status</li>
								<li class="two-box last">Update</li> -->
							</ul>
								<ul>
								<div id="itemContainer" class="itemContainer" style="width: 202%">
								</div>
								</ul>
							</div>
							
							<div align="center">
								<h4 id="noSortData" style="display: none">No Data Found</h4>
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
							<aside></aside>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
$(document).ready(function() {
	
	var categoryList = ${VendorList};
	if (categoryList == "") {
		$('#tablePagination').remove();
		$("#userdata ul li").remove();
		$('#noSortData').show();
		$('#legend2').hide();
		$('.holder').hide();
	} else {
		$('#noSortData').hide();
		$('#legend2').show();
		$('.holder').show();
		$.each(categoryList,
						function(i, catObj) {
							var tblRow = "<ul>"
									 + "<li class='dept-box'>"
									 + catObj.firstName
									 + "</li>"
									 + "<li class='dept-box'>"
									 + catObj.address
									 + "</li>"
									 + "<li class='dept-box'>"
									 + catObj.city
									 + "</li>"
									 + "<li class='dept-box'>"
									 + catObj.mobileNumber
									 + "</li>"
									+ "<li class='eleven-box '>"
									+ '<a href="editCat.htm?categoryId='
									+ catObj.id
									+ '" class="">Edit</a>'
									+ '</li>'
									+ "<li class='ten-box last'>"
									+ "<a href='javascript:void(0)' id='"
									+ catObj.id
									+ "' onclick='forDelete(this.id)' class='ico del'>Delete</a>"
									+ '</li>'
									 + '</ul>';
							$(tblRow).appendTo("#itemContainer");

							
						});
	};
	paginationTable(12);
});
</script>
	<div id="dial"></div>
</body>
</html>