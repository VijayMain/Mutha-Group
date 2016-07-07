<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset</title>
</head>
<body>
<span id="reset_data">
<%
try{
	Connection con = Connection_Util.getLocalDatabase();
	String report = request.getParameter("q");
	String comp = request.getParameter("comp");
	PreparedStatement ps = con.prepareStatement("delete from dailyreports_config_tbl where reports_id="+Integer.parseInt(report)+" and company_id="+Integer.parseInt(comp));
	int del = ps.executeUpdate();
if(del>0){
%>
<b style="font-size: 11px;font-family: Arial;color: green;">Done..</b>
<%
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</span>
</body>
</html>