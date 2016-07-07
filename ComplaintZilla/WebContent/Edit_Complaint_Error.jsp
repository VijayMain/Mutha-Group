<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Upadation Error</title>

<!-- Stylesheets -->

<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript" src="js/view.js"></script>
<script type="text/javascript" src="js/calendar.js"></script>

<link rel="stylesheet" href="css/style.css">

<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery & JS files -->

<script src="js/script.js"></script>


</head>

<body>
	<%@ page import="com.muthagroup.bo.GetUserName_BO"%>

	<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>

	<%
		GetUserName_BO ubo = new GetUserName_BO();
		//PreparedStatement ps = null;
		//ResultSet rs = null;
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		//out.println("UID "+ uid);
		String U_Name = ubo.getUserName(uid);
		//out.print("user name  :"+U_Name);
		String complaint_no = null;
		int count = 0;
		count = Integer.parseInt(session.getAttribute("count").toString());
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">

				<li class="v-sep"><a href="#"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a>
				</li>

				<li><a href="Marketing_Home.jsp"
					class="round button dark menu-email-special image-left"><%=count%>
						New Complaints</a></li>
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>

			</ul>
			<!-- end nav -->
			<%
				
			%>

			<form action="#" method="POST" id="search-form" class="fr">
				<fieldset>
					<input type="text" id="search-keyword"
						class="round button dark ic-search image-right"
						placeholder="Search..." /> <input type="hidden" value="SUBMIT" />
				</fieldset>
			</form>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->



	<!-- HEADER -->
	<div id="header-with-tabs">

		<div class="page-full-width cf">

			<ul id="tabs" class="fl">
				<li><a href="Marketing_Home.jsp"
					class="active-tab dashboard-tab">Home</a></li>
				<li><a href="Register_Complaint.jsp" class="active-tab dashboard-tab">Register Complaint</a></li>
				<li><a href="Report_List.jsp" class="active-tab dashboard-tab">Reports</a></li>
				<li><a href="Dashboard_mkt.jsp" class="active-tab dashboard-tab">Dashboard</a></li>
			</ul>
			<!-- end tabs -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 30px height. -->
			<a href="http://localhost:8001/ComplaintZilla/Marketing_Home.jsp"
				id="company-branding-small" class="fr"><img
				src="images/company-logo.png" alt="ComplaintZilla" /></a>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end header -->



	<!-- MAIN CONTENT -->
	<div id="content">

		<div class="page-full-width cf">

			<div class="side-menu fl">

				<h3>Content</h3>
				<ul>
					<li><a href="Register_Complaint.jsp">Register Complaint</a></li>

				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">Search Complaint</h3>


					</div>
					<!-- end content-module-heading -->
					<div class="content-module-main">

						<table>
							<tr>
								<td><p style="color: red; font-size: 50px">Updation
										Error</p></td>
							</tr>
							<tr>
								<td><a href="Marketing_Home.jsp"><b>Go Back
											Home...!!</b></a></td>
							</tr>
						</table>

					</div>
					<!-- end content-module-main -->

				</div>
				<!-- end content-module -->

			</div>
			<!-- end half-size-column -->

		</div>
		<!-- end content-module-main -->

	</div>
	<!-- end content-module -->
	<!-- FOOTER -->
	<div id="footer">

		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries, Satara</a>
		</p>

	</div>
	<!-- end footer -->
</body>
</html>