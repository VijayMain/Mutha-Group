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
<title>Party Wise Work Order</title>
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
String sup =request.getParameter("sup");

String from =request.getParameter("date_frombt");
String to =request.getParameter("date_tobt");
String passSuppliers = sup;
 

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
String supName="";
 if(sup.equalsIgnoreCase("All_Supplier")){
	 allFlag = true; 
	 sup = "101110054,101110069,101110100,101110205,101110233,101110347,101110475,101120645,101122002,101123158,101124452";
	 supName = "ALL"; 
 }else{
	 PreparedStatement pssup=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLACNO='" + sup + "'");
	 ResultSet rssup=pssup.executeQuery();
	  while(rssup.next()){
	 	 if(rssup.getString("SUB_GLACNO").equalsIgnoreCase(sup)){
	 		 supName = rssup.getString("SUBGL_LONGNAME");
	 	 }
	  }
 }
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %> </strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Branch Transfer for <%=supName %> from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
	</strong>
	<br /> 
<strong style="font-family: Arial; font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	   <div style="width: 100%"> 
		<table id="tftable" class="tftable" border="1" style="width: 100%">  
			<tr style="font-size: 12px; font-family: Arial;">
			<th scope="col" class="th">TRAN NO</th> 
			<th scope="col" class="th">TRAN DATE</th>
			<th scope="col" class="th">SUPPLIER</th> 
			<th scope="col" class="th">MATERIAL NAME</th>
			<th scope="col" class="th">CHALLAN QTY</th>  
			<th scope="col" class="th">CASTING WT</th>
			<th scope="col" class="th">TONNAGE</th>
			<th scope="col" class="th">RATE</th>  
			<th scope="col" class="th">AMOUNT</th>
			</tr>
			<%
			String trn_date = "";
			PreparedStatement ps_bt = con.prepareStatement("SELECT RIGHT(TRNSTORMATI.TRAN_NO,6) AS TranNO, "+
					" TRNSTORMATI.TRAN_DATE, TRNSTORMATI.TRAN_SUBTYPE, TRNSTORMATI.MAT_CODE,  "+
					" TRNSTORMATI.CHLN_QTY, TRNSTORMATI.SUB_GLACNO,  "+
					" MSTMATERIALS.CASTING_WT, (CAST(MSTMATERIALS.CASTING_WT as FLOAT) * CAST(TRNSTORMATI.CHLN_QTY AS FLOAT)) as TONNAGE "+ 
					" ,(CAST(TRNSTORMATI.RATE as FLOAT) * CAST(TRNSTORMATI.CHLN_QTY AS FLOAT)) as AMOUNT  "+
				    " ,TRNSTORMATI.RATE,TRNSTORMATI.SUB_GLACNO,  "+
				    " MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+ 
					" MSTMATERIALS.CASTING_WT,MSTMATERIALS.FINISH_WT,  "+
					" MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE,MSTMATERIALS.NAME FROM TRNSTORMATI "+ 
					" LEFT JOIN MSTACCTGLSUB ON TRNSTORMATI.SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO  "+
					" LEFT JOIN MSTMATERIALS ON TRNSTORMATI.MAT_CODE = MSTMATERIALS.CODE  "+
					" WHERE TRNSTORMATI.SUB_GLACNO in(" + sup + ")   "+
					" AND TRNSTORMATI.TRAN_DATE BETWEEN '"+sqlfromDate+"' AND '" + sqltoDate +
					"' and TRNSTORMATI.STATUS_CODE =0  "+
					" AND MSTMATERIALS.MATERIAL_TYPE =101 "+ 
					 " AND TRNSTORMATI.TRAN_SUBTYPE IN (66) order by TRNSTORMATI.SUB_GLACNO,TRAN_NO");
			ResultSet rs_bt = ps_bt.executeQuery();
			while(rs_bt.next()){ 					// 20170709  12345678
				trn_date = rs_bt.getString("TRAN_DATE").substring(6,8)   +"/"+ rs_bt.getString("TRAN_DATE").substring(4,6)  +"/"+ rs_bt.getString("TRAN_DATE").substring(0,4); 
			%>
			<tr>
			<td align="right"><%=rs_bt.getString("TranNO") %></td>
			<td><%=trn_date %></td>
			<td><%=rs_bt.getString("SUBGL_LONGNAME") %></td>
			<td><%=rs_bt.getString("NAME") %></td> 
			<td align="right"><%=noDForm.format(Double.valueOf(rs_bt.getString("CHLN_QTY"))) %></td>
			<td align="right"><%=threeDForm.format(Double.valueOf(rs_bt.getString("CASTING_WT"))) %></td>
			<td align="right"><%=twoDForm.format(Double.valueOf(rs_bt.getString("TONNAGE"))) %></td>
			<td align="right"><%=rs_bt.getString("RATE") %></td>
			<td align="right"><%=twoDForm.format(Double.valueOf(rs_bt.getString("AMOUNT"))) %></td>
			</tr>
			<%
			trn_date="";
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