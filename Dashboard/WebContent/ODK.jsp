<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ODK</title>
</head>
<body>
<%
ArrayList numberlist = new ArrayList();
numberlist.add("1");
numberlist.add("2");
numberlist.add("1");
numberlist.add("1");
double sum = 0;
for(int i=0; i<numberlist.size(); i++){
    sum += Double.parseDouble(numberlist.get(i).toString());
}
System.out.println("Sum = " + sum);
%>
</body>
</html>