<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mail Dashboard</title>
</head>
<body>
<%
try{
	Connection con=null;
	String CompanyName="";
	String comp = "101";
	boolean chk_flag=false;
	
	if(comp.equalsIgnoreCase("101")){
		CompanyName = "H-21"; 
		con = null;
		con = ConnectionUrl.getMEPLH21ERP();
	}else{
		CompanyName = "H-25";
		con = null;
		con	= ConnectionUrl.getMEPLH25ERP();
	}
	
	 	String DATE_FORMAT = "yyyyMMdd";
	    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	    Calendar c1 = Calendar.getInstance(); // today
	    
	    String DATE_FORMAT2 = "dd/MM/yyyy";
	    SimpleDateFormat sdf2 = new SimpleDateFormat(DATE_FORMAT2);
	    Calendar c2 = Calendar.getInstance(); // today
	    
		String datesql = sdf.format(c1.getTime());
		String printdate = sdf2.format(c1.getTime());
	    
	ArrayList subgl = new ArrayList();
	    
	CallableStatement cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
	cs.setString(1, comp);
	cs.setString(2, "0");
	cs.setString(3, datesql);
	/* cs.setString(3, "20170122"); */
	cs.setString(4, "101102103");
	ResultSet rs = cs.executeQuery(); 
	while(rs.next()){
		subgl.add(rs.getString("SUB_GLACNO"));
		chk_flag=true;
	}
	Set<String> hs = new HashSet();
	hs.addAll(subgl);
	subgl.clear();
	subgl.addAll(hs);
%>
<!--  exec "ENGERP"."dbo"."Sel_RptStockInoutStatus";1 '101', '0', '20170122', '101102103'  -->
<table border='1' width='60%' style='font-family: Arial;text-align: center;font-family: Arial;font-size: 12px;'>
<tr style='font-size: 12px; background-color: #c8e6f0; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>
<td colspan="3">Stock In/Out Register as on <%=printdate %></td>
</tr>
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>
<td>Part Name</td>
<td>In Qty</td>
<td>Out Qty</td>
</tr>
<%
int flag=0,sno=1;
for(int i=0;i<subgl.size();i++){
	flag=i;
	rs = cs.executeQuery();
	while(rs.next()){
		if(subgl.get(i).toString().equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
if(flag==i){
%>
<tr> 
<td colspan="3" align="left" style="background-color: #fdffaa"><strong><%=sno %> &nbsp; <%=rs.getString("SUBGL_LONGNAME") %></strong></td>
</tr>
<%
sno++;
}
%>
<tr> 
<td align="left"><%=rs.getString("NAME") %></td>
<td align="right"><%=rs.getString("IN_QTY") %></td>
<td align="right"><%=rs.getString("OUT_QTY") %></td> 
</tr>
<%
flag++;
		}
	}
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</table>
</body>
</html>