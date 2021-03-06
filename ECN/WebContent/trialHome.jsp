<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.mysql.jdbc.ResultSetRow"%>
<%@page import="java.util.ArrayList"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ECN Home</title>
<!--============================================================================-->
<!--=================== Design Script ===================================-->
<!--============================================================================-->
<meta name="keywords"
	content="graphite theme, free templates, website templates, CSS, HTML" />
<meta name="description"
	content="Graphite Theme, Contact page, free CSS template provided by templatemo.com" />
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />

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
<script language="javascript">
	function button1(val) {
		var val1 = val;
		alert(val1);
		document.getElementById("hid").value = val1;
		edit.submit();
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
	<div id="templatemo_wrapper">
		<div id="templatemo_top"></div>
		<!-- end of top -->

<!--============================================================================-->
<!--========================== Menu Bar ==========================-->
<!--============================================================================-->
		<div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp">Home</a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<li><a href="Cab_Edit_Request.jsp">Edit Request</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
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
			<h4>ECN Home</h4>
			<div class="col_w630 float_l">
				<div id="contact_form">
					<%
						try {

							int uid = 0;
							int ap_id = 0;
							int cr_no1 = 0;
							ArrayList cr_list = new ArrayList();

							ArrayList approval_list = new ArrayList();

							uid = Integer.parseInt(session.getAttribute("uid").toString());

							Connection con = Connection_Utility.getConnection();

							uid = Integer.parseInt(session.getAttribute("uid").toString());

							PreparedStatement ps_cr_appr_rl = con
									.prepareStatement("select cr_no from cr_approver_relation_tbl where U_id="
											+ uid);

							ResultSet rs_cr_appr_rl = ps_cr_appr_rl.executeQuery();

							while (rs_cr_appr_rl.next()) {
								cr_list.add(rs_cr_appr_rl.getInt("CR_No"));
							}

							for (int i = 0; i < cr_list.size(); i++) {
								PreparedStatement ps_ap_id = con
										.prepareStatement("select approval_id,cr_no from cr_tbl_approval where Cr_no="
												+ cr_list.get(i) + " and u_id=" + uid);

								ResultSet rs_ap_id = ps_ap_id.executeQuery();

								while (rs_ap_id.next()) {
									ap_id = rs_ap_id.getInt("Approval_id");
									cr_no1 = rs_ap_id.getInt("CR_No");
									if (ap_id == 2) {
										approval_list.add(cr_no1);
									}

								}

							}
					%>
					<!-- <form method="post" name="contact" action="Edit_Request.jsp"> -->
					<form method="post" name="contact"
						action="Cab_ApproveDecline_Request.jsp">



						<table style="width: 1100px">
							<thead style="color: #FAF7F2; background-color: #2B2A29;">
								<tr>
									<td align="center">CR NO</td>
									<td align="center">Supplier Name</td>
									<td align="center">Item Name</td>
									<td align="center">Category</td>
									<td align="center">Change Request Date</td>
									<td align="center">Proposed Impl. Date</td>
									<td align="center">Actual Impl. Date</td>
									<td align="center">Requested By</td>
									<td align="center">Approval Status</td>
									<td align="center">Action</td>
								</tr>
							</thead>

							<tbody>


								<tr>
									<%
										for (int f = 0; f < approval_list.size(); f++) {

												PreparedStatement ps_CR_Details = con
														.prepareStatement("select * from CR_tbl where CR_No="
																+ Integer.parseInt(approval_list.get(f)
																		.toString()) + " order by CR_date");

												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
									%>
									<td align="center"><%=cr_no%></td>
									<%
										PreparedStatement ps_company = con
															.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
																	+ rs_CR_Details.getInt("Company_Id"));
													ResultSet rs_company = ps_company.executeQuery();
													while (rs_company.next()) {
									%>
									<td align="center"><%=rs_company.getString("Company_Name")%></td>
									<%
										}
													PreparedStatement ps_item = con
															.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
																	+ rs_CR_Details.getInt("Item_Id"));
													ResultSet rs_item = ps_item.executeQuery();
													while (rs_item.next()) {
									%>
									<td align="center"><%=rs_item.getString("Item_Name")%></td>
									<td align="center"><select class="required input_field"
										style="width: 70px">
											<%
												}
															PreparedStatement ps_category_id = con
																	.prepareStatement("select CR_Category_Id from CR_category_relation_tbl where CR_No="
																			+ cr_no);
															ResultSet rs_category_id = ps_category_id
																	.executeQuery();

															ArrayList cat_id = new ArrayList();

															while (rs_category_id.next()) {
																cat_id.add(rs_category_id.getInt("CR_Category_Id"));
															}
															//System.out.println("Home Test = " + cat_id);
															for (int j = 0; j < cat_id.size(); j++) {
																PreparedStatement ps_category = con
																		.prepareStatement("select * from CR_tbl_category where CR_Category_Id="
																				+ Integer.parseInt(cat_id.get(j)
																						.toString()));
																ResultSet rs_category = ps_category.executeQuery();
																while (rs_category.next()) {
											%>
											<option value="<%=rs_category.getInt("CR_Category_Id")%>"><%=rs_category.getString("CR_Category")%></option>
											<%
												}
															}
											%>
									</select></td>
									<td align="center"><%=rs_CR_Details.getString("CR_Date")%></td>
									<td align="center"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>
									<td align="center"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
									<%
										PreparedStatement ps_U_Name = con
															.prepareStatement("select U_Name from User_Tbl where U_Id="
																	+ rs_CR_Details.getString("U_Id"));

													ResultSet rs_U_Name = ps_U_Name.executeQuery();
													while (rs_U_Name.next()) {
									%>


									<td align="center"><%=rs_U_Name.getString("U_Name")%></td>


									<%
										}

													ArrayList appr_list = new ArrayList();
													ArrayList appr_id_list = new ArrayList();
													PreparedStatement ps_appr_list = con
															.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="
																	+ cr_no);

													ResultSet rs_appr_list = ps_appr_list.executeQuery();

													while (rs_appr_list.next()) {
														appr_list.add(rs_appr_list.getInt("U_Id"));
													}

													for (int appr = 0; appr < appr_list.size(); appr++) {
														PreparedStatement ps_appr = con
																.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
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
									%>
									<td align="center">Declined</td>
									<%
										} else if (cnt1 == appr_id_list.size()) {
									%>
									<td align="center">Approved</td>
									<%
										} else {
									%>
									<td align="center">Pending</td>
									<%
										}
									%>
									<td align="center">
										<button onclick="button1(this.value)" name="edit_button"
											id="edit_button" value="<%=cr_no%>">Approve/Decline</button>
									</td>

									<td><input type="hidden" name="hid" id="hid"></td>
								</tr>

								<%
									}
										}

									} catch (Exception e) {
										e.printStackTrace();
									}
								%>

							</tbody>
							<thead style="color: #FAF7F2; background-color: #2B2A29;">
								<tr>
									<td align="center">CR NO</td>
									<td align="center">Supplier Name</td>
									<td align="center">Item Name</td>
									<td align="center">Category</td>
									<td align="center">Change Request Date</td>
									<td align="center">Proposed Impl. Date</td>
									<td align="center">Actual Impl. Date</td>
									<td align="center">Requested By</td>
									<td align="center">Approval Status</td>
									<td align="center">Action</td>
								</tr>
							</thead>
						</table>



					</form>
<!--============================================================================-->
<!--============================================================================-->

				</div>
			</div>

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