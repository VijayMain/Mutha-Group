<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<title>My Approvals</title> 
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
<script type="text/javascript" src="js/ddsmoothmenu.js"></script>
<script type="text/javascript">
	ddsmoothmenu.init({
		mainmenuid : "templatemo_menu", //menu DIV id
		orientation : 'h', //Horizontal or vertical menu: Set to "h" or "v"
		classname : 'ddsmoothmenu', //class added to menu's outer DIV
		//customtheme: ["#1c5a80", "#18374a"],
		contentsource : "markup" //"markup" or ["container_id", "path_to_menu_file"]
	});
</script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<!-- <script type="text/javascript" src="js/piroBox.1_2.js"></script> -->
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
		approve.submit();
	}
</script> 
</head>

<body id="sub_page">
		<%
						try { 
							int uid = 0;
 							int ap_id = 0;
							int cr_no1 = 0;
							ArrayList cr_list = new ArrayList();
							ArrayList cr_list1 = new ArrayList();
							ArrayList approval_list = new ArrayList();
 							Connection con = Connection_Utility.getConnection();
 							uid = Integer.parseInt(session.getAttribute("uid").toString());
 							PreparedStatement ps_uidappr = con.prepareStatement("select * from user_tbl where U_Id=" + uid);
							String UName = null;
							ArrayList id1 = new ArrayList();
							ResultSet rs_uidappr = ps_uidappr.executeQuery();
							while (rs_uidappr.next()) {
								UName = rs_uidappr.getString("U_Name");
								PreparedStatement ps_id = con.prepareStatement("select * from user_tbl where U_Name='" + UName + "'");
								ResultSet rs_id = ps_id.executeQuery();
								while (rs_id.next()) {
									id1.add(rs_id.getInt("U_Id"));
								}
							}

							for (int s = 0; s < id1.size(); s++) {
								PreparedStatement ps_ap_id = con.prepareStatement("select cr_no from cr_tbl_approval where u_id="
												+ Integer.parseInt(id1.get(s).toString())
												+ " and Approval_id=2");

								ResultSet rs_ap_id = ps_ap_id.executeQuery();

								while (rs_ap_id.next()) { 
									// System.out.print("CR No..." + rs_ap_id.getInt("CR_No"));
									approval_list.add(rs_ap_id.getInt("CR_No")); 
								}
							}
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
				<li><a href="logout.jsp">Log Out  <b style="font-size: 9px;">( <%=UName%> )</b></a></li>
			</ul>
		</div>

<!-- 
============================================================================
============================================================================
		<div id="templatemo_menu">
			<div id="site_title">
				<h1 style="color: orange;">ECN</h1>
			</div>
		</div>

		end of header 
 -->
		<!-- <div id="templatemo_main">
			<h4 style="color: white;">My Approvals Internal</h4>
			<div class="col_w630 float_l">
				<div id="contact_form"> -->

					<!-- <div id="templatemo_header" class="ddsmoothmenu"> 
						<ul>
							<li style="background-color: #B3A6AA;"><a href="My_Approvals.jsp">Internal</a></li>
							<li style="background-color: #B3A6AA;"><a href="My_Approvals_Customer.jsp">Customer</a></li>
							<li style="background-color: #B3A6AA;"><a href="All_Requests.jsp">All Requests</a></li>
						</ul>
					</div> -->
					
					<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%"> 
						<ul>
							<li style="background-color: #1c6f8a;color: white;"><a href="My_Approvals.jsp"><b>Internal</b></a></li>
							<li style="background-color: #B3A6AA;"><a href="My_Approvals_Customer.jsp">Customer</a></li>
							<li style="background-color: #B3A6AA;"><a href="All_Requests.jsp">All Internal</a></li>
							<li style="background-color: #B3A6AA;"><a href="All_Requests_Customer.jsp">All Customer</a></li>
						</ul>
					</div>  
					<!-- <form method="post" name="contact" action="Edit_Request.jsp"> -->
					<form method="post" name="approve" action="My_Approvals_Result.jsp" id="approve">
						<%
							ArrayList cr = new ArrayList(); 
								for (int s = 0; s < id1.size(); s++) {

									PreparedStatement ps_cr = con.prepareStatement("select cr_no from cr_Tbl_approval where u_id="
													+ Integer.parseInt(id1.get(s).toString()));
									ResultSet rs_cr = ps_cr.executeQuery(); 
									while (rs_cr.next()) {
										cr.add(rs_cr.getInt("CR_No"));
									} 
								}

								// System.out.println("Cr number list = " + cr);
								PreparedStatement psPagianation = null;
								ResultSet rs_CR_Details = null;
						%>
					<div style="height: 550px;width: 100%;overflow: scroll;">  
					<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th>CR NO</th>
									<th>Supplier Name</th>
									<th>Item Name</th>
									<th>Category</th>
									<th>Change Request Date</th>
									<th>Proposed Impl. Date</th>
									<!-- <th>Actual Impl. Date</th> -->
									<th>Approval Status</th> 
								</tr>
									<%
										for (int crno = 0; crno < cr.size(); crno++) {

												String sqlPagination = "SELECT * FROM CR_Tbl where CR_No="
														+ Integer.parseInt(cr.get(crno).toString())
														+ " order by cr_no";
												// System.out.println("Testing Cr No2 = " + Integer.parseInt(cr.get(crno).toString()));
												psPagianation = con.prepareStatement(sqlPagination);
												rs_CR_Details = psPagianation.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
													// System.out.println("Testing Cr No = " + cr_no);
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=cr_no%>');" style="cursor: pointer;">
										<td align="right"><%=cr_no%></td>
										<%
											PreparedStatement ps_company = con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id=" + rs_CR_Details.getInt("Company_Id"));
											ResultSet rs_company = ps_company.executeQuery();
											while (rs_company.next()) {
										%>
										<td align="left"><%=rs_company.getString("Company_Name")%></td>
										<%
											}
											PreparedStatement ps_item = con.prepareStatement("select Item_Name from customer_tbl_item where Item_Id=" + rs_CR_Details.getInt("Item_Id"));
											ResultSet rs_item = ps_item.executeQuery();
											while (rs_item.next()) {
										%>
										<td align="left"><%=rs_item.getString("Item_Name")%></td>
										<td align="left" width="200"> 
												<%
													}
													PreparedStatement ps_category_id = con.prepareStatement("select CR_Category_Id from CR_category_relation_tbl where CR_No=" + cr_no);
													ResultSet rs_category_id = ps_category_id.executeQuery();
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
												<label><%=rs_category.getString("CR_Category") %></label>, 
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>

										<%-- <%
											if (rs_CR_Details.getString("Actual_Impl_Date").equals(
																"0002-11-30 00:00:00.0")) {
										%>
										<td align="center" width="110px">0000-00-00 00:00:00.0</td>
										<%
											} else {
										%>
										<td align="center" width="110px"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
										<%
											}
										%> --%>
										<%
														//ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														/* PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="+ cr_no);

														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) { */
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="	+ cr_no);
															ResultSet rs_appr = ps_appr.executeQuery();
															while (rs_appr.next()) {
																appr_id_list.add(rs_appr.getInt("Approval_Id"));
															}

														/* } */
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
										<%-- 				<td align="center" width="110px">
											<button onclick="button1(this.value)" name="edit_button"
												id="edit_button" value="<%=cr_no%>">Take</button>
										</td>--%> 
										<input type="hidden" name="hid" id="hid">
									</tr>
									<%
										}
											}
										} catch (Exception e) {
											e.printStackTrace();
										}
									%> 
							</table> 
						</div>
					</form>
 
<!--============================================================================-->
<!--============================================================================-->
</body>
</html>