<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="com.muthagroup.bo.GetUserName_BO"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
			int uid, count = 0,int_count=0;
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
<div style="background-color: white; padding-left: 2px;padding-right: 2px;">
		<form action="Comp_StatusWise_Report" method="post">
<table style="border: 1px;font-family: Arial;"> 
  <tr style="background-color: #D1CED9;font-size: 14px;height: 30px;">
    <td colspan="6"><b style="font-family: Arial;font-size: 12px;">CUSTOMER COMPLAINT SUMMARY</b></td> 
  </tr>
<tr style="font-size: 15px;"> 
    <th width="11%" align="right"><b>STATUS&#8680;<br> COMPANY&#8681;</b></th>
    <th width="21%" align="center"><b>NEW</b></th>
    <th width="20%" align="center"><b>OPEN</b></th>
    <th width="19%" align="center"><b>RESOLVED</b></th>
    <th width="16%" align="center"><b>REOPEN</b></th>
    <th width="13%" align="center"><b>CLOSE</b></th>
  </tr>
  <% 
  ArrayList h21_comp = new ArrayList();
  ArrayList h25_comp = new ArrayList();
  ArrayList mfpl_comp = new ArrayList();
  ArrayList di_comp = new ArrayList();
  ArrayList unit3_comp = new ArrayList();
  
  PreparedStatement ps = null,ps_h25=null,ps_di=null,ps_mfpl=null,ps_unit=null;
  ResultSet rs = null,rs_h25=null,rs_di=null,rs_mfpl=null,rs_unit=null;
  
  for(int i=1;i<=5;i++){
  ps = con.prepareStatement("select count(*) from complaint_tbl where Status_Id="+i+" and Company_Id=1");
  rs =  ps.executeQuery();
  while(rs.next()){
	  h21_comp.add(rs.getString("count(*)"));
  }
  ps_h25 = con.prepareStatement("select count(*) from complaint_tbl where Status_Id="+i+" and Company_Id=2");
  rs_h25 =  ps_h25.executeQuery();
  while(rs_h25.next()){
	  h25_comp.add(rs_h25.getString("count(*)"));
  }
  ps_mfpl = con.prepareStatement("select count(*) from complaint_tbl where Status_Id="+i+" and Company_Id=3");
  rs_mfpl =  ps_mfpl.executeQuery();
  while(rs_mfpl.next()){
	  mfpl_comp.add(rs_mfpl.getString("count(*)"));
  }
  ps_di = con.prepareStatement("select count(*) from complaint_tbl where Status_Id="+i+" and Company_Id=5");
  rs_di =  ps_di.executeQuery();
  while(rs_di.next()){
	  di_comp.add(rs_di.getString("count(*)"));
  }
  ps_unit = con.prepareStatement("select count(*) from complaint_tbl where Status_Id="+i+" and Company_Id=4");
  rs_unit =  ps_unit.executeQuery();
  while(rs_unit.next()){
	  unit3_comp.add(rs_unit.getString("count(*)"));
  }
  }
  %>
  <tr align="center" style="cursor: pointer;">
    <th><b>MEPL H21</b></th>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=1&status=1"><%=h21_comp.get(0) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=1&status=2"><%=h21_comp.get(1) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=1&status=3"><%=h21_comp.get(2) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=1&status=4"><%=h21_comp.get(3) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=1&status=5"><%=h21_comp.get(4) %></a></td>
  </tr>
  <tr align="center" style="cursor: pointer;">
    <th><b>MEPL H25</b></th>
      <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=2&status=1"><%=h25_comp.get(0) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=2&status=2"><%=h25_comp.get(1) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=2&status=3"><%=h25_comp.get(2) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=2&status=4"><%=h25_comp.get(3) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=2&status=5"><%=h25_comp.get(4) %></a></td>
  </tr>
  <tr align="center" style="cursor: pointer;">
    <th><b>MFPL</b></th>
	<td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=3&status=1"><%=mfpl_comp.get(0) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=3&status=2"><%=mfpl_comp.get(1) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=3&status=3"><%=mfpl_comp.get(2) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=3&status=4"><%=mfpl_comp.get(3) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=3&status=5"><%=mfpl_comp.get(4) %></a></td>
  </tr>
  <tr align="center" style="cursor: pointer;">
    <th><b>DI</b></th>
   	<td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=5&status=1"><%=di_comp.get(0) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=5&status=2"><%=di_comp.get(1) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=5&status=3"><%=di_comp.get(2) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=5&status=4"><%=di_comp.get(3) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=5&status=5"><%=di_comp.get(4) %></a></td>
  </tr>
  <tr align="center" style="cursor: pointer;">
    <th><b>MEPL UNIT III</b></th>
  	<td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=4&status=1"><%=unit3_comp.get(0) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=4&status=2"><%=unit3_comp.get(1) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=4&status=3"><%=unit3_comp.get(2) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=4&status=4"><%=unit3_comp.get(3) %></a></td>
    <td style="background-color: #F2F2F2;font-size: 14px;"><a href="Dashboard_mktSummary.jsp?comp=4&status=5"><%=unit3_comp.get(4) %></a></td>
  </tr>
  <tr style="font-size: 14px;"> 
    <td colspan="6"><b style="font-family: Arial;font-size: 11px;color: red;">Note : Click on records to get details &#8657; </b></td> 
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