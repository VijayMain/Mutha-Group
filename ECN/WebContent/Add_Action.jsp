<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Add Action</title> 
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
		action.submit();
	}
</script>
</head>
<body id="sub_page">
					<%
						try { 
							int uid = 0;
							uid = Integer.parseInt(session.getAttribute("uid").toString()); 
							Connection con = Connection_Utility.getConnection();
							PreparedStatement ps_uidappr = con.prepareStatement("select * from user_tbl where U_Id=" + uid);
							String UName = null;
							ArrayList id1 = new ArrayList();
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
				<li><a href="Add_Action.jsp" style="background-color: #808080"><b>Add Action</b></a></li>
				<li><a href="My_Approvals.jsp">Details</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li style="text-align: center;"><a href="logout.jsp">Log Out <b style="font-size: 9px;">( <%=user_name%> )</b></a></li>
			</ul>
		</div>		
		<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%"> 
						<ul>
							<li  style="background-color: #1c6f8a;color: white;"><a href="Add_Action.jsp"><b>Add Action Internal</b></a></li>
							<li style="background-color: #B3A6AA;"><a href="Add_Action_Customer.jsp">Add Action Customer</a></li>
						</ul>
		</div>
			<!--  
			<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%"> 
						<ul> 
							<li  style="background-color: #1c6f8a;color: white;"><a href="Cab_Home.jsp"><b>Internal Approvals</b></a></li>
							<li style="background-color: #B3A6AA;"><a href="Cab_Home_Customer.jsp">Customer Approvals</a></li>
						</ul>
			</div>  
			-->
					<div style="height: 550px;width: 100%;overflow: scroll;">
					<!-- <form method="post" name="contact" action="Edit_Request.jsp"> -->
					<form method="post" name="action" action="Add_Action_Details.jsp" id="action">
						<%
							int cr_no = 0; 
								ArrayList appr_id_list1 = new ArrayList();
								ArrayList appr_id_list = new ArrayList();
								ArrayList cr_no_list = new ArrayList();

								PreparedStatement ps_Cr_No = con.prepareStatement("select Cr_no from cr_tbl where U_Id=" + uid);
								ResultSet rs_Cr_No = ps_Cr_No.executeQuery();
								while (rs_Cr_No.next()) {
									ArrayList appr_list = new ArrayList();

									int cnt1 = 0;
									int cnt2 = 0;
									int cnt3 = 0;
									cr_no = rs_Cr_No.getInt("CR_NO");
									System.out.print("\n req no... " + cr_no);
									PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No=" + cr_no);
									ResultSet rs_appr_list = ps_appr_list.executeQuery();
 									while (rs_appr_list.next()) {
										//System.out.print("\n Approvers ... " + rs_appr_list.getInt("U_Id"));

										appr_list.add(rs_appr_list.getInt("U_Id"));
									}

									appr_id_list.clear();
									for (int appr = 0; appr < appr_list.size(); appr++) {
										PreparedStatement ps_appr = con
												.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
														+ cr_no
														+ " and U_Id="
														+ Integer.parseInt(appr_list.get(appr)
																.toString()));

										ResultSet rs_appr = ps_appr.executeQuery();

										while (rs_appr.next()) {
											System.out.print("\n loop... " + appr_list.size());
											System.out.print("\n Approvals ... "
													+ rs_appr.getInt("Approval_Id"));
											appr_id_list.add(rs_appr.getInt("Approval_Id"));
										}

									}
									String Status = null;

									boolean flag = false;
									System.out.print("approvers id size :"
											+ appr_id_list.size());
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
										System.out.print("Declined");

									} else if (cnt1 == appr_id_list.size()) {
										System.out.print("Approved. . . " + cr_no);
										cr_no_list.add(cr_no);

									} else {
										System.out.print("\n Pending  . . . ");
									}

								}
						%>

					<table style="width: 100%;" class="tftable">  
					<tr style="height: 27px;">
									<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Category</th>
									<th align="center">Change Request Date</th>
									<th align="center">Proposed Impl. Date</th>
									<!-- <th align="center">Actual Impl. Date</th> -->
									<th align="center">Approval Status</th> 
								</tr> 
									<%
										PreparedStatement ps_action;
										ResultSet rs_action;

											for (int cr = 0; cr < cr_no_list.size(); cr++) {
												System.out.print("into loop .. " + cr_no_list.get(cr));
												int crno = Integer.parseInt(cr_no_list.get(cr).toString()); 
												ps_action = con.prepareStatement("select * from cr_tbl where cr_no=" + crno); 
												rs_action = ps_action.executeQuery(); 
												while (rs_action.next()) {
									%>
									<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=crno%>');">
										<td align="right"><%=crno%></td>
										<%
											PreparedStatement ps_company = con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
																		+ rs_action.getInt("Company_Id"));
														ResultSet rs_company = ps_company.executeQuery();
														while (rs_company.next()) {
										%>
										<td align="left"><%=rs_company.getString("Company_Name")%></td>
										<%
											}
														PreparedStatement ps_item = con.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
																		+ rs_action.getInt("Item_Id"));
														ResultSet rs_item = ps_item.executeQuery();
														while (rs_item.next()) {
										%>
										<td align="left"><%=rs_item.getString("Item_Name")%></td>
										<td align="left" width="200">
												<%
													}
																PreparedStatement ps_category_id = con.prepareStatement("select CR_Category_Id from CR_category_relation_tbl where CR_No="
																				+ cr_no_list.get(cr));
																ResultSet rs_category_id = ps_category_id.executeQuery(); 
																ArrayList cat_id = new ArrayList(); 
																while (rs_category_id.next()) {
																	cat_id.add(rs_category_id.getInt("CR_Category_Id"));
																}
																//System.out.println("Home Test = " + cat_id);
																for (int j = 0; j < cat_id.size(); j++) {
																	PreparedStatement ps_category = con.prepareStatement("select * from CR_tbl_category where CR_Category_Id="
																					+ Integer.parseInt(cat_id.get(j).toString()));
																	ResultSet rs_category = ps_category.executeQuery();
																	while (rs_category.next()) {
												%>
												<label><%=rs_category.getString("CR_Category")%></label>,
												<%
													}
																}
												%>
										</td>
										<td align="left"><%=rs_action.getString("CR_Date")%> 
											<input type="hidden" name="req_date" value="<%=rs_action.getString("CR_Date")%>"></td>
											
										<td align="left"><%=rs_action.getString("Proposed_Impl_Date")%></td> 
										
										<%-- <%
											if(rs_action.getString("Actual_Impl_Date").equals("0002-11-30 00:00:00.0"))
											{
										%>
												<td align="left"></td>
										<%
											}
											else
											{
										%> 
											<td align="left"><%=rs_action.getString("Actual_Impl_Date")%></td> 
										<%
											} 
										%> --%>
										
										<td align="left">Approved</td>
										<%--		<td align="center" width="110px">
											<button onclick="button1(this.value)" name="action_button"
												id="action_button" value="<%=crno%>">Action</button>
										</td> --%> 
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
					</form>
				</div> 
</body>
</html>