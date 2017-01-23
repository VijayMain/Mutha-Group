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
<title>DVP Home</title>

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
	font-size: 10px;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}

table.gridtable tr {
	border-width: 1px;
	padding: 5px;
	font-size: 11px;
	border-style: solid;
	border-color: #666666;
}

table.gridtable td {
	border-width: 1px;
	padding: 3px;
	font-size: 10px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
</style>

<script language="javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = 'white';
	}
}
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
	int plant_id = 0, PlantVendor = 0;
	int cast_id = 0, castVendor = 0;
	String User_Name = null;

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
					<li><a href="Home.jsp" class="current"  style="font-size: 12px;">HOME</a></li>
					<li><a href="All_DVPSheets.jsp"  style="font-size: 12px;">ALL SHEETS</a></li>
					<li><a href="EditSheet.jsp"  style="font-size: 12px;">EDIT SHEETS</a></li>
					<li><a href="Approval_Requests.jsp"  style="font-size: 12px;">REQUESTS</a></li> 
					<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">DVP MOM</a></li>
					<!-- <li><a href="#"  style="font-size: 12px;">REPORTS</a></li> -->
					<li><a href="Search.jsp"  style="font-size: 12px;">SEARCH</a></li>
					<li><a href="Logout.jsp" class="last"  style="font-size: 12px;">LOG OUT (<b><%=User_Name%></b>)
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

		<form action="Activity_Sheet.jsp" class="register" method="post" id="myForm" name="myForm">

			<table width="93%" border="1" class="gridtable">
				<tr align="center" style="background-color: #B0C9D6">
					<th width="1%" height="33" scope="col">Sheet No.</th>
					<th width="12%" scope="col">Customer</th>
					<th width="12%" scope="col">Part Name</th>
					<th width="10%" scope="col">Part No</th>
					<th width="5%" scope="col">Machining From</th>
					<th width="5%" scope="col">Casting From</th>
					<th width="5%" scope="col">Schedule/Month</th>
				</tr>
				<%
					int basic_id = 0;
						PreparedStatement ps_getBasicInfo = con.prepareStatement("select * from dev_basicinfo_tbl where basic_Id in(select basic_id from dev_basic_projectLead_rel_tbl where Project_Lead="
										+ uid + " or Created_By= "+uid+")");

						ResultSet rs_getBasicInfo = ps_getBasicInfo.executeQuery();

						while (rs_getBasicInfo.next()) {
							basic_id = rs_getBasicInfo.getInt("Basic_Id");
				%>
				<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=rs_getBasicInfo.getInt("Basic_Id")%>');" align="center" style="cursor: pointer;">
					<td><%=basic_id%></td>
					<input type="hidden" name="hid" id="hid">
					<%
						PreparedStatement ps_getCustName = con
										.prepareStatement("select Cust_Name from customer_tbl where Cust_Id="
												+ rs_getBasicInfo.getInt("Cust_Id"));
								ResultSet rs_getCustName = ps_getCustName.executeQuery();
								while (rs_getCustName.next()) {
					%>
					<td align="left"><%=rs_getCustName.getString("Cust_Name")%></td>
					<%
						}
					%>


					<%
						PreparedStatement ps_getPartName = con
										.prepareStatement("select Part_Name from cs_part_name_tbl where PartName_Id="
												+ rs_getBasicInfo.getInt("PartName_Id"));
								ResultSet rs_getPartName = ps_getPartName.executeQuery();

								while (rs_getPartName.next()) {
					%>
					<td align="left"><%=rs_getPartName.getString("Part_Name")%></td>
					<%
						}
								rs_getPartName.close();
								ps_getPartName.close();

								PreparedStatement ps_getPartNo = con
										.prepareStatement("select Part_No from cs_part_no_tbl where PartNo_Id="
												+ rs_getBasicInfo.getInt("PartNo_Id"));
								ResultSet rs_getPartNo = ps_getPartNo.executeQuery();
								while (rs_getPartNo.next()) {
					%>
					<td align="left"><%=rs_getPartNo.getString("Part_No")%></td>
					<%
						}
								PreparedStatement ps_plant = con
										.prepareStatement("select Plant_Id  from  dev_basic_plant_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_plant = ps_plant.executeQuery();
								while (rs_plant.next()) {
									plant_id = rs_plant.getInt("Plant_Id");
								}

								PreparedStatement ps_plantVandor = con
										.prepareStatement("select PlantVendor_Id  from  dev_basic_plantvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_plantVandor = ps_plantVandor.executeQuery();
								while (rs_plantVandor.next()) {
									PlantVendor = rs_plantVandor.getInt("PlantVendor_Id");
								}

								System.out.println("Plant = " + plant_id + "Plant Vendor ="
										+ PlantVendor);
								if (plant_id != 0) {
						PreparedStatement ps_plantId = con
											.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
													+ plant_id);
									ResultSet rs_plantId = ps_plantId.executeQuery();
									while (rs_plantId.next()) {
					%>

					<td align="left"><%=rs_plantId.getString("Company_Name")%></td>

					<%
						}
					%>
					<%
						} else if (PlantVendor != 0) {

									PreparedStatement ps_plantVendorId = con
											.prepareStatement("select plantvendor_name from dev_plantvendor_tbl where plantvendor_id="
													+ PlantVendor);
									ResultSet rs_plantVendorId = ps_plantVendorId
											.executeQuery();
									while (rs_plantVendorId.next()) {
					%>
					<td align="left"><%=rs_plantVendorId.getString("plantvendor_name")%></td>
					<%
						}

								} else {
					%>
					<td></td>
					<%
						}
					%>

					<%
						PreparedStatement ps_cast = con
										.prepareStatement("select Casting_From_Id from dev_basic_casting_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_cast = ps_cast.executeQuery();
								while (rs_cast.next()) {
									cast_id = rs_cast.getInt("Casting_From_Id");
								}

								PreparedStatement ps_castVendor = con
										.prepareStatement("select CastingVendor_Id from dev_basic_castingvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_castVendor = ps_castVendor.executeQuery();
								while (rs_castVendor.next()) {
									castVendor = rs_castVendor.getInt("CastingVendor_Id");
								}
								System.out.println("casting from = " + cast_id
										+ " Casting Vendor =" + castVendor);
								if (cast_id != 0) {

									PreparedStatement ps_castingFrom = con
											.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
													+ cast_id);
									ResultSet rs_castingFrom = ps_castingFrom
											.executeQuery();
									while (rs_castingFrom.next()) {
					%>
					<td align="left"><%=rs_castingFrom.getString("Company_Name")%></td>
					<%
						}
								} else if (castVendor != 0) {

									PreparedStatement ps_castingVendor = con
											.prepareStatement("select castingvendor_name from dev_castingvendor_tbl where castingvendor_id="
													+ castVendor);
									ResultSet rs_castingVendor = ps_castingVendor
											.executeQuery();
									while (rs_castingVendor.next()) {
					%>
					<td align="left"><%=rs_castingVendor
									.getString("castingvendor_name")%></td>
					<%
						}

								}
					%>




					<td align="right"><%=rs_getBasicInfo.getInt("Schedule_Per_Month")%></td>
				</tr>
				<%
					System.out.println("Shedule / month "
									+ rs_getBasicInfo.getInt("Schedule_Per_Month"));
						}
				%>
			</table>
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
		<li style="color: #020303;"><a href="Home.jsp"><img src="images/homeicon.png"><strong> DVP BOSS</strong></a></li>
		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New DVP Sheet </a></li>
		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My Approvals</a></li>
		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval Status</a></li>
		<li><a href="Dev_Summary_Sheet.jsp" style="font-size: 12px;">DVP Summary</a></li>
		<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">MOM Summary</a><br /></li>
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