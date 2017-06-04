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
<title>My Approvals Results</title>
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
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
					window.location.reload(true);
					//window.opener.location.href = window.opener.location;
					//window.opener.location.reload(true);
					//window.location.href = window.location;
					//window.opener.document.forms["myForm"].submit();
					//document.getElementById("myForm").innerHTML=xmlhttp.responseText;
					//window.opener.location.replace(window.opener.location.href);
				}
			};
			xmlhttp.open("GET", "Delete.jsp?q=" + str, true);
			xmlhttp.send();
		} else {
			window.opener.document.forms["myForm"];
		}
	}
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

<!--============================================================================-->
<!--====================== Menu Bar ==================================-->
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
			<h1 style="color: white;">My Approval</h1>
			<div class="col_w630 float_l">

				<div id="contact_form">
					<form method="post" action="Cab_ApproveDecline_Request_Controller"
						onsubmit="return(validate());" name="myForm">
						<table width="1050px" border="1" bordercolor="F70727">


							<%
								try {

									Connection con = Connection_Utility.getConnection();

									int cr_No = 0;
									cr_No = Integer.parseInt(request.getParameter("hid"));

									PreparedStatement ps_edit = con
											.prepareStatement("select * from CR_tbl where CR_No="
													+ cr_No);

									ResultSet rs_edit = ps_edit.executeQuery();
									int company_id = 0;
									while (rs_edit.next()) {
							%>
							<input type="hidden" name="crno" value="<%=cr_No%>">
							<tr>
								<td><b>Request Number</b></td>
								<td><b>Request Date</b></td>
								<td><b>Supplier Name</b></td>
								<td><b>Part Name</b></td>
								<td><b>Category Of Change</b></td>
								<td><b>Type Of Change</b></td>
								<td><b>Proposed date</b></td>
								<td><b>Actual Implementation date</b></td>
								<td><b>ComplaintNo(Optional)</b></td>
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
									%> <label><%=rs_cat_name.getString("CR_Category")%></label> <%
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
									%> <b>-></b><label><%=rs_type.getString("CR_Type")%></label> <%
 	}
 			}
 %>
								</td>



								<td><label><%=rs_edit.getString("Proposed_Impl_Date")%></label>`</td>


								<%
									if (rs_edit.getString("Actual_Impl_Date").equals(
													"0002-11-30 00:00:00.0")) {
								%>
								<td align="center" width="110px">0000-00-00 00:00:00.0</td>
								<%
									} else {
								%>

								<td><label><%=rs_edit.getString("Actual_Impl_Date")%></label></td>
								<%
									}
								%>
								<td><label><%=rs_edit.getString("Complaint_No")%></label></td>
							</tr>
						</table>

						<table width="1050px" border="1" bordercolor="F70727">

							<tr>

								<td colspan="2" align="center"><b>Tracking Changes</b></td>
								<td colspan="2" align="center"><b>Present System</b></td>
								<td colspan="3" align="center"><b>Proposed System</b></td>
								<td colspan="3" align="center"><b>Objective</b></td>

							</tr>


							<tr>
								<td colspan="2" align="center">
									<%
										PreparedStatement ps_tc_id = con
														.prepareStatement("select TC_Id from cr_tc_rel_tbl where Cr_No="
																+ cr_No);

												ResultSet rs_tc_id = ps_tc_id.executeQuery();

												while (rs_tc_id.next()) {

													PreparedStatement ps_tc = con
															.prepareStatement("Select * from cr_tracking_change where TC_Id="
																	+ rs_tc_id.getInt("TC_Id"));

													ResultSet rs_tc = ps_tc.executeQuery();

													while (rs_tc.next()) {
									%> <label> -><%=rs_tc.getString("TC_Type")%>
								</label> <%
 	}

 			}
 %>
								</td>
								<td colspan="2" align="center"><%=rs_edit.getString("Present_System")%>

									<div class="cleaner h10"></div></td>

								<td colspan="3" align="center"><%=rs_edit.getString("Proposed_System")%>

									<div class="cleaner h10"></div></td>

								<td colspan="3" align="center"><%=rs_edit.getString("Objective")%>
									<div class="cleaner h10"></div></td>
							</tr>


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
 		}
 %>
								</td>
								<td colspan="1" align="center">
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
									<table width="390px">
										<tr>
											<td width="270px" align="center"><a
												href="Display_Attach.jsp?field=<%=rs_file1.getString("File_Name")%>"
												style="color: #396E2F"><b> <%=rs_file1.getString("File_Name")%></b></a>

												<%--<input
												type="button" value=" Remove "
												onclick="showState111(<%=rs_file1.getInt("Cr_Attach_Id")%>)">
											 --%></td>
										</tr>
									</table> <%
 	}
 %>
								</td>

							</tr>

						</table>

						<table width="1050px" border="1" bordercolor="F70727">
							<tr>
								<td align="center" colspan="3"><b>Approver Name</b></td>
								<td align="center" colspan="2"><b>Approve Type</b></td>
								<td align="center" colspan="1"><b>Approve Date</b></td>
								<td align="center" colspan="3"><b>Remark</b></td>
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
								%>
								<td colspan="3" align="center"><%=rs_U_Name.getString("U_Name")%>
								</td>
								<%
									}

											PreparedStatement ps_A_Name = con
													.prepareStatement("select Approval_Type from Cr_tbl_Approval_Type where Approval_Id="
															+ rs_appr_details.getInt("Approval_Id"));

											ResultSet rs_A_Name = ps_A_Name.executeQuery();

											while (rs_A_Name.next()) {
								%>
								<td colspan="2" align="center"><%=rs_A_Name.getString("Approval_Type")%>
								</td>
								<%
									}

											PreparedStatement ps_Remark = con
													.prepareStatement("select Remark,CR_Approval_Date from Cr_tbl_Approval where U_Id="
															+ rs_appr_details.getInt("U_Id")
															+ " and CR_No=" + cr_No);

											ResultSet rs_Remark = ps_Remark.executeQuery();

											while (rs_Remark.next()) {
								%>
								<td colspan="1" align="center"><%=rs_Remark.getString("CR_Approval_Date")%></td>
								<td colspan="3" align="center"><%=rs_Remark.getString("Remark")%>
								</td>
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
								<td align="center" width="10px"><b>ANo</b></td>
								<td align="center" width="200px"><b>Action Description</b></td>
								<td align="center" width="110px"><b>Action Date</b></td>
								<td align="center" width="110px"><b>Proposed Output</b></td>
								<td align="center" width="110px"><b>Actual Output</b></td>
								<td align="center" width="390px"><b>Attachments</b></td>
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
								<td align="center" width="10px"><%=cnt%></td>

								<td align="left" width="250px"><textarea
										style="width: 250px; height: 50px;"><%=rs_action_no.getString("Action_Discription")%></textarea></td>

								<td align="center" width="110px"><%=rs_action_no.getString("Action_Date")%></td>

								<td align="center" width="160px"><%=rs_action_no.getString("Proposed_Output")%></td>

								<td align="center" width="160px"><%=rs_action_no.getString("Actual_Output")%></td>



								<td width="270px">
									<%
										/****************************************************************************************************************
																																																																																																																																																							TO SELECT ATTACHMENTS RELATED TO Action NUMBER 							
												 ****************************************************************************************************************/
												PreparedStatement ps_file = null;

												ps_file = con
														.prepareStatement("select * from cr_tbl_action_attachment where CR_Action_Id="
																+ rs_action_no.getInt("CR_Action_Id")
																+ " and delete_Status=1");
												ResultSet rs_file = ps_file.executeQuery();
												while (rs_file.next()) {
									%>
									<table width="270px">
										<tr>
											<td width="270px" align="center"><a
												href="Display.jsp?field=<%=rs_file.getString("File_Name")%>"><%=rs_file.getString("File_Name")%></a></td>

										</tr>
									</table> <%
 	}
 		}
 %>
								</td>

							</tr>
						</table>




						<%
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>

						<a href="My_Approvals.jsp"><strong style="font-size: 5mm;">
								Back </strong></a>

					</form>

				</div>
			</div>
<!--============================================================================-->
<!--============================================================================-->



			<div class="cleaner"></div>
		</div>
		<!-- end of main -->
	</div>
	<!-- end of wrapper -->

	<div id="templatemo_footer_wrapper">
		<div id="templatemo_footer">
			Copyright 2013 <a href="http://www.muthagroup.com">Muthagroup
				Satara</a> |
			<div class="cleaner"></div>
		</div>
	</div>



</body>
</html>