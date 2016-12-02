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
<title>Add News</title>
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
<link rel="stylesheet" href="js/jquery-ui.css"></link>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script  type="text/javascript">
$(document).ready( 
		  function () { 
		    $( "#fromdate" ).datepicker({
		    	minDate: 0,
		      changeMonth: true,
		      changeYear: true 
		    });
		    $( "#todate" ).datepicker({
		    	minDate: 0,
			      changeMonth: true,
			      changeYear: true 
			    }); 
		  } 
		); 
</script> 
<script type="text/javascript" src="js/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="css/highslide.css" />

<script type="text/javascript">
	hs.graphicsDir = 'graphics/';
	hs.outlineType = null;
	hs.wrapperClassName = 'colored-border';
</script>
<script type="text/javascript">  
function load_image(ext)
{
   if(validateExtension(ext) == false)
   {
      alert("Please upload only jpg,jpeg or png files !!!"); 
      return false;
   }
}

function validateExtension(v)
{
      var allowedExtensions = new Array("jpg","JPG","jpeg","JPEG","png","PNG");
      for(var ct=0;ct<allowedExtensions.length;ct++)
      {
          sample = v.lastIndexOf(allowedExtensions[ct]);
          if(sample != -1){
        	  return true;
        	  }
      }
      return false;
}
</script>
<script type="text/javascript">
function validate_StoryForm(theForm) {
	// headings   details
	
	var headings = document.getElementById("headings");
	var details = document.getElementById("details");
	var fromdate = document.getElementById("fromdate");
	var todate = document.getElementById("todate");
	var priority = document.getElementById("priority");
	
		if (headings.value=="0" || headings.value==null || headings.value=="" || headings.value=="null") {
			alert("Please Provide heading !!!");  
			return false;
		}
		
		if (details.value=="0" || details.value==null || details.value=="" || details.value=="null") {
			alert("Please Provide Details !!!");  
			return false;
		}
		if (fromdate.value=="0" || fromdate.value==null || fromdate.value=="" || fromdate.value=="null") {
			alert("Please Provide visible from date !!!");  
			return false;
		}
		if (todate.value=="0" || todate.value==null || todate.value=="" || todate.value=="null") {
			alert("Please Provide visible to date !!!");  
			return false;
		}
		if (priority.value=="0" || priority.value==null || priority.value=="" || priority.value=="null") {
			alert("Please select Priority !!!");  
			return false;
		}
	
		if (theForm.dept.checked == false && theForm.group.checked == false && theForm.mepl_h21.checked == false &&
				theForm.mepl_h25.checked == false && theForm.mfpl.checked == false && theForm.unit3.checked == false  && theForm.di.checked == false) 
			{
			alert ('You didn\'t choose any of the Visible to checkboxes!');
				return false;
			} else { 	
				return true;
			} 
		return true;
}
</script>

</head>
<body>
<%
try{
String uname="",department="";
int d_Id=0;
Date date = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); 
String strDate = sdf.format(date); 
Connection con = Connection_Utility.getConnection();
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
<div class="dropdown" style="cursor: pointer;">&nbsp;&nbsp;
  <strong style="color: white;font-size: 13px"><a href="http://192.168.0.6/companyunits.htm">In-House Software's</a></strong>
  <div class="dropdown-content">
  <a href="http://192.168.0.7/ComplaintZilla/">&nbsp;&nbsp;<strong>ComplaintZilla</strong>&nbsp;</a>  
  <a href="http://192.168.0.7/ittracker/">&nbsp;&nbsp;<strong>IT Tracker</strong>&nbsp;</a>  
  <a href="http://192.168.0.7:8080/">&nbsp;&nbsp;<strong>MIKI</strong>&nbsp;</a> 
  <a href="http://192.168.0.7/dvpboss/">&nbsp;&nbsp;<strong>DVP BOSS</strong> &nbsp;</a> 
  <a href="http://192.168.0.7/ECN/">&nbsp;&nbsp;<strong>ECN</strong>&nbsp;</a>
  <a href="http://192.168.0.7/foundrymis/">&nbsp;&nbsp;<strong>Foundry MIS</strong>&nbsp;</a>
  <a href="http://192.168.0.7/dailyreports/">&nbsp;&nbsp;<strong>Daily Reports</strong>&nbsp;</a>
  <a href="http://192.168.0.7/muthaplanner/">&nbsp;&nbsp;<strong>Mutha Planner</strong>&nbsp;</a>  
  </div>
</div> 
 <div class="dropdown" style="cursor: pointer;">&nbsp;&nbsp;
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
 <a href="http://www.getmykaizen.com/">&nbsp;&nbsp;<strong>GetMyKaizen</strong> &nbsp;&nbsp;</a>  
 <div class="dropdown" style="cursor: pointer;">
  <strong style="color: white;font-size: 13px"><a href="HelpLine.html">Contact Us</a></strong>
  <div class="dropdown-content" style="font-family: Arial;font-size: 10px;">
    <a href="HelpLine.html">ERP (Nilesh Sarnaik -<b>9923399361</b> )</a>
    <a href="HelpLine.html">ERP (Amit Jadhav - <b>9923395915</b> )</a>
    <a href="HelpLine.html">Software (Vijay Main - <b>9923396823</b> )</a>
    <a href="HelpLine.html">Software (Uday Vedpathak - <b>9175004128</b> )</a>
    <a href="HelpLine.html">Hardware (Makarand Apsingkar - <b>9923396807</b> )</a> 
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
 PreparedStatement ps_head = con.prepareStatement("select  * from homepage_headlines_tbl where enable_id!=0 and  created_date=CURDATE()");
 ResultSet rs_head = ps_head.executeQuery();
 while(rs_head.next()){
 %>
 <b style="color: #B04525;font-family: Arial;font-size: 16px;"><%=rs_head.getString("headlines") %></b>  _ _     
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
 <strong style="font-family: Arial;font-size: 18px;color: #10006E;">MUTHA GROUP TOP STORIES</strong><br/>
 <hr />
 </div>
 <div id="main" style="overflow: scroll;">
 <form action="Add_StoriesController" method="post" id="add_str" name="add_str" onsubmit="return validate_StoryForm(this);" enctype="multipart/form-data"> 
 <table border="0" style="font-family: Arial;"> 
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Heading :</strong> </td>
				<td>
				<input type="text" name="headings" id="headings" style="background-color: #EDF7EE;width: 300px;" />
				</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>In Details :</strong> </td>
				<td>
				<textarea rows="5" cols="60" style="background-color: #EDF7EE;" name="details" id="details"></textarea>
				</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Visible to <br/>(Select Multiple):</strong> </td>
				<td>
	<input type="checkbox" name="group" style="font-family: Arial;font-size: 10px;" value="6"/> Group&nbsp;<b>|</b>
 	<input type="checkbox" name="dept" style="font-family: Arial;font-size: 10px;" value="<%=d_Id%>"/><%=department %>&nbsp;Dept &nbsp;<b>|</b><br/>  
 	<input type="checkbox" name="mepl_h21" style="font-family: Arial;font-size: 10px;" value="1"/>MEPL-H21&nbsp;<b>|</b>
 	<input type="checkbox" name="mepl_h25" style="font-family: Arial;font-size: 10px;" value="2"/>MEPL-H25&nbsp;<b>|</b> 
 	<input type="checkbox" name="mfpl" style="font-family: Arial;font-size: 10px;" value="3"/>MFPL&nbsp;<b>|</b>
 	<input type="checkbox" name="unit3" style="font-family: Arial;font-size: 10px;" value="4"/>MEPL-Unit III&nbsp;<b>|</b>  
 	<input type="checkbox" name="di" style="font-family: Arial;font-size: 10px;" value="5"/>DI</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Visible from :</strong> </td>
				<td>
				 	<input type="text" name="fromdate" id="fromdate" style="background-color: #EDF7EE;font-family: Arial;font-size: 12px;"/>
				</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Visible to :</strong> </td>
				<td>
 					<input type="text" name="todate" id="todate" style="background-color: #EDF7EE;font-family: Arial;font-size: 12px;"/>
				</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;"><b style="color: red;">*</b>Priority :</strong> </td>
				<td>
 					<select name="priority" id="priority" style="font-family: Arial;font-size: 14px;background-color: #EDF7EE;">
 					<option value="3">Low</option>
 					<option value="2">Medium</option>
 					<option value="1">High</option> 
 					</select>
				</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;">Attach Document<br/> (If Any) :</strong> </td>
				<td>
 					<input  type="file" name="doc" id="doc" size="60" style="font-family: Arial;background-color: #EDF7EE;"/>
				</td>
			</tr>
			<tr>
				<td><strong style="font-family: Arial;font-size: 12px;">Attach Photo (If Any)<br/>(.jpg and .png only) :</strong> </td>
				<td>
 					<input  type="file" name="photo" id="photo" size="60" style="font-family: Arial;background-color: #EDF7EE;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input  type="submit" name="submit" value="Submit" style="font-family: Arial;background-color: #EDF7EE;text-shadow:black; width: 200px;height: 30px;"/>
				</td>
			</tr>
		</table>
		</form>
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