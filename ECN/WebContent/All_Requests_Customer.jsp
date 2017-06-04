<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>My Approvals</title> 
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" /> 
<style>
div.scroll {
	background-color: #F0EBF2;
	width: 1010px;
	height: 600px;
	overflow: scroll;
}
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
		approve.submit();
	}
</script> 
</head> 
<body id="sub_page">
			<div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp">Home</a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<li><a href="Cab_Edit_Request.jsp">Edit Request</a></li>
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li><a href="My_Approvals.jsp">Details</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li><a href="logout.jsp">Log Out</a></li>
			</ul> 
		</div>  
				<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%">
						<ul>
							<li style="background-color: #B3A6AA;"><a href="My_Approvals.jsp">Internal</a></li>
							<li style="background-color: #B3A6AA;"><a href="My_Approvals_Customer.jsp">Customer</a></li>
							<li style="background-color: #B3A6AA;"><a href="All_Requests.jsp">All Internal</a></li>
							<li style="background-color: #1c6f8a;color: white;"><a href="All_Requests_Customer.jsp"><b>All Customer</b></a></li>
						</ul>
				</div>




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
					%>
					<!-- <form method="post" name="contact" action="Edit_Request.jsp"> -->
					<form method="post" name="approve" action="Customer_Requests_Result.jsp" id="approve">
						<%
							PreparedStatement psPagianation = null;
								ResultSet rs_CR_Details = null;
						%> 
						<div style="height: 550px;width: 100%;overflow: scroll;">  
								<table style="width: 100%;" class="tftable">  
									<tr style="height: 27px;"> 
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Change For</th>
									<th align="center">Change Request Date</th>
									<th align="center">Total Stock</th>
									<th align="center">Target Impl. Date</th>
									<th align="center">Approval Status</th> 
								</tr> 
									<%
										String sqlPagination = "SELECT * FROM CRC_Tbl order by crc_no desc";

											psPagianation = con.prepareStatement(sqlPagination);
											rs_CR_Details = psPagianation.executeQuery();
											int cr_no = 0;
											while (rs_CR_Details.next()) {
												cr_no = rs_CR_Details.getInt("CRC_No");
												System.out.println("Testing Cr No = " + cr_no);
									%>
									<tr onmouseover="ChangeColor(this, true);"
										onmouseout="ChangeColor(this, false);" style="cursor: pointer;"
										onclick="button1('<%=cr_no%>');">
										<td align="right"><%=cr_no%></td>
										<%
											PreparedStatement ps_company = con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
																	+ rs_CR_Details.getInt("Company_Id"));
													ResultSet rs_company = ps_company.executeQuery();
													while (rs_company.next()) {
										%>
										<td align="left"><%=rs_company.getString("Company_Name")%></td>
										<%
											}
													PreparedStatement ps_item = con
															.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
																	+ rs_CR_Details.getInt("Item_Id"));
													ResultSet rs_item = ps_item.executeQuery();
													while (rs_item.next()) {
										%>
										<td align="left"><%=rs_item.getString("Item_Name")%></td>
										<td align="left"><%=rs_CR_Details.getString("Change_For")%></td>
										<td align="left"><%=rs_CR_Details.getString("CRC_Date")%></td>
										<td align="right"><%=rs_CR_Details.getInt("Total_Stock")%></td>

										<%
											if (rs_CR_Details.getString("TArgated_Impl_Date")
																.equals("0002-11-30 00:00:00.0")) {
										%>
										<td align="center"></td>
										<%
											} else {
										%>
										<td align="left"><%=rs_CR_Details.getString("Targated_Impl_Date")%></td>
										<%
											}
														ArrayList appr_list = new ArrayList();
														ArrayList appr_id_list = new ArrayList();
														PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from crc_tbl_approver_rel where CRC_No=" + cr_no);

														ResultSet rs_appr_list = ps_appr_list.executeQuery();

														while (rs_appr_list.next()) {
															appr_list.add(rs_appr_list.getInt("U_Id"));
														}

														for (int appr = 0; appr < appr_list.size(); appr++) {
															PreparedStatement ps_appr = con
																	.prepareStatement("select Approval_Id from crc_tbl_Approval where CRC_No="
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
</body>
</html>