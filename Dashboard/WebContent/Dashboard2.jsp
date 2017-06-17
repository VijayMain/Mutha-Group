<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
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
Date d = new Date();
SimpleDateFormat formatView = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat formatsql = new SimpleDateFormat("yyyyMMdd"); 
Calendar aCalendar = Calendar.getInstance(); 
//set DATE to 1, so first date of previous month
aCalendar.set(Calendar.DATE, 1);
Date firstDateOfPreviousMonth = aCalendar.getTime();
aCalendar.set(Calendar.DATE,aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
// Date lastDateOfPreviousMonth = aCalendar.getTime();
String from_date = formatsql.format(firstDateOfPreviousMonth);
// String to_date = formatsql.format(lastDateOfPreviousMonth);
String dateFrom = formatView.format(firstDateOfPreviousMonth); 
// String dateTo = formatView.format(lastDateOfPreviousMonth);

String to_date = formatsql.format(d);
String dateTo = formatView.format(d); 
System.out.println("From Date : " + from_date + " To Date : " + to_date + " from =" +dateFrom+ " to = " + dateTo);
%>


<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>
<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>
<th scope='col'>ORDER NO</th>
<th scope='col'>PO DATE</th>
<th scope='col'>SUPPLIER</th>
<th scope='col'>MATERIAL</th>
<th scope='col'>EXT REF</th>
<th scope='col'>EXT REF</th>
<th scope='col'>ORDER QTY</th>
<th scope='col'>ORDER AMOUNT</th>
<th scope='col'>ORDER RATE</th>
<th scope='col'>RECV QTY</th>
<th scope='col'>RECV AMT</th>
<th scope='col'>PUR PO NO</th>
<th scope='col'>PENDING QTY</th>
<th scope='col'>PEND QTY</th>
<th scope='col'>VALUE AMT</th>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</table>










</body>
</html>