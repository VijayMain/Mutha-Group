<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ECN Home</title>
<meta name="keywords" content="graphite theme, free templates, website templates, CSS, HTML" />
<meta name="description" content="Graphite Theme, Contact page, free CSS template provided by templatemo.com" />
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<style>
div.scroll {
	background-color: #F0EBF2;
	width: 1010px;
	height: 600px;
	overflow: scroll;
}
</style>
<style type="text/css">
.tftable {
	font-size: 11px;
	color: #333333;
	width: 100%;  
}

.tftable th {
	font-size: 12px;
	background-color: #388EAB; 
	padding: 3px; 
	color: white;
	text-align: center;
}

.tftable tr {
	background-color: white;
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
</script>
<link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ddsmoothmenu.js"> </script>
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
<script src="js/script.js"></script> 
<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = 'white';
		}
	}
</script>

<script language="javascript">
	function button1(val) {
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		search.submit();
	}
</script>
<!--////// END  \\\\\\\-->
<!--============================================================================-->
<!--============================================================================-->

</head>

<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<body id="sub_page">
<%
try {
//System.out.println("calling search req. for customer......"); 
int uid = 0;
uid = Integer.parseInt(session.getAttribute("uid").toString()); 
Connection con = Connection_Utility.getConnection(); 
ArrayList cr_list = (ArrayList) (session.getAttribute("disList")); 
 
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
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li><a href="My_Approvals.jsp">Details</a></li>
				<li><a href="Cab_Search_Request.jsp" style="background-color: #808080"><b>Search Request</b></a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li style="text-align: center;"><a href="logout.jsp">Log Out <b style="font-size: 9px;">( <%=user_name%> )</b></a></li>
			</ul> 
		</div>
		<div style="height: 550px;width: 100%;overflow: scroll;">			
					<!-- <form method="post" name="contact" action="Edit_Request.jsp"> -->
					<form method="post" name="search" action="Cab_ApproveDecline_Request_Customer.jsp" id="search">
							<table style="width: 100%;" class="tftable">
									<tr>
										<th align="center">CR NO</th>
										<th align="center">Supplier Name</th>
										<th align="center">Customer Name</th>
										<th align="center">Item Name</th>
										<th align="center">Change For</th>
										<th align="center">Change Request Date</th>
										<th align="center">Total Stock</th>
										<th align="center">Targeted Impl. Date</th>
										<th align="center">Approval Status</th> 
									</tr> 									
									<%
										for (int f = 0; f < cr_list.size(); f++) {
												PreparedStatement ps_CR_Details = con.prepareStatement("select * from CRC_tbl where CRC_No="
																+ Integer.parseInt((cr_list.get(f).toString()))
																+ " order by CRC_date");
												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CRC_No");
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=cr_no%>');" style="cursor: pointer;">
										<td align="right"><b><%=cr_no%></b></td>
										<%
											PreparedStatement ps_company = con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
																		+ rs_CR_Details.getInt("Company_Id"));
														ResultSet rs_company = ps_company.executeQuery();
														while (rs_company.next()) {
										%>
										<td align="left"><%=rs_company.getString("Company_Name")%></td>
										<%
											} 
														PreparedStatement ps_cust = con.prepareStatement("select Cust_Name from customer_tbl where Cust_Id="
																		+ rs_CR_Details.getInt("Cust_Id"));
														ResultSet rs_cust = ps_cust.executeQuery();
														while (rs_cust.next()) {
										%>
										<td align="left"><%=rs_cust.getString("Cust_Name")%></td>
										<%
											}
														PreparedStatement ps_item = con.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
																		+ rs_CR_Details.getInt("Item_Id"));
														ResultSet rs_item = ps_item.executeQuery();
														while (rs_item.next()) {
										%>
										<td align="left"><%=rs_item.getString("Item_Name")%></td>
										<%
											}
										%>
										<td align="left"><%=rs_CR_Details.getString("Change_For")%></td>
										<td align="left"><%=rs_CR_Details.getString("CRC_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Total_Stock")%></td>
										<td align="left"><%=rs_CR_Details.getString("Targated_Impl_Date")%></td>
										<%
											ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from crc_tbl_approver_rel where CRC_No="
																		+ cr_no); 
														ResultSet rs_appr_list = ps_appr_list.executeQuery();
														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from crc_tbl_Approval where CRC_No="
																			+ cr_no
																			+ " and U_Id="
																			+ Integer.parseInt(appr_list.get(appr).toString()));

															ResultSet rs_appr = ps_appr.executeQuery();
															while (rs_appr.next()) {
																appr_id_list.add(rs_appr.getInt("Approval_Id"));
															}

														}
														String Status = null;

														boolean flag = false;
														int cnt1 = 0;
														int cnt2 = 0;
														int cnt3 = 0;
														for (int appr_id = 0; appr_id < appr_id_list.size(); appr_id++) {
															int id = 0;

															id = Integer.parseInt(appr_id_list.get(appr_id).toString());

															if (id == 3) {
																cnt3++;
																//flag=true;
																break;
															} else if (id == 2) {
																cnt2++;
																continue;
															} else {
																cnt1++;
																continue;
															}

														}

														if (cnt3 > 0) {
										%>
										<td align="left">Declined</td>
										<%
											} else if (cnt1 == appr_id_list.size()) {
										%>
										<td align="left">Approved</td>
										<%
											} else {
										%>
										<td align="left">Pending</td>
										<%
											}
										%> 
										<input type="hidden" name="hid" id="hid" value="<%=cr_no%>">
											<%
												}
													}
												} catch (Exception e) {
													e.printStackTrace();
												}
											%>
							</table>
					</form>
				</div>
</body>
</html>