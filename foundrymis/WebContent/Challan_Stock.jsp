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
<title>Challan Stock</title>
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
	font-size: 11px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 4px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
} 
</STYLE> 
<script type="text/javascript">
	function getExcel_Report(comp, from, to) {
		document.getElementById("fileloading").style.visibility = "visible";
		document.getElementById("filebutton").disabled = true;
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("exportId").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Challan_StockXls.jsp?company=" + comp + "&date_from=" + from + "&date_to=" + to, true); 
		xmlhttp.send();
	}
</script>
</head>
<body  style="font-family: Arial;"> 
<%
try{
Connection con =null;
String comp =request.getParameter("company");
String from =request.getParameter("date_from");
String to =request.getParameter("date_to");
String sup =request.getParameter("sup");

String fromDate = from.substring(8,10) +"/"+ from.substring(5,7) +"/"+ from.substring(0,4);
String toDate = to.substring(8,10) +"/"+ to.substring(5,7) +"/"+ to.substring(0,4);

String sqlfromDate = from.substring(0,4)   + from.substring(5,7)  + from.substring(8,10);
String sqltoDate = to.substring(0,4) + to.substring(5,7) + to.substring(8,10);

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

ArrayList codes = new ArrayList();
PreparedStatement ps=con.prepareStatement("SELECT SUB_GLACNO FROM MSTACCTGLSUB WHERE SUB_GLCODE =12");
 ResultSet rs3=ps.executeQuery();
 while(rs3.next()){
	  codes.add(rs3.getString("SUB_GLACNO"));
 }
 
 Connection conLocal = ConnectionUrl.getLocalDatabase();
 
 PreparedStatement ps_local = null,ps_localmax = null,ps_localPrev = null; 
 ResultSet rs_localmax=null,rs_localPrev=null;
 int ct=0;
 for(int i=0;i<codes.size();i++){
	 if(i==0){
 ps_local = conLocal.prepareStatement("insert into purchase_overdues_tbl(value,enable)values(?,?)");
 ps_local.setString(1, codes.get(i).toString());
 ps_local.setInt(2, 1);
 ps_local.executeUpdate();
	  }else{
		  ps_localmax = conLocal.prepareStatement("select max(overdue_id) from purchase_overdues_tbl");
		  rs_localmax = ps_localmax.executeQuery();
		  while (rs_localmax.next()) {
			 ct = rs_localmax.getInt("max(overdue_id)");
		}
		  ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
		  rs_localPrev=ps_localPrev.executeQuery();
		  while (rs_localPrev.next()) { 	  
		  ps_local = conLocal.prepareStatement("update purchase_overdues_tbl set value=? where overdue_id="+ct);
		  ps_local.setString(1, rs_localPrev.getString("value") + codes.get(i).toString()); 
		  ps_local.executeUpdate(); 
		  }
	  }
 }
 
 String sqlquery = "{call Sel_SubContractStockLedgerMutha(?,?,?,?,?,?)}";
CallableStatement cs = con.prepareCall(sqlquery,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
cs.setString(1, comp);
cs.setString(2, "0");

if(sup.equalsIgnoreCase("All_Suppliers")){
ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
rs_localPrev=ps_localPrev.executeQuery();
while (rs_localPrev.next()) {
cs.setString (3,rs_localPrev.getString("value"));
}
}else{
	cs.setString (3, sup);
}

cs.setString(4, sqlfromDate);
cs.setString(5, sqltoDate);
cs.setString(6, "101");

 
ResultSet rs = cs.executeQuery();
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %> </strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Sub Contract Stock Ledger from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %></strong>
	<br /> 
<%
if(comp.equalsIgnoreCase("101") || comp.equalsIgnoreCase("102")){
%>
	<strong style="font-family: Arial; font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;
<%
}else{
%>
<strong style="font-family: Arial; font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;
<%
}
%>
	<%-- 
	<span id="exportId">  
		<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer; font-family: Arial; font-size: 13px;height: 25px;font-weight: bold;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
	</span>  
	--%>       
	   <div style="width: 100%"> 
		<table id="tftable" class="tftable" border="1" style="width: 100%">
		               
			<tr style="font-size: 12px; font-family: Arial;">
			<th scope="col" class="th">Desp. No.</th> 
			<th scope="col" class="th">Supplier Name</th>
			<th scope="col" class="th">Item Name</th>
			<th scope="col" class="th">Date</th>
			<th scope="col" class="th">Desp. Qty.</th> 
			<th scope="col" class="th">Rec. No.</th>
			<th scope="col" class="th">Chln No.</th>
			<th scope="col" class="th">Date</th> 
			<th scope="col" class="th">OK</th> 
			<th scope="col" class="th">MR</th>  
			<th scope="col" class="th">CR</th>
			<th scope="col" class="th">CAST</th> 
			<th scope="col" class="th">SCRAP</th> 
			<th scope="col" class="th">Total Rec.</th>
			<th scope="col" class="th">Chln. Balance</th>
			<th scope="col" class="th">Balance</th>
			<th scope="col" class="th">Process Type</th>			 
			</tr>
			<%
			double tot_rec = 0,chl_bal=0,tr_chl_bal=0,tr_desp_Qty=0;
			String trno = "";
			boolean flagchk = false;
			
			while(rs.next()){ 
				// System.out.println("This data = " + trno + " = = " + tr_chl_bal); 
				if(!trno.equalsIgnoreCase("") && trno.equalsIgnoreCase(rs.getString("TRNNO"))){
					tr_desp_Qty = tr_chl_bal;
					flagchk =true;
				// System.out.println("This data = " + trno + " = = " + tr_chl_bal + "  =  true = " + flagchk);
				}else{
					tr_desp_Qty = Double.parseDouble(rs.getString("DESP_QTY"));
				}
			%>
			<tr>
				<td align="right"><%=rs.getString("TRNNO") %></td>
				<td><%=rs.getString("AC_NAME") %></td>
				<td><%=rs.getString("NAME") %></td>
				<td><%=rs.getString("PRN_TRANDATE") %></td>
				<%-- <td align="right"><%=rs.getString("DESP_QTY") %></td> --%>
				<%
				if(flagchk==true){
				%>
				<td align="right">&nbsp;</td>
				<%
				}else{
				%>
				<td align="right"><%=tr_desp_Qty %></td>
				<%
				}
				%>
				<td align="right"><%=rs.getString("RCPT_TRNNO") %></td>
				<td align="right"><%=rs.getString("RCPT_CHLNNO") %></td>
				<td><%=rs.getString("RCPT_TRAN_DATE") %></td>
				<td align="right"><%=rs.getString("RCPT_DC_QTY") %></td>
				<td align="right"><%=rs.getString("RCPT_SCRAP_QTY") %></td>
				<td align="right"><%=rs.getString("RCPT_CR_QTY") %></td>
				<td align="right"><%=rs.getString("RCPT_CAST_QTY") %></td>
				<td align="right"><%=rs.getString("RCPT_SCRAP_QTY") %></td>
				<%
				tot_rec = Double.parseDouble(rs.getString("RCPT_DC_QTY")) +
						Double.parseDouble(rs.getString("RCPT_SCRAP_QTY")) +
						Double.parseDouble(rs.getString("RCPT_CR_QTY"))+
						Double.parseDouble(rs.getString("RCPT_CAST_QTY"))+
						Double.parseDouble(rs.getString("RCPT_SCRAP_QTY"));
				chl_bal = tr_desp_Qty - tot_rec;
				%>
				<td align="right"><%=tot_rec %></td>
				<td align="right"><%=chl_bal %></td>				
				<td align="right"><%=chl_bal %></td>
				<%-- <td align="right"><%=chl_bal %></td> --%> 
				<td><%=rs.getString("PROCESS_TYPE") %></td> 
			</tr>
			<%
			trno = rs.getString("TRNNO");
			tr_chl_bal = chl_bal;
			tot_rec = 0;
			chl_bal =0; 
			flagchk=false;
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