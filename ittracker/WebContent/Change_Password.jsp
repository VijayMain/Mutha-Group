<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Password</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
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
	padding: 5px; 
}
</style>

<script language="javascript" type="text/javascript">
	function showState(str) {
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
				var a = null;
				document.getElementById("req_type").innerHTML = xmlhttp.responseText;
				//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

			}
		};
		xmlhttp.open("POST", "Req_Type.jsp?q=" + str, true);
		xmlhttp.send();
	};
</script>

<script type="text/javascript">
<!--
	// Form validation code will come here.
	function validate() {

		if (document.myForm.rel_to.value == 0) {
			alert("Please select Problem Related To ..!");
			document.myForm.rel_to.focus();
			return false;
		}

		if (document.myForm.change_selected.value == "") {
			alert("Please provide Change Type!");
			document.myForm.change_selected.focus();
			return false;
		}

		if (document.myForm.Present.value == "") {
			alert("Please provide Present System!");
			document.myForm.Present.focus();
			return false;
		}

		if (document.myForm.quality.checked == false
				&& document.myForm.cost.checked == false
				&& document.myForm.delivery.checked == false
				&& document.myForm.material.checked == false
				&& document.myForm.safety.checked == false
				&& document.myForm.Dimensional.checked == false) {
			alert("Please provide Category Of Change");
			document.myForm.quality.focus();
			return false;
		}

		return (true);
	}
//-->
</script>

<%
	try {

		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		int d_Id=0;
 	
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con
				.prepareStatement("select * from User_tbl where U_Id="+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			d_Id = rs_uname.getInt("Dept_Id");
			uname = rs_uname.getString("U_Name");
		}
%>
</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Change Password</h3>
		</div>
		<div id="menu">
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="New_Requisition.jsp">Add New</a></li>
				<li><a href="Requisition_Status.jsp">Status</a></li>
				<li><a href="Closed_Req_User.jsp">Closed</a></li>
				<li><a href="All_Requisitions.jsp">All</a></li>
				<li><a href="Search_Requisitions.jsp">Search</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
						<%--
						if(d_Id==26 || d_Id==21 || d_Id==11){
						%>
						<li><a href="Admin.jsp">Admin</a></li>
						<%
						}
						--%>
				<li><a href="Reports_User.jsp">Reports</a></li>
				<li><a href="Change_Password.jsp">Change Password</a></li>
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: small;"> <%=uname%></strong></li>
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
			<form action="Change_Password_controller" method="post">
				<table align="center"  border="0" class="tftable">
					<tr>
						<td align="right"><b>Current Password :</b></td>
						<td align="left"><input type="password" name="c_pwd" size="35" style="height: 20px; font-size: 14px;"/>
						</td>
					</tr>
					<tr>
						<td align="right"><b>New Password :</b></td>
						<td align="left"><input type="password" name="new_pwd" size="35" style="height: 20px; font-size: 14px;"/>
						</td>
					</tr>
					<tr>
						<td align="right"><b>Re-Enter New Password :</b></td>
						<td align="left"><input type="password" name="new_r_pwd" size="35" style="height: 20px; font-size: 14px;"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit" value="Save" style="width: 150px; height: 30px;"></td>
					</tr>

				</table>

			</form>
			<div id="footer">
			<p class="style2">
				<a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New
					Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a>
				<a href="All_Requisitions.jsp">All Requisitions</a> <a
					href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a>
				<br /> <a href="http://www.muthagroup.com">Mutha Group, Satara
				</a>
			</p>
		</div>
		</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		
	</div>
</body>
</html>