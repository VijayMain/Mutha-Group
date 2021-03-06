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
	// window.location="RateAmendReduction_Details.jsp?name="+name+"&comp="+comp+"&from="+from+"&to="+to;
	
	String name = request.getParameter("name"); 
	String comp = request.getParameter("comp");
	String from = request.getParameter("from"); 
	String to = request.getParameter("to");   
	
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
	<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Rate Reduction Given Of <%=name %> from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>

	<strong style="font-family: Arial;font-size: 13px;"><a href="Rate_amend_Summary.jsp?comp=<%=comp %>&from=<%=from %>&to=<%=to %>" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
		 <div style="width:60%; float: left;">
	 		<table border="1" class="tftable">
				<tr style="font-family: Arial;font-size: 14px;">
					<th scope="col" colspan="4"><b style="font-size: 14px;"><%=CompanyName %> Rate Reduction Given</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 12px;">
					<th scope="col">GRN No.</th>
					<th scope="col">GRN Date</th>
					<th scope="col">Amount </th>
					<th scope="col">Narration</th>
				</tr> 
				<%
				CallableStatement cs_rc = con.prepareCall("{call Sel_GRNRegister(?,?,?,?,?,?)}");
				cs_rc.setString(1,comp);
				cs_rc.setString(2,"0");
				cs_rc.setString(3,"2027,20219");
				cs_rc.setString(4,from);
				cs_rc.setString(5,to); 
				cs_rc.setString(6,"103");
				ResultSet rs21 = cs_rc.executeQuery(); 
				while(rs21.next()){
					if(name.equalsIgnoreCase(rs21.getString("AC_NAME"))){
				%>
				<tr style="font-family: Arial;font-size: 12px;">
					<td scope="col" align="right"><%=rs21.getString("GRN_NO") %></td>
					<td scope="col" align="right"><%=rs21.getString("PRN_TRANDATE") %></td>
					<td scope="col" align="right"><%=rs21.getString("AMOUNT") %></td>
					<td scope="col" align="left"><%=rs21.getString("SHORT_NARRTN") %></td>
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