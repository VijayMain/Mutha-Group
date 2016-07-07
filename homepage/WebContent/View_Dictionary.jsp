<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Add Headlines</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/style.css"/> 
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}
 

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
<link rel="stylesheet" href="js/jquery-ui.css"></link>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<script type="text/javascript">
function delete_msg(str) {
	var where_to = confirm("Do you really want to DELETE this information ???"); 
	if (where_to == true) {
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
				document.getElementById("delmsg").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Delete_headline.jsp?story_id=" + str, true);
		xmlhttp.send();
		window.location.reload();
	} else {
		window.location.reload();
	}
}
</script> 
<script type="text/javascript">
function validate_HeadForm(theForm) { 
	
	var headings = document.getElementById("headline"); 
	
		if (headings.value=="0" || headings.value==null || headings.value=="" || headings.value=="null") {
			alert("Please Provide Headlines !!!");  
			return false;
		}
 
		return true;
}
</script>

</head>
<body>
<%
try{
	Connection con = Connection_Utility.getConnection();			
String uname="",department="";
int d_Id=0;
Date date = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); 
String strDate = sdf.format(date); 
%> 
<div id="container">
    <div id="content"> 
  <div id="menu" style="font-size: 16px;font-family: Arial;">
  <a href="homepage.jsp"><strong>Home</strong></a> &nbsp; &nbsp;&nbsp; 
  <a href="http://192.168.0.6/companyunits.htm/"><strong>ERP</strong> </a> &nbsp;&nbsp; &nbsp;
  <a href="http://all-free-download.com/free-website-templates/"><strong>ComplaintZilla</strong></a> &nbsp;&nbsp;&nbsp;
  <a href="http://all-free-download.com/free-website-templates/"><strong>IT Tracker</strong></a> &nbsp;&nbsp; &nbsp;
  <a href="http://all-free-download.com/free-website-templates/"><strong>MIKI</strong></a> &nbsp;&nbsp; &nbsp;   
  <a href="http://all-free-download.com/free-website-templates/"><strong>DVP BOSS</strong></a> &nbsp;&nbsp;&nbsp;  
  <a href="http://all-free-download.com/free-website-templates/"><strong>ECN</strong></a> &nbsp;&nbsp; &nbsp;
  <a href="http://all-free-download.com/free-website-templates/"><strong>Get My Kaizen</strong></a> &nbsp;&nbsp;&nbsp;  
<%
if (session.getAttribute("uid") != null) { 
	int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
  
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		d_Id = rs_uname.getInt("Dept_Id");
		PreparedStatement ps_dept=con.prepareStatement("select * from user_tbl_dept where dept_id="+d_Id);
		ResultSet rs_dept=ps_dept.executeQuery();
		while(rs_dept.next())
		{
			department = rs_dept.getString("Department");
		} 
		uname=rs_uname.getString("U_Name"); 
	} 
%>    
  <a href="http://all-free-download.com/free-website-templates/"><strong>foundrymis</strong></a> &nbsp;&nbsp; &nbsp;
  <a href="Logout.jsp"><strong>LogOut (<%=uname %>)</strong></a>
   <%
	}   
   %>
  </div>
  <div style="height: 44px;">
<strong style="color: #BF240F;">MUTHA GROUP HEADLINES &#8680;</strong>
<marquee WIDTH="100%"  scrolldelay="180">
 <%
 PreparedStatement ps_head1 = con.prepareStatement("select  * from homepage_headlines_tbl where enable_id!=0 and  created_date=CURDATE()");
 ResultSet rs_head1 = ps_head1.executeQuery();
 while(rs_head1.next()){
 %>
 <b style="color: #437ED1;"><%=rs_head1.getString("headlines") %></b>  _ _     
 <%
 }
 %>
 </marquee>
 </div> 
  <div id="sidebar">
  <div style="background-color:#B6CBDB;background-repeat: repeat-x;height: 30px;">
 <strong>&nbsp;&nbsp;Today's Birthday  &#8680;</strong> <br/> 
 <hr />
</div> 
<div style="height: 150px;overflow: scroll;width: 194px;"> 
 <div style="font-size: 13px;">
 <strong>Mr. Vijay B. Main</strong><br/>
 Mutha Engineering Pvt. Ltd.<br/>
 (10/10/1985)
 </div>
 <hr />
 <div style="font-size: 13px;">
 <strong>Mr. Vijay B. Main</strong><br/>
 Mutha Engineering Pvt. Ltd.<br/>
 (10/10/1985)
 </div>
 <hr />  
 </div>
  <br/> 
<%
if (session.getAttribute("uid") != null) {
%>
<div style="background-color:#B6CBDB;background-repeat: repeat-x;height: 30px;">
 <strong>&nbsp;&nbsp;Add Top Stories  &#8680;</strong> <br/> 
<hr />
</div> 
<br/>
<div align="left">
<a href="Add_Stories.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;">&#8680;  Add News</a> <br/><br/>
<a href="Add_Headlines.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;">&#8680; Add Headlines</a> <br/><br/>
</div>


	<%                
          }else if (session.getAttribute("uid") == null) { 
	%>
	<div style="background-color:#B6CBDB;background-repeat: repeat-x;height: 30px;">
 <strong>User Login  </strong> <br/> 
 <hr />
</div>
<form action="UserLogin_Controller" method="post">
 User Name  :<input  type="text" name="name" style="background-color: #EDF7EE;"/>
 Password : <input  type="password" name="password" style="background-color:  #EDF7EE;"/>
 <input  type="submit" value="Login" style="width: 100px;height: 30px;"/>
 </form>
 				<%
				if(request.getParameter("str")!=null){
				%>
				<strong style="color: red;"><%=request.getParameter("str") %></strong><br/>
				<strong style="color: #A3802C;"><%=request.getParameter("str1") %></strong><br/>
				<%	
				}
         			}
   				%>
 </div>
 <div style="text-align: center;">
 <hr />
 <strong style="font-family: Arial;font-size: 18px;color: #10006E;">MUTHA GROUP ITEM DICTIONARY</strong><br/>
 <hr />
 </div>
 <div id="main" style="overflow: scroll;">
 <form action="Add_HeadlinesController" method="post" id="add_str" name="add_str" onsubmit="return validate_HeadForm(this);"> 
 <table border="0" style="font-family: Arial;"> 
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Headline :</strong> </td>
				<td>
				<input  type="text"/>
				</td>
			</tr> 
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Heading :</strong> </td>
				<td>
				<input  type="text"/>
				</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>In Details :</strong> </td>
				<td>
				<input  type="text"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input  type="submit" name="submit" value="Submit" style="font-family: Arial;background-color: #EDF7EE;text-shadow:black; width: 200px;height: 30px;"/>
				</td>
			</tr>
		</table>
		</form>
		<div> 
		<table border="0" style="font-family: Arial;" class="tftable">
			<tr style="background-color: #acc8cc;text-align: center;">
				<td >Your Messages </td>
				<td>
				Date
				</td>
				<td>
				Delete
				</td>
			</tr>
			<%
			PreparedStatement ps_head = con.prepareStatement("select * from homepage_headlines_tbl where enable_id!=0 and created_by="+Integer.parseInt(session.getAttribute("uid").toString()) + " order by created_date");
			ResultSet rs_head = ps_head.executeQuery();
			while(rs_head.next()){
			%>
			<tr>
				<td><%=rs_head.getString("headlines") %></td>
				<td><%=rs_head.getDate("created_date") %></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="delete_msg(<%=rs_head.getInt("homepage_headlines_id")%>)" style="cursor: pointer;" value="Delete"/></td>
			</tr>
			<%
			}
			%>
		</table>		
		<span id="delmsg"></span>
		</div>
</div> 
</div>
<div id="footer" style="width: 900px; margin: 0 auto; background: #FFFFFF;">
<a href="http://www.muthagroup.com/"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp; 
<strong>Mail to :</strong>&nbsp;
<a href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top" style="color: blue;">itsupports@muthagroup.com</a> &nbsp; | &nbsp;
Date :&nbsp;<strong><%=sdf.format(date) %></strong> 
</div>
</div>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>