<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Get Available Data</title>
</head>
<%
	try
	{
		Connection con=Connection_Utility.getConnection();
		int company_id=Integer.parseInt(request.getParameter("q"));
		
		Calendar cal = Calendar.getInstance();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		String today = dateFormat.format(cal.getTime());
		cal.add(Calendar.DATE, -1);
		String yestday = dateFormat.format(cal.getTime()); 
%>
<body>
	<span id="sheetdata">
	<table border="1" style="font-size: 15px; color: #333333; width: 80%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
			 
		<tr bgcolor="#B6B0B8">
				<td width="15%" style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong>Sr. No</strong></td>
				<td width="40%" style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong>Attendance Date</strong> </td>
				<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong>Attendance Sheet</strong></td>
		</tr>
		<%
		PreparedStatement ps_avail=con.prepareStatement("select * from hr_attendance_data_tbl where attendance_date='"+today+"' or attendance_date='"+yestday+"' having Delete_Status=1 and company_id="+company_id);
		ResultSet rs_avail =ps_avail.executeQuery();
		
		int cnt =1;
		rs_avail.last();
		int avail = rs_avail.getRow();
		rs_avail.beforeFirst();
		if(avail>0){
		while(rs_avail.next()){
			DateFormat dateavailFm = new SimpleDateFormat("dd-MM-yyyy"); 
			String attDate = dateavailFm.format(rs_avail.getDate("attendance_date").getTime());
		%>
		<tr>
		<td width="10%" style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=cnt %> </td> 
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=attDate %> </td> 
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;">
		<a href="Display_AttendanceSheet.jsp?field=<%=rs_avail.getInt("Attendance_data_id")%>"><strong style="color: green;"><%=rs_avail.getString("File_Name") %></strong></a>
		</td>
		</tr>
		<%
		cnt++;
		}
		}		
		%>
		</table>
	</span>					 
</body>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</html>