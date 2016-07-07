<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<html>
<head>
<!--======================== Design Script ============================-->
<!--============================================================================-->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ECN Approve Request</title>
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}

	//--============================================================================-->
	//-------------- AJAX to get itm name ---------------------------------------- 
	//-============================================================================-->
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
				var a = null;
				document.getElementById("item").innerHTML = xmlhttp.responseText;
				//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

			}
		};
		xmlhttp.open("GET", "Item_Name.jsp?q=" + str, true);
		xmlhttp.send();
	};
</script>

<link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ddsmoothmenu.js">
	
</script>
<script type="text/javascript">
	function validate() {

		if (document.myForm.remark.value == ""
				|| document.myForm.remark.value == null
				|| document.myForm.remark.value == "null") {
			alert("Please provide Remark!");
			document.myForm.remark.focus();
			return false;
		}
		return (true);
	}
</script>

<script type="text/javascript">
	ddsmoothmenu.init({
		mainmenuid : "templatemo_menu", //menu DIV id
		orientation : 'h', //Horizontal or vertical menu: Set to "h" or "v"
		classname : 'ddsmoothmenu', //class added to menu's outer DIV
		//customtheme: ["#1c5a80", "#18374a"],
		contentsource : "markup" //"markup" or ["container_id", "path_to_menu_file"]
	});
</script>

<!--////// CHOOSE ONE OF THE 3 PIROBOX STYLES  \\\\\\\-->
<link href="css_pirobox/white/style.css" media="screen" title="shadow"
	rel="stylesheet" type="text/css" />
<!--<link href="css_pirobox/white/style.css" media="screen" title="white" rel="stylesheet" type="text/css" />
<link href="css_pirobox/black/style.css" media="screen" title="black" rel="stylesheet" type="text/css" />-->
<!--////// END  \\\\\\\-->

<!--////// INCLUDE THE JS AND PIROBOX OPTION IN YOUR HEADER  \\\\\\\-->
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/piroBox.1_2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$().piroBox({
			my_speed : 600, //animation speed
			bg_alpha : 0.5, //background opacity
			radius : 4, //caption rounded corner
			scrollImage : false, // true == image follows the page, false == image remains in the same open position
			pirobox_next : 'piro_next', // Nav buttons -> piro_next == inside piroBox , piro_next_out == outside piroBox
			pirobox_prev : 'piro_prev',// Nav buttons -> piro_prev == inside piroBox , piro_prev_out == outside piroBox
			close_all : '.piro_close',// add class .piro_overlay(with comma)if you want overlay click close piroBox
			slideShow : 'slideshow', // just delete slideshow between '' if you don't want it.
			slideSpeed : 4
		//slideshow duration in seconds(3 to 6 Recommended)
		});
	});
</script>
<!--////// END  \\\\\\\-->
<script type="text/javascript">
	function ClearList(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function move(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('change_name');
			attribute2 = document.getElementById('change_selected');
		} else {
			attribute2 = document.getElementById('change_name');
			attribute1 = document.getElementById('change_selected');
		}

		//fill an array with old values
		for ( var i = 0; i < attribute2.length; i++) {
			temp1[current1++] = attribute2.options[i].value;
		}

		//assign new values to arrays
		for ( var i = 0; i < attribute1.length; i++) {
			if (attribute1.options[i].selected) {
				temp1[current1++] = attribute1.options[i].value;
			} else {
				temp2[current2++] = attribute1.options[i].value;
			}
		}

		//generating new options 
		for ( var i = 0; i < temp1.length; i++) {
			attribute2.options[i] = new Option();
			attribute2.options[i].value = temp1[i];
			attribute2.options[i].text = temp1[i];
			attribute2.options[i].selected = "selected";
		}

		//generating new options
		ClearList(attribute1, attribute1);
		if (temp2.length > 0) {
			for ( var i = 0; i < temp2.length; i++) {
				attribute1.options[i] = new Option();
				attribute1.options[i].value = temp2[i];
				attribute1.options[i].text = temp2[i];
				attribute1.options[i].text = temp2[i];
			}
		}
	}
</script>
<script type="text/javascript">
	function ClearList1(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function move1(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('approver_name');
			attribute2 = document.getElementById('approver_selected');
		} else {
			attribute2 = document.getElementById('approver_name');
			attribute1 = document.getElementById('approver_selected');
		}

		//fill an array with old values
		for ( var i = 0; i < attribute2.length; i++) {
			temp1[current1++] = attribute2.options[i].value;
		}

		//assign new values to arrays
		for ( var i = 0; i < attribute1.length; i++) {
			if (attribute1.options[i].selected) {
				temp1[current1++] = attribute1.options[i].value;

			} else {
				temp2[current2++] = attribute1.options[i].value;

			}
		}

		//generating new options 
		for ( var i = 0; i < temp1.length; i++) {
			attribute2.options[i] = new Option();
			attribute2.options[i].value = temp1[i];
			attribute2.options[i].text = temp1[i];
			attribute2.options[i].selected = "selected";
		}

		//generating new options
		ClearList(attribute1, attribute1);
		if (temp2.length > 0) {
			for ( var i = 0; i < temp2.length; i++) {
				attribute1.options[i] = new Option();
				attribute1.options[i].value = temp2[i];
				attribute1.options[i].text = temp2[i];

			}
		}
	}
</script>

<script type="text/javascript" src="jquery-1.6.1.min.js"></script>
<link href="jquery.datepick.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery.datepick.js"></script>
<script type="text/javascript">
	$(function() {

		$('#txtdate,#txtreturndate').datepick({
			onSelect : customRange,
			showTrigger : '#calImg'
		});

		function customRange(dates) {
			if (this.id == 'txtdate') {
				$('#txtreturndate').datepick('option', 'minDate',
						dates[0] || null);
			} else {
				$('#txtdate').datepick('option', 'maxDate', dates[0] || null);
			}
		}

	});
</script>
<!--============================================================================-->
<!--============================================================================-->
</head>
<body id="sub_page">


	<div id="templatemo_wrapper1">
		<div id="templatemo_top"></div>
		<!-- end of top -->

<!--===================== Menu Bar ================================-->
<!--============================================================================-->
		<div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp">Home</a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<li><a href="Cab_Edit_Request.jsp">Edit Request</a></li>
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li><a href="My_Approvals.jsp">My Approvals</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li><a href="logout.jsp">Log Out</a></li>
			</ul>
			<br style="clear: left" />
		</div>
		<!--============================================================================-->
		<!--============================================================================-->
		<!-- end of templatemo_menu -->
		<div id="templatemo_menu">
			<div id="site_title">
				<h1 style="color: orange;">ECN</h1>
			</div>
		</div>

		<!-- end of header -->

		<div id="templatemo_main">
			<h1 style="color: white;">Approve Request</h1>
			<div class="col_w630 float_l">

				<div id="contact_form">
					<form method="post"
						action="Cab_ApproveDecline_Request_Controller_Customer"
						onsubmit="return(validate());" name="myForm">
						<table width="1050px" border="1" bordercolor="F70727">


							<%
								try {

									Connection con = Connection_Utility.getConnection();
									ArrayList name = new ArrayList();
									int cr_No = 0;
									cr_No = Integer.parseInt(request.getParameter("hid"));

									PreparedStatement ps_edit = con
											.prepareStatement("select * from CRC_tbl where CRC_No="
													+ cr_No);

									ResultSet rs_edit = ps_edit.executeQuery();
									int company_id = 0;
									while (rs_edit.next()) {
							%>
							<input type="hidden" name="crno" value="<%=cr_No%>">
							<tr>
								<td align="center"><b>R No</b></td>
								<td align="center"><b>R Date</b></td>
								<td align="center"><b>Supplier Name</b></td>
								<td align="center"><b>Part Name</b></td>
								<td align="center"><b>Change For</b></td>
								<td align="center"><b>WIP Stock</b></td>
								<td align="center"><b>As Cast Stock</b></td>
								<td align="center"><b>Total Stock</b></td>

							</tr>
							<tr>
								<td align="center"><label><%=cr_No%></label></td>
								<td align="center"><label><%=rs_edit.getString("CRC_Date")%></label></td>

								<%
									PreparedStatement ps_company = con
													.prepareStatement("select * from user_tbl_company where company_id="
															+ rs_edit.getInt("company_id"));
											ResultSet rs_company = ps_company.executeQuery();
											while (rs_company.next()) {

												company_id = rs_company.getInt("Company_Id");
								%>
								<td align="center"><label><%=rs_company.getString("Company_name")%></label></td>
								<%
									}

											PreparedStatement ps_item = con
													.prepareStatement("select * from customer_tbl_item where item_id="
															+ rs_edit.getInt("item_id"));
											ResultSet rs_item = ps_item.executeQuery();

											while (rs_item.next()) {
								%>
								<td align="center"><label><%=rs_item.getString("Item_Name")%></label></td>
								<%
									}
								%>

								<td align="center"><label><%=rs_edit.getString("Change_For")%></label>
								</td>
								<td align="center"><label><%=rs_edit.getInt("Existing_WIP_Stock")%></label>
								</td>
								<td align="center"><label><%=rs_edit.getInt("Existing_As_Cast_Stock")%></label>
								</td>
								<td align="center"><label><%=rs_edit.getInt("Total_Stock")%></label>
								</td>



							</tr>
						</table>

						<table width="1050px" border="1" bordercolor="F70727">

							<tr>
								<td align="center"><b>Targated Impl. Date</b></td>
								<td colspan="4" align="center"><b>Tooling</b></td>
								<td colspan="4" align="center"><b>Gauges</b></td>
								<td colspan="4" align="center"><b>Fixture</b></td>
								<td colspan="2" align="center"><b>PPAP</b></td>
								<td colspan="2" align="center"><b>Change Level</b></td>

							</tr>
							<tr>


								<%
									if (rs_edit.getString("Targated_Impl_Date").equals(
													"0002-11-30 00:00:00.0")) {
								%>
								<td align="center" width="110px">0000-00-00 00:00:00.0</td>
								<%
									} else {
								%>


								<td align="center"><label><%=rs_edit.getString("Targated_Impl_Date")%></label></td>
								<%
									}
								%>


								<td colspan="4" align="center">
									<table border="1">
										<tr>
											<td colspan="2" align="left"><b>Old</b></td>
											<td colspan="2" align="right"><b>New</b></td>
										</tr>
										<tr>
											<td colspan="2" align="left"><%=rs_edit.getInt("Tooling_Old")%></td>
											<td colspan="2" align="right"><%=rs_edit.getInt("Tooling_New")%></td>
										</tr>
									</table>

								</td>

								<td colspan="4" align="center">

									<table border="1">

										<tr>
											<td colspan="2" align="left"><b>Old</b></td>
											<td colspan="2" align="right"><b>New</b></td>
										</tr>
										<tr>
											<td colspan="2" align="left"><%=rs_edit.getInt("Gauges_Old")%></td>
											<td colspan="2" align="right"><%=rs_edit.getInt("Gauges_New")%></td>
										</tr>
									</table>
								</td>
								<td colspan="4" align="center">
									<table border="1">

										<tr>
											<td colspan="2" align="left"><b>Old</b></td>
											<td colspan="2" align="right"><b>New</b></td>
										</tr>
										<tr>
											<td colspan="2" align="left"><%=rs_edit.getInt("Fixture_Old")%></td>
											<td colspan="2" align="right"><%=rs_edit.getInt("Fixture_New")%></td>
										</tr>
									</table>
								</td>

								<td colspan="2" align="center"><%=rs_edit.getString("PPAP")%>
								</td>

								<td colspan="2" align="center"><%=rs_edit.getString("Change_Level")%>
								</td>
							</tr>

							<%
								
							%>
						</table>


						<table width="1050px" border="1" bordercolor="F70727">


							<tr>
								<td colspan="1" align="center"><b>Requestor </b></td>
								<td colspan="1" align="center"><b>Attachments </b></td>
							</tr>
							<tr>
								<td colspan="1" align="center">
									<%
										PreparedStatement ps_UName = con
														.prepareStatement("select U_Name from User_tbl where U_Id="
																+ rs_edit.getInt("U_Id"));

												ResultSet rs_UName = ps_UName.executeQuery();

												while (rs_UName.next()) {
									%> <label> <%=rs_UName.getString("U_Name")%>
								</label> <%
 	}
 			//System.out.println("User input list " + name);
 		}
 %>
								</td>
								<td colspan="1" align="center">
									<%
										/****************************************************************************************************************
																																																																																																																																																																																																																																																TO SELECT ATTACHMENTS RELATED TO Action NUMBER 							
											 ****************************************************************************************************************/
											PreparedStatement ps_file1 = null;
											System.out.println("Cr no.... for attachment...." + cr_No);
											ps_file1 = con
													.prepareStatement("select * from crc_tbl_attachment where CRC_No="
															+ cr_No + " and Del_Status=1");
											ResultSet rs_file1 = ps_file1.executeQuery();
											while (rs_file1.next()) {
									%>
									<table width="390px">
										<tr>
											<td width="270px" align="center"><a
												href="Display_Attach_Customer.jsp?field=<%=rs_file1.getString("CRC_File_Name")%>"
												style="color: #396E2F"> <b> <%=rs_file1.getString("CRC_File_Name")%></b>
											</a></td>
										</tr>
									</table> <%
 	}
 %>
								</td>

							</tr>

						</table>











						<table width="1050px" border="1" bordercolor="F70727">
							<tr>
								<td align="center" colspan="2"><b>Approver Name</b>
									<div class="cleaner h10"></div></td>
								<td align="center" colspan="2"><b>Approve Type</b>
									<div class="cleaner h10"></div></td>
								<td align="center" colspan="1"><b>Approve Date</b>
									<div class="cleaner h10"></div></td>
								<td align="center" colspan="3"><b>Remark</b>
									<div class="cleaner h10"></div></td>
							</tr>
							<%
								PreparedStatement ps_appr_details = con
											.prepareStatement("select * from crc_tbl_approval where CRC_no="
													+ cr_No);

									ResultSet rs_appr_details = ps_appr_details.executeQuery();

									while (rs_appr_details.next()) {
							%>
							<tr>
								<%
									PreparedStatement ps_U_Name = con
													.prepareStatement("select distinct(U_Name) from user_tbl where U_Id="
															+ rs_appr_details.getInt("U_Id"));

											ResultSet rs_U_Name = ps_U_Name.executeQuery();

											while (rs_U_Name.next()) {
												name.add(rs_U_Name.getString("U_Name"));
								%>
								<td colspan="2" align="center"><%=rs_U_Name.getString("U_Name")%><div
										class="cleaner h10"></div></td>
								<%
									}

											PreparedStatement ps_A_Name = con
													.prepareStatement("select Approval_Type from Cr_tbl_Approval_Type where Approval_Id="
															+ rs_appr_details.getInt("Approval_Id"));

											ResultSet rs_A_Name = ps_A_Name.executeQuery();

											while (rs_A_Name.next()) {
								%>
								<td colspan="2" align="center"><%=rs_A_Name.getString("Approval_Type")%><div
										class="cleaner h10"></div></td>
								<%
									}

											PreparedStatement ps_Remark = con
													.prepareStatement("select Remark,CRC_Approval_Date from crc_tbl_approval where U_Id="
															+ rs_appr_details.getInt("U_Id")
															+ " and CRC_No=" + cr_No);

											ResultSet rs_Remark = ps_Remark.executeQuery();

											while (rs_Remark.next()) {
								%>
								<td colspan="1" align="center"><%=rs_Remark.getTimestamp("CRC_Approval_Date")%></td>
								<td colspan="3" align="center"><%=rs_Remark.getString("Remark")%><div
										class="cleaner h10"></div></td>
								<%
									}
								%>

							</tr>
							<%
								}
							%>

						</table>

						<table width="1050px" border="1" bordercolor="F70727">
							<tr>
								<td align="center" width="10px"><b>Action No</b></td>
								<td align="center" width="200px"><b>Action Description</b></td>
								<td align="center" width="110px"><b>Action Date</b></td>
								<td align="center" width="110px"><b>Proposed Output</b></td>
								<td align="center" width="110px"><b>Actual Output</b></td>

								<!-- <td align="center" width="110px"><b>Proposed Date</b></td>
								<td align="center" width="110px"><b>Implementation Date</b></td> -->

								<td align="center" width="390px"><b>Attachments</b></td>
							</tr>
							<%
								PreparedStatement ps_action_no = con
											.prepareStatement("select * from crc_tbl_action where CRC_no="
													+ cr_No);

									ResultSet rs_action_no = ps_action_no.executeQuery();
									int cnt = 0;
									while (rs_action_no.next()) {

										cnt++;
							%>
							<tr>
								<td align="center" width="10px"><%=cnt%></td>

								<td align="left" width="250px"><textarea
										style="width: 250px; height: 50px;"><%=rs_action_no.getString("Action_Discription")%></textarea></td>

								<td align="center" width="110px"><%=rs_action_no.getString("Action_Date")%></td>

								<td align="center" width="110px"><%=rs_action_no.getString("proposed_Output")%></td>
								<td align="center" width="110px"><%=rs_action_no.getString("Actual_Output")%></td>

								<%--
								<td align="center" width="110px"><%=rs_action_no.getString("Proposed_Date")%></td>

								<td align="center" width="110px"><%=rs_action_no.getString("Actual_Impl_Date")%></td>
 --%>
								<td width="390px">
									<%
										/****************************************************************************************************************
																																																																																																																																																																																																																																																																									TO SELECT ATTACHMENTS RELATED TO Action NUMBER 							
												 ****************************************************************************************************************/
												PreparedStatement ps_file = null;

												ps_file = con
														.prepareStatement("select * from crc_tbl_action_attachment where CRC_Action_Id="
																+ rs_action_no.getInt("CRC_Action_Id")
																+ " and CRC_Action_delete_status=1");
												ResultSet rs_file = ps_file.executeQuery();
												while (rs_file.next()) {
									%>
									<table width="390px">
										<tr>
											<td width="270px" align="center"><a
												href="Display.jsp?field=<%=rs_file.getString("CRC_Action_File_Name")%>"><%=rs_file.getString("CRC_Action_File_Name")%></a>
											</td>
										</tr>
									</table> <%
 	}
 		}
 %>
								</td>

							</tr>
						</table>






						<table width="1050px" border="1" bordercolor="F70727">
							<tr>
								<td align="left" width="10px"><b>Do you want Approval
										from (Optional) :</b></td>

							</tr>


							<tr>
								<td colspan="1"><b>Approvers</b></td>
								<td></td>
								<td colspan="1"><b>Selected Approvers</b></td>
							</tr>


							<tr>
								<td colspan="1"><select id="approver_name"
									name="approver_name" multiple="multiple" size="5"
									style="width: 310px" title="Approvers"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">

										<%
											//******************************************************************************************************************
												ArrayList depthd = new ArrayList();
												PreparedStatement ps_deptheads = con
														.prepareStatement("select * from user_tbl_depthead");
												ResultSet rs_deptheads = ps_deptheads.executeQuery();
												while (rs_deptheads.next()) {

													PreparedStatement ps_dehd = con
															.prepareStatement("select * from user_tbl where U_Id="
																	+ rs_deptheads.getInt("U_Id"));
													ResultSet rsdephd = ps_dehd.executeQuery();
													while (rsdephd.next()) {
														depthd.add(rsdephd.getString("U_Name"));
													}

												}
												System.out.println("Departmental heads === " + depthd);

												ArrayList planthd = new ArrayList();
												PreparedStatement ps_pltheads = con
														.prepareStatement("select * from user_tbl_planthead");
												ResultSet rs_plantheads = ps_pltheads.executeQuery();
												while (rs_plantheads.next()) {

													PreparedStatement ps_plthd = con
															.prepareStatement("select * from user_tbl where U_Id="
																	+ rs_plantheads.getInt("U_Id"));
													ResultSet rspltphd = ps_plthd.executeQuery();
													while (rspltphd.next()) {
														planthd.add(rspltphd.getString("U_Name"));
													}

												}
												System.out.println("Plant heads === " + planthd);

												//******************************************************************************************************************

												ArrayList users = new ArrayList();
												PreparedStatement ps_user = con
														.prepareStatement("select distinct(U_Name) from user_tbl where Enable_id=1 and  U_Designation='Manager' or U_Designation='Administration' order by U_Name");
												ResultSet rs_user = ps_user.executeQuery();

												while (rs_user.next()) {
													users.add(rs_user.getString("U_Name"));

												}
												System.out.println("users " + users + "Names ==== " + name);

												ArrayList userrem = new ArrayList();

												if (depthd.size() != 0 && users.size() != 0) {

													for (int a1 = 0; a1 < users.size(); a1++) {
														for (int b1 = 0; b1 < depthd.size(); b1++) {
															if (users.contains(depthd.get(b1))) {
																depthd.remove(b1);

															} else {
																continue;
															}
														}
													}
												}

												users.addAll(depthd);

												if (planthd.size() != 0 && users.size() != 0) {

													for (int a1 = 0; a1 < users.size(); a1++) {
														for (int b1 = 0; b1 < planthd.size(); b1++) {
															if (users.contains(planthd.get(b1))) {
																planthd.remove(b1);

															} else {
																continue;
															}
														}
													}
												}

												users.addAll(planthd);

												System.out.println("Users LIst new Logic ===== " + users);

												System.out.println("users Size Updated " + users.size());

												//******************************************************************************************************************
												for (int aa = 0; aa < users.size(); aa++) {
										%><option value="<%=users.get(aa).toString()%>"><%=users.get(aa).toString()%></option>
										<%
											}
										%>

								</select></td>
								<td style="width: 50px;" align="center"><input
									value="&gt;&gt;" onclick="move1('right', 'rep')" type="button"><br>
									<input value="&lt;&lt;" onclick="move1('left', 'rep')"
									type="button"></td>
								<td colspan="1"><select id="approver_selected"
									name="approver_selected" multiple="multiple" size="5"
									style="width: 310px" title="Selected Approvers"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
								</select></td>
							</tr>



						</table>







						<table width="1050px" border="1" bordercolor="F70727">


							<tr>
								<td colspan="1" align="center"><b>Do you want to add
										Actions </b></td>

							</tr>



							<tr>
								<%
									System.out.println("CRC No Is == " + cr_No);
								%>
								<td colspan="1" align="center"><a
									href="NewRequestCustomer_AddAction.jsp?hid=<%=cr_No%>"><b
										style="font-size: 14px;">ADD ACTIONS</b></a></td>
							</tr>

						</table>












						<table width="1050px" border="1" bordercolor="F70727">

							<tr>

								<%
									int uid = 0;
										boolean flag = false;
										uid = Integer.parseInt(session.getAttribute("uid").toString());

										int ap_id = 0;

										PreparedStatement ps_check = con
												.prepareStatement("select * from cr_tbl_approval");
										ResultSet rs_check = ps_check.executeQuery();
										while (rs_check.next()) {
											int cr_No1 = rs_check.getInt("CR_No");
											int uid1 = rs_check.getInt("U_Id");

											if (cr_No == cr_No1 && uid == uid1) {
												flag = true;
								%>
								<td><b>Action</b></td>
								<td><select name="approval_name">

										<%
											ap_id = rs_check.getInt("Approval_Id");

														PreparedStatement ps = con
																.prepareStatement("select * from cr_tbl_approval_Type where Approval_Id="
																		+ ap_id);
														ResultSet rs = ps.executeQuery();
														while (rs.next()) {
										%>
										<option selected="selected"
											value="<%=rs.getInt("Approval_Id")%>"><%=rs.getString("Approval_Type")%></option>

										<%
											}
														if (ap_id == 1 || ap_id == 3) {
															PreparedStatement ps_apprval_type = con
																	.prepareStatement("select * from cr_tbl_approval_type where approval_id!="
																			+ ap_id + " and approval_id!=2");
															ResultSet rs_apprval_type = ps_apprval_type
																	.executeQuery();
															while (rs_apprval_type.next()) {
										%>
										<option value="<%=rs_apprval_type.getInt("Approval_id")%>"><%=rs_apprval_type.getString("Approval_Type")%></option>
										<%
											}
														} else {
															PreparedStatement ps_apprval_type = con
																	.prepareStatement("select * from cr_tbl_approval_type where approval_id!="
																			+ ap_id);
															ResultSet rs_apprval_type = ps_apprval_type
																	.executeQuery();
															while (rs_apprval_type.next()) {
										%>
										<option value="<%=rs_apprval_type.getInt("Approval_id")%>"><%=rs_apprval_type
										.getString("Approval_Type")%></option>
										<%
											}
														}
										%>
								</select>
							</tr>
							<tr>
								<td><b>Remark</b></td>
								<td rowspan="1" colspan="1"><textarea name="remark"><%=rs_check.getString("Remark")%></textarea>
								</td>
							</tr>
							<%
								}
									}
									if (flag == false) {
							%>
							<tr>
								<td><b>Action</b></td>
								<td><select name="approval_name">
										<option selected="selected" value="0">----select-----</option>
										<%
											PreparedStatement ps_apprval_type1 = con
															.prepareStatement("select * from cr_tbl_approval_type");
													ResultSet rs_apprval_type1 = ps_apprval_type1
															.executeQuery();
													while (rs_apprval_type1.next()) {
										%>
										<option value="<%=rs_apprval_type1.getInt("Approval_id")%>"><%=rs_apprval_type1.getString("Approval_Type")%></option>
										<%
											}
										%>
								</select></td>
							</tr>
							<tr>
								<td><b>Remark</b></td>
								<td rowspan="1" colspan="1"><textarea name="remark"
										id="remark"></textarea></td>

							</tr>

							<%
								}
							%>


						</table>
						<%
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
						<input type="submit" value="Take Action"
							style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;">

					</form>

				</div>
			</div>



			<div class="cleaner"></div>
		</div>
		<!-- end of main -->
	</div>
	<!-- end of wrapper -->
<!--============================================================================-->
<!--============================================================================-->
	<div id="templatemo_footer_wrapper">
		<div id="templatemo_footer">
			Copyright 2013 <a href="http://www.muthagroup.com">Muthagroup
				Satara</a> |
			<div class="cleaner"></div>
		</div>
	</div>



</body>
</html>