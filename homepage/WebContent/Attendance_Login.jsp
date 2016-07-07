<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<html>
<head> 
<title>IT Tracker Login</title>
<script type="text/javascript">
function getAvailSheet(str) {
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
			document.getElementById("sheetdata").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "Get_AvailData.jsp?q=" + str, true);
	xmlhttp.send();

}

function validateForm() {
var u_name=document.getElementById("u_name"); 
var u_pwd=document.getElementById("u_pwd");

if(u_name.value=="0" || u_name.value==null || u_name.value=="" || u_name.value=="null"){
	alert("Please Enter User Name !!!");
	return false; 
	}

if(u_pwd.value=="0" || u_pwd.value==null || u_pwd.value=="" || u_pwd.value=="null"){
	alert("Please Enter Password !!!");
	return false; 
	}
	
return true;
}	
</script>
</head>
<body bgcolor="#D6D6D6"> 
<%
try{ 
	Connection con = Connection_Utility.getConnection();
%>
	<div style="float: left; width:50%;margin-left: 7%;">
	<br>
	<br> 
	<table border="1" style="font-size: 15px; color: #333333; width: 80%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
			<tr>
				<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Mutha Group Attendance Sheet</b></td>
			</tr>
			<tr bgcolor="#B6B0B8">
				<td width="5%" style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong>Select Company</strong>
				<strong>:</strong>&nbsp;&nbsp; 
				<select id="comp" name="comp" onchange="getAvailSheet(this.value)" style="padding-left: 40px;padding-right: 40px;padding-top: 40px;padding-bottom: 40px;">
				<option value="">- - - - - Select - - - - -</option>
				 <%
				 PreparedStatement ps_comp=con.prepareStatement("select * from user_tbl_company where Company_Id!=6");
				 ResultSet rs_comp=ps_comp.executeQuery();
				 while(rs_comp.next()){
				 %>
				 <option value="<%=rs_comp.getInt("Company_Id")%>"><%=rs_comp.getString("Company_Name")%></option>
				 <%
				 }
				 %>
				</select>				
				</td>				 
			</tr>  
		</table>
		<span id="sheetdata"></span>
		
			
	</div>

	<div style="float: right; width: 30%;margin-right: 7%">
		<form action="Login_Controller" method="post" onSubmit="return validateForm();">
		<img alt="image/attend.png" src="image/attend.png" width="50%" height="150px" align="middle"> 
		
		<br>
		<br>
		<table style="font-size: 15px; color: #333333; width: 70%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
			<tr>
				<td align="left" colspan="2" height="35px"><strong>HR Login Details :</strong> </td> 
			</tr>
			<tr>
				<td align="left"><label>User Name :</label></td>
				<td align="left"><input type="text" name="u_name" id="u_name" size="25"> </td>
			</tr>
			<tr>
				<td align="left"><label>Password :</label></td>
				<td align="left"><input type="password" name="u_pwd" id="u_pwd" size="25"> </td>
			</tr> 
			<tr>
				<td colspan="2" align="center"><input type="submit" value="Login" style="width: 150px;height: 34px;"> </td>
			</tr>
		
		</table>
	</form>	
	
	</div>
	<%
	}catch(Exception e){
	e.printStackTrace();
	}
	%>
</body>
</html>