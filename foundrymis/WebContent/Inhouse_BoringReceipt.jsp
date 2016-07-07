<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>In-house Boring Receipt</title>
</head>
<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#F7F5FC';
	} else {
		tableRow.style.backgroundColor = '#DEDFE0';
	}
}
</script> 
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 60%;
	padding-left:20px;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 4px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 10px;
	border-width: 1px;
	padding: 4px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
<body bgcolor="#EBE4E7" style="font-family: Arial;">
<%
try{  
//http://localhost:11/foundrymis/Daywise_Boring.jsp?fd=20150201&ld=20150228&cp=101&db=ENGERP&m=2&y=2015
Connection con = null;	
Connection condisp = null;	
String comp =request.getParameter("cp");
String db =request.getParameter("db");
String month=request.getParameter("m");
String year=request.getParameter("y");
String firstdate=request.getParameter("fd");
String lastdate=request.getParameter("ld");
String filter=request.getParameter("filter");

String CompanyName="",matcode="";
String mnt = month;
DecimalFormat zeroDForm = new DecimalFormat("#####0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
month = new DateFormatSymbols().getMonths()[Integer.parseInt(month) -1];

if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21";
	con = ConnectionUrl.getMEPLH21ERP();
	  PreparedStatement ps=con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='105'");
	  ResultSet rs=ps.executeQuery();
	  while(rs.next()){
		  matcode+=rs.getString("code");		  
	  } 
	 // System.out.println("code = " + matcode);
}else{
	CompanyName = "H-25";
	con	= ConnectionUrl.getMEPLH25ERP();
	PreparedStatement ps=con.prepareStatement("select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='105'");
	ResultSet rs=ps.executeQuery();
	while(rs.next()){
		  matcode+=rs.getString("code");
	}
}
String ct = lastdate.substring(6); 
String st = lastdate.substring(0, 6); 
DecimalFormat formatter = new DecimalFormat("00"); 
filter = formatter.format(Integer.parseInt(filter)); 
%> 
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">In-house Boring Receipt of <%=filter %> <%=month %>&nbsp;<%=year %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<br/>
<strong style="font-family: Arial;font-size: 13px;"> 
<a href="Daywise_Boring.jsp?cp=<%=comp%>&fd=<%=firstdate%>&ld=<%=lastdate%>&db=<%=db%>&m=<%=mnt%>&y=<%=year%>" style="text-decoration: none;">&#8656;BACK</a>
</strong>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <span style="font-family: Arial;font-size: 12px;color: brown;"><b>( Note : Click on record to get details &#8628; )</b></span> -->
<br/>
<div style="width: 100%;padding-left: 2em; float: left;"> 
		<form action="PotwiseDetailReportK1.jsp" method="post" id="edit" name="edit">	
	<%

// exec "ENGERP"."dbo"."Sel_SaleRegister";1 '101', '0', '20150201', '20150222', '1155', '0'
 
int sr=1;
CallableStatement csvend = con.prepareCall("{call Sel_BoringRegister(?,?,?,?,?)}");
csvend.setString(1,comp);
csvend.setString(2,"0");
csvend.setString(3,firstdate);
csvend.setString(4,lastdate);
csvend.setString(5,"103,131"); 
ResultSet rs = csvend.executeQuery(); 
	%>
<!--============================================================================-->
<!--============================================================================-->
		<table border="1" class="tftable">
				<tr>
					<th>Sr No</th>
					<th>Vendor Name</th> 
					<th>Date</th>
					<th>Invoice No</th> 
					<th>Challan No</th>
					<th>Challan Qty</th>
				</tr>
				<%
				while(rs.next()){
				if(filter.equalsIgnoreCase(rs.getString("PRN_TRANDATE").substring(0, 2))){	
				%>
				<tr>
					<td align="center"><%=sr %></td>
					<td align="left" width="55%"><%=rs.getString("AC_NAME") %></td>
					<td align="right"><%=rs.getString("PRN_TRANDATE") %></td>
					<td align="right"><%=rs.getString("TRNNO").substring(12) %></td>
					<td align="right"><%=rs.getString("CHLNNO") %></td>
					<td align="right" width="10%"><%=zeroDForm.format(Double.parseDouble(rs.getString("CHLN_QTY"))) %></td>
				</tr>
				<%
				sr++;
				} 
				}
				%>				  
		</table>				

		</form>
	</div>
<%
con.close();
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>