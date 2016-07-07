<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Edit by Search</title>

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

	<SCRIPT LANGUAGE="JavaScript">
		function button1(val) {
			var val1 = val;

			document.getElementById("hid").value = val1;
			edit.submit();
		}
	</SCRIPT>


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
		try {

			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps = con
					.prepareStatement("select * from complaint_tbl order by complaint_no desc limit 5");
			ResultSet rs = ps.executeQuery();
			PreparedStatement ps6 = con
					.prepareStatement("select count(status_id) from complaint_tbl where status_id=1");
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Status_Id)");
				session.setAttribute("count", count);
			}
			rs.close();
			ps.close();
			rs6.close();
			ps6.close();
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">

				<li class="v-sep"><a href="#"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a>
				</li>

					<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left"><%=count%>
						New Complaints</a></li>
				<!-- 
				<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left">All
						Complaints</a></li>
					 -->	
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
				<li><a href="Register_Complaint.jsp"
					class="active-tab dashboard-tab">Register Complaint</a></li>
				<li><a href="Report_List.jsp" class="active-tab dashboard-tab">Reports</a></li>
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
	<div id="content">

		<div class="page-full-width cf">

			<div class="side-menu fl">

				<h3>Content</h3>
				<ul>
					<li><a href="Register_Complaint.jsp">Register Complaint</a></li>
					<li><a href="Edit_By_Search.jsp">Search Complaint</a></li>

				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">Search Complaint</h3>


					</div>
					<!-- end content-module-heading -->
					<form action="Search_Controller" method="post"></form>

					<div class="content-module-main">






						<div id="form_container">

							<form id="form_596466" class="appnitro" name="edit" method="post"
								action="Search_Controller">

								<label class="description"> <strong style="color: red;">
										Please select atleast one parameter !!! </strong>
								</label>


								<ul>

									<li id="li_3"><label class="description" for="element_3">Company
											Name </label>
										<div>
											<select name="company_name">
												<option value="0">---select---</option>
												<%
													PreparedStatement ps_com = con
																.prepareStatement("select * from user_tbl_Company");
														ResultSet rs_com = ps_com.executeQuery();
														while (rs_com.next()) {
												%>
												<option value="<%=rs_com.getInt("Company_Id")%>">
													<%=rs_com.getString("Company_Name")%></option>
												<%
													}
														rs_com.close();
														ps_com.close();
												%>
											</select>
										</div></li>
									<li id="li_4"><label class="description" for="element_4">Customer
											Name </label>
										<div>
											<select name="cust_name">
												<option value="0">---select---</option>
												<%
													PreparedStatement ps_cust = con
																.prepareStatement("select * from customer_tbl");
														ResultSet rs_cust = ps_cust.executeQuery();
														while (rs_cust.next()) {
												%>
												<option value="<%=rs_cust.getInt("Cust_Id")%>">
													<%=rs_cust.getString("Cust_Name")%></option>
												<%
													}
														rs_cust.close();
														ps_cust.close();
												%>
											</select>
										</div></li>
									<li id="li_5"><label class="description" for="element_5">Severity
									</label>
										<div>
											<select name="severity">
												<option value="0">---select---</option>
												<%
													PreparedStatement ps_p = con
																.prepareStatement("select * from severity_tbl");
														ResultSet rs_p = ps_p.executeQuery();
														while (rs_p.next()) {
												%>
												<option value="<%=rs_p.getInt("P_Id")%>"><%=rs_p.getString("P_Type")%></option>
												<%
													}
														rs_p.close();
														ps_p.close();
												%>
											</select>
										</div></li>
									<li id="li_6"><label class="description" for="element_6">Status
									</label>
										<div>
											<select name="status">
												<option value="0">---select---</option>
												<%
													PreparedStatement ps_status = con
																.prepareStatement("select * from Status_tbl");
														ResultSet rs_status = ps_status.executeQuery();
														while (rs_status.next()) {
												%>
												<option value="<%=rs_status.getInt("Status_Id")%>"><%=rs_status.getString("Status")%></option>
												<%
													}
														rs_status.close();
														ps_status.close();
												%>
											</select>
										</div></li>
									<li id="li_1"><label class="description" for="element_1">Select
											Start Date </label> <span> <input id="element_1_1" name="m1"
											class="element text" size="2" maxlength="2" value=""
											type="text"> / <label for="element_1_1">MM</label>
									</span> <span> <input id="element_1_2" name="d1"
											class="element text" size="2" maxlength="2" value="0"
											type="text"> / <label for="element_1_2">DD</label>
									</span> <span> <input id="element_1_3" name="y1"
											class="element text" size="4" maxlength="4" value=""
											type="text"> <label for="element_1_3">YYYY</label>
									</span> <span id="calendar_1"> <img id="cal_img_1"
											class="datepicker" src="calendar.gif" alt="Pick a date.">
									</span> <script type="text/javascript">
										Calendar.setup({
											inputField : "element_1_3",
											baseField : "element_1",
											displayArea : "calendar_1",
											button : "cal_img_1",
											ifFormat : "%B %e, %Y",
											onSelect : selectDate
										});
									</script></li>
									<li id="li_2"><label class="description" for="element_2">Select
											End Date </label> <span> <input id="element_2_1" name="m2"
											class="element text" size="2" maxlength="2" value=""
											type="text"> / <label for="element_2_1">MM</label>
									</span> <span> <input id="element_2_2" name="d2"
											class="element text" size="2" maxlength="2" value="0"
											type="text"> / <label for="element_2_2">DD</label>
									</span> <span> <input id="element_2_3" name="y2"
											class="element text" size="4" maxlength="4" value=""
											type="text"> <label for="element_2_3">YYYY</label>
									</span> <span id="calendar_2"> <img id="cal_img_2"
											class="datepicker" src="calendar.gif" alt="Pick a date.">
									</span> <script type="text/javascript">
										Calendar.setup({
											inputField : "element_2_3",
											baseField : "element_2",
											displayArea : "calendar_2",
											button : "cal_img_2",
											ifFormat : "%B %e, %Y",
											onSelect : selectDate
										});
									</script></li>

									<li class="buttons"><input type="hidden" name="form_id"
										value="596466" /> <input id="saveForm" class="button_text"
										type="submit" name="submit" value="Search" /></li>
								</ul>
							</form>

						</div>
						<!-- end content-module-main -->
						<%
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
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