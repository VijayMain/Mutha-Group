<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Attachment </title>
</head>
<body>
<!--============================================================================-->
<!--======================= Delete Attachment ===========================-->
<!--============================================================================-->
	<%
		try {
			System.out.println("I am in Delete attach");
			String IdStr = request.getParameter("p");
			int id = Integer.parseInt(IdStr);
			
			System.out.println("I am in Delete attach.... "+id);
			
			String complaint_No, date_attached, filename = "";
			int del_stat = 0;
			int uid = 0;
			InputStream file;
			//********************************************************************************
			// Date
			Date d = new Date();

			String date = null, month = null, year = null;
			int date_in = d.getDate();

			if (date_in <= 9) {
				date = "0" + date_in;
			} 
			else 
			{
				date = Integer.toString(date_in);
			}
			if (d.getMonth() <= 9) {
				month = "0" + Integer.toString(d.getMonth() + 1);

			} 
			else
			{
				month = Integer.toString(d.getMonth() + 1);
			}
			year = Integer.toString(d.getYear() + 1900);
			String today = date + "/" + month + "/" + year;
			//********************************************************************************

			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps = con
					.prepareStatement("update cr_tbl_attachment set Del_Status=0 where Cr_Attach_Id="
							+ id);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<!--============================================================================-->
	<!--============================================================================-->
	
</body>
</html>