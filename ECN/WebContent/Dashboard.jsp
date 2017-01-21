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
<title>ECN New Request</title>
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<!--============================================================================-->
<!--================ DashBoard =====================================-->
<!--============================================================================-->
<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}
	//-============================================================================-->
	//-======================== Item Name AJAX script ===============================-->
	
	function showState(str) {
		var xmlhttp;

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("item").innerHTML = xmlhttp.responseText;
				//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

			}
		};
		xmlhttp.open("GET", "Item_Name.jsp?q=" + str, true);
		xmlhttp.send();
	};
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


	<div id="templatemo_wrapper">
		<div id="templatemo_top"></div>
		<!-- end of top -->


		<div id="templatemo_header" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp">Home</a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<li><a href="Search_Request.jsp">Search Request</a></li>
				<li><a href="logout.jsp">Log Out</a></li>
				<!--<li><a href="portfolio.html">Portfolio</a></li>
				<li><a href="blog.html">Blog</a></li>
				<li><a href="contact.html" class="selected">Contact</a></li> -->
			</ul>
			<br style="clear: left" />
		</div>
		<!-- end of templatemo_menu -->
		<div id="templatemo_menu">
			<div id="site_title">
				<h1 style="color: orange;">ECN</h1>
			</div>
		</div>

		<!-- end of header -->

		<div id="templatemo_main">
			<h4>New Request</h4>
			<div class="col_w630 float_l">

				<div id="contact_form">
					<form name="contact" method="post"
						action="Change_Request_Controller">
						<table>

							<tr>
								<%
									try {

										Connection con = Connection_Utility.getConnection();

										int cr_No = 0;
										cr_No = Integer.parseInt(request.getParameter("hid"));

										PreparedStatement ps_edit = con
												.prepareStatement("select * from CR_tbl where CR_No="
														+ cr_No);

										ResultSet rs_edit = ps_edit.executeQuery();
										int company_id = 0;
										while (rs_edit.next()) {
								%>


								<td colspan="1"><b>Request Number</b> <input type="text"
									id="author" name="author" value="<%=cr_No%>"
									disabled="disabled" class="required input_field" /> <input
									type="hidden" name="crno" value="<%=cr_No%>" />



									<div class="cleaner h10"></div></td>

							</tr>
							<tr>
								<td colspan="1"><b>Request Date</b> <%
 	PreparedStatement ps_CRdate = con
 					.prepareStatement("select * from cr_tbl where CR_No="
 							+ cr_No);
 			ResultSet rs_CRdate = ps_CRdate.executeQuery();
 			while (rs_CRdate.next()) {
 %> <input name="req_date" type="text" id="txtreturndate"
									class="validate-email required input_field" size="16"
									readonly="true" value="<%=rs_CRdate.getString("CR_Date")%>" />
									<%
										}
									%>
									<div class="cleaner h10"></div></td>

							</tr>
							<tr>
								<td colspan="1">
									<%
										PreparedStatement ps_company = con
														.prepareStatement("select * from user_tbl_company where company_id="
																+ rs_edit.getInt("company_id"));
												ResultSet rs_company = ps_company.executeQuery();

												while (rs_company.next()) {

													company_id = rs_company.getInt("Company_Id");
									%> <b>Supplier Name</b> <Select id="company" name="company"
									class="required input_field" onchange="showState(this.value)">
										<option value="<%=company_id%>"><%=rs_company.getString("Company_name")%></option>

										<%
											}
													PreparedStatement ps_c_list = con
															.prepareStatement("select * from user_tbl_company where company_id!="
																	+ rs_edit.getInt("company_id")
																	+ " and company_id!=6");
													ResultSet rs_c_list = ps_c_list.executeQuery();

													while (rs_c_list.next()) {
										%>
										<option value="<%=rs_c_list.getInt("Company_id")%>"><%=rs_c_list.getString("Company_name")%></option>
										<%
											}
										%>
								</Select>
									<div class="cleaner h10"></div>
								</td>
								<td colspan="1"><b>Part Name</b> <%
 	PreparedStatement ps_item = con
 					.prepareStatement("select * from customer_tbl_item where item_id="
 							+ rs_edit.getInt("item_id"));
 			ResultSet rs_item = ps_item.executeQuery();
 %>

									<div id="item">
										<Select class="validate-email required input_field"
											name="item" id="item" style="width: 350px">
											<%
												int item_id = 0;
														while (rs_item.next()) {
															item_id = rs_item.getInt("Item_Id");
											%>
											<option <%=item_id%>><%=rs_item.getString("Item_Name")%></option>


											<%
												}

														PreparedStatement ps_cust_list = con
																.prepareStatement("select Cust_Id from company_customer_relation_tbl where company_Id="
																		+ company_id);
														ArrayList cust_list = new ArrayList();

														ResultSet rs_cust_list = ps_cust_list.executeQuery();

														while (rs_cust_list.next()) {
															cust_list.add(rs_cust_list.getInt("Cust_id"));
														}

														ArrayList item_list = new ArrayList();

														for (int i = 0; i < cust_list.size(); i++) {
															int cust_id = Integer.parseInt(cust_list.get(i)
																	.toString());
															PreparedStatement ps_i_list = con
																	.prepareStatement("select Item_Id from customer_item_tbl where Cust_Id="
																			+ cust_id);
															ResultSet rs_i_list = ps_i_list.executeQuery();

															while (rs_i_list.next()) {
																item_list.add(rs_i_list.getInt("Item_Id"));
															}

														}
														for (int i = 0; i < item_list.size(); i++) {
															PreparedStatement ps_item1 = con
																	.prepareStatement("select * from customer_tbl_item where item_Id="
																			+ Integer.parseInt(item_list.get(i)
																					.toString())
																			+ " and item_id!="
																			+ item_id);
															ResultSet rs_item1 = ps_item1.executeQuery();
															while (rs_item1.next()) {
											%>
											<option value="<%=rs_item1.getString("Item_Id")%>"><%=rs_item1.getString("Item_name")%></option>
											<%
												}

														}
											%>
										</select>
									</div>
									<div class="cleaner h10"></div></td>
							</tr>
							<tr>
								<td><b>Category Of Change</b></td>
							</tr>

							<%
								ArrayList list_sel = new ArrayList();
										PreparedStatement ps_selected = con
												.prepareStatement("select * from cr_category_relation_tbl where CR_No="
														+ cr_No);
										ResultSet rs_selected = ps_selected.executeQuery();
										while (rs_selected.next()) {
											list_sel.add(rs_selected.getInt("CR_Category_Id"));
										}

										ArrayList list_sel_all = new ArrayList();
										PreparedStatement ps_sel_all = con
												.prepareStatement("select * from cr_tbl_category");
										ResultSet rs_sel_all = ps_sel_all.executeQuery();
										while (rs_sel_all.next()) {

											list_sel_all.add(rs_sel_all.getInt("CR_Category_Id"));

										}
										System.out.println("Test all = " + list_sel_all);
							%>



							<tr>

								<td>
									<%
										PreparedStatement ps_seleceted = null;
												ResultSet rs_sel = null;
												for (int i = 0; i < list_sel.size(); i++) {

													ps_seleceted = con
															.prepareStatement("select * from cr_tbl_category where CR_Category_Id="
																	+ Integer.parseInt(list_sel.get(i)
																			.toString()));
													rs_sel = ps_seleceted.executeQuery();
													while (rs_sel.next()) {
									%> <input type="checkbox" checked="checked"
									value="<%=Integer.parseInt(list_sel.get(i)
									.toString())%>"
									name="<%=rs_sel.getString("CR_Category")%>"><%=rs_sel.getString("CR_Category")%>

									<%
										}
													for (int sel11 = 0; sel11 < list_sel_all.size(); sel11++) {
														if (list_sel.get(i).toString()
																.equals(list_sel_all.get(sel11).toString())) {
															list_sel_all.remove(sel11);
														}
													}

												}
												System.out.println("Test no = " + list_sel_all);
									%>
								</td>
							</tr>
							<tr>
								<td>
									<%
										for (int all = 0; all < list_sel_all.size(); all++) {

													PreparedStatement ps_nonsel = con
															.prepareStatement("select * from cr_tbl_category where CR_Category_Id="
																	+ Integer.parseInt(list_sel_all
																			.get(all).toString()));
													ResultSet rs_nonsel = ps_nonsel.executeQuery();
													while (rs_nonsel.next()) {
									%> <input type="checkbox"
									value="<%=Integer.parseInt(list_sel_all.get(all)
									.toString())%>"
									name="<%=rs_nonsel.getString("CR_Category")%>"><%=rs_nonsel.getString("CR_Category")%>
									<%
										}
												}
									%>
								</td>
							</tr>


							<tr>
								<td colspan="1"><b>Change Type</b></td>
								<td></td>

								<td colspan="1"><b>Selected Change Type</b></td>


							</tr>
							<tr>
								<td colspan="1"><select id="change_name" name="change_name"
									multiple="multiple" size="5" style="width: 310px">

										<%
											PreparedStatement ps_ct = con
															.prepareStatement("select * from cr_tbl_type");
													ResultSet rs_ct = ps_ct.executeQuery();
													while (rs_ct.next()) {
										%>

										<option value="<%=rs_ct.getString("CR_Type")%>"><%=rs_ct.getString("CR_Type")%></option>
										<%
											}
										%>

								</select></td>
								<td style="width: 50px;" align="center"><input
									value="&gt;&gt;" onclick="move('right', 'rep')" type="button"><br>
									<input value="&lt;&lt;" onclick="move('left', 'rep')"
									type="button"></td>
								<td colspan="1"><select id="change_selected"
									name="change_selected" multiple="multiple" size="5"
									style="width: 310px">
										<%
											PreparedStatement ps_editcrtype = con
															.prepareStatement("select * from cr_ctype_relation_tbl where CR_No="
																	+ cr_No);
													ResultSet rs_crtype = ps_editcrtype.executeQuery();
													while (rs_crtype.next()) {

														PreparedStatement ps_namectype = con
																.prepareStatement("select * from cr_tbl_type where CR_Type_Id="
																		+ rs_crtype.getInt("CR_Type_Id"));
														ResultSet rs_nm = ps_namectype.executeQuery();
														while (rs_nm.next()) {
										%>
										<option value="<%=rs_nm.getString("CR_Type")%>"
											selected="selected"><%=rs_nm.getString("CR_Type")%>
										</option>
										<%
											}
													}
										%>
								</select></td>
							</tr>
							<tr>
								<td><b>Present System</b></td>
								<td><b>Proposed System</b></td>
								<td><b>Objective</b></td>
							</tr>
							<tr>
								<td><textarea class="validate-subject required input_field"
										name="Present" id="Present" style="height: 100px">
										<%=rs_edit.getString("Present_System")%>
										
										</textarea>
									<div class="cleaner h10"></div></td>
								<td><textarea class="validate-subject required input_field"
										name="Proposed" id="Proposed" style="height: 100px">
										<%=rs_edit.getString("Present_System")%>
										
										</textarea>
									<div class="cleaner h10"></div></td>
								<td><textarea class="validate-subject required input_field"
										name="Objective" id="Objective" style="height: 100px">
										<%=rs_edit.getString("Objective")%>
										
										</textarea>
									<div class="cleaner h10"></div></td>
							</tr>

							<tr>

								<td><b>Proposed date</b></td>
								<td><b>Actual Implementation date</b></td>
							</tr>
							<tr>
								<td><input name="proposeddate" type="text"
									id="txtreturndate" class="validate-email required input_field"
									size="16" readonly="true"
									value="<%=rs_edit.getString("Proposed_Impl_Date")%>" />
									<div class="cleaner h10"></div></td>
								<div class="cleaner h10"></div>
								<td><input name="actualimpldate" type="text"
									id="txtreturndate" class="validate-email required input_field"
									size="16" readonly="true"
									value="<%=rs_edit.getString("Actual_Impl_Date")%>" />
									<div class="cleaner h10"></div></td>
							</tr>





							<tr>

								<td><b>ComplaintNo(Optional)</b></td>
							</tr>
							<tr>
								<td><input name="complaintno" type="text"
									class="validate-email required input_field" size="16"
									onfocus="if(this.value==this.defaultValue)this.value='';"
									onblur="if(this.value=='')this.value=this.defaultValue;"
									value="<%=rs_edit.getString("Complaint_No")%>" />





									<div class="cleaner h10"></div></td>
								<div class="cleaner h10"></div>
								</td>
							</tr>




							<tr>
								<td colspan="1"><b>Approvers</b></td>
								<td></td>

								<td colspan="1"><b>Selected Approvers</b></td>


							</tr>
							<tr>
								<td colspan="1"><select id="approver_name"
									name="approver_name" multiple="multiple" size="5"
									style="width: 310px">

										<%
											PreparedStatement ps_user = con
															.prepareStatement("select * from user_tbl");
													ResultSet rs_user = ps_user.executeQuery();
													while (rs_user.next()) {
										%>

										<option value="<%=rs_user.getString("U_Name")%>"><%=rs_user.getString("U_Name")%></option>
										<%
											}
										%>

								</select></td>
								<td style="width: 50px;" align="center"><input
									value="&gt;&gt;" onclick="move1('right', 'rep')" type="button"><br>
									<input value="&lt;&lt;" onclick="move1('left', 'rep')"
									type="button"></td>
								<td colspan="1"><select id="approver_selected"
									name="approver_selected" multiple="multiple" size="5"
									style="width: 310px">

										<%
											PreparedStatement ps_appsel = con
															.prepareStatement("select * from cr_approver_relation_tbl where CR_No="
																	+ cr_No);
													ResultSet rs_appsel = ps_appsel.executeQuery();
													while (rs_appsel.next()) {

														PreparedStatement ps_ap = con
																.prepareStatement("select * from user_tbl where U_Id="
																		+ rs_appsel.getInt("U_Id"));
														ResultSet rs_appp = ps_ap.executeQuery();
														while (rs_appp.next()) {
										%>

										<option value="<%=rs_appp.getString("U_Name")%>"
											selected="selected"><%=rs_appp.getString("U_Name")%></option>

										<%
											}
													}
										%>

								</select></td>
							</tr>
							<tr>
								<td colspan="3" align="Center"><input type="submit"
									value="Send Request"></td>
							</tr>

							<%
								}
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
						</table>
					</form>

				</div>
			</div>
<!--============================================================================-->
<!--============================================================================-->



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