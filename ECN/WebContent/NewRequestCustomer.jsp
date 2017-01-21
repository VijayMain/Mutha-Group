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
<!--===================== Design Script =================================-->
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
<!--================== Validation ==================================-->
<!--============================================================================-->

<script type="text/javascript">
<!--
	// Form validation code will come here.
	function validate() {

		if (document.myForm.cust_company_name.value == "") {
			alert("Please provide Company Name !!!");
			document.myForm.cust_company_name.focus();
			return false;
		}

		if (document.myForm.item_name.value == "") {
			alert("Please provide  Customer and Part Name !!!");
			document.myForm.item_name.focus();
			return false;
		}

		if (document.myForm.extchg.value == "") {
			alert("Please provide Existing change level !!!");
			document.myForm.extchg.focus();
			return false;
		}

		if (document.myForm.demo3.value == "") {
			alert("Please provide Existing change level date !!!");
			document.myForm.demo3.focus();
			return false;
		}

		if (document.myForm.newchg.value == "") {
			alert("Please provide New change level !!!");
			document.myForm.newchg.focus();
			return false;
		}

		if (document.myForm.demo4.value == "") {
			alert("Please provide New change level date !!!");
			document.myForm.demo4.focus();
			return false;
		}

		if (document.myForm.naturechg.value == "") {
			alert("Please provide Nature of change !!!");
			document.myForm.naturechg.focus();
			return false;
		}

		if (document.myForm.reasonchg.value == "") {
			alert("Please provide Reason for change !!!");
			document.myForm.reasonchg.focus();
			return false;
		}

		if (document.myForm.demo.value == "") {
			alert("Please provide Targeted cut-off date for implementation !!!");
			document.myForm.demo.focus();
			return false;
		}

		if (document.myForm.wip.value == "") {
			alert("Please provide Existing Stock WIP !!!");
			document.myForm.wip.focus();
			return false;
		}

		if (document.myForm.cst.value == "") {
			alert("Please provide Existing Stock AsCast !!!");
			document.myForm.cst.focus();
			return false;
		}

		if (document.myForm.oldtool.value == "") {
			alert("Please provide Tooling old !!!");
			document.myForm.oldtool.focus();
			return false;
		}

		if (document.myForm.newtool.value == "") {
			alert("Please provide Tooling new !!!");
			document.myForm.newtool.focus();
			return false;
		}

		if (document.myForm.old_fixture.value == "") {
			alert("Please provide Fixture !!!");
			document.myForm.old_fixture.focus();
			return false;
		}

		if (document.myForm.old_gauges.value == "") {
			alert("Please provide Gauges !!!");
			document.myForm.old_gauges.focus();
			return false;
		}
		if (document.myForm.new_gauges.value == "") {
			alert("Please provide Gauges  !!!");
			document.myForm.new_gauges.focus();
			return false;
		}

		if (document.myForm.approver_selected.value == "") {
			alert("Please provide Approvers !!!");
			document.myForm.approver_selected.focus();
			return false;
		}

		if (document.myForm.department_selected.value == "") {
			alert("Please provide Concern Department !!!");
			document.myForm.department_selected.focus();
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
				document.getElementById("item").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("GET", "Item_Name.jsp?q=" + str, true);
		xmlhttp.send();
	};

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
<!--===================== Menu Bar ============================-->
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
			<h4 style="color: white;">Change Request Customer</h4>
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
						action="Customer_Request_Controller" enctype="multipart/form-data"
						onsubmit="return(validate());">
						<table>
							<tr>
								<%
									try {

										Connection con = Connection_Utility.getConnection();
										PreparedStatement ps = con
												.prepareStatement("select * from customer_tbl order by Cust_name");
										PreparedStatement ps1 = con
												.prepareStatement("select * from customer_tbl_item order by Item_name");

										//PreparedStatement ps3 = con.prepareStatement("select * from user_tbl where enable_id=1");
										PreparedStatement ps4 = con
												.prepareStatement("select * from category_tbl order by Category");
										PreparedStatement ps_ucomp = con
												.prepareStatement("select * from user_tbl_company where company_id!=6 order by Company_Name");

										ResultSet rs_ucomp = ps_ucomp.executeQuery();

										ResultSet rs4 = ps4.executeQuery();
										//ResultSet rs3 = ps3.executeQuery();

										ResultSet rs1 = ps1.executeQuery();
										ResultSet rs = ps.executeQuery();

										PreparedStatement ps_crcno = con
												.prepareStatement("select Max(CRC_No) from crc_tbl");
										ResultSet rs_crcno = ps_crcno.executeQuery();
										int ECN = 0;
										while (rs_crcno.next()) {
											ECN = rs_crcno.getInt("Max(CRC_No)") + 1;
										}
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
									id="cust_company_name" name="cust_company_name"
									onchange="showState2(this.value)">
										<option value="">-------SELECT-------</option>
										<%
											while (rs_ucomp.next()) {
										%>
										<option value="<%=rs_ucomp.getInt("Company_Id")%>"><%=rs_ucomp.getString("Company_Name")%></option>
										<%
											}
										%>
								</select></td>

								<td colspan="1"><b>CUSTOMER NAME</b>
									<div id="cust">

										<select class="validate-email required input_field"
											id="cust_name" name="cust_name"
											onchange="showState(this.value)">
											<option value="">-------SELECT-------</option>

										</select>
									</div></td>
								<td colspan="1"><b>Component NAME</b>
									<div id="item">
										<select class="validate-email required input_field"
											id="item_name" name="item_name">
											<option value="">-------SELECT-------</option>

										</select>
									</div></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>


							<tr>
								<td><b><input type="radio" name="change" id="change"
										value="casting" style="width: 40px;">Casting Change<input
										type="radio" name="change" value="machining" id="change"
										style="width: 40px;">Machining Change</b></td>
							</tr>


							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="1"><b>Existing change level</b><input
									type="text" class="required input_field" name="extchg"
									id="extchg" />
									<div class="cleaner h10"></div></td>
								<td colspan="1"><b>Existing change level Date</b><input
									id="demo3" name="extchgdate" type="text" size="25"
									readonly="readonly" title="Click on DatePicker"> <a
									href="javascript:NewCal('demo3','ddmmyyyy',true,24)"> <img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a></td>

							</tr>

							<tr>
								<td colspan="1"><b>New change level</b><input type="text"
									class="required input_field" name="newchg" id="newchg" />
									<div class="cleaner h10"></div></td>
								<td colspan="1"><b> New change level Date</b><input
									id="demo4" name="newchgdate" type="text" size="25"
									readonly="readonly" title="Click on DatePicker"> <a
									href="javascript:NewCal('demo4','ddmmyyyy',true,24)"><img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a></td>

							</tr>



							<tr>
								<td colspan="1"><b>Nature of Change</b> <textarea
										class="validate-subject required input_field" name="naturechg"
										id="naturechg" style="height: 75px" title="Nature of Change"></textarea>
									<div class="cleaner h10"></div></td>
								<td colspan="1"><b>Reason for change</b> <textarea
										class="validate-subject required input_field" name="reasonchg"
										id="reasonchg" style="height: 75px" title="Reason for change"></textarea>
									<div class="cleaner h10"></div></td>

							</tr>



							<tr>

								<td colspan="1"><b>Targeted cut-off date for
										implementation</b><input id="demo" name="targetdate" type="text"
									size="25" readonly="readonly" title="Click on DatePicker">
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
							<tr>
								<td>Level 1<input type="radio" name="level" value="level1"
									id="level1" style="width: 40px;">Level 2<input
									id="level2" type="radio" name="level" value="level2"
									style="width: 40px;"></td>
							</tr>


							<tr>
								<td>Level 3<input type="radio" name="level" value="level3"
									id="level3" style="width: 40px;">Level 4<input
									type="radio" name="level" value="level4" style="width: 40px;"
									id="level4"></td>
							</tr>
							<tr>
								<td><b>Existing Stock ===> </b></td>
							</tr>
							<tr>
								<td><b>WIP</b><input type="text"
									class="required input_field" name="wip" id="wip"
									onkeyup="totalsum();" />
									<div class="cleaner h10"></div></td>
								<td><b>As Cast</b><input type="text"
									class="required input_field" name="ascast" id="cst"
									onkeyup="totalsum();" />
									<div class="cleaner h10"></div></td>
							</tr>
							<tr>
								<td><b>Total ===></b></td>
							</tr>
							<tr>
								<td><b><input type="text" class="required input_field"
										name="total" id="total" /></b></td>
							</tr>





							<tr>
								<td><b>Tooling ===> </b></td>
							</tr>
							<tr>
								<td><b>Old</b><input type="text" id="oldtool"
									class="required input_field" name="oldtool" />
									<div class="cleaner h10"></div></td>
								<td><b>New</b><input type="text" id="newtool"
									class="required input_field" name="newtool" />
									<div class="cleaner h10"></div></td>
							</tr>
							<tr>
								<td><b>Old Fixture</b><input type="text" id="old_fixture"
									class="required input_field" name="old_fixture" />
									<div class="cleaner h10"></div></td>
								<td><b>New Fixture</b><input type="text" id="new_fixture"
									class="required input_field" name="new_fixture" />
									<div class="cleaner h10"></div></td>
							</tr>




							<tr>
								<td><b>Gauges ===> </b></td>
							</tr>
							<tr>
								<td><b>Old Gauges</b><input type="text" id="old_gauges"
									class="required input_field" name="old_gauges" />
									<div class="cleaner h10"></div></td>
								<td><b>New Gauges</b><input type="text" id="new_gauges"
									class="required input_field" name="new_gauges" />
									<div class="cleaner h10"></div></td>
							</tr>

							<tr>
								<td><b>Re PPAP ===> </b></td>
							</tr>
							<tr>



								<td><b><input type="radio" name="ppap" value="Required"
										id="ppapr" style="width: 40px;">Required<input
										id="ppapnr" type="radio" name="ppap" value="Not Required"
										style="width: 40px;">Not Required</b></td>




								<td colspan="1"><b>Actual date of implementation</b><input
									id="demo5" name="Actualimpldate" type="text" size="25"
									readonly="readonly" title="Click on DatePicker"> <a
									href="javascript:NewCal('demo5','ddmmyyyy',true,24)"> <img
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
														.prepareStatement("select * from user_tbl_dept order by Department");
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
									title="Selected Concern Department"></select></td>
							</tr>




							<%-- 

							<tr>
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