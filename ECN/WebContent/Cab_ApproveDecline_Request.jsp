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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ECN Approve Req</title>
<!--============================================================================-->
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.tftable {
	font-size: 11px;
	color: #333333;
	width: 100%;  
}

.tftable th {
	font-size: 11px;
	background-color: #388EAB; 
	padding: 3px; 
	color: white;
	text-align: center;
}

.tftable tr {
	background-color: white;
	font-size: 11px;
}
.tftable td {
	font-size: 11px; 
	padding: 3px; 
}
</style>
<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}
	//============================================================================-->
	//====================== AJAX to get item ===============================-->
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
<!--============================================================================-->
<!--============================================================================-->
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
 
<link href="css_pirobox/white/style.css" media="screen" title="shadow" rel="stylesheet" type="text/css" />
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
<%
try { 
	String user_name = ""; 
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uidappr = con.prepareStatement("select * from user_tbl where U_Id=" + uid); 
	ResultSet rs_uname = ps_uidappr.executeQuery(); 
	while (rs_uname.next()) {
		user_name = rs_uname.getString("u_name");
	} 
	rs_uname.close();
%>
<!--======================= Menu Bar ====================================-->
<!--====================================================================-->
		<div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp" style="background-color: #808080"><b>Home</b></a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<!-- <li><a href="Cab_Edit_Request.jsp">Edit Request</a></li> -->
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li><a href="My_Approvals.jsp">Details</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li style="text-align: center;"><a href="logout.jsp">Log Out <b style="font-size: 9px;">( <%=user_name%> )</b></a></li>
			</ul> 
		</div>
		<!--============================================================================-->
		  
			
			<div style="width: 100%;overflow: scroll;">
			<!-- <h4 style="color: #1222e9">Approve/Decline Request Form</h4> -->
					<form method="post" action="Cab_ApproveDecline_Request_Controller" onsubmit="return(validate());" name="myForm">
						<table style="width: 100%;" class="tftable"> 
						<tr style="background-color: #e66a0f">
							<td colspan="10"><b style="color: white;font-size: 13px;">Internal Approve/Decline ECN Change</b></td>
						</tr>
							<% 
									ArrayList name = new ArrayList(); 
									int cr_No = 0;
									cr_No = Integer.parseInt(request.getParameter("hid"));

									PreparedStatement ps_edit = con.prepareStatement("select * from CR_tbl where CR_No="
													+ cr_No);

									ResultSet rs_edit = ps_edit.executeQuery();
									int company_id = 0;
									while (rs_edit.next()) {
							%>
							<input type="hidden" name="crno" value="<%=cr_No%>">
							<tr style="height: 27px;"> 
								<th align="center"><b>R No</b></th>
								<th><b>R Date/Time</b></th>
								<th><b>Supplier Name</b></th>
								<th><b>Part Name</b></th>
								<th><b>Category Of Change</b></th>
								<th><b>Type Of Change</b></th>
								<th><b>Proposed date</b></th>
								<th><b>Actual Impl date</b></th>
								<th colspan="2"><b>ComplaintNo</b></th>
							</tr>
							<tr>
								<td align="center"><label><%=cr_No%></label></td>
								<td><label><%=rs_edit.getString("CR_Date")%></label></td>

								<%
									PreparedStatement ps_company = con
													.prepareStatement("select * from user_tbl_company where company_id="
															+ rs_edit.getInt("company_id"));
											ResultSet rs_company = ps_company.executeQuery();
											while (rs_company.next()) {

												company_id = rs_company.getInt("Company_Id");
								%>
								<td><label><%=rs_company.getString("Company_name")%></label></td>
								<%
									}

											PreparedStatement ps_item = con
													.prepareStatement("select * from customer_tbl_item where item_id="
															+ rs_edit.getInt("item_id"));
											ResultSet rs_item = ps_item.executeQuery();

											while (rs_item.next()) {
								%>
								<td><label><%=rs_item.getString("Item_Name")%></label></td>
								<%
									}
								%>



								<td>
									<%
										PreparedStatement ps_cat_list = con
														.prepareStatement("select CR_Category_Id from cr_category_relation_tbl where CR_No="
																+ rs_edit.getInt("CR_No"));
												ResultSet rs_cat_list = ps_cat_list.executeQuery();

												while (rs_cat_list.next()) {
													PreparedStatement ps_cat_name = con
															.prepareStatement("select CR_Category from cr_tbl_category where CR_Category_Id="
																	+ rs_cat_list.getInt("CR_Category_Id"));
													ResultSet rs_cat_name = ps_cat_name.executeQuery();
													while (rs_cat_name.next()) {
									%> <label>-> <%=rs_cat_name.getString("CR_Category")%></label><br> 
									<%
 									}
 											}	
 									%>

								</td>
								<td>
									<%
										PreparedStatement ps_type_list = con
														.prepareStatement("select CR_Type_Id from cr_ctype_relation_tbl where CR_No="
																+ rs_edit.getInt("CR_No"));
												ResultSet rs_type_list = ps_type_list.executeQuery();

												while (rs_type_list.next()) {
													PreparedStatement ps_type = con
															.prepareStatement("select CR_Type from cr_tbl_type where CR_type_Id="
																	+ rs_type_list.getInt("CR_Type_Id"));
													ResultSet rs_type = ps_type.executeQuery();
													while (rs_type.next()) {
									%> <b>-></b><label><%=rs_type.getString("CR_Type")%></label><br> <%
 	}
 			}
 %>
								</td>
								<td><label><%=rs_edit.getString("Proposed_Impl_Date")%></label>`</td>

								<%
									if (rs_edit.getString("Actual_Impl_Date").equals(
													"0002-11-30 00:00:00.0")) {
								%>
								<td align="center" width="110px"></td>
								<%
									} else {
								%>


								<td><label><%=rs_edit.getString("Actual_Impl_Date")%></label></td>
								<%
									}
								%>
								<td colspan="2"><label><%=rs_edit.getString("Complaint_No")%></label></td>

							</tr> 
							<tr>
								<th colspan="2" align="center"><b>Tracking Changes</b></th>
								<th colspan="2" align="center"><b>Present System</b></th>
								<th colspan="2" align="center"><b>Proposed System</b></th>
								<th colspan="2" align="center"><b>Objective</b></th>
								<th colspan="1" align="center"><b>Requestor </b></th>
								<th colspan="1" align="center"><b>Attachments </b></th>
							</tr>
							<tr>

								<td colspan="2">
									<%
										PreparedStatement ps_tc_id = con.prepareStatement("select TC_Id from cr_tc_rel_tbl where Cr_No="
																+ cr_No); 
												ResultSet rs_tc_id = ps_tc_id.executeQuery(); 
												while (rs_tc_id.next()) { 
													PreparedStatement ps_tc = con.prepareStatement("Select * from cr_tracking_change where TC_Id="
																	+ rs_tc_id.getInt("TC_Id")); 
													ResultSet rs_tc = ps_tc.executeQuery(); 
													while (rs_tc.next()) {
									%> <label> -> <%=rs_tc.getString("TC_Type")%><br>
								</label> <%
 	}

 			}
 %>
								</td>

								<td colspan="2"><%=rs_edit.getString("Present_System")%>

									<div class="cleaner h10"></div></td>

								<td colspan="2"><%=rs_edit.getString("Proposed_System")%>

									<div class="cleaner h10"></div></td>

								<td colspan="2"><%=rs_edit.getString("Objective")%>
									<div class="cleaner h10"></div></td>
							  
								<td colspan="1">
									<%
										PreparedStatement ps_UName = con
														.prepareStatement("select distinct(U_Name) from User_tbl where U_Id="
																+ rs_edit.getInt("U_Id"));

												ResultSet rs_UName = ps_UName.executeQuery();

												while (rs_UName.next()) {
									%> <label> <%=rs_UName.getString("U_Name")%>
								</label> <%
 	}
 		}
 %> 							
								<td colspan="1">
									<%
										/****************************************************************************************************************
																																																																																																																																																																																																																																																																																																																																																																																	TO SELECT ATTACHMENTS RELATED TO Action NUMBER 							
											 ****************************************************************************************************************/
											PreparedStatement ps_file1 = null;

											ps_file1 = con
													.prepareStatement("select * from cr_tbl_attachment where CR_No="
															+ cr_No + " and Del_Status=1");
											ResultSet rs_file1 = ps_file1.executeQuery();
											while (rs_file1.next()) {
									%>
									<a href="Display_Attach.jsp?field=<%=rs_file1.getString("File_Name")%>"
												style="color: #396E2F"><b> <%=rs_file1.getString("File_Name")%></b></a>
 									<%
 										}
 									%>
								</td>

							</tr>
 							<tr>
								<th align="center" colspan="3"><b>Approver Name</b> </th>
								<th align="center" colspan="2"><b>Approve Type</b></th>
								<th align="center" colspan="2"><b>Approve Date</b></th>
								<th align="center" colspan="3"><b>Remark</b></th>
							</tr>
							<%
								PreparedStatement ps_appr_details = con
											.prepareStatement("select * from cr_tbl_approval where CR_no="
													+ cr_No);

									ResultSet rs_appr_details = ps_appr_details.executeQuery();

									while (rs_appr_details.next()) {
							%>
							<tr>
								<%
									PreparedStatement ps_U_Name = con
													.prepareStatement("select U_Name from user_tbl where U_Id="
															+ rs_appr_details.getInt("U_Id"));

											ResultSet rs_U_Name = ps_U_Name.executeQuery();

											while (rs_U_Name.next()) {
												name.add(rs_U_Name.getString("U_Name"));
								%>
								<td colspan="3" align="left"><%=rs_U_Name.getString("U_Name")%></td>
								<%
									}
											//System.out.println("Name List ====== " + name);

											PreparedStatement ps_A_Name = con
													.prepareStatement("select Approval_Type from Cr_tbl_Approval_Type where Approval_Id="
															+ rs_appr_details.getInt("Approval_Id"));

											ResultSet rs_A_Name = ps_A_Name.executeQuery();

											while (rs_A_Name.next()) {
								%>
								<td colspan="2" align="left"><%=rs_A_Name.getString("Approval_Type")%></td>
								<%
									}
											PreparedStatement ps_Remark = con
													.prepareStatement("select Remark,CR_Approval_Date from Cr_tbl_Approval where U_Id="
															+ rs_appr_details.getInt("U_Id")
															+ " and CR_No=" + cr_No);

											ResultSet rs_Remark = ps_Remark.executeQuery();

											while (rs_Remark.next()) {
								%>
								<td colspan="2" align="left"><%=rs_Remark.getTimestamp("CR_Approval_Date")%></td>
								<td colspan="3" align="left"><%=rs_Remark.getString("Remark")%></td>
								<%
									}
								%> 
							</tr>
							<%
								}
							%>
							<tr>
								<th align="center" colspan="1"><b>Action No</b></th>
								<th align="center" colspan="2"><b>Action Description</b></th>
								<th align="center" colspan="2"><b>Action Date</b></th>
								<th align="center" colspan="2"><b>Proposed Output</b></th>
								<th align="center" colspan="2"><b>Actual Output</b></th>
								<th align="center" colspan="2"><b>Attachments</b></th>
							</tr>
							<%
								PreparedStatement ps_action_no = con
											.prepareStatement("select * from cr_tbl_action where CR_no="
													+ cr_No);

									ResultSet rs_action_no = ps_action_no.executeQuery();
									int cnt = 0;
									while (rs_action_no.next()) {

										cnt++;
							%>
							<tr>
								<td align="center" colspan="1"><%=cnt%></td> 
								<td align="left" colspan="2"><textarea style="width: 250px; height: 50px;"><%=rs_action_no.getString("Action_Discription")%></textarea></td>
								<td colspan="2"><%=rs_action_no.getString("Action_Date")%></td> 
								<td colspan="2"><%=rs_action_no.getString("proposed_Output")%></td>
								<td colspan="2"><%=rs_action_no.getString("Actual_Output")%></td> 
								<td colspan="2">
									<% 
									PreparedStatement ps_file = null;
 									ps_file = con.prepareStatement("select * from cr_tbl_action_attachment where CR_Action_Id="
																+ rs_action_no.getInt("CR_Action_Id")
																+ " and delete_Status=1");
									ResultSet rs_file = ps_file.executeQuery();
									while (rs_file.next()) {
									%>
									<table>
										<tr>
											<td align="left"><a href="Display.jsp?field=<%=rs_file.getString("File_Name")%>"><%=rs_file.getString("File_Name")%></a>
											</td>
										</tr>
									</table> 
							<%
 								}
 							}
 							%>
								</td>
							</tr> 
							<tr>
								<th align="left" colspan="10" style="font-size: 11px; background-color: #644970;padding: 3px;color: white; text-align: left;"><b>Do you want to add Approvee ( Optional ) :</b></th> 
							</tr>
							<tr>
								<td colspan="3" style="font-size: 11px; background-color: #644970;padding: 3px;color: white; text-align: center;"><b>Approvers</b></td>
								<td style="font-size: 11px; background-color: #644970;padding: 3px;color: white; text-align: center;"></td>
								<td colspan="3" style="font-size: 11px; background-color: #644970;padding: 3px;color: white; text-align: center;"><b>Selected Approvers</b></td>
							</tr> 
							<tr>
								<td colspan="3" align="center"><select id="approver_name"
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
												//System.out.println("Departmental heads === " + depthd);

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
												//System.out.println("Plant heads === " + planthd);

												//******************************************************************************************************************

												ArrayList users = new ArrayList();
												PreparedStatement ps_user = con
														.prepareStatement("select distinct(U_Name) from user_tbl where Enable_id=1 and  U_Designation='Manager' or U_Designation='Administration' order by U_Name");
												ResultSet rs_user = ps_user.executeQuery();

												while (rs_user.next()) {
													users.add(rs_user.getString("U_Name"));

												}

												//System.out.println("users " + users + "Names ==== " + name);
												ArrayList userName = new ArrayList();

												for (int a = 0; a < users.size(); a++) {
													for (int b = 0; b < name.size(); b++) {
														if (users.get(a).toString()
																.equalsIgnoreCase(name.get(b).toString())) {
															userName.add(a);

														} else {
															continue;
														}
													}
												}

												Iterator it = userName.iterator();
												while (it.hasNext()) {
													Object obj = it.next();
													users.remove(obj);

												}

												//System.out.println("users original  " + users);
												//System.out.println("depthd original " + depthd);

												ArrayList Usersdpt = new ArrayList();
												ArrayList selectedUsers = new ArrayList();

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

												PreparedStatement ps_DefaulApprovers = con
														.prepareStatement("select U_id from cr_approver_relation_tbl where cr_no="
																+ cr_No);
												ResultSet rs_DefaultApprovers = ps_DefaulApprovers
														.executeQuery();
												PreparedStatement ps_AppName = null;
												ResultSet rs_AppName = null;
												while (rs_DefaultApprovers.next()) {
													ps_AppName = con
															.prepareStatement("select U_Name from User_Tbl where U_Id="
																	+ rs_DefaultApprovers.getInt("U_Id"));
													rs_AppName = ps_AppName.executeQuery();

													while (rs_AppName.next()) {
														selectedUsers.add(rs_AppName.getString("U_Name"));
													}

												}

												/* System.out.println("Users LIst new Logic ===== " + selectedUsers);
												System.out.println("Users LIst new Logic ===== " + users); */

												if (users.size() != 0 && selectedUsers.size() != 0) {
													for (int a1 = 0; a1 < selectedUsers.size(); a1++) {
														for (int b1 = 0; b1 < users.size(); b1++) {
															if (selectedUsers.contains(users.get(b1))) {
																users.remove(b1);

															} else {
																continue;
															}
														}
													}

												}
												/* System.out.println("Users LIst after removing selected users ===== " + users);
												System.out.println("users Size Updated " + users.size()); */
												//******************************************************************************************************************
												for (int aa = 0; aa < users.size(); aa++) {
										%><option value="<%=users.get(aa).toString()%>"><%=users.get(aa).toString()%></option>
										<%
											}
										%>

								</select></td>
								<td style="width: 50px;" align="center">
								<input value="&gt;&gt;" onclick="move1('right', 'rep')" type="button" style="font-weight: bold;"><br>
								<input value="&lt;&lt;" onclick="move1('left', 'rep')" type="button" style="font-weight: bold;">
								</td>
								<td colspan="3" align="center"><select id="approver_selected"
									name="approver_selected" multiple="multiple" size="5"
									style="width: 310px" title="Selected Approvers"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"> 
								</select></td> 
							</tr> 
							<tr style="background-color: #388eab;"> 
								<td colspan="10" align="left"><b style="font-size: 14px;color: white;">Provide Approval </b><a href="NewRequest_AddAction.jsp?hid=<%=cr_No%>"><b style="font-size: 12px;color: white;">( Add More Actions if any )</b></a></td>
							</tr> 
							<tr> 
								<%
										boolean flag = false;
									 	int ap_id = 0;
										PreparedStatement ps_check = con.prepareStatement("select * from cr_tbl_approval");
										ResultSet rs_check = ps_check.executeQuery();
										while (rs_check.next()) {
											int cr_No1 = rs_check.getInt("CR_No");
											int uid1 = rs_check.getInt("U_Id");
											if (cr_No == cr_No1 && uid == uid1) {
												flag = true;
								%>
								<td><b style="font-size: 13px;">Action</b></td>
								<td align="left" colspan="9">
								<select name="approval_name" style="font-size: 14px;width: 200px;height: 26px;background-color: #d2e9f0"> 
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
												PreparedStatement ps_apprval_type = con.prepareStatement("select * from cr_tbl_approval_type where approval_id!=" + ap_id);
												ResultSet rs_apprval_type = ps_apprval_type.executeQuery();
												while (rs_apprval_type.next()) {
										%>
										<option value="<%=rs_apprval_type.getInt("Approval_id")%>"><%=rs_apprval_type.getString("Approval_Type")%></option>
										<%
											}
												}
										%>
								</select> 
							</tr>
							<tr>
								<td><b style="font-size: 13px;">Remark</b></td>
								<td colspan="9" align="left"><textarea name="remark" cols="30" rows="4" style="background-color: #d2e9f0"><%=rs_check.getString("Remark")%></textarea>
								</td> 
							</tr>
							<%
								}
									}
									if (flag == false) {
							%>
							<tr>
								<td><b style="font-size: 13px;">Action</b></td> 
								<td align="left" colspan="9">
								<select name="approval_name" style="font-size: 14px;width: 200px;height: 26px; background-color: #d2e9f0"> 
										<option selected="selected" value="0">----select-----</option>
										<%
											PreparedStatement ps_apprval_type1 = con.prepareStatement("select * from cr_tbl_approval_type");
											ResultSet rs_apprval_type1 = ps_apprval_type1.executeQuery();
											while (rs_apprval_type1.next()) {
										%>
										<option value="<%=rs_apprval_type1.getInt("Approval_id")%>"><%=rs_apprval_type1.getString("Approval_Type")%></option>
										<%
											}
										%>
								</select></td>
							</tr>
							<tr>
								<td><b style="font-size: 13px;">Remark</b></td>
								<td colspan="9" align="left"><textarea name="remark" cols="30" rows="4" style="background-color: #d2e9f0"><%=rs_check.getString("Remark")%></textarea></td>
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
						<input type="submit" value="Take Action" style="font-weight:bold;height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;">

					</form>
				</div> 
</body>
</html>