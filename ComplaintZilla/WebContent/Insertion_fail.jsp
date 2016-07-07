<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>SimpleAdmin - Dashboard</title>

<!-- Stylesheets -->
<link rel="stylesheet" href="css/style.css">

<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery & JS files -->
<link rel="stylesheet" type="text/css" href="view.css" media="all">
<script type="text/javascript" src="view.js"></script>
<script type="text/javascript" src="js/calendar.js"></script>
<link rel="stylesheet" href="css/style.css">
<script src="js/script.js"></script>

<!-- 

TO LOCK PAGE BACK EVENT
 -->
<script type="text/javascript">
	function noBack() {
		window.history.forward()
	}
	noBack();
	window.onload = noBack;
	window.onpageshow = function(evt) {
		if (evt.persisted)
			noBack();
	};
	window.onunload = function() {
		void (0);
	};


</script>

</head>
<body>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">
				<!-- 				<li class="v-sep"><a href="#"
					class="round button dark ic-left-arrow image-left">Go to
						website</a></li> -->
				<li class="v-sep"><a href="Admin_Index.jsp"
					class="round button dark menu-user image-left">Logged in as <strong>Admin</strong></a>
				</li>

				<!--  	<li><a href="#"
					class="round button dark menu-email-special image-left">
						new Complaints</a></li> -->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>

			</ul>
			<!-- end nav -->


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
				<li><a href="Admin_Index.jsp" class="active-tab dashboard-tab">Admin
						Home</a></li>
			</ul>
			<!-- end tabs -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 30px height. -->
			<a href="Admin_Index.jsp" id="company-branding-small" class="fr"><img
				src="images/company-logo.png" alt="Blue Hosting" /></a>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end header -->



	<!-- MAIN CONTENT -->
	<div id="content">

		<div class="page-full-width cf">

			<div class="side-menu fl">

				<h3>Contents</h3>
				<ul>
					<li><a href="Admin_Index.jsp">Add Users</a></li>
					<li><a href="Add_Company.jsp">Add Company</a></li>
					<li><a href="Add_Customer.jsp">Add Customer</a></li>
					<li><a href="Add_Item.jsp">Add Item</a></li>
					<!-- <li><a href="Add_Subject.jsp">Add Subject / Issue</a></li> -->
					<li><a href="Add_Defect.jsp">Add Defect</a></li>
					<li><a href="Add_Category.jsp">Add Category</a></li>
					<li><a href="Add_Action.jsp">Add Action</a></li>
					<li><a href="Add_AutoMailing_List.jsp">Add Auto Mailing
							List</a></li>

				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">Operation Status</h3>

					</div>
					<!-- end content-module-heading -->


					<div class="content-module-main" id="form_container">









						<div id="form_container">

							<br> <strong style="color: red;">Data Insertion
								Failed !!!!!!!</strong>


						</div>










					</div>
					<!-- end content-module -->

				</div>
				<!-- end half-size-column -->

			</div>
			<!-- end content-module-main -->

		</div>
		<!-- end content-module -->



	</div>
	<!-- end side-content -->



	<!-- FOOTER -->
	<div id="footer">

		<p>
			&copy; Copyright 2013 <a href="http://www.muthagroup.com">Mutha
				Group, Satara</a>. All rights reserved.
		</p>

	</div>
	<!-- end footer -->


</body>
</html>