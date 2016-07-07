<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ECN Edit Request</title>
<!--==================== Design Script ================================-->
<!--============================================================================-->
<meta name="keywords"
	content="graphite theme, free templates, website templates, CSS, HTML" />
<meta name="description"
	content="Graphite Theme, Contact page, free CSS template provided by templatemo.com" />
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />

<style>
div.scroll {
	background-color: #F0EBF2;
	width: 1010px;
	height: 600px;
	overflow: scroll;
}
</style>




<script src="js/script.js"></script>

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#EDEDED';
		}
	}

	/* function DoNav(theUrl) {
		document.location.href = theUrl;
		//	document.getElementById("frm1").submit();
	} */
</script>
<script language="javascript">
	function button1(val) {
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		edit.submit();
	}
</script>

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
<script type="text/javascript" src="js/ddsmoothmenu.js">
	/***********************************************
	 * Smooth Navigational Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
	 * This notice MUST stay intact for legal use
	 * Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
	 ***********************************************/
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
<!--============================================================================-->
<!--============================================================================-->
</head>

<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>


<body id="sub_page">
	<div id="templatemo_wrapper">
		<div id="templatemo_top"></div>
		<!-- end of top -->

<!--============================================================================-->
<!--======================= Menu Bar =================================-->

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
		<!-- end of templatemo_menu -->
		
		<!--============================================================================-->
		<!--============================================================================-->
		<div id="templatemo_menu">
			<div id="site_title">
				<h1 style="color: orange;">ECN</h1>
			</div>
		</div>

		<!-- end of header -->

		<div id="templatemo_main">
			<h4 style="color: white;">Edit Request Customer</h4>
			<div class="col_w630 float_l">
				<div id="contact_form">

					<div id="templatemo_header" class="ddsmoothmenu">

						<ul>

							<li style="background-color: #B3A6AA;"><a
								href="Cab_Edit_Request.jsp">Edit Request Internal</a></li>
							<li style="background-color: #B3A6AA;"><a
								href="Cab_Edit_Request_Customer.jsp">Edit Request Customer</a></li>
						</ul>

					</div>


					<%
						try {
							HashMap hm = new HashMap();
							int uid = 0;
							int ap_id = 0;
							int cr_no1 = 0;
							ArrayList cr_list = new ArrayList();
							ArrayList cr_list1 = new ArrayList();
							ArrayList approval_list = new ArrayList();

							Connection con = Connection_Utility.getConnection();

							uid = Integer.parseInt(session.getAttribute("uid").toString());

							PreparedStatement ps_uidappr = con
									.prepareStatement("select * from user_tbl where U_Id="
											+ uid);
							String UName = null;
							ArrayList id1 = new ArrayList();
							ResultSet rs_uidappr = ps_uidappr.executeQuery();
							while (rs_uidappr.next()) {
								UName = rs_uidappr.getString("U_Name");
								PreparedStatement ps_id = con
										.prepareStatement("select * from user_tbl where U_Name='"
												+ UName + "'");
								ResultSet rs_id = ps_id.executeQuery();
								while (rs_id.next()) {
									id1.add(rs_id.getInt("U_Id"));
								}
							}

							for (int s = 0; s < id1.size(); s++) {
								PreparedStatement ps_ap_id = con
										.prepareStatement("select crc_no from crc_tbl_approval where u_id="
												+ Integer.parseInt(id1.get(s).toString())
												+ " and CRC_Approval_id=2");

								ResultSet rs_ap_id = ps_ap_id.executeQuery();

								while (rs_ap_id.next()) {

									System.out.print("CRC No..."
											+ rs_ap_id.getInt("CRC_No"));
									approval_list.add(rs_ap_id.getInt("CRC_No"));

								}
							}
					%>
					<!-- <form method="post" name="contact" action="Edit_Request.jsp"> -->
					<form method="post" name="edit" action="Edit_Request_Customer.jsp"
						id="edit">


						<table width="1000px">
							<thead style="color: #FAF7F2; background-color: #2B2A29;">
								<tr>
									<td align="center" width="50px">CR NO</td>
									<td align="center" width="50px">Supplier Name</td>
									<td align="center" width="230px">Customer Name</td>
									<td align="center" width="230px">Item Name</td>
									<td align="center" width="50px">Change For</td>
									<td align="center" width="60px">Change Request Date</td>
									<td align="center" width="50px">Total Stock</td>
									<td align="center" width="60px">Targeted Impl. Date</td>
									<td align="center" width="50px">Approval Status</td>
									<!--  		<td align="center" width="110px">Action</td>-->
								</tr>
							</thead>
						</table>

						<div class="scroll">
							<table width="1000px">
								<tbody>

									<%
										for (int s = 0; s < id1.size(); s++) {

												String sqlPagination = "SELECT * FROM CRC_Tbl where u_id="
														+ Integer.parseInt(id1.get(s).toString());
												PreparedStatement psPagianation = null;
												ResultSet rs_CR_Details = null;

												psPagianation = con.prepareStatement(sqlPagination);
												rs_CR_Details = psPagianation.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CRC_No");
									%>
									<tr onmouseover="ChangeColor(this, true);"
										onmouseout="ChangeColor(this, false);"
										onclick="button1('<%=cr_no%>');">
										<td align="center" width="50px"><%=cr_no%></td>
										<%
											PreparedStatement ps_company = con
																.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
																		+ rs_CR_Details.getInt("Company_Id"));
														ResultSet rs_company = ps_company.executeQuery();
														while (rs_company.next()) {
										%>
										<td align="center" width="50px"><%=rs_company.getString("Company_Name")%></td>
										<%
											}

														PreparedStatement ps_cust = con
																.prepareStatement("select Cust_Name from customer_tbl where Cust_Id="
																		+ rs_CR_Details.getInt("Cust_Id"));
														ResultSet rs_cust = ps_cust.executeQuery();
														while (rs_cust.next()) {
										%>
										<td align="center" width="230px"><%=rs_cust.getString("Cust_Name")%></td>

										<%
											}

														PreparedStatement ps_item = con
																.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
																		+ rs_CR_Details.getInt("Item_Id"));
														ResultSet rs_item = ps_item.executeQuery();
														while (rs_item.next()) {
										%>
										<td align="center" width="230px"><%=rs_item.getString("Item_Name")%></td>
										<%
											}
										%>
										<td align="center" width="50px"><%=rs_CR_Details.getString("Change_For")%></td>
										<td align="center" width="60px"><%=rs_CR_Details.getString("CRC_Date")%></td>
										<td align="center" width="50px"><%=rs_CR_Details.getString("Total_Stock")%></td>
										<td align="center" width="60px"><%=rs_CR_Details.getString("Targated_Impl_Date")%></td>
										<%
											ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con
																.prepareStatement("select U_Id from crc_tbl_approver_rel where CRC_No="
																		+ cr_no);

														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con
																	.prepareStatement("select Approval_Id from crc_tbl_Approval where CRC_No="
																			+ cr_no
																			+ " and U_Id="
																			+ Integer.parseInt(appr_list.get(
																					appr).toString()));

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

															id = Integer.parseInt(appr_id_list.get(appr_id)
																	.toString());

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
															hm.put(cr_no, "declined");
										%>
										<td align="center" width="110px">Declined</td>
										<%
											} else if (cnt1 == appr_id_list.size()) {
															hm.put(cr_no, "approved");
										%>
										<td align="center" width="50px">Approved</td>
										<%
											} else {
															hm.put(cr_no, "pending");
										%>
										<td align="center" width="50px">Pending</td>
										<%
											}
										%>

										<!-- 	<td align="center" width="110px">
											<button onclick="button1(this.value)" name="edit_button"
												id="edit_button" value="">Take</button>
										</td>
 -->
										<input type="hidden" name="hid" id="hid" value="<%=cr_no%>">
											<%
												}
													}
													session.setAttribute("hashSesObject", hm);
													//	System.out.println("Testing map==== >" + hm.get(cr_no));
												} catch (Exception e) {
													e.printStackTrace();
												}
											%>
										
									</tr>
								</tbody>

							</table>
						</div>
					</form>
				</div>
			</div>

			<div class="cleaner"></div>
		</div>
		<!-- end of main -->
	</div>
	<!-- end of wrapper -->

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