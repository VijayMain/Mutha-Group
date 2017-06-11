<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ECN Search Request</title>
<script type="text/javascript" src="jquery-1.7.1.min.js"></script>
<meta name="keywords" content="graphite theme, free templates, website templates, CSS, HTML" />
<meta name="description" content="Graphite Theme, Contact page, free CSS template provided by templatemo.com" />
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

<link href="jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<script src="js/jquery-1.7.2.min.js"> </script>
<script src="js/jquery-ui-1.8.18.custom.min.js"></script>
<script language="javascript" type="text/javascript" src="datetimepicker.js"></script>
<!-- End Tab Logic -->
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="tytabs.jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#tabsholder").tytabs({
			tabinit : "2",
			fadespeed : "fast"
		});
		$("#tabsholder2").tytabs({
			prefixtabs : "tabz",
			prefixcontent : "contentz",
			classcontent : "tabscontent",
			tabinit : "3",
			catchget : "tab2",
			fadespeed : "normal"
		});
	});
</script> 
<style type="text/css"> 
.center {
	width: 60%;
	margin: 20px auto 0 auto;
}

.marginbot {
	margin-bottom: 15px;
}

ul.list li {
	list-style-type: none;
	margin-left: 20px;
}

ul.tabs {
	width: 100%;
	overflow: hidden;
}

ul.tabs li {
	list-style-type: none;
	display: block;
	float: left;
	color: #fff;
	padding: 8px;
	margin-right: 2px;
	border-bottom: 2px solid #2f2f2f;
	background-color: #1f5e6f;
	-moz-border-radius: 4px 4px 0 0;
	-webkit-border-radius: 4px 4px 0 0;
	cursor: pointer;
}

ul.tabs li:hover {
	background-color: #43b0ce;
}

ul.tabs li.current {
	border-bottom: 2px solid #43b0ce;
	background-color: #43b0ce;
	padding: 8px;
}

.tabscontent {
	border-top: 2px solid #43b0ce;
	padding: 8px 0 0 0;
	display: none;
	width: 100%;
	text-align: justify;
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
</head>
<body id="sub_page">
				<%
						try { 
							int uid = 0; 
							uid = Integer.parseInt(session.getAttribute("uid").toString()); 
							Connection con = Connection_Utility.getConnection();
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
				<li><a href="Cab_Search_Request.jsp"><b>Search Request</b></a></li>
				<li><a href="Reports.jsp" style="background-color: #808080"><b>Reports</b></a></li>
				<li style="text-align: center;"><a href="logout.jsp">Log Out <b style="font-size: 9px;">( <%=user_name%> )</b></a></li>
			</ul> 
		</div> 
			<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%"> 
					<ul>
							<li  style="background-color: #1c6f8a;color: white;"><a href="Reports.jsp"><b>Reports Internal</b></a></li>
							<li style="background-color: #B3A6AA;"><a href="ReportsCustomer.jsp">Reports Customer</a></li>
					</ul>
					</div>
			<div style="height: 550px;width: 100%;overflow: scroll;">	 
					<form method="post" name="contact" action="Reports_Internal_Controller">
						<p>&nbsp;</p>
						<!-- Tabs -->
						<div id="tabsholder">
							<ul class="tabs">
								<li id="tab1">Supplier Wise</li>
								<li id="tab2">Item Wise</li>
								<li id="tab3">Approval Type Wise</li>
							</ul>
							<div class="contents marginbot">

								<div id="content1" class="tabscontent">
									<table style="width: 50%;" class="tftable">  
										<tr>
											<td colspan="2"><b>Company </b></td>
											<%
												PreparedStatement ps_company = con
															.prepareStatement("select * from user_tbl_company where company_id!=6");
													ResultSet rs_company = ps_company.executeQuery();
											%>
											<td><select name="company_name_sup" style="background-color: #dcf1f8">
													<option value="0">---Select---</option>
													<%
														while (rs_company.next()) {
													%>
													<option value="<%=rs_company.getInt("Company_Id")%>"><%=rs_company.getString("Company_Name")%></option>
													<%
														}
													%>
											</select></td>
										</tr>
										<tr>
											<td><b>Start Date</b></td>
											<td colspan="2"><input id="demo1" name="start_date_sup"  style="background-color: #dcf1f8"
												type="text" size="25" TITLE="Click on Date Picker">
													<a href="javascript:NewCal('demo1','ddmmyyyy',true,24)">
														<img src="cal.gif" width="16" height="16" border="0"
														alt="Pick a date" /></td>
										</tr>
										<tr>
											<td><b>End Date</b></td>
											<td colspan="2"><input id="demo2" name="end_date_sup"  style="background-color: #dcf1f8"
												type="text" size="25" TITLE="Click on Date Picker">
													<a href="javascript:NewCal('demo2','ddmmyyyy',true,24)">
														<img src="cal.gif" width="16" height="16" border="0"
														alt="Pick a date" /></td>
										</tr>
										<tr>
											<td colspan="3" align="center"><input type="submit"
												value="Generate Report" onclick="popupWindow();"
												style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;font-weight: bold;"></input></td>
										</tr>

									</table>

								</div>
								<div id="content2" class="tabscontent">
								<table style="width: 50%;" class="tftable">  
										<tr>
											<td colspan="2"><b>Company</b></td>
											<%
												PreparedStatement ps_company1 = con.prepareStatement("select * from user_tbl_company where company_id!=6");
													ResultSet rs_company1 = ps_company1.executeQuery();
											%>
											<td><select name="company_name_item"  style="background-color: #dcf1f8" onchange="showState(this.value)">
													<option value="0">---Select---</option>
													<%
														while (rs_company1.next()) {
													%>
													<option value="<%=rs_company1.getInt("Company_Id")%>"><%=rs_company1.getString("Company_Name")%></option>
													<%
														}
													%>
											</select></td>
										</tr>
										<tr>
											<td colspan="2"><b>Item</b></td>
											<%
												PreparedStatement ps_item = con.prepareStatement("select * from customer_tbl_item order by Item_Name");
													ResultSet rs_item = ps_item.executeQuery();
											%>
											<td>
												<div id="item">
													<select name="item_name"  style="background-color: #dcf1f8">
														<option value="0">---Select---</option>
														<%
															while (rs_item.next()) {
														%>
														<option value="<%=rs_item.getInt("Item_Id")%>"><%=rs_item.getString("Item_Name")%></option>
														<%
															}
														%>
													</select>
												</div>
											</td>
										</tr>

										<tr>
											<td><b>Start Date</b></td>
											<td colspan="2"><input id="demo3" name="start_date_item"  style="background-color: #dcf1f8"
												type="text" size="25" TITLE="Click on Date Picker">
													<a href="javascript:NewCal('demo3','ddmmyyyy',true,24)">
														<img src="cal.gif" width="16" height="16" border="0"
														alt="Pick a date"></td>
										</tr>
										<tr>
											<td><b>End Date</b></td>
											<td colspan="2"><input id="demo4" name="end_date_item"  style="background-color: #dcf1f8"
												type="text" size="25" TITLE="Click on Date Picker">
													<a href="javascript:NewCal('demo4','ddmmyyyy',true,24)">
														<img src="cal.gif" width="16" height="16" border="0"
														alt="Pick a date"></td>
										</tr>
										<tr>
											<td colspan="3" align="center"><input type="submit"
												value="Generate Report"
												style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;font-weight: bold;"></input></td>
										</tr>

									</table>












								</div>
								<div id="content3" class="tabscontent">
									<table style="width: 50%;" class="tftable">
										<tr>
											<td colspan="2"><b>Approval Type</b></td>
											<%
												PreparedStatement ps_appr = con
															.prepareStatement("select * from cr_tbl_approval_type");
													ResultSet rs_appr = ps_appr.executeQuery();
											%>
											<td><select name="approval_type_app"  style="background-color: #dcf1f8">
													<option value="0">---Select---</option>
													<%
														while (rs_appr.next()) {
													%>
													<option value="<%=rs_appr.getInt("Approval_Id")%>"><%=rs_appr.getString("Approval_Type")%></option>
													<%
														}
													%>
											</select></td>
										</tr>
										<tr>
											<td><b>Start Date</b></td>
											<td colspan="2"><input id="demo5" name="start_date_app"  style="background-color: #dcf1f8"
												type="text" size="25" TITLE="Click on Date Picker">
													<a href="javascript:NewCal('demo5','ddmmyyyy',true,24)">
														<img src="cal.gif" width="16" height="16" border="0"
														alt="Pick a date"></td>
										</tr>
										<tr>
											<td><b>End Date</b></td>
											<td colspan="2"><input id="demo6" name="start_date_app"  style="background-color: #dcf1f8"
												type="text" size="25" TITLE="Click on Date Picker">
													<a href="javascript:NewCal('demo6','ddmmyyyy',true,24)">
														<img src="cal.gif" width="16" height="16" border="0"
														alt="Pick a date"></td>
										</tr>
										<tr>
											<td colspan="3" align="center"><input type="submit"
												value="Generate Report"
												style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;font-weight: bold;"></input></td>
										</tr>
									</table>
									<%
										} catch (Exception e) {
											e.printStackTrace();
										}
									%>
								</div>
							</div>
						</div>
						<!-- /Tabs --> 
					</form> 
				</div> 
</body>
</html>