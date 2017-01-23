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
<title>DVP Boss Search</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>

<script type="text/javascript">
	function getpart(str) {
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
				document.getElementById("part1").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Part_ForSearch.jsp?q=" + str, true);
		xmlhttp.send();
	};

	function getpartno(str) {

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
				document.getElementById("partno1").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Part_No_ForSearch.jsp?q=" + str, true);
		xmlhttp.send();

	}
</script>



<script>
$(function() {
$( "#menu" ).menu();
});
</script>
<script>
$(function() {
$( "#dateFrom" ).datepicker({
showButtonPanel: true
});
});

$(function() {
	$( "#dateTo" ).datepicker({
	showButtonPanel: true
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

<script type="text/javascript">
function getSheetNo(){
	var sheetNo=document.getElementById("sheetNo");
	var customer=document.getElementById("customer");
	var partName=document.getElementById("part_name");
	var partNo=document.getElementById("part_no"); 
	var dateTo=document.getElementById("dateTo");
	var dateFrom=document.getElementById("dateFrom");
	
	if(sheetNo.value > 0){ 		
		customer.disabled=true;
		partName.disabled=true;
		partNo.disabled=true;
		dateTo.disabled=true;
		dateFrom.disabled=true; 
	}else{
		customer.disabled=false;
		partName.disabled=false;
		partNo.disabled=false;
		dateTo.disabled=false;
		dateFrom.disabled=false;
	}
}
</script>
<script type="text/javascript">
function validateForm(){
	var sheetNo=document.getElementById("sheetNo"); 
	var dateTo=document.getElementById("dateTo");
	var dateFrom=document.getElementById("dateFrom");
	
	if(sheetNo.value == 0 && (dateTo.value=="" || dateFrom.value=="")){
		alert("Please provide To and From dates !!!");
		return false;
	} 
	return true;
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
 

				<%
					Connection con=Connection_Utility.getConnection();
					String User_Name = null;
					int uid = Integer.parseInt(session.getAttribute("uid").toString());
					Get_UName_bo bo = new Get_UName_bo();
					User_Name = bo.get_UName(uid);
				%>
				 <div id="templatemo_menu">
				<div id="templatemo_menu_left"></div>
				<ul>
					<li><a href="Home.jsp"  style="font-size: 12px;">HOME</a></li>
					<li><a href="All_DVPSheets.jsp"  style="font-size: 12px;">ALL SHEETS</a></li>
					<li><a href="EditSheet.jsp"  style="font-size: 12px;">EDIT SHEETS</a></li>
					<li><a href="Approval_Requests.jsp"  style="font-size: 12px;">REQUESTS</a></li> 
					<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">DVP MOM</a></li>
					<!-- <li><a href="#"  style="font-size: 12px;">REPORTS</a></li> -->
					<li><a href="Search.jsp" class="current"  style="font-size: 12px;">SEARCH</a></li>
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
	<%
		try {
	%>
	<div class="templatemo_section_1"> 
<form action="Search_Controller" method="post" onsubmit="return validateForm();">


		<table width="80%"  style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #172380;">
					<th height="33" scope="col" colspan="4"><b style="color: white;">&nbsp;DVP Sheet Search : &#8658; </b></th>  
				</tr>
			<tr>
				<td>&nbsp;</td>
				<td><strong>DVP Sheet No </strong></td>
				<td><strong>:</strong></td>
				<td><input type="text" name="sheetNo" id="sheetNo" onkeypress="return validatenumerics(event);" onkeyup="getSheetNo();"/></td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td width="19%"><strong>Customer</strong></td>
				<td width="1%"><strong>:</strong></td>
				<%
					PreparedStatement ps_getCust=con.prepareStatement("select cust_id,cust_name from customer_tbl");
					ResultSet rs_getCust=ps_getCust.executeQuery();
				%>
				<td width="78%">
					<select name="customer" onchange="getpart(this.value)" id="customer">
					<option value="0">---Select---</option>
						<%
						while(rs_getCust.next())
						{
						%>
						<option value="<%=rs_getCust.getInt("cust_id")%>"><%=rs_getCust.getString("cust_name")%></option>
						<%
						}
						%>				
					</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><strong>Part Name </strong></td>
				<td><strong>:</strong></td>
				<td id="part1"><select name="part_name" id="part_name" onchange="getpartno(this.value)">
				<option value="0">---Select---</option>
				<%
					PreparedStatement ps_getPartName=con.prepareStatement("select PartName_Id,Part_Name from cs_part_name_tbl");
					ResultSet rs_getPartName=ps_getPartName.executeQuery();
					while(rs_getPartName.next())
					{
				%>
					<option value="<%=rs_getPartName.getInt("PartName_Id")%>"><%=rs_getPartName.getString("Part_Name") %></option>
				<%		
					}
				%>
						
				</select></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><strong>Part No. </strong></td>
				<td><strong>:</strong></td>
				<td id="partno1">
					<select name="part_no" id="part_no">
						<option value="0">----Select----</option>
						<%
							PreparedStatement ps_getPartNo=con.prepareStatement("select Part_No,PartNo_Id from cs_part_no_tbl");
							ResultSet rs_getPartNo=ps_getPartNo.executeQuery();
							while(rs_getPartNo.next())
							{
						%>
						
							<option value="<%=rs_getPartNo.getInt("PartNo_Id")%>"><%=rs_getPartNo.getString("Part_No") %></option>
						
						<%		
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><strong>Date From </strong></td>
				<td><strong>:</strong></td>
				<td><input type="text" readonly="readonly" id="dateFrom"
					name="date_From"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><strong>Date To </strong></td>
				<td><strong>:</strong></td>
				<td><input type="text" readonly="readonly" id="dateTo"
					name="date_To"></td>
			</tr>
			
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><input type="submit" name="Search"
					value="Search" /></td>
			</tr>
		</table>
</form>
	</div>
	<ul id="menu" class="templatemo_section_2">
		<li style="color: #020303;"><a href="Home.jsp"><img src="images/homeicon.png"><strong> DVP BOSS</strong></a></li>
		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New DVP Sheet </a></li> 
		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My Approvals</a></li> 
		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval Status</a></li> 
		<li><a href="Dev_Summary_Sheet.jsp" style="font-size: 12px;">DVP Summary</a></li> 
		<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">MOM Summary</a><br /></li>
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