<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="com.muthagroup.bo.Login_BO"%>
<%@page import="com.muthagroup.vo.Login_VO"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<html>
<head>

<title>Register unassigned Complaint</title>

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
<script type="text/javascript" src="tabledeleterow.js"></script>
<script language="JavaScript" src="gen_validatorv4.js"
	type="text/javascript" xml:space="preserve"></script>


<!-- Stylesheets -->
<link rel="stylesheet" href="css/style.css">

<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery & JS files -->

<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript" src="js/view.js"></script>

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/style1.css" />



<script src="js/jquery.autocomplete.js"></script>
<script src="js/script.js"></script>
<script type="text/javascript">
	function validateForm() {
		var x = document.getElementById('defect_name');
		if (x > 5) {
			alert("Invalid Defect !!!!!");
			return false;
		}
	}
</script>
<!-- 
//******************************************************************************************************************************

						AJAX Code to fetch customer name and Item name

//******************************************************************************************************************************
-->


<script type="text/javascript">
	function loadSubmit() {
		ProgressImage = document.getElementById('progress_image');
		document.getElementById("progress").style.visibility = 'visible';
		setTimeout("ProgressImage.src = ProgressImage.src", 100);

		return true;
	};

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
				document.getElementById("item").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Item_Name.jsp?q=" + str, true);
		xmlhttp.send();
	};

	function showState2(str1) {
		var xmlhttp;
		var xmlhttp1;

		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				document.getElementById("user").innerHTML = xmlhttp.responseText;

			}

		};

		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp1 = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp1.onreadystatechange = function() {
			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {

				document.getElementById("cust").innerHTML = xmlhttp1.responseText;
			}

		};

		xmlhttp.open("POST", "Assigned_To.jsp?p=" + str1, true);

		xmlhttp1.open("POST", "Customer_Name.jsp?p=" + str1, true);

		xmlhttp.send();

		xmlhttp1.send();
	};

	//********************************************************************************************************************************
</script>


<script language="javascript" type="text/javascript"
	src="datetimepicker.js"></script>










</head>
<body>
	<%@ page import="com.muthagroup.bo.GetUserName_BO"%>

	<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>

	<%
		//******************************************************************************************************************************

		// To Count New Complaints

		//******************************************************************************************************************************
		GetUserName_BO ubo = new GetUserName_BO();
		int count = 0;
		String complaint_no = null;
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		int un_ass = Integer.parseInt(request.getParameter("hid"));
		String U_Name = ubo.getUserName(uid);

		try {
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps6 = con
					.prepareStatement("select count(Status_Id) from complaint_tbl where Status_Id=1");
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Status_Id)");
				session.setAttribute("count", count);
			}

			//******************************************************************************************************************************
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">

				<li class="v-sep"><a href="Marketing_Home.jsp"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a></li>

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

			<!-- 
			<form action="#" method="POST" id="search-form" class="fr">
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

				<h3>Content</h3>
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

						<h3 class="fl">Register unassigned Complaint</h3>

					</div>
					<!-- end content-module-heading -->



					<div id="form_container">

						<!-- 

						************************ REGISTRATION FORM *************************************

						-->

						<form class="appnitro" method="post" action="Register_Controller"
							name="Register_Complaint" id="Register_Complaint"
							enctype="multipart/form-data" onsubmit="return validateForm()">


							<%
								System.out.println("This is no " + request.getParameter("hid"));
									int no = Integer.parseInt(request.getParameter("hid"));
							%>
							<input type="hidden" name="unregistered" id="unregistered"
								value="<%=no%>">

							<%
								//************************************************************************************************************

									// To Populate drop down parameters from database

									//************************************************************************************************************
									PreparedStatement ps = con
											.prepareStatement("select * from customer_tbl order by Cust_name");
									PreparedStatement ps1 = con
											.prepareStatement("select * from customer_tbl_item order by Item_name");

									//PreparedStatement ps3 = con.prepareStatement("select * from user_tbl where enable_id=1");
									PreparedStatement ps4 = con
											.prepareStatement("select * from category_tbl order by Category");
									

									ResultSet rs4 = ps4.executeQuery();
									//ResultSet rs3 = ps3.executeQuery();

									ResultSet rs1 = ps1.executeQuery();
									ResultSet rs = ps.executeQuery();

									PreparedStatement ps_pr = con
											.prepareStatement("select * from Severity_tbl order by p_type");
									ResultSet rs_pr = ps_pr.executeQuery();

									//****************************************************************************************************************
							%>
							<ul>


								<li id="li_5"><label class="description" for="element_5">COMPANY
										NAME </label>
									<div>

										<select class="element select medium" id="element_5"
											name="cust_company_name" onchange="showState2(this.value)">
										
									
											<%
											int comp=0;
											PreparedStatement ps_unassign_Comp = con.prepareStatement("select * from complaint_tbl_unassigned where unassign_id="+ un_ass);
											ResultSet rs_unassign_comp=ps_unassign_Comp.executeQuery();
										while(rs_unassign_comp.next()){
											comp=rs_unassign_comp.getInt("Company_Id");
											PreparedStatement pscomp=con.prepareStatement("select * from user_tbl_company where company_id="+comp);
											ResultSet rsComp=pscomp.executeQuery();
											while(rsComp.next()){
										%>
											<option value="<%=rsComp.getInt("Company_Id")%>"><%=rsComp.getString("Company_Name")%></option>
										<%
											}
										}
										PreparedStatement ps_ucomp = con.prepareStatement("select * from user_tbl_company where company_id NOT IN (6,"+comp+")order by Company_Name");

										ResultSet rs_ucomp = ps_ucomp.executeQuery();
												while (rs_ucomp.next()) {
											%>
											<option value="<%=rs_ucomp.getInt("Company_Id")%>"><%=rs_ucomp.getString("Company_Name")%></option>
											<%
												}
											%>
										</select>
									</div></li>



								<li id="li_5"><label class="description" for="element_5">CUSTOMER
										NAME </label>
									<div id="cust">
										<select class="element select medium" id="element_5"
											name="cust_name" onchange="showState(this.value)">
											<option value="">-------SELECT-------</option>

										</select>
									</div></li>

								<li id="li_6"><label class="description" for="element_6">Component
										NAME</label>
									<div id="item">
										<select class="element select medium" id="element_6"
											name="item_name">
											<option value="">-------SELECT-------</option>

										</select>
									</div></li>
								<li id="li_7"><label class="description" for="element_7">COMPLAINT
										RECEIVED BY </label>
									<div>
										<select class="element select medium" id="element_7"
											name="received">
											<option value="">--------SELECT--------</option>
											<option value="Telephone">Telephone</option>
											<option value="Email">Email</option>
											<option value="Written">Written</option>
											<option value="Other">Other</option>
										</select>
									</div></li>

								<li id="li_1"><label class="description" for="element_1">Severity</label>
									<div>
										<select class="element select medium" id="element_6"
											name="severity">
											<option value="">--------SELECT-------</option>
											<%
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
											<option value="">----------SELECT----------</option>
											<%
												while (rs4.next()) {
											%>
											<option value="<%=rs4.getInt("Category_Id")%>"><%=rs4.getString("Category")%></option>
											<%
												}
											%>
										</select>
									</div></li>

								<li id="li_8"><label class="description" for="element_8">DEFECT
								</label>
									<div>
										<input type="text" id="defect_name" name="defect_name"
											size="50" title="Maximum 50 Characters" />
									</div></li>
								<li id="li_1"><label class="description" for="element_1">COMPLAINT
										DESCRIPTION </label> <%
 	

 		System.out.println("out of the loop Unassigned id... : "
 				+ un_ass);

 		System.out.println("Unassigned id... : " + un_ass);
 		PreparedStatement ps_unassign_desc = con
 				.prepareStatement("select Mail_Content from complaint_tbl_unassigned where unassign_id="
 						+ un_ass);
 		ResultSet rs_unassign_desc = ps_unassign_desc.executeQuery();
 		while (rs_unassign_desc.next()) {
 %>
									<div>
										<textarea id="description" name="description" cols="60"
											rows="20"><%=rs_unassign_desc.getString("Mail_Content")%></textarea>
									</div> <%
 	}
 %></li>

								<li id="li_2"><label class="description" for="element_2">COMPLAINT
										RELATED TO </label>
									<div id="dept">
										<select class="element select medium" id="element_8"
											name="related">
											<option value="">-------SELECT--------</option>
											<%
												//*************************************Select the department**************************** 

													PreparedStatement ps_dept = con
															.prepareStatement("select * from user_tbl_dept order by department");
													ResultSet rs_dept = ps_dept.executeQuery();
													while (rs_dept.next()) {
											%>
											<option value="<%=rs_dept.getString("Dept_Id")%>"><%=rs_dept.getString("Department")%></option>
											<%
												}

													//*****************************************************************************************
											%>
										</select>
									</div></li>

								<li id="li_9"><label class="description" for="element_9">COMPLAINT
										ASSIGNED TO </label>
									<div id="user">
										<select class="element select medium" id="element_9"
											name="assigned">
											<option value="">-------SELECT-------</option>
											<%
												//while (rs3.next()) {
											%>
											<option value=""></option>
											<%
												//}
											%>
										</select>
									</div></li>

								<%
									int un_ass1 = 0;
										un_ass1 = Integer.parseInt(request.getParameter("hid"));

										System.out.println("out of the loop Unassigned id... : "
												+ un_ass1);

										System.out.println("Unassigned id... : " + un_ass1);
										PreparedStatement ps_unassign_desc1 = con
												.prepareStatement("select * from complaint_tbl_unassigned where unassign_id="
														+ un_ass1);
										ResultSet rs_unassign_desc1 = ps_unassign_desc1.executeQuery();
								%>



								<li id="li_3"><label class="description" for="element_3">COMPLAINT
										Date </label>
									<div>
										<%
											while (rs_unassign_desc1.next()) {
													Timestamp timestamp = rs_unassign_desc1
															.getTimestamp("Mail_Received_Date");
													java.util.Date utilDate = new java.util.Date(
															timestamp.getTime());
													DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
													String result = df.format(utilDate);
													System.out.println("Input date ====  " + result);
										%>
										<input type="text" name="complaint_date" value="<%=result%>"
											readonly="readonly">
										<%
											}
										%>

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

										</div>
									</div></li>




								<li id="li_4" class="buttons"><label class="description"
									for="element_4">Files Attached</label>
									<div>
										<div>

											<table>


												<%
													/****************************************************************************************************************
																																																																																															
																																																																																																			TO SELECT ATTACHMENTS RELATED TO COMPLAINT NUMBER 							
																																																																																															
														 ****************************************************************************************************************/
														PreparedStatement ps_file = con
																.prepareStatement("select * from complaint_tbl_unassigned_attachment where unassign_Id like "
																		+ no + " and  Delete_Status=1");
														ResultSet rs_file = ps_file.executeQuery();
														while (rs_file.next()) {

															//****************************************************************************************************************
												%>
												<tr>


													<!--  									
												****************************************************************************************************************
																		
																		TO Display/Delete files attached for complaint number
												
												****************************************************************************************************************
													-->
													<td style="font-size: 15px;" align="left"><a
														href="DisplayIncoming.jsp?field=<%=rs_file.getString("File_Name")%>">
															<%=rs_file.getString("File_Name")%></a></td>
													<td></td>
													<td></td>

													<!-- 
												
										***********************************************************************************************************************
												
												 -->
												</tr>
												<%
													}
												%>
											</table>









										</div>
									</div></li>







								<li class="buttons"><input
									style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;"
									type="submit" name="submit" onclick="loadSubmit()"
									value="REGISTER" /></li>
							</ul>
							<!-- 
						
						************************************************************************************************************
						
						 -->
							<br>
							<p align="left" style="visibility: hidden;" id="progress">
								<strong style="color: gray;">Wait uploading in
									progress.........</strong><br> <img id="progress_image"
									style="padding-left: 5px; padding-top: 5px;" alt=""
									src="images/ajax-loader.gif">


							</p>



							<!-- 
						
						************************************************************************************************************
						
						 -->




							<%
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
						</form>





						<!--  
		//********************************************************************************************************
		
		//Form Validation Script
		
		//********************************************************************************************************
		-->
						<script language="JavaScript" type="text/javascript"
							xml:space="preserve">
							var frmvalidator = new Validator(
									"Register_Complaint");

							frmvalidator.addValidation("cust_company_name",
									"req", "Please select your Company");

							frmvalidator.addValidation("cust_name", "req",
									"Please select customer");

							frmvalidator.addValidation("item_name", "req",
									"Please select Component");

							frmvalidator.addValidation("received", "req",
									"Complaint received by ??????");

							frmvalidator.addValidation("severity", "req",
									"Severity ??????");

							frmvalidator.addValidation("category", "req",
									"Category ????");

							frmvalidator.addValidation("defect_name", "req",
									"defect ????");

							frmvalidator.addValidation("description", "req",
									"Comaplaint description ????");

							frmvalidator.addValidation("related", "req",
									"Complaint Related to ??????");

							frmvalidator.addValidation("assigned", "req",
									"Complaint Assigned to ?????");

							frmvalidator.addValidation("Complaint_Month",
									"req", "Date ????");
						</script>
						<!--  
		//*****************************************************************************************************
-->

					</div>

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

<!-- 
// ****************************************************************************************************
			SCRIPT TO AUTOCOMPLETE DEFECT
// ****************************************************************************************************
 -->

<script>
	jQuery(function() {
		$("#defect_name").autocomplete("auto_defect.jsp");
	});
</script>
<!-- ************************************************************************************************************************* -->
<script language="Javascript" type="text/javascript">
	$("#hh").css("height", "200px").css("width", "380px").htmlbox({
		toolbars : [ [
		// Cut, Copy, Paste
		"separator", "cut", "copy", "paste",
		// Undo, Redo
		"separator", "undo", "redo",
		// Bold, Italic, Underline, Strikethrough, Sup, Sub
		"separator", "bold", "italic", "underline", "strike", "sup", "sub",
		// Left, Right, Center, Justify
		"separator", "justify", "left", "center", "right", ] ],
		skin : "blue"
	});
</script>
<!-- ************************************************************************************************************************* -->

<HEAD>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<META HTTP-EQUIV="Expires" CONTENT="-1">
</HEAD>
</html>