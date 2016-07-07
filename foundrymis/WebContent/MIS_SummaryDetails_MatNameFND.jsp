<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Detailed MIS ItemWise FND</title>
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
	font-family: Arial;
	color: #333333;
	width: 70%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
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
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
<body bgcolor="#EBE4E7" style="font-family: Arial;">
	<%
		try {
			Connection con = ConnectionUrl.getFoundryFMShopConnection();
			String item = "";
			String comp = request.getParameter("comp");
			String OnDateMIS = request.getParameter("ondate");
			String db = request.getParameter("db");
			String matcode = request.getParameter("matcode"); 
			String grade = request.getParameter("grade");
			
			//System.out.println("Mat Code == " + matcode);
			String OnDate = OnDateMIS.substring(6, 8) + "/"
					+ OnDateMIS.substring(4, 6) + "/"
					+ OnDateMIS.substring(0, 4); 
			
		ArrayList qty = new ArrayList(); 
		ArrayList head = new ArrayList(); 
			head.add("Item Name");
			head.add("Scheduled Qty");
			head.add("On Date Prod Qty");
			head.add("On Date Rejection Qty");
			head.add("On Date Rejection %");
			head.add("On Date Despatch Qty");
			head.add("Mold Qty");
			head.add("To Date Prod Qty");
			head.add("To Date Rej Qty");
			head.add("To Date Rejection %");
			head.add("To Date Despatch Qty");
			head.add("Balance Qty");
			head.add("On Date Prod MT");
			head.add("To Date Prod MT");
			head.add("On Date Rejection MT");
			head.add("To Date Rej MT");
			head.add("On Date Despatch MT");
			head.add("To Date Despatch MT");
			head.add("Rate");
			head.add("On Date Despatch Lacs");
			head.add("To Date Despatch lacs");
			head.add("OP Stock MT");
			head.add("Balance Qty MT");
			
			CallableStatement cs = con.prepareCall("{call Sel_RptMISMonthlySummery(?,?,?)}");
	 		cs.setString(1, comp);
	 		cs.setString(2, OnDateMIS);
	 		cs.setString(3, db); 
			ResultSet rs1 = cs.executeQuery(); 
			while(rs1.next()){
				if(rs1.getString("MAT_CODE").equalsIgnoreCase(matcode)){ 
					item = rs1.getString("MAT_NAME");
					qty.add(rs1.getString("MAT_NAME"));
					qty.add(rs1.getString("SCH_QTY"));
					qty.add(rs1.getString("OD_PROD_QTY"));
					qty.add(rs1.getString("OD_REJ_QTY"));
					qty.add(rs1.getString("OD_REJ_PER"));
					qty.add(rs1.getString("OD_DESP_QTY"));
					qty.add(rs1.getString("MOLD_QTY"));
					qty.add(rs1.getString("TD_PROD_QTY"));
					qty.add(rs1.getString("TD_REJ_QTY"));
					qty.add(rs1.getString("TD_REJ_PER"));
					qty.add(rs1.getString("TD_DESP_QTY"));
					qty.add(rs1.getString("BAL_QTY"));
					qty.add(rs1.getString("OD_PROD_MT"));
					qty.add(rs1.getString("TD_PROD_MT"));
					qty.add(rs1.getString("OD_REJ_MT"));
					qty.add(rs1.getString("TD_REJ_MT"));
					qty.add(rs1.getString("OD_DESP_MT"));
					qty.add(rs1.getString("TD_DESP_MT"));
					qty.add(rs1.getString("RATE"));
					qty.add(rs1.getString("OD_DISP_LACS"));
					qty.add(rs1.getString("TD_DISP_LACS"));
					qty.add(rs1.getString("OP_STOCK_MT"));
					qty.add(rs1.getString("BAL_QTY_MT"));
				}
			}
			 
		
		%> 
<strong style="font-family: Arial;font-size: 14px;">MUTHA FOUNDERS PVT.LTD.<br/></strong> 
<strong style="font-family: Arial;font-size: 14px;"><a href="MIS_SummaryDetails_GradeFND.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&grade=<%=grade %>" style="color:blue; text-decoration: none;">&lArr;BACK</a></strong>
<br/>

	<div style="width: 40%; padding-left: 5em; float: left; font-family: Arial;">
		
		<table border="1" class="tftable">
			<tr>
				<th scope="col" align="center" colspan="2"><strong>MIS Summary for <%=item %></strong> </th> 
			</tr>
		<tr>
		<th scope="col">Head</th>
		<th scope="col">Qty</th>
		</tr>
					<% 
					if(qty.size()>0){
						for(int i=0;i<head.size();i++){
							//System.out.println("qty = " + qty.get(18));
					%>
					<tr>
						<td scope="col" align="left"><%=head.get(i).toString() %> </td>
						 
						<td scope="col" align="right"><%=qty.get(i) %></td>
						 
					</tr>
					<%
					}
					}
					%>
			<tr> 
			<td></td>
			<td></td>
			</tr>
		</table>
		<br/>
		<br/>
		<!--============================================================================-->
		<!--============================================================================-->
	</div>

	<%
		con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>