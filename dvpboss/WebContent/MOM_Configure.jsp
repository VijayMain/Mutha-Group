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

$(document).ready(
		  function () {
		    $( "#mom_date" ).datepicker({
		    /* minDate: -60, */
		      changeMonth: true,
		      changeYear: true
		    }); 
		  }
		); 

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
	padding: 8px;
	font-size: 11px; 
}

table.gridtable td { 
	padding: 8px;
	font-size: 11px; 
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
	
	function getPart_Name(str){
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
				document.getElementById("getPart_Name").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "getMOM_PartName.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	function validate_MOM() {
		var comp = document.getElementById("comp");
		var part = document.getElementById("part");
		var mom_date = document.getElementById("mom_date");
		var attachment = document.getElementById("attachment");
		 
			if (comp.value=="0" || comp.value==null || comp.value=="" || comp.value=="null") {
				alert("Please Select Company !!!");  
				return false;
			}
			if (part.value=="0" || part.value==null || part.value=="" || part.value=="null") {
				alert("Please Select Part Name !!!");  
				return false;
			} 
			if (mom_date.value=="0" || mom_date.value==null || mom_date.value=="" || mom_date.value=="null") {
				alert("Please Select MOM Date !!!");  
				return false;
			}
			if (attachment.value=="0" || attachment.value==null || attachment.value=="" || attachment.value=="null") {
				alert("Please Provide Attachment !!!");  
				return false;
			}   
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
					<li><a href="#"  style="font-size: 12px;">REPORTS</a></li>
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
		<form action="MOM_Configure" class="register" method="post"  onSubmit="return validate_MOM();" enctype="multipart/form-data">
			<table width="90%" border="0" class="gridtable" style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #B0C9D6">
					<th height="33" scope="col" colspan="3">&nbsp;&nbsp;Configure Development MOM &#8658; </th>  
				</tr>
				<tr>
				<td width="20%"><b style="color: red;">*</b>Company Name</td>
				<td width="1%">:</td>
				<td>
						<select name="comp" id="comp" style="background-color: #F5F5F5;" onchange="getPart_Name(this.value)">
						<option value="">- - - - - Select - - - - -</option>
						<%
						PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id<6");
						ResultSet rs_comp = ps_comp.executeQuery();
						while(rs_comp.next()){
						%>
						<option value="<%=rs_comp.getInt("Company_Id")%>"><%=rs_comp.getString("Company_Name") %></option>
						<%
						}
						ps_comp.close();
						rs_comp.close();
						%>
						</select>
				</td>
				</tr>
				<tr>
				<td width="13%"><b style="color: red;">*</b>Part Name</td>
				<td width="1%">:</td>
				<td>
				<span id="getPart_Name">
						<select name="part" id="part" style="background-color: #F5F5F5;">
						<option value=""></option>
						</select>
				</span>
				</td>
				</tr>
				<tr>
					<td width="13%"><b style="color: red;">*</b>MOM Date</td>
					<td width="1%">:</td>
					<td> 
					<input type="text" name="mom_date" readonly="readonly" id="mom_date" />
					</td>
				</tr>
				<tr>
					<td width="16%"><b style="color: red;">*</b><b>Attachment</b>(MOM Sheet)</td>
					<td width="1%">:</td>
					<td>
					<input type="file" name="attachment" id="attachment">
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><input type="submit" value="     SAVE     " style="background-color: #BABABA;" />
					<a href="MOM_Configure.jsp" style="text-decoration: none;"><b style="color: blue;">RESET</b></a>
				<%
				if(request.getParameter("result")!=null){
				%> 
				<strong style="color: #A3802C;"><%=request.getParameter("result") %></strong><br/>
				<%
				} 
   				%>
					</td> 
				</tr>
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