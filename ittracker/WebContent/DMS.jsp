<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DMS</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<script type="text/javascript" src="js/tabledeleterow.js"></script>
<script type="text/javascript">
	function validateForm() {
	var srno = document.getElementById("srno"); 
		/* if (req_details.value=="0" || req_details.value==null || req_details.value=="" || req_details.value=="null") {
			alert("Please Provide Requisition Details !!!");
			document.getElementById("Save").disabled = false;
			return false;
		} */
	alert("Sr No = " + srno.value);	
		return true;
	}
</script>
<style>
button.accordion {
    background-color: #006999;
    color: white;
    cursor: pointer;
    padding: 5px; 
    width: 100%;
    border: thin; 
    outline: black;
    font-size: 12.5px;
    transition: 0.4s;
}

button.accordion.active, button.accordion:hover {
    background-color: #ddd;
    color: black;
}

div.panel {
font-size: 12.5px;
    padding: 0 1px;
    background-color: white;
    color : #050aad;
    max-height: 0;
    overflow: hidden;
    transition: 0.6s ease-in-out;
    opacity: 0;
}

div.panel.show {
    opacity: 1;
    max-height: 500px;  
}
</style>
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 11px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 4px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 12px; 
	padding: 1px; 
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
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Add_NewDoc.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	
	function GetMyDocs(str) {
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
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "GetMyDocs.jsp?q=" + str, true);
		xmlhttp.send();
	};
	function GetSharedDocs(str) {
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
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Shared_doc.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
</script>
<%
	try {
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		int d_Id=0;
 		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
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
			<h3>Document Management System (DMS)</h3>
		</div>
		<div id="menu">
			<%
			if(d_Id!=18){
			%>
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="New_Requisition.jsp">Add New</a></li>
				<li><a href="Requisition_Status.jsp">Status</a></li>
				<li><a href="Closed_Req_User.jsp">Closed</a></li>
				<li><a href="All_Requisitions.jsp">All</a></li>
				<li><a href="Search_Requisitions.jsp">Search</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Reports_User.jsp">Reports</a></li>
				<li><a href="Change_Password.jsp">Change Password</a></li>
				<li><a href="Profile.jsp">My Profile</a></li> 
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: small;"> <%=uname%></strong></li>
			</ul>
			<%
			}else{
			%>
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li> 
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
			<%
			}
			%>
</div>
<div style="height: 530px;width:99%; overflow: scroll;"> 
		 
<div style="float:left;width:20.8%;text-align: left; height: 470px;background-color: #006999;overflow: scroll;">
         	 
<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">Add New Document</button> 
<div class="panel">
  <p style="padding-left: 15px;">
 	<a onclick="showState(this.value)" style="cursor: pointer;"><b>Add New Document</b></a>
  </p>
</div>
<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">My Documents</button>
<div class="panel">
 <p style="padding-left: 15px;">
 	<a onclick="GetMyDocs(this.value)" style="cursor: pointer;"><b>My Folder Name</b></a>
  </p>
</div>

<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">Shared Documents</button>
<div class="panel">
 <p style="padding-left: 15px;">
 	<a onclick="GetSharedDocs(this.value)" style="cursor: pointer;"><b>My Shared Folder</b></a>
  </p>
</div>

<script>
var acc = document.getElementsByClassName("accordion");
var i;
for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        this.nextElementSibling.classList.toggle("show");      
  }  
}
</script>
</div>
<div style="float:right; width:79%">
	<span id="new_dms">
    	<img alt="No Image" src="images/dms.jpg" style="width: 100%;height: 470px;">
    </span>
</div>
</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		<div id="footer">
			<p class="style2">
				<a href="index.jsp">Home</a><a href="New_Requisition.jsp">New Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a>
				<a href="All_Requisitions.jsp">All Requisitions</a> <a href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a>
		 <br /> <a href="http://www.muthagroup.com">Mutha Group, Satara
				</a>
			</p>
		</div> 
</div>
</body>
</html>