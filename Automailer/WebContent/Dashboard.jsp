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
<p style='font-family: Arial;font-size: 12px;'> Dear HR Team, </p>
<p style='font-family: Arial;font-size: 12px;'>
This is to inform you that customer complaints are not Resolved beyond 7 days in ComplaintZilla(Customer Complaint Tracking Software).
</p> <p style='font-family: Arial;font-size: 12px;color: red;'>
<b>As per management decision penalty of Rs. 100 per day will be applicable to the person responsible as listed below.</b> </p>
<p style='font-family: Arial;font-size: 12px;'> <b>Please Note: </b> 
If complaint assigned person is not available then Quality Team must be responsible to take action on complaints. </p>
<p style='font-family: Arial;font-size: 12px;'>
For more details please login to <b>http://192.168.0.7/ComplaintZilla/</b>  and find details in Dashboard. </p>
	
		<%
		Connection con = Connection_Utility.getConnection(); 
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HashMap<String,Integer> hm=new HashMap<String,Integer>();  
		Calendar cal = new GregorianCalendar();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		Date sevenDaysAgo = cal.getTime(); 
		String dateback = format2.format(cal.getTime());
		String name = "";
		ArrayList list_assigned = new ArrayList();
				 
		PreparedStatement ps_aasignCnt = null, ps_resolvedCnt = null,ps_user=null,ps_get=null;
		ResultSet rs_assignedCnt = null, rs_resolvedCnt = null,rs_user=null,rs_get=null;
		   
		// **********************************************************************************************************************************************************
		// **********************************************************************************************************************************************************
		
		ps_aasignCnt  = con.prepareStatement("select distinct(Complaint_Assigned_To) from complaint_tbl where company_id=3 and Status_Id<3 and Complaint_Date<'"+dateback+"'");
		rs_assignedCnt = ps_aasignCnt.executeQuery();
		while(rs_assignedCnt.next()){
			 ps_user = con.prepareStatement("select * from user_tbl where u_id="+rs_assignedCnt.getInt("Complaint_Assigned_To") +" and enable_id=1");
				rs_user = ps_user.executeQuery();
				while(rs_user.next()){
					name = rs_user.getString("U_Name");
					list_assigned.add(name);
					
					ps_get = con.prepareStatement("select count(*) from complaint_tbl where Complaint_Assigned_To="+rs_user.getInt("u_id") +" and Complaint_Date<'"+dateback+"' and status_id<3");
					  rs_get = ps_get.executeQuery();
					  while(rs_get.next()){
						  hm.put(name,rs_get.getInt("count(*)")); 
					  }
					  name = "";
				}
		}
		 
		
		if(list_assigned.size()>0){
		%>
		<table border='1' width='60%' style='font-family: Arial;'>
		<tr style='font-size: 11px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<td colspan='3' height='20'><b style='font-family: Arial; font-size: 11px;'>Updated list of users responsible to Resolve customer complaints (For those complaints which are over due beyond 7 days)</b></td>
		</tr> 		
		<tr align='center' style='font-size: 11px; font-family: Arial; background-color: #acc8cc;'>
			<th style='width: 25px;'>Sr.No</th>
			<th>Penalty applicable to</th>
			<th  style='width: 140px;'>No of Complaints</th> 
		</tr>
		<tr style='font-size: 11px; font-family: Arial; background-color: #D1D1D1;'>
			<th colspan='3' align='left'>Complaints are assigned to and not resolved by ==></th>
		</tr>
		<%
		for(int s=0;s<list_assigned.size();s++){
		%>
		<tr>
			<td align='center'><%=s+1 %></td>
			<td><%=list_assigned.get(s).toString() %></td>
			<td align='center'><%=hm.get(list_assigned.get(s).toString()) %></td>
		</tr>
		<%
		}
		}
		// ********************************************************************************************************************************************************** 
	%>
</table>

	<!-- 
	<tr>
		<td colspan='3' align='center'>All Complaints are successfully closed. Please remove penalty from the users applicable to.  </td>
	</tr> 
	-->
	<%--
	Calendar cal2 = Calendar.getInstance(); 
	SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat sqlDate = new SimpleDateFormat("yyyyMMdd");
	String todays_date = todaysDate.format(cal2.getTime()).toString();
	System.out.println("Date = " + todays_date);
	--%>
	
</body>

</html>