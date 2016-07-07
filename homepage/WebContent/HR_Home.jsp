<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>IT Tracker Home</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<script type="text/javascript">
	function getAvailData(str) {
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
				document.getElementById("Particulars").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "GetParticulars.jsp?q=" + str, true);
		xmlhttp.send();
	};
</script>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<script>
	$(function() {
		$("#tabs").tabs();
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#date").datepicker({

		});
	}); 
</script> 

<script type="text/javascript">  
function addDev_Type() {
	window.location="Add_newDeviceType.jsp";
}
	// Form validation code will come here.
	function validateForm() {
	var date1 = document.getElementById("date");   
	var file = document.getElementById("file");
	
		if (date1.value=="0" || date1.value==null || date1.value=="" || date1.value=="null") {
			alert("Please Provide Date !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (file.value=="0" || file.value==null || file.value=="" || file.value=="null") {
			alert("Please Provide Attendance File !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}		
		document.getElementById("ADD").disabled = true;
		ProgressImage = document.getElementById('progress_image');
		document.getElementById("progress").style.visibility = 'visible'; 
		setTimeout("ProgressImage.src = ProgressImage.src", 100);
		return true;
	}
</script>
</head>
<body>
<%
try {
	
	int dept_id=0;
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String uname="",today="",yestday="";
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		uname=rs_uname.getString("U_Name");
		dept_id = rs_uname.getInt("Dept_Id");
	}
	rs_uname.close();
	ps_uname.close();
	Calendar cal = Calendar.getInstance();
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
	today = dateFormat.format(cal.getTime());
	cal.add(Calendar.DATE, -1);
	yestday = dateFormat.format(cal.getTime()); 
%>

<div id="container">
  <div id="top">
   <img alt="image/attend.png" src="image/attend.png" width="20%" height="80px" align="middle"/> 
  </div>
  <div id="menu">
			<ul>
				<li><a href="HR_Home.jsp">Home</a></li> 
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: x-small;"> (<%=uname%>)</strong></a></li>
			</ul>
		</div>
 
  <div style="width:50%; height: 100%; padding-left: 20px;padding-bottom: 5px;padding-top: 5px;float:left;">
  <form action="HR_Attendance_Controller" method="post" id="myForm" name="myForm" enctype="multipart/form-data" onSubmit="return validateForm();">
				<table width="95%" border="0">
					<tr>
						<th colspan="5" align="left" scope="col"><b style="font-size: 20px; color: green;">Add New Attendance Sheet :</b></th>
					</tr> 	 	
					<tr>
						<td height="36">Date</td>
						<td><strong>:</strong></td>
						<td><input type="text" name="date" id="date" size="20" style="height: 20px;readonly="readonly"/>&nbsp;&nbsp;yyyy-mm-dd </td>
					</tr>			
					<tr>
						<td height="36">Attachment</td>
						<td><strong>:</strong></td>
						<td><input type="file" name="file" id="file" size="45" style="height: 25px;"/></td>
					</tr>	
					<tr>
						<td height="36"><strong><a href="HR_Home.jsp" style="font-size:20px;width: 155px;height: 35px;">Reset</a></strong> </td> 
					<td height="36" colspan="2"><input type="submit" name="submit" id="ADD"  class="groovybutton" value="ADD"
							style="background-color: #BABABA;width: 155px;height: 35px;"/></td>
					</tr>
					<tr>
						<td height="36" colspan="3">
		<%
		if(request.getParameter("success")==null && request.getParameter("error")==null){
		%>
		
		<p align="left" style="visibility: hidden;" id="progress">								 
			<img src="images/loading.gif"/>
		</p>
		<%
		}
		%>
		<%
		if(request.getParameter("success")!=null && request.getParameter("error")==null){
		%>
		
		<p style="color: green;"> <%=request.getParameter("success") %>
		</p>
		<%
		}
		%>
		<%
		if(request.getParameter("error")!=null && request.getParameter("success")==null){
		%> 
		<p style="color: red;">	 <%=request.getParameter("error") %>
		</p>
		<%
		}
		%>
						</td>
					</tr>
						
				</table>
				</form>
  		 		
  <br />
  </div>
  <div style="width:40%; height: 100%; padding-left: 5px;padding-bottom: 5px;padding-top: 5px;float:right;">
 <table border="1" style="font-size: 13px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
			<tr>
				<td colspan="3" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Attendance Sheet</b></td>
			</tr>
		<tr bgcolor="#B6B0B8">
				<td width="10%" style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong>Sr. No</strong></td>
				<td width="40%" style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong>Attendance Date(dd-mm-yyyy)</strong> </td>
				<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong>Attendance Sheet</strong></td>
		</tr>
		<%
		PreparedStatement ps_avail=con.prepareStatement("select * from hr_attendance_data_tbl where attendance_date='"+today+"' or attendance_date='"+yestday+"' having Delete_Status=1");
		ResultSet rs_avail =ps_avail.executeQuery();
		
		int cnt =1;
		rs_avail.last();
		int avail = rs_avail.getRow();
		rs_avail.beforeFirst();
		if(avail>0){
		while(rs_avail.next()){
			DateFormat dateavailFm = new SimpleDateFormat("dd-MM-yyyy"); 
			String attDate = dateavailFm.format(rs_avail.getDate("attendance_date").getTime());
		%>
		<tr>
		<td width="10%" style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=cnt %> </td> 
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=attDate %> </td> 
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;">
		<a href="Display_AttendanceSheet.jsp?field=<%=rs_avail.getInt("Attendance_data_id")%>"><strong style="color: green;"><%=rs_avail.getString("File_Name") %></strong></a>
		</td>
		</tr>
		<%
		cnt++;
		}
		}		
		%>
		</table>
  </div>
   
</div>
  <%
   	} catch (Exception e) {
   		e.printStackTrace();
   	}
   %> 
</body>
</html>
