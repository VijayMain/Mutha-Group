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
				}
			};
			xmlhttp.open("GET", "Delete.jsp?q=" + str, true);
			xmlhttp.send();
		} else {
			window.opener.document.forms["myForm"];
		}
	}
</script> 
<style type="text/css">
.tftable {
	font-size: 10px;
	color: white;
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
	color: black;
}
.tftable td {
	font-size: 10px; 
	padding: 3px; 
}
</style>
<link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" /> 
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ddsmoothmenu.js"></script>
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
<%
try { 
	Connection con = Connection_Utility.getConnection(); 
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	
	PreparedStatement ps_uidappr = con.prepareStatement("select * from user_tbl where U_Id=" + uid);
	String UName = null; 
	ResultSet rs_uname = ps_uidappr.executeQuery(); 
	String user_name = null; 
	while (rs_uname.next()) {
		user_name = rs_uname.getString("u_name");
	}
	rs_uname.close();
%>
 		<div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp">Home</a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<!-- <li><a href="Cab_Edit_Request.jsp">Edit Request</a></li> -->
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li style="background-color: #808080"><a href="My_Approvals.jsp"><b>Details</b></a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li><a href="logout.jsp">Log Out  <b style="font-size: 9px;">( <%=user_name%> )</b></a></li>
			</ul>
		</div>
		  			<div style="height: 550px;width: 100%;overflow: scroll;">
					<form method="post" action="Cab_ApproveDecline_Request_Controller" onsubmit="return(validate());" name="myForm">
					<a href="All_Requests_Customer.jsp"><strong style="font-size: 5mm;"> <== Go Back </strong></a>
					<table style="width: 100%;" class="tftable">  
							<% 
									int cr_No = 0;
									cr_No = Integer.parseInt(request.getParameter("hid"));

									PreparedStatement ps_edit = con.prepareStatement("select * from CRC_tbl where CRC_No=" + cr_No);
									ResultSet rs_edit = ps_edit.executeQuery();
									int company_id = 0;
									while (rs_edit.next()) {
							%>
							<input type="hidden" name="crno" value="<%=cr_No%>">
							<tr style="height: 27px;">
								<th align="center"><b>R No</b></th>
								<th align="center"><b>R Date</b></th>
								<th align="center"><b>Supplier Name</b></th>
								<th align="center" colspan="2"><b>Part Name</b></th>
								<th align="center"><b>Change For</b></th>
								<th align="center"><b>WIP Stock</b></th>
								<th align="center"><b>As Cast Stock</b></th>
								<th align="center"><b>Total Stock</b></th> 
							</tr>
							<tr>
								<td align="center"><label style="font-weight: bold;font-size: 12px;"><%=cr_No%></label></td>
								<td align="left"><label><%=rs_edit.getString("CRC_Date")%></label></td> 
								<%
									PreparedStatement ps_company = con.prepareStatement("select * from user_tbl_company where company_id=" + rs_edit.getInt("company_id"));
									ResultSet rs_company = ps_company.executeQuery();
									while (rs_company.next()) { 
									company_id = rs_company.getInt("Company_Id");
								%>
								<td align="left"><label><%=rs_company.getString("Company_name")%></label></td>
								<%
									} 
											PreparedStatement ps_item = con.prepareStatement("select * from customer_tbl_item where item_id=" + rs_edit.getInt("item_id"));
											ResultSet rs_item = ps_item.executeQuery(); 
											while (rs_item.next()) {
								%>
								<td align="left" colspan="2"><label><%=rs_item.getString("Item_Name")%></label></td>
								<%
									}
								%> 
								<td align="left"><label><%=rs_edit.getString("Change_For")%></label>
								</td>
								<td align="right"><label><%=rs_edit.getInt("Existing_WIP_Stock")%></label>
								</td>
								<td align="right"><label><%=rs_edit.getInt("Existing_As_Cast_Stock")%></label>
								</td>
								<td align="right"><label><%=rs_edit.getInt("Total_Stock")%></label>
								</td> 
							</tr> 
							<tr>
								<th align="center"><b>Targated Impl. Date</b></th>
								<th align="center"><b>Tooling Old</b></th>
								<th align="center"><b>Tooling New</b></th>
								<th align="center"><b>Gauges Old</b></th>
								<th align="center"><b>Gauges New</b></th>
								<th align="center"><b>Fixture Old</b></th>
								<th align="center"><b>Fixture New</b></th>
								<th align="center"><b>PPAP</b></th>
								<th align="center"><b>Change Level</b></th> 
							</tr>
							<tr> 
								<%
									if (rs_edit.getString("Targated_Impl_Date").equals("0002-11-30 00:00:00.0")) {
								%>
								<td align="center"></td>
								<%
									} else {
								%>  
								<td align="left"><label><%=rs_edit.getString("Targated_Impl_Date")%></label></td>
								<%
									}
								%> 
								<td align="right"><%=rs_edit.getInt("Tooling_Old")%></td>
								<td align="right"><%=rs_edit.getInt("Tooling_New")%></td> 
								<td align="right"><%=rs_edit.getInt("Gauges_Old")%></td>
								<td align="right"><%=rs_edit.getInt("Gauges_New")%></td>
								<td align="right"><%=rs_edit.getInt("Fixture_Old")%></td>
								<td align="right"><%=rs_edit.getInt("Fixture_New")%></td>
								<td align="left"><%=rs_edit.getString("PPAP")%></td> 
								<td align="left"><%=rs_edit.getString("Change_Level")%></td>
							</tr> 
							
							
							
							<tr>
								<th colspan="2" align="center"><b>Requestor </b></th>
								<th colspan="3" align="center"><b>Attachments </b></th>
								<th colspan="2" align="center"><b>Nature of Change</b></th>
								<th colspan="2" align="center"><b>Reason for change</b></th>								
							</tr>
							<tr>
								<td colspan="2" align="left">
									<%
										PreparedStatement ps_UName = con.prepareStatement("select U_Name from User_tbl where U_Id=" + rs_edit.getInt("U_Id"));
										ResultSet rs_UName = ps_UName.executeQuery();
										while (rs_UName.next()) {
									%> 
									<label> <%=rs_UName.getString("U_Name")%></label> 
								<%
 									} 
 								%>
								</td>
								<td colspan="3" align="left">
									<%
											PreparedStatement ps_file1 = null;
											System.out.println("Cr no.... for attachment...." + cr_No);
											ps_file1 = con.prepareStatement("select * from crc_tbl_attachment where CRC_No=" + cr_No + " and Del_Status=1");
											ResultSet rs_file1 = ps_file1.executeQuery();
											while (rs_file1.next()) {
									%>
									<a href="Display_Attach_Customer.jsp?field=<%=rs_file1.getString("CRC_File_Name")%>" style="color: #396E2F"> <b> <%=rs_file1.getString("CRC_File_Name")%></b> </a><br>
									<%
 										}
 									%>
								</td> 
								<td colspan="2" align="left"><%=rs_edit.getString("Nature_Of_Change")%></td>
								<td colspan="2" align="left"><%=rs_edit.getString("Reason_For_Change")%></td>
								<%
									}
								%>
							</tr> 
							
							
							
 							<tr>
								<th align="center" colspan="3"><b>Approver Name</b></th>
								<th align="center" colspan="2"><b>Approve Type</b></th>
								<th align="center" colspan="1"><b>Approve Date</b></th>
								<th align="center" colspan="3"><b>Remark</b></th>
							</tr>
							<%
								PreparedStatement ps_appr_details = con.prepareStatement("select * from crc_tbl_approval where CRC_no=" + cr_No);
								ResultSet rs_appr_details = ps_appr_details.executeQuery();
								while (rs_appr_details.next()) {
							%>
							<tr>
								<%
									PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from user_tbl where U_Id="
															+ rs_appr_details.getInt("U_Id"));
									ResultSet rs_U_Name = ps_U_Name.executeQuery();
									while (rs_U_Name.next()) {
								%>
								<td colspan="3" align="left"><%=rs_U_Name.getString("U_Name")%></td>
								<%
									}
											PreparedStatement ps_A_Name = con.prepareStatement("select Approval_Type from Cr_tbl_Approval_Type where Approval_Id=" + rs_appr_details.getInt("Approval_Id"));
											ResultSet rs_A_Name = ps_A_Name.executeQuery();
											while (rs_A_Name.next()) {
								%>
								<td colspan="2" align="left"><%=rs_A_Name.getString("Approval_Type")%>
								</td>
								<%
									} 
											PreparedStatement ps_Remark = con.prepareStatement("select Remark,CRC_Approval_Date from Crc_tbl_Approval where U_Id="
															+ rs_appr_details.getInt("U_Id")
															+ " and CRC_No=" + cr_No); 
											ResultSet rs_Remark = ps_Remark.executeQuery(); 
											while (rs_Remark.next()) {
								%>
								<td colspan="1" align="left"><%=rs_Remark.getString("CRC_Approval_Date")%></td>
								<td colspan="3" align="left"><%=rs_Remark.getString("Remark")%>
								</td>
								<%
									}
								%> 
							</tr>
							<%
								}
							%> 
							<tr>
								<th align="center"><b>ANo</b></th>
								<th align="center" colspan="2"><b>Action Description</b></th>
								<th align="center"><b>Action Date</b></th>
								<th align="center" colspan="2"><b>Proposed Output</b></th>
								<th align="center" colspan="2"><b>Actual Output</b></th>
								<th align="center"><b>Attachments</b></th>
							</tr>
							<%
								PreparedStatement ps_action_no = con.prepareStatement("select * from crc_tbl_action where CRC_no="
													+ cr_No);

									ResultSet rs_action_no = ps_action_no.executeQuery();
									int cnt = 0;
									while (rs_action_no.next()) {

										cnt++;
							%>
							<tr>
								<td align="right"><%=cnt%></td> 
								<td align="left" colspan="2"><%=rs_action_no.getString("Action_Discription")%></td> 
								<td align="left"><%=rs_action_no.getString("Action_Date")%></td> 
								<td align="left" colspan="2"><%=rs_action_no.getString("Proposed_Output")%></td> 
								<td align="left" colspan="2"><%=rs_action_no.getString("Actual_Output")%></td> 
								<td align="left">
									<% 
												PreparedStatement ps_file = null; 
												ps_file = con.prepareStatement("select * from crc_tbl_action_attachment where CRC_Action_Id="
																+ rs_action_no.getInt("CRC_Action_Id")
																+ " and CRC_Action_delete_status=1");
												ResultSet rs_file = ps_file.executeQuery();
												while (rs_file.next()) {
									%>
									<a href="Display_Customer.jsp?field=<%=rs_file.getString("CRC_Action_File_Name")%>" style="font-weight: bold;color: green;"><%=rs_file.getString("CRC_Action_File_Name")%></a><br>
									<%
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
					</form> 
				</div>
</body>
</html>