<%@page import="java.util.Calendar"%>
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
    <th>Request Date</th>
    <th>Created By</th>
    <th>Status</th>
  </tr>
  <%
//Get today as a Calendar
Calendar today = Calendar.getInstance();
today.add(Calendar.DATE, 1); 
java.sql.Date today1 = new java.sql.Date(today.getTimeInMillis()); 
//System.out.println("today = " + today1);
//Subtract 1 day
today.add(Calendar.DATE, -3);
//Make an SQL Date out of that
java.sql.Date yesterday = new java.sql.Date(today.getTimeInMillis()); 
//System.out.println("yes = " + yesterday);
  
  String query = "";
  if(app_status.equalsIgnoreCase("Approved")){
	  query = "select DATE_FORMAT(registered_date, \"%d/%m/%Y %l:%i\") as registered_date,code,supplier,registered_by from new_item_creation where enable=1 and approval_status='"+app_code+"' and update_date between  '"+yesterday+"' and '"+today1+"' order by update_date desc";
  }else{
	  query = "select DATE_FORMAT(registered_date, \"%d/%m/%Y %l:%i\") as registered_date,code,supplier,registered_by from new_item_creation where enable=1 and approval_status='"+app_code+"'  order by update_date desc";
  }
  
  PreparedStatement ps = conlocal.prepareStatement(query);
  ResultSet rs = ps.executeQuery();
  while(rs.next()){
  %>
  <tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"  onClick="button1('<%=rs.getInt("code")%>')" style="cursor: pointer;">
  <td align="left" style="font-family: Arial;font-size: 10px;"><%=rs.getString("supplier").toUpperCase() %></td>
  <td><%=rs.getString("registered_date") %></td>
  <td><%=rs.getString("registered_by") %></td>
  <td><%=app_status %></td>
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