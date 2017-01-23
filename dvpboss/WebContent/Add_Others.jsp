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
<title>Add Other</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>

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
<script type="text/javascript">
function validateForm(){
	var desc=document.getElementById("desc_Other");
	
	 if(desc.value=="" || desc.value==null || desc.value=="null"){
		 alert("Other Details ???");
			return false;
	 }
	 return true;
}

</script>

<script type="text/javascript">
function editvalidateForm(){
	var editDec=document.getElementById("otherEditDesc");
	 if(editDec.value=="" || editDec.value==null){
		 alert("Other Details ???");
			return false;
	 }
}

</script>

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
					<li><a href="All_DVPSheets.jsp">All DVP Sheets</a></li>
					<li><a href="EditSheet.jsp">Edit DVP Sheets</a></li>
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
	<%
		int rel_id = 0;
		int basic_id = 0;
		if (request.getParameter("relId") != null) {
			rel_id = Integer.parseInt(request.getParameter("relId"));
		}

		if (request.getParameter("basic_id") != null) {
			basic_id = Integer.parseInt(request.getParameter("basic_id"));
		}
		
		String action=null;
		action=request.getParameter("action");
		
		try {
			Connection con = Connection_Utility.getConnection();

			System.out.println("basic id =" + basic_id + " Rel Id = "
					+ rel_id);
	%>


	<div class="templatemo_section_1">
<%
		if(action.equalsIgnoreCase("new"))
		{
			
%>
		<form action="Add_Others_Controller" class="register" method="post"
			id="myForm" name="myForm" onsubmit="return(validateForm());">

			<input type="hidden" name="basic_id" value="<%=basic_id%>">
			<input type="hidden" name="rel_id" value="<%=rel_id%>">

			
			</br>
			<table width="56%">
				<tr>
					<th colspan="4" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Add Other Details </span></th>
				</tr>
				<tr>
					<td width="10%" height="24">Other Details</td>
					<td width="1%">:</td>
					<td width="50%"><textarea name="description" id="desc_Other" rows="5" cols="50"></textarea></td>
					<td width="44%">&nbsp;</td>
				</tr>


				<tr>
					<td height="21">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td colspan="1" align="center"><input type="submit"
						name="Submit" value="Add" /></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
		<%

			}
		else
		{
			%>
				<form action="Edit_Others_Controller" class="register" method="post"
			id="myForm" name="myForm" onsubmit="return(editvalidateForm());">

			<input type="hidden" name="basic_id" value="<%=basic_id%>">
			<input type="hidden" name="rel_id" value="<%=rel_id%>">
			</br>
			<table width="56%">
				<tr>
					<th colspan="4" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Edit Other Details</span></th>
				</tr>
				<tr>
					<td width="10%" height="24">Other Details</td>
					<td width="1%">:</td>
					<%
						PreparedStatement ps_getOther=con.prepareStatement("select other_discription from dev_otherdata_tbl where basic_id="+basic_id+" and opnno_opn_rel_id="+rel_id);
						ResultSet rs_getOther=ps_getOther.executeQuery();
						while(rs_getOther.next())
						{
					%>
					<td><textarea name="description" id="otherEditDesc" rows="5" cols="50"><%=rs_getOther.getString("other_discription") %></textarea></td>
					<%

						}
						rs_getOther.close();
						ps_getOther.close();
					%>
					<td width="44%">&nbsp;</td>
				</tr>

				<tr>
					<td height="21">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td colspan="1" align="center">
					<input type="submit" name="Submit" value="Update" /></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>			
			
			<%
		}
		
		%>
	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong> DVP BOSS</strong></li>

	<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New DVP
				Sheet</a></li>

		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a> </li>

	<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a> </li>
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