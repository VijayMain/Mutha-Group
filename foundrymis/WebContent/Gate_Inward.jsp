<%@page import="java.text.Normalizer.Form"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<html>
<head> 
<title>Gate Inward</title>
<STYLE TYPE="text/css" MEDIA=all> 

.tftable tr {
	background-color: white;
	font-size: 10px;
}

.tftable td {
	background-color: white;
	font-size: 10px;
}

.th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
}
 
</STYLE> 
</head>
<body  style="font-family: Arial;"> 
<%
try{
Connection con =null;
String comp =request.getParameter("company");
String inward_type =request.getParameter("inward_type").toString();  

String from =request.getParameter("date_from");
String to =request.getParameter("date_to");

String fromDate = from.substring(8,10) +"/"+ from.substring(5,7) +"/"+ from.substring(0,4);
String toDate = to.substring(8,10) +"/"+ to.substring(5,7) +"/"+ to.substring(0,4);

String sqlfromDate = from.substring(0,4)   + from.substring(5,7)  + from.substring(8,10);
String sqltoDate = to.substring(0,4) + to.substring(5,7) + to.substring(8,10);

DecimalFormat twoDForm = new DecimalFormat("#####0.00");
DecimalFormat threeDForm = new DecimalFormat("#####0.000");
DecimalFormat noDForm = new DecimalFormat("####0");

String CompanyName="";  
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21 MUTHA ENGINEERING";
	con = ConnectionUrl.getMEPLH21ERP();
}
if(comp.equalsIgnoreCase("102")){
	CompanyName = "H-25 MUTHA ENGINEERING";
	con	= ConnectionUrl.getMEPLH25ERP(); 
} 
if(comp.equalsIgnoreCase("103")){
	CompanyName = "MUTHA FOUNDERS PVT. LTD.";
	con = ConnectionUrl.getFoundryERPNEWConnection();   
}
if(comp.equalsIgnoreCase("105")){	
	CompanyName = "DHANASHREE INDUSTRIES";
	con=ConnectionUrl.getDIERPConnection();
}
if(comp.equalsIgnoreCase("106")){
	CompanyName = "MUTHA ENGINEERING UNIT III";
	con = ConnectionUrl.getK1ERPConnection();
}  
boolean allFlag = false; 
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %> </strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;"><%= inward_type %> Gate Inward from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %></strong>
	<br /> 
<strong style="font-family: Arial; font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	   <div style="width: 100%"> 
		<table id="tftable" class="tftable" border="1" style="width: 100%">  
			<tr style="font-size: 12px; font-family: Arial;">
			<th scope="col" class="th">PARTY NAME</th>
			<th scope="col" class="th">GRN NO</th>
			<th scope="col" class="th">GRN DATE</th>
			<th scope="col" class="th">GATE NO</th>
			<th scope="col" class="th">GATE DATE</th>		 
			</tr>
			<%
			String query ="";
			if(inward_type.equalsIgnoreCase("Against_GRN")){
				query = "select CONVERT(INT, SUBSTRING(CONVERT(VARCHAR,TRNACCTMATH.TRAN_NO),13,6)) AS GRN_NO, "+
						 " TRNACCTMATH.TRAN_NO, "+
						 " TRNACCTMATH.TRAN_DATE,  "+
						 " DBO.FORMAT_DATE(TRNACCTMATH.TRAN_DATE) AS GRN_Date, "+
						 " TRNACCTMATH.SUB_GLACNO AS SUB_GLACNO, "+
						 " CONVERT(INT, SUBSTRING(CONVERT(VARCHAR,TRNACCTMATH.REF_TRANNO1),13,6)) AS Gate_NO, "+
						 " TRNACCTOTHH.TRAN_NO, "+
						 " TRNACCTOTHH.TRAN_DATE, "+
						 " DBO.FORMAT_DATE(TRNACCTOTHH.TRAN_DATE) AS  Gate_Date, "+
						 " MSTACCTGLSUB.SUBGL_LONGNAME from TRNACCTMATH  "+
						 " LEFT JOIN TRNACCTOTHH ON  TRNACCTMATH.REF_TRANNO1 = TRNACCTOTHH.TRAN_NO "+
						 " LEFT JOIN MSTACCTGLSUB ON  TRNACCTMATH.SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
						 " where TRNACCTMATH.TRAN_NO LIKE '%20215%' "+
						 " AND TRNACCTMATH.TRAN_DATE BETWEEN  "+ sqlfromDate + " AND " + sqltoDate; 
			}
			if(inward_type.equalsIgnoreCase("Without_GRN")){
				query = "";
			}
			PreparedStatement ps_bt = con.prepareStatement(query);
			ResultSet rs_bt = ps_bt.executeQuery();
			while(rs_bt.next()){
			%>
			<tr>
				<td><%=rs_bt.getString("SUBGL_LONGNAME") %></td>
				<td align="right"><%=rs_bt.getString("GRN_NO") %></td>
				<td><%=rs_bt.getString("GRN_Date") %></td>
				<td align="right"><%=rs_bt.getString("Gate_NO") %></td>
				<td><%=rs_bt.getString("Gate_Date") %></td>
			</tr>
			<%
			}
			%>
		</table>
<% 
con.close();
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%>
	</div>
	<br> 
</body>
</html>