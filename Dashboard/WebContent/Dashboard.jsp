<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
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
<%/* 
Calendar cal = Calendar.getInstance();  
cal.set(2010, 4, 14);

Calendar dob = Calendar.getInstance();
dob.setTime(cal.getTime());
Calendar today = Calendar.getInstance();
int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);

System.out.println(" Age = " + age);

java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
String todays_date = df.format(curr_Date);

Date dateUp = df.parse(todays_date);

String up = df2.format(dateUp);

System.out.print("date 1 = " + todays_date + " date 2 = " + up);

String dd = "2015-04-30";

System.out.println("date = " + dd.substring(0, 4) + " = " + dd.substring(5, 7) + " = " + dd.substring(8, 10));

Calendar first_Datecal = Calendar.getInstance();   
first_Datecal.add(Calendar.DATE, -1);  
Date date_last = first_Datecal.getTime();
SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");  

System.out.println("Dtae = = " + sdfFIrstDate.format(date_last));
*/


Date d = new Date();
String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };  
DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
DateFormat dateFormat2 = new SimpleDateFormat("dd/MM/yyyy");
Calendar cal = Calendar.getInstance();
cal.add(Calendar.DATE, -1);
String yes_date = dateFormat.format(cal.getTime()).toString(); 
String ason_date = dateFormat2.format(cal.getTime()).toString(); 			  
	//************************************************************************************************
//		System.out.println("Date before  =  " +yes_date+"\n date before = "+ason_date); 
	if(weekday[d.getDay()].equals("Sunday")){
		cal.add(Calendar.DATE, -1);
		yes_date = dateFormat.format(cal.getTime()).toString(); 
		ason_date = dateFormat2.format(cal.getTime()).toString();
	}
System.out.println("Date after =  " +yes_date+"\n date after = "+ason_date);

%>
<table>
<tr>
<td align="right"></td>
</tr>
</table>
</body>
</html>