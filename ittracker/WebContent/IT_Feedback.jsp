<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Closed Requisitions</title>
<link rel="stylesheet" type="text/css" href="styles.css" />

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#FFFFFF';
		}
	}
</script>

<script language="javascript">
	function button1(val) {
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		edit.submit();
	}
</script>
<style>
div.scroll {
	background-color: #F0EBF2;
	width: 760px;
	height: 600px;
	overflow: scroll;
}
</style>
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 12px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 11px; 
	padding: 3px; 
}
</style>
<%
	try {

		int uid = Integer.parseInt(session.getAttribute("uid")
				.toString());
		String uname = null;
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con
				.prepareStatement("select U_Name from User_tbl where U_Id="
						+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}
%>


</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Closed Requisitions</h3>

		</div>
		<div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li>
				<!-- <li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> -->
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="IT_Feedback.jsp">Feedback</a></li> 
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
		</div>
		<%@page import="java.text.SimpleDateFormat"%>
		<%@page import="java.text.DateFormat"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.util.*"%>
		<%@page import="java.sql.PreparedStatement"%>
		<%
			response.setHeader("Cache-Control", "no-cache");
				response.setHeader("Pragma", "no-cache");
				response.setDateHeader("Expires", -1);
		%>
		<div style="height: 500px;width:99%; overflow: scroll;"> 
			<form method="post" name="edit" action="IT_All_Req_Details.jsp" id="edit">
			 	<%
					Connection conn = null;
						conn = Connection_Utility.getConnection();
 
						PreparedStatement ps_reqDetails = null;
						PreparedStatement psRowCnt = null;
 
						String sqlPagination = "SELECT * FROM  it_user_feedback where enable=1 order by feedback_date desc";

						ps_reqDetails = conn.prepareStatement(sqlPagination);
						rs_uname = ps_reqDetails.executeQuery(); 
				%> 
					<table border="0" class="tftable"> 
							<tr>
								<th height='20'>Network</th>
								<th>Device Satisfaction</th>
								<th>In-House Softwares</th>
								<th>ERP</th>
								<th>Overall Satisfied</th>
								<th>Comments</th>  
								<th>Date (yyyy-mm-dd)</th>
								<th>User</th>  
							</tr>
							<%
								while (rs_uname.next()) {
							%>

							<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;">
								<td align='right'><%=rs_uname.getInt("internet_speed") %></td>
								<td align='right'><%=rs_uname.getInt("pc_laptop") %></td>
								<td align='right'><%=rs_uname.getInt("inhouse") %></td>
								<td align='right'><%=rs_uname.getInt("erp") %></td>
								<td align='right'><%=rs_uname.getInt("it_satisfaction") %></td>
								<td><%=rs_uname.getString("comments") %></td> 
								<td><%=rs_uname.getString("feedback_date").substring(0,10) %></td>
								<td><%=rs_uname.getString("user") %></td> 
							</tr>
							<%
								} 
							%> 
					</table> 
 					<%	
						} catch (Exception e)

						{
							e.printStackTrace();
						} 
					%>
				</form>
		</div>
		<div id="footer">
			<p class="style2">
				<a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New
					Requisition</a> <a href="Closed_Requisitions.jsp">Closed
					Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="IT_Reports.jsp">Reports</a>
				<a href="Software_Access.jsp">Software Access</a> <a
					href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara </a>
			</p>
		</div>
	</div>

</body>
</html>