<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="com.muthagroup.bo.Login_BO"%>
<%@page import="com.muthagroup.vo.Login_VO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.muthagroup.bo.GetUserName_BO"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="com.muthagroup.vo.Edit_VO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>
<html>
<head>

<title>Edit_Complaint</title>
<!--
//******************************************************************************************************************************
-->
<script type="text/javascript" src="scripts/jquery-1.3.2.js"></script>
<script type="text/javascript" src="scripts/jHtmlArea-0.7.5.js"></script>
<link rel="Stylesheet" type="text/css" href="style/jHtmlArea.css" />
<script type="text/javascript">
	$(function() {

		$("textarea").htmlarea(); // Initialize jHtmlArea's with all default values
	});
</script>
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: left;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
}
</style>

<!-- 
//******************************************************************************************************************************
-->

<!-- Stylesheets -->
<link rel="stylesheet" href="css/style.css">

<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery & JS files -->

<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript" src="js/view.js"></script>
<script type="text/javascript" src="js/calendar.js"></script>
<link rel="stylesheet" href="css/style.css">
<script src="js/script.js"></script>
<script type="text/javascript" src="tabledeleterow.js"></script>





<!-- 
// ****************************************************************************************************

							JAVA SCRIPT CODE TO DELETE FILE

// ****************************************************************************************************
 -->
<script type="text/javascript">


window.onerror = function() {
	// Returning true informs the browser,
	// that the error has been taken care of
	return true;
};


function loadSubmit() {

	ProgressImage = document.getElementById('progress_image');
	document.getElementById("progress").style.visibility = 'visible';

	setTimeout("ProgressImage.src = ProgressImage.src", 100);
	return true;

};


	function showState(str) {
		var xmlhttp;
		var where_to = confirm("Do you really want to DELETE this file ???");
		if (where_to == true) {

			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					window.location.reload();
				}
			};
			xmlhttp.open("POST", "Delete.jsp?q=" + str, true);
			xmlhttp.send();
		} else {
			window.location.reload();
		}
	}
</script>
<script language="javascript" type="text/javascript"
	src="datetimepicker.js"></script>
<!-- 

 ****************************************************************************************************
 -->
</head>



<body>


	<%
		//****************************************************************************************************

		//COUNT NEW COMPLAINT AND SET SESSION ATTRIBUTE(complaint_no) 

		//****************************************************************************************************
		Edit_VO bean = new Edit_VO();
		GetUserName_BO ubo = new GetUserName_BO();
		int count = 0;
		String complaint_no = null;
		//complaint_no=bean.getComplaint_no();
		complaint_no = request.getParameter("hid");
		System.out.println("complaint_no Edit Complaint :" + complaint_no);
		session.setAttribute("complaint_no", complaint_no);
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		count = Integer.parseInt(session.getAttribute("count").toString());
		int int_count = Integer.parseInt(session.getAttribute("int_count").toString());
		String U_Name = ubo.getUserName(uid);
		int dept_id = ubo.getUserDeptID(uid); 
		try {
			Connection con = Connection_Utility.getConnection();
			String dept_name = ""; 
			PreparedStatement ps_dp = con.prepareStatement("select * from user_tbl_dept where dept_id="+dept_id);
			ResultSet rs_dp=ps_dp.executeQuery();
			while(rs_dp.next())
			{
				dept_name=rs_dp.getString("Department"); 
			}
			ps_dp.close();
			rs_dp.close(); 
			//****************************************************************************************************
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">

				<li class="v-sep"><a href="Marketing_Home.jsp"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a></li>
					
				<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left" title="New Customer Complaints"><%=count%>
						Customer Complaints</a></li>
						<li><a href="All_Complaint_Int.jsp"
					class="round button dark menu-email-special image-left" title="New Internal Complaints"><%=int_count%>
						Internal Complaints</a></li>
						
				<!-- 
				<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left">All
						Complaints</a></li>
					 -->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out  <b>(<%= dept_name%>)</b></a></li>
			</ul>
			<!-- end nav -->


			<!-- <form action="#" method="POST" id="search-form" class="fr">
				<fieldset>
					<input type="text" id="search-keyword"
						class="round button dark ic-search image-right" /> <input
						type="hidden" value="SUBMIT" />
				</fieldset>
			</form>
 -->
		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->

	<!-- HEADER -->
	<div id="header-with-tabs">

		<div class="page-full-width cf">

			<ul id="tabs" class="fl">
				<li><a href="Marketing_Home.jsp" class="active-tab dashboard-tab">Home</a></li>
					<%
					if(dept_id==8){
					%>
				<li><a href="Register_Complaint.jsp" class="active-tab dashboard-tab">Register Complaint</a></li>
				<%
					}
				%>
			<!-- 	<li><a href="Unassigned_Complaints.jsp"
					class="active-tab dashboard-tab">Unassigned Complaints</a></li> -->
				<li><a href="Report_List.jsp" class="active-tab dashboard-tab">Reports</a></li>
				<li> <a href="Edit_By_Search.jsp" class="active-tab dashboard-tab">Search</a></li>
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

						<h3 class="fl">Edit Complaint</h3>

					</div>
					<!-- end content-module-heading -->

					<div id="form_container" style="float: left; width: 60%">


				<!--  
				****************************************************************************************************
							EDIT COMPLAINT
				****************************************************************************************************
				-->
						<form class="appnitro" action="Edit_Complaint_Controller"
							method="post" enctype="multipart/form-data">
							<%
								/****************************************************************************************************************
								TO POPULATE FORM VALUES USING COMPLAINT NUMBER 
								****************************************************************************************************************/
									PreparedStatement ps = con
											.prepareStatement("select * from customer_tbl");
									ResultSet rs = ps.executeQuery();

									PreparedStatement ps3 = con
											.prepareStatement("select * from complaint_tbl");
									ResultSet rs3 = ps3.executeQuery();

									PreparedStatement ps13 = con
											.prepareStatement("select * from user_tbl_company");
									ResultSet rs13 = ps13.executeQuery();

									int company_id = 0, company_id1 = 0, cust_id = 0, Item_Id = 0, Defect_Id = 0, Category_Id = 0, p_id = 0;
									int status_id = 0, assigned_id = 0, related_id = 0;
									String received = null, discription = null, assigned = null, related = null;
									Timestamp CDate = null;
									String cust_name = null, company_name = null, unit_name = null, company_name1 = null, item_name = null, defect = null, category = null;

			PreparedStatement ps5 = con.prepareStatement("select * from complaint_tbl where complaint_no='" + complaint_no + "'");
			ResultSet rs5 = ps5.executeQuery();

									int a_uid = 0;
									String comp_type = "";
									while (rs5.next()) {
										cust_id = rs5.getInt("cust_id");
										company_id = rs5.getInt("company_id");
										Item_Id = rs5.getInt("Item_Id");
										status_id = rs5.getInt("status_id");
										received = rs5.getString("Complaint_Received_By");
										discription = rs5.getString("Complaint_Description");
										related_id = rs5.getInt("Complaint_Related_To");
										Defect_Id = rs5.getInt("Defect_Id");
										assigned_id = rs5.getInt("Complaint_Assigned_To");
										Category_Id = rs5.getInt("Category_Id");
										CDate = rs5.getTimestamp("Complaint_Date");
										p_id = rs5.getInt("p_id");
										a_uid = rs5.getInt("U_Id");
										comp_type = rs5.getString("complaint_type");
										PreparedStatement ps_ass = con.prepareStatement("select U_Name from User_Tbl where U_Id=" + assigned_id);
										ResultSet rs_ass = ps_ass.executeQuery();
										while (rs_ass.next()) {
											assigned = rs_ass.getString("U_name");
										}

										PreparedStatement ps_rel = con
												.prepareStatement("select Department from User_Tbl_dept where dept_Id="
														+ related_id);
										ResultSet rs_rel = ps_rel.executeQuery();
										while (rs_rel.next()) {
											related = rs_rel.getString("Department");
										}

										PreparedStatement ps7 = con
												.prepareStatement("select Cust_Name from customer_tbl where cust_id="
														+ cust_id);
										ResultSet rs7 = ps7.executeQuery();
										while (rs7.next()) {
											cust_name = rs7.getString("Cust_Name");

										}

										PreparedStatement ps8 = con
												.prepareStatement("select item_name from customer_tbl_item where item_id="
														+ Item_Id);
										ResultSet rs8 = ps8.executeQuery();
										while (rs8.next()) {
											item_name = rs8.getString("item_name");
										}

										PreparedStatement ps9 = con
												.prepareStatement("select defect_type from defect_tbl where defect_id="
														+ Defect_Id);
										ResultSet rs9 = ps9.executeQuery();
										while (rs9.next()) {
											defect = rs9.getString("defect_type");
										}

										PreparedStatement ps10 = con
												.prepareStatement("select category from category_tbl where category_id="
														+ Category_Id);
										ResultSet rs10 = ps10.executeQuery();
										while (rs10.next()) {
											category = rs10.getString("category");
										}

										PreparedStatement ps12 = con
												.prepareStatement("select company_name from user_tbl_company where company_id="
														+ company_id);

										ResultSet rs12 = ps12.executeQuery();
										while (rs12.next()) {
											company_name = rs12.getString("company_name");
										}

									}
									String priority = null;
									PreparedStatement ps_p = con
											.prepareStatement("select * from severity_tbl where p_id="
													+ p_id);
									ResultSet rs_p = ps_p.executeQuery();
									while (rs_p.next()) {
										priority = rs_p.getString("p_type");
									}

									//****************************************************************************************************************
									if (uid == a_uid) {
							%>
							<ul>
								<li id="li_5"><label class="description" for="element_5">Complaint No : <%=session.getAttribute("complaint_no")%></label></li>
								
								<li id="li_5"><label class="description" for="element_5">Complaint Type : <%=comp_type%></label></li>
								
								<li id="li_5"><label class="description" for="element_5">COMPANY NAME </label>
									<div>
										<select class="element select medium" id="element_5" name="company_name" disabled="disabled">
											<option value="<%=company_id%>"><%=company_name%></option>
											<%
												while (rs13.next()) {
											%>
											<option value="<%=rs13.getInt("company_id")%>"><%=rs13.getString("company_name")%></option>
											<%
												}
											%>
										</select> <input type="hidden" name="company_name"
											value="<%=company_id%>">
									</div></li>
								<li id="li_5"><label class="description" for="element_5">CUSTOMER
										NAME </label>
									<div>

										<select class="element select medium" id="element_5" name=""
											disabled="disabled" style="width: 300px">
											<option value="<%=cust_id%>"><%=cust_name%></option>
										</select> <input type="hidden" value="<%=cust_id%>" name="cust_name">
									</div></li>



								<li id="li_6"><label class="description" for="element_6">COMPONENT
										NAME</label>
									<div>
										<select class="element select medium" id="element_6"
											name="item_name" style="width: 500px">
											<option value="<%=Item_Id%>"><%=item_name%></option>
											<%
												//SELECT COMPONEMT NAMES
														PreparedStatement ps_item = con
																.prepareStatement("select item_id from customer_item_tbl where cust_id="
																		+ cust_id);
														ResultSet rs_item = ps_item.executeQuery();
														ArrayList al = new ArrayList();
														while (rs_item.next()) {
															al.add(rs_item.getInt("item_id"));
														}
														rs_item.close();
														Iterator it = al.iterator();
														for (int i_id = 1; i_id < al.size(); i_id++) {
															PreparedStatement ps_i = con
																	.prepareStatement("select distinct Item_Name,Item_Id from customer_tbl_item where Item_id="
																			+ al.get(i_id));
															ResultSet rs_i = ps_i.executeQuery();

															while (rs_i.next()) {
											%>
											<option value="<%=rs_i.getString("Item_Id")%>"><%=rs_i.getString("Item_Name")%></option>
											<%
												}
														}
											%>
										</select>
									</div></li>




								<li id="li_7"><label class="description" for="element_7">COMPLAINT
										RECEIVED BY </label>
									<div>
										<select class="element select medium" id="element_7"
											name="received">
											<option value="<%=received%>"><%=received%></option>
											<option value="Telephone">Telephone</option>
											<option value="Email">Email</option>
											<option value="Written">Written</option>
											<option value="Other">Other</option>
										</select>
									</div></li>

								<li id="li_1"><label class="description" for="element_1">Severity</label>
									<div>
										<select class="element select medium" id="element_6"
											name="priority">
											<option value="<%=p_id%>"><%=priority%></option>
											<%
												//SELECT SEVERITY
														PreparedStatement ps_pr = con
																.prepareStatement("select * from severity_tbl where P_Id!="
																		+ p_id);
														ResultSet rs_pr = ps_pr.executeQuery();

														while (rs_pr.next()) {
											%>
											<option value="<%=rs_pr.getInt("p_id")%>"><%=rs_pr.getString("p_type")%></option>
											<%
												}
											%>
										</select>
									</div></li>


								<li id="li_10"><label class="description" for="element_10">CATEGORY
								</label>
									<div>
										<select class="element select medium" id="element_10"
											name="category">
											<option value="<%=Category_Id%>"><%=category%></option>
											<%
												PreparedStatement ps4 = con
																.prepareStatement("select * from category_tbl where Category_Id!="
																		+ Category_Id);
														ResultSet rs4 = ps4.executeQuery();
														while (rs4.next()) {
											%>
											<option value="<%=rs4.getString("Category_Id")%>"><%=rs4.getString("Category")%></option>
											<%
												}
											%>
										</select>
									</div></li>


								<li id="li_8"><label class="description" for="element_8">DEFECT
								</label>
									<div>
										<select class="element select medium" id="element_8"
											name="defect">
											<option value="<%=Defect_Id%>"><%=defect%></option>
											<%
												PreparedStatement ps2 = con
																.prepareStatement("select * from defect_tbl where Defect_Id!="
																		+ Defect_Id);
														ResultSet rs2 = ps2.executeQuery();
														while (rs2.next()) {
											%>
											<option value="<%=rs2.getString("Defect_Id")%>"><%=rs2.getString("Defect_Type")%></option>
											<%
												}
											%>
										</select>
									</div></li>




								<li id="li_1"><label class="description" for="element_1">COMPLAINT
										DESCRIPTION </label>
									<div>
										<textarea name="discription" class="element textarea medium"
											cols="60" rows="30"><%=discription%></textarea>
									</div></li>
								<li id="li_2"><label class="description" for="element_2">COMPLAINT
										RELATED TO </label>
									<div>
										<select class="element select medium" id="element_8"
											name="related">
											<option value="<%=related_id%>"><%=related%></option>
											<%
												//SELECT COMPLAINT RELATED TO ( GET DATA FROM USER TABLE )
														PreparedStatement ps_rel1 = con
																.prepareStatement("select * from User_Tbl_dept where Dept_Id!="
																		+ related_id);
														ResultSet rs_rel1 = ps_rel1.executeQuery();

														while (rs_rel1.next()) {
											%>
											<option value="<%=rs_rel1.getInt("Dept_Id")%>"><%=rs_rel1.getString("Department")%></option>
											<%
												}
											%>
										</select>
									</div></li>
								<li id="li_9"><label class="description" for="element_9">COMPLAINT
										ASSIGNED TO </label>
									<div>
										<select class="element select medium" id="element_9"
											name="assigned_name">
											<option value="<%=assigned_id%>"><%=assigned%></option>
											<%
												// GET DATA FROM USER TABLE FOR COMPLAINT ASSIGN TO
														PreparedStatement ps17 = con
																.prepareStatement("select U_Id,U_Name from user_tbl where enable_id=1 && U_Id!="
																		+ assigned_id);

														ResultSet rs17 = ps17.executeQuery();

														while (rs17.next()) {
											%>
											<option value="<%=rs17.getInt("U_Id")%>"><%=rs17.getString("U_Name")%></option>
											<%
												}
											%>
										</select>
									</div></li>

								<%
									String str = CDate.toString();

											String DD = str.substring(8, 10);
											String MM = str.substring(4, 7);
											String YYYY = str.substring(0, 4);
											String time = str.substring(10, 21);

											String str1 = DD + MM + "-" + YYYY + time;
								%>

								<li id="li_3"><label class="description" for="element_3">COMPLAINT
										Date </label> <input id="edit_date" name="edit_date" type="text" size="25"
									value="<%=str1%>" TITLE="Click on Date Picker" readonly="readonly"></li>
									
								<li id="li_4" class="buttons">
								<label class="description"
									for="element_4">ATTACH FILE (Optional) </label>
									<div>
										<div>



											<table id="tblSample">

												<tr>
													&nbsp;&nbsp;&nbsp;
													<strong> <input type="button"
														value="  ADD More Files  " name="button"
														onclick="addRowToTable();" /></strong> &nbsp;&nbsp;
													<input type="button" value=" Delete [Selected] "
														onclick="deleteChecked();" />&nbsp;&nbsp;
													<input type="hidden" id="srno" name="srno" value="">
												</tr>
												<tbody></tbody>
											</table>


											<label class="description"> Files Attached</label>
											<table style="width: 900px;">
												<tr>
													<td width="600px;" align="right"><strong>
															FILE NAME</strong></td>
													<td width="300px;"><strong> DELETE</strong></td>
												</tr>

												<%
													/****************************************************************************************************************
																																																																																											
																																																																																															TO SELECT ATTACHMENTS RELATED TO COMPLAINT NUMBER 							
																																																																																											
															 ****************************************************************************************************************/
															PreparedStatement ps_file = con
																	.prepareStatement("select * from complaint_tbl_attachments where Complaint_No like'"
																			+ complaint_no
																			+ "'"
																			+ "and  delete_Status=1");
															ResultSet rs_file = ps_file.executeQuery();
															while (rs_file.next()) {
																System.out.println("Files Attached "
																		+ rs_file.getString("File_Name"));
																System.out.println("Primary key = "
																		+ rs_file.getInt("Attach_Id"));

																//****************************************************************************************************************
												%>
												<tr>


													<!--  									
												****************************************************************************************************************
																		
																		TO Display/Delete files attached for complaint number
												
												****************************************************************************************************************
													-->
													<td><a
														href="Display.jsp?field=<%=rs_file.getString("File_Name")%>">
															<%=rs_file.getString("File_Name")%></a></td>
													<td><input type="button" value="    Delete    "
														onclick="showState(<%=rs_file.getInt("Attach_Id")%>)"></td>
													<!-- 
										***********************************************************************************************************************
												  -->
												</tr>

											<%
													}
												%>

											</table>
											<label class="description"> Customers Reply</label>
											<table>
												<%
													PreparedStatement ps_un = con
																	.prepareStatement("select * from complaint_unassigned_rel_tbl where Complaint_No='"
																			+ complaint_no + "'");
															ResultSet rs_un = ps_un.executeQuery();
															rs_un.last();
															int attch = rs_un.getRow();
															rs_un.beforeFirst();
															if (attch > 0) {
																while (rs_un.next()) {
																	PreparedStatement ps_unassign = con
																			.prepareStatement("select * from complaint_tbl_unassigned_attachment where unassign_Id="
																					+ rs_un.getInt("unassign_Id"));
																	ResultSet rs_unassign = ps_unassign.executeQuery();
																	while (rs_unassign.next()) {
												%>
												<tr>
													<td><a
														href="ViewCustAttachment.jsp?field=<%=rs_unassign
										.getInt("Unasigned_Attach_id")%>"><%=rs_unassign.getString("File_Name")%></a>
													</td>
												</tr>
												<%
													}
																}
															}
												%>


											</table>





										</div>
									</div></li>

								<li class="buttons"><input
									style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;"
									id="saveForm" class="button_text" type="submit" name="submit"
									onclick="loadSubmit()" value="UPDATE" /></li>
							</ul>
							<%
								} else {
							%>
							<ul>
								<li id="li_5"><label class="description" for="element_5">Complaint No : <%=session.getAttribute("complaint_no")%></label></li>
								<li id="li_5"><label class="description" for="element_5">Complaint Type : <%=comp_type%></label></li>
								<li id="li_5"><label class="description" for="element_5">COMPANY NAME </label>
									<div>

										<select class="element select medium" id="element_5"
											name="company_name" disabled="disabled">
											<option value="<%=company_id%>"><%=company_name%></option>
											<%
												while (rs13.next()) {
											%>
											<option value="<%=rs13.getInt("company_id")%>"><%=rs13.getString("company_name")%></option>
											<%
												}
											%>
										</select> <input type="hidden" name="company_name"
											value="<%=company_id%>">
									</div></li>
								<li id="li_5"><label class="description" for="element_5">CUSTOMER
										NAME </label>
									<div>

										<select class="element select medium" id="element_5" name=""
											disabled="disabled" style="width: 300px">
											<option value="<%=cust_id%>"><%=cust_name%></option>
										</select> <input type="hidden" value="<%=cust_id%>" name="cust_name">
									</div></li>



								<li id="li_6"><label class="description" for="element_6">COMPONENT
										NAME</label>
									<div>
										<select class="element select medium" id="element_6"
											name="item_name" style="width: 500px" disabled="disabled">
											<option value="<%=Item_Id%>"><%=item_name%></option>
										</select>
									</div></li>




								<li id="li_7"><label class="description" for="element_7">COMPLAINT
										RECEIVED BY </label>
									<div>
										<select class="element select medium" id="element_7"
											name="received" disabled="disabled">
											<option value="<%=received%>"><%=received%></option>
										</select>
									</div></li>

								<li id="li_1"><label class="description" for="element_1">Severity</label>
									<div>
										<select class="element select medium" id="element_6"
											name="priority" disabled="disabled">
											<option value="<%=p_id%>"><%=priority%></option>
										</select>
									</div></li>


								<li id="li_10"><label class="description" for="element_10">CATEGORY
								</label>
									<div>
										<select class="element select medium" id="element_10"
											disabled="disabled" name="category">
											<option value="<%=Category_Id%>"><%=category%></option>
										</select>
									</div></li>


								<li id="li_8"><label class="description" for="element_8">DEFECT
								</label>
									<div>
										<select class="element select medium" id="element_8"
											disabled="disabled" name="defect">
											<option value="<%=Defect_Id%>"><%=defect%></option>
										</select>
									</div></li>




								<li id="li_1"><label class="description" for="element_1">COMPLAINT
										DESCRIPTION </label>
									<div>
										<textarea id="element_1" name="discription"
											disabled="disabled" class="element textarea medium"><%=discription%></textarea>
									</div></li>
								<li id="li_2"><label class="description" for="element_2">COMPLAINT
										RELATED TO </label>
									<div>
										<select class="element select medium" id="element_8"
											disabled="disabled" name="related">
											<option value="<%=related_id%>"><%=related%></option>
										</select>
									</div></li>
								<li id="li_9"><label class="description" for="element_9">COMPLAINT
										ASSIGNED TO </label>
									<div>
										<select class="element select medium" id="element_9"
											disabled="disabled" name="assigned_name">
											<option value="<%=assigned_id%>"><%=assigned%></option>
										</select>
									</div></li>

								<%
									String str = CDate.toString();

											String DD = str.substring(8, 10);
											String MM = str.substring(4, 7);
											String YYYY = str.substring(0, 4);
											String time = str.substring(10, 21);

											String str1 = DD + MM + "-" + YYYY + time;
								%>

								<li id="li_3"><label class="description" for="element_3">COMPLAINT
										Date </label> <input id="edit_date" name="edit_date" type="text" size="25"
									value="<%=str1%>" TITLE="Click on Date Picker"
									disabled="disabled"></li>
								
								<li id="li_4" class="buttons">
								
								<label class="description"
									for="element_4">ATTACH FILE (Optional) </label>
									<div>
										<div>

											<label class="description"> Files Attached</label>
											<table>
												<tr>
													<td align="center"><strong> FILE NAME</strong></td>
												</tr>

												<%
													/****************************************************************************************************************
																																																																																											
																																																																																															TO SELECT ATTACHMENTS RELATED TO COMPLAINT NUMBER 							
																																																																																											
															 ****************************************************************************************************************/
															PreparedStatement ps_file = con
																	.prepareStatement("select * from complaint_tbl_attachments where Complaint_No like'"
																			+ complaint_no
																			+ "'"
																			+ "and  delete_Status=1");
															ResultSet rs_file = ps_file.executeQuery();
															while (rs_file.next()) {
																System.out.println("Files Attached "
																		+ rs_file.getString("File_Name"));
																System.out.println("Primary key = "
																		+ rs_file.getInt("Attach_Id"));

																//****************************************************************************************************************
												%>
												<tr>


													<!--  									
												****************************************************************************************************************
																		
																		TO Display/Delete files attached for complaint number
												
												****************************************************************************************************************
													-->
													<td><a
														href="Display.jsp?field=<%=rs_file.getString("File_Name")%>">
															<%=rs_file.getString("File_Name")%></a></td>
													<!-- 
												
										***********************************************************************************************************************
												 
												 -->


												</tr>
												<%
													}
												%>
											</table>
											<label class="description"> Customers Reply</label>
											<table>
												<%
													PreparedStatement ps_un = con
																	.prepareStatement("select * from complaint_unassigned_rel_tbl where Complaint_No='"
																			+ complaint_no + "'");
															ResultSet rs_un = ps_un.executeQuery();
															rs_un.last();
															int attch = rs_un.getRow();
															rs_un.beforeFirst();
															if (attch > 0) {
																while (rs_un.next()) {
																	PreparedStatement ps_unassign = con
																			.prepareStatement("select * from complaint_tbl_unassigned_attachment where unassign_Id="
																					+ rs_un.getInt("unassign_Id"));
																	ResultSet rs_unassign = ps_unassign.executeQuery();
																	while (rs_unassign.next()) {
												%>
												<tr>
													<td><a
														href="ViewCustAttachment.jsp?field=<%=rs_unassign
										.getInt("Unasigned_Attach_id")%>"><%=rs_unassign.getString("File_Name")%></a>
													</td>
												</tr>
												<%
													}
																}
															}
												%>


											</table>


										</div>
									</div></li>

								<li><a href="Marketing_Home.jsp"><strong
										style="font-size: large;">Back</strong></a></li>
							</ul>




							<%
								}
							%>


							<!-- 
						
						************************************************************************************************************
						
						 -->
							<br>

							<!-- 
						
						************************************************************************************************************
						
						 -->
						</form>
					</div>

					<div style="float: right; width: 40%;background-color: #DBDBDB">
						<%
							int unassignId = 0;
								PreparedStatement ps_reply = con
										.prepareStatement("select * from complaint_unassigned_rel_tbl where complaint_no='"
												+ complaint_no + "'");
								ResultSet rs_reply = ps_reply.executeQuery();

								rs_reply.last();
								int other = rs_reply.getRow();
								rs_reply.beforeFirst();

								if (other > 0) {
									while (rs_reply.next()) {
										unassignId = rs_reply.getInt("unassign_id");
									}
									PreparedStatement ps_unrep = con
											.prepareStatement("select * from complaint_unassigned_reply_tbl where unassign_id="
													+ unassignId +" order by customer_unassigned_reply_id desc");
									ResultSet rs_unrep = ps_unrep.executeQuery();

									rs_unrep.last();
									int un = rs_unrep.getRow();
									rs_unrep.beforeFirst();
									if (un > 0) {
						%>
						<br>
						<span><strong style="font-size: 16px; color: #727502">Customers
									Reply History:</strong></span>
						<div style="width:100%; height:400px; overflow: auto;">
							 <br>
							<%
								while (rs_unrep.next()) {
							%>
							<label style="font-size: 12px"> <%=rs_unrep.getString("reply_content")%>
							</label>
							<hr>

							<%
								}
							%>
						</div>
						<%
							}
								}
						%>

					</div>
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
<HEAD>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<META HTTP-EQUIV="Expires" CONTENT="-1">
</HEAD>
</html>