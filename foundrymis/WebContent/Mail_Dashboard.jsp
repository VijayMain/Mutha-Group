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
	boolean chk_flag=false,chk_grand=false;
	/**************************************************************************************************************/
  		String CompanyName="";
		String comp = "";
		ArrayList subgl = new ArrayList();
	 	String DATE_FORMAT = "yyyyMMdd";
	    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	    Calendar c1 = Calendar.getInstance(); // today
	    
	    String DATE_FORMAT2 = "dd/MM/yyyy";
	    SimpleDateFormat sdf2 = new SimpleDateFormat(DATE_FORMAT2);
	    Calendar c2 = Calendar.getInstance(); // today
	    
		String datesql = sdf.format(c1.getTime());
		String printdate = sdf2.format(c1.getTime());
		System.out.println("Date = " + datesql);
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
subgl.clear();
comp = "101";
CompanyName = "MEPL H-21";
con = ConnectionUrl.getMEPLH21ERP();
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
 
int flag=0,sno=1;
double sum_inqty=0,sum_outqty=0;
for(int i=0;i<subgl.size();i++){
if(i==0){
%>	
<tr> 
 <td colspan="3" align="left" style="background-color: #382891;color: white;"><strong><%=CompanyName %> ===> </strong></td>
</tr>
<%	
} 
	flag=i;
	rs = cs.executeQuery();
	while(rs.next()){
		if(subgl.get(i).toString().equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
if(flag==i){
	chk_grand=true;
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
sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
flag++;
		}
	}
} 
if(chk_grand==true){
%>
<tr style="background-color: #b5fdfd">
<td><strong>Grand Total </strong> </td>
<td align="right"><%= sum_inqty%></td>
<td align="right"><%= sum_outqty %></td>
</tr> 
<%
}
%>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------->


<%  
subgl.clear();
chk_grand=false;
comp = "102";
CompanyName = "MEPL H-25";
con = ConnectionUrl.getMEPLH25ERP();
cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
cs.setString(1, comp);
cs.setString(2, "0");
cs.setString(3, datesql);
/* cs.setString(3, "20170122"); */
cs.setString(4, "101102103");
rs = cs.executeQuery();
while(rs.next()){
subgl.add(rs.getString("SUB_GLACNO"));
chk_flag=true;
} 
hs.clear();
hs.addAll(subgl);
subgl.clear();
subgl.addAll(hs);
 
flag=0;sno=1;
sum_inqty=0;sum_outqty=0;
for(int i=0;i<subgl.size();i++){
if(i==0){
	chk_grand=true;
%>	
<tr> 
 <td colspan="3" align="left" style="background-color: #382891;color: white;"><strong><%=CompanyName %> ===> </strong></td>
</tr>
<%	
} 
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
sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
flag++;
		}
	}
} 
if(chk_grand==true){
%>
<tr style="background-color: #b5fdfd">
<td><strong>Grand Total </strong> </td>
<td align="right"><%= sum_inqty%></td>
<td align="right"><%= sum_outqty %></td>
</tr> 
<%
}
%>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------->



<%  
subgl.clear();
chk_grand=false;
comp = "103";
CompanyName = "MFPL";
con = ConnectionUrl.getFoundryERPNEWConnection();
cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
cs.setString(1, comp);
cs.setString(2, "0");
cs.setString(3, datesql);
/* cs.setString(3, "20170122"); */
cs.setString(4, "101102103");
rs = cs.executeQuery();
while(rs.next()){
subgl.add(rs.getString("SUB_GLACNO"));
chk_flag=true;
} 
hs.clear();
hs.addAll(subgl);
subgl.clear();
subgl.addAll(hs);
 
flag=0;sno=1;
sum_inqty=0;sum_outqty=0;
for(int i=0;i<subgl.size();i++){
if(i==0){
	chk_grand=true;
%>	
<tr> 
 <td colspan="3" align="left" style="background-color: #382891;color: white;"><strong><%=CompanyName %> ===> </strong></td>
</tr>
<%	
} 
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
sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
flag++;
		}
	}
} 
if(chk_grand==true){
%>
<tr style="background-color: #b5fdfd">
<td><strong>Grand Total </strong> </td>
<td align="right"><%= sum_inqty%></td>
<td align="right"><%= sum_outqty %></td>
</tr> 
<%
}
%>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------->




<%  
subgl.clear();
chk_grand=false;
comp = "105";
CompanyName = "DI";
con = ConnectionUrl.getDIERPConnection();
cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
cs.setString(1, comp);
cs.setString(2, "0");
cs.setString(3, datesql);
/* cs.setString(3, "20170122"); */
cs.setString(4, "101102103");
rs = cs.executeQuery();
while(rs.next()){
subgl.add(rs.getString("SUB_GLACNO"));
chk_flag=true;
} 
hs.clear();
hs.addAll(subgl);
subgl.clear();
subgl.addAll(hs);
 
flag=0;sno=1;
sum_inqty=0;sum_outqty=0;
for(int i=0;i<subgl.size();i++){
if(i==0){
	chk_grand=true;
%>	
<tr> 
 <td colspan="3" align="left" style="background-color: #382891;color: white;"><strong><%=CompanyName %> ===> </strong></td>
</tr>
<%	
} 
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
sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
flag++;
		}
	}
} 
if(chk_grand==true){
%>
<tr style="background-color: #b5fdfd">
<td><strong>Grand Total </strong> </td>
<td align="right"><%= sum_inqty%></td>
<td align="right"><%= sum_outqty %></td>
</tr> 
<%
}
%>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------->


<%  
subgl.clear();
chk_grand=false;
comp = "106";
CompanyName = "MEPL UNIT III";
con = ConnectionUrl.getK1ERPConnection();
cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
cs.setString(1, comp);
cs.setString(2, "0");
cs.setString(3, datesql);
/* cs.setString(3, "20170122"); */
cs.setString(4, "101102103");
rs = cs.executeQuery();
while(rs.next()){
subgl.add(rs.getString("SUB_GLACNO"));
chk_flag=true;
} 
hs.clear();
hs.addAll(subgl);
subgl.clear();
subgl.addAll(hs);
 
flag=0;sno=1;
sum_inqty=0;sum_outqty=0;
for(int i=0;i<subgl.size();i++){
if(i==0){
	chk_grand=true;
%>	
<tr> 
 <td colspan="3" align="left" style="background-color: #382891;color: white;"><strong><%=CompanyName %> ===> </strong></td>
</tr>
<%	
} 
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
sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
flag++;
		}
	}
} 
if(chk_grand==true){
%>
<tr style="background-color: #b5fdfd">
<td><strong>Grand Total </strong> </td>
<td align="right"><%= sum_inqty%></td>
<td align="right"><%= sum_outqty %></td>
</tr> 
<%
}
%>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------->



<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</table>
</body>
</html>