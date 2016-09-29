<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.muthagroup.bo.GetUserName_BO"%> 
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="js/jquery-1.3.2.min.js" language="javascript"
	type="text/javascript"></script>
<script src="js/jquery-blink.js" language="javscript"
	type="text/javascript"></script>

<script type="text/javascript" language="javascript">
	$(document).ready(function() {
		$('.blink').blink();
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
<title>Home</title>

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


</head>
<body>

	<SCRIPT LANGUAGE="JavaScript">
		function button1(val) {
			var val1 = val;

			document.getElementById("hid").value = val1;
			edit.submit();

		}
	</SCRIPT> 
	<%
		GetUserName_BO ubo = new GetUserName_BO();
		//PreparedStatement ps = null;
		//ResultSet rs = null;
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		//out.println("UID "+ uid);
		String U_Name = ubo.getUserName(uid);
		//out.print("user name  :"+U_Name);
		String complaint_no = null;
		int count = 0, int_count = 0;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			Connection con = Connection_Utility.getConnection();
			session.setMaxInactiveInterval(-1);
			PreparedStatement ps = con
					.prepareStatement("select * from complaint_tbl order by complaint_date desc limit 5");
			ResultSet rs = ps.executeQuery();

			PreparedStatement ps6 = con
					.prepareStatement("select count(Status_Id) from complaint_tbl where Status_Id=1 and complaint_type='customer'");
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Status_Id)");
				session.setAttribute("count", count);
			}
			ps6 = con
					.prepareStatement("select count(Status_Id) from complaint_tbl where Status_Id=1 and complaint_type='internal'");
			rs6 = ps6.executeQuery();
			while (rs6.next()) {
				int_count = rs6.getInt("count(Status_Id)");
				session.setAttribute("int_count", int_count);
			}
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">
				<li class="v-sep"><a href="Home.jsp"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a>
				</li>

				<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"
					title="New Customer Complaints"><%=count%> Customer Complaints</a></li>
				<li><a href="All_Complaint_OthersQlty.jsp"
					class="round button dark menu-email-special image-left"
					title="New Internal Complaints"><%=int_count%> Internal
						Complaints</a></li>

				<!-- 
					<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"> All
						Complaints</a></li>
				 -->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>
			</ul>
			<!-- end nav -->
			<!-- 	<form action="#" method="POST" id="search-form" class="fr">
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
				<li><a href="Home.jsp" class="active-tab dashboard-tab">Home</a></li>
				<li><a href="Report_List_Others.jsp"
					class="active-tab dashboard-tab">Reports</a></li>

				<li><a href="Dashboard.jsp" class="active-tab dashboard-tab">Dashboard</a></li>

			</ul>
			<!-- end tabs -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 30px height. -->
			<a href="Home.jsp" id="company-branding-small" class="fr"><img
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
					<li><a href="Edit_By_Search_Other.jsp">Search Complaint</a></li>

				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">All Complaint's</h3>
						<%
							//********************************************************************************************************************

								//TO display last 3 Complaints at the marketing home page...

								//******************************************************************************************************************
						%>

					</div>
					<!-- end content-module-heading -->


					<div class="content-module-main">

						<form name="edit" action="Complaint_Action.jsp" method="post">
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
	}
	%>
	<%
										Connection conn = null;
											Class.forName("com.mysql.jdbc.Driver").newInstance();
											conn = DriverManager.getConnection(
													"jdbc:mysql://localhost:3306/ComplaintZilla", "root",
													"root");

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

											String sqlPagination = "SELECT SQL_CALC_FOUND_ROWS *,CONVERT(SUBSTRING(Complaint_No, 12, 100),Unsigned Integer) as C_No FROM Complaint_Tbl where Status_id!=5 order by C_No desc limit "
													+ iPageNo + "," + iShowRows + "";

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
										<table width="100%" cellpadding="0" cellspacing="0" border="0"
											style="font-family: Arial;">
											<thead>
												<tr>
													<th>Complaint No</th>
													<th>Type</th>
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

											</thead>

											<%
												while (rsPagination.next()) {
											%>
											<tr onmouseover="ChangeColor(this, true);"
												onmouseout="ChangeColor(this, false);"
												onclick="button1('<%=rsPagination.getString("complaint_no")%>');"
												style="cursor: pointer;">
												<td><%=rsPagination.getString("Complaint_No")%></td>
												<td><%=rsPagination.getString("complaint_type")%></td>
												<%
													PreparedStatement ps_cust = con
																	.prepareStatement("select Cust_name from Customer_tbl where Cust_Id="
																			+ rsPagination.getInt("Cust_Id"));
															ResultSet rs_cust = ps_cust.executeQuery();
															while (rs_cust.next()) {
												%>
												<td><%=rs_cust.getString("Cust_Name")%></td>

												<%
													}
												%>



												<%
													PreparedStatement ps_comp = con
																	.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
																			+ rsPagination.getInt("Company_Id"));
															ResultSet rs_comp = ps_comp.executeQuery();
															while (rs_comp.next()) {
												%>
												<td><%=rs_comp.getString("Company_Name")%></td>
												<%
													}
												%>




												<%
													PreparedStatement ps_Status = con
																	.prepareStatement("select Status from Status_tbl where Status_Id="
																			+ rsPagination.getInt("Status_id"));
															ResultSet rs_Status = ps_Status.executeQuery();
															while (rs_Status.next()) {
																if (rs_Status.getString("Status").equalsIgnoreCase(
																		"New")) {
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
																			+ rsPagination.getInt("P_id"));
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
																			+ rsPagination.getInt("Item_id"));
															ResultSet rs_Item = ps_Item.executeQuery();
															while (rs_Item.next()) {
												%>
												<td><%=rs_Item.getString("Item_Name")%></td>
												<%
													}

															PreparedStatement ps_Defect = con
																	.prepareStatement("select Defect_Type from Defect_tbl where Defect_id="
																			+ rsPagination.getInt("Defect_Id"));
															ResultSet rs_Defect = ps_Defect.executeQuery();
															while (rs_Defect.next()) {
												%>
												<td><strong><%=rs_Defect.getString("Defect_Type")%></strong>
												</td>
												<%
													}
												%>

												<td><%=rsPagination.getString("Complaint_Received_By")%></td>

												<%
													PreparedStatement ps_related = con
																	.prepareStatement("select Department from User_tbl_Dept where Dept_id="
																			+ rsPagination
																					.getInt("Complaint_Related_To"));
															ResultSet rs_related = ps_related.executeQuery();
															while (rs_related.next()) {
												%>
												<td><%=rs_related.getString("Department")%></td>
												<%
													}
															PreparedStatement ps_registerer = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rsPagination.getInt("U_Id"));
															ResultSet rs_registerer = ps_registerer.executeQuery();
															while (rs_registerer.next()) {
												%>

												<td><%=rs_registerer.getString("U_Name")%></td>
												<%
													}

															PreparedStatement ps_assigned = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rsPagination
																					.getInt("Complaint_Assigned_To"));
															ResultSet rs_assigned = ps_assigned.executeQuery();
															while (rs_assigned.next()) {
												%>
												<td><%=rs_assigned.getString("U_Name")%></td>
												<%
													}

															PreparedStatement ps_category = con
																	.prepareStatement("select Category from Category_tbl where category_id="
																			+ rsPagination.getInt("category_id"));
															ResultSet rs_category = ps_category.executeQuery();
															while (rs_category.next()) {
												%>
												<td><%=rs_category.getString("Category")%></td>
												<%
													}
												%>

												<td><%=sdf.format(rsPagination.getDate("complaint_date"))%></td>
												<%-- <!-- 	<td>
													<button onclick="button1(this.value)" name="edit_button"
														id="edit_button"
														value="<%=rsPagination.getString("complaint_no")%>">&nbsp;&nbsp;&nbsp;Take&nbsp;&nbsp;&nbsp;</button>
												</td> --> --%>
												<input type="hidden" name="hid" id="hid">
											</tr>
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
															href="Home.jsp?iPageNo=<%=prePageNo%>&cPageNo=<%=prePageNo%>">
															Previous</a>
														<%
															}

																	for (i = ((cPage * iTotalSearchRecords) - (iTotalSearchRecords - 1)); i <= (cPage * iTotalSearchRecords); i++) {
																		if (i == ((iPageNo / iShowRows) + 1)) {
														%>
														<a href="Home.jsp?iPageNo=<%=i%>"
															style="cursor: pointer; color: red"><b><%=i%></b></a>
														<%
															} else if (i <= iTotalPages) {
														%>
														<a href="Home.jsp?iPageNo=<%=i%>"><%=i%></a>
														<%
															}
																	}
																	if (iTotalPages > iTotalSearchRecords && i < iTotalPages) {
														%>
														<a href="Home.jsp?iPageNo=<%=i%>&cPageNo=<%=i%>"> Next</a>
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

													<th>Complaint No</th>
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
			<a href="http://www.muthagroup.com">Mutha Group of Foundries,
				Satara</a>
		</p>

	</div>
	<!-- end footer -->
</body>
</html>