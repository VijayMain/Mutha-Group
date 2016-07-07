<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
String partname = request.getParameter("q");
String comp = request.getParameter("comp");
String from = request.getParameter("from");
String to = request.getParameter("to");
String report = request.getParameter("report");
Connection con = null;
%>
<span id="getParts">

<%
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

ArrayList custname = new ArrayList();

//exec "FOUNDRYERPNEW"."dbo"."Sel_DayWiseSubContractStockLedgerFinal";1 '103', '0', '20160201', '20160309'
CallableStatement cs_op = con.prepareCall("{call Sel_DayWiseSubContractStockLedgerFinal(?,?,?,?)}");
cs_op.setString(1, comp);
cs_op.setString(2, "0");
cs_op.setString(3, from);
cs_op.setString(4, to);

ResultSet rs_op = cs_op.executeQuery(); 
while(rs_op.next()){ 
if(rs_op.getString("MATERIAL_TYPE").equalsIgnoreCase("101") && rs_op.getString("MAT_NAME").equalsIgnoreCase(partname)){ 
custname.add(rs_op.getString("AC_NAME"));
}
}
 
HashSet hs = new HashSet();
hs.addAll(custname);
custname.clear();
custname.addAll(hs);
%>  
<select name="sbOne" id="sbOne" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 12px;">
<%
Collections.sort(custname);
for(int i=0;i<custname.size();i++){
%>
<option value="<%=custname.get(i).toString()%>"><%=custname.get(i).toString()%></option>
<%
}
%>
</select>
<input type="hidden" name="datefrom" id="datefrom" value="<%=from%>">
<input type="hidden" name="tofrom" id="tofrom" value="<%=to%>">
</span>
<%
con.close();
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>