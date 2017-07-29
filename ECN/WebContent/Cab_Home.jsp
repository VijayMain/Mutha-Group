<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.mysql.jdbc.ResultSetRow"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ECN Internal Req</title> 
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" /> 
<style>
div.scroll {
	background-color: #F0EBF2;
	width: 1120px;
	height: 600px;
	overflow: scroll;
}
</style>
<style type="text/css">
.tftable {
	font-size: 10px;
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
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
$(function() {
	$("#tabs").tabs();
});

	ddsmoothmenu.init({
		mainmenuid : "templatemo_menu", //menu DIV id
		orientation : 'h', //Horizontal or vertical menu: Set to "h" or "v"
		classname : 'ddsmoothmenu', //class added to menu's outer DIV
		//customtheme: ["#1c5a80", "#18374a"],
		contentsource : "markup" //"markup" or ["container_id", "path_to_menu_file"]
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
		document.getElementById("hid").value = val1;
		edit.submit();
	}
</script> 
<!--============================================================================-->
<!--============================================================================-->
</head>
<%
	try { 
		int uid = 0; 
		int ap_id = 0;
		int cr_no1 = 0;
		ArrayList cr_list = new ArrayList();
		ArrayList cr_list1 = new ArrayList();
		ArrayList approval_list = new ArrayList();
		String UName = null;
		ArrayList id1 = new ArrayList();
		
		Connection con = Connection_Utility.getConnection();
		uid = Integer.parseInt(session.getAttribute("uid").toString());
		PreparedStatement ps_uidappr = con.prepareStatement("select * from user_tbl where U_Id=" + uid);
		
		ResultSet rs_uname = ps_uidappr.executeQuery();
		String user_name = null,companyName="";
		PreparedStatement ps_cmp = null;
		ResultSet rs_cmp = null;
		ArrayList compList = new ArrayList();
		ArrayList compIDList = new ArrayList();
		
		while (rs_uname.next()) {
		user_name = rs_uname.getString("u_name");
		ps_cmp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_uname.getInt("Company_Id"));
		rs_cmp = ps_cmp.executeQuery();
		while(rs_cmp.next()){
			companyName = rs_cmp.getString("Company_Name");
			compList.add(rs_cmp.getString("Company_Name"));
			compIDList.add(rs_cmp.getInt("Company_Id"));
		}
		}
		rs_uname.close();
		ps_cmp = con.prepareStatement("select * from user_tbl_company where Company_Name!='" + companyName + "'");
		rs_cmp = ps_cmp.executeQuery();
		while(rs_cmp.next()){
		companyName = rs_cmp.getString("Company_Name");
		compList.add(rs_cmp.getString("Company_Name"));
		compIDList.add(rs_cmp.getInt("Company_Id"));
		}
%>
<body id="sub_page">
		<!--========================== Menu Bar ==========================-->
		<div id="templatemo_header1" class="ddsmoothmenu">
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
					<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%"> 
						<ul> 
							<li  style="background-color: #1c6f8a;color: white;"><a href="Cab_Home.jsp"><b>Internal Approvals</b></a></li>
							<li style="background-color: #B3A6AA;"><a href="Cab_Home_Customer.jsp">Customer Approvals</a></li> 
						</ul>
					</div> 
					<%
						/* ResultSet rs_uidappr = ps_uidappr.executeQuery();
							while (rs_uidappr.next()) {
								UName = rs_uidappr.getString("U_Name");
								PreparedStatement ps_id = con.prepareStatement("select * from user_tbl where U_Name='" + UName + "'");
								ResultSet rs_id = ps_id.executeQuery();
								while (rs_id.next()) {
									id1.add(rs_id.getInt("U_Id")); 
								}
							} 
							for (int s = 0; s < id1.size(); s++) { */
								PreparedStatement ps_ap_id = con.prepareStatement("select cr_no from cr_tbl_approval where u_id="
												+ uid
												+ " and Approval_id=2");
								ResultSet rs_ap_id = ps_ap_id.executeQuery();
								while (rs_ap_id.next()) {
									approval_list.add(rs_ap_id.getInt("CR_No"));
								}
							/* } */
							//System.out.println("APprovers = " + approval_list);
					%>
		<div style="height: 500px;width:99%; overflow: scroll;">
		 <div id="tabs">
		 <form method="post" name="edit" action="Cab_ApproveDecline_Request.jsp" id="edit">
		 	<ul>
		 			<li><a href="#tabs-1"><font style="font-size: 12px;">&nbsp;&nbsp;<b><%=compList.get(0) %></b>&nbsp;&nbsp;</font></a></li>
					<li><a href="#tabs-2"><font style="font-size: 12px;">&nbsp;&nbsp;<b><%=compList.get(1) %></b>&nbsp;&nbsp;</font></a></li> 
					<li><a href="#tabs-3"><font style="font-size: 12px;">&nbsp;&nbsp;<b><%=compList.get(2) %></b>&nbsp;&nbsp;</font></a></li>
					<li><a href="#tabs-4"><font style="font-size: 12px;">&nbsp;&nbsp;<b><%=compList.get(3) %></b>&nbsp;&nbsp;</font></a></li>
					<li><a href="#tabs-5"><font style="font-size: 12px;">&nbsp;&nbsp;<b><%=compList.get(4) %></b>&nbsp;&nbsp;</font></a></li>
					<li><a href="#tabs-6"><font style="font-size: 12px;">&nbsp;&nbsp;<b><%=compList.get(5) %></b>&nbsp;&nbsp;</font></a></li> 
				</ul>
				<div id="tabs-1"> 
				<!------------------------------------------------------------------------------------------ ( 0 ) --------------------------------------------------------------------------------------------------------->
				<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Category</th>
									<th align="center">Change Request Date</th>
									<th align="center">Proposed Impl. Date</th>
									<th align="center">Actual Impl. Date</th>
									<th align="center">Requested By</th>
									<th align="center">Approval Status</th>
									<!-- 	<th align="center">Action</th> -->
					</tr>
									<% 
										for (int f = 0; f < approval_list.size(); f++) {
												PreparedStatement ps_CR_Details = con.prepareStatement("select * from CR_tbl where CR_No=" + Integer.parseInt(approval_list.get(f).toString()) + " and Company_Id ="+Integer.parseInt(compIDList.get(0).toString())+" order by CR_date");
												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=cr_no%>');">
										<td align="right" width="50px"><%=cr_no%></td>
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
										<%
											}
										%>
										<td align="left">
												<%
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
												<span><%=rs_category.getString("CR_Category")%></span> 
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>
										<%
											if (rs_CR_Details.getString("Actual_Impl_Date").equals("0002-11-30 00:00:00.0")) {
										%>
										<td align="left"></td>
										<%
											} else {
										%>
										<td align="left"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
										<%
											} 
														PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from User_Tbl where U_Id="
																		+ rs_CR_Details.getString("U_Id"));

														ResultSet rs_U_Name = ps_U_Name.executeQuery();
														while (rs_U_Name.next()) {
										%> 
										<td align="left"><%=rs_U_Name.getString("U_Name")%></td>


										<%
											}

														ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="
																		+ cr_no);
														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
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
										<input type="hidden" name="hid" id="hid">
									</tr>
									<%
										}
											} 
									%> 
							</table>
				<!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------> 
				</div>
				<div id="tabs-2"> 
				
				<!------------------------------------------------------------------------------------------ ( 1 ) --------------------------------------------------------------------------------------------------------->
				<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Category</th>
									<th align="center">Change Request Date</th>
									<th align="center">Proposed Impl. Date</th>
									<th align="center">Actual Impl. Date</th>
									<th align="center">Requested By</th>
									<th align="center">Approval Status</th>
									<!-- 	<th align="center">Action</th> -->
					</tr>
									<%
										for (int f = 0; f < approval_list.size(); f++) {
												PreparedStatement ps_CR_Details = con.prepareStatement("select * from CR_tbl where CR_No=" + Integer.parseInt(approval_list.get(f).toString()) + " and Company_Id ="+Integer.parseInt(compIDList.get(1).toString())+" order by CR_date");
												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=cr_no%>');">
										<td align="right" width="50px"><%=cr_no%></td>
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
										<%
											}
										%>
										<td align="left">
												<%
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
												<span><%=rs_category.getString("CR_Category")%></span> 
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>
										<%
											if (rs_CR_Details.getString("Actual_Impl_Date").equals("0002-11-30 00:00:00.0")) {
										%>
										<td align="left"></td>
										<%
											} else {
										%>
										<td align="left"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
										<%
											} 
														PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from User_Tbl where U_Id="
																		+ rs_CR_Details.getString("U_Id"));

														ResultSet rs_U_Name = ps_U_Name.executeQuery();
														while (rs_U_Name.next()) {
										%> 
										<td align="left"><%=rs_U_Name.getString("U_Name")%></td>


										<%
											}

														ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="
																		+ cr_no);
														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
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
										<input type="hidden" name="hid" id="hid">
									</tr>
									<%
										}
											} 
									%> 
							</table>
				<!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------> 
				
				
				
				
				</div>
				<div id="tabs-3"> 
				
				<!------------------------------------------------------------------------------------------ ( 2 ) --------------------------------------------------------------------------------------------------------->
				<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Category</th>
									<th align="center">Change Request Date</th>
									<th align="center">Proposed Impl. Date</th>
									<th align="center">Actual Impl. Date</th>
									<th align="center">Requested By</th>
									<th align="center">Approval Status</th>
									<!-- 	<th align="center">Action</th> -->
					</tr>
									<%
										for (int f = 0; f < approval_list.size(); f++) {
												PreparedStatement ps_CR_Details = con.prepareStatement("select * from CR_tbl where CR_No=" + Integer.parseInt(approval_list.get(f).toString()) + " and Company_Id ="+Integer.parseInt(compIDList.get(2).toString())+" order by CR_date");
												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=cr_no%>');">
										<td align="right" width="50px"><%=cr_no%></td>
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
										<%
											}
										%>
										<td align="left">
												<%
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
												<span><%=rs_category.getString("CR_Category")%></span> 
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>
										<%
											if (rs_CR_Details.getString("Actual_Impl_Date").equals("0002-11-30 00:00:00.0")) {
										%>
										<td align="left"></td>
										<%
											} else {
										%>
										<td align="left"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
										<%
											} 
														PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from User_Tbl where U_Id="
																		+ rs_CR_Details.getString("U_Id"));

														ResultSet rs_U_Name = ps_U_Name.executeQuery();
														while (rs_U_Name.next()) {
										%> 
										<td align="left"><%=rs_U_Name.getString("U_Name")%></td>


										<%
											}

														ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="
																		+ cr_no);
														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
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
										<input type="hidden" name="hid" id="hid">
									</tr>
									<%
										}
											} 
									%> 
							</table>
				<!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------> 
			
				
				
				
				</div>
				<div id="tabs-4"> 
				
				
				<!------------------------------------------------------------------------------------------ ( 3 ) --------------------------------------------------------------------------------------------------------->
				<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Category</th>
									<th align="center">Change Request Date</th>
									<th align="center">Proposed Impl. Date</th>
									<th align="center">Actual Impl. Date</th>
									<th align="center">Requested By</th>
									<th align="center">Approval Status</th>
									<!-- 	<th align="center">Action</th> -->
					</tr>
									<%
										for (int f = 0; f < approval_list.size(); f++) {
												PreparedStatement ps_CR_Details = con.prepareStatement("select * from CR_tbl where CR_No=" + Integer.parseInt(approval_list.get(f).toString()) + " and Company_Id ="+Integer.parseInt(compIDList.get(3).toString())+" order by CR_date");
												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=cr_no%>');">
										<td align="right" width="50px"><%=cr_no%></td>
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
										<%
											}
										%>
										<td align="left">
												<%
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
												<span><%=rs_category.getString("CR_Category")%></span> 
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>
										<%
											if (rs_CR_Details.getString("Actual_Impl_Date").equals("0002-11-30 00:00:00.0")) {
										%>
										<td align="left"></td>
										<%
											} else {
										%>
										<td align="left"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
										<%
											} 
														PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from User_Tbl where U_Id="
																		+ rs_CR_Details.getString("U_Id"));

														ResultSet rs_U_Name = ps_U_Name.executeQuery();
														while (rs_U_Name.next()) {
										%> 
										<td align="left"><%=rs_U_Name.getString("U_Name")%></td>


										<%
											}

														ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="
																		+ cr_no);
														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
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
										<input type="hidden" name="hid" id="hid">
									</tr>
									<%
										}
											} 
									%> 
							</table>
				<!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------> 
			
				
				
				
				</div>
				<div id="tabs-5"> 
				
				<!------------------------------------------------------------------------------------------ ( 4 ) --------------------------------------------------------------------------------------------------------->
				<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Category</th>
									<th align="center">Change Request Date</th>
									<th align="center">Proposed Impl. Date</th>
									<th align="center">Actual Impl. Date</th>
									<th align="center">Requested By</th>
									<th align="center">Approval Status</th>
									<!-- 	<th align="center">Action</th> -->
					</tr>
									<%
									//  System.out.println("DI = " + Integer.parseInt(compIDList.get(4).toString()) + "  =   "   +approval_list + " = " + compIDList);
										for (int f = 0; f < approval_list.size(); f++) {
												PreparedStatement ps_CR_Details = con.prepareStatement("select * from CR_tbl where CR_No=" + Integer.parseInt(approval_list.get(f).toString()) + " and Company_Id ="+Integer.parseInt(compIDList.get(4).toString())+" order by CR_date");
												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=cr_no%>');">
										<td align="right" width="50px"><%=cr_no%></td>
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
										<%
											}
										%>
										<td align="left">
												<%
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
												<span><%=rs_category.getString("CR_Category")%></span> 
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>
										<%
											if (rs_CR_Details.getString("Actual_Impl_Date").equals("0002-11-30 00:00:00.0")) {
										%>
										<td align="left"></td>
										<%
											} else {
										%>
										<td align="left"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
										<%
											} 
														PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from User_Tbl where U_Id="
																		+ rs_CR_Details.getString("U_Id"));

														ResultSet rs_U_Name = ps_U_Name.executeQuery();
														while (rs_U_Name.next()) {
										%> 
										<td align="left"><%=rs_U_Name.getString("U_Name")%></td>


										<%
											}

														ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="
																		+ cr_no);
														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
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
										<input type="hidden" name="hid" id="hid">
									</tr>
									<%
										}
											} 
									%> 
							</table>
				<!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------> 
			
				
				
				</div>
				<div id="tabs-6"> 
				
				
				<!------------------------------------------------------------------------------------------ ( 5 ) --------------------------------------------------------------------------------------------------------->
				<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Category</th>
									<th align="center">Change Request Date</th>
									<th align="center">Proposed Impl. Date</th>
									<th align="center">Actual Impl. Date</th>
									<th align="center">Requested By</th>
									<th align="center">Approval Status</th>
									<!-- 	<th align="center">Action</th> -->
					</tr>
									<% 
										for (int f = 0; f < approval_list.size(); f++) {
												PreparedStatement ps_CR_Details = con.prepareStatement("select * from CR_tbl where CR_No=" + Integer.parseInt(approval_list.get(f).toString()) + " and Company_Id ="+Integer.parseInt(compIDList.get(5).toString())+" order by CR_date");
												ResultSet rs_CR_Details = ps_CR_Details.executeQuery();
												int cr_no = 0;
												while (rs_CR_Details.next()) {
													cr_no = rs_CR_Details.getInt("CR_No");
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=cr_no%>');">
										<td align="right" width="50px"><%=cr_no%></td>
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
										<%
											}
										%>
										<td align="left">
												<%
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
												<span><%=rs_category.getString("CR_Category")%></span> 
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>
										<%
											if (rs_CR_Details.getString("Actual_Impl_Date").equals("0002-11-30 00:00:00.0")) {
										%>
										<td align="left"></td>
										<%
											} else {
										%>
										<td align="left"><%=rs_CR_Details.getString("Actual_Impl_Date")%></td>
										<%
											} 
														PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from User_Tbl where U_Id="
																		+ rs_CR_Details.getString("U_Id"));

														ResultSet rs_U_Name = ps_U_Name.executeQuery();
														while (rs_U_Name.next()) {
										%> 
										<td align="left"><%=rs_U_Name.getString("U_Name")%></td>


										<%
											}

														ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No="
																		+ cr_no);
														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
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
										<input type="hidden" name="hid" id="hid">
									</tr>
									<%
										}
											} 
									%> 
							</table>
				<!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------> 
				
				
				</div>
				</form>
		 </div>			 
		 </div>
			<%
					} catch (Exception e) {
					e.printStackTrace();
				}
			%>
<!--============================================================================-->
<!--============================================================================-->
</body> 
</html>