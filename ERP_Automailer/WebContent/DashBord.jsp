<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionERPUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>Dash Board</title>
</head>
<body>
	<%
		try {
			Connection con = ConnectionUrl.getFoundryFMShopConnection();
			String comp = "103";
			String db = "FOUNDRYERP";
			CallableStatement cs2 = con.prepareCall("{call Sel_DBFoundryProdMIS(?,?,?,?)}");
	 		cs2.setString(1, comp);
	 		cs2.setString(2, "0");
	 		cs2.setString(3, "20170213");
	 		cs2.setString(4, db);
			ResultSet rs_stk = cs2.executeQuery();
	%>
	<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>
	 <tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th scope='col'>Item Name</th>
			<th scope='col'>Schedule Qty</th>
			<th scope='col'>Production Qty</th>
			<th scope='col'>Dispatch Qty</th>
		</tr>
		<%
		while(rs_stk.next()){
			//System.out.println("Date  = = " + Double.valueOf(rs1.getString("ON_PRODQTY")) + " = " +  Double.valueOf(rs1.getString("ON_DISPQTY")));
			if(Double.valueOf(rs_stk.getString("ON_PRODQTY"))==0.0 && Double.valueOf(rs_stk.getString("ON_DISPQTY"))==0.0){
			}else{
				if(!rs_stk.getString("MAT_NAME").equalsIgnoreCase("")){
		%>
		<tr>
			<td align="left"><%=rs_stk.getString("MAT_NAME") %></td>
			<td align='right'><%=rs_stk.getString("SHEDULE_QTY") %></td>
			<td align='right'><%=rs_stk.getString("ON_PRODQTY") %></td>
			<td align='right'><%=rs_stk.getString("ON_DISPQTY") %></td>
		</tr>
<%
				}
			}
		}
		rs_stk.close();
%>
</table>
<table border='1' style='font-size: 12px; color: #333333; width: 60%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>
<%	
	if (cs2.getMoreResults()) {
    rs_stk = cs2.getResultSet();
 %>
  <tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th scope='col'>Prod Qty MT</th>
			<th scope='col'>Disp Qty MT</th>
			<th scope='col'>Opening Stock MT</th>
			<th scope='col'>Bal Stock MT</th>
			<th scope='col'>Closing Stock MT</th>
		</tr>
 <%
    while(rs_stk.next()){
%> 
 <tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<td align="right"><%=rs_stk.getString("TO_PROD_MT") %></td>
			<td align='right'><%=rs_stk.getString("TO_DISP_MT") %></td>
			<td align='right'><%=rs_stk.getString("TO_OPESTOCK_MT") %></td>
			<td align='right'><%=rs_stk.getString("TO_BALSTOCK_MT") %></td>
			<td align='right'><%=rs_stk.getString("CLOSING_STKMT") %></td>
		</tr>
<%
    }
 rs_stk.close();
 }
%>
	</table>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>