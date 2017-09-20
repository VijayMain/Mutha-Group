<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Export to Excel - Demo</title>
</head>
<body>
    <table align="center" border="2">
        <thead>
            <tr bgcolor="lightgreen">
                <th>Sr. No.</th>
                <th>Text Data</th>
                <th>Number Data</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (int i = 0; i < 10; i++) {
            %>
            <tr bgcolor="lightblue">
                <td align="center"><%=i%></td>
                <td align="center">This is text data <%=i%></td>
                <td align="center"><%=i * i%></td>
            </tr>
            <%
                }
            
            SimpleDateFormat formatView = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat formatsql = new SimpleDateFormat("yyyyMMdd");
            Date date = new Date();
            Calendar c = Calendar.getInstance();
            c.setTime(date);
            int i = c.get(Calendar.DAY_OF_WEEK) - c.getFirstDayOfWeek();
            c.add(Calendar.DATE, -i - 7);
            Date start = c.getTime();
            c.add(Calendar.DATE, 12);
            Date end = c.getTime();
            System.out.println(start + " - " + end);
			 
            String from_sqldate = formatsql.format(start);
			String to_sqldate = formatsql.format(end);
			String dateFrom = formatView.format(start);
			String dateTo = formatView.format(end);
			
			System.out.println(start + " - " + end + " - " +  from_sqldate + " - " + to_sqldate + " - " +  dateFrom + " - " + dateTo);
            %>
        </tbody>
    </table>
</body>
</html>