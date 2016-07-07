<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
td {
	border-collapse: collapse;
}

td a {
	text-decoration: none;
}
</style>
<script src="js/jquery-1.3.2.min.js" language="javascript"
	type="text/javascript"></script>
<script src="js/jquery-blink.js" language="javscript"
	type="text/javascript"></script>

<script type="text/javascript" language="javascript">
	$(document).ready(function() {
		$('.blink').blink();
	});
	$(document).ready(function() {
		$('.blinkst').blink();
	});
</script>

<script type="text/javascript">
	function noBack() {
		window.history.forward();
	};
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
<title>Unassigned Unit3 Complaints</title>

<!-- Stylesheets -->
<link rel="stylesheet" href="css/style.css">

<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery & JS files -->

<script src="js/script.js"></script>

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = 'white';
		}
	}

	/* function DoNav(theUrl) {
		document.location.href = theUrl;
		//	document.getElementById("frm1").submit();
	} */
</script>

<script type="text/javascript">
	function submitForm() {
		var form = document.getElementById("myForm");
		var mode = document.getElementById("choice");
		if (mode.value == "MEPLH-21") {
			form.action = "Unassigned_Mepl.jsp";
		} else if (mode.value == "MEPLH-25") {
			form.action = "Unassigned_Mepl25.jsp";
		} else if (mode.value == "") {
			form.action = "Unassigned_Complaints.jsp";
		} else if (mode.value == "DI") {
			form.action = "Unassigned_DI.jsp";
		} else if (mode.value == "MFPL") {
			form.action = "Unassigned_MFPL.jsp";
		} else if (mode.value == "MEPL Unit-3") {
			form.action = "Unassigned_unit3.jsp";
		}
	}
</script>


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
		String mail = null;

		//***************************************************************************************************************************
		String order = null;
		if (request.getParameter("name") == null) {
			order = "Company_Id";
		} else if (request.getParameter("name").equals("unassign_id")) {
			order = "unassign_id";
		} else if (request.getParameter("name").equals("Mail_From")) {
			order = "Mail_From";
		} else if (request.getParameter("name").equals("Mail_Subject")) {
			order = "Mail_Subject";
		} else if (request.getParameter("name")
				.equals("Mail_Received_Date")) {
			order = "Mail_Received_Date";
		} else if (request.getParameter("name").equals("Company_Name")) {
			order = "Company_Id";
		}

		//***************************************************************************************************************************

		session.setMaxInactiveInterval(-1); //Session timeout limit = unlimited

		int count = 0;

		try {

			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps = con
					.prepareStatement("select * from complaint_tbl order by complaint_date desc limit 5");
			ResultSet rs = ps.executeQuery();

			PreparedStatement ps6 = con
					.prepareStatement("select count(status_id) from complaint_tbl where status_id=1");
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Status_Id)");
				session.setAttribute("count", count);
			}
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">


				<li class="v-sep"><a href="Marketing_Home.jsp"
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


			<!-- <form action="#" method="POST" id="search-form" class="fr">
				<fieldset>
					<input type="text" id="search-keyword"
						class="round button dark ic-search image-right" /> <input
						type="hidden" value="SUBMIT" />
				</fieldset>
			</form> -->

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
				<li><a href="Unassigned_Complaints.jsp"
					class="active-tab dashboard-tab">Unassigned Complaints</a></li>
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

				<h3 align="center">Content</h3>
				<ul>
					<li><a href="Register_Complaint.jsp">Register Complaint</a></li>
					<li><a href="Edit_By_Search.jsp">Search Complaint</a></li>
					<li><a href="Unassigned_Complaints.jsp">Unassigned
							Complaints</a></li>

				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">Unassigned Complaint's</h3>
					</div>
					<!----------------------------- end content-module-heading ---------------------------->
					<form name="myForm" method="post" action="oldUrl.do" id="myForm"
						onsubmit="return submitForm()">
						<select name="modeOfT" id="choice">

							<%
								PreparedStatement ps_cp = con
											.prepareStatement("select * from user_tbl_company  where Company_Id!=6");
									ResultSet rs_cp = ps_cp.executeQuery();
							%>
							<option value="">Select Company</option>
							<%
								while (rs_cp.next()) {
							%>
							<option value="<%=rs_cp.getString("Company_Name")%>"><%=rs_cp.getString("Company_Name")%></option>
							<%
								}
							%>

						</select><input type="submit" value="Get Mails" name="submitBtn"
							onclick="submitForm()">

					</form>

					<div class="content-module-main">

						<form name="edit" action="Register_Complaint_Unassign.jsp"
							method="post">
							<table>


								<tbody>
									<%@ page language="java"
										contentType="text/html; charset=ISO-8859-1"%>
									<%@ page import="java.sql.PreparedStatement"%>
									<%@ page import="java.sql.ResultSet"%>
									<%@ page import="java.sql.Connection"%>
									<%@ page import="java.sql.DriverManager"%>
									<%!public int nullIntconv(String str) {
		int conv = 0;
		if (str == null) {
			str = "0";
		} else if ((str.trim()).equals("null")) {
			str = "0";
		} else if (str.equals("")) {
			str = "0";
		}
		try {
			conv = Integer.parseInt(str);
		} catch (Exception e) {
		}
		return conv;
	}%>
									<%
										Connection conn = null;
											conn = Connection_Utility.getConnection();

											ResultSet rsPagination = null;
											ResultSet rsRowCnt = null;

											PreparedStatement psPagination = null;
											PreparedStatement psRowCnt = null;

											int iShowRows = 10; // Number of records show on per page
											int iTotalSearchRecords = 10; // Number of pages index shown

											int iTotalRows = nullIntconv(request.getParameter("iTotalRows"));
											int iTotalPages = nullIntconv(request
													.getParameter("iTotalPages"));
											int iPageNo = nullIntconv(request.getParameter("iPageNo"));
											int cPageNo = nullIntconv(request.getParameter("cPageNo"));

											int iStartResultNo = 0;
											int iEndResultNo = 0;

											if (iPageNo == 0) {
												iPageNo = 0;
											} else {
												iPageNo = Math.abs((iPageNo - 1) * iShowRows);
											}

											String sqlPagination = "SELECT SQL_CALC_FOUND_ROWS * FROM complaint_tbl_unassigned where Enable_Id=1 and Company_Id=5 order by '"
													+ order + "' limit " + iPageNo + "," + iShowRows + "";

											psPagination = conn.prepareStatement(sqlPagination);
											rsPagination = psPagination.executeQuery();

											//// this will count total number of rows
											String sqlRowCnt = "SELECT FOUND_ROWS() as cnt";
											psRowCnt = conn.prepareStatement(sqlRowCnt);
											rsRowCnt = psRowCnt.executeQuery();

											if (rsRowCnt.next()) {
												iTotalRows = rsRowCnt.getInt("cnt");
											}
									%>
									<form name="frm">
										<input type="hidden" name="iPageNo" value="<%=iPageNo%>">
										<input type="hidden" name="cPageNo" value="<%=cPageNo%>">
										<input type="hidden" name="iShowRows" value="<%=iShowRows%>">
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
											<thead>

												<tr>
													<th width="20%"><a
														href="Unassigned_unit3.jsp?name=unassign_id"
														style="color: white;">Sr. No</a></th>
													<th><a href="Unassigned_unit3.jsp?name=Mail_From"
														style="color: white;"> Mail From</a></th>



													<th><a href="Unassigned_unit3.jsp?name=Mail_Subject"
														style="color: white;">Mail Subject</a></th>


													<th width="30%"><a
														href="Unassigned_unit3.jsp?name=Mail_Received_Date"
														style="color: white;"> Mail Received Date</a></th>


													<th><a href="Unassigned_unit3.jsp?name=Company_Name"
														style="color: white;"> Company</a></th>
												</tr>
												<%
													System.out.println("Unassigned mail= "
																+ request.getParameter("name"));
												%>
											</thead>



											<%
												while (rsPagination.next()) {
											%>
											<tr onmouseover="ChangeColor(this, true);"
												onmouseout="ChangeColor(this, false);"
												onclick="button1('<%=rsPagination.getInt("unassign_id")%>');">
												<td width="20%"><%=rsPagination.getInt("unassign_id")%></td>

												<td><%=rsPagination.getString("Mail_From")%></td>

												<td><%=rsPagination.getString("Mail_Subject")%></td>

												<td width="30%"><%=rsPagination.getTimestamp("Mail_Received_Date")%></td>



												<%
													PreparedStatement ps_cmp = con
																	.prepareStatement("select * from user_tbl_company where Company_Id="
																			+ rsPagination.getInt("Company_Id"));
															ResultSet rs_comp = ps_cmp.executeQuery();
															while (rs_comp.next()) {
												%>
												<td><%=rs_comp.getString("Company_Name")%></td>
												<%
													}
												%>




											</tr>
											<input type="hidden" name="hid" id="hid">
											<%
												}
											%>
											<%
												//// calculate next record start record  and end record 
													try {
														if (iTotalRows < (iPageNo + iShowRows)) {
															iEndResultNo = iTotalRows;
														} else {
															iEndResultNo = (iPageNo + iShowRows);
														}

														iStartResultNo = (iPageNo + 1);
														iTotalPages = ((int) (Math.ceil((double) iTotalRows
																/ iShowRows)));

													} catch (Exception e) {
														e.printStackTrace();
													}
											%>
											<tr>
												<td colspan="3">
													<div>
														<%
															//// index of pages 

																int i = 0;
																int cPage = 0;
																if (iTotalRows != 0) {
																	cPage = ((int) (Math.ceil((double) iEndResultNo
																			/ (iTotalSearchRecords * iShowRows))));

																	int prePageNo = (cPage * iTotalSearchRecords)
																			- ((iTotalSearchRecords - 1) + iTotalSearchRecords);
																	if ((cPage * iTotalSearchRecords) - (iTotalSearchRecords) > 0) {
														%>
														<a
															href="Unassigned_unit3.jsp?iPageNo=<%=prePageNo%>&cPageNo=<%=prePageNo%>">
															Previous</a>
														<%
															}

																	for (i = ((cPage * iTotalSearchRecords) - (iTotalSearchRecords - 1)); i <= (cPage * iTotalSearchRecords); i++) {
																		if (i == ((iPageNo / iShowRows) + 1)) {
														%>
														<a href="Unassigned_unit3.jsp?iPageNo=<%=i%>"
															style="cursor: pointer; color: red"><b><%=i%></b></a>
														<%
															} else if (i <= iTotalPages) {
														%>
														<a href="Unassigned_unit3.jsp?iPageNo=<%=i%>"><%=i%></a>
														<%
															}
																	}
																	if (iTotalPages > iTotalSearchRecords && i < iTotalPages) {
														%>
														<a
															href="Unassigned_unit3.jsp?iPageNo=<%=i%>&cPageNo=<%=i%>">
															Next</a>
														<%
															}
																}
														%>
														<b>Rows <%=iStartResultNo%> - <%=iEndResultNo%> Total
															Result <%=iTotalRows%>
														</b>
													</div>
												</td>
											</tr>
											<thead>

												<tr>
													<th width="20%"><a
														href="Unassigned_unit3.jsp?name=unassign_id"
														style="color: white;">Sr. No</a></th>
													<th><a href="Unassigned_unit3.jsp?name=Mail_From"
														style="color: white;"> Mail From</a></th>



													<th><a href="Unassigned_unit3.jsp?name=Mail_Subject"
														style="color: white;">Mail Subject</a></th>


													<th width="30%"><a
														href="Unassigned_unit3.jsp?name=Mail_Received_Date"
														style="color: white;"> Mail Received Date</a></th>


													<th><a href="Unassigned_unit3.jsp?name=Company_Name"
														style="color: white;"> Company</a></th>
												</tr>
												<%
													System.out.println("Unassigned mail= "
																+ request.getParameter("name"));
												%>
											</thead>

										</table>
									</form>

									<%
										try {
												if (psPagination != null) {
													psPagination.close();
												}
												if (rsPagination != null) {
													rsPagination.close();
												}

												if (psRowCnt != null) {
													psRowCnt.close();
												}
												if (rsRowCnt != null) {
													rsRowCnt.close();
												}

												if (conn != null) {
													conn.close();
												}
											} catch (Exception e) {
												e.printStackTrace();
											}
										} catch (Exception e)

										{
											e.printStackTrace();
										} finally {

										}
									%>
								</tbody>
							</table>
						</form>
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