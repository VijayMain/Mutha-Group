<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.controller.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Count</title>
</head>
<body>
			<%
			Connection con = Connection_Utility.getConnection();
			SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			HashMap<String, Integer> hm = new HashMap<String, Integer>();
			Calendar cal = new GregorianCalendar();
			cal.add(Calendar.DAY_OF_MONTH, -14);
			Date sevenDaysAgo = cal.getTime();
			String dateback = format2.format(cal.getTime());
			System.out.println("Data from " + dateback);
			
			int count=0;
			PreparedStatement ps_plant = con.prepareStatement("select count(*) from complaint_tbl where company_id=1 and Status_Id<5 and Complaint_Date<'"+dateback+"'");
	 		ResultSet rs_plant = ps_plant.executeQuery();
	 		while (rs_plant.next()) {
	 			count = rs_plant.getInt("count(*)");
			}
			%>
	<p style='font-family: Arial; font-size: 12px;'>Dear HR Team,</p>
	<p style='font-family: Arial; font-size: 12px;'>This is to inform you that <b style='font-family: Arial; color: red;'><%=count %> customer complaints</b> are not closed beyond 14 days in
		ComplaintZilla(Customer Complaint Tracking Software).</p>
	<p style='font-family: Arial; font-size: 12px; color: red;'>
		<b>As per management decision penalty of Rs. 200 per day will be applicable to the Plant Head.</b>	</p>
<p style='font-family: Arial; font-size: 12px; color: red;'>
		In case of any genuine constraint to close within the specified period,
Extension to be obtained in writing from Management so that the penalty can be waived.
</p> 
<p style='font-family: Arial;font-size: 14px;color: green;'>IF EXTENTION APPROVAL IS GIVEN BY MANAGEMENT THEN PLEASE IGNORE THIS MAIL</p>
	<p style='font-family: Arial; font-size: 12px;'>
		<b>Please Note: </b>
		<p>
In ComplaintZilla Complaints must be resolved by assigned person,
Quality team must verify and close the complaints. 
Plant head need to monitor this flow.
</p>
<p>
To monitor please <a href="http://192.168.0.7/ComplaintZilla/">Click Here</a> to Login into ComplaintZilla</p> 
<p>Use your in-house software login details to login e.g. IT Tracker.</p>
Find Dashboard and check the live customer complaints status. 
	
</body>
</html>