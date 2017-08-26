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
<title>Branch Transfer</title>
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
	function getExcel_Report(sqlfromDate,sqltoDate,passSuppliers,comp,getcategoryDate,ps_matType) {
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
		xmlhttp.open("POST", "Branch_TransferXls.jsp?sqlfromDate=" + sqlfromDate +"&sqltoDate="+sqltoDate+"&passSuppliers="+passSuppliers+"&comp="+comp+"&getcategoryDate="+getcategoryDate+"&ps_matType="+ps_matType, true); 
		xmlhttp.send();
	}
</script>
</head>
<body  style="font-family: Arial;"> 
<%
try{
Connection con =null;
String comp =request.getParameter("company");
String sup =request.getParameter("sup").toString();
int getcategoryDate = Integer.parseInt(request.getParameter("category"));
String ps_matType=request.getParameter("matType");

String rep_cat="";
if(getcategoryDate==1){
	rep_cat = "ISSUES & RECEIPT";
}
if(getcategoryDate==2){
	rep_cat = "ISSUES";
}
if(getcategoryDate==3){
	rep_cat = "RECEIPT";
}
String matType = "";

if(request.getParameter("matType").equalsIgnoreCase("All")){
	Connection conMaster = ConnectionUrl.getBWAYSERPMASTERConnection();
	PreparedStatement ps_mst = conMaster.prepareStatement("select * from CNFMATERIALS");
	ResultSet rs_mst = ps_mst.executeQuery();
	while(rs_mst.next()){
		matType = matType + rs_mst.getString("CODE") + ",";
	}
	matType = matType.substring(0, matType.length() - 1);
}else{
	matType = request.getParameter("matType");
}

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
	 /* sup = "101110054,101110069,101110100,101110233,101120645,101110205,101110475,101122002,101124452,101110347,101123158"; */
	 sup="101110032,101121994,101110060,101110070,101120646,101110054,101110069,101110100,101110233,101120645,101110205,101110475,101122002,101124452,101110347,101123158";
	 supName = "ALL"; 
 }else{
	 if(sup.equalsIgnoreCase("101")){
		 sup="101110054,101110069,101110100,101110233,101120645"; 
		 supName="MUTHA ENGINEERING PVT LTD (D) UNIT I";
	 }
	 if(sup.equalsIgnoreCase("102")){
		 sup="101110205,101110475,101122002,101124452,101121994"; 
		 supName="MUTHA ENGINEERING PVT LTD (D) UNIT II";
	 }
	 if(sup.equalsIgnoreCase("106")){
		 sup="101110347,101123158"; 
		 supName="MUTHA ENGINEERING PVT LTD (D) UNIT III";
	 }
 }
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %> </strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Branch Transfer for <b style="color: blue;"><%=supName %></b> from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %></strong>
	 &nbsp; <b style="color: blue;">( <%=rep_cat %>)</b>
	<br /> 
<strong style="font-family: Arial; font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong> 
	<span id="exportId">  
		<button id="filebutton" onclick="getExcel_Report('<%=sqlfromDate%>','<%=sqltoDate%>','<%=passSuppliers%>','<%=comp%>','<%=getcategoryDate%>','<%=ps_matType%>')" style="cursor: pointer; font-family: Arial; font-size: 13px;height: 25px;font-weight: bold;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
	</span>  		       
	   <div style="width: 100%"> 
		<table id="tftable" class="tftable" border="1" style="width: 100%">  
			<tr style="font-size: 12px; font-family: Arial;">
			<th scope="col" class="th">GRN_NO</th> 
			<th scope="col" class="th">TRAN DATE</th>
			<th scope="col" class="th">SUPPLIER</th> 
			<th scope="col" class="th">MATERIAL NAME</th>
			<th scope="col" class="th">TYPE</th>
			<th scope="col" class="th">REF. NO</th> 
			<th scope="col" class="th">RATE</th> 
			<th scope="col" class="th">CHALLAN QTY</th>  
			<th scope="col" class="th">CASTING WT</th>
			<th scope="col" class="th">TONNAGE</th> 
			<th scope="col" class="th" width="200">NARRATION</th>			 
			</tr>
			<%
			if(getcategoryDate ==1 || getcategoryDate ==2){
			%>
			<tr>
			<td colspan="11" height="25" style="background-color: #64590b;font-size:12px; color: white;"><b>ISSUE ==></b></td>
			</tr>
			<%
			String trn_date = "";
			PreparedStatement ps_bt = con.prepareStatement("select CONVERT(INT, SUBSTRING(CONVERT(VARCHAR,TRNMATPOST.TRAN_NO),13,6)) AS GRN_NO, "+
					" TRNMATPOST.TRAN_NO, "+
					" TRNMATPOST.TRAN_DATE, "+
					" DBO.FORMAT_DATE(TRNMATPOST.TRAN_DATE) AS PRN_TRNDATE, "+
					" TRNMATPOST.SUB_GLACNO1 AS SUB_GLACNO, "+
					" MSTACCTGLSUB.SUBGL_LONGNAME, "+
					" TRNMATPOST.MAT_CODE, "+
					" TRNSTORMATI.RATE, "+
					" TRNMATPOST.MAT_VALUE, "+
					" MSTMATERIALS.NAME, "+
					" MSTMATERIALS.MATERIAL_TYPE, "+
					" CNFMATERIALS.NAME as MAT_TYPE, "+
					" MSTMATERIALS.CASTING_WT, (CAST(MSTMATERIALS.CASTING_WT as FLOAT) * CAST(TRNMATPOST.QTY AS FLOAT)) as TONNAGE, "+
					" TRNMATPOST.QTY, "+
					" TRNMATPOST.SR_NO, "+
					" TRNACCTMATH.SHORT_NARRTN, "+
					" TRNACCTMATH.EXT_REF1 "+
					" from TRNMATPOST "+
					" LEFT JOIN TRNACCTMATH ON  TRNMATPOST.TRAN_NO = TRNACCTMATH.TRAN_NO "+ 
					" LEFT JOIN MSTACCTGLSUB ON  TRNMATPOST.SUB_GLACNO1 = MSTACCTGLSUB.SUB_GLACNO "+ 
					" LEFT JOIN MSTMATERIALS ON  TRNMATPOST.MAT_CODE = MSTMATERIALS.CODE  "+
					" LEFT JOIN CNFMATERIALS ON  CNFMATERIALS.CODE = MSTMATERIALS.MATERIAL_TYPE "+ 
					" LEFT JOIN TRNSTORMATI ON  TRNMATPOST.TRAN_NO = TRNSTORMATI.TRAN_NO AND TRNSTORMATI.MAT_CODE=TRNMATPOST.MAT_CODE "+
					" where TRNMATPOST.TRAN_NO like '%171821333%' "+
					" and TRNMATPOST.STATUS_CODE=0  AND  MSTMATERIALS.MATERIAL_TYPE IN ("+matType+") AND"+
					" TRNMATPOST.TRAN_DATE between '"+sqlfromDate+"' AND '" + sqltoDate +
					"' and MSTACCTGLSUB.SUB_GLACNO in(" + sup + ") " +
					" ORDER BY MSTACCTGLSUB.SUBGL_LONGNAME,MSTMATERIALS.NAME");
			ResultSet rs_bt = ps_bt.executeQuery();
			while(rs_bt.next()){ 					// 20170709  12345678
				/* trn_date = rs_bt.getString("TRAN_DATE").substring(6,8)   +"/"+ rs_bt.getString("TRAN_DATE").substring(4,6)  +"/"+ rs_bt.getString("TRAN_DATE").substring(0,4); */
				trn_date = rs_bt.getString("PRN_TRNDATE");				
			%>
			<tr>
			<td align="right"><%=rs_bt.getString("GRN_NO") %></td>
			<td><%=trn_date %></td>
			<td><%=rs_bt.getString("SUBGL_LONGNAME") %></td>
			<td><%=rs_bt.getString("NAME") %></td> 
			<td><%=rs_bt.getString("MAT_TYPE") %></td>
			<td><%=rs_bt.getString("EXT_REF1") %></td>
			<td align="right"><%=rs_bt.getString("RATE") %></td>			
			<td align="right"><%=noDForm.format((Double.valueOf(rs_bt.getString("QTY")) * -1)) %></td>
			<td align="right"><%=threeDForm.format(Double.valueOf(rs_bt.getString("CASTING_WT"))) %></td>
			<td align="right"><%=twoDForm.format(Double.valueOf(rs_bt.getString("TONNAGE")) * -1) %></td> 
			<td align="left"><%=rs_bt.getString("SHORT_NARRTN") %></td>
			</tr>
			<%
			trn_date="";
			}
			}
			%>  
			<%
			if(getcategoryDate ==1 || getcategoryDate ==3){
			%>
			<tr>
			<td colspan="11" height="25" style="background-color: #64590b;font-size:12px; color: white;"><b>RECEIPT ==></b></td>
			</tr>
			<%	
			String trn_date = "";
			PreparedStatement ps_bt = con.prepareStatement("select CONVERT(INT, SUBSTRING(CONVERT(VARCHAR,TRNMATPOST.TRAN_NO),13,6)) AS GRN_NO, "+
					" TRNMATPOST.TRAN_NO, "+
					" TRNMATPOST.TRAN_DATE, "+
					" DBO.FORMAT_DATE(TRNMATPOST.TRAN_DATE) AS PRN_TRNDATE, "+
					" TRNMATPOST.SUB_GLACNO1 AS SUB_GLACNO, "+
					" MSTACCTGLSUB.SUBGL_LONGNAME, "+
					" TRNMATPOST.MAT_CODE, "+
					" TRNSTORMATI.RATE, "+
					" TRNMATPOST.MAT_VALUE, "+
					" MSTMATERIALS.NAME, "+
					" MSTMATERIALS.MATERIAL_TYPE, "+
					" CNFMATERIALS.NAME as MAT_TYPE, "+
					" MSTMATERIALS.CASTING_WT, (CAST(MSTMATERIALS.CASTING_WT as FLOAT) * CAST(TRNMATPOST.QTY AS FLOAT)) as TONNAGE, "+
					" TRNMATPOST.QTY, "+
					" TRNMATPOST.SR_NO, "+
					" TRNACCTMATH.SHORT_NARRTN, "+
					" TRNACCTMATH.EXT_REF1 "+
					" from TRNMATPOST "+
					" LEFT JOIN TRNACCTMATH ON  TRNMATPOST.TRAN_NO = TRNACCTMATH.TRAN_NO "+ 
					" LEFT JOIN MSTACCTGLSUB ON  TRNMATPOST.SUB_GLACNO1 = MSTACCTGLSUB.SUB_GLACNO "+ 
					" LEFT JOIN MSTMATERIALS ON  TRNMATPOST.MAT_CODE = MSTMATERIALS.CODE  "+
					" LEFT JOIN CNFMATERIALS ON  CNFMATERIALS.CODE = MSTMATERIALS.MATERIAL_TYPE "+ 
					" LEFT JOIN TRNSTORMATI ON  TRNMATPOST.TRAN_NO = TRNSTORMATI.TRAN_NO AND TRNSTORMATI.MAT_CODE=TRNMATPOST.MAT_CODE "+
					" where TRNMATPOST.TRAN_NO like '%171820232%' "+
					" and TRNMATPOST.STATUS_CODE=0  AND  MSTMATERIALS.MATERIAL_TYPE IN ("+matType+") AND"+
					" TRNMATPOST.TRAN_DATE between '"+sqlfromDate+"' AND '" + sqltoDate +
					"' and MSTACCTGLSUB.SUB_GLACNO in(" + sup + ") " +
					"  ORDER BY MSTACCTGLSUB.SUBGL_LONGNAME,MSTMATERIALS.NAME");
			ResultSet rs_bt = ps_bt.executeQuery();
			while(rs_bt.next()){ 					// 20170709  12345678
				/* trn_date = rs_bt.getString("TRAN_DATE").substring(6,8)   +"/"+ rs_bt.getString("TRAN_DATE").substring(4,6)  +"/"+ rs_bt.getString("TRAN_DATE").substring(0,4); */
				trn_date = rs_bt.getString("PRN_TRNDATE");		 
			%>
			<tr>
			<td align="right"><%=rs_bt.getString("GRN_NO") %></td>
			<td><%=trn_date %></td>
			<td><%=rs_bt.getString("SUBGL_LONGNAME") %></td>
			<td><%=rs_bt.getString("NAME") %></td> 
			<td><%=rs_bt.getString("MAT_TYPE") %></td>
			<td><%=rs_bt.getString("EXT_REF1") %></td>
			<td align="right"><%=rs_bt.getString("RATE") %></td>
			<td align="right"><%=noDForm.format(Double.valueOf(rs_bt.getString("QTY"))) %></td>
			<td align="right"><%=threeDForm.format(Double.valueOf(rs_bt.getString("CASTING_WT"))) %></td>
			<td align="right"><%=twoDForm.format(Double.valueOf(rs_bt.getString("TONNAGE"))) %></td> 
			<td align="left"><%=rs_bt.getString("SHORT_NARRTN") %></td>
			</tr>
			<%
			trn_date="";
			}
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