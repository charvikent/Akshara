<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


			 <%
			 java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
			 java.text.DateFormat df1 = new java.text.SimpleDateFormat("dd-MM-yyyy");
			 
			 Date parsebookeddate = (Date)df.parse(session.getAttribute("completionDate").toString());
			  Date kistaxdate = (Date)df.parse("2016-06-01");
			 int d = parsebookeddate.compareTo(kistaxdate);
			 //out.print(d);
			 double price=0.0;
			 
			 	double totalDiscount = Double.valueOf(session.getAttribute("totalDiscount").toString());
			 	double fixedCharge = Double.valueOf(session.getAttribute("fixedCharge").toString());
			 	double goodscharge = Double.valueOf(session.getAttribute("goodscharge").toString());
			 	double vendorServiceCharge = Double.valueOf(session.getAttribute("vendorServiceCharge").toString());
			 	double transportaionCharge = Double.valueOf(session.getAttribute("transportaionCharge").toString());
			 	double marginValue = Double.valueOf(session.getAttribute("marginValue").toString());
			 	int userId = Integer.valueOf(session.getAttribute("userId").toString());
			 	/* if(userId == 1 ||  userId == 3){
			 		 price = Double.valueOf(session.getAttribute("totalPrice").toString());
			 		 price = price-totalDiscount;
			 	}else{ */
			 	 price = fixedCharge+vendorServiceCharge+transportaionCharge+marginValue;
			 	//}
			 	double servicetax=Double.valueOf(session.getAttribute("servicetax").toString());
			 	double kisantax = 0.0;
			 	double caluculatekisantax = 0.0;
			 if(d>0){
				 kisantax =  Double.valueOf(session.getAttribute("kisantax").toString());
				 caluculatekisantax=price*(kisantax)/100;
			 }
			  
			 
			 	double sbses=Double.valueOf(session.getAttribute("sbses").toString());
			 	double calcuservicetax=price*(servicetax)/100;
			 	double calcusbses=price*(sbses)/100;
			 	double totalprice = price+goodscharge+calcuservicetax+calcusbses+caluculatekisantax;
			 	String strservicetax=String.format("%.2f", calcuservicetax);
			 	String strcalcusbses=String.format("%.2f", calcusbses);
				String strkisantax=String.format("%.2f", caluculatekisantax);
			 	totalprice = Math.round(totalprice);
			 	String strDoubleTprice = String.format("%.2f", Math.ceil(totalprice));
				String strDoublegoodscharge = String.format("%.2f", goodscharge);
				String strDoubleprice = String.format("%.2f", price);

			 	session.getAttribute("serviceName");
			 	session.getAttribute("bookedDate");
			 	session.getAttribute("serviceDate");  
			 	session.getAttribute("invoiceId");
			 	session.getAttribute("clientId");
			 	session.getAttribute("customerName");
			 	String ownerbooked=null;
				 ownerbooked= session.getAttribute("billingTo").toString();
			 	 if(ownerbooked=="null" || ownerbooked==""){
			 		ownerbooked=session.getAttribute("userName").toString();
			 	} 
		 	 if(ownerbooked.equals("Client") ){
			 		ownerbooked=session.getAttribute("displayName").toString();
			 	} 
		 	if(ownerbooked.equals("Tenant") ){
		 		ownerbooked = session.getAttribute("customerName").toString();
		 	} 
		 	if(ownerbooked.equals("Owner") ){
		 		ownerbooked=session.getAttribute("ownerName").toString();
		 	} 
			 	 
			 String userName=	session.getAttribute("displayName").toString();
			     userName = userName.toUpperCase();
			    userName = userName.substring(0,5);
			    
			 %>
			 
			
			<%-- <%= session.getAttribute("serviceDescription") %>
			<%= price %> --%>
			<%-- <%= session.getAttribute("userName") %> --%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Refresh" content="1000">
<link rel="icon" href="images/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<title><%out.print(session.getAttribute("orderId"));  %></title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<!-- <link rel="stylesheet" type="text/css" href="css/invoice.css"> -->

<style type="text/css">
@CHARSET "UTF-8";
.container{
	width:1000px;
	height:650px;
	margin-top: 42px;
}
body {
    position: relative;
    height: 29.7cm;
    margin: 0 auto;
    color: #001028;
    background: #FFFFFF;
    font-family: Arial, sans-serif;
}
a {
  color: #5D6975;
  text-decoration: underline;
}
h1{
	font-size: 19px;
    font-weight: 800;
    margin-top: 0px;
}
div h2{
	font-size: 13px;
    text-align: center;
    margin-top: 0px;
    margin-bottom: 0px;
    font-weight: 600;
}
div img{
	margin-left:161px;
	width:65px;
	
}
.table{
	margin-left: -15px;
    border-left: 2px solid black;
    border-right: 2px solid black;
    height: 78px;
    width: 966px;
    margin-bottom: 0px;
}
table th,
table td {
  text-align: center;
}
table td {
  padding: 5px 20px;
  color: #000;
  border-bottom: 1px solid #C1CED9;
  white-space: nowrap;        
  font-weight: normal;
}
.pan{
  float:left;	
  margin-left: 100px;
}
.space{
	float:left;	
    margin-left: 133px;
    color: rebeccapurple;
    font-size: 10px;
}
.Thanku{
	border: 2px solid black;
    margin-right: 19px;
    margin-left: -15px;
}
.row {
    width: 966px;
    /* border: 2px solid black; */
    border-top: 2px solid black;
    border-left: 2px solid black;
    border-right: 2px solid black;
}
#notice2{
	font-size: 17px;
	font-weight: 600;
	border-top: 2px solid black;
}
#notices{
	border-top: 2px solid black;
    border-bottom: 2px solid black;
}
.main{
	margin-left: -15px;
    border: 2px solid black;
    /* margin-top: 13px; */
    width: 966px;
    height: 469px;
}
.CIN-1{
	height: 83px;
}
.CIN{
	margin-right: 15px;
}
.clearfix:after {
  content: "";
  display: table;
  clear: both;
}
header {
  padding: 10px 0;
}
#project {
  float: left;
}
#project span {
  color: #000;
  text-align: right;
  /*width: 52px;*/
  margin-right: 10px;
  display: inline-block;
  font-size: 0.8em;
}
#company {
  float: right;
  text-align: right;
  font-weight: 600;
  font-size: 13px;
}
#project div,
#company div {
  white-space: nowrap;        
}
.notice{
	font-size: 15px;
	font-weight: 600;
}
.notice1{
	font-size: 15px;
	font-weight: 600;
}
table {
  width: 100%;
  border-collapse: collapse;
  border-spacing: 0;
  margin-bottom: 20px;
}
table th {
    padding: 5px 20px;
    border-bottom: 1px solid #C1CED9;
    white-space: pre-wrap;
    font-weight: 600;
    color: #E83052;
}
table .service,
table .desc {
  text-align: left;
}
footer {
  color: #5D6975;
  width: 100%;
  height: 30px;
  position: absolute;
  bottom: 0;
  border-top: 1px solid #C1CED9;
  padding: 8px 0;
  text-align: center;
}
h1 {  text-align: center; }

</style>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">

var th = ['','thousand','million', 'billion','trillion'];
//uncomment this line for English Number System
//var th = ['','thousand','million', 'milliard','billion'];

var dg = ['Zero','One','Two','Three','Four', 'Five','Six','Seven','Eight','Nine']; 
var tn = ['Ten','Eleven','Twelve','Thirteen', 'Fourteen','Fifteen','Sixteen', 'Seventeen','Eighteen','Nineteen']; var tw = ['Twenty','Thirty','Forty','Fifty', 'Sixty','Seventy','Eighty','Ninety']; function toWords(s){s = s.toString(); s = s.replace(/[\, ]/g,''); if (s != parseFloat(s)) return 'not a number'; var x = s.indexOf('.'); if (x == -1) x = s.length; if (x > 15) return 'too big'; var n = s.split(''); var str = ''; var sk = 0; for (var i=0; i < x; i++) {if ((x-i)%3==2) {if (n[i] == '1') {str += tn[Number(n[i+1])] + ' '; i++; sk=1;} else if (n[i]!=0) {str += tw[n[i]-2] + ' ';sk=1;}} else if (n[i]!=0) {str += dg[n[i]] +' '; if ((x-i)%3==0) str += 'Hundred ';sk=1;} if ((x-i)%3==1) {if (sk) str += th[(x-i-1)/3] + ' ';sk=0;}} 
if (x != s.length)
{
	var y = s.length;
	str += 'point ';
	for (var i=x+1; i<y; i++) 
		str += dg[n[i]] +' ';
	} return str.replace(/\s+/g,' ');
	}

var num = <%= Math.round(totalprice)%>

//alert(num);
</script>
</head>
<body>
 <div class="container">
   <div class="row">
     <header class="clearfix">
      <h1 >Aurospaces Software Pvt Ltd</h1>
      <div id="company" class="clearfix">
        <div style="margin-right: 70px;"><img src="images/logo.png"></div>
        <div class="space"><span>One Space For All Services</span></div><br>
        <div class="CIN"><span>PAN Number</span>&nbsp; :<span>AANCA0353L</span></div>
        <div class="CIN"><span>CIN</span>&nbsp; :<span>U72900KA2014PTC077409</span></div>
        <div class="CIN"><span>Service Tax</span>&nbsp; :<span>AANCA0353LSD001</span></div>
      </div>
     
      <div id="project">
         
         <div class="link_auro" style="padding-left: 10px;"><a>www.aurospaces.com</a></div>
        <div style="padding-left: 10px;"><span>INVOICE NO</span>&nbsp; &nbsp; &nbsp;&nbsp;:<span style="margin-left: 9px;font-size: 13px;font-weight: 900;"> <%= userName %> <%=session.getAttribute("invoiceId") %></span></div>
        <div style="padding-left: 10px;"><span>INVOICE DATE</span> &nbsp;:<span style="margin-left: 11px;font-size: 13px;font-weight: 900;"><%= df1.format(session.getAttribute("invoiceDate")) %></span></div>
        <div style="padding-left: 10px; "><span>ADDRESS</span> &nbsp; &nbsp; &nbsp;&nbsp; :<span style="margin-left: 11px;font-size: 13px;font-weight: 400;  ;"><%= session.getAttribute("address") %></span></div>
      </div>
    </header>
     </div>
     <div class="Thanku">
   <h2>Thanks For Using Aurospaces Services</h2>
   </div>
   <div >
    <table class="table">
  <tr>
    <td style="font-weight: 600;">Billing To</td>
    <td style="font-weight: 600;">Booked ID</td> 
   <td style="font-weight: 600;">House ID</td>  
    <td style="font-weight: 600;">Booking Date</td>
    <td style="font-weight: 600;">Service Date</td>
  </tr>
  <tr>
    <td><%= ownerbooked %></td>
    <td><%= session.getAttribute("clientId") %></td> 
   <td><%= session.getAttribute("houseId") %></td> 
    <td><%= df1.format(session.getAttribute("bookedDate")) %></td>
    <td><%= df1.format( session.getAttribute("completionDate")) %></td>
  </tr>
</table>
 <main class="main">
   <table>
        <thead>
          <tr>
            <th>S.no</th>
            <th class="service">Service ID</th>
            <th class="desc">Service Name</th>
            <th class="desc">Service Description</th>
            <th colspan="1" style="text-align: right;">Price</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="qty">1</td>
            <td class="service" style="white-space: pre-wrap;"><%out.print(session.getAttribute("orderId"));  %></td>
            <td class="desc" style="white-space: pre-wrap;"><%= session.getAttribute("serviceName") %></td>
             <td class="desc" style="white-space: pre-wrap;"><%= session.getAttribute("description") %></td>
            <td class="unit" style="text-align: right;"><%= strDoubleprice %></td>
          </tr>
          <tr>
            <td class="qty" >2</td>
            <td>  </td>
            <td class="service" >Goods</td>
            <td class="desc" style="white-space: pre-wrap;"><%= session.getAttribute("goodsDiscription") %> </td>
            <td colspan="2" style="text-align: right;"><%= strDoublegoodscharge %></td>
          </tr>
          <tr>
            <td colspan="4" class="grand total">Service Tax(<%=servicetax %>%)</td>
            <td class="grand total" style="text-align: right;"><%= strservicetax %></td>
          </tr>
          <tr>
            <td colspan="4" class="grand total">SB Cess(0.5%)</td>
            <td class="grand total" style="text-align: right;"><%= strcalcusbses %></td>
          </tr>
           <tr id="kisantax">
            <td colspan="4" class="grand total">KK Cess(<%= kisantax%>%)</td>
            <td class="grand total" style="text-align: right;"><%= strkisantax %></td>
          </tr>
          <tr>
            <td colspan="4" class="grand total">GRAND TOTAL</td>
            <td class="grand total" style="text-align: right;"><%= strDoubleTprice %></td>
          </tr>
        </tbody>
      </table>
      
      <div id="notices" style="padding-left: 10px;">   
        <div>You have to pay(in words) :<span style="font-size:15px;font-weight:600;" id="totalpriceId">&nbsp;</span> <span style="font-size:15px;font-weight:600;">Rupees Only</span></div>
      </div>
      <div id="notices1" style="padding-left: 10px;">
        <div style="font-size: 17px;font-weight: 600;">Transfer the amount to:</div>
        <div class="notice"  >Kotak Mahindra Bank <br><span>Account : #5711566210,</span><span> IFSC code : KKBK0000424,</span><span>Branch : Koramangla</span></div>
        <div class="notice1"  >Type:Current;<span>Name:</span><span>Aurospaces Software Pvt Ltd</span>                   
      </div>
      </div>
      <div >
      <div id="notice2"  style="padding-left: 10px;">Aurospaces Software Pvt Ltd <br> <a>www.aurospaces.com</a></div>
      <address style="padding-left: 10px;">
      #1190/1,3rd floor, 22nd cross,14th main, 3rd Sector,HSR Layout,Bangalore-560102 <br> Whatsapp (or) call Us at +91-974-255-7757
      </address>
      </div>
    </main>
   </div>
   <div class="was" style="text-align: center;">
   <br>

   Invoice was created on a computer and is valid without the signature and seal.
   </div>
 </div>
</body>
</html>
<script>
window.onload = function() {
    if(!window.location.hash) {
    	window.location.reload();
        window.location = window.location + '#loaded';
        window.location.reload();
    }
}

var s = $("#totalpriceId").text(toWords(parseInt(num)));
/*  */
var x=window.location.href  
//alert(x);
/* $( document ).ready(function() {
	window.location.reload();
	window.location.replace(x);
	
}); */

//window.print(); 
</script>


