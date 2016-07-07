<%@page import="com.muthagroup.bo.Get_UName_bo"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Add Fixture</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}

	$(function() {
		$("#accordion").accordion();
	});
</script>
<script>
$(function() {
$( "#menu" ).menu();
});
</script>
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

function validateForm() {
	var fixt=document.getElementById("fixture");
	var fixtNew=document.getElementById("fixtureNew"); 
	var fixt_no=document.getElementById("fixture_no");
	var fixtNo_New=document.getElementById("fixtureNoNew"); 
	var fqty=document.getElementById("fixtqty");
	var quotDate=document.getElementById("quotdate");
	var fixPoNo=document.getElementById("fixtpono");
	var poDate=document.getElementById("podate");
	var targetDate=document.getElementById("targetrecdate");
//	var fxavail=document.getElementById("fx_avail");

	
	
	if(fixt.disabled ==false){
		 if(fixt.value==null || fixt.value==""){
			alert("Fixture ???");
			return false;
		 }
		} 
	 if(fixt.disabled==true){
		 if(fixtNew.value==null || fixtNew.value==""){
			alert("Fixture ???");
			return false;
		 }
		}
	 
	 if(fixt_no.disabled ==false){
		 if(fixt_no.value==null || fixt_no.value=="" || fixt_no.value=="null"){
			alert("Fixture No ???");
			return false;
		 }
		} 
	 if(fixt_no.disabled==true){
		 if(fixtNo_New.value==null || fixtNo_New.value==""){
			alert("Fixture No ???");
			return false;
		 }
		}
	 //-----------
	 if(fqty.value=="" || fqty.value==null){
		 alert("Fixture Qty ???");
			return false;
	 }
	 if(quotDate.value=="" || quotDate.value==null){
		 alert("Quotation Date ???");
			return false;
	 }
	 if(fixPoNo.value=="" || fixPoNo.value==null){
		 alert("Fixture PO No ???");
			return false;
	 }
	 if(poDate.value=="" || poDate.value==null){
		 alert("PO Date ???");
			return false;
	 }
	 if(targetDate.value=="" || targetDate.value==null){
		 alert("Tgt Recpt Date ???");
			return false;
	 }
	 /* if(actRecDate.value=="" || actRecDate.value==null){
		 alert("Act Recpt Date ???");
			return false;
	 }  */
	 
	return true;
}


</script>

<script type="text/javascript">
function  editvalidateForm() {
	fixName=document.getElementById("fixture");
	fixBtn=document.getElementById("fxbtn1");
	fixeditname=document.getElementById("fixtureName");
	fixNameNew=document.getElementById("newFXName");
	fixBtnNew=document.getElementById("fixBTN");
	
	fixNo=document.getElementById("fixture_no");
	fixNoEdit=document.getElementById("editFixNoId");
	
	fixNobtn=document.getElementById("fxNoBTN");
	fixNoNew=document.getElementById("newFixNo");
	
	fixQty=document.getElementById("fixQty");
	fixQuotData=document.getElementById("quotdate");
	fixPoNo=document.getElementById("fixPoNo");
	fixPoDate=document.getElementById("podate");
	fixTarRecDate=document.getElementById("targetrecdate");
//	fixavail=document.getElementById("fixt_availqty");
	

	
	
	if(fixNobtn.disabled ==true){
		 if(fixNoNew.value=="null" || fixNoNew.value==null || fixNoNew.value==""){
			alert("Fixture No ???");
			return false;
		 }
		}
	
	
	if(fixName.disabled ==false){
		 if(fixName.value=="null" || fixName.value==null || fixName.value==""){
			alert("Fixture ???");
			return false;
		 }
		}
	if(fixName.disabled ==true){
		 if(fixeditname.value=="null" || fixeditname.value==null || fixeditname.value==""){
			alert("Edit Fixture ???");
			return false;
		 }
		}
	
	if(fixName.disabled ==true){
		 if(fixeditname.value=="null" || fixeditname.value==null || fixeditname.value==""){
			alert("Edit Fixture ???");
			return false;
		 }
		}
	if(fixBtnNew.disabled ==true){
		 if(fixNameNew.value=="null" || fixNameNew.value==null || fixNameNew.value==""){
			alert("New Fixture ???");
			return false;
		 }
		}
	if(fixNo.disabled ==false){
		 if(fixNo.value=="null" || fixNo.value==null || fixNo.value==""){
			alert("Fixture No ???");
			return false;
		 }
		}
	if(fixNo.disabled ==true){
		 if(fixNoEdit.value=="null" || fixNoEdit.value==null || fixNoEdit.value==""){
			alert("Edit Fixture ???");
			return false;
		 }
		}
	

	if(fixQty.value=="null" || fixQty.value==null || fixQty.value==""){
		alert("Fixture Qty ???");
		return false;
	 }	
	
	if(fixQuotData.value=="null" || fixQuotData.value==null || fixQuotData.value==""){
		alert("Quotation Date ???");
		return false;
	 }
	if(fixPoNo.value=="null" || fixPoNo.value==null || fixPoNo.value==""){
		alert("Fixture PO No. ???");
		return false;
	 }
	if(fixPoDate.value=="null" || fixPoDate.value==null || fixPoDate.value==""){
		alert("PO Date ???");
		return false;
	 }
	if(fixTarRecDate.value=="null" || fixTarRecDate.value==null || fixTarRecDate.value==""){
		alert("Target Recpt Date ???");
		return false;
	 }
	/* if(fixActRecDate.value=="null" || fixActRecDate.value==null || fixActRecDate.value==""){
		alert("Act Recpt Date ???");
		return false;
	 } */
	return true;
}
</script>

<script type="text/javascript">
function addNewfixtureno(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newFixNo");
	var here = document.getElementById("newFXNo");
	here.appendChild(element);
	
	
	var e1 = document.getElementById("editFixNoId");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("fxnobtn1");
	e.setAttribute('disabled', 'disabled');

	var e1 = document.getElementById("fixture_no");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("fxNoBTN");
	e.setAttribute('disabled', 'disabled');


	
}


function addNewfixture(type) {
	var element = document.createElement("input");
element.setAttribute("type", "text");
element.setAttribute("name", type);
element.setAttribute("id", "newFXName");
var here = document.getElementById("newFX");
here.appendChild(element);

var e1 = document.getElementById("fixBTN");
e1.setAttribute('disabled', 'disabled');

var e = document.getElementById("fixtureName");
e.setAttribute('disabled', 'disabled');

var e1 = document.getElementById("fxbtn1");
e1.setAttribute('disabled', 'disabled');

var e = document.getElementById("fixture");
e.setAttribute('disabled', 'disabled');




}

function addfixture(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "fixtureNew");
	var here = document.getElementById("fix");
	here.appendChild(element);

	var e1 = document.getElementById("fixture");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("fxbtn");
	e.setAttribute('disabled', 'disabled');
}
function addfixture_no(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "fixtureNoNew");
	var here = document.getElementById("fixno");
	here.appendChild(element);

	var e1 = document.getElementById("fixture_no");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("fxnobtn");
	e.setAttribute('disabled', 'disabled');
}

function editfixture(type) 
{
	document.getElementById("fixtureName").disabled=false;

	var e1 = document.getElementById("fixture");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("fxbtn1");
	e.setAttribute('disabled', 'disabled');
}

function editfixture_no(type) 
{
	document.getElementById("editFixNoId").disabled=false;

	var e1 = document.getElementById("fixture_no");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("fxnobtn1");
	e.setAttribute('disabled', 'disabled');
}

</script>
<!-- CSS goes in the document HEAD or added to your external stylesheet -->
<style type="text/css">
table.gridtable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}

table.gridtable tr {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
}

table.gridtable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
</style>

<script>
 
	$(function() {
		//	$("#datepicker").datepicker();
		$("#quotdate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#targetrecdate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#podate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#actrecdate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
 </script>
<script type="text/javascript">
function getFixture_No(str) {
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
			document.getElementById("fixt_no").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "getFixture_No.jsp?fixture_no=" + str, true);
	xmlhttp.send();
};
</script>

</head>
<%
	try {
		int u_id = 0;
		int mcdata_id = 0;
		int basic_id = 0;
		int rel_id = 0;
		String action = null;
		if (request.getParameter("action") != null) {

			action = request.getParameter("action");
		}

		u_id = Integer.parseInt(session.getAttribute("uid").toString());

		if (request.getParameter("hid") != null) {
			basic_id = Integer.parseInt(request.getParameter("hid"));
		}

		if (request.getParameter("mcdata_id") != null) {
			mcdata_id = Integer.parseInt(request
					.getParameter("mcdata_id"));

			System.out.println("mc data id.. " + mcdata_id);
		}
		if (request.getParameter("relId") != null) {
			rel_id = Integer.parseInt(request.getParameter("relId"));
		}
		Connection con = Connection_Utility.getConnection();
%>


<body>
	<div id="templatemo_header_wrapper">
		<!--  Free Web Templates by TemplateMo.com  -->
		<div id="templatemo_header">

			<!-- 	<div id="site_logo"></div> -->

			<div id="templatemo_menu">
				<div id="templatemo_menu_left"></div>
				<ul>
				<%

				String User_Name = null;
				int uid = Integer.parseInt(session.getAttribute("uid").toString());
				Get_UName_bo bo = new Get_UName_bo();
				User_Name = bo.get_UName(uid);
				%>
					<li><a href="Home.jsp" class="current">Home</a>h</li>
					<li><a href="All_DVPSheets.jsp">All DVP Sheets</a></li>
				<li><a href="EditSheet.jsp">Edit DVP Sheets</a></li>
					<li><a href="Approval_Requests.jsp">Approvals Requests</a></li>
					<li><a href="#">Reports</a></li>
					<li><a href="Search.jsp">Search</a></li>
					
			<li><a href="Logout.jsp" class="last"><strong> Log Out (<%=User_Name %>)</strong></a></li>
			<li><img alt="Mutha Group" src="images/logo.jpg" align="middle"/></li>
				</ul>
			</div>
			<!-- end of menu -->

		</div>
		<!-- end of header -->
	</div>
	<!-- end of header wrapper -->
	<!-- ----------------------------------------------------------------------------------------------- -->
	<!-- ----------------------------Master here----------------------------------
	<ul id="globalnav">

		<li><a href="New_CostSheet.jsp" class="here">Basic</a></li>
		<li><a href="New_CostSheet_Charge.jsp">Charge</a></li>

	</ul>
	<br>
- -->



	<div class="templatemo_section_1">
		<%
			if (action.equalsIgnoreCase("new")) {
		%>
		<form action="Add_Fixture_Controller" class="register" method="post"
			id="myForm" name="myForm" onSubmit="return(validateForm());">

			<input type="hidden" name="mcDataId" value="<%=mcdata_id%>">
			<input type="hidden" name="rel_id" value="<%=rel_id%>"> <input
				type="hidden" name="basic_id" value="<%=basic_id%>">

			<table width="66%" border="1" class="gridtable">
				<tr style="background-color: #B0C9D6">
					<th height="33" colspan="7" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Fixtures</span></th>
				</tr>
				<tr>
					<th width="6%" scope="col">Sr. No</th>
					<th width="26%" scope="col">Fixture list</th>
					<th width="10%" scope="col">Fixture No</th>
					<th width="14%" scope="col">Quotation Date</th>
					<th width="14%" scope="col">PO Date</th>
					<th width="15%" scope="col">Target Receipt Date</th>
					<th width="15%" scope="col">Actual Receipt Date</th>
				</tr>
				<%
					int sr_no = 0;
							PreparedStatement ps_getFD = con
									.prepareStatement("select * from dev_fixturedata_tbl where mcdata_id="
											+ mcdata_id
											+ " and opnno_opn_rel_id="
											+ rel_id);
							ResultSet rs_getFD = ps_getFD.executeQuery();

							while (rs_getFD.next()) {
								sr_no = sr_no + 1;
				%>

				<tr>
					<td><%=sr_no%></td>
					<%
						PreparedStatement ps_getRelDetails = con
											.prepareStatement("select Fixture_id,FixtureNo_Id from dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="
													+ rs_getFD.getInt("fixt_fixtNo_rel_Id"));

									ResultSet rs_getRelDetails = ps_getRelDetails
											.executeQuery();

									while (rs_getRelDetails.next()) {

										PreparedStatement ps_getFixture = con
												.prepareStatement("select Fixture_Name from dev_fixture_mst_tbl where Fixture_Id="
														+ rs_getRelDetails
																.getInt("fixture_id"));
										ResultSet rs_getFixture = ps_getFixture
												.executeQuery();

										while (rs_getFixture.next()) {
					%>
					<td><%=rs_getFixture
										.getString("Fixture_Name")%></td>
					<%
						}
										rs_getFixture.close();
										ps_getFixture.close();

										PreparedStatement ps_getFixtureNo = con
												.prepareStatement("select Fixture_No from dev_fixture_no_mst_tbl where FixtureNo_Id="
														+ rs_getRelDetails
																.getInt("fixtureNo_id"));
										ResultSet rs_getFixtureNo = ps_getFixtureNo
												.executeQuery();

										while (rs_getFixtureNo.next()) {
					%>
					<td><%=rs_getFixtureNo
										.getString("Fixture_No")%></td>
					<%
						}
										rs_getFixtureNo.close();
										ps_getFixtureNo.close();
									}
									rs_getRelDetails.close();
									ps_getRelDetails.close();
					%>
					<td><%=rs_getFD.getDate("quotation_date")%></td>
					<td><%=rs_getFD.getDate("fixture_po_date")%></td>
					<td><%=rs_getFD.getDate("target_receipt_date")%></td>
					<td><%=rs_getFD.getDate("actual_receipt_date")%></td>
				</tr>
				<%
					}
				%>
			</table>
			<br />
			<table width="82%">
				<tr>
					<th colspan="7" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8;">Add Fixtures</span></th>
				</tr>
				<tr>
					<td width="16%" height="32">Fixture Name</td>
					<td width="1%">:</td>
					<td width="21%"><select name="fixture" id="fixture"
						onchange="getFixture_No(this.value)"
						style="cursor: pointer; max-width: 11em;">

							<option value="">----- Select -----</option>
							<%
								PreparedStatement ps_getAllFixture = con
												.prepareStatement("select Fixture_Name from dev_fixture_mst_tbl");
										ResultSet rs_getAllFixture = ps_getAllFixture
												.executeQuery();

										while (rs_getAllFixture.next()) {
							%>
							<option value="<%=rs_getAllFixture.getString("Fixture_Name")%>"><%=rs_getAllFixture.getString("Fixture_Name")%></option>
							<%
								}
										rs_getAllFixture.close();
										ps_getAllFixture.close();
							%>

					</select></td>
					<td width="12%"><input type="button"
						onclick="addfixture('fixture')" id="fxbtn" value="If other"
						style="cursor: pointer" /></td>
					<td width="17%"><span id="fix"></span></td>
					<td width="1%">&nbsp;</td>
					<td width="32%">&nbsp;</td>
				</tr>

				<tr>
					<td height="30">Fixture No.</td>
					<td>:</td>
					<td>
						<div id="fixt_no">
							<select name="fixture_no" id="fixture_no">
								<option value="">----Select----</option>
							</select>
						</div>
					</td>
					<td><input name="button" type="button" id="fxnobtn"
						style="cursor: pointer" onClick="addfixture_no('fixture_no')"
						value="If other" /></td>
					<td><span id="fixno"></span></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td height="28">Fixture Reqd Qty</td>
					<td>:</td>
					<td colspan="2"><input type="text" name="fixtqty" id="fixtqty" onkeypress="return validatenumerics(event);"></td> 
					<td>Fixture Avail Qty</td>
					<td>:</td>
					<td><input type="text" name="fx_avail" id="fx_avail" onkeypress="return validatenumerics(event);"/></td>
				</tr>

				<tr>
					<td height="30">Quotation Date</td>
					<td>:</td>
					<td colspan="2"><input type="text" name="quotdate"
						id="quotdate" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td height="30">Fixture PO No.</td>
					<td>:</td>
					<td><input type="text" name="fixtpono" id="fixtpono"></td>
					<td>&nbsp;</td>
					<td>PO Date</td>
					<td>:</td>
					<td><input type="text" name="podate" id="podate" /></td>
				</tr>
				<tr>
					<td height="27">Tgt Recpt Date</td>
					<td>:</td>
					<td colspan="2"><input type="text" name="targetrecdate"
						id="targetrecdate" /></td>
					<td>Act Recpt Date</td>
					<td>:</td>
					<td><input type="text" name="actrecdate" id="actrecdate" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr align="center">
					<td colspan="4"><input type="submit" name="Submit" value="Add" />
						&nbsp;&nbsp; &nbsp;&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>

		</form>

		<%
			} else {
		%>

		<form action="Edit_Fixture_Controller" class="register" method="post"
			id="myForm" name="myForm" onSubmit="return(editvalidateForm());">


			<input type="hidden" name="mcDataId" value="<%=mcdata_id%>">
			<input type="hidden" name="rel_id" value="<%=rel_id%>"> <input
				type="hidden" name="basic_id" value="<%=basic_id%>">

			<table width="91%">
				<tr>
					<th colspan="10" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Edit Fixtures</span></th>
				</tr>
				<tr>
					<td width="1%"></td>
					<td width="19%" height="32"><strong>Change Fixture
							Name</strong></td>
					<td width="1%"><strong>:</strong></td>
					<td width="19%"><select name="fixture" id="fixture"
						onchange="getFixture_No(this.value)"
						style="cursor: pointer; max-width: 11em;">
							<%
								PreparedStatement ps_getFD_Details = con
												.prepareStatement("select * from dev_fixturedata_tbl where mcdata_id="
														+ mcdata_id
														+ " and opnno_opn_rel_id="
														+ rel_id);
										ResultSet rs_getFD_Details = ps_getFD_Details
												.executeQuery();

										int fRel_Id = 0;
										int selFId = 0;

										int selFNoId = 0;

										String fixture_no = null;
										String fixture_name = null;

										while (rs_getFD_Details.next()) {
											fRel_Id = rs_getFD_Details.getInt("fixt_fixtNo_rel_Id");

											PreparedStatement ps_getFNameId = con
													.prepareStatement("select fixture_id from dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="
															+ fRel_Id);
											ResultSet rs_getFNameId = ps_getFNameId.executeQuery();
											while (rs_getFNameId.next()) {
												selFId = rs_getFNameId.getInt("fixture_id");
											}
											rs_getFNameId.close();
											ps_getFNameId.close();

											PreparedStatement ps_getSelFName = con
													.prepareStatement("select Fixture_Name from dev_fixture_mst_tbl where Fixture_Id="
															+ selFId);
											ResultSet rs_getSelFName = ps_getSelFName
													.executeQuery();
											while (rs_getSelFName.next()) {
												fixture_name = rs_getSelFName
														.getString("Fixture_Name");
							%>
							<option value="<%=fixture_name%>"><%=fixture_name%></option>
							<%
								}
											rs_getSelFName.close();
											ps_getSelFName.close();

											PreparedStatement ps_getAllFixture = con
													.prepareStatement("select Fixture_Name from dev_fixture_mst_tbl where Fixture_Id!="
															+ selFId);
											ResultSet rs_getAllFixture = ps_getAllFixture
													.executeQuery();

											while (rs_getAllFixture.next()) {
							%>
							<option
								value="<%=rs_getAllFixture
									.getString("Fixture_Name")%>"><%=rs_getAllFixture
									.getString("Fixture_Name")%></option>
							<%
								}
											rs_getAllFixture.close();
											ps_getAllFixture.close();
							%>
					</select></td>
					<td width="14%"><input type="button"
						onclick="editfixture('fixture')" id="fxbtn1" value="to Edit"
						style="cursor: pointer" /></td>
					<td width="20%"><strong>Edit Fixture Name</strong></td>
					<td width="1%"><strong>:</strong></td>
					<td width="25%"><input type="text" value="<%=fixture_name%>"
						name="fixture" id="fixtureName" disabled="disabled" /></td>
				</tr>

				<tr>
					<td></td>
					<td height="30">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input name="button2" type="button" id="fixBTN"
						style="cursor: pointer" onClick="addNewfixture('new_fixture')"
						value="If other" /></td>
					<td><strong>Add New Fixture </strong></td>
					<td><strong>:</strong></td>
					<td><span id="newFX"></span></td>
				</tr>
				<tr>
					<td></td>
					<td height="30"><strong>Change Fixture No.</strong></td>
					<td><strong>:</strong></td>
					<td>
						<div id="fixt_no">
							<select name="fixture_no" id="fixture_no">
								<%
									PreparedStatement ps_getFNoId = con
														.prepareStatement("select FixtureNo_Id from dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="
																+ fRel_Id);
												ResultSet rs_getFNoId = ps_getFNoId.executeQuery();
												while (rs_getFNoId.next()) {
													selFNoId = rs_getFNoId.getInt("FixtureNo_Id");
												}
												rs_getFNoId.close();
												ps_getFNoId.close();

												PreparedStatement ps_getSelFNo = con
														.prepareStatement("select Fixture_No from dev_fixture_no_mst_tbl where FixtureNo_Id="
																+ selFNoId);
												ResultSet rs_getSelFNo = ps_getSelFNo.executeQuery();
												while (rs_getSelFNo.next()) {
													fixture_no = rs_getSelFNo.getString("Fixture_No");
								%>
								<option value="<%=fixture_no%>"><%=fixture_no%></option>
								<%
									}
												rs_getSelFName.close();
												ps_getSelFName.close();
								%>
							</select>
						</div>
					</td>
					<td><input name="button" type="button" id="fxnobtn1"
						style="cursor: pointer" onClick="editfixture_no('fixture_no')"
						value="to Edit" /></td>
					<td><strong>Edit Fixture No</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" value="<%=fixture_no%>"
						name="fixture_no" id="editFixNoId" disabled="disabled" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="30">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input name="button22" type="button" id="fxNoBTN"
						style="cursor: pointer" onClick="addNewfixtureno('new_fixture_no')"
						value="If other" /></td>
					<td><strong>Add New Fixture No </strong></td>
					<td><strong>:</strong></td>
					<td><span id="newFXNo"></span></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="30"><strong>Fixture Reqd Qty</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text"
						value="<%=rs_getFD_Details.getInt("fixture_qty")%>" name="fixtqty" id="fixQty" onkeypress="return validatenumerics(event);"></td>
					<td>&nbsp;</td>
					<td height="30"><strong>Fixture Available Qty</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text"
						value="<%=rs_getFD_Details.getInt("avail_qty")%>" name="fixt_availqty" id="fixt_availqty" onkeypress="return validatenumerics(event);"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="28"><strong>Quotation Date</strong></td>
					<td><strong>:</strong></td>
					<td colspan="2"><input type="text"
						value="<%=rs_getFD_Details.getDate("quotation_date")%>"
						name="quotdate" id="quotdate" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="28"><strong>Fixture PO No.</strong></td>
					<td><strong>:</strong></td>
					<td colspan="2"><input type="text"
						value="<%=rs_getFD_Details.getString("fixture_po_no")%>" id="fixPoNo"
						name="fixtpono"></td>
					<td><strong>PO Date</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text"
						value="<%=rs_getFD_Details.getString("fixture_po_date")%>"
						name="podate" id="podate" /></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td height="27"><strong>Tgt Recpt Date</strong></td>
					<td><strong>:</strong></td>
					<td colspan="2"><input type="text"
						value="<%=rs_getFD_Details.getString("target_receipt_date")%>"
						name="targetrecdate" id="targetrecdate" /></td>
					<td><strong>Act Recpt Date</strong></td>
					<td><strong>:</strong></td>
					<td>
					<%
					if(rs_getFD_Details.getString("actual_receipt_date")!=null){
					%>
					<input type="text" value="<%=rs_getFD_Details.getString("actual_receipt_date") %>" name="actrecdate" id="actrecdate" />
					<%
					}else{
					%>
					<input type="text" name="actrecdate" id="actrecdate" />
					<%
					}
					%>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr align="center">
					<td colspan="5"><input type="submit" name="Submit"
						value="Update" /> &nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>

		</form>

		<%
			}
					rs_getFD_Details.close();
					ps_getFD_Details.close();
				}
		%>
	</div>


	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong>
				DVP BOSS</strong></li>


		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New DVP
				Sheet</a></li>


		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a></li>
				
					<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a></li>


	</ul>
	<!-- ----------------------------------------------------------------------------------------------- -->


	<div id="templatemo_content_wrapper">
		<div id="templatemo_content">

			<div id="column_w530">



				<div class="cleaner"></div>
			</div>


			<div class="cleaner"></div>
		</div>
		<!-- end of content wrapper -->
	</div>
	<!-- end of content wrapper -->

	<div id="templatemo_footer_wrapper">

		<div id="templatemo_footer"></div>
		<!-- end of footer -->


	</div>
</body>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
</html>