<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AJAX</title>
</head>
<body>
 <div id="itemSelected">  
 <%
 try{
	 Connection con = ConnectionUrl.getBWAYSERPMASTERConnection();
	 String code = request.getParameter("q"); 
	 System.out.println("COde in casting= " + code);
	// --------------------------------------------------------------------------- Casting ----------------------------------------------------------------------------- 
		 if(code.equalsIgnoreCase("101")){
 %>
 
  <%
		 } 
 if(code!=""){
	 
 }
 }catch(Exception e){
	 e.printStackTrace();
 }
 %>
 </div>
</body>
</html>