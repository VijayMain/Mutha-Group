<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Available Items</title>
</head>
<body>
<span id="autofind">
<%
try{
	String item_name = request.getParameter("q");
	Connection con = ConnectionUrl.getBWAYSERPMASTERConnection();
	Connection conlocal = ConnectionUrl.getLocalDatabase();
	 PreparedStatement ps_avail =null;
	 ResultSet rs_avail = null;
%>
<table class="tftable" style="border: 0px;"> 
  <%
  if(item_name!=""){
  %>
  <tr>
    <th>Available Supplier Names</th>
  </tr>  
  <%
  ps_avail = con.prepareStatement("select * from MSTMATERIALS where NAME like '%"+item_name+"%' order by NAME");
  rs_avail = ps_avail.executeQuery();
  while(rs_avail.next()){
  %>
  <tr>
  	<td style="color: red;font-weight: bold;"><%=rs_avail.getString("NAME") %></td>
  </tr>
  <%
  }
  ps_avail = conlocal.prepareStatement("select * from erp_itemmaster where enable=1 and NAME like '%"+item_name+"%'");
  rs_avail = ps_avail.executeQuery();
  while(rs_avail.next()){
  %>
  <tr>
  	<td style="color: red;font-weight: bold;"><%=rs_avail.getString("NAME") %></td> 
  </tr>
  <%
  }
  %>
  <%
  }else{
  %>
   <tr>
    <th>Available Supplier Names Pending for Approval</th>
  </tr> 
  <% 
  ps_avail = conlocal.prepareStatement("select * from erp_itemmaster where enable=1");
  rs_avail = ps_avail.executeQuery();
  while(rs_avail.next()){ 
  %>
  <tr>
  	<td  style="color: red;font-weight: bold;"><%=rs_avail.getString("NAME") %></td> 
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