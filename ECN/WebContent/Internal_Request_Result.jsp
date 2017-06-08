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
<script type="text/javascript" src="js/ddsmoothmenu.js"> </script>
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
</head>
<body id="sub_page">
<%
try {
	Connection con = Connection_Utility.getConnection();
	int cr_No = 0;
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
			<a href="All_Requests.jsp"><strong style="font-size: 5mm;"><== Go Back </strong></a>
			<form method="post" action="Cab_ApproveDecline_Request_Controller" onsubmit="return(validate());" name="myForm">
			<table style="width: 100%;" class="tftable">
							<% 
									cr_No = Integer.parseInt(request.getParameter("hid"));
									PreparedStatement ps_edit = con.prepareStatement("select * from CR_tbl where CR_No=" + cr_No);
									ResultSet rs_edit = ps_edit.executeQuery();
									int company_id = 0;
									while (rs_edit.next()) {
							%>
							<input type="hidden" name="crno" value="<%=cr_No%>">
							<tr style="height: 27px;">
								<th><b>Request Number</b></th>
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
								<td align="center"><b style="font-size: 12px;"><%=cr_No%></b></td>
								<td align="left"><label><%=rs_edit.getString("CR_Date")%></label></td>
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
								<td align="left"><label><%=rs_item.getString("Item_Name")%></label></td>
								<%
									}
								%>
								<td>
									<%
										PreparedStatement ps_cat_list = con.prepareStatement("select CR_Category_Id from cr_category_relation_tbl where CR_No=" + rs_edit.getInt("CR_No"));
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
								<td align="left">
									<%
										PreparedStatement ps_type_list = con.prepareStatement("select CR_Type_Id from cr_ctype_relation_tbl where CR_No=" + rs_edit.getInt("CR_No"));
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
								<td align="left"><label><%=rs_edit.getString("Proposed_Impl_Date")%></label>`</td>
								<%
									if (rs_edit.getString("Actual_Impl_Date").equals(
													"0002-11-30 00:00:00.0")) {
								%>
								<td align="left"></td>
								<%
									} else {
								%> 
								<td align="left"><label><%=rs_edit.getString("Actual_Impl_Date")%></label></td>
								<%
									}
								%>
								<td align="left"><label><%=rs_edit.getString("Complaint_No")%></label></td>
							</tr> 
							<tr> 
								<th colspan="2" align="center"><b>Tracking Changes</b></th>
								<th colspan="2" align="center"><b>Present System</b></th>
								<th colspan="3" align="center"><b>Proposed System</b></th>
								<th colspan="3" align="center"><b>Objective</b></th> 
							</tr>  
							<tr>
								<td colspan="2" align="left">
									<%
										PreparedStatement ps_tc_id = con.prepareStatement("select TC_Id from cr_tc_rel_tbl where Cr_No=" + cr_No);
										ResultSet rs_tc_id = ps_tc_id.executeQuery();
												while (rs_tc_id.next()) {
													PreparedStatement ps_tc = con.prepareStatement("Select * from cr_tracking_change where TC_Id=" + rs_tc_id.getInt("TC_Id"));
													ResultSet rs_tc = ps_tc.executeQuery();
													while (rs_tc.next()) {
									%> <label> -><%=rs_tc.getString("TC_Type")%> </label><br> 
									<%
 									}
 											}
 									%>
								</td>
								<td colspan="2" align="left"><%=rs_edit.getString("Present_System")%> </td> 
								<td colspan="3" align="left"><%=rs_edit.getString("Proposed_System")%></td> 
								<td colspan="3" align="left"><%=rs_edit.getString("Objective")%></td>
							</tr>   
							<tr>
								<th colspan="4" align="center"><b>Requester </b></th>
								<th colspan="5" align="center"><b>Attachments </b></th>
							</tr>
							<tr>
								<td colspan="4" align="left">
									<%
										PreparedStatement ps_UName = con.prepareStatement("select U_Name from User_tbl where U_Id=" + rs_edit.getInt("U_Id"));
										ResultSet rs_UName = ps_UName.executeQuery();
												while (rs_UName.next()) {
									%> <label> <%=rs_UName.getString("U_Name")%></label> <%
								 	}
 										}
 									%>
								</td>
								<td colspan="5" align="left">
									<% 		
									PreparedStatement ps_file1 = null;
									ps_file1 = con.prepareStatement("select * from cr_tbl_attachment where CR_No=" + cr_No + " and Del_Status=1");
									ResultSet rs_file1 = ps_file1.executeQuery();
									while (rs_file1.next()) {
									%>
									<a href="Display_Attach.jsp?field=<%=rs_file1.getString("File_Name")%>" style="color: #396E2F"><b> <%=rs_file1.getString("File_Name")%></b></a>
									<%
 										}
 									%>
								</td> 
							</tr> 
							<tr>
								<th align="center" colspan="3"><b>Approver Name</b></th>
								<th align="center" colspan="2"><b>Approve Type</b></th>
								<th align="center" colspan="1"><b>Approve Date</b></th>
								<th align="center" colspan="3"><b>Remark</b></th>
							</tr>
							<%
								PreparedStatement ps_appr_details = con.prepareStatement("select * from cr_tbl_approval where CR_no=" + cr_No);
								ResultSet rs_appr_details = ps_appr_details.executeQuery();
								while (rs_appr_details.next()) {
							%>
							<tr>
								<%
									PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from user_tbl where U_Id=" + rs_appr_details.getInt("U_Id"));
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
											PreparedStatement ps_Remark = con.prepareStatement("select Remark,CR_Approval_Date from Cr_tbl_Approval where U_Id="
															+ rs_appr_details.getInt("U_Id")
															+ " and CR_No=" + cr_No); 
											ResultSet rs_Remark = ps_Remark.executeQuery(); 
											while (rs_Remark.next()) {
								%>
								<td colspan="1" align="left"><%=rs_Remark.getString("CR_Approval_Date")%></td>
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
								<th align="center"><b>A. No</b></th>
								<th colspan="2" align="center"><b>Action Description</b></th>
								<th align="center"><b>Action Date</b></th>
								<th colspan="2" align="center"><b>Proposed Output</b></th>
								<th colspan="2" align="center"><b>Actual Output</b></th>
								<th align="center"><b>Attachments</b></th>
							</tr>
							<%
								PreparedStatement ps_action_no = con.prepareStatement("select * from cr_tbl_action where CR_no=" + cr_No);
 									ResultSet rs_action_no = ps_action_no.executeQuery();
									int cnt = 0;
									while (rs_action_no.next()) {
 										cnt++;
							%>
							<tr>
								<td align="right" width="10px"><%=cnt%></td> 
								<td align="left" colspan="2"><%=rs_action_no.getString("Action_Discription")%></td> 
								<td align="left"><%=rs_action_no.getString("Action_Date")%></td> 
								<td align="left" colspan="2"><%=rs_action_no.getString("Proposed_Output")%></td> 
								<td align="left" colspan="2"><%=rs_action_no.getString("Actual_Output")%></td>
								<td align="left">
									<% 
												PreparedStatement ps_file = null; 
												ps_file = con.prepareStatement("select * from cr_tbl_action_attachment where CR_Action_Id="
																+ rs_action_no.getInt("CR_Action_Id")
																+ " and delete_Status=1");
												ResultSet rs_file = ps_file.executeQuery();
												while (rs_file.next()) {
									%> 
									<a href="Display.jsp?field=<%=rs_file.getString("File_Name")%>"><%=rs_file.getString("File_Name")%></a><br>
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