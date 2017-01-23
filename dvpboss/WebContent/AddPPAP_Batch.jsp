<%@page import="com.muthagroup.bo.Get_UName_bo"%>
<%@page import="java.util.ArrayList"%>
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
<title>DVP Boss Operations</title>

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

$(function() {
	//	$("#datepicker").datepicker();
	$("#ppap_date").datepicker({

	});
});
$(function() {
	//	$("#datepicker").datepicker();
	$("#handover_date").datepicker({

	});
});
$(function() {
	//	$("#datepicker").datepicker();
	$("#end_date").datepicker({

	});
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

<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 80%;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	padding: 8px;
	text-align: left;
}

.tftable td {
	font-size: 12px;
	padding: 8px;
}
</style>

<script type="text/javascript">

function addnewOper(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	var here = document.getElementById("addNewOpr");
	here.appendChild(element);
	
	
	var e1 = document.getElementById("addNewOpBtn");
	e1.setAttribute('disabled', 'disabled');

	var e2 = document.getElementById("editOpr");
	e2.setAttribute('disabled', 'disabled');
	
	var e1 = document.getElementById("opbtn1");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("operation");
	e.setAttribute('disabled', 'disabled');
	
}


function addnewOpNo(type) {

	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	var here = document.getElementById("newON");
	here.appendChild(element);
	
	var e1 = document.getElementById("opno1");
	e1.setAttribute('disabled', 'disabled');

	var e2 = document.getElementById("opnobtn1");
	e2.setAttribute('disabled', 'disabled');
	
	var e1 = document.getElementById("opno");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("newBtn");
	e.setAttribute('disabled', 'disabled');
}


function addopno(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	var here = document.getElementById("opr");
	here.appendChild(element);

	var e1 = document.getElementById("opno");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("opnobtn");
	e.setAttribute('disabled', 'disabled');
}
function addoperation(type) {
	
	
	
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	var here = document.getElementById("getop");
	here.appendChild(element);

	var e = document.getElementById("opbtn");
	e.setAttribute('disabled', 'disabled');
	
	var e = document.getElementById("operation");
	e.setAttribute('disabled', 'disabled');
	
}


function changeOpno(type) 
{
	document.getElementById("opno1").disabled=false;

	var e1 = document.getElementById("opno");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("opnobtn1");
	e.setAttribute('disabled', 'disabled');
}

function editoperation(type) 
{
	document.getElementById("editOpr").disabled=false;

	var e1 = document.getElementById("operation");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("opbtn1");
	e.setAttribute('disabled', 'disabled');
}



</script>




<script type="text/javascript">
function getOpn_Names(str) {
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
			document.getElementById("opn_names").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "getOpn_Names.jsp?opn_no=" + str, true);
	xmlhttp.send();
};
</script>


</head>
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
					<li><a href="Home.jsp" class="current">Home</a></li>
					<li><a href="#">All DVP Sheets</a></li>
					<li><a href="EditSheet.jsp">Edit DVP Sheets</a></li>
					<li><a href="Approval_Requests.jsp">Approvals Requests</a></li>
					<li><a href="#">Reports</a></li>
					<li><a href="Search.jsp">Search</a></li>
					<li><a href="Logout.jsp" class="last"><strong>
								Log Out (<%=User_Name%>)
						</strong></a></li>
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

	<%
		try {

			Connection con = Connection_Utility.getConnection();
			int basic_id = 0;
			if (request.getParameter("basic_id") != null) {
				basic_id = Integer.parseInt(request
						.getParameter("basic_id"));
			}
			String action = null;
			action = request.getParameter("action");
	%>

	<div class="templatemo_section_1">
		<%
			if (action.equals("new")) {
		%>

		<table border="1" class="tftable">
			<tr style="background-color: #B0C9D6" align="center">
				<th height="17" colspan="8" align="center" scope="col">PPAP
					Batch / Trials</th>
			</tr>
			<tr align="center" style="background-color: #C7C7C7">
				<td><strong>B. No.</strong></td>
				<td><strong>MC Allocation</strong></td>
				<td><strong>Pre PPAP Batch / Pilot Lot</strong></td>
				<td><strong>Feedback Details</strong></td>
				<td><strong>PPAP Batch Date</strong></td>
				<td><strong>Feedback Details</strong></td>
				<td><strong>Hand Over to Production</strong></td>
				<td><strong>Attachment</strong></td>
			</tr>
			<%
				int b_no = 0;
						PreparedStatement ps_getPPAPTrials = con
								.prepareStatement("select * from dev_ppap_trial_tbl where Basic_Id="
										+ basic_id);
						ResultSet rs_getPPAPTrials = ps_getPPAPTrials
								.executeQuery();
						while (rs_getPPAPTrials.next()) {
							b_no = b_no + 1;
			%>
			<tr align="center">
				<td><%=b_no%></td>
				<td><%=rs_getPPAPTrials.getString("mc_allocation")%></td>
				<td><%=rs_getPPAPTrials.getInt("ppap_pilot_lot")%></td>
				<td><%=rs_getPPAPTrials
								.getString("pilot_lot_feedback")%></td>
				<td><%=rs_getPPAPTrials.getDate("ppap_batch_date")%></td>
				<td><%=rs_getPPAPTrials
								.getString("feedback_details")%></td>
				<td><%=rs_getPPAPTrials.getDate("Handover_toProd")%></td>
				<td>
					<%
						PreparedStatement ps_attach = con
											.prepareStatement("select * from dev_ppap_trial_attachment_tbl where ppap_trial_id="
													+ rs_getPPAPTrials
															.getInt("ppap_trial_id"));
									ResultSet rs_attach = ps_attach.executeQuery();
									while (rs_attach.next()) {
					%> <a
					href="Display_ppapAttachment.jsp?field=<%=rs_attach.getInt("ppap_trial_attach_id")%>"><%=rs_attach.getString("file_name")%></a>
					<%
						}
					%>
				</td>
			</tr>
			<%
				}
			%>
		</table>




		<form action="Add_PPAPTrials_controller" class="register"
			method="post" id="myForm" name="myForm" enctype="multipart/form-data">

			<input type="hidden" name="basic_id" id="basic_id"
				value="<%=basic_id%>">

			<table width="1310" border="0">
				<tr>
					<th height="36" colspan="5" align="left" scope="col"><strong
						style="color: #0066FF">Add PPAP Batch / Trials </strong></th>
				</tr>

				<tr>
					<td width="28">&nbsp;</td>
					<td width="218"><strong>MC Allocation</strong></td>
					<td width="5"><strong>:</strong></td>
					<td width="1031"><input type="text" name="mcallocation">
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Pre PPAP Batch / Pilot Lot</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="ppapbatch_lot"
						onkeypress="return validatenumerics(event);"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Feedback</strong></td>
					<td><strong>:</strong></td>
					<td><textarea name="feedback"></textarea></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>PPAP Batch Date</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="ppap_date" id="ppap_date"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Feedback Details</strong></td>
					<td><strong>:</strong></td>
					<td><textarea name="feedback_details"></textarea></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Hand Over to Production</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="handover_toprod_date"
						id="handover_date"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Attachment</strong></td>
					<td><strong>:</strong></td>
					<td><input type="file" name="Attachment" id="Attachment"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3"><input name="Add" type="submit" value="Add">
					</td>
				</tr>
			</table>




		</form>
		<%
			} else {

					int ppap_id = 0;

					if (request.getParameter("PPAP_Id") != null) {
						ppap_id = Integer.parseInt(request
								.getParameter("PPAP_Id"));
					}
					System.out.println("ppap_id=" + ppap_id);
					System.out.println(action);
		%>
		<form action="Edit_PPAPTrials_controller" class="register"
			method="post" id="myForm1" name="myForm1"
			enctype="multipart/form-data">

			<input type="hidden" name="basic_id" id="basic_id"
				value="<%=basic_id%>"> <input type="hidden" name="ppap_id"
				id="ppap_id" value="<%=ppap_id%>">

			<table border="0">
				<tr>
					<th height="36" colspan="4" align="left" scope="col"><strong
						style="color: #0066FF">Edit PPAP Batch / Trials </strong></th>
				</tr>
				<%
					PreparedStatement ps_getPPAP_Details = con
									.prepareStatement("select * from dev_ppap_trial_tbl where ppap_trial_id="
											+ ppap_id);
							ResultSet rs_getPPAP_Details = ps_getPPAP_Details
									.executeQuery();
							while (rs_getPPAP_Details.next()) {
				%>
				<tr>
					<td>&nbsp;</td>
					<td><strong>MC Allocation</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text"
						value="<%=rs_getPPAP_Details.getString("mc_allocation")%>"
						name="mcallocation"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>PPAP Batch / Pilot Lot</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text"
						value="<%=rs_getPPAP_Details.getInt("ppap_pilot_lot")%>"
						onkeypress="return validatenumerics(event);" name="ppapbatch_lot"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Feedback</strong></td>
					<td><strong>:</strong></td>
					<td><textarea name="feedback"><%=rs_getPPAP_Details
								.getString("pilot_lot_feedback")%></textarea></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>PPAP Batch Date</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="ppap_date"
						value="<%=rs_getPPAP_Details.getDate("ppap_batch_date")%>"
						id="ppap_date"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Feedback Details</strong></td>
					<td><strong>:</strong></td>
					<td><textarea name="feedback_details"><%=rs_getPPAP_Details
								.getString("feedback_details")%></textarea></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Hand Over to Production</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="handover_toprod_date"
						value="<%=rs_getPPAP_Details.getDate("Handover_toProd")%>"
						id="handover_date"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Attachment</strong></td>
					<td><strong>:</strong></td>
					<td>
						<%
							PreparedStatement ps_attach = con
												.prepareStatement("select * from dev_ppap_trial_attachment_tbl where ppap_trial_id="
														+ rs_getPPAP_Details
																.getInt("ppap_trial_id"));
										ResultSet rs_attach = ps_attach.executeQuery();
										while (rs_attach.next()) {
						%> <a
						href="Display_ppapAttachment.jsp?field=<%=rs_attach.getInt("ppap_trial_attach_id")%>"><%=rs_attach.getString("file_name")%></a>
						<input type="hidden" name="preppapAttach" id="preppapAttach"
						value="<%=rs_attach.getInt("ppap_trial_attach_id")%>"> <%
 	}
 %>
					</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td><strong>Update Attachment</strong></td>
					<td><strong>:</strong></td>
					<td><input type="file" name="Attachment" id="Attachment"></td>
				</tr>

				<%
					}
				%>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3"><input name="Add" type="submit" value="Update">
					</td>
				</tr>

			</table>
		</form>

		<%
			}
		%>
	</div>
	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong>
				DVP BOSS</strong></li>


		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New
				DVP Sheet</a></li>



		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a></li>


		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a><br /></li>


	</ul>

	<!-- ----------------------------------------------------------------------------------------------- -->
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

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
</html>