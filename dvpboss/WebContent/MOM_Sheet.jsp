<%@page import="java.text.SimpleDateFormat"%>
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
	width: 93%;
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
	
	function getMOM_Data(str){
		if(str!=""){ 
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
				document.getElementById("getMOM_Data").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "getSearched_MOM.jsp?q=" + str, true);
		xmlhttp.send();
		}
	};
	
	function getMOM_Partwise(str){
		var comp = document.getElementById("status").value; 
		if(str!=""){ 
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
				document.getElementById("getMOM_Data").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "getSearchedPart_MOM.jsp?q=" + str + " &r=" + comp, true);
		xmlhttp.send();
		}
	};
</script>


</head>
<%
	int uid = 0;
	int plant_id = 0, PlantVendor = 0;
	int cast_id = 0, castVendor = 0;
	String User_Name = null;
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
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
					<li><a href="Home.jsp" style="font-size: 12px;">HOME</a></li>
					<li><a href="All_DVPSheets.jsp"  style="font-size: 12px;">ALL SHEETS</a></li>
					<li><a href="EditSheet.jsp"  style="font-size: 12px;">EDIT SHEETS</a></li>
					<li><a href="Approval_Requests.jsp"  style="font-size: 12px;">REQUESTS</a></li> 
					<li><a href="MOM_Sheet.jsp"  class="current"  style="font-size: 12px;">DVP MOM</a></li>
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

<a href="MOM_Configure.jsp">
   <input type="button" value=" Configure    " style="cursor: pointer;background-color: #B2E8A0;text-decoration: none;font-weight: bold;"/>
</a>			
<span style="color: red; font-family: Arial;font-size: 11px;"><b>(Please Note : Click on  Records to Upload/Download Development MOM Sheet Details &#8628; )</b></span>
				<%
				if(request.getParameter("result")!=null){
				%> 
				<strong style="color: green;"><%=request.getParameter("result") %> &#8659; </strong><br/>
				<%	
				} 
   				%>
		<form action="MOM_History.jsp" class="register" method="post" id="myForm" name="myForm">
<input type="hidden" name="hid" id="hid">
<span id="getMOM_Data">
<input type="hidden" name="status" id="status" value="All"> 
			<table width="93%" border="1" class="gridtable">
				<tr align="center" style="background-color: #B0C9D6">
					<th width="3%" height="33" scope="col">M.No.</th> 
					<th   scope="col">COMPANY
							<select name="s_comp" id="s_comp" onchange="getMOM_Data(this.value)" style="width: 20px;">
								<option value=""></option>
								<option value="All">All</option>
								<%
									PreparedStatement ps_sname = con.prepareStatement("SELECT * FROM user_tbl_company where company_id in (SELECT distinct(company) FROM dev_mom_tbl)");
									ResultSet rs_sname = ps_sname.executeQuery();
									while(rs_sname.next()){
								%>					
								<option value="<%=rs_sname.getInt("Company_Id")%>"><%=rs_sname.getString("Company_Name") %></option>
					 			<%
									}
									ps_sname.close();
									rs_sname.close();
					 			%>
							</select>
					</th>
					<th  scope="col">PART NAME
								<select name="s_name" id="s_name" style="width : 20px;" onchange="getMOM_Partwise(this.value)">
								<option></option> 
								<%
									PreparedStatement ps_spart = con.prepareStatement("SELECT * FROM complaintzilla.dev_mom_tbl group by part_name order by company");
									ResultSet rs_spart = ps_spart.executeQuery();
									while(rs_spart.next()){
								%>
								<option value="<%=rs_spart.getInt("part_code")%>"><%=rs_spart.getString("part_name") %></option>
					 			<%
									}
									ps_sname.close();
									rs_sname.close();
					 			%>
							</select>
					</th>
					<th   scope="col">MOM DATE</th> 
					<th scope="col">CREATED BY</th> 
				</tr> 
				<%
				int mno = 1;
				PreparedStatement ps_comp = null,ps_user=null;
				ResultSet rs_comp = null,rs_user=null;
				PreparedStatement ps_mom = con.prepareStatement("select * from dev_mom_tbl where enable=1 order by company");
				ResultSet rs_mom = ps_mom.executeQuery();
				while(rs_mom.next()){
				%>
				<tr onclick="button1('<%=rs_mom.getInt("CODE")%>');" align="center" style="cursor: pointer;">
					<td><%=rs_mom.getInt("CODE") %></td>
				<%
					ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_mom.getInt("company"));
					rs_comp = ps_comp.executeQuery();
					while(rs_comp.next()){
				%>
					<td align="left"><%=rs_comp.getString("Company_Name") %></td>
				<%
					}
				%>
					<td align="left"><%=rs_mom.getString("part_name") %></td>
					<td align="left"><%=sdf.format(rs_mom.getDate("mom_date")) %></td>
					<%
					ps_user = con.prepareStatement("select * from user_tbl where U_Id="+rs_mom.getInt("created_by"));
					rs_user = ps_user.executeQuery();
					while(rs_user.next()){
					%>
					<td align="left"><%=rs_user.getString("U_Name") %></td>
					<%
					}
					%>
				</tr> 
			<%
			mno++;
				}
			%>
			</table>
		</span>	
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

		<li><a href="MOM_Sheet.jsp" style="font-size: 12px;background-color: #E8E8E8;"><b>MOM Summary &#8658; </b></a><br /></li>
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