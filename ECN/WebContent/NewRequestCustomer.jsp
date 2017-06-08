<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.PreparedStatement"%>
 <html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ECN New Request</title>
<script type="text/javascript" src="tabledeleterow.js"></script>
<script language="javascript" type="text/javascript" src="datetimepicker.js"></script>
<script type="text/javascript">
	function SendRequest() {
		var current = document.getElementById("valReq");
		current.value = 1;
	}
	function Action() {
		var current = document.getElementById("valReq");
		current.value = 2;
	}
	function validateForm() {
		var cust_company_name = document.getElementById("cust_company_name");   
		var cust_name = document.getElementById("cust_name");    
		var item_name = document.getElementById("item_name");
		var change_cast   = document.getElementById("change_cast");
		var change_mac = document.getElementById("change_mac"); 
		var targetdate = document.getElementById("targetdate");
		var extchg  = document.getElementById("extchg");
		var extchgdate  = document.getElementById("extchgdate");
		var newchg = document.getElementById("newchg");
		var newchgdate = document.getElementById("newchgdate");
		var naturechg = document.getElementById("naturechg");
		var reasonchg = document.getElementById("reasonchg");   
		var level1 = document.getElementById("level1"); 
		var level2 = document.getElementById("level2");
		var level3 = document.getElementById("level3");
		var level4 = document.getElementById("level4");  
		var wip = document.getElementById("wip");
		var ascast = document.getElementById("ascast"); 
		var oldtool = document.getElementById("oldtool");
		var newtool = document.getElementById("newtool");
		var old_fixture = document.getElementById("old_fixture");
		var new_fixture = document.getElementById("new_fixture");
		var old_gauges = document.getElementById("old_gauges");
		var new_gauges = document.getElementById("new_gauges");
		var ppapr = document.getElementById("ppapr");
		var ppapnr = document.getElementById("ppapnr");
		var department_selected = document.getElementById("department_selected");
		
			if (cust_company_name.value=="0" || cust_company_name.value==null || cust_company_name.value=="" || cust_company_name.value=="null") {
				alert("COMPANY NAME ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (cust_name.value=="0" || cust_name.value==null || cust_name.value=="" || cust_name.value=="null") {
				alert("Customer  Name ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (item_name.value=="0" || item_name.value==null || item_name.value=="" || item_name.value=="null") {
				alert("Component  Name ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			
			if (change_cast.checked == false && change_mac.checked == false) {
				alert("Change Type ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}     
			if (targetdate.value=="0" || targetdate.value==null || targetdate.value=="" || targetdate.value=="null") {
				alert("Targeted cut-off date for implementation ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (extchg.value=="0" || extchg.value==null || extchg.value=="" || extchg.value=="null") {
				alert("Existing change level ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (extchgdate.value=="0" || extchgdate.value==null || extchgdate.value=="" || extchgdate.value=="null") {
				alert("Existing change level Date ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			
			if (newchg.value=="0" || newchg.value==null || newchg.value=="" || newchg.value=="null") {
				alert("New change level ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (newchgdate.value=="0" || newchgdate.value==null || newchgdate.value=="" || newchgdate.value=="null") {
				alert("New change level Date ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (naturechg.value=="0" || naturechg.value==null || naturechg.value=="" || naturechg.value=="null") {
				alert("Nature of Change ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (reasonchg.value=="0" || reasonchg.value==null || reasonchg.value=="" || reasonchg.value=="null") {
				alert("Reason for change ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (level1.checked == false && level2.checked == false && level3.checked == false && level4.checked == false) {
				alert("Level of Change ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (wip.value==null || wip.value=="" || wip.value=="null") {
				alert("Existing Stock WIP ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (ascast.value==null || ascast.value=="" || ascast.value=="null") {
				alert("Existing Stock As Cast ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (oldtool.value==null || oldtool.value=="" || oldtool.value=="null") {
				alert("Old Tooling ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (newtool.value==null || newtool.value=="" || newtool.value=="null") {
				alert("New Tooling ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (old_fixture.value==null || old_fixture.value=="" || old_fixture.value=="null") {
				alert("Old Fixture ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (new_fixture.value==null || new_fixture.value=="" || new_fixture.value=="null") {
				alert("New Fixture ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (old_gauges.value==null || old_gauges.value=="" || old_gauges.value=="null") {
				alert("Old Gauges ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (new_gauges.value==null || new_gauges.value=="" || new_gauges.value=="null") {
				alert("New Gauges ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
		//  cust_company_name   cust_name   item_name   change_cast   change_mac   targetdate    extchg   extchgdate   newchg  newchgdate    naturechg   reasonchg   
		//  level1  level2   level3   level4   wip   ascast   total   oldtool   newtool   old_fixture   new_fixture   old_gauges    new_gauges   ppapr   ppapnr   department_selected
			if (ppapr.checked == false && ppapnr.checked == false) {
				alert("Re PPAP ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			if (department_selected.value==null || department_selected.value=="" || department_selected.value=="null") {
				alert("Selected Department ?");
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}
			
			document.getElementById("NewRequest").disabled = true;
			document.getElementById("NewAction").disabled = true;
			return true;
		}
</script>

<script type="text/javascript">
	function totalsum() {
		var a = document.getElementById("wip");
		var b = document.getElementById("ascast");

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
<script type="text/javascript" src="js/ddsmoothmenu.js"> </script>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
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
<link href="css_pirobox/white/style.css" media="screen" title="shadow" rel="stylesheet" type="text/css" /> 
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(
		  function () {			              
		    $( "#extchgdate" ).datepicker({
		      changeMonth: true,
		      changeYear: true 
		    });
		    $( "#newchgdate" ).datepicker({
			      changeMonth: true,
			      changeYear: true 
			 });
		    $( "#targetdate" ).datepicker({
			      changeMonth: true,
			      changeYear: true 
			 });
			 $( "#Actualimpldate" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
			 });
		  } 
		); 

</script>
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
<style type="text/css">
.tftable {
	font-size: 11px;
	color: #333333;
	width: 90%;  
}

.tftable th {
	font-size: 11px;
	background-color: #388EAB; 
	padding: 4px; 
	color: white;
	text-align: center;
}

.tftable tr {
	background-color: white;
	font-size: 11px;
}
.tftable td {
	font-size: 11px; 
	padding: 6px; 
}
</style>
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

<!-- 
<link href="jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<script src="js/jquery-1.7.2.min.js">
	
</script>
<script src="js/jquery-ui-1.8.18.custom.min.js">
	
</script> 
-->
 
</head>
<body id="sub_page">
<%
try {
	Connection con = Connection_Utility.getConnection();
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
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
				<li><a href="New_Request.jsp" style="background-color: #808080"><b>New Request</b></a></li>
				<!-- <li><a href="Cab_Edit_Request.jsp">Edit Request</a></li> -->
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li><a href="My_Approvals.jsp">Details</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li style="text-align: center;"><a href="logout.jsp">Log Out <b style="font-size: 9px;">( <%=user_name%> )</b></a></li>
			</ul> 
		</div>
		<!-- end of templatemo_menu 
		<div id="templatemo_menu">
			<div id="site_title">
				<h1 style="color: orange;">ECN</h1>
			</div>
		</div> 
		end of header -->

		<!-- <div id="templatemo_main">
			<h4 style="color: white;">Change Request Customer</h4>
			<div class="col_w630 float_l">
				<div id="contact_form"> -->


					<!-- <div id="templatemo_header" class="ddsmoothmenu"> 
						<ul>
							<li style="background-color: #B3A6AA;"><a
								href="New_Request.jsp">Change Request Internal</a></li>
							<li style="background-color: #B3A6AA;"><a
								href="NewRequestCustomer.jsp">Change Request Customer</a></li>
						</ul> 
					</div> -->
				<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%">
 						<ul>
 							<li style="background-color: #B3A6AA;"><a href="New_Request.jsp">Change Request Internal</a></li>
							<li style="background-color: #1c6f8a;color: white;"><a href="NewRequestCustomer.jsp"><b>Change Request Customer</b></a></li>
						</ul>
					</div>

				<div style="height: 550px;width: 100%;">	
					<form name="myForm" method="post" action="Customer_Request_Controller" enctype="multipart/form-data" onSubmit="return validateForm();">
						<table style="width: 100%;" class="tftable"> 
								<%	
										PreparedStatement ps = con.prepareStatement("select * from customer_tbl order by Cust_name");
										PreparedStatement ps1 = con.prepareStatement("select * from customer_tbl_item order by Item_name");

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
							<tr>		
								<td colspan="1"><b>Request Number :</b></td>
								<td colspan="5" align="left"><input type="text" id="author" name="author"
									value="<%=ECN%>" disabled="disabled" style="font-weight: bold;"
									class="required input_field" /> <input type="hidden"
									name="crcno" value="<%=ECN%>" /></td> 
							</tr> 
							<tr> 
								<td colspan="1"><b>Company Name :</b></td> 
								<td colspan="5" align="left">
								<select class="validate-email required input_field" style="font-weight:bold;  background-color: #dcf1f8"
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
								</select>
								</td> 
								</tr>
								<tr>
								<td colspan="1"><b>Customer Name : </b></td>
								<td colspan="5" align="left">
									<div id="cust"> 
										<select class="validate-email required input_field" style="font-weight:bold;  background-color: #dcf1f8" id="cust_name" name="cust_name"
											onchange="showState(this.value)">
											<option value="">-------SELECT-------</option>
										</select>
									</div></td>
								</tr>
								<tr>	
								<td colspan="1"><b>Component Name :</b></td>
								<td colspan="5">
									<div id="item">
										<select class="validate-email required input_field" style="font-weight:bold;  background-color: #dcf1f8"  id="item_name" name="item_name">
											<option value="">-------SELECT-------</option> 
										</select>
									</div></td>
							</tr>  
							<tr>
								<td colspan="1"><b>Change Type : </b></td>
								<td colspan="1" align="left">&nbsp;&nbsp;&nbsp;
								<input type="radio" name="change" id="change_cast" value="casting" style="width: 40px;font-weight:bold;  background-color: #dcf1f8"><b>Casting Change</b>		
								<input type="radio" name="change"id="change_mac"  value="machining" style="width: 40px;font-weight:bold;  background-color: #dcf1f8"><b>Machining Change</b>
								</td>
								<td colspan="1"><b>Targeted cut-off date for implementation :</b> 
								<td colspan="3">
								<input type="text" name="targetdate" id="targetdate" readonly="readonly" style="height: 22px; width: 150px; font-weight:bold;  background-color: #dcf1f8"/>
									<!-- <input id="demo" name="targetdate" type="text"
									size="25" readonly="readonly" title="Click on DatePicker">
									<a href="javascript:NewCal('demo','ddmmyyyy',true,24)"><img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a> --> 
								</td>
							</tr> 
							<tr>
								<td colspan="1"><b>Existing change level : </b></td>
								<td colspan="1"> <input type="text" class="required input_field" name="extchg" id="extchg" style="font-weight:bold;  background-color: #dcf1f8"/> </td>
								<td colspan="1"><b>Existing change level Date :</b></td>
								<td colspan="3"><input type="text" name="extchgdate" id="extchgdate" readonly="readonly" style="height: 22px; width: 150px; font-weight:bold;  background-color: #dcf1f8"/>
								<!-- <input
									id="demo3" name="extchgdate" type="text" size="25"
									readonly="readonly" title="Click on DatePicker"> <a
									href="javascript:NewCal('demo3','ddmmyyyy',true,24)"> <img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a> -->
								</td> 
							</tr>

							<tr>
								<td colspan="1"><b>New change level :</b></td>
								<td colspan="1"> <input type="text" class="required input_field" name="newchg" id="newchg" style="font-weight:bold;  background-color: #dcf1f8"/> </td>
								<td colspan="1"><b> New change level Date :</b></td>
								<td colspan="3"> <input type="text" name="newchgdate" id="newchgdate" readonly="readonly" style="height: 22px; width: 150px; font-weight:bold;  background-color: #dcf1f8"/>
							<!-- 	<input
									id="demo4" name="newchgdate" type="text" size="25"
									readonly="readonly" title="Click on DatePicker"> <a
									href="javascript:NewCal('demo4','ddmmyyyy',true,24)"><img
										src="cal.gif" width="16" height="16" border="0"
										alt="Pick a date"></a> -->
								</td> 
							</tr> 
							<tr>
								<td colspan="1"><b>Nature of Change :</b>
								<td colspan="1"> 
								<textarea class="validate-subject required input_field" name="naturechg" id="naturechg" rows="4" cols="30" style="font-weight:bold;  background-color: #dcf1f8" title="Nature of Change"></textarea> </td>
								<td colspan="2"><b>Reason for change :</b>
								<td colspan="2"> 
								<textarea class="validate-subject required input_field" name="reasonchg" id="reasonchg" rows="4" cols="30" style="font-weight:bold;  background-color: #dcf1f8" title="Reason for change"></textarea> </td> 
							</tr>
							<tr>
								<td><b> Level of Change :</b></td> 
								<td colspan="5" align="left">
								<b>Level 1 </b> <input type="radio" name="level" value="level1" id="level1" style="width: 40px;font-weight:bold;  background-color: #dcf1f8">&nbsp;
								<b>Level 2 </b> <input id="level2" type="radio" name="level" value="level2" style="width: 40px;font-weight:bold;  background-color: #dcf1f8">&nbsp;
								<b>Level 3 </b> <input type="radio" name="level" value="level3" id="level3" style="width: 40px;font-weight:bold;  background-color: #dcf1f8">&nbsp;
								<b>Level 4 </b> <input type="radio" name="level" value="level4" id="level4" style="width: 40px;font-weight:bold;  background-color: #dcf1f8">&nbsp;
								</td>
							</tr>
							<tr>
								<td colspan="1"><b>Existing Stock : </b></td>  
								<td colspan="5">
									<b>WIP : </b>
<input type="text" onkeypress="return validatenumerics(event);" style="font-weight:bold;  background-color: #dcf1f8;text-align: right;" class="required input_field" name="wip" id="wip" onkeyup="totalsum();" />&nbsp;&nbsp;
									<b>As Cast : </b>
<input type="text" onkeypress="return validatenumerics(event);" style="font-weight:bold;  background-color: #dcf1f8;text-align: right;" class="required input_field" name="ascast" id="ascast" onkeyup="totalsum();" />&nbsp; &nbsp; 
									<b>Total : </b> <b>
<input type="text" readonly="readonly" class="required input_field" onkeypress="return validatenumerics(event);" style="font-weight:bold;text-align: right;  background-color: #dcf1f8" name="total" id="total" /></b>
								</td>
							</tr>
							<tr>
								<td colspan="1"><b>Tooling : </b></td>
								<td colspan="5"><b>Old : </b><input type="text" id="oldtool" onkeypress="return validatenumerics(event);" style="font-weight:bold; text-align: right; background-color: #dcf1f8" class="required input_field" name="oldtool" />&nbsp;&nbsp;
								<b>New : </b><input type="text" id="newtool" onkeypress="return validatenumerics(event);" style="font-weight:bold; text-align: right; background-color: #dcf1f8" class="required input_field" name="newtool" />&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<td colspan="1"><b>Fixture : </b></td>
								<td colspan="5"><b>Old Fixture : </b><input type="text" id="old_fixture" onkeypress="return validatenumerics(event);" style="font-weight:bold; text-align: right; background-color: #dcf1f8" class="required input_field" name="old_fixture" />&nbsp;&nbsp;
								<b>New Fixture : </b><input type="text" id="new_fixture" onkeypress="return validatenumerics(event);" style="font-weight:bold; text-align: right; background-color: #dcf1f8" class="required input_field" name="new_fixture" />&nbsp;&nbsp; </td>
							</tr>
 
							<tr>
								<td colspan="1"><b>Gauges : </b></td>
								<td colspan="5"><b>Old Gauges : </b><input type="text" id="old_gauges" onkeypress="return validatenumerics(event);" style="font-weight:bold; text-align: right; background-color: #dcf1f8" class="required input_field" name="old_gauges" />&nbsp;&nbsp;
								<b>New Gauges : </b><input type="text" id="new_gauges" onkeypress="return validatenumerics(event);" style="font-weight:bold; text-align: right; background-color: #dcf1f8" class="required input_field" name="new_gauges" />&nbsp;&nbsp;</td>
							</tr>

							<tr>
								<td colspan="1"><b>Re PPAP : </b></td>
								<td colspan="5"><b><input type="radio" name="ppap" value="Required" id="ppapr" style="width: 40px;font-weight:bold;  background-color: #dcf1f8"> Required &nbsp;
									<input id="ppapnr" type="radio" name="ppap" value="Not Required" style="width: 40px;font-weight:bold;  background-color: #dcf1f8"> Not Required &nbsp;</b></td>
							</tr>
							<tr>
								<td colspan="1"><b>Actual date of implementation (Optional) : </b></td>
								<td colspan="5">
								<input type="text" name="Actualimpldate" id="Actualimpldate" readonly="readonly" style="height: 22px; width: 150px; font-weight:bold;  background-color: #dcf1f8"/>
								<!-- <input id="demo5" name="Actualimpldate" type="text" size="25" readonly="readonly" title="Click on DatePicker"> 
									   <a href="javascript:NewCal('demo5','ddmmyyyy',true,24)"> <img src="cal.gif" width="16" height="16" border="0" alt="Pick a date"></a> --> 
								</td>
							</tr>
 
							<tr>
								<td colspan="2" align="left"><b>Concern Department</b></td>
								<td colspan="1" align="left"><b><= Select =></b></td>
								<td colspan="3"><b>Selected Department</b></td>
							</tr>
							<tr>
								<td colspan="2" align="left"><select id="department"
									name="department" multiple="multiple" size="5"
									style="width: 310px;font-weight:bold;  background-color: #dcf1f8" title="Concern Department">

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
								<td colspan="1">
								<input value="&gt;&gt;" onclick="movedata('right', 'rep')" style="font-weight:bold;" type="button"><br> 
								<input value="&lt;&lt;" onclick="movedata('left', 'rep')" type="button" style="font-weight:bold;"></td>
								<td colspan="3" align="left">
								<select id="department_selected" name="department_selected" multiple="multiple" size="5" style="width: 310px;font-weight:bold;  background-color: #dcf1f8" title="Selected Concern Department"></select>
								</td>
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
								<td colspan="1"><b>Attachments (If Any) :</b></td> 
								<td colspan="5">
							<table id="tblSample"> 
								<tr>
									&nbsp;&nbsp;&nbsp; 
									<input type="button" style="font-weight:bold;" value="  ADD More Files  " name="button" onclick="addRowToTable();" /></strong> &nbsp;&nbsp;
									<input type="button" value=" Delete [Selected] " onclick="deleteChecked();" style="font-weight:bold;"/>&nbsp;&nbsp;
									<input type="hidden" id="srno" name="srno" value="">
								</tr>
								<tbody></tbody>
							</table>
							</td>
						</tr> 
							<tr>
								<td colspan="6" align="left">
									<input type="submit" value="Suggestion / Send Request" name="NewRequest" id="NewRequest" style="cursor:pointer; height: 35px; width: 250px; background-color: #C4C4C4; border-radius: 20px/20px;font-weight: bold;" onclick="SendRequest();" title="Send for approval direcltly.."> 
									&nbsp;&nbsp;&nbsp; 
									<input type="submit" value="Send Request & Add Action" name="NewAction" id="NewAction" style="cursor:pointer; height: 35px; width: 250px; background-color: #C4C4C4; border-radius: 20px/20px;font-weight: bold;" onclick="Action();" title="If Actions known at the time of request click here...."> 
									<input type="hidden" name="valReq" id="valReq">
								</td>
							</tr>
							<%
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
						</table>

					</form> 
						 </div>
</body> 
</html>