<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
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
SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
Calendar cal = Calendar.getInstance();
cal.add(Calendar.DATE, -30); 
System.out.println("Date = "+ sdfFIrstDate.format(cal.getTime()));
%>
</body>
</html>