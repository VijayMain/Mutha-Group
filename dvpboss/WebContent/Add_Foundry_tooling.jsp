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
<title>Add Foundry Tooling</title>

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
	
	$(function() {
		//	$("#datepicker").datepicker();
		$("#receptDate").datepicker({
			appendText : " ( YYYY/MM/DD ) "
		});
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

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) 
	{
		if (highLight) 
		{
			tableRow.style.backgroundColor = '#CFCFCF';
		} 
		else 
		{
			tableRow.style.backgroundColor = '#EDEDED';
		}
	}
</script>

<script language="javascript">
	function button1(val) 
	{
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		myForm.submit();
	}
</script>


</head>
<%
	int uid = 0;
	int ftd_Id=0;

	String User_Name = null;

	int basic_id=0;
	
	String action=null;
	
	action=request.getParameter("action");
	
	if(request.getParameter("ftd_Id")!=null)
	{
		ftd_Id=Integer.parseInt(request.getParameter("ftd_Id"));
		System.out.println("Ftd id by Edit button.."+ftd_Id);
	}
	
	if(request.getParameter("basic_id")!=null)
	{
		basic_id=Integer.parseInt(request.getParameter("basic_id"));
	}
	
	
	
	uid = Integer.parseInt(session.getAttribute("uid").toString());

	Get_UName_bo bo = new Get_UName_bo();

	User_Name = bo.get_UName(uid);

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
					<li><a href="Home.jsp" class="current">Home</a></li>
					<li><a href="All_DVPSheets.jsp">All DVP Sheets</a></li>
					<li><a href="EditSheet.jsp">Edit DVP Sheets</a></li>
					<li><a href="Approval_Requests.jsp">Approvals Requests</a></li>
					<li><a href="#">Reports</a></li>
					<li><a href="Search.jsp">Search</a></li>
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


<%
	if(action.equalsIgnoreCase("new"))
	{
		
%>
	<div class="templatemo_section_1">

		<form action="add_FTD_Conroller" class="register" method="post"
			id="myForm" name="myForm" onsubmit="return(validate());">
		
		<input type="hidden" name="basic_id" value="<%=basic_id%>">
			<table width="57%">
				<tr>
					<th colspan="26" align="left" scope="col"
						style="font-size: 25px; color: #2883B8">Add Foundry Tooling</th>
				</tr>
				<tr>
					<td width="40%">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="24%">&nbsp;</td>
					<td width="10%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
				</tr>
				<tr>
					<td>Sheet Number</td>
					<td>:</td>
					<td><%=basic_id %></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td> 
				</tr>

				<tr>
					<td>No Of Pattern Available</td>
					<td>:</td> 
					<td><input type="text" name="pat_avail" onKeyPress="return validatenumerics(event);"> </td>

					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>No Of Pattern Required</td>
					<td>:</td>
					<td> <input type="text" name="pat_req" onKeyPress="return validatenumerics(event);"> </td> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>No Of Core Box Available</td>
					<td>:</td>
					<td> <input type="text" name="cb_avail" onKeyPress="return validatenumerics(event);"> </td> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>No Of Core Box Required</td>
					<td>:</td>
					<td> <input type="text" name="cb_req" onKeyPress="return validatenumerics(event);"> </td> 
					<td>&nbsp;</td>
				</tr>
				
				
				<tr> 
					<td>Recept Date</td>
					<td>:</td>
					<td colspan="2"> <input type="text" name="receptDate" id="receptDate" /></td> 
				</tr>
				
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="submit" name="Submit" value="Add Foundry Tooling" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
		
	</div>
	<%
	}
	else
	{
		%>
			<div class="templatemo_section_1">

		<form action="edit_FTD_Conroller" class="register" method="post"
			id="myForm" name="myForm" onsubmit="return(validate());">

			<%
				PreparedStatement ps_getFTD=con.prepareStatement("select * from dev_foundrytoolingdata_tbl where Basic_Id="+basic_id+" and FTD_Id="+ftd_Id);
			
			
			%>
			<input type="hidden" name="basic_id" value="<%=basic_id%>">
			<input type="hidden" name="ftd_id" value="<%=ftd_Id%>">
			<table width="57%">
				<tr>
					<th colspan="26" align="left" scope="col"
						style="font-size: 25px; color: #2883B8">Add Foundry Tooling</th>
				</tr>
				<tr>
					<td width="40%">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="24%">&nbsp;</td>
					<td width="10%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
				</tr>
				<%
					ResultSet rs_getFTD=ps_getFTD.executeQuery();
					while(rs_getFTD.next())
					{
				%>
				<tr>
					<td>Sheet Number</td>
					<td>:</td>
					<td><%=basic_id %></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td> 
				</tr>

				<tr>
					<td>No Of Pattern Available</td>
					<td>:</td> 
					<td><input type="text" name="pat_avail" value="<%=rs_getFTD.getInt("Pattern_Avail") %>" onKeyPress="return validatenumerics(event);"> </td>

					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>No Of Pattern Required</td>
					<td>:</td>
					<td> <input type="text" name="pat_req" value="<%=rs_getFTD.getInt("Pattern_Required") %>" onKeyPress="return validatenumerics(event);"> </td> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>No Of Core Box Available</td>
					<td>:</td>
					<td> <input type="text" name="cb_avail" value="<%=rs_getFTD.getInt("CoreBox_Avail") %>" onKeyPress="return validatenumerics(event);"> </td> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>No Of Core Box Required</td>
					<td>:</td>
					<td> <input type="text" name="cb_req" value="<%=rs_getFTD.getInt("CoreBox_Required") %>" onKeyPress="return validatenumerics(event);"> </td> 
					<td>&nbsp;</td>
				</tr>
				
				
				<tr> 
					<td>Recept Date</td>
					<td>:</td>
					<td colspan="2"> <input type="text" name="receptDate" value="<%=rs_getFTD.getDate("Recpt_Date") %>" name="receptDate" id="receptDate" /></td> 
				</tr>
				<%
				
					}
				
				%>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="submit" name="Submit" value="Edit Foundry Tooling" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
		
	</div>
		<%
	}

	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
	<!-- 	<div id="accordion" class="templatemo_section_2">
		<h3>New Sheet</h3>
		<div>
			<a href="NewSheet.jsp" style="font-size: 12px;">New DVP Sheet</a><br />
			<a href="My_Approvals.jsp" style="font-size: 12px;">My Approvals</a><br />
		</div>
		 
	</div> -->

	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong>
				DVP BOSS</strong></li>


		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New
				DVP Sheet</a></li>

		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a></li>


		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a></li>

		<li><a href="Dev_Summary_Sheet.jsp" style="font-size: 12px;">Development
				Summary</a><br /></li>


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