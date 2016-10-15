<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
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

<!-- Tab Logic ====== >>> -->
<link href="jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<script src="jquery-1.7.2.min.js"></script>
<script src="jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" language="javascript">
	$(function() {
		$("#cnt").tabs();
	});
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = 'white';
		}
	}
</script>
   
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 100%;  
}

.tftable th {
	font-size: 11px;
	background-color: #388EAB; 
	padding: 3px; 
	text-align: center;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 10px; 
	padding: 3px; 
}
</style>
<title>Report</title>
<link rel="stylesheet" href="css/style.css">  
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="js/script.js"></script>
<script type="text/javascript">
	function getExcel_Report(comp,from,to,status) {
		document.getElementById("fileloading").style.visibility = "visible";
		document.getElementById("filebutton").disabled = true; 
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("exportId").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Complaint_Report_xls.jsp?comp="+comp+"&status="+status+"&fromDate="+from+"&toDate="+to, true);
		xmlhttp.send();
	};
</script>
</head>
<body>
	<%
	try{
		int uid, count = 0;
		SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");
		Connection con = Connection_Utility.getConnection();
		GetUserName_BO ubo = new GetUserName_BO();
		uid = Integer.parseInt(session.getAttribute("uid").toString());
		String U_Name = ubo.getUserName(uid);
		int dept_id = ubo.getUserDeptID(uid); 
		String dept_name = ""; 
		PreparedStatement ps_dp = con.prepareStatement("select * from user_tbl_dept where dept_id="+dept_id);
		ResultSet rs_dp=ps_dp.executeQuery();
		while(rs_dp.next())
		{
			dept_name=rs_dp.getString("Department"); 
		}
		ps_dp.close();
		rs_dp.close(); 
		count = Integer.parseInt(session.getAttribute("count").toString());
		int int_count = Integer.parseInt(session.getAttribute("int_count").toString());
		int comp = Integer.parseInt(request.getParameter("comp"));
		String status  = request.getParameter("status");
		String fromDate  = request.getParameter("fromDate");
		String toDate  = request.getParameter("toDate");
		
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		PreparedStatement ps_sel = null; 
		ResultSet rs_sel = null; 
		 
	    if(fromDate!="" && toDate !="" && comp==6){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status)+" and Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"'");
	    	rs_sel = ps_sel.executeQuery(); 
	    } 
	    if(fromDate!="" && toDate !="" && comp!=6){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status)+" and Company_Id="+comp+" and Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"'");
	    	rs_sel = ps_sel.executeQuery(); 
	    }
	    if(comp!=6 && (fromDate=="" || toDate =="")){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status)+" and Company_Id="+comp);
	    	rs_sel = ps_sel.executeQuery(); 
	    }
	    if(comp==6 && (fromDate=="" || toDate =="")){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status));
	    	rs_sel = ps_sel.executeQuery();
	    }
	    
	    if(Integer.parseInt(status)==0 && comp==6 && (fromDate=="" || toDate =="")){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl order by Company_Id");
	    	rs_sel = ps_sel.executeQuery();
	    }
	    if(Integer.parseInt(status)==0 && comp!=6 && (fromDate=="" || toDate =="")){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl where Company_Id="+comp);
	    	rs_sel = ps_sel.executeQuery();
	    }
	    if(Integer.parseInt(status)==0 && comp==6 && (fromDate!="" || toDate !="")){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl where Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"' order by Company_Id");
	    	rs_sel = ps_sel.executeQuery();
	    }
	    if(Integer.parseInt(status)==0 && comp!=6 && (fromDate!="" || toDate !="")){
	    	ps_sel = con.prepareStatement("select * from complaint_tbl where Company_Id="+comp+" and Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"'");
	    	rs_sel = ps_sel.executeQuery();
	    }
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
					class="round button dark menu-logoff image-left">Log out  <b>(<%= dept_name%>)</b></a></li>

			</ul> 

		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->
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
				<!-- <li><a href="Unassigned_Complaints.jsp" class="active-tab dashboard-tab">Unassigned Complaints</a></li> -->
				<li><a href="Report_List.jsp" class="active-tab dashboard-tab">Reports</a></li>
				<li> <a href="Edit_By_Search.jsp" class="active-tab dashboard-tab">Search</a></li>
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
	
	
	<div id="content">
		<div class="page-full-width cf">
			<div>
				<div class="content-module"> 
					<!-- end content-module-heading -->
					<div style="height: 500px;overflow: scroll;">
	<span id="exportId">
&nbsp;&nbsp;&nbsp;&nbsp;<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=fromDate%>','<%=toDate%>','<%=status%>')" style="cursor: pointer; font-family: Arial; font-size: 13px;height: 25px;">&nbsp;&nbsp;Click to Generate Excel&nbsp;&nbsp;</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
	</span>
 					<table style="width: 100%;" class="tftable"> 
												<tr>
													<th>Complaint No</th>
													<th style="width: 60px;"><b>Type</b><!-- 
														<select name="type" id="type" style="width: 17px;" onchange="getType(this.value)">
															<option value=""></option>
															<option value="all">All</option>
															<option value="customer">Customer</option>
															<option value="internal">Internal</option>
														</select>(all) -->
													</th>
													<th>Customer Name</th>
													<th>Company</th>
													<th>Status</th>
													<th>Severity</th>
													<th>Item Name</th>
													<th>Defect</th>
													<th>Complaint Received By</th>
													<th>Complaint Related To</th>
													<th>Complaint Registered By</th>
													<th>Complaint Assigned To</th>
													<th>Category</th>
													<th>Complaint Date</th>
												</tr>
							<%
							 while(rs_sel.next()){
							 %>
							 					<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;">
												<td><b><%=rs_sel.getString("Complaint_No")%></b></td>
												<td><b><%=rs_sel.getString("complaint_type")%></b></td>
												<%
													PreparedStatement ps_cust = con.prepareStatement("select Cust_name from Customer_tbl where Cust_Id="+ rs_sel.getInt("Cust_Id"));
															ResultSet rs_cust = ps_cust.executeQuery();
															while (rs_cust.next()) {
												%>
												<td><%=rs_cust.getString("Cust_Name")%></td>

												<%
													}
													ps_cust.close();	
													rs_cust.close();
												%>



												<%
													PreparedStatement ps_comp = con.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
																			+ rs_sel.getInt("Company_Id"));
															ResultSet rs_comp = ps_comp.executeQuery();
															while (rs_comp.next()) {
												%>
												<td><%=rs_comp.getString("Company_Name")%></td>
												<%
													}
															ps_comp.close();		
															rs_comp.close();
												%>




												<%
													PreparedStatement ps_Status = con
																	.prepareStatement("select Status from Status_tbl where Status_Id="
																			+ rs_sel.getInt("Status_id"));
															ResultSet rs_Status = ps_Status.executeQuery();
															while (rs_Status.next()) {
																if (rs_Status.getString("Status").equalsIgnoreCase("New")) {
												%>
												<td style="color: #2230C7;" class="blink"><strong>
														<%=rs_Status.getString("Status")%></strong></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Open")) {
												%>
												<td><%=rs_Status.getString("Status")%></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Resolved")) {
												%>
												<td><%=rs_Status.getString("Status")%></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Reopen")) {
												%>
												<td style="color: #DB2739;" class="blink"><strong>
														<%=rs_Status.getString("Status")%></strong></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Close")) {
												%>
												<td style="color: green;"><strong> <%=rs_Status.getString("Status")%></strong></td>
												<%
													}

															}

															PreparedStatement ps_priority = con
																	.prepareStatement("select P_Type from Severity_tbl where P_Id="
																			+ rs_sel.getInt("P_id"));
															ResultSet rs_priority = ps_priority.executeQuery();
															while (rs_priority.next()) {
																if (rs_priority.getString("P_Type").equalsIgnoreCase(
																		"Major")) {
												%>
												<td style="color: #E81A24;" class="blink"><strong>
														<%=rs_priority.getString("P_Type")%></strong></td>
												<%
													} else {
												%>
												<td><%=rs_priority.getString("P_Type")%></td>
												<%
													}
															}
															PreparedStatement ps_Item = con
																	.prepareStatement("select Item_Name from Customer_tbl_Item where Item_Id="
																			+ rs_sel.getInt("Item_id"));
															ResultSet rs_Item = ps_Item.executeQuery();
															while (rs_Item.next()) {
												%>
												<td><%=rs_Item.getString("Item_Name")%></td>
												<%
													}

															PreparedStatement ps_Defect = con
																	.prepareStatement("select Defect_Type from Defect_tbl where Defect_id="
																			+ rs_sel.getInt("Defect_Id"));
															ResultSet rs_Defect = ps_Defect.executeQuery();
															while (rs_Defect.next()) {
												%>
												<td><strong><%=rs_Defect.getString("Defect_Type")%></strong>
												</td>
												<%
													}
												%>

												<td><%=rs_sel.getString("Complaint_Received_By")%></td>

												<%
													PreparedStatement ps_related = con
																	.prepareStatement("select Department from User_tbl_Dept where Dept_id="
																			+ rs_sel
																					.getInt("Complaint_Related_To"));
															ResultSet rs_related = ps_related.executeQuery();
															while (rs_related.next()) {
												%>
												<td><%=rs_related.getString("Department")%></td>
												<%
													}
															PreparedStatement ps_registerer = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rs_sel.getInt("U_Id"));
															ResultSet rs_registerer = ps_registerer.executeQuery();
															while (rs_registerer.next()) {
												%>

												<td><%=rs_registerer.getString("U_Name")%></td>
												<%
													}

															PreparedStatement ps_assigned = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rs_sel
																					.getInt("Complaint_Assigned_To"));
															ResultSet rs_assigned = ps_assigned.executeQuery();
															while (rs_assigned.next()) {
												%>
												<td><%=rs_assigned.getString("U_Name")%></td>
												<%
													}

															PreparedStatement ps_category = con
																	.prepareStatement("select Category from Category_tbl where category_id="
																			+ rs_sel.getInt("category_id"));
															ResultSet rs_category = ps_category.executeQuery();
															while (rs_category.next()) {
												%>
												<td><%=rs_category.getString("Category")%></td>
												<%
													}
												%>

												<td><%=sdf2.format(rs_sel.getDate("complaint_date"))%></td> 
											</tr>
							 <%   	
							    }
							%>
						</table>
					</div> 
				</div> 
			</div> 
		</div> 
	</div> 
	<div id="footer">
		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries, Satara</a>
		</p> 
	</div> 
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>