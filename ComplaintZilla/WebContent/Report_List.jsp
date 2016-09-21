<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="com.muthagroup.bo.GetUserName_BO"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#fromDate").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#toDate").datepicker({
			changeMonth : true,
			changeYear : true
		});
	});
</script>
<title>Report</title> 
<link rel="stylesheet" href="css/style.css">
<script src="js/script.js"></script>
</head>
<body> 
	<%
		try {
			int uid=0, count = 0,int_count=0;
			Connection con = Connection_Utility.getConnection();
			GetUserName_BO ubo = new GetUserName_BO();
			uid = Integer.parseInt(session.getAttribute("uid").toString());
			String U_Name = ubo.getUserName(uid);
			int dept_id = ubo.getUserDeptID(uid); 
			count = Integer.parseInt(session.getAttribute("count").toString());
			int_count = Integer.parseInt(session.getAttribute("int_count").toString());
	%>
	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">


				<li class="v-sep"><a href="Marketing_Home.jsp"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a></li>

				<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left" title="New Customer Complaints"><%=count%>
						Customer Complaints</a></li>
						<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left" title="New Internal Complaints"><%=int_count%>
						Internal Complaints</a></li>
						
				<!-- 
				<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left">All
						Complaints</a></li>
					 -->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>

			</ul> 

		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->



	<!-- HEADER -->
	<div id="header-with-tabs">

		<div class="page-full-width cf">

			<ul id="tabs" class="fl">
				<li><a href="Marketing_Home.jsp" class="active-tab dashboard-tab">Home</a></li>
				<%
				if(dept_id==8){
				%>
				<li><a href="Register_Complaint.jsp" class="active-tab dashboard-tab">Register Complaint</a></li>
				<%
				}
				%>
				<!-- <li><a href="Unassigned_Complaints.jsp"
					class="active-tab dashboard-tab">Unassigned Complaints</a></li> -->
				<li><a href="Report_List.jsp" class="active-tab dashboard-tab">Reports</a></li>
				<li><a href="Dashboard_mkt.jsp" class="active-tab dashboard-tab">Dashboard</a></li>
			</ul>
			<!-- end tabs -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 30px height. -->
			<a href="Marketing_Home.jsp" id="company-branding-small" class="fr"><img
				src="images/company-logo.png" alt="ComplaintZilla" /></a>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end header -->



	
	<!-- MAIN CONTENT -->
	<div class="content-module-heading cf">
		<h3 class="fl">Generate Report</h3>
	</div>
	<div style="background-color: white; padding-left: 50px;">
		<form action="Comp_StatusWise_ReportMKT" method="post">
			<table align="center">
				<tr align="left">
					<td colspan="3" style="text-align: left; font-size: 15px;"><b>Company
							Wise Complaints &#8658;</b></td>
				</tr>
				<tr align="left">
					<td style="width: 10%; text-align: left;"><b>Company Name</b></td>
					<td width="1%">:</td>
					<td align="left"><select name="comp" id="comp"
						style="height: 25px; font-size: 14px;">
							<%
								PreparedStatement ps_comp = con
											.prepareStatement("select * from user_tbl_company");
									ResultSet rs_comp = ps_comp.executeQuery();
									while (rs_comp.next()) {
							%>
							<option value="<%=rs_comp.getInt("Company_Id")%>"><%=rs_comp.getString("Company_Name")%></option>
							<%
								}
									ps_comp.close();
									rs_comp.close();
							%>
					</select></td>
				</tr>
				<tr align="left">
					<td style="width: 10%; text-align: left;"><b>Status</b></td>
					<td>:</td>
					<td align="left"><select name="status" id="status"
						style="height: 25px; font-size: 14px;">
							<option value="0">All</option>
							<%
								PreparedStatement ps_status = con
											.prepareStatement("select * from status_tbl");
									ResultSet rs_status = ps_status.executeQuery();
									while (rs_status.next()) {
							%>
							<option value="<%=rs_status.getInt("Status_Id")%>"><%=rs_status.getString("Status")%></option>
							<%
								}
									ps_comp.close();
									rs_comp.close();
							%>
					</select></td>
				</tr>
				<tr align="left">
					<td style="text-align: left;" colspan="3"><b>Date From</b>(Optional)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

						<input name="fromDate" id="fromDate" readonly="readonly"
						style="font-size: 10px;"> &nbsp;&nbsp;&nbsp;<b>To Date</b>(Optional)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

						<input name="toDate" id="toDate" style="font-size: 10px;">
					</td>
				</tr>
				<tr align="left">
					<td colspan="3" style="text-align: left;"><input type="submit"
						value="Create Report" style="width: 200px; height: 25px;">
					</td>
				</tr>
			</table>
		</form>
		<hr>
	</div>


	<!-- FOOTER -->
	<div id="footer">

		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries, Satara</a>
		</p>

	</div>
	<!-- end footer -->

<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>