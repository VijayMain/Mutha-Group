<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.PreparedStatement"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>
<html>
<head>

<!--============================================================================-->
<!--======================== Design Script ================================-->
<!--============================================================================-->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ECN New Request</title>

<script type="text/javascript" src="tabledeleterow.js"></script>


<script language="javascript" type="text/javascript"
	src="datetimepicker.js"></script>
<script type="text/javascript">
	function SendRequest() {
		var current = document.getElementById("valReq");
		current.value = 1;
	}
	function Action() {
		var current = document.getElementById("valReq");
		current.value = 2;
	}
</script>

<!--============================================================================-->
<!--========================= Validation ==================================-->

<script type="text/javascript">
<!--
	// Form validation code will come here.
	function validate() {

		if (document.myForm.item_name.value == "") {
			alert("Please provide Supplier Name and Part Name!");
			document.myForm.item_name.focus();
			return false;
		}

		if (document.myForm.change_selected.value == "") {
			alert("Please provide Change Type!");
			document.myForm.change_selected.focus();
			return false;
		}

		if (document.myForm.Present.value == "") {
			alert("Please provide Present System!");
			document.myForm.Present.focus();
			return false;
		}
		if (document.myForm.Proposed.value == "") {
			alert("Please provide Proposed System!");
			document.myForm.Proposed.focus();
			return false;
		}
		if (document.myForm.Objective.value == "") {
			alert("Please provide Objective!");
			document.myForm.Objective.focus();
			return false;
		}
		if (document.myForm.proposeddate.value == "") {
			alert("Please provide Proposed date!");
			document.myForm.proposeddate.focus();
			return false;
		}
		/* if (document.myForm.actualimpldate.value == "") {
			alert("Please provide Actual Implementation date!");
			document.myForm.actualimpldate.focus();
			return false;
		} */
		if (document.myForm.approver_selected.value == "") {
			alert("Please provide Selected Approvers!");
			document.myForm.approver_selected.focus();
			return false;
		}
		if (document.myForm.quality.checked == false
				&& document.myForm.cost.checked == false
				&& document.myForm.delivery.checked == false
				&& document.myForm.material.checked == false
				&& document.myForm.safety.checked == false
				&& document.myForm.Dimensional.checked == false) {
			alert("Please provide Category Of Change");
			document.myForm.quality.focus();
			return false;
		}

		return (true);
	}
//-->
</script>
<!--============================================================================-->
<!--============================================================================-->

<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="tabledeleterow.js"></script>
<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}

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
		xmlhttp.open("GET", "Item_Name_Internal.jsp?q=" + str, true);
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
	function ClearList2(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function movedata(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('tracking_change');
			attribute2 = document.getElementById('tracking_selected');
		} else {
			attribute2 = document.getElementById('tracking_change');
			attribute1 = document.getElementById('tracking_selected');
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
		ClearList2(attribute1, attribute1);
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

<link href="jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<script src="js/jquery-1.7.2.min.js">
	
</script>
<script src="js/jquery-ui-1.8.18.custom.min.js">
	
</script>
<!--============================================================================-->
<!--============================================================================-->

</head>
<body id="sub_page">
	<div id="templatemo_wrapper">
		<div id="templatemo_top"></div>
		<!-- end of top -->

<!--============================================================================-->
<!--====================== Menu Bar ===============================-->
<!--============================================================================-->
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
			<h4 style="color: white;">Change Request Internal</h4>
			<div class="col_w630 float_l">
				<div id="contact_form">


					<div id="templatemo_header" class="ddsmoothmenu">

						<ul>

							<li style="background-color: #B3A6AA;"><a
								href="New_Request.jsp">Change Request Internal</a></li>
							<li style="background-color: #B3A6AA;"><a
								href="NewRequestCustomer.jsp">Change Request Customer</a></li>
						</ul>

					</div>

					<form name="myForm" method="post"
						action="Change_Request_Controller" enctype="multipart/form-data"
						onsubmit="return(validate());">
						<table>
							<tr>
								<%
									try {

										Connection con = Connection_Utility.getConnection();

										PreparedStatement ps_crno = con
												.prepareStatement("select Max(CR_No) from cr_tbl");
										ResultSet rs_crno = ps_crno.executeQuery();
										int cr_No = 0;
										while (rs_crno.next()) {
											cr_No = rs_crno.getInt("Max(CR_No)") + 1;
										}
								%>
								<td colspan="1"><b>Request Number</b> <input type="text"
									id="author" name="author" value="<%=cr_No%>"
									disabled="disabled" class="required input_field" /> <input
									type="hidden" name="crno" value="<%=cr_No%>" />
									<div class="cleaner h10"></div></td>

							</tr>
							<tr>
								<td colspan="1"><b>Company Name</b> <Select id="supplier"
									name="supplier" class="required input_field"
									title="Supplier Name"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"
									onchange="showState(this.value)">
										<option value="<%=0%>">----Select----</option>
										<%
											PreparedStatement ps = con
														.prepareStatement("select * from user_tbl_company where Company_Id!=6 order by company_name");
												ResultSet rs = ps.executeQuery();
												while (rs.next()) {
										%>
										<option value="<%=rs.getInt("Company_Id")%>"><%=rs.getString("Company_Name")%></option>
										<%
											}
										%>
								</Select>
									<div class="cleaner h10"></div></td>
								<td colspan="1"><b>Part Name</b>
									<div id="item">
										<Select id="item_name" class="required input_field"
											name="item_name" title="Part Name"
											onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
											onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
											<option value="0">----Select----</option>
										</select>
									</div>
									<div class="cleaner h10"></div></td>
							</tr>


							<tr>
								<td><b>Category Of Change</b></td>
							</tr>
							<tr>
								<td><input type="checkbox" value="2" name="quality"
									id="quality">Quality</td>
								<td><input type="checkbox" value="1" name="cost" id="cost">Cost</td>
								<td><input type="checkbox" value="6" name="Dimensional"
									id="Dimensional">Dimensional</td>
							</tr>
							<tr>
								<td><input type="checkbox" value="3" name="delivery"
									id="delivery">Delivery</td>
								<td><input type="checkbox" value="4" name="material"
									id="material">Material</td>

								<td colspan="2"><input type="checkbox" value="5"
									name="safety" id="safety">Safety</td>


							</tr>


							<tr></tr>
							<tr>
								<td colspan="1"><b>Change Type</b></td>
								<td></td>
								<td colspan="1"><b>Selected Change Type</b></td>
							</tr>
							<tr>
								<td colspan="1" align="left"><select id="change_name"
									name="change_name" multiple="multiple" size="5"
									style="width: 310px" title="Change Type"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">

										<%
											PreparedStatement ps_ct = con
														.prepareStatement("select * from cr_tbl_type order by cr_type");
												ResultSet rs_ct = ps_ct.executeQuery();
												while (rs_ct.next()) {
										%>

										<option value="<%=rs_ct.getString("CR_Type")%>"><%=rs_ct.getString("CR_Type")%></option>
										<%
											}
										%>

								</select></td>
								<td style="width: 50px;" align="center" align="center"><input
									value="&gt;&gt;" onclick="move('right', 'rep')" type="button"><br>
									<input value="&lt;&lt;" onclick="move('left', 'rep')"
									type="button"></td>
								<td colspan="1" align="right"><select id="change_selected"
									name="change_selected" multiple="multiple" size="5"
									style="width: 310px" title="Selected Change Type"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></select></td>
							</tr>
							<tr>
								<td><b>Present System</b></td>
								<td><b>Proposed System</b></td>
								<td><b>Objective</b></td>
							</tr>




							<tr>
								<td><textarea class="validate-subject required input_field"
										name="Present" id="Present" style="height: 75px"
										title="Present System"
										onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
										onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></textarea>
									<div class="cleaner h10"></div></td>
								<td><textarea class="validate-subject required input_field"
										name="Proposed" id="Proposed" style="height: 75px"
										title="Proposed System"
										onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
										onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></textarea>
									<div class="cleaner h10"></div></td>
								<td><textarea class="validate-subject required input_field"
										name="Objective" id="Objective" style="height: 75px"
										title="Objective"
										onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
										onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></textarea>
									<div class="cleaner h10"></div></td>
							</tr>

							<tr>
								<!-- ****************************************************************************************************************** -->
							<tr>

								<td colspan="1"><b>Tracking Change</b></td>
								<td></td>
								<td colspan="1"><b>Selected Tracking Change</b></td>
							</tr>
							<tr>
								<td colspan="1" align="left"><select id="tracking_change"
									name="tracking_change" multiple="multiple" size="5"
									style="width: 310px" title="Tracking Change"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">

										<%
											PreparedStatement ps_ct1 = con
														.prepareStatement("select * from cr_tracking_change order by TC_Type");
												ResultSet rs_ct1 = ps_ct1.executeQuery();
												while (rs_ct1.next()) {
										%>

										<option value="<%=rs_ct1.getString("TC_Type")%>"><%=rs_ct1.getString("TC_Type")%></option>
										<%
											}
										%>

								</select></td>
								<td style="width: 50px;" align="center" align="center"><input
									value="&gt;&gt;" onclick="movedata('right', 'rep')"
									type="button"><br> <input value="&lt;&lt;"
									onclick="movedata('left', 'rep')" type="button"></td>
								<td colspan="1" align="right"><select
									id="tracking_selected" name="tracking_selected"
									multiple="multiple" size="5" style="width: 310px"
									title="Selected Tracking Change"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></select></td>
							</tr>
							<!-- ****************************************************************************************************************** -->




							<tr>

								<td><b>Proposed date</b></td>
								<td><b>Actual Implementation date</b></td>
							</tr>
							<tr>

								<td><input id="demo3" name="proposeddate" type="text"
									size="25" readonly="readonly" title="Click on DatePicker">
									<a href="javascript:NewCal('demo3','ddmmyyyy',true,24)"> <img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></td>

								<div class="cleaner h10"></div>

								<td><input id="demo4" name="actualimpldate" type="text"
									size="25" readonly="readonly" title="Click on DatePicker">
									<a href="javascript:NewCal('demo4','ddmmyyyy',true,24)"> <img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></td>

								<div class="cleaner h10"></div>

							</tr>


							<tr>

								<td><b>Complaint No(Optional)</b></td>
							</tr>
							<tr>
								<td><input name="complaintno" type="text"
									class="validate-email required input_field" size="16"
									onfocus="if(this.value==this.defaultValue)this.value='';"
									onblur="if(this.value=='')this.value=this.defaultValue;"
									value="Related Complaint No(If any)"
									title="ComplaintNo(Optional)"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}" />

									<div class="cleaner h10"></div></td>
								<div class="cleaner h10"></div>

							</tr>



							<%-- 
							<tr>
								<td colspan="1"><b>Approvers</b></td>
								<td></td>
								<td colspan="1"><b>Selected Approvers</b></td>
							</tr>


							<tr>
								<td colspan="1"><select id="approver_name"
									name="approver_name" multiple="multiple" size="5"
									style="width: 310px" title="Approvers"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">

										<%
											PreparedStatement ps_user = con
														.prepareStatement("select distinct(U_Name) from user_tbl where Enable_id=1 order by U_name");
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
									style="width: 310px" title="Selected Approvers"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
								</select></td>
							</tr>
 --%>

							<tr>
								<td><b>Attachments </b></td>
							</tr>





							<table id="tblSample">

								<tr>
									&nbsp;&nbsp;&nbsp;
									<strong> <input type="button"
										value="  ADD More Files  " name="button"
										onclick="addRowToTable();" /></strong> &nbsp;&nbsp;
									<input type="button" value=" Delete [Selected] "
										onclick="deleteChecked();" />&nbsp;&nbsp;
									<input type="hidden" id="srno" name="srno" value="">
								</tr>
								<tbody></tbody>
							</table>


							<tr>
								<td></td>
							</tr>



							<tr>
								<td colspan="3" align="Center"><input type="submit"
									value="Suggestion" name="NewRequest"
									style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;"
									onclick="SendRequest();"> <input type="submit"
									value="Send Request & Add Action" name="NewAction"
									style="height: 35px; width: 200px; background-color: #C4C4C4; border-radius: 20px/20px;"
									onclick="Action();"> <input type="hidden" name="valReq"
									id="valReq"></td>
							</tr>
							<%
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
						</table>

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
<HEAD>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<META HTTP-EQUIV="Expires" CONTENT="-1">
</HEAD>
</html>