<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Select Parts</title>
</head>
<body>
<span id="getItems"> 
<%
try{
String report = request.getParameter("q");
String comp = request.getParameter("s");
Connection con = null;
if(report.equalsIgnoreCase("3")){
%>
<b><b style="color: red;"></b>Part Name : </b>
<select name="custsub" id="custsub" style="height: 25px;background-color: #EBECED;" onchange="getAllcustsub(this.value)">
<option value=""> - - - - - Select - - - - - </option>
<%
con = Connection_Util.getLocalDatabase();

if(comp.equalsIgnoreCase("101")){	
	con = Connection_Util.getMEPLH21ERP();
}
if(comp.equalsIgnoreCase("102")){	
	con = Connection_Util.getMEPLH25ERP();
}		 
if(comp.equalsIgnoreCase("103")){
	con = Connection_Util.getFoundryERPNEWConnection();
}
if(comp.equalsIgnoreCase("105")){	
	con = Connection_Util.getDIERPConnection();
}
if(comp.equalsIgnoreCase("106")){	
	con = Connection_Util.getK1ERPConnection();
}

SimpleDateFormat sdfFIrst = new SimpleDateFormat("yyyyMMdd");
Calendar cal1 = Calendar.getInstance();
Date lastDate = cal1.getTime();
String toDate = sdfFIrst.format(lastDate);
String fromDate = toDate.substring(0, 6)+"01";

ArrayList matname = new ArrayList();

//  exec "FOUNDRYERPNEW"."dbo"."Sel_DayWiseSubContractStockLedgerFinal";1 '103', '0', '20160201', '20160309'
CallableStatement cs_op = con.prepareCall("{call Sel_DayWiseSubContractStockLedgerFinal(?,?,?,?)}");
cs_op.setString(1, comp);
cs_op.setString(2, "0");
cs_op.setString(3, fromDate);
cs_op.setString(4, toDate);

ResultSet rs_op = cs_op.executeQuery();
while(rs_op.next()){

if(rs_op.getString("MATERIAL_TYPE").equalsIgnoreCase("101")){
matname.add(rs_op.getString("MAT_NAME"));
}
}

HashSet hs = new HashSet();
hs.addAll(matname);
matname.clear();
matname.addAll(hs); 

Collections.sort(matname);

for(int i=0;i<matname.size();i++){
%>
<option value="<%=matname.get(i).toString()%>"><%=matname.get(i).toString()%></option>
<%
}
%>
</select> 
<span id="waitImagep_order" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span>
<input type="hidden" name="fromDatehid" id="fromDatehid" value="<%=fromDate%>">
<input type="hidden" name="toDatehid" id="toDatehid" value="<%=toDate%>">
<input type="hidden" name="reporthid" id="reporthid" value="<%=report%>">
<br> 
<a onclick="getReset('<%=report %>','<%=comp %>')" style="cursor: pointer;"><b>Click to Reset All Data</b></a>
<span id="reset_data"></span>
<%
}else{
%>
<span id="getItems"> 
	<b style="color: blue;">Search : </b> 
	<input type="text" name="search" id="search" size="70" onkeyup="getSearchedPart(this.value)" style="color: blue;font-family: Arial;font-size: 14px;"/>
	<span id="waitImagep_order" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span>
</span>
<%
}
%>
</span>
<%
con.close();
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>