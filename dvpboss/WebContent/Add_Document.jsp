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
<title>Add PRE_PPAP Batch</title>

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
				basic_id = Integer.parseInt(request.getParameter("basic_id"));
			}
			String action = null;
			action = request.getParameter("action");
	%>

	<div class="templatemo_section_1">
		<%
			if (action.equals("new")) {
		%>
		 
		<form action="Add_Document_controller" class="register" method="post" id="myForm" name="myForm">

			<input type="hidden" name="basic_id" id="basic_id" value="<%=basic_id%>">

			<table width="1310" border="0">
				<tr>
					<th height="36" colspan="4" align="left" scope="col"><strong style="font-size: 25px; color: #2883B8">Add Documents Summary</strong></th>
				</tr>

				<tr>
					<td width="28">&nbsp;</td>
					<td width="300"><strong>APQP (Yes/No)</strong></td>
					<td width="5"><strong>:</strong></td>
					<td width="2031"><input type="radio" name="apqp" id="apqp" value="yes">Yes
					&nbsp;&nbsp;&nbsp;<input type="radio" name="apqp" id="apqp" value="no">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Process Sheet</strong></td>
					<td><strong>:</strong></td>
					<td>
					<input type="radio" name="pr_sheet" id="pr_sheet" value="yes">Yes
					&nbsp;&nbsp;&nbsp;<input type="radio" name="pr_sheet" id="pr_sheet" value="no">No
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Completed PPAP Document out of 19 </strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="final_ppap" id="final_ppap" size="50" onKeyPress="return validatenumerics(event);"> </td>
				</tr> 
				<tr>
				<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="3"><input name="Add" type="submit" value="Add" style="width: 150px; height: 23px;">
					</td>
				</tr>
			</table>




		</form>
		<%
			} else {

					int docId = 0;

					if (request.getParameter("docId") != null) {
						docId = Integer.parseInt(request.getParameter("docId"));
					}
					System.out.println("docId=" + docId);
		%>
		<form action="Edit_Document_controller" class="register" method="post" id="myForm" name="myForm"> 
		
			<input type="hidden" name="basic_id" id="basic_id" value="<%=basic_id%>"> 
			<input type="hidden" name="docId" id="docId" value="<%=docId%>">
 		

			<input type="hidden" name="basic_id" id="basic_id"
				value="<%=basic_id%>">

			<table width="1310" border="0">
				<tr>
					<th height="36" colspan="4" align="left" scope="col"><strong style="font-size: 25px; color: #2883B8">Edit Documents Summary</strong></th>
				</tr>

			<%
			PreparedStatement ps_docsel=con.prepareStatement("select * from dev_document_tbl where document_id="+docId +" and basic_id="+basic_id);
			ResultSet rs_docsel=ps_docsel.executeQuery();
			while(rs_docsel.next()){
			%>
				<tr>
					<td width="28">&nbsp;</td>
					<td width="300"><strong>APQP (Yes/No)</strong></td>
					<td width="5"><strong>:</strong></td>
					<td width="2031">
					<%
					if(rs_docsel.getString("apqp_doc").equalsIgnoreCase("yes")){
					%>
					<input type="radio" name="apqp" id="apqp" value="Yes" checked="checked">Yes
					&nbsp;&nbsp;&nbsp;<input type="radio" name="apqp" id="apqp" value="No">No
					<%
					}else{
					%>
					<input type="radio" name="apqp" id="apqp" value="Yes">Yes
					&nbsp;&nbsp;&nbsp;<input type="radio" name="apqp" id="apqp" value="No" checked="checked">No
					<%
					}
					%>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Process Sheet</strong></td>
					<td><strong>:</strong></td>
					<td>
					<%
					if(rs_docsel.getString("process_sheet").equalsIgnoreCase("Yes")){
					%>
					<input type="radio" name="pr_sheet" id="pr_sheet" value="Yes" checked="checked">Yes
					&nbsp;&nbsp;&nbsp;<input type="radio" name="pr_sheet" id="pr_sheet" value="No">No
					<%
					}else{
					%>
					<input type="radio" name="pr_sheet" id="pr_sheet" value="Yes">Yes
					&nbsp;&nbsp;&nbsp;<input type="radio" name="pr_sheet" id="pr_sheet" value="No" checked="checked">No		
					<%
					}
					%>			
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><strong>Completed PPAP Document out of 19 </strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="final_ppap" id="final_ppap" size="20" value="<%=rs_docsel.getString("final_ppap") %>" onKeyPress="return validatenumerics(event);"> </td>
				</tr> 
				<tr>
				
				<%
			}
				%>
				<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="3"><input name="Add" type="submit" value="Update" style="width: 150px; height: 23px;">
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