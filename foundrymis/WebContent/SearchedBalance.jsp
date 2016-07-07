<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<title>Searched Balance</title>
</head>
<body style="width: 90%">
<% 
try{
String comp =request.getParameter("comp"); 
String from =request.getParameter("from");
String to =request.getParameter("to");
double bal = 0;
if(request.getParameter("q")!=""){
 bal =  Double.parseDouble(request.getParameter("q"));
}else{
	bal = 0;
} 
Connection con = null;
 System.out.println("doun = " + bal);
if(comp.equalsIgnoreCase("101")){ 
	con = ConnectionUrl.getMEPLH21ERP();   
}
if(comp.equalsIgnoreCase("102")){ 
	con	= ConnectionUrl.getMEPLH25ERP(); 
} 
if(comp.equalsIgnoreCase("103")){ 
	con = ConnectionUrl.getFoundryERPNEWConnection();   
}
if(comp.equalsIgnoreCase("105")){	  
	con=ConnectionUrl.getDIERPConnection();
}
if(comp.equalsIgnoreCase("106")){ 
	con = ConnectionUrl.getK1ERPConnection();
} 
if(comp.equalsIgnoreCase("0")){ 
	con = ConnectionUrl.getENGH25CONSConnection();
}
%>

<span id="filter"> 
		<table id="t1" class="t1" border="1" style="width: 90%; border: 1px solid #000;"> 
			<tr style="font-size: 12px; font-family: Arial;"> 
				<th scope="col" class="th">Date</th>
				<th scope="col" class="th">Voucher</th>
				<th scope="col" class="th">Type & No</th>
				<th scope="col" class="th">Account Name</th>
				<th scope="col" class="th">Particulars</th>
				<th scope="col" class="th">Debit Amount</th>
				<th scope="col" class="th">Credit Amount</th> 
				<!-- <th scope="col" class="th">Balance</th>  -->
			</tr> 
			<%
			String dateCheck = "";
			double debit=0;
			int cnt=0;
			double balance = 0;
			ArrayList cmpr = new ArrayList();
			// exec "DIERP"."dbo"."Sel_CashBankBook";1 '105', '0', 101160001, '20140401', '20150331', 1, 1
			CallableStatement cs = con.prepareCall("{call Sel_CashBankBook(?,?,?,?,?,?,?)}");
			cs.setString(1, comp);
			cs.setString(2, "0");
			cs.setString(3, "101160001");
			cs.setString(4, from);
			cs.setString(5, to);
			cs.setString(6, "1");
			cs.setString(7, "1"); 
			ResultSet rs = cs.executeQuery(); 
			while (rs.next()) {
				cmpr.add(rs.getString("TRAN_DATE"));
			}	
			rs = cs.executeQuery();
			while (rs.next()) {
			
				if(dateCheck==""){
			%>
			<tr style="font-family: Arial;font-size: 10px;">
				<td colspan="3"><strong>Date : <%=rs.getString("PRN_TRANDATE") %></strong> </td>
				<td><strong>OPENING BALANCE</strong></td> 
				<td></td> 
				<td align="right"><strong><%=rs.getString("DR_AMT") %></strong></td>
				<td colspan="2"></td>
			</tr>
			<%
			balance = Double.parseDouble(rs.getString("DR_AMT"));
				}else{ 
					int retval = Double.compare(Double.parseDouble(rs.getString("DR_AMT")), bal);
					if(retval > 0) {
						
					balance = (balance+ Double.parseDouble(rs.getString("CR_AMT"))) - Double.parseDouble(rs.getString("DR_AMT")) ;
					balance = Math.round(balance * 100.0) / 100.0; 
			%>
					 <tr style="font-family: Arial;font-size: 10px;">
					 	<td><%=rs.getString("PRN_TRANDATE") %></td>
						<td align="center"><%=rs.getString("VOUCHER_TYPE")%></td>
						<td align="center"><%=rs.getString("TRAN_NO") %></td>
						<td><strong><%=rs.getString("AC_NAME") %></strong></td>
						<td><%=rs.getString("PARTICULARS") %></td>
						<%
						if(rs.getString("CR_AMT").equalsIgnoreCase("0.00")){
						%> 
						<td>&nbsp;</td>
						<%
						}else{
						%>
						<td align="right"><strong><%=rs.getString("CR_AMT") %></strong></td>
						<%	
						}
						%> 
						<td align="right"><%=rs.getString("DR_AMT")%></td>
						
						<%-- <td align="right"><%=balance %></td> --%>
						  
					</tr>  
			<%	 
				}
				}
				dateCheck = rs.getString("TRAN_DATE");
			}
			%>
		</table>  
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>