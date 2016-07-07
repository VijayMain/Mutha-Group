<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Search_Result</title>

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


	<%@ page import="com.muthagroup.bo.GetUserName_BO"%>
	<%@ page import="com.muthagroup.vo.Edit_By_Search_VO"%>
	<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
	<%@ page import="java.util.ArrayList"%>
	<%
		GetUserName_BO ubo = new GetUserName_BO();
		Edit_By_Search_VO bean = null;
		String complaint_no = null;
		//Edit_By_Search_DAO dao=new Edit_By_Search_DAO();

		//PreparedStatement ps = null;
		//ResultSet rs = null;
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		//out.println("UID "+ uid);
		String U_Name = ubo.getUserName(uid);
		int dept_id = ubo.getUserDeptID(uid); 
		//out.print("user name  :"+U_Name);

		int count = 0;
		try {
			//complaint_no=bean.getComplaint_no();
			Connection con = Connection_Utility.getConnection();
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			PreparedStatement ps6 = con
					.prepareStatement("select count(status_id) from complaint_tbl where status_id=1");
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Status_Id)");
				session.setAttribute("count", count);
			}

			ArrayList arr = new ArrayList();
			if (request.getAttribute("arry") != null) {
				arr = (ArrayList) request.getAttribute("arry");
				System.out.println("There are values in the arraylist");
			} else {
				System.out.println("There are no values in the arraylist");
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
				<%
					if(dept_id==8){
				%>	
				<li><a href="Register_Complaint.jsp" class="active-tab dashboard-tab">Register Complaint</a></li>
				<%
					}
				%>
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
				<%
					if(dept_id==8){
				%>
					<li><a href="Register_Complaint.jsp">Register Complaint</a></li>
				<%
					}
				%>	
					<li><a href="Edit_By_Search.jsp">Search Complaint</a></li>

				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">Search Result</h3>
						<%
							//********************************************************************************************************************

								//TO display searched Complaints at the marketing home page...

								//******************************************************************************************************************
						%>

					</div>
					<!-- end content-module-heading -->


					<div class="content-module-main">

						<form name="edit" action="Edit_Complaint.jsp" method="post">
							<table>

								<thead>

									<tr>

										<th>Complaint No</th>
										<th>Customer Name</th>
										<th>Status</th>
										<th>Item Name</th>
										<th>Defect</th>
										<th>Complaint Received By</th>
										<th>Severity</th>
										<th>Complaint Related To</th>
										<th>Complaint Registered By</th>
										<th>Complaint Assigned To</th>
										<th>Category</th>
										<th>Complaint Date</th>
									</tr>

								</thead>
								<tbody>
									<%
										for (int i = 0; i < arr.size(); i++) {
												complaint_no = arr.get(i).toString();
												//out.println(complaint_no);

												PreparedStatement ps = con
														.prepareStatement("select * from complaint_tbl where complaint_no='"
																+ complaint_no + "'");
												ResultSet rs = ps.executeQuery();

												while (rs.next()) {
													//complaint_no = session.getAttribute("complaint_no").toString();
									%>
									<tr onmouseover="ChangeColor(this, true);"
										onmouseout="ChangeColor(this, false);"
										onclick="button1('<%=complaint_no%>');">

										<td><%=complaint_no%></td>
										<%
											//session.setAttribute("complaint_no", complaint_no);
														PreparedStatement ps1 = con
																.prepareStatement("select cust_name from customer_tbl where cust_Id="
																		+ rs.getInt("Cust_Id"));
														ResultSet rs1 = ps1.executeQuery();
														while (rs1.next()) {
										%>
										<td><%=rs1.getString("cust_name")%></td>
										<%
											String status = null;
															PreparedStatement ps5 = con
																	.prepareStatement("select status from status_tbl where status_id=(select status_id from complaint_tbl where Complaint_No='"
																			+ complaint_no + "')");
															ResultSet rs5 = ps5.executeQuery();
															while (rs5.next()) {
										%>
										<td><%=rs5.getString("status")%></td>
										<%
											}
														}

														PreparedStatement ps2 = con
																.prepareStatement("select Item_Name from customer_tbl_Item where Item_Id="
																		+ rs.getInt("Item_Id"));
														ResultSet rs2 = ps2.executeQuery();
														while (rs2.next()) {
										%>
										<td><%=rs2.getString("Item_Name")%></td>
										<%
											}

														PreparedStatement ps3 = con
																.prepareStatement("select defect_type from defect_tbl where Defect_Id="
																		+ rs.getInt("Defect_Id"));
														ResultSet rs3 = ps3.executeQuery();
														while (rs3.next()) {
										%>
										<td><%=rs3.getString("defect_type")%></td>
										<%
											}
										%>
										<td><%=rs.getString("Complaint_Received_By")%></td>
										<%
											PreparedStatement ps_sev = con
																.prepareStatement("select P_type from Severity_tbl where P_Id='"
																		+ rs.getInt("P_Id") + "'");
														ResultSet rs_sev = ps_sev.executeQuery();
														while (rs_sev.next()) {
										%>

										<td><%=rs_sev.getString("P_Type")%></td>

										<%
											}

														PreparedStatement ps_dept = con
																.prepareStatement("select department from User_tbl_dept where dept_Id="
																		+ rs.getInt("Complaint_Related_To"));
														ResultSet rs_dept = ps_dept.executeQuery();
														while (rs_dept.next()) {
										%>

										<td><%=rs_dept.getString("Department")%></td>
										<%
											}

														PreparedStatement ps_registerer = con
																.prepareStatement("select U_Name from User_tbl where U_id="
																		+ rs.getInt("U_Id"));
														ResultSet rs_registerer=ps_registerer.executeQuery();
														while(rs_registerer.next())
														{
															
											%>
													
													<td><%=rs_registerer.getString("U_Name")%></td>
											<%															

														}	

														PreparedStatement ps_u = con
																.prepareStatement("select U_Name from User_tbl where U_Id="
																		+ rs.getInt("Complaint_Assigned_To"));
														ResultSet rs_u = ps_u.executeQuery();
														while (rs_u.next()) {
										%>

										<td><%=rs_u.getString("U_Name")%></td>
										<%
											}
										%>
										<%
											PreparedStatement ps4 = con
																.prepareStatement("select Category from Category_tbl where Category_Id="
																		+ rs.getInt("Category_Id"));
														ResultSet rs4 = ps4.executeQuery();
														while (rs4.next()) {
										%>

										<td><%=rs4.getString("Category")%>
										<input type="hidden" name="hid" id="hid">
										</td>
										<%
											}
										%>
										<td><%=sdf.format(rs.getDate("complaint_date"))%></td>
										<%-- <!-- <td>
											<button onclick="button1(this.value)" name="edit_button"
												id="edit_button" value="<%=complaint_no%>">View/Edit</button>
										</td>--> --%>
										
									</tr>

									<%
										}
											}
										} catch (Exception e) {
											e.printStackTrace();
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