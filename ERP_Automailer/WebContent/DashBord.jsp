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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>Dash Board</title>
</head>
<body>
	<%
		try {
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");  
			Date tdate = new Date();  
			String nowDate = sdfFIrstDate.format(tdate);
			DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
			// System.out.println("Sql Date = " + nowDate); 
			Boolean flag_avail=false;
			String comp = "103";
			int cnt=1;
			double tot_wt =0;
			// exec "FOUNDRYERP"."dbo"."Sel_CustomerwiseDespatchmutha";1 '103', '0', '20170402', '20170405', '101110048', '115'
			// MFPL
			Connection con_erp = ConnectionUrl.getFoundryERPNEWConnection();
			CallableStatement cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
			cs.setString(1, "103");
			cs.setString(2, "0");
			cs.setString(3, "20170402"); 
			cs.setString(4, nowDate);
			cs.setString(5, "101110048");
			cs.setString(6, "115");
			ResultSet rs = cs.executeQuery();
			
	%>
	<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>
	 <tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th scope='col'>S.No</th>
			<th align='center' scope='col'>Invoice No</th>
			<th scope='col'>Invoice Date</th>
			<th scope='col'>Part Name</th>
			<th scope='col'>Sale Rate</th>
			<th scope='col'>Qty</th>
			<th scope='col'>Packets</th>
			<th scope='col'>Weight</th>
			<th scope='col'>Total Weight</th>
			<th scope='col'>Basic Amount</th>
			<th scope='col'>Total Amount</th>
			<th scope='col'>Company</th>
			<th scope='col'>Vehicle No</th>
	</tr>
	<%
	while(rs.next()){
	%>
	<tr>
		<td align="right"><%=cnt %></td>
		<td><%=rs.getString("INV_NO") %></td>
		<td><%=rs.getString("PRN_TRANDATE") %></td>
		<td><%=rs.getString("MAT_NAME") %></td>
		<td align="right"><%=rs.getString("RATE") %></td>
		<td align="right"><%=rs.getString("QTY") %></td>
		<td align="right"><%=rs.getString("TOTAL_BOXES") %></td>
		<td align="right"><%=rs.getString("WEIGHT") %></td>
		<%
		tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
		%>
		<td align="right"><%=twoDForm.format(tot_wt) %></td>
		<td align="right"><%=rs.getString("ITEM_AMOUNT") %></td>
		<td align="right"><%=rs.getString("INV_AMOUNT") %></td>
		<td>MFPL Sale</td>
		<td><%=rs.getString("VEHICLE_NO") %></td> 
	</tr>
	<%
	flag_avail=true;
	cnt++;
		}
		// DI
		cnt=1;
		tot_wt=0;
		con_erp = ConnectionUrl.getDIERPConnection();
		cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
		cs.setString(1, "105");
		cs.setString(2, "0");
		cs.setString(3, "20170302"); 
		cs.setString(4, nowDate);
		cs.setString(5, "101110048");
		cs.setString(6, "115");
		rs = cs.executeQuery();
		while(rs.next()){
				%>
				<tr>
					<td align="right" colspan='13'><%=cnt %></td>
					<td><%=rs.getString("INV_NO") %></td>
					<td><%=rs.getString("PRN_TRANDATE") %></td>
					<td><%=rs.getString("MAT_NAME") %></td>
					<td align="right"><%=rs.getString("RATE") %></td>
					<td align="right"><%=rs.getString("QTY") %></td>
					<td align="right"><%=rs.getString("TOTAL_BOXES") %></td>
					<td align="right"><%=rs.getString("WEIGHT") %></td>
					<%
					tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
					%>
					<td align="right"><%=twoDForm.format(tot_wt) %></td>
					<td align="right"><%=rs.getString("ITEM_AMOUNT") %></td>
					<td align="right"><%=rs.getString("INV_AMOUNT") %></td>
					<td>DI Sale</td>
					<td><%=rs.getString("VEHICLE_NO") %></td> 
				</tr>
				<%
				flag_avail=true;
				cnt++;		
		}
		// H21
				cnt=1;
				tot_wt=0;
				con_erp = ConnectionUrl.getMEPLH21ERP();
				cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
				cs.setString(1, "101");
				cs.setString(2, "0");
				cs.setString(3, "20170302"); 
				cs.setString(4, nowDate);
				cs.setString(5, "101110048");
				cs.setString(6, "115");
				rs = cs.executeQuery();
				while(rs.next()){
						%>
						<tr>
							<td align="right"><%=cnt %></td>
							<td><%=rs.getString("INV_NO") %></td>
							<td><%=rs.getString("PRN_TRANDATE") %></td>
							<td><%=rs.getString("MAT_NAME") %></td>
							<td align="right"><%=rs.getString("RATE") %></td>
							<td align="right"><%=rs.getString("QTY") %></td>
							<td align="right"><%=rs.getString("TOTAL_BOXES") %></td>
							<td align="right"><%=rs.getString("WEIGHT") %></td>
							<%
							tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
							%>
							<td align="right"><%=twoDForm.format(tot_wt) %></td>
							<td align="right"><%=rs.getString("ITEM_AMOUNT") %></td>
							<td align="right"><%=rs.getString("INV_AMOUNT") %></td>
							<td>MEPL H21 Sale</td>
							<td><%=rs.getString("VEHICLE_NO") %></td> 
						</tr>
						<%
						flag_avail=true;
						cnt++;		
				}
				// H25
				cnt=1;
				tot_wt=0;
				con_erp = ConnectionUrl.getMEPLH25ERP();
				cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
				cs.setString(1, "102");
				cs.setString(2, "0");
				cs.setString(3, "20170302"); 
				cs.setString(4, nowDate);
				cs.setString(5, "101110048");
				cs.setString(6, "115");
				rs = cs.executeQuery();
				while(rs.next()){
						%>
						<tr>
							<td align="right"><%=cnt %></td>
							<td><%=rs.getString("INV_NO") %></td>
							<td><%=rs.getString("PRN_TRANDATE") %></td>
							<td><%=rs.getString("MAT_NAME") %></td>
							<td align="right"><%=rs.getString("RATE") %></td>
							<td align="right"><%=rs.getString("QTY") %></td>
							<td align="right"><%=rs.getString("TOTAL_BOXES") %></td>
							<td align="right"><%=rs.getString("WEIGHT") %></td>
							<%
							tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
							%>
							<td align="right"><%=twoDForm.format(tot_wt) %></td>
							<td align="right"><%=rs.getString("ITEM_AMOUNT") %></td>
							<td align="right"><%=rs.getString("INV_AMOUNT") %></td>
							<td>MEPL H25 Sale</td>
							<td><%=rs.getString("VEHICLE_NO") %></td> 
						</tr>
				<%
				flag_avail=true;
				cnt++;		
				}
				// MEPL UIII
				cnt=1;
				tot_wt=0;
				con_erp = ConnectionUrl.getK1ERPConnection();
				cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
				cs.setString(1, "106");
				cs.setString(2, "0");
				cs.setString(3, "20170302"); 
				cs.setString(4, nowDate);
				cs.setString(5, "101110048");
				cs.setString(6, "115");
				rs = cs.executeQuery();
				while(rs.next()){
						%>
						<tr>
							<td align="right"><%=cnt %></td>
							<td><%=rs.getString("INV_NO") %></td>
							<td><%=rs.getString("PRN_TRANDATE") %></td>
							<td><%=rs.getString("MAT_NAME") %></td>
							<td align="right"><%=rs.getString("RATE") %></td>
							<td align="right"><%=rs.getString("QTY") %></td>
							<td align="right"><%=rs.getString("TOTAL_BOXES") %></td>
							<td align="right"><%=rs.getString("WEIGHT") %></td>
							<%
							tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
							%>
							<td align="right"><%=twoDForm.format(tot_wt) %></td>
							<td align="right"><%=rs.getString("ITEM_AMOUNT") %></td>
							<td align="right"><%=rs.getString("INV_AMOUNT") %></td>
							<td>MEPL UIII Sale</td>
							<td><%=rs.getString("VEHICLE_NO") %></td>
						</tr>
						<%
						flag_avail=true;
						cnt++;
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