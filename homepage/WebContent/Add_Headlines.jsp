<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Calendar"%>
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
<style>
.dropbtn {
    background-color: black;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
	font-family: Arial; 
    position: absolute;
    background-color: #3b7687;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: black;}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: black;
}
</style>
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
	window.location.reload();
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
<script type="text/javascript" src="js/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="css/highslide.css" />

<script type="text/javascript">
	hs.graphicsDir = 'graphics/';
	hs.outlineType = null;
	hs.wrapperClassName = 'colored-border';
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
  <a href="homepage.jsp">&nbsp; &nbsp;&nbsp;<strong>Home</strong>&nbsp; &nbsp;&nbsp;</a>   
<div class="dropdown" style="cursor: pointer;">
  <strong style="color: white;font-size: 13px"><a href="http://192.168.0.6/companyunits.htm">ERP Login</a></strong>
  <div class="dropdown-content">
    <a href="http://192.168.0.6/meplbwayserp/">MEPL H21</a>
    <a href="http://192.168.0.6/H25bwayserp/">MEPL H25</a>
    <a href="http://192.168.0.6/K1BWAYSERP/">MEPL UNIT III</a>
    <a href="http://192.168.0.6/UNITIVBWAYSERP/">MEPL UNIT IV</a>
    <a href="http://192.168.0.6/MFPLBWAYSERP/">MFPL</a>
    <a href="http://192.168.0.6/DIBWAYSERP">DI</a>
    
    <a href="http://192.168.0.6/ENGH25CONSOLIDATION/">H21 & H25 CON</a>
    <a href="http://192.168.0.6/UNIT123CONSOLIDATION/">H21,H25 & Unit III CON</a>
    <a href="http://192.168.0.6/MUTHACONSOLIDATION/">ALL CON</a>
  </div>
</div>
  <a href="http://192.168.0.7/ComplaintZilla/">&nbsp; &nbsp;&nbsp;<strong>ComplaintZilla</strong>&nbsp;&nbsp;&nbsp;</a>  
  <a href="http://192.168.0.7/ittracker/">&nbsp; &nbsp;&nbsp;<strong>IT Tracker</strong>&nbsp;&nbsp;&nbsp;</a>  
  <a href="http://192.168.0.7:8080/">&nbsp; &nbsp;&nbsp;<strong>MIKI</strong>&nbsp;&nbsp; &nbsp;</a> 
  <a href="http://192.168.0.7/dvpboss/">&nbsp; &nbsp;&nbsp;<strong>DVP BOSS</strong> &nbsp;&nbsp;&nbsp;</a> 
  <a href="http://192.168.0.7/ECN/">&nbsp; &nbsp;&nbsp;<strong>ECN</strong> &nbsp;&nbsp;&nbsp;</a><!-- 
  <a href="http://192.168.0.7/dictionary/">&nbsp; &nbsp;&nbsp;<strong>Item Dictionary</strong> &nbsp;&nbsp;&nbsp;</a> --> 
  <a href="http://192.168.0.7/foundrymis/">&nbsp; &nbsp;&nbsp;<strong>Foundry MIS</strong>&nbsp;&nbsp; &nbsp;</a>
  <a href="http://192.168.0.7/dailyreports/">&nbsp; &nbsp;&nbsp;<strong>Daily Reports</strong>&nbsp;&nbsp; &nbsp;</a>  
  <a href="http://www.getmykaizen.com/">&nbsp; &nbsp;&nbsp;<strong>GetMyKaizen</strong> &nbsp;&nbsp;&nbsp;</a>  
 <div class="dropdown" style="cursor: pointer;">
 <strong style="color: white;font-size: 13px">Portal</strong>
 <div class="dropdown-content">
    <a href="https://srm.inservices.tatamotors.com/irj/portal">Tata Motors</a>
    <a href="http://its.forcemotors.com/sap/its/homepages/vis/default.html">Force Motors</a>
    <a href="http://www.mantrucksindia.com/login/">MAN Trucks</a>
    <a href="https://tradewithtvs.com/Login.aspx">TVS</a>
    <a href="https://mptax.mp.gov.in/mpvatweb/index.jsp">Road Permit MP</a>
    <a href="http://yorkebiz.com/ebp/">York</a>
 </div>
 </div> 
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
  &nbsp;&nbsp;&nbsp;<a href="Logout.jsp"><strong>LogOut (<%=uname %>)</strong></a>
   <%
	}   
   %>
  </div>
  <div style="height: 25px;"> 
<marquee WIDTH="100%"  scrolldelay="100">
 <%
 PreparedStatement ps_head1 = con.prepareStatement("select  * from homepage_headlines_tbl where enable_id!=0 and  created_date=CURDATE()");
 ResultSet rs_head1 = ps_head1.executeQuery();
 while(rs_head1.next()){
 %>
 <b style="color: #B04525;font-family: Arial;font-size: 16px;"><%=rs_head1.getString("headlines") %></b>  _ _     
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
<div style="height: 200px;width: 245px;"> 

 <%
 Calendar cal = Calendar.getInstance(); 
 String month =  String.valueOf(cal.get(Calendar.MONTH) + 1);
 String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
 
 SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
 
 if(month.length()==1){
	 month = "0" + month;
 }
if(day.length()==1){
	 day = "0" + day;
 }
 String checkBDate = day+month;
 String dept="";
 PreparedStatement p_bday = con.prepareStatement("select * from user_tbl where Bdays='"+checkBDate+"' and Enable_id=1");
 ResultSet r_bday = p_bday.executeQuery();
 
 %>
 <marquee direction="up" scrollamount="3">
 <% 
 while(r_bday.next()){
	 if(r_bday.getString("user_photoName")!=null){
			%>
		<img src="bday_photo.jsp?field=<%=r_bday.getInt("U_Id")%>" alt="No Image" title="Click to enlarge"  height="70" width="70" onclick="return hs.expand(this)"  style="cursor:pointer"/><br/>	 
			<%
			 } 
			 
	 PreparedStatement p_dept = con.prepareStatement("select * from user_tbl_dept where dept_id="+r_bday.getInt("dept_id"));
	 ResultSet r_dept = p_dept.executeQuery();
	 while(r_dept.next()){
		 dept = r_dept.getString("Department");
	 }
	 PreparedStatement p_cp = con.prepareStatement("select * from user_tbl_company where Company_Id="+r_bday.getInt("Company_Id"));
	 ResultSet r_cp = p_cp.executeQuery();
	 while(r_cp.next()){	 
 %>
 <div style="font-size: 13px;">
 <strong>Mr. <%=r_bday.getString("U_Name") %></strong><br/>
 <%=r_cp.getString("Company_Name") %>&nbsp;&#8594;&nbsp;<%=dept %><br/>
 
 </div>
 <hr /> 
 <%
 }
 }
 %> 
   </marquee>
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
 <strong style="font-family: Arial;font-size: 18px;color: #10006E;">MUTHA GROUP HEADLINES</strong><br/>
 <hr />
 </div>
 <div id="main" style="overflow: scroll;">
 <form action="Add_HeadlinesController" method="post" id="add_str" name="add_str" onsubmit="return validate_HeadForm(this);"> 
 <table border="0" style="font-family: Arial;"> 
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Headline :</strong> </td>
				<td>
				<textarea rows="2" cols="60" style="background-color: #EDF7EE;" name="headline" id="headline"></textarea>
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
		<span id="headline_id"></span>
		<br/>
		<br/>
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
<a href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top" style="color: blue;">itsupports@muthagroup.com</a> &nbsp; | &nbsp;<a href="HelpLine.html" style="color: blue;">IT SUPPORT</a> &nbsp; | &nbsp;
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