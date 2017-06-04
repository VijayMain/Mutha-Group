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
<title>ECN Approve Request</title>
<script language="javascript" type="text/javascript" src="datetimepicker.js"></script>
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}
</script>
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
<script type="text/javascript">
 function submitDone(){
	var current = document.getElementById("mytext");
	current.value = 1;
	document.myForm.submit();
}
function SubmitAction(){
	var current = document.getElementById("mytext");
	current.value = 2;
}
 
	function validate() {

		if (document.myForm.Action_disc.value == "") {
			alert("Please provide Action Discription!");
			document.myForm.Action_disc.focus();
			return false;
		}

		if (document.myForm.Prop_output.value == "") {
			alert("Please provide Proposed Output!");
			document.myForm.Prop_output.focus();
			return false;
		}

		if (document.myForm.demo3.value == "") {
			alert("Please provide Proposed Date!");
			document.myForm.demo3.focus();
			return false;
		} 
		return (true);
	} 
</script> 
<script type="text/javascript">

function showState111(str) {
	var xmlhttp1;
	var where_to = confirm("Do you really want to DELETE this file ???");
	if (where_to == true) {

		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp1 = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
				window.location.reload(true);
				
			}
		};
		xmlhttp1.open("GET", "Delete_attach.jsp?q=" + str, true);
		xmlhttp1.send();
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
	ddsmoothmenu.init({
		mainmenuid : "templatemo_menu", //menu DIV id
		orientation : 'h', //Horizontal or vertical menu: Set to "h" or "v"
		classname : 'ddsmoothmenu', //class added to menu's outer DIV
		//customtheme: ["#1c5a80", "#18374a"],
		contentsource : "markup" //"markup" or ["container_id", "path_to_menu_file"]
	});
</script>
<link href="css_pirobox/white/style.css" media="screen" title="shadow" 	rel="stylesheet" type="text/css" />
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

<link href="jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<script src="js/jquery-1.7.2.min.js">
	
</script>
<script src="js/jquery-ui-1.8.18.custom.min.js">
	
</script>
<script type="text/javascript" src="tabledeleterow.js"></script>
<script type="text/javascript">
	$(function() {

		$("#req_date").datepicker({
			dateFormat : "dd/mm/yy"
		});
		$("#Actual_impl_date").datepicker({
			dateFormat : "dd/mm/yy"
		});
		$("#proposed_date").datepicker({
			dateFormat : "dd/mm/yy"
		});
	});
</script>


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
<!--======================== Delete Attachment ================================-->
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
<!--============================================================================-->
<!--============================================================================-->

</head>
<body id="sub_page">
 
			<div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="#"><b>Add Action</b></a></li> 
			</ul> 
			</div>
		<!-- <div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp">Home</a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<li><a href="Cab_Edit_Request.jsp">Edit Request</a></li>
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li><a href="My_Approvals.jsp">My Approvals</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="logout.jsp">Log Out</a></li>
			</ul>
			<br style="clear: left" />
		</div> -->
		<!-- end of templatemo_menu -->
		<!-- <div id="templatemo_menu">
			<div id="site_title">
				<h1 style="color: orange;">ECN</h1>
			</div>
		</div> -->  
					<div style="width: 100%;">
					<form method="post" action="Action_Controller" onsubmit="return(validate());" name="myForm" id="myForm" enctype="multipart/form-data">
					<table style="width: 100%;" class="tftable">  
							<%
								try {
									Connection con = Connection_Utility.getConnection();
									HttpSession session1 = request.getSession();
									int cr_No = 0;
									cr_No = Integer.parseInt(request.getParameter("hid"));
									session1.setAttribute("crno", cr_No);
									PreparedStatement ps_edit = con.prepareStatement("select * from CR_tbl where CR_No=" + cr_No);
									ResultSet rs_edit = ps_edit.executeQuery();
									int company_id = 0;
									while (rs_edit.next()) {
							%>
							<input type="hidden" name="crno" value="<%=cr_No%>">
							<tr style="background-color: #e66a0f">
								<th align="center"><b>R No</b></th>
								<th><b>Request Date</b></th>
								<th><b>Supplier Name</b></th>
								<th><b>Part Name</b></th>
								<th><b>Category Of Change</b></th>
								<th><b>Type Of Change</b></th>
								<th><b>Proposed date</b></th>
								<th><b>Actual Implementation date</b></th>
								<th><b>ComplaintNo(Optional)</b></th>
							</tr>
							<tr>
								<td align="right"><label><%=cr_No%></label></td>
								<td><label><%=rs_edit.getString("CR_Date")%></label> 
								<input type="hidden" name="req_date" value="<%=rs_edit.getString("CR_Date")%>"></td>
								<%
									PreparedStatement ps_company = con.prepareStatement("select * from user_tbl_company where company_id="
															+ rs_edit.getInt("company_id"));
											ResultSet rs_company = ps_company.executeQuery();
											while (rs_company.next()) { 
												company_id = rs_company.getInt("Company_Id");
								%>
								<td><label><%=rs_company.getString("Company_name")%></label></td>
								<%
									}

											PreparedStatement ps_item = con.prepareStatement("select * from customer_tbl_item where item_id="
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
										PreparedStatement ps_cat_list = con.prepareStatement("select CR_Category_Id from cr_category_relation_tbl where CR_No="
																+ rs_edit.getInt("CR_No"));
										ResultSet rs_cat_list = ps_cat_list.executeQuery(); 
										while (rs_cat_list.next()) {
										PreparedStatement ps_cat_name = con.prepareStatement("select CR_Category from cr_tbl_category where CR_Category_Id="
																	+ rs_cat_list.getInt("CR_Category_Id"));
										ResultSet rs_cat_name = ps_cat_name.executeQuery();
										while (rs_cat_name.next()) {
									%> -> <label><%=rs_cat_name.getString("CR_Category")%></label><br> <%
 									}
 										}
 									%>
								</td>
								<td>
									<%
										PreparedStatement ps_type_list = con.prepareStatement("select CR_Type_Id from cr_ctype_relation_tbl where CR_No="
																+ rs_edit.getInt("CR_No"));
										ResultSet rs_type_list = ps_type_list.executeQuery();

										while (rs_type_list.next()) {
										PreparedStatement ps_type = con.prepareStatement("select CR_Type from cr_tbl_type where CR_type_Id="
																	+ rs_type_list.getInt("CR_Type_Id"));
										ResultSet rs_type = ps_type.executeQuery();
										while (rs_type.next()) {
									%> -> <label><%=rs_type.getString("CR_Type")%></label> <br><%
 									}
 										}
 									%>
								</td> 
								<td><label><%=rs_edit.getString("Proposed_Impl_Date")%></label></td>
								<%
									if (rs_edit.getString("Actual_Impl_Date").equals(
													"0002-11-30 00:00:00.0")) {
								%>
								<td align="center"></td>
								<%
									} else {
								%>
								<td><label><%=rs_edit.getString("Actual_Impl_Date")%></label></td>
								<%
									}
								%>
								<td><label><%=rs_edit.getString("Complaint_No")%></label></td>
							</tr> 
							<tr>
								<th colspan="3" align="left"><b>Present System</b></th>
								<th colspan="3" align="left"><b>Proposed System</b></th>
								<th colspan="2" align="left"><b>Objective</b></th>
								<th colspan="1" align="left"><b>Attachments</b></th>
							</tr>
							<tr>
								<td colspan="3" align="left"><%=rs_edit.getString("Present_System")%></td>
								<td colspan="3" align="left"><%=rs_edit.getString("Proposed_System")%></td> 
								<td colspan="2" align="left"><%=rs_edit.getString("Objective")%></td>
								<td colspan="1" align="left">
								<%
										PreparedStatement ps_file1 = null;
										ps_file1 = con.prepareStatement("select * from cr_tbl_attachment where CR_No="
															+ cr_No + " and Del_Status=1");
											ResultSet rs_file1 = ps_file1.executeQuery();
											while (rs_file1.next()) {
									%>
									<table width="390px">
										<tr>
											<td width="270px" align="left"><a href="Display_Attach.jsp?field=<%=rs_file1.getString("File_Name")%>" style="color: blue;"><b> <%=rs_file1.getString("File_Name")%></b></a>
												<%--<input
												type="button" value=" Remove "
												onclick="showState111(<%=rs_file1.getInt("Cr_Attach_Id")%>)">
											 --%></td>
										</tr>
									</table> 
									<%
 											}
									%> 
								</td>
							</tr>
							<%
								}
							%>
						 	<tr>
								<th colspan="2" align="center"><b>Approver Name</b></th> 
								<th colspan="2" align="center"><b>Approve Type</b></th> 
								<th colspan="2" align="center"><b>Approve Date</b></th> 
								<th colspan="3" align="center"><b>Remark</b></th>
							</tr>
							<%
								PreparedStatement ps_appr_details = con.prepareStatement("select * from cr_tbl_approval where CR_no=" + cr_No); 
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
								%>
								<td colspan="2" align="left"><%=rs_U_Name.getString("U_Name")%> </td>
								<%
									}

											PreparedStatement ps_A_Name = con.prepareStatement("select Approval_Type from Cr_tbl_Approval_Type where Approval_Id="
															+ rs_appr_details.getInt("Approval_Id"));
											ResultSet rs_A_Name = ps_A_Name.executeQuery();
											while (rs_A_Name.next()) {
								%>
								<td colspan="2" align="left"><%=rs_A_Name.getString("Approval_Type")%>
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
								<td colspan="2" align="left"><%=rs_Remark.getString("CR_Approval_Date")%></td> 
								<td colspan="3" align="left"><%=rs_Remark.getString("Remark")%></td>
								<%
									}
								%> 
							</tr>
							<%
								}
							%>
  							<tr>
								<th align="center"><b>Action No</b></th>
								<th align="center" colspan="2"><b>Action Description</b></th>
								<th align="center"><b>Action Date</b></th> 
								<th align="center" colspan="2"><b>Proposed Output</b></th>
								<th align="center" colspan="2"><b>Actual Output</b></th>
								<th align="center"><b>Attachments</b></th> 
							</tr>
							<%
								PreparedStatement ps_action_no = con.prepareStatement("select * from cr_tbl_action where CR_no="
													+ cr_No);

									ResultSet rs_action_no = ps_action_no.executeQuery();
									int cnt = 0;
									while (rs_action_no.next()) {

										cnt++;
							%>
							<tr>
								<td align="center"><%=cnt%></td>
								<td align="left" colspan="2"><%=rs_action_no.getString("Action_Discription")%></td>
								<td align="left"><%=rs_action_no.getTimestamp("Action_Date")%></td>
								<td align="left" colspan="2"><%=rs_action_no.getString("proposed_Output")%></td>
								<td align="left" colspan="2"><%=rs_action_no.getString("Actual_Output")%></td>
								<td>
								<table>
									<%
												PreparedStatement ps_file = null;
												ps_file = con.prepareStatement("select * from cr_tbl_action_attachment where CR_Action_Id="
																+ rs_action_no.getInt("CR_Action_Id")
																+ " and delete_Status=1");
												ResultSet rs_file = ps_file.executeQuery();
												while (rs_file.next()) {
									%>
										<tr>
											<td align="left">
											<a href="Display.jsp?field=<%=rs_file.getString("File_Name")%>" style="color: blue;"><%=rs_file.getString("File_Name")%></a>
												<input type="button" value=" Remove " onclick="showState(<%=rs_file.getInt("Cr_Attach_Id")%>)" style="font-weight: bold; background-color: #BFBFBF;"></td>
										</tr>
									<%
 									}
 									%>
 									</table>
								</td>
								<%
									}
								%>
							</tr> 
							<tr style="background-color: #e66a0f;color: white;">
								<td colspan="6"><b>Add Actions ==></b></td>  
							</tr> 
							<tr>
								<td colspan="3"><b>Action Discription =></b></td>
								<td colspan="3"><b>Proposed Output =></b></td> 
							</tr> 
							<tr>
								<td align="left" colspan="3"><textarea style="background-color: #d2e9f0" cols="30" rows="3" name="Action_disc" id="Action_disc"></textarea></td>
								<td align="left" colspan="3"><textarea style="background-color: #d2e9f0" cols="30" rows="3" name="Prop_output" id="Prop_Action"></textarea></td>
							</tr>
							<tr>
								<td colspan="3"><b>Proposed Date =></b><br> <input id="demo3" name="proposeddate" type="text" size="25" readonly="readonly"  style="background-color: #d2e9f0">
									<a href="javascript:NewCal('demo3','ddmmyyyy',true,24)"><img src="cal.gif" width="16" height="16" border="0" alt="Pick a date"></td>
								<td colspan="3"><b>Actual Implementation Date =></b><br> <input id="demo4" name="actualimpldate" type="text" size="25" readonly="readonly"  style="background-color: #d2e9f0"> <a href="javascript:NewCal('demo4','ddmmyyyy',true,24)"> <img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></td>
							</tr>
							<tr>
								<td colspan="6"><b>ATTACH FILE (Optional) =></b><br>
									<table id="tblSample">
										<tr style="background-color: #d2e9f0">
											<td><strong> <input type="button" style="background-color: #d2e9f0" value="  ADD More Files  " name="button" onclick="addRowToTable();" /></strong></td>
											<td><input type="button" value=" Delete[Selected] " onclick="deleteChecked();" />&nbsp;&nbsp; <input type="hidden" id="srno" name="srno" value=""></td>
										</tr>
										<tbody></tbody>
									</table></td>
							</tr>

						</table>
						<%
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
						<table>
							<tr>
								<td><input type="submit" value="Done" name="done"
									style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;"
									onclick="submitDone();"></td> 
								<td></td>
								<td></td> 
								<td align="center"><input type="submit"
									value="Add More Actions"
									style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;"
									onclick="SubmitAction()"> <input type="hidden"
									name="mytext" id="mytext"></td> 
							</tr> 
						</table> 
					</form> 
				</div> 
	<div id="templatemo_footer_wrapper">
		<div id="templatemo_footer">
			| Copyright 2013 <a href="http://www.muthagroup.com">Muthagroup
				Satara</a> |
			<div class="cleaner"></div>
		</div>
	</div>
<!--============================================================================-->
<!--============================================================================-->

</body>
</html>