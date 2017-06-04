<%@page import="java.util.Date"%>
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
<form action="CreateTableExample" method="post">
<input type="submit" value="Generate PDF">
</form>
<% 
Calendar aCalendar = Calendar.getInstance(); 
aCalendar.set(Calendar.DATE,     aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH)); 
Date lastDateOfPreviousMonth = aCalendar.getTime();


aCalendar.add(Calendar.MONTH, -2); 
aCalendar.set(Calendar.DATE, 1); 
Date firstDateOfPreviousMonth = aCalendar.getTime(); 



System.out.println("last date = " + lastDateOfPreviousMonth + "last date = " + firstDateOfPreviousMonth);
%>
</body>
</html>