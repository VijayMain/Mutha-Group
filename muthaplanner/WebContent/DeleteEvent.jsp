<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.muthagroup.connection.ConnectionModel"%>
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
	Connection con =ConnectionModel.getConnection();  
	int uid = Integer.parseInt(session.getAttribute("u_id").toString());
	Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	
	PreparedStatement ps = con.prepareStatement("update events_units set enable_id=?,update_date=?,updated_by=? where event_id="+Integer.parseInt(request.getParameter("event_id")));
	ps.setInt(1, 0);
	ps.setTimestamp(2, timestamp);
	ps.setInt(3, uid);
	int up = ps.executeUpdate();
	
	if(up>0){
		response.sendRedirect("mainpage.jsp");
	}else{
		response.sendRedirect("mainpage.jsp");
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>