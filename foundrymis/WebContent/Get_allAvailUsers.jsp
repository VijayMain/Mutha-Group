<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX AVAIL Suppliers</title>
</head>
<body>
<span id="autofind">
<%
try{
	String supp_name = request.getParameter("q");
	Connection con = ConnectionUrl.getBWAYSERPMASTERConnection(); 
	Connection conlocal = ConnectionUrl.getLocalDatabase();
%>
<table class="tftable" style="border: 0px;"> 
  <%
  if(supp_name!=""){
  %>
  <tr>
    <th>Available Supplier Names</th>
  </tr>
  <%	  
  PreparedStatement ps = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=12 and SUBGL_LONGNAME like '%"+supp_name+"%'");
  ResultSet rs = ps.executeQuery();
  while(rs.next()){
  %>
  <tr>
  <td align="left" style="font-family: Arial;font-size: 10px;"><%=rs.getString("SUBGL_LONGNAME") %></td>
  </tr>
  <%
  }
  ps = conlocal.prepareStatement("select * from new_item_creation where enable=1 and supplier  like  '%"+supp_name+"%'");
  rs = ps.executeQuery();
  while(rs.next()){
  %>
  <tr>
  <td align="left" style="font-family: Arial;font-size: 10px;"><%=rs.getString("supplier") %></td>
  </tr>
  <%
  }
  }else{
  %>
   <tr>
    <th>Available Supplier Names Pending for Approval</th>
  </tr>
  <%  
  PreparedStatement  ps = conlocal.prepareStatement("select * from new_item_creation where enable=1 and supplier  like  '%"+supp_name+"%'");
  ResultSet  rs = ps.executeQuery();
  while(rs.next()){
  %>
  <tr>
  <td align="left" style="font-family: Arial;font-size: 10px;"><%=rs.getString("supplier") %></td>
  </tr>
  <%
  }
  }
  %>
</table>
<% 
}catch(Exception e){
	e.printStackTrace();
}
%>
</span>
</body>
</html>