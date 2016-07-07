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
<!--======================== Design Script ====================================-->
<!--============================================================================-->
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>
<html>
<head>
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




<script type="text/javascript">
	function totalsum() {
		var a = document.getElementById("wip");
		var b = document.getElementById("cst");

		if (a.value == "") {
			a.value = 0;
		}
		if (b.value == "") {
			b.value = 0;
		}

		var f = parseFloat(a.value) + parseFloat(b.value);

		document.getElementById("total").value = f;
	}
</script>

<!--============================================================================-->
<!--============================================================================-->





<!--=================== Validation ===================================-->
<!--============================================================================-->
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
				&& document.myForm.safety.checked == false) {
			alert("Please provide Category Of Change");
			document.myForm.quality.focus();
			return false;
		}

		return (true);
	}
//-->
</script>



<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="tabledeleterow.js"></script>
<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}
	//<!--================== AJAX Get Item Name =========================-->
	//<!--============================================================================-->
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
				document.getElementById("item").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("GET", "Item_Name.jsp?q=" + str, true);
		xmlhttp.send();
	};

	//<!--============================================================================-->
	//<!--=========================AJAX get Customer Name =============================-->
	function showState2(str1) {

		var xmlhttp1;

		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp1 = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp1.onreadystatechange = function() {
			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {

				document.getElementById("cust").innerHTML = xmlhttp1.responseText;
			}

		};

		xmlhttp1.open("GET", "Customer_Name.jsp?p=" + str1, true);

		xmlhttp1.send();
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
			attribute1 = document.getElementById('department');
			attribute2 = document.getElementById('department_selected');
		} else {
			attribute2 = document.getElementById('department');
			attribute1 = document.getElementById('department_selected');
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
<!--=========================== Delete Attachment Customer ===========================-->
<!--============================================================================-->
<script type="text/javascript">

function showState111(str) {
	var xmlhttp;
	var where_to = confirm("Do you really want to DELETE this file ???");
	if (where_to == true) {

		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				window.location.reload(true);
				
			}
		};
		xmlhttp.open("GET", "Delete_Attach_Customer.jsp?p=" + str, true);
		xmlhttp.send();
	} else {
		window.opener.document.forms["myForm"];
	}
}
</script>
<!--============================================================================-->
<!--============================================================================-->
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
<!--============================================================================-->
<!--============================================================================-->
<link href="jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<script src="js/jquery-1.7.2.min.js">
	
</script>
<script src="js/jquery-ui-1.8.18.custom.min.js">
	
</script>

</head>
<body id="sub_page">
	<div id="templatemo_wrapper">
		<div id="templatemo_top"></div>
		<!-- end of top -->

<!--==================== Menu Bar ====================================-->
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
		<!--============================================================================-->
		<!--============================================================================-->
		<!-- end of templatemo_menu -->
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



					<form name="myForm" method="post"
						action="Edit_Customer_Request_Controller"
						enctype="multipart/form-data" onsubmit="return(validate());">
						<table>
							<tr>
								<%
									try {

										Connection con = Connection_Utility.getConnection();
										int crc_No = 0;
										crc_No = Integer.parseInt(request.getParameter("hid"));
										System.out.println("Cr No==== >" + crc_No);
										PreparedStatement ps_crcno = con
												.prepareStatement("select * from crc_tbl where CRC_No="
														+ crc_No);
										ResultSet rs_crcno = ps_crcno.executeQuery();
										int ECN = 0;
										while (rs_crcno.next()) {
											ECN = rs_crcno.getInt("CRC_No");

											//PreparedStatement ps3 = con.prepareStatement("select * from user_tbl where enable_id=1");
											PreparedStatement ps4 = con
													.prepareStatement("select * from category_tbl order by Category");
											PreparedStatement ps_ucomp = con
													.prepareStatement("select * from user_tbl_company where Company_Id="
															+ rs_crcno.getInt("Company_Id"));

											ResultSet rs_ucomp = ps_ucomp.executeQuery();

											ResultSet rs4 = ps4.executeQuery();
											//ResultSet rs3 = ps3.executeQuery();
								%>
								<td colspan="1"><b>Request Number</b></td>
							<tr>
								<td><input type="text" id="author" name="author"
									value="<%=ECN%>" disabled="disabled"
									class="required input_field" /> <input type="hidden"
									name="crcno" value="<%=ECN%>" />
									<div class="cleaner h10"></div></td>

							</tr>

							<tr>

								<td colspan="1"><b>COMPANY NAME</b></td>
							</tr>
							<tr>
								<td><select class="validate-email required input_field"
									id="element_5" name="cust_company_name"
									onchange="showState2(this.value)">
										<%
											while (rs_ucomp.next()) {
										%>
										<option value="<%=rs_ucomp.getInt("Company_Id")%>"><%=rs_ucomp.getString("Company_Name")%></option>
										<%
											}

													PreparedStatement ps_comp = con
															.prepareStatement("select * from user_tbl_company where Company_Id!="
																	+ rs_crcno.getInt("Company_Id")
																	+ " and company_id!=6");
													ResultSet rs_comp = ps_comp.executeQuery();
													while (rs_comp.next()) {
										%>
										<option value="<%=rs_comp.getInt("Company_Id")%>"><%=rs_comp.getString("Company_Name")%></option>
										<%
											}
										%>
								</select></td>

								<td colspan="1"><b>CUSTOMER NAME</b>

									<div id="cust">

										<select class="validate-email required input_field"
											id="element_5" name="cust_name"
											onchange="showState(this.value)">
											<%
												PreparedStatement ps_selCust = con
																.prepareStatement("select * from customer_tbl where Cust_Id="
																		+ rs_crcno.getInt("Cust_Id"));
														ResultSet rs_selCust = ps_selCust.executeQuery();
														while (rs_selCust.next()) {
											%>
											<option value="<%=rs_selCust.getInt("Cust_Id")%>"><%=rs_selCust.getString("Cust_Name")%></option>
											<%
												}
														PreparedStatement pCust = con
																.prepareStatement("select * from customer_tbl where Cust_Id!="
																		+ rs_crcno.getInt("Cust_Id"));
														ResultSet rCust = pCust.executeQuery();
														while (rCust.next()) {
											%>
											<option value="<%=rCust.getInt("Cust_Id")%>"><%=rCust.getString("Cust_Name")%></option>
											<%
												}
											%>

										</select>
									</div></td>
								<td colspan="1"><b>Component NAME</b>
									<div id="item">
										<select class="validate-email required input_field"
											id="element_6" name="item_name">


											<%
												PreparedStatement ps_selitem = con
																.prepareStatement("select * from customer_tbl_item where Item_Id="
																		+ rs_crcno.getInt("Item_Id"));
														ResultSet rs_selitem = ps_selitem.executeQuery();
														while (rs_selitem.next()) {
											%>
											<option value="<%=rs_selitem.getInt("Item_Id")%>"><%=rs_selitem.getString("Item_Name")%></option>
											<%
												}
											%>
											<%
												PreparedStatement pitem = con
																.prepareStatement("select * from customer_tbl_item where Item_Id!="
																		+ rs_crcno.getInt("Item_Id"));
														ResultSet rlitem = pitem.executeQuery();
														while (rlitem.next()) {
											%>
											<option value="<%=rlitem.getInt("Item_Id")%>"><%=rlitem.getString("Item_Name")%></option>
											<%
												}
											%>

										</select>
									</div></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<%
								String cfor = rs_crcno.getString("Change_For");
							%>

							<tr>
								<td>
									<%
										if (cfor.equalsIgnoreCase("casting")) {
									%> <b><input type="radio" name="change" value="casting"
										checked="checked" style="width: 40px;">Casting Change<input
										type="radio" name="change" value="machining"
										style="width: 40px;">Machining Change</b> <%
 	} else {
 %> <b><input type="radio" name="change" value="casting"
										style="width: 40px;">Casting Change<input type="radio"
										name="change" value="machining" checked="checked"
										style="width: 40px;">Machining Change</b> <%
 	}
 %>

								</td>
							</tr>


							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="1"><b>Existing change level</b><input
									type="text" class="required input_field"
									value="<%=rs_crcno.getString("Existing_Change_level")%>"
									name="extchg" />
									<div class="cleaner h10"></div></td>
								<td colspan="1"><b>Existing change level Date</b><input
									id="demo3" name="extchgdate"
									value="<%=rs_crcno
							.getTimestamp("Existing_Change_level_Date")%>"
									type="text" size="25" readonly="readonly"
									title="Click on DatePicker"> <a
									href="javascript:NewCal('demo3','ddmmyyyy',true,24)"> <img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a></td>

							</tr>

							<tr>
								<td colspan="1"><b>New change level</b><input type="text"
									class="required input_field" name="newchg"
									value="<%=rs_crcno.getString("New_Change_level")%>" />
									<div class="cleaner h10"></div></td>
								<td colspan="1"><b> New change level Date</b><input
									id="demo4" name="newchgdate" type="text" size="25"
									value="<%=rs_crcno.getString("New_Change_level_Date")%>"
									readonly="readonly" title="Click on DatePicker"> <a
									href="javascript:NewCal('demo4','ddmmyyyy',true,24)"><img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a></td>

							</tr>



							<tr>
								<td colspan="1"><b>Nature of Change</b> <textarea
										class="validate-subject required input_field" name="naturechg"
										id="naturechg" style="height: 75px" title="Nature of Change"><%=rs_crcno.getString("Nature_Of_Change")%></textarea>
									<div class="cleaner h10"></div></td>
								<td colspan="1"><b>Reason for change</b> <textarea
										class="validate-subject required input_field" name="reasonchg"
										id="reasonchg" style="height: 75px" title="Reason for change"><%=rs_crcno.getString("Reason_For_Change")%></textarea>
									<div class="cleaner h10"></div></td>

							</tr>



							<tr>

								<td colspan="1"><b>Targeted cut-off date for
										implementation</b><input id="demo" name="targetdate" type="text"
									size="25" readonly="readonly" title="Click on DatePicker"
									value="<%=rs_crcno.getTimestamp("Targated_Impl_Date")%>">
									<a href="javascript:NewCal('demo','ddmmyyyy',true,24)"><img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a></td>

							</tr>

							<tr>
								<td></td>
							</tr>
							<tr>
								<td><b> Level Change</b></td>
							</tr>






							<%
								String level = rs_crcno.getString("Change_Level");

										if (level.equals("level1")) {
							%>
							<tr>
								<td>Level 1<input type="radio" name="level" value="level1"
									checked="checked" style="width: 40px;">Level 2<input
									type="radio" name="level" value="level2" style="width: 40px;"></td>
							</tr>


							<tr>
								<td>Level 3<input type="radio" name="level" value="level3"
									style="width: 40px;">Level 4<input type="radio"
									name="level" value="level4" style="width: 40px;"></td>
							</tr>
							<%
								} else if (level.equals("level2")) {
							%>
							<tr>
								<td>Level 1<input type="radio" name="level" value="level1"
									style="width: 40px;">Level 2<input type="radio"
									name="level" value="level2" checked="checked"
									style="width: 40px;"></td>
							</tr>


							<tr>
								<td>Level 3<input type="radio" name="level" value="level3"
									style="width: 40px;">Level 4<input type="radio"
									name="level" value="level4" style="width: 40px;"></td>
							</tr>
							<%
								} else if (level.equals("level3")) {
							%>
							<tr>
								<td>Level 1<input type="radio" name="level" value="level1"
									style="width: 40px;">Level 2<input type="radio"
									name="level" value="level2" style="width: 40px;"></td>
							</tr>


							<tr>
								<td>Level 3<input type="radio" name="level" value="level3"
									checked="checked" style="width: 40px;">Level 4<input
									type="radio" name="level" value="level4" style="width: 40px;"></td>
							</tr>
							<%
								} else {
							%>

							<tr>
								<td>Level 1<input type="radio" name="level" value="level1"
									style="width: 40px;">Level 2<input type="radio"
									name="level" value="level2" style="width: 40px;"></td>
							</tr>


							<tr>
								<td>Level 3<input type="radio" name="level" value="level3"
									checked="checked" style="width: 40px;">Level 4<input
									type="radio" name="level" value="level4" checked="checked"
									style="width: 40px;"></td>
							</tr>

							<%
								}
							%>

							<tr>
								<td><b>Existing Stock ===> </b></td>
							</tr>
							<tr>
								<td><b>WIP</b><input type="text"
									class="required input_field" name="wip" id="wip"
									value="<%=rs_crcno.getDouble("Existing_WIP_Stock")%>"
									onkeyup="totalsum();" />
									<div class="cleaner h10"></div></td>
								<td><b>As Cast</b><input type="text"
									class="required input_field" name="ascast" id="cst"
									value="<%=rs_crcno.getDouble("Existing_As_Cast_Stock")%>"
									onkeyup="totalsum();" />
									<div class="cleaner h10"></div></td>
							</tr>
							<tr>
								<td><b>Total ===></b></td>
							</tr>
							<tr>
								<td><b><input type="text" class="required input_field"
										name="total" id="total"
										value="<%=rs_crcno.getDouble("Total_Stock")%>" /></b></td>
							</tr>





							<tr>
								<td><b>Tooling ===> </b></td>
							</tr>
							<tr>
								<td><b>Old</b><input type="text"
									class="required input_field" name="oldtool"
									value="<%=rs_crcno.getDouble("Tooling_Old")%>" />
									<div class="cleaner h10"></div></td>
								<td><b>New</b><input type="text"
									value="<%=rs_crcno.getDouble("Tooling_New")%>"
									class="required input_field" name="newtool" />
									<div class="cleaner h10"></div></td>
							</tr>
							<tr>
								<td><b>Old Fixture</b><input type="text"
									value="<%=rs_crcno.getDouble("Fixture_Old")%>"
									class="required input_field" name="old_fixture" />
									<div class="cleaner h10"></div></td>
								<td><b>New Fixture</b><input type="text"
									value="<%=rs_crcno.getDouble("Fixture_New")%>"
									class="required input_field" name="new_fixture" />
									<div class="cleaner h10"></div></td>
							</tr>




							<tr>
								<td><b>Gauges ===> </b></td>
							</tr>
							<tr>
								<td><b>Old Gauges</b><input type="text"
									value="<%=rs_crcno.getDouble("Gauges_Old")%>"
									class="required input_field" name="old_gauges" />
									<div class="cleaner h10"></div></td>
								<td><b>New Gauges</b><input type="text"
									value="<%=rs_crcno.getDouble("Gauges_New")%>"
									class="required input_field" name="new_gauges" />
									<div class="cleaner h10"></div></td>
							</tr>

							<tr>
								<td><b>Re PPAP ===> </b></td>
							</tr>
							<tr>

								<%
									String ppap = rs_crcno.getString("PPAP");

											if (ppap.equals("Required")) {
								%>
								<td><b><input type="radio" name="ppap"
										checked="checked" value="Required" style="width: 40px;">Required<input
										type="radio" name="ppap" value="Not Required"
										style="width: 40px;">Not Required</b></td>
								<%
									} else {
								%>
								<td><b><input type="radio" name="ppap" value="Required"
										style="width: 40px;">Required<input type="radio"
										name="ppap" value="Not Required" checked="checked"
										style="width: 40px;">Not Required</b></td>
								<%
									}
								%>
							</tr>


							<tr>

								<td colspan="1"><b>Actual date of implementation</b><input
									id="demo5" name="Actualimpldate" type="text" size="25"
									readonly="readonly" title="Click on DatePicker"
									value="<%=rs_crcno.getTimestamp("Actual_Impl_Date")%>">
									<a href="javascript:NewCal('demo5','ddmmyyyy',true,24)"> <img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a></td>
							</tr>





							<tr>
								<td colspan="1"><b>Concern Department</b></td>
								<td></td>
								<td colspan="1"><b>Selected Department</b></td>
							</tr>
							<tr>
								<td colspan="1" align="left"><select id="department"
									name="department" multiple="multiple" size="5"
									style="width: 310px" title="Concern Department">

										<%
											PreparedStatement ps_ct1 = con
															.prepareStatement("select * from user_tbl_dept");
													ResultSet rs_ct1 = ps_ct1.executeQuery();
													while (rs_ct1.next()) {
										%>

										<option value="<%=rs_ct1.getString("Department")%>"><%=rs_ct1.getString("Department")%></option>
										<%
											}
										%>

								</select></td>
								<td style="width: 50px;" align="center" align="center"><input
									value="&gt;&gt;" onclick="movedata('right', 'rep')"
									type="button"><br> <input value="&lt;&lt;"
									onclick="movedata('left', 'rep')" type="button"></td>
								<td colspan="1" align="right"><select
									id="department_selected" name="department_selected"
									multiple="multiple" size="5" style="width: 310px"
									title="Selected Concern Department">

										<%
											PreparedStatement ps_deptId = con
															.prepareStatement("select dept_id from crc_tbl_cocern_dept where CRC_No="
																	+ crc_No);
													ResultSet rs_deptId = ps_deptId.executeQuery();
													while (rs_deptId.next()) {
														PreparedStatement ps_deptName = con
																.prepareStatement("select * from User_Tbl_Dept where dept_id="
																		+ rs_deptId.getInt("dept_id"));

														ResultSet rs_deptName = ps_deptName.executeQuery();

														while (rs_deptName.next()) {
										%>
										<option selected="selected"
											value="<%=rs_deptName.getString("Department")%>"><%=rs_deptName.getString("Department")%></option>
										<%
											}
													}
										%>


								</select></td>
							</tr>






							<%-- 	<tr>
								<td><b>Approver Name</b></td>
							</tr>





							<tr>
								<td colspan="1"><select id="approver_name"
									name="approver_name" multiple="multiple" size="5"
									style="width: 310px" title="Approvers"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">

										<%
											PreparedStatement ps_user = con
															.prepareStatement("select distinct(U_Name) from user_tbl");
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
									style="width: 310px" title="Selected Approvers">




										<%
											PreparedStatement ps_UId = con
															.prepareStatement("select U_Id from crc_tbl_approver_rel where CRC_No="
																	+ crc_No);
													ResultSet rs_UId = ps_UId.executeQuery();
													while (rs_UId.next()) {
														PreparedStatement ps_UName = con
																.prepareStatement("select * from User_Tbl where u_id="
																		+ rs_UId.getInt("u_id"));

														ResultSet rs_UName = ps_UName.executeQuery();

														while (rs_UName.next()) {
										%>
										<option selected="selected"
											value="<%=rs_UName.getString("U_Name")%>"><%=rs_UName.getString("U_Name")%></option>
										<%
											}
													}
										%>




								</select></td>
							</tr> --%>


							<tr>
								<td><b>Attached Files </b></td>
							</tr>
							<tr>

								<td width="390px">
									<%
										/****************************************************************************************************************
																																																																																																																																																																																																																								TO SELECT ATTACHMENTS RELATED TO Action NUMBER 							
												 ****************************************************************************************************************/
												PreparedStatement ps_file = null;

												ps_file = con
														.prepareStatement("select * from crc_tbl_attachment where CRC_No="
																+ crc_No + " and Del_Status=1");
												ResultSet rs_file = ps_file.executeQuery();
												while (rs_file.next()) {
									%>
									<table width="390px">
										<tr>
											<td width="270px" align="left"><a
												href="Display_Attach_Customer.jsp?field=<%=rs_file.getString("CRC_File_Name")%>"
												style="color: #1E5734"><b> <%=rs_file.getString("CRC_File_Name")%></b></a><input
												type="button" value=" Remove "
												onclick="showState111(<%=rs_file.getInt("Crc_Attach_Id")%>)"></td>
										</tr>
									</table> <%
 	}
 %>
								</td>
							</tr>

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
								}
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