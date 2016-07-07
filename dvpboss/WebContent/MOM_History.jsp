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
<title>MOM History</title>

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
	//	document.getElementById("hid").value = val1;
		myForm.submit();
	}
	
	function validate_MOM() {
		var title = document.getElementById("title");
		var description = document.getElementById("description");
		var attachment = document.getElementById("attachment"); 
		 
			if (title.value=="0" || title.value==null || title.value=="" || title.value=="null") {
				alert("Please Provide Titile !!!");  
				return false;
			}
			if (description.value=="0" || description.value==null || description.value=="" || description.value=="null") {
				alert("Please Provide Description !!!"); 
				return false;
			} 
			if (attachment.value=="0" || attachment.value==null || attachment.value=="" || attachment.value=="null") {
				alert("Please Provide Updated MOM Sheet !!!");
				return false;
			}
	}
	
	function getMOM_AttachData(str,momcode){
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
		xmlhttp.open("POST", "getSearched_AttachedMOM.jsp?q=" + str + " &r=" + momcode, true);
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
    int momcode = Integer.parseInt(request.getParameter("hid"));
    /* String momStatus = request.getParameter("status");
    System.out.print("datata  = = " + momStatus); */
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
					<li><a href="Home.jsp"  style="font-size: 12px;">HOME</a></li>
					<li><a href="All_DVPSheets.jsp"  style="font-size: 12px;">ALL SHEETS</a></li>
					<li><a href="EditSheet.jsp"  style="font-size: 12px;">EDIT SHEETS</a></li>
					<li><a href="Approval_Requests.jsp"  style="font-size: 12px;">REQUESTS</a></li> 
					<li><a href="MOM_Sheet.jsp" class="current"  style="font-size: 12px;">DVP MOM</a></li>
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
	 
	<div class="templatemo_section_1">
	<div style="width: 90%">
	<div style="float: left;width: 65%;"> 
		<!-- <span style="color: red; font-family: Arial;font-size: 11px;"><b>(Please Note : Click on  Records to Upload/Download Development MOM Sheet Details &#8628; )</b></span> -->
			<table width="100%" border="1" class="gridtable">
				<tr align="center" style="background-color: #B0C9D6">
					<th scope="col" height="33">COMPANY</th>
					<th scope="col">PART NAME</th>
					<th scope="col">MOM DATE</th>
					<th scope="col">CREATED BY</th> 
					<th scope="col">MOM Sheet</th>
				</tr>
				<% 
				PreparedStatement ps_comp = null,ps_user=null;
				ResultSet rs_comp = null,rs_user=null;
				PreparedStatement ps_mom = con.prepareStatement("select * from dev_mom_tbl where CODE="+momcode+" and enable=1");
				ResultSet rs_mom = ps_mom.executeQuery();
				while(rs_mom.next()){
				%>
				<tr onclick="button1('<%=rs_mom.getInt("CODE")%>');" align="center" style="cursor: pointer;" height="33">
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
					<td>
					 <a href="Display_MOMSheet.jsp?field=<%=rs_mom.getInt("CODE")%>"><%=rs_mom.getString("attach_name")%></a>
					</td>
				</tr> 
			<% 
				}
			%>
			<tr align="center" style="background-color: #B0C9D6"> 
					<td colspan="5" height="18" align="left"><b style="font-size: 14px;">MOM HISTORY &#8658; </b>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="MOM_History.jsp?hid=<%=momcode %>" style="text-decoration: none;"><b style="color: blue;">Refresh</b></a></td>
				</tr> 
			</table>
			<div style="overflow: scroll;height: 500px;">
			<span id="getMOM_Data">
			<table width="100%" border="1" class="gridtable">
				<tr align="center" style="background-color: #B0C9D6"> 
					<th scope="col" height="30">USER NAME
							<select name="s_name" id="s_name" style="width : 20px;"  onchange="getMOM_AttachData(this.value,<%=momcode%>)">
								<option value=""></option>
								<%
									PreparedStatement ps_sname = con.prepareStatement("SELECT * FROM user_tbl where u_id in(SELECT created_by FROM  dev_mom_history_tbl where mom_code="+momcode+")");
									ResultSet rs_sname = ps_sname.executeQuery();
									while(rs_sname.next()){
								%>					
								<option value="<%=rs_sname.getInt("U_Id")%>"><%=rs_sname.getString("U_Name") %></option>
					 			<%
									}
									ps_sname.close();
									rs_sname.close();
					 			%>
							</select>
							
					</th> 
					<th scope="col">TITLE</th>
					<th scope="col">DESCRIPTION</th> 
					<th scope="col">MOM ATTACHED</th> 
					<th scope="col">MOM UPDATE DATE</th>
				</tr>  
				<%
				PreparedStatement ps_uname = null;
				ResultSet rs_uname = null;
				PreparedStatement ps_his = con.prepareStatement("select * from dev_mom_history_tbl where mom_code="+momcode +" order by created_by,attach_date desc");
				ResultSet rs_his = ps_his.executeQuery();
				while(rs_his.next()){
				%>
				<tr>
				 <%
				 ps_uname = con.prepareStatement("select * from user_tbl where U_Id=" + rs_his.getInt("created_by"));
				 rs_uname = ps_uname.executeQuery();
				 while(rs_uname.next()){
				 %>
					<td scope="col"><%=rs_uname.getString("U_Name") %></td>
				<%
				 }
				%>
					<td scope="col"><%=rs_his.getString("title") %></td>
					<td scope="col"><%=rs_his.getString("description") %></td> 
					<td scope="col"><a href="Get_MOMAttach_hist.jsp?field=<%=rs_his.getInt("code")%>"><%=rs_his.getString("attach_name")%></a></td> 
					<td scope="col"><%= sdf.format(rs_his.getDate("attach_date")) %></td>
				</tr>
				<%
				}
				%>
				</table>
				</span>
				
				
				</div>
		</div>
		
		<div style="width: 34%;float: right;">
		<form action="MOM_Sheet_Update" class="register" method="post"  onSubmit="return validate_MOM();" enctype="multipart/form-data">
				<input type="hidden" name="hid" id="hid" value="<%=momcode%>">
			<table width="100%"  style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #172380;">
					<th height="33" scope="col" colspan="3"><b style="color: white;">&nbsp;&nbsp;Add Updated Development MOM Sheets &#8658; </b></th>  
				</tr>
				<tr>
					<td width="30%"><b style="color: red;">*</b><b>Titile</b></td>
					<td width="1%"><b>:</b></td>
					<td>
					<input type="text" name="title" id="title" size="30"/>
					</td>
				</tr>
				<tr>
					<td width="30%"><b style="color: red;">*</b><b>Description</b></td>
					<td width="1%"><b>:</b></td>
					<td> 
					<textarea rows="3" cols="27" name="description" id="description"></textarea>
					</td>
				</tr>
				<tr>
					<td width="26%"><b style="color: red;">*</b><b>MOM Sheet</b></td>
					<td width="1%"><b>:</b></td>
					<td> 
					<input type="file" name="attachment" id="attachment">
					</td>
				</tr> 
				<tr>
					<td></td>
					<td colspan="3"><input type="submit" value="     SAVE     " style="background-color: #BABABA;" />
					<a href="MOM_History.jsp?hid=<%=momcode %>" style="text-decoration: none;"><b style="color: blue;">Refresh</b></a>
				<%
				if(request.getParameter("result")!=null){ 
				%> 
				<strong style="color: green;font-family: Arial;font-size: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=request.getParameter("result") %></strong><br/>
				<% 
				}
				if(request.getParameter("error")!=null){
				%> 
				<strong style="color: red;font-family: Arial;font-size: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=request.getParameter("error") %></strong><br/>
				<%		
					} 
   				%>
					</td> 
				</tr>
			</table>
		</form> 
		</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%> 
	</div> 
</div>
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