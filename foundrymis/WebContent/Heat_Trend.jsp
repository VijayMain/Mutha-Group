<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Category Wise Outstanding</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 { 
	font-size: 10px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
.tftable tr {
	background-color: white;
	font-size: 10px;
}

.th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
}

A:link {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

A:visited {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

.div_freezepanes_wrapper {
	font-size:10px;
	position: relative; 
	width: 99%;
	height: 550px;
	overflow: hidden;
	background: #fff;
	border-style: ridge;
	
}

.div_verticalscroll {
	font-size:10px;
	position: absolute;
	right: 0px;
	width: 18px;
	height: 100%;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonUp {
	width: 20px;
	position: absolute;
	top: 2px;
}

.buttonDn {
	width: 20px;
	position: absolute;
	bottom: 22px;
}

.div_horizontalscroll {
	font-size:10px;
	position: absolute;
	bottom: 0px;
	width: 98%;
	height: 18px;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonRight {
	width: 20px;
	position: absolute;
	left: 0px;
	padding-top: 2px;
}

.buttonLeft {
	width: 20px;
	position: absolute;
	right: 22px;
	padding-top: 2px;
}
</STYLE> 
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<% 
try {
Connection con = null;
String comp =request.getParameter("company");
String datefrom =request.getParameter("FromDate_heattrend");  
String dateto =request.getParameter("ToDate_heattrend"); 

datefrom = datefrom.replaceAll("[-+.^:,]","");
dateto = dateto.replaceAll("[-+.^:,]","");

String date_From = datefrom.substring(6,8) +"/"+ datefrom.substring(4,6) +"/"+ datefrom.substring(0,4);
String date_to = dateto.substring(6,8) +"/"+ dateto.substring(4,6) +"/"+ dateto.substring(0,4);

DecimalFormat zeroDForm = new DecimalFormat("###,##0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
String datetab = datefrom.substring(4,6);
String nameComp = "";

if(comp.equalsIgnoreCase("103")){
	con = ConnectionUrl.getFoundryERPNEWConnection(); 
	nameComp = "MUTHA FOUNDERS PVT.LTD.";
}
if(comp.equalsIgnoreCase("105")){
	con = ConnectionUrl.getDIERPConnection();
	nameComp = "DHANASHREE INDUSTRIES";
}
if(comp.equalsIgnoreCase("106")){
	con = ConnectionUrl.getK1ERPConnection(); 
	nameComp = "MUTHA ENGINEERING PVT.LTD.UNIT III ";
}
if(comp.equalsIgnoreCase("101")){
	con = ConnectionUrl.getMEPLH21ERP();
	nameComp = "H21 MUTHA ENGINEERING PVT.LTD.";
}
if(comp.equalsIgnoreCase("102")){
	con = ConnectionUrl.getMEPLH25ERP();
	nameComp = "H25 MUTHA ENGINEERING PVT.LTD.";
}
if(comp.equalsIgnoreCase("111")){
	con = ConnectionUrl.getENGH25CONSConnection();
	nameComp = "MEPL H21 & MEPL H25 Consolidated";
}
%>
<div>
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=nameComp %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Heat Trend Report from <%=date_From %> to <%=date_to %>&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<strong style="font-family: Arial;font-size: 13px;">
<%
if(comp.equalsIgnoreCase("101") || comp.equalsIgnoreCase("102") || comp.equalsIgnoreCase("111")){
%>
<a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a>
<%
}else{
%>
<a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a>
<%
}
%>
</strong>
<table id="t1" border="1" cellpadding=2 style="width:50%; border: 1px solid #000;"> 
			<tr align="center">
					<th class="th">Day</th>
					<th class="th">Shift 1</th>  
					<th class="th">Shift 2</th>   
					<th class="th">Shift 3</th>
			</tr> 
			<tr align="center" style="background-color: #FEFCFF;cursor: pointer;font-family: Arial;font-size: 10px;" align="center">
					<td align="right"></td>
					<td align="right"></td>
					<td align="right"></td>
					<td align="right"></td>				 				 
			</tr>
			</table>
</div>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>