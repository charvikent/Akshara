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
<link rel="stylesheet" href="Branding/css/chosen.css" />
<style>
.java {
	width: 60px;
	height: 20px;
}
</style>
<script src="Branding/js/jquery-1.7.2.js"></script>
<script src="Branding/js/jquery-ui.js"></script>
<script type="text/javascript">
	var index = 2;
	var list = [];
	function deleteRow(rowid) {
		var j = index - 1;
		var row = document.getElementById(rowid);
		var table = row.parentNode;
		while (table && table.tagName != 'TABLE')
			table = table.parentNode;
		if (!table)
			return;
		table.deleteRow(row.rowIndex);
		if ($("#ser" + j).val() != null && $("#ser" + j).val() != ""
				&& $('#price' + j).val() != null && $('#price' + j).val() != "") {
			list.splice(list.indexOf(row - 1), 1);
		}
		index--;
	}

	function insertRowsss() {
		var j = index - 1;
		//alert($('#price1').val().length);
		if ($("#ser" + j).val() != null && $("#ser" + j).val() != ""
				&& $('#price' + j).val() != null && $('#price' + j).val() != "") {
			var serviceId = "ser" + j;
			var serviceType = $("#ser" + j).val();
			var priceValue = $('#price' + j).val();

			var item = {};
			item['serviceId'] = serviceId;
			item['serviceType'] = serviceType;
			item['priceValue'] = priceValue;
			list.push(item);
			var data = JSON.stringify(list);
			//alert(data);
			$('#listData').val(data);
			alert($('#listData').val());
			var table = document.getElementById("myTableData");
			var row = table.insertRow(table.rows.length);
			row.id = table.rows.length;
			var cell1 = row.insertCell(0);
			var t1 = document.createElement("input");
			t1.id = "ser" + index;
			cell1.appendChild(t1);
			var cell2 = row.insertCell(1);
			var t2 = document.createElement("input");
			t2.id = "price" + index;
			cell2.appendChild(t2);
			var cell3 = row.insertCell(2);

			var t3 = document.createElement("button");
			t3.id = "txtGender" + index;
			var t = document.createTextNode("Delete");
			t3.appendChild(t);
			t3.className = 'java';
			t3.value = 'Delete';
			t3.name = 'Delete' + table.rows.length;
			t3.id = table.rows.length;
			t3.setAttribute("onclick", 'deleteRow(this.id)');
			cell3.appendChild(t3);
			index++;
		} else {
			alert("please fill the data");
		}

	}
</script>
<%-- <body>
<!-- End Google Tag Manager -->
	<!-- SET: WRAPPER -->
	<div class="wrapper">
		<!-- SET: CONTAINER -->
		<div class="container">

			<div class="main_content">
			
				
					
						<div class="block-box1 client-topbox">
							<!-- block-box-top-header -->
							<div id="myform">
<div id="mydata">
<table id="myTableData" cellpadding="2">
    <tr style="width:60x">
    <label style="padding-left: 50px;">Service Type</label>
     <td><input type="text"  id="ser1"></td>
     <label style="padding-left: 50px;">Price</label>
     <td><input type="text" id="price1"></td><td><input type="button" id="add" value="Add" style="width:60x" onclick="Javascript:insertRowsss()"></td>  
    </tr>
    <!--<tr >
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>-->
</table>
</div>
<form:input path="listVendorDetails" id="listData"/>
 </div>
							
						<!-- 	<div id="serviceContainer" style="display: none;">
								<table border="1">
									<tr>
										<th>Service Name</th>
										<th>CheckBox</th>
									</tr>
								</table>
							</div> -->
						</div> 
						
				

			</div>
		</div>
	</div>
</body> --%>
<body>
	<!-- SET: WRAPPER -->
	<div class="wrapper">
		<!-- SET: CONTAINER -->
		<div class="container">

			<div class="main_content">

				<div class="block-box123 client-topbox">
					<!-- block-box-top-header -->
					<div id="mydata">
						<table id="myTableData" cellpadding="2">
							<tr style="width: 60x">
								<label style="padding-left: 50px;">Service Type</label>
								<td><input type="text" id="ser1"></td>
								<label style="padding-left: 50px;">Price</label>
								<td><input type="text" id="price1"></td>
								<td><input type="button" id="add" value="Add"
									style="width: 60x" onclick="Javascript:insertRowsss()"></td>
							</tr>
							
						</table>
					</div>
					<form:hidden path="serviceName" id="listData" /> 
				</div>

			</div>
		</div>

	</div>
	</div>
</body>

</html>