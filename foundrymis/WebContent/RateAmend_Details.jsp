<%@page import="java.util.HashSet"%>
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
<title>Summary</title>
</head> 
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px; 
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
	border-style: solid;
	border-color: #729ea5;
}
</style>  
<body bgcolor="#EBE4E7" style="font-family: Arial;">
<%
try{   
	Connection con=null;
	String sub = request.getParameter("sub"); 
	String comp = request.getParameter("comp");
	String from = request.getParameter("from"); 
	String to = request.getParameter("to"); 
	String nameCust = request.getParameter("name"); 
	String matcode = "";  
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);
	
	
 
	DecimalFormat zeroDForm = new DecimalFormat("#####0.00");
	
	// System.out.println("sub = " + sub);
 
	String CompanyName="";
	if(comp.equalsIgnoreCase("101")){
		CompanyName = "H-21"; 
		con = ConnectionUrl.getMEPLH21ERP();  
	}
	if(comp.equalsIgnoreCase("102")){
		CompanyName = "H-25"; 
		con	= ConnectionUrl.getMEPLH25ERP(); 
	}
	%>
	<div style="width: 100%; float: left;">
	<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Rate Amendment Details Of <%=nameCust %> from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>

	<strong style="font-family: Arial;font-size: 13px;"><a href="Rate_amend_Summary.jsp?comp=<%=comp %>&from=<%=from %>&to=<%=to %>" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
		 <div style="width:60%; float: left;">
	 		<table border="1" class="tftable">
				<tr style="font-family: Arial;font-size: 13px;">
					<th scope="col" colspan="4"><b style="font-size: 13px;"><%=CompanyName %> Rate Amendment Received</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 12px;">
					<th scope="col">Invoice No.</th>
					<th scope="col">Invoice Date</th>
					<th scope="col">Basic Amount </th>
					<th scope="col">Bill Amount</th>
				</tr>
				 <% 
				 ArrayList subglno = new ArrayList();
				 CallableStatement cs = con.prepareCall("{call Sel_SaleRegisterForAudit(?,?,?,?,?,?)}");
					cs.setString(1,comp);
					cs.setString(2,"0");
					cs.setString(3,from);
					cs.setString(4,to);
					cs.setString(5,"11525,11510,11515"); 
					cs.setString(6,"0");
					ResultSet rs = cs.executeQuery(); 
					while(rs.next()){  
						if(sub.equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
					%>
					<tr style="font-family: Arial;font-size: 12px;">
					<td scope="col" width="15%" align="right"><%=rs.getString("INV_NO") %></td>
					<td scope="col" width="15%" align="right"><%=rs.getString("PRN_TRANDATE") %></td>
					<td scope="col" width="15%" align="right"><%=rs.getString("BASIC_AMT") %></td>
					<td scope="col" width="15%;" align="right"><%=rs.getString("BILL_AMOUNT") %></td>
				</tr>
					<%
						}
					}  								
					%>
			</table>  
 </div>
<%
con.close(); 
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>