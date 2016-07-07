<%@page import="com.muthagroup.bo.GetUserName_BO"%>
<%@page import="com.muthagroup.vo.Edit_VO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.muthagroup.bo.Login_BO"%>
<%@page import="com.muthagroup.vo.Login_VO"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="cache-control" content="no-cache" />
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-back");
	if (session.getAttribute("uid") == null)
		response.sendRedirect("login.jsp");
%>

<html>
<head>

<title>Complaint Action</title>
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
<script type="text/javascript" src="tabledeleterow.js"></script>
<script type="text/javascript">

function validateComplaint(){
	var stat = document.getElementById("status");
	var a = document.getElementById("a");
	var b = document.getElementById("b");
 	
	if (stat.value=="1") {
		alert("Please Change Complaint Status !!!");  
		return false;
	}
	if (a.value=="0" || a.value==null || a.value=="" || a.value=="null") {
		alert("Please provide Proper Action Type and PHASE !!!");  
		return false;
	}
	if (b.value=="0" || b.value==null || b.value=="" || b.value=="null") {
		alert("Please provide Action Description! !!!");  
		return false;
	}
	return true;
}


/* function loadSubmit() {

	ProgressImage = document.getElementById('progress_image');
	document.getElementById("progress").style.visibility = 'visible';

	setTimeout("ProgressImage.src = ProgressImage.src", 100);
	return true;

} */
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



<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/style1.css" />
<script src="js/script.js"></script>

<script src="js/jquery.autocomplete.js"></script>
</head>
<body>

	<%
		Edit_VO bean = new Edit_VO();
		GetUserName_BO ubo = new GetUserName_BO();
		int count = 0,depart_id=0;
		String u_name = null, status =null;
		String complaint_no = null;
		complaint_no = request.getParameter("hid");
		System.out.println("complaint_no Edit Complaint :" + complaint_no);
		session.setAttribute("complaint_no", complaint_no);
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		count = Integer.parseInt(session.getAttribute("count").toString());
		String U_Name = ubo.getUserName(uid);
		try {
			Connection con = Connection_Utility.getConnection();
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">

				<li class="v-sep"><a href="#"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a></li>
				<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"><%=count%>
						New Complaints</a></li>
				<!--<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"> All
						Complaints</a></li>-->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>
			</ul>
			<!-- end nav -->

			<%--
			<form action="#" method="POST" id="search-form" class="fr">
				<fieldset>
					<input type="text" id="search-keyword"
						class="round button dark ic-search image-right" /> <input
						type="hidden" value="SUBMIT" />
				</fieldset>
			</form>
 --%>
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

						<h3 class="fl">Action</h3>

					</div>
					<!-- end content-module-heading -->

					<div id="form_container" style="float: left; width: 90%">

						<form class="appnitro" action="Complaint_Action_Controller" name="myForm" id="myForm" method="post" enctype="multipart/form-data" onSubmit="return validateComplaint();">

							<%
								PreparedStatement ps = con
											.prepareStatement("select * from customer_tbl");
									PreparedStatement ps1 = con
											.prepareStatement("select * from customer_tbl_item");
									PreparedStatement ps11 = con
											.prepareStatement("select * from status_tbl");
									PreparedStatement ps2 = con
											.prepareStatement("select * from defect_tbl");
									PreparedStatement ps3 = con
											.prepareStatement("select * from complaint_tbl");
									PreparedStatement ps4 = con
											.prepareStatement("select * from category_tbl");
									PreparedStatement ps5 = con
											.prepareStatement("select * from complaint_tbl where Complaint_No='"
													+ complaint_no + "'");

									ResultSet rs11 = ps11.executeQuery();
									ResultSet rs5 = ps5.executeQuery();
									ResultSet rs4 = ps4.executeQuery();
									ResultSet rs3 = ps3.executeQuery();
									ResultSet rs2 = ps2.executeQuery();
									ResultSet rs1 = ps1.executeQuery();
									ResultSet rs = ps.executeQuery();

									int cust_Id = 0, Item_Id = 0, Defect_Id = 0, Category_Id = 0, assigned = 0, comp_No = 0, status_id = 0;
									String received = null, related = null, discription = null;
									Timestamp CDate = null;
									String cust_name = null, item_name = null, defect = null, category = null, cust_comp = null, unit_name = null;
									int max_Action_Id = 0;

									PreparedStatement ps_MaxActionId = null;

									ps_MaxActionId = con
											.prepareStatement("select max(Action_id) from complaint_tbl_action where Complaint_No='"
													+ complaint_no + "'");

									ResultSet rs_MaxActionId = ps_MaxActionId.executeQuery();

									while (rs_MaxActionId.next()) {
										max_Action_Id = rs_MaxActionId.getInt("max(Action_id)");
									}
									String dept = null;
									PreparedStatement ps_user_dept = con
											.prepareStatement("select department from user_tbl_dept where dept_Id=(select dept_id from user_tbl where u_id="
													+ uid + ")");
									ResultSet rs_user_dept = ps_user_dept.executeQuery();
									while (rs_user_dept.next()) {
										dept = rs_user_dept.getString("department");
									}
									while (rs5.next()) {
										cust_Id = rs5.getInt("Cust_Id");
										//out.println("customer id :" + cust_Id);
										status_id = rs5.getInt("Status_Id");
										Item_Id = rs5.getInt("Item_Id");
										received = rs5.getString("Complaint_Received_By");
										discription = rs5.getString("Complaint_Description");
										related = rs5.getString("Complaint_Related_To");
										Defect_Id = rs5.getInt("Defect_Id");
										assigned = rs5.getInt("Complaint_Assigned_To");
										Category_Id = rs5.getInt("Category_Id");
										CDate = rs5.getTimestamp("Complaint_Date");
										comp_No = rs5.getInt("Company_Id");

										PreparedStatement ps7 = con
												.prepareStatement("select Cust_Name from customer_tbl where Cust_Id="
														+ cust_Id);
										PreparedStatement ps8 = con
												.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
														+ Item_Id);
										PreparedStatement ps9 = con
												.prepareStatement("select Defect_Type from defect_tbl where Defect_Id="
														+ Defect_Id);
										PreparedStatement ps10 = con
												.prepareStatement("select Category from category_tbl where Category_Id="
														+ Category_Id);
										PreparedStatement ps_act = con
												.prepareStatement("select * from user_tbl_company where Company_Id='"
														+ comp_No + "'");

										ResultSet rs_act = ps_act.executeQuery();

										while (rs_act.next()) {
											cust_comp = rs_act.getString("Company_Name");

										}
										ResultSet rs7 = ps7.executeQuery();
										while (rs7.next()) {
											cust_name = rs7.getString("Cust_Name");
										}
										ResultSet rs8 = ps8.executeQuery();
										while (rs8.next()) {
											item_name = rs8.getString("Item_Name");
										}
										ResultSet rs9 = ps9.executeQuery();
										while (rs9.next()) {
											defect = rs9.getString("Defect_Type");
										}
										ResultSet rs10 = ps10.executeQuery();
										while (rs10.next()) {
											category = rs10.getString("Category");
										}
									}
 	

									ArrayList arr_uid = new ArrayList();

									boolean flag = false;
									int user_comp = 0;
									PreparedStatement ps_u_name = con.prepareStatement("Select U_Name,Dept_Id,Company_Id from user_tbl where u_id=" + uid);

									ResultSet rs_u_name = ps_u_name.executeQuery();

									while (rs_u_name.next()) {
										u_name = rs_u_name.getString("U_Name");
										depart_id = rs_u_name.getInt("Dept_Id"); 
										user_comp = rs_u_name.getInt("Company_Id");
									}
									 
									
									PreparedStatement ps_u_id = con.prepareStatement("Select U_Id from user_tbl where U_Name='"+ u_name + "'");

									ResultSet rs_u_id = ps_u_id.executeQuery();

									while (rs_u_id.next()) {
										arr_uid.add(rs_u_id.getInt("U_Id"));
										System.out.println("original user id is :" + uid);
										System.out.println("user has id like :" + rs_u_id.getInt("U_Id"));
									}

									for (int i = 0; i < arr_uid.size(); i++) {
										if (Integer.parseInt(arr_uid.get(i).toString()) == assigned) {
											flag = true;
										}
									}

									if (flag == true) {
							%>
							<ul>
								<li id="li_5"><label class="description" for="element_5">Complaint No : <%=session.getAttribute("complaint_no")%></label></li>

								<li id="li_5"><label class="description" for="element_5">Company NAME </label>
									<div>
										<input type="text" name="" value="<%=cust_comp%>" disabled="disabled" size="80"> <input type="hidden" name="company_name" value="<%=cust_comp%>">
									</div> <input type="hidden" name="complaint_no" value="<%=complaint_no%>"></li>



								<li id="li_5"><label class="description" for="element_5">CUSTOMER
										NAME </label>
									<div>

										<input type="text" name="" value="<%=cust_name%>"
											disabled="disabled" size="80"> <input type="hidden"
											name="cust_name" value="<%=cust_name%>">

									</div></li>



								<li id="li_6"><label class="description" for="element_6">ITEM
										NAME</label>
									<div>
										<input type="text" name="" value="<%=item_name%>"
											disabled="disabled" size="80"> <input type="hidden"
											name="item_name" value="<%=item_name%>">
									</div></li>
















								<li id="li_1"><label class="description" for="element_1">COMPLAINT
										DESCRIPTION </label>
									<div>
										<textarea id="element_1" class="element textarea medium"
											readonly="readonly" cols="50" rows="5"><%=discription%></textarea>
										<input type="hidden" name="description"
											value="<%=discription%>">
									</div></li>



								<%--	<li id="li_2"><label class="description" for="element_2">COMPLAINT
										RELATED TO </label>
									<div>
										<input id="element_2" name="related"
											class="element text medium" type="text" maxlength="255"
											value="<%=related%>" disabled="disabled" />
									</div></li>
									--%>

								<li id="li_8"><label class="description" for="element_8">DEFECT
								</label>
									<div>

										<input type="text" value="<%=defect%>" disabled="disabled"
											size="80"> <input type="hidden" name="defect"
											value="<%=defect%>">
									</div></li>



								<li id="li_1"><label class="description" for="element_1">Action
										Performed</label>
									<div>

										<table style="font-size: small; width: 700px;">

											<%
												PreparedStatement PS_AP = con
																.prepareStatement("select * from complaint_tbl_action where Complaint_No='"
																		+ complaint_no + "'");
														ResultSet rs_AP = PS_AP.executeQuery();
											%>
											<tr align="center">
												<td  style="width: 200px;"><strong>Phase Name</strong></td>
												<td  style="width: 200px;"><strong>Action Type</strong></td>
												<td  style="width: 400px;"><strong> Description</strong></td>
												<td><strong></strong></td>
											</tr>
											<%
												while (rs_AP.next()) {
											%>
											<tr align="center">
												<%
													PreparedStatement ps_phase = con
																		.prepareStatement("select phase_name from Complaint_Tbl_Phase where phase_Id="
																				+ rs_AP.getInt("Phase_Id"));
																ResultSet rs_phase = ps_phase.executeQuery();
																while (rs_phase.next()) {
																	if (rs_phase.getString("Phase_Name").equals("")) {
												%>
												<td></td>
												<%
													} else {
												%>
												<td><%=rs_phase.getString("Phase_Name")%></td>
												<%
													}
																}
												%>

												<td><%=rs_AP.getString("Action_Type")%></td>
												<td style="font-size: 13px;"><%=rs_AP.getString("Action_Discription")%></td>
												<td><a
													href="Edit_Action.jsp?a_id=<%=rs_AP.getInt("Action_Id")%>">Edit</a></td>
												<%
													//max_Action_Id = rs_AP.getInt("Action_Id");
															}
												%>

											</tr>
										</table>


									</div></li>




								<%
									if ((U_Name.equalsIgnoreCase("Shirish koli") || depart_id==6) && (user_comp==comp_No)) {
								%>
								<li id="li_6"><label class="description" for="element_6">STATUS
								</label>
									<div>
										<select class="element select medium" id="status" name="status">
											<%
												PreparedStatement ps13 = con
																	.prepareStatement("select * from status_tbl where Status_Id="
																			+ status_id);
															ResultSet rs13 = ps13.executeQuery();
															while (rs13.next()) {
																status = rs13.getString("Status");
											%>
											<option value="<%=status_id%>"><%=status%></option>

											<%
												}
											%>
											<option value="2">Open</option>
											<option value="3">Resolved</option>
											<option value="4">Reopen</option>
											<option value="5">Close</option>
										</select>
									</div></li>
								<%
									} else {
								%>
								<li id="li_6"><label class="description" for="element_6">STATUS
								</label>
									<div>
										<select class="element select medium" id="status"
											name="status">
											<%
												PreparedStatement ps13 = con
																	.prepareStatement("select * from status_tbl where Status_Id="
																			+ status_id);
															ResultSet rs13 = ps13.executeQuery();
															while (rs13.next()) {
																status = rs13.getString("Status");
											%>
											<option value="<%=status_id%>"><%=status%></option>

											<%
												}
											%>
											<option value="2">Open</option>
											<option value="3">Resolved</option>

										</select>
									</div></li>
								<%
									}
								%>





								<li id="li_8"><label class="description" for="element_8">CHOOSE
										PHASE </label> <%
 	PreparedStatement ps_selectedPhase = con
 					.prepareStatement("select phase_id from complaint_tbl_action where Action_Id="
 							+ max_Action_Id);
 			int phase_id = 0;
 			ResultSet rs_selectedPhase = ps_selectedPhase
 					.executeQuery();
 			while (rs_selectedPhase.next()) {
 				phase_id = rs_selectedPhase.getInt("Phase_Id");
 			}
 %>
									<div>
										<table>
											<%
												if (phase_id == 0) {
											%>
											<tr>

												<td><input type="radio" value="1" name="phase_id"></td>
												<td><label>Phase 1 (Root Cause Analysis)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="2" name="phase_id"></td>
												<td><label>Phase 2 (Action Planning)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="3" name="phase_id"></td>
												<td><label>Phase 3 (Implementation)</label></td>
											</tr>
											<%
												} else if (phase_id == 1) {
											%>
											<tr>

												<td><input type="radio" value="1" name="phase_id"
													checked="checked"></td>
												<td><label>Phase 1 (Root Cause Analysis)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="2" name="phase_id"></td>
												<td><label>Phase 2 (Action Planning)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="3" name="phase_id"></td>
												<td><label>Phase 3 (Implementation)</label></td>
											</tr>
											<%
												} else if (phase_id == 2) {
											%>
											<tr>

												<td><input type="radio" value="1" name="phase_id"></td>
												<td><label>Phase 1 (Root Cause Analysis)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="2" name="phase_id"
													checked="checked"></td>
												<td><label>Phase 2 (Action Planning)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="3" name="phase_id"></td>
												<td><label>Phase 3 (Implementation)</label></td>
											</tr>
											<%
												} else if (phase_id == 3) {
											%>
											<tr>

												<td><input type="radio" value="1" name="phase_id"></td>
												<td><label>Phase 1 (Root Cause Analysis)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="2" name="phase_id"></td>
												<td><label>Phase 2 (Action Planning)</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="3" name="phase_id"
													checked="checked"></td>
												<td><label>Phase 3 (Implementation)</label></td>
											</tr>
											<%
												}
											%>

										</table>

									</div></li>
								<li id="li_10"><label class="description" for="element_10">Action
										Type</label>
									<div>
										<input type="text" id="a" name="a_type" size="45"
											title="Maximum 45 Characters" />
									</div></li>



								<li id="li_1"><label class="description" for="element_1">Action
										Description</label>
									<div>
										<textarea id="b" name="action_description" cols="50" rows="5"
											class="element textarea medium"></textarea>
									</div></li>

								<li id="li_4" class="buttons"><label class="description"
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
											<table>
												<tr style="text-align: left;">
													<td style="width: 400px;"><strong> FILE NAME</strong></td>
													<td><strong> DELETE</strong></td>
												</tr>

												<%
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
												%>
												<tr>
													<td><a
														href="Display.jsp?field=<%=rs_file.getString("File_Name")%>">
															<%=rs_file.getString("File_Name")%></a></td>
													<td><input type="button" value="   Delete    " onClick="showState(<%=rs_file.getInt("Attach_Id")%>)"></td>
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
																	PreparedStatement ps_unassign=con.prepareStatement("select * from complaint_tbl_unassigned_attachment where unassign_Id="+rs_un.getInt("unassign_Id"));
																	ResultSet rs_unassign=ps_unassign.executeQuery();
																	while(rs_unassign.next()){
																		%>
												<tr>
													<td>
													 <a href="ViewCustAttachment.jsp?field=<%=rs_unassign.getInt("Unasigned_Attach_id")%>"><%=rs_unassign.getString("File_Name") %></a>
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

								<li>
								<a href="Home.jsp"><strong style="font-size: large;">&#8656;Back</strong></a>
								<input  type="submit" name="submit" style="width:200px;height:40px; font-size: 15px;font-family: Arial;background-color: #9191C2"  value="SUBMIT" /> </li>
							</ul>
							<%
								} else {
							%>
							<ul>
								<li id="li_5"><label class="description" for="element_5">Complaint
										No : <%=session.getAttribute("complaint_no")%></label></li>

								<li id="li_5"><label class="description" for="element_5">Company
										NAME </label>
									<div>
										<input type="text" name="" value="<%=cust_comp%>"
											readonly="readonly" size="80"> <input type="hidden"
											name="company_name" value="<%=cust_comp%>">

									</div> <input type="hidden" name="complaint_no"
									value="<%=complaint_no%>"></li>



								<li id="li_5"><label class="description" for="element_5">CUSTOMER
										NAME </label>
									<div>

										<input type="text" name="" value="<%=cust_name%>"
											readonly="readonly" size="80"> <input type="hidden"
											name="cust_name" value="<%=cust_name%>">



										<!-- ****************************************************************************************************************************** -->

										<input type="hidden" name="a_type" value=""> <input
											type="hidden" name="action_description" value="">
										<!-- ****************************************************************************************************************************** -->


									</div></li>
								<!-- <input type="hidden" name="a_type" value="" />
								<input type="hidden" name="action_description" value="" /> -->



								<li id="li_6"><label class="description" for="element_6">ITEM
										NAME</label>
									<div>
										<input type="text" name="" value="<%=item_name%>"
											readonly="readonly" size="80"> <input type="hidden"
											name="item_name" value="<%=item_name%>">
									</div></li>

								<li id="li_1"><label class="description" for="element_1">COMPLAINT
										DESCRIPTION </label>
									<div>
										<textarea id="element_1" name="description" cols="50"
											rows="5" class="element textarea medium" readonly="readonly"><%=discription%></textarea>

									</div></li>



								<%--	<li id="li_2"><label class="description" for="element_2">COMPLAINT
										RELATED TO </label>
									<div>
										<input id="element_2" name="related"
											class="element text medium" type="text" maxlength="255"
											value="<%=related%>" disabled="disabled" />
									</div></li>
									--%>
								<li id="li_8"><label class="description" for="element_8">DEFECT
								</label>
									<div>

										<input type="text" name="" value="<%=defect%>"
											readonly="readonly" size="80"> <input type="hidden"
											name="defect" value="<%=defect%>">
									</div></li>



								<li id="li_1"><label class="description" for="element_1">Action
										Performed</label>
									<div>

										<table style="font-size: small; width: 700px;">

											<%
												PreparedStatement PS_AP = con
																.prepareStatement("select * from complaint_tbl_action where Complaint_No='"
																		+ complaint_no + "'");
														ResultSet rs_AP = PS_AP.executeQuery();
											%>
											<tr align="justify">
												<td style="width: 200px;"><strong>Phase Name</strong></td>
												<td style="width: 200px;"><strong>Action Type</strong></td>
												<td  style="width: 400px;"><strong> Description</strong></td>
											</tr>
											<%
												while (rs_AP.next()) {
											%>
											<tr align="justify">
												<%
													PreparedStatement ps_phase = con
																		.prepareStatement("select phase_name from Complaint_Tbl_Phase where phase_Id="
																				+ rs_AP.getInt("Phase_Id"));
																ResultSet rs_phase = ps_phase.executeQuery();
																while (rs_phase.next()) {
																	if (rs_phase.getString("Phase_Name").equals("")) {
												%>
												<td></td>
												<%
													} else {
												%>
												<td><%=rs_phase.getString("Phase_Name")%></td>
												<%
													}
																}
												%>
												<td><%=rs_AP.getString("Action_Type")%></td>
												<td style="font-size: 13px;"><%=rs_AP.getString("Action_Discription")%></td>

												<%
													}
												%>

											</tr>
										</table>

										<%
										if ((U_Name.equalsIgnoreCase("Shirish koli") || depart_id==6) && (user_comp==comp_No)) {
										%>

									</div></li>




								<%
								if ((U_Name.equalsIgnoreCase("Shirish koli") || depart_id==6) && (user_comp==comp_No)) {
								%>
								<li id="li_6"><label class="description" for="element_6">STATUS
								</label>
									<div>
										<select class="element select medium" id="status"
											name="status">
											<%
												PreparedStatement ps13 = con
																		.prepareStatement("select * from status_tbl where Status_Id="
																				+ status_id);
																ResultSet rs13 = ps13.executeQuery();
																while (rs13.next()) {
																	status = rs13.getString("Status");
											%>
											<option value="<%=status_id%>"><%=status%></option>

											<%
												}
											%>
											<option value="2">Open</option>
											<option value="3">Resolved</option>
											<option value="4">Reopen</option>
											<option value="5">Close</option>
										</select>

									</div></li>
								<%
									} else {
								%>
								<li id="li_6"><label class="description" for="element_6">STATUS
								</label>
									<div>
										<select class="element select medium" readonly="readonly"
											id="status" name="status">
											<%
												PreparedStatement ps13 = con
																		.prepareStatement("select * from status_tbl where Status_Id="
																				+ status_id);
																ResultSet rs13 = ps13.executeQuery();
																while (rs13.next()) {
																	status = rs13.getString("Status");
											%>
											<option value="<%=status_id%>"><%=status%></option>

											<%
												}
											%>

										</select>

									</div></li>



								<%
									}
								%>



								<div>
									<li id="li_8"><label class="description" for="element_8">CHOOSE
											PHASE </label> <%
 	PreparedStatement ps_selectedPhase = con
 						.prepareStatement("select phase_id from complaint_tbl_action where Action_Id="
 								+ max_Action_Id);
 				int phase_id = 0;
 				ResultSet rs_selectedPhase = ps_selectedPhase
 						.executeQuery();
 				while (rs_selectedPhase.next()) {
 					phase_id = rs_selectedPhase.getInt("Phase_Id");
 				}
 %>
										<div>
											<table>
												<%
													if (phase_id == 0) {
												%>
												<tr>

													<td><input type="radio" value="1" name="phase_id"></td>
													<td><label>Phase 1 (Root Cause Analysis)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="2" name="phase_id"></td>
													<td><label>Phase 2 (Action Planning)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="3" name="phase_id"></td>
													<td><label>Phase 3 (Implementation)</label></td>
												</tr>
												<%
													} else if (phase_id == 1) {
												%>
												<tr>

													<td><input type="radio" value="1" name="phase_id"
														checked="checked"></td>
													<td><label>Phase 1 (Root Cause Analysis)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="2" name="phase_id"></td>
													<td><label>Phase 2 (Action Planning)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="3" name="phase_id"></td>
													<td><label>Phase 3 (Implementation)</label></td>
												</tr>
												<%
													} else if (phase_id == 2) {
												%>
												<tr>

													<td><input type="radio" value="1" name="phase_id"></td>
													<td><label>Phase 1 (Root Cause Analysis)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="2" name="phase_id"
														checked="checked"></td>
													<td><label>Phase 2 (Action Planning)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="3" name="phase_id"></td>
													<td><label>Phase 3 (Implementation)</label></td>
												</tr>
												<%
													} else if (phase_id == 3) {
												%>
												<tr>

													<td><input type="radio" value="1" name="phase_id"></td>
													<td><label>Phase 1 (Root Cause Analysis)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="2" name="phase_id"></td>
													<td><label>Phase 2 (Action Planning)</label></td>
												</tr>
												<tr>
													<td><input type="radio" value="3" name="phase_id"
														checked="checked"></td>
													<td><label>Phase 3 (Implementation)</label></td>
												</tr>
												<%
													}
												%>

											</table>

										</div></li>
									<li id="li_10"><label class="description" for="element_10">Action
											Type</label>
										<div>
											<input type="text" id="a" name="a_type" size="45"
												title="Maximum 45 Characters" />
										</div></li>



									<li id="li_1"><label class="description" for="element_1">Action
											Description</label>
										<div>
											<textarea id="b" name="action_description" cols="50"
												rows="5" class="element textarea medium"></textarea>
										</div></li>

								</div>

								<%
									}
								%>
								<%--	<li><input type="hidden" name="a_type" value="null"></li>
								<li><input type="hidden" name="action_description" value="null"></li> --%>
								<li id="li_4" class="buttons"><label class="description"
									for="element_4"> </label>
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
											<table>
												<tr>
													<td align="center"><strong>FILE NAME</strong></td>

												</tr>

												<%
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
												%>
												<tr>
													<td><a
														href="Display.jsp?field=<%=rs_file.getString("File_Name")%>">
															<%=rs_file.getString("File_Name")%></a></td>

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
																	PreparedStatement ps_unassign=con.prepareStatement("select * from complaint_tbl_unassigned_attachment where unassign_Id="+rs_un.getInt("unassign_Id"));
																	ResultSet rs_unassign=ps_unassign.executeQuery();
																	while(rs_unassign.next()){
																		%>
												<tr>
													<td>
													 <a href="ViewCustAttachment.jsp?field=<%=rs_unassign.getInt("Unasigned_Attach_id")%>"><%=rs_unassign.getString("File_Name") %></a>
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
								<%
								if ((U_Name.equalsIgnoreCase("Shirish koli") || depart_id==6) && (user_comp==comp_No)) {
								%>
								<li>
								<a href="Home.jsp"><strong style="font-size: large;">&#8656;Back</strong></a>
								<input type="submit" name="submit" style="width:200px;height:40px; font-size: 15px;font-family: Arial;background-color: #9191C2"  value="SUBMIT" /> </li>

								<%
									} else {
								%>
								<li><a href="Home.jsp"><strong
										style="font-size: large;">&#8656;Back</strong></a></li>
							</ul>
							<%
								}
									}

							
							%>
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
<script>
	jQuery(function() {
		$("#a_type").autocomplete("auto_Action.jsp");
	});
	jQuery(function() {
		$("#a").autocomplete("auto_Action.jsp");
	});
</script>
</html>