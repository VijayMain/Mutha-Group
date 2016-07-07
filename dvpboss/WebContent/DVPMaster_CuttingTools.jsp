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
<title>DVP Master Page</title>

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
<style type="text/css">
#templatemo_menu {
	float: left;
	width: 100%;
	height: 48px;
	background: url(images/templatemo_menu_bg.jpg);
	padding: 5px 0 0 0;
}
</style>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) 
{
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script>
<script type="text/javascript">
 function openPage(pageURL)
 {
	 window.location.href = pageURL;
 }
</script>
<script>
$(function() {
$( "#menu" ).menu();
});
</script>
<style>
.ui-menu {
	width: 150px;
}
</style>
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



</head>
<%
	int uid = 0;
	int plant_id = 0, PlantVendor = 0;
	int cast_id = 0, castVendor = 0;
	String User_Name = null;

	//	uid = Integer.parseInt(session.getAttribute("uid").toString());

	//	Get_UName_bo bo = new Get_UName_bo();

	//	User_Name = bo.get_UName(uid);

	try {
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
					<li><a href="DVPMaster_OpNo.jsp" class="current">Home</a></li>
					<li><a href="#">Reports</a></li>
					<li><a href="#">Search</a></li>
					<li><a href="Logout.jsp" class="last">Log Out (<b><%=User_Name%></b>)
					</a></li>
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

		<form action="Activity_Sheet.jsp" class="register" method="post"
			id="myForm" name="myForm" onsubmit="return(validate());">



			<div style="float: left; width: 40%">
				<table width="100%">
					<tr>
						<th height="43" colspan="4" align="left" scope="col"><strong
							style="font-size: 22px; color: #2883B8;">Add New Cutting
								Tool: </strong></th>
					</tr>

					<tr>
						<td width="4">&nbsp;</td>
						<td width="161"><strong>Cutting Tool </strong></td>
						<td width="6"><strong>:</strong></td>
						<td width="479"><select name="cuttingtool">
						</select></td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td><strong>New Cutting Tool </strong></td>
						<td><strong>:</strong></td>
						<td><input type="text" name="cuttingtool" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="2"><strong> <input type="button"
								name="Add" value="ADD" /> <input type="button" name="Edit"
								value="Edit" /> <input type="button" name="Delete"
								value="Delete" />
						</strong></td>
					</tr>
				</table>
			</div>
			<div style="width: 60%; float: right;visibility: visible;">
				<table width="100%" align="left">
					<tr>
						<th height="42" colspan="4" align="left" scope="col"><strong
							style="font-size: 22px; color: #2883B8;">Edit Cutting
								Tool: </strong></th>
					</tr>
					<tr>
						<td width="2%" height="24">&nbsp;</td>
						<td width="21%"><strong>Edit Cutting Tool </strong></td>
						<td width="1%">&nbsp;</td>
						<td><input type="text" name="cuttingtool" /></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="2"><strong> <input type="button"
								name="Edit2" value="Edit" />
						</strong></td>
					</tr>
				</table>
			</div>


		</form>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</div>
	<!-- 	<div id="accordion" class="templatemo_section_2">
		<h3>New Sheet</h3>
		<div>
			<a href="NewSheet.jsp" style="font-size: 12px;">New DVP Sheet</a><br />
			<a href="My_Approvals.jsp" style="font-size: 12px;">My Approvals</a><br />
		</div>
		 
	</div> -->
	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong>
				Add / Update</strong></li>


		<li><a href="DVPMaster_OpNo.jsp" style="font-size: 12px;">Operation No</a></li>
		<li><a href="DVPMaster_Operation.jsp" style="font-size: 12px;">Operation</a></li>
		<li><a href="DVPMaster_Machine.jsp" style="font-size: 12px;">Machine Used</a></li>
		<li><a href="DVPMaster_FixtureNo.jsp" style="font-size: 12px;">FIxture No</a></li>
		<li><a href="DVPMaster_Fixture.jsp" style="font-size: 12px;">Fixture</a></li>
		<li><a href="DVPMaster_CuttingTools.jsp" style="font-size: 12px;">Cutting Tools</a></li>
		<li><a href="DVPMaster_Gauges.jsp" style="font-size: 12px;">Gauges</a></li>



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
</html>