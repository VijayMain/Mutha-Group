<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX Selected Approvals</title>
</head>
<body>
<span id="autofind">
<%
try{
	String app_code = request.getParameter("q");
	String app_status = "";
	
	if(app_code.equalsIgnoreCase("1")){
		app_status = "Approved";
	}
	if(app_code.equalsIgnoreCase("3")){
		app_status = "Declined";
	}
	if(app_code.equalsIgnoreCase("0")){
		app_status = "Pending";
	}
	 
	Connection conlocal = ConnectionUrl.getLocalDatabase();
%>
<table class="tftable" style="border: 0px;">  
  <tr>
    <th> <select name="supplier_name" id="supplier_name" onchange="getSupplier(this.value)">
    <option value="<%=app_code%>"><%=app_status%></option>
    <option value="0">Pending</option>
    <option value="1">Approved</option>
    <option value="3">Declined</option> 
    </select>Supplier Names</th>
  </tr>
  <%	   
  PreparedStatement ps = conlocal.prepareStatement("select * from new_item_creation where enable=1 and approval_status='"+app_code+"'");
  ResultSet rs = ps.executeQuery();
  while(rs.next()){
  %>
  <tr>
  <td align="left" style="font-family: Arial;font-size: 10px;"><%=rs.getString("supplier") %></td>
  </tr>
  <%
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