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
	function SendRequest() {
//		alert("loop 1");
		var current = document.getElementById("valReq");
		current.value = 1; 
	}
	function Action() {
	//	alert("loop 2");
		var current = document.getElementById("valReq");
		current.value = 2;
	}
	function validateForm() {
//		var rel_to = document.getElementById("rel_to");
		var supplier  = document.getElementById("supplier");
		var item_name  = document.getElementById("item_name"); 
		var quality   = document.getElementById("quality");
		var cost   = document.getElementById("cost");
		var Dimensional   = document.getElementById("Dimensional");
		var delivery    = document.getElementById("delivery");
		var material    = document.getElementById("material");
		var safety    = document.getElementById("safety"); 
		var change_selected     = document.getElementById("change_selected"); 
		var Present    = document.getElementById("Present");
		var Proposed   = document.getElementById("Proposed");
		var Objective    = document.getElementById("Objective");
		var tracking_selected   = document.getElementById("tracking_selected"); 
		
			if (supplier.value=="0" || supplier.value==null || supplier.value=="" || supplier.value=="null") {
				alert("Company Name ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (item_name.value=="0" || item_name.value==null || item_name.value=="" || item_name.value=="null") {
				alert("Part Name ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (quality.checked == false && cost.checked == false &&  Dimensional.checked ==false &&  delivery.checked == false && material.checked == false && safety.checked == false) {
				alert("Category Of Change ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (change_selected.value=="0" || change_selected.value==null || change_selected.value=="" || change_selected.value=="null") {
				alert("Selected Change Type ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (Present.value=="0" || Present.value==null || Present.value=="" || Present.value=="null") {
				alert("Present System ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (Proposed.value=="0" || Proposed.value==null || Proposed.value=="" || Proposed.value=="null") {
				alert("Proposed System ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (Objective.value=="0" || Objective.value==null || Objective.value=="" || Objective.value=="null") {
				alert("Objective ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			} 
			if (tracking_selected.value=="0" || tracking_selected.value==null || tracking_selected.value=="" || tracking_selected.value=="null") {
				alert("Selected Tracking Change ?"); 
				document.getElementById("NewRequest").disabled = false;
				document.getElementById("NewAction").disabled = false;
				return false;
			}  
			
			
			document.getElementById("NewRequest").disabled = true;
			document.getElementById("NewAction").disabled = true;
			return true;
		} 
	
</script>
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
<!-- <script type="text/javascript" src="tabledeleterow.js"></script> -->
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

<script type="text/javascript" src="js/ddsmoothmenu.js"> </script>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(
		  function () {
		    $( "#proposeddate" ).datepicker({
		      changeMonth: true,
		      changeYear: true 
		    });
		    $( "#actualimpldate" ).datepicker({
			      changeMonth: true,
			      changeYear: true 
			    });   
		  } 
		); 

</script>
<style type="text/css">
.tftable {
	background-color: white;
	font-size: 12px;
	color: #333333;
	width: 80%;   
}

.tftable th {
	font-size: 12px;
	background-color: #388EAB; 
	padding: 4px; 
	color: white;
	text-align: center;
}

.tftable tr {
	background-color: white;
	font-size: 12px;
}
.tftable td {
	font-size: 12px; 
	padding: 6px; 
}
</style>
<script type="text/javascript">
	ddsmoothmenu.init({
		mainmenuid : "templatemo_menu", //menu DIV id
		orientation : 'h', //Horizontal or vertical menu: Set to "h" or "v"
		classname : 'ddsmoothmenu', //class added to menu's outer DIV 
		contentsource : "markup" //"markup" or ["container_id", "path_to_menu_file"]
	});
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
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/jquery-ui-1.8.18.custom.min.js"></script>
</head>
<body id="sub_page" style="background-color: white;">
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
 					<div id="templatemo_header" class="ddsmoothmenu" style="width: 100%">
 						<ul>
 							<li style="background-color: #1c6f8a;color: white;"><a href="New_Request.jsp"><b>Change Request Internal</b></a></li>
							<li style="background-color: #B3A6AA;"><a href="NewRequestCustomer.jsp">Change Request Customer</a></li>
						</ul>
					</div>
				<div style="height: 550px;width: 100%;">				
					<form name="myForm" method="post" action="Change_Request_Controller" enctype="multipart/form-data" onSubmit="return validateForm();">
						<table style="width: 100%;" class="tftable">
							<tr>
								<%
									
										Calendar first_Datecal = Calendar.getInstance();   
										first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
										Date dddd = first_Datecal.getTime();  
										SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd"); 
										PreparedStatement ps_crno = con.prepareStatement("select Max(CR_No) from cr_tbl");
										ResultSet rs_crno = ps_crno.executeQuery();
										int cr_No = 0;
										while (rs_crno.next()) {
											cr_No = rs_crno.getInt("Max(CR_No)") + 1;
										}
								%>
								<td colspan="1"><b>Request Number :</b></td>
								<td colspan="5"> 
								<input type="text" id="author" name="author" value="<%=cr_No%>" disabled="disabled" class="required input_field" style="background-color: #dcf1f8;font-weight: bold;"/> 
								<input type="hidden" name="crno" value="<%=cr_No%>" /> 
								</td>
							</tr>
							 <tr> 
							 <td colspan="1"><b>Company Name :</b></td>
								<td colspan="5"> 
								<Select id="supplier" style="height: 27px; width: 300px;  text-align: center;background-color: #dcf1f8"
									name="supplier" class="required input_field"
									title="Supplier Name" 
									onchange="showState(this.value)">
										<option value="0">----Select----</option>
										<%
											PreparedStatement ps = con.prepareStatement("select * from user_tbl_company where Company_Id!=6 order by company_name");
												ResultSet rs = ps.executeQuery();
												while (rs.next()) {
										%>
										<option value="<%=rs.getInt("Company_Id")%>"><%=rs.getString("Company_Name")%></option>
										<%
											}
										%>
								</Select>
								</td>
								</tr>
								<tr>
								<td colspan="1"><b>Part Name : </b></td>
								<td colspan="5"> 								
								<div id="item">
										<Select id="item_name" name="item_name" class="required input_field" style="background-color: #dcf1f8;height: 27px;width: 300px;" title="Part Name">
											<option value="0">----Select----</option>
										</select>
								</div>
								</td>
							</tr>
							
							
							<tr>
								<td colspan="6"><b>Category Of Change :</b></td>
							</tr>
							<tr>
								<td colspan="6"><input type="checkbox" value="2" name="quality" id="quality" style="background-color: #dcf1f8">Quality &nbsp;&nbsp;
								<input type="checkbox" value="1" name="cost" id="cost" style="background-color: #dcf1f8">Cost &nbsp;&nbsp;
								<input type="checkbox" value="6" name="Dimensional" id="Dimensional" style="background-color: #dcf1f8">Dimensional &nbsp;&nbsp; 
								<input type="checkbox" value="3" name="delivery" id="delivery" style="background-color: #dcf1f8">Delivery &nbsp;&nbsp;
								<input type="checkbox" value="4" name="material" id="material" style="background-color: #dcf1f8">Material &nbsp;&nbsp;
								<input type="checkbox" value="5" name="safety" id="safety" style="background-color: #dcf1f8">Safety</td>
							</tr>
							
							
							
							<tr>
								<td colspan="2"><b>Change Type</b></td>
								<td colspan="2" align="center"><b><= Select =></b></td>
								<td colspan="2"><b>Selected Change Type</b></td>
							</tr>
							<tr>
								<td colspan="2" align="left"><select id="change_name"
									name="change_name" multiple="multiple" size="6"
									style="width: 330px;background-color: #dcf1f8" title="Change Type;"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"> 
										<%
											PreparedStatement ps_ct = con.prepareStatement("select * from cr_tbl_type order by cr_type");
												ResultSet rs_ct = ps_ct.executeQuery();
												while (rs_ct.next()) {
										%> 
										<option value="<%=rs_ct.getString("CR_Type")%>"><%=rs_ct.getString("CR_Type")%></option>
										<%
											}
										%> 
								</select></td>
								<td  colspan="2" style="width: 50px;" align="center"><input value="&gt;&gt;" onclick="move('right', 'rep')" type="button"><br>
									<input value="&lt;&lt;" onclick="move('left', 'rep')"
									type="button"></td>
								<td colspan="2" align="left"><select id="change_selected"
									name="change_selected" multiple="multiple" size="6"
									style="width: 330px;background-color: #dcf1f8" title="Selected Change Type"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></select></td>
							</tr>
							
							
							
							<tr>
								<td colspan="2"><b>Present System</b></td>
								<td colspan="2"><b>Proposed System</b></td>
								<td colspan="2"><b>Objective</b></td>
							</tr>




							<tr>
								<td colspan="2"><textarea class="validate-subject required input_field" 
										name="Present" id="Present" style="height: 75px;width: 330px;background-color: #dcf1f8"
										title="Present System"
										onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
										onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></textarea> </td>
								<td colspan="2"><textarea class="validate-subject required input_field"
										name="Proposed" id="Proposed" style="height: 75px;width: 330px;background-color: #dcf1f8"
										title="Proposed System"
										onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
										onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></textarea> </td>
								<td colspan="2"><textarea class="validate-subject required input_field"
										name="Objective" id="Objective" style="height: 75px;width: 330px;background-color: #dcf1f8"
										title="Objective"
										onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
										onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></textarea> </td>
							</tr>

						 <tr> 
								<td colspan="2"><b>Tracking Change</b></td>
								<td colspan="2" align="center"><b><= Select =></b></td>
								<td colspan="2"><b>Selected Tracking Change</b></td>
							</tr>
							<tr>
								<td colspan="2" align="left"><select id="tracking_change"
									name="tracking_change" multiple="multiple" size="5"
									style="width: 330px;background-color: #dcf1f8" title="Tracking Change"
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
								<td colspan="2" style="width: 50px;" align="center" align="center"><input
									value="&gt;&gt;" onclick="movedata('right', 'rep')"
									type="button"><br> <input value="&lt;&lt;"
									onclick="movedata('left', 'rep')" type="button"></td>
								<td colspan="2" align="left"><select
									id="tracking_selected" name="tracking_selected"
									multiple="multiple" size="5" style="width: 330px;background-color: #dcf1f8"
									title="Selected Tracking Change"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></select></td>
							</tr>
							<!-- ****************************************************************************************************************** -->

							<tr>
							<td colspan="1"><b>Proposed date :</b></td>
							<td colspan="5"><input type="text" name="proposeddate" id="proposeddate" readonly="readonly" value="<%=sdfFIrstDate.format(dddd) %>" style="height: 22px; width: 150px; font-weight:bold;  background-color: #dcf1f8"/></td>
							</tr>
							<tr>
							<td colspan="1"><b>Actual Implementation date :</b></td>
							<td colspan="5"><input type="text" name="actualimpldate" id="actualimpldate" readonly="readonly" style="height: 22px; width: 150px; font-weight:bold;  background-color: #dcf1f8"/></td>
							</tr>
 							<tr> 
								<td colspan="1"><b>ComplaintZilla Complaint No ( Optional ) :</b></td> 
								<td colspan="5">
								<Select id="complaintno" style="height: 27px; width: 150px;background-color: #dcf1f8;font-weight: bold;" 
									name="complaintno"
									title="ComplaintZilla Software Complaint No(Optional)" > 
								<option value="Related Complaint No(If any)">- - - - N.A. - - - - </option>
								<%
								PreparedStatement ps_cz = con.prepareStatement("select * from complaint_tbl");
								ResultSet rs_cz = ps_cz.executeQuery();
								while(rs_cz.next()){
								%>
								<option value="<%=rs_cz.getString("complaint_no")%>"><%=rs_cz.getString("complaint_no") %></option>
								<%
								}
								%>	
								</Select>
								<!-- <input name="complaintno" type="text"
									class="validate-email required input_field" size="16"
									onfocus="if(this.value==this.defaultValue)this.value='';"
									onblur="if(this.value=='')this.value=this.defaultValue;"
									value="Related Complaint No(If any)"
									title="ComplaintNo(Optional)"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}" /> -->
								</td>
							</tr>

						<%--
							<tr>
								<td colspan="2"><b>Approvers</b></td>
								<td colspan="2"></td>
								<td colspan="2"><b>Selected Approvers</b></td>
							</tr> 
						 <tr>
								<td colspan="2"><select id="approver_name"
									name="approver_name" multiple="multiple" size="5"
									style="width: 330px" title="Approvers"
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
								<td colspan="2" style="width: 50px;" align="center"><input
									value="&gt;&gt;" onclick="move1('right', 'rep')" type="button"><br>
									<input value="&lt;&lt;" onclick="move1('left', 'rep')"
									type="button"></td>
								<td colspan="2"><select id="approver_selected"
									name="approver_selected" multiple="multiple" size="5"
									style="width: 330px;background-color: #dcf1f8;" title="Selected Approvers"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
								</select></td>
							</tr> --%>


							<tr>
								<td colspan="6"><b>Attachments </b></td> 
							</tr>	
							<tr>	
							<td colspan="6">
							<table id="tblSample"> 
								<tr>
									&nbsp;&nbsp;&nbsp;
									<strong> <input type="button" value="  ADD More Files  " name="button" onclick="addRowToTable();" /></strong> &nbsp;&nbsp;
									<input type="button" value=" Delete [Selected] " onclick="deleteChecked();" />&nbsp;&nbsp;
									<input type="hidden" id="srno" name="srno" value="">
								</tr>
								<tbody></tbody>
							</table> 
							</td>
							</tr>
 							<tr>
								<td colspan="6" align="left">
<input type="submit" value="Suggestion / Send Request" name="NewRequest" id="NewRequest" style="height: 35px; width: 250px; background-color: #C4C4C4; border-radius: 20px/20px;font-weight: bold;cursor: pointer;"
onclick="SendRequest();" title="Send for approval direcltly.."> 
&nbsp;&nbsp;&nbsp;
<input type="submit" value="Send Request & Add Action" name="NewAction" id="NewAction"  style="height: 35px; width: 250px; background-color: #C4C4C4; border-radius: 20px/20px;font-weight: bold;cursor: pointer;"
onclick="Action();" title="If Actions known at the time of request click here...."> <input type="hidden" name="valReq" id="valReq"></td>
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