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

<script src="js/script.js"></script>
</head>
<body>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">

				<li class="v-sep"><a href="#"
					class="round button dark ic-left-arrow image-left">Go to
						website</a></li>
				<li class="v-sep"><a href="#"
					class="round button dark menu-user image-left">Logged in as <strong>admin</strong></a>
					<ul>
						<li><a href="#">My Profile</a></li>
						<li><a href="#">User Settings</a></li>
						<li><a href="#">Log out</a></li>
					</ul></li>
				<%
					int a = 0;
				%>
				<li><a href="#"
					class="round button dark menu-email-special image-left"><%=a%>
						new Complaints</a></li>
				<li><a href="#"
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
				<li><a href="dashboard.html" class="active-tab dashboard-tab">Dashboard</a></li>
				<li><a href="page-full-width.html">Full width page</a></li>
				<li><a href="page-other.html">Other page elements</a></li>
			</ul>
			<!-- end tabs -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 30px height. -->
			<a href="#" id="company-branding-small" class="fr"><img
				src="images/company-logo.png" alt="Blue Hosting" /></a>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end header -->



	<!-- MAIN CONTENT -->
	<div id="content">

		<div class="page-full-width cf">

			<div class="side-menu fl">

				<h3>Side Menu</h3>
				<ul>
					<li><a href="#">Register Complaint</a></li>
					<li><a href="#">Edit Complaint</a></li>
					<li><a href="#">Reports</a></li>

				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">Complaint List</h3>
						<span class="fr expand-collapse-text">Click to collapse</span> <span
							class="fr expand-collapse-text initial-expand">Click to
							expand</span>

					</div>
					<!-- end content-module-heading -->


					<div class="content-module-main">

						<table>

							<thead>

								<tr>
									<th><input type="checkbox" id="table-select-all"></th>
									<th>Name</th>
									<th>Username</th>
									<th>Email</th>
									<th>Actions</th>
								</tr>

							</thead>


							<tbody>

								<tr>
									<td><input type="checkbox"></td>
									<td>Adrian Purdila</td>
									<td>adipurdila</td>
									<td><a href="#">adipurdila@gmail.com</a></td>
									<td><a href="#" class="table-actions-button ic-table-edit"></a>
										<a href="#" class="table-actions-button ic-table-delete"></a>
									</td>
								</tr>


							</tbody>

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



	</div>
	<!-- end side-content -->

	</div>
	<!-- end full-width -->

	</div>
	<!-- end content -->



	<!-- FOOTER -->
	<div id="footer">

		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries, Satara</a>
		</p>

	</div>
	<!-- end footer -->


</body>
</html>