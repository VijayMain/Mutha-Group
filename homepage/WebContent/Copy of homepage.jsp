<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/style.css"/>

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
		xmlhttp.open("POST", "Delete.jsp?story_id=" + str, true);
		xmlhttp.send();
		window.location.reload();
	} else {
		window.location.reload();
	}
	window.location.reload();
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
DateFormat formatter   = new SimpleDateFormat("dd/MM/yyyy"); 
DateFormat formatter2   = new SimpleDateFormat("yyyy-MM-dd"); 
String uname="",department="";
int d_Id=0,comp_id=0, uid =0;
Date date = new Date(); 
String strDate = formatter.format(date);  
String strDate2 = formatter2.format(date); 
String company = "";
ArrayList list_news = new ArrayList();
%> 
<div id="container">
    <div id="content"> 
  <div id="menu" style="font-size: 16px;font-family: Arial;">
  <a href="homepage.jsp">&nbsp; &nbsp;&nbsp;<strong>Home</strong>&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</a>   
  <a href="ERP_Login.jsp">&nbsp; &nbsp;&nbsp;<strong>ERP</strong> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</a>  
  <a href="http://192.168.0.7/ComplaintZilla/">&nbsp; &nbsp;&nbsp;<strong>ComplaintZilla</strong>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</a>  
  <a href="http://192.168.0.7/ittracker/">&nbsp; &nbsp;&nbsp;<strong>IT Tracker</strong>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</a>  
  <a href="http://192.168.0.7:8080/">&nbsp; &nbsp;&nbsp;<strong>MIKI</strong>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; </a> 
  <a href="http://192.168.0.7/dvpboss/">&nbsp; &nbsp;&nbsp;<strong>DVP BOSS</strong> &nbsp;&nbsp;&nbsp;  &nbsp; &nbsp;&nbsp;</a> 
  <a href="http://192.168.0.7/ECN/">&nbsp; &nbsp;&nbsp;<strong>ECN</strong> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</a>
  <a href="http://192.168.0.7/dictionary/">&nbsp; &nbsp;&nbsp;<strong>Item Dictionary</strong> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</a> 
  <a href="http://192.168.0.7/foundrymis/">&nbsp; &nbsp;&nbsp;<strong>Foundry MIS</strong>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</a>  
  <a href="http://www.getmykaizen.com/">&nbsp; &nbsp;&nbsp;<strong>Get My Kaizen</strong> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</a>   
<%
if (session.getAttribute("uid") != null) { 
	uid = Integer.parseInt(session.getAttribute("uid").toString()); 
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		d_Id = rs_uname.getInt("Dept_Id");
		comp_id = rs_uname.getInt("Company_Id");
		
		if(comp_id==1){
			company = "acc_h21";
		}
		if(comp_id==2){
			company = "acc_h25";	
		}
		if(comp_id==3){
			company = "acc_mfpl";
		}
		if(comp_id==4){
			company = "acc_unit3";
		}
		if(comp_id==5){
			company = "acc_di";
		} 
		
		PreparedStatement ps_dept=con.prepareStatement("select * from user_tbl_dept where dept_id="+d_Id);
		ResultSet rs_dept=ps_dept.executeQuery(); 
		while(rs_dept.next())
		{
			department = rs_dept.getString("Department");
		}
		uname=rs_uname.getString("U_Name"); 
	}
%> 
  <a href="Logout.jsp"><strong>LogOut (<%=uname %>)</strong></a>
   <%
	}
   %>
  </div>
  <div style="height: 25px;"> 
 <marquee WIDTH="100%"  scrolldelay="100">
 <%
 PreparedStatement ps_head = con.prepareStatement("select  * from homepage_headlines_tbl where enable_id!=0 and created_date=CURDATE()");
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
<div style="height: 100px;width: 245px;"> 
 
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
 <div style="font-size: 15px;font-family: Arial;">
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
  <br/> <br/> <br/> <br/> <br/> <br/> 
  
<div style="background-color:#B6CBDB;background-repeat: repeat-x;height: 30px;">
 <strong>&nbsp;&nbsp;Dashboard &#8680;</strong> <br/> 
<hr />
</div>
<br/>
  <div style="height: 100%;width: 245px;"> 	
 	<%
Calendar caldate = Calendar.getInstance();
 	caldate.set(Calendar.DATE, 1);
 	caldate.add(Calendar.DAY_OF_MONTH, -1);
Date lastDateOfPreviousMonth = caldate.getTime();
	caldate.set(Calendar.DATE, 1);
Date firstDateOfPreviousMonth = caldate.getTime();
 
%>
<table style="font-family: Arial;font-size: 12px;">
		<tr>
			<td colspan="2" align="center" style="color: #87364E;"><b>Software Usage from <%=new SimpleDateFormat("dd-MM-yyyy").format(firstDateOfPreviousMonth) %>
			</b></td>
		</tr>
		<tr align="left" style="color: blue;">
			<td><b>SOFTWARE</b></td>
			<td><b>USAGE</b></td>
		</tr>
		<tr>
			<%
			int cnt=0,cnt1=0;
			PreparedStatement ps_ecn = con.prepareStatement("SELECT count(*) FROM cr_tbl where  cr_date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW()");
			ResultSet rs_ecn = ps_ecn.executeQuery();
			while(rs_ecn.next()){
				cnt = rs_ecn.getInt("count(*)");
			}
			PreparedStatement ps_ecn1 = con.prepareStatement("SELECT count(*) FROM crc_tbl where  CRC_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW()");
			ResultSet rs_ecn1 = ps_ecn1.executeQuery();
			while(rs_ecn1.next()){
				cnt1 = rs_ecn1.getInt("count(*)");
			}
			int sum = cnt + cnt1;
			%>
			<td title="ECN Internal Requests = <%=cnt%> Customer Requests = <%=cnt1%>" style="cursor: pointer;">ECN</td>
			<td title="ECN Internal Requests = <%=cnt%> Customer Requests = <%=cnt1%>" style="cursor: pointer;"><b><%=sum %></b></td>
		</tr>
		<tr>
			
			<%
			int itpending=0,itinprogress=0,itclosed=0,itreopen=0,sumIT = 0;
			PreparedStatement pspending = con.prepareStatement("SELECT count(*) FROM it_user_requisition where  Req_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='Pending'");
			ResultSet rspending = pspending.executeQuery();
			while(rspending.next()){
				itpending = rspending.getInt("count(*)");
			}
			rspending.close();
			
			PreparedStatement psinprogress = con.prepareStatement("SELECT count(*) FROM it_user_requisition where  Req_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='In Progress'");
			ResultSet rsinprogress = psinprogress.executeQuery();
			while(rsinprogress.next()){
				itinprogress = rsinprogress.getInt("count(*)");
			}
			rsinprogress.close();
			
			PreparedStatement psclosed = con.prepareStatement("SELECT count(*) FROM it_user_requisition where  Req_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='Closed'");
			ResultSet rsclosed = psclosed.executeQuery();
			while(rsclosed.next()){
				itclosed = rsclosed.getInt("count(*)");
			}
			rsclosed.close();
			
			PreparedStatement psreopen = con.prepareStatement("SELECT count(*) FROM it_user_requisition where  Req_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='Reopen'");
			ResultSet rsreopen = psreopen.executeQuery();
			while(rsreopen.next()){
				itreopen = rsreopen.getInt("count(*)");
			} 
			rsreopen.close();
			
			PreparedStatement psITpending = con.prepareStatement("SELECT count(*) FROM it_requisition_remark_tbl where  Remark_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='Pending'");
			ResultSet rsITpending = psITpending.executeQuery();
			while(rsITpending.next()){
				itpending = itpending + rsITpending.getInt("count(*)");
			}
			rsITpending.close();
			
			PreparedStatement psITinprogress = con.prepareStatement("SELECT count(*) FROM it_requisition_remark_tbl where  Remark_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='In Progress'");
			ResultSet rsITinprogress = psITinprogress.executeQuery();
			while(rsITinprogress.next()){
				itinprogress = itinprogress + rsITinprogress.getInt("count(*)");
			}
			rsITinprogress.close();
			
			PreparedStatement psITclosed = con.prepareStatement("SELECT count(*) FROM it_requisition_remark_tbl where  Remark_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='Closed'");
			ResultSet rsITclosed = psITclosed.executeQuery();
			while(rsITclosed.next()){
				itclosed = itclosed + rsITclosed.getInt("count(*)");
			}
			rsITclosed.close();
			
			PreparedStatement psITreopen = con.prepareStatement("SELECT count(*) FROM it_requisition_remark_tbl where  Remark_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and status='Reopen'");
			ResultSet rsITreopen = psITreopen.executeQuery();
			while(rsITreopen.next()){
				itreopen = itreopen + rsITreopen.getInt("count(*)");
			}			
			rsITreopen.close();
			
			sumIT = itpending + itinprogress + itclosed + itreopen;
			%>
			<td title="IT Tracker Pending =<%=itpending%> InProgress =<%=itinprogress%> Closed =<%=itclosed%> Re-Opened =<%=itreopen%>" style="cursor: pointer;">IT Tracker</td>
			<td title="IT Tracker Pending =<%=itpending%> InProgress =<%=itinprogress%> Closed =<%=itclosed%> Re-Opened =<%=itreopen%>" style="cursor: pointer;"><b><%=sumIT %></b></td>
		</tr>
		<tr>
		<%
		int newcz=0,opencz=0,resolved=0,reopen=0,closed=0,actionPerformed=0,sumcz=0;
		
		PreparedStatement psCZ = con.prepareStatement("SELECT count(*) FROM complaint_tbl where  Complaint_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and Status_Id=1");
		ResultSet rsCZ = psCZ.executeQuery();
		while(rsCZ.next()){
			newcz = rsCZ.getInt("count(*)");
		}
		rsCZ.close();
		
		PreparedStatement psCZopen = con.prepareStatement("SELECT count(*) FROM complaint_tbl where  Complaint_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and Status_Id=2");
		ResultSet rsCZopen = psCZopen.executeQuery();
		while(rsCZopen.next()){
			opencz = rsCZopen.getInt("count(*)");
		}
		rsCZopen.close();
		
		PreparedStatement psCZresolved = con.prepareStatement("SELECT count(*) FROM complaint_tbl where  Complaint_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and Status_Id=3");
		ResultSet rsCZresolved = psCZresolved.executeQuery();
		while(rsCZresolved.next()){
			resolved = rsCZresolved.getInt("count(*)");
		}
		rsCZresolved.close();
		
		PreparedStatement psCZreopen = con.prepareStatement("SELECT count(*) FROM complaint_tbl where  Complaint_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and Status_Id=4");
		ResultSet rsCZreopen = psCZreopen.executeQuery();
		while(rsCZreopen.next()){
			reopen = rsCZreopen.getInt("count(*)");
		}
		rsCZreopen.close();
		
		PreparedStatement psCZclosed = con.prepareStatement("SELECT count(*) FROM complaint_tbl where  Complaint_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW() and Status_Id=5");
		ResultSet rsCZclosed = psCZclosed.executeQuery();
		while(rsCZclosed.next()){
			closed = rsCZclosed.getInt("count(*)");
		}
		rsCZclosed.close();
		
		PreparedStatement psCZaction = con.prepareStatement("SELECT count(*) FROM complaint_tbl_action where  Action_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW()");
		ResultSet rsCZaction = psCZaction.executeQuery();
		while(rsCZaction.next()){
			actionPerformed = rsCZaction.getInt("count(*)");
		}
		rsCZaction.close();
		
		sumcz= newcz + opencz + resolved + reopen + closed + actionPerformed; 
		
		%>				
			<td title="ComplaintZilla new=<%=newcz%> open=<%=opencz%> resolved=<%=resolved%> reopen=<%=reopen%> closed=<%=closed%> actionPerformed=<%=actionPerformed %>" style="cursor: pointer;">ComplaintZilla</td> 
			<td title="ComplaintZilla new=<%=newcz%> open=<%=opencz%> resolved=<%=resolved%> reopen=<%=reopen%> closed=<%=closed%> actionPerformed=<%=actionPerformed %>" style="cursor: pointer;"><b><%=sumcz %></b></td>
		</tr>
		<tr>
		<%
		int newSHeet=0; 
		PreparedStatement psdvpsheet = con.prepareStatement("SELECT count(*) FROM dev_basicinfo_tbl where  Created_Date BETWEEN date_sub(now(),INTERVAL 30 DAY) AND NOW()");
		ResultSet rsdvpsheet = psdvpsheet.executeQuery();
		while(rsdvpsheet.next()){
			newSHeet = rsdvpsheet.getInt("count(*)");
		}
		rsdvpsheet.close();
		%>
			<td title="DVP Boss New Sheet =<%=newSHeet%>" style="cursor: pointer;">DVP BOSS</td>
			<td title="DVP Boss New Sheet =<%=newSHeet%>" style="cursor: pointer;"><b><%=newSHeet %></b></td>  
		</tr>
		</table>
 	
  </div>
  <br/>
<%
if (session.getAttribute("uid") != null) {
%>
<div style="background-color:#B6CBDB;background-repeat: repeat-x;height: 30px;">
 <strong>&nbsp;&nbsp;Select  &#8680;</strong> <br/> 
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
<table>
<tr>
<td>Login_Name</td>
<td>:</td>
<td><input  type="text" name="name" style="background-color: #EDF7EE;"/></td>
</tr>
<tr>
<td>Password</td>
<td>:</td>
<td><input  type="password" name="password" style="background-color:  #EDF7EE;"/></td>
</tr>
<tr>
<td colspan="3" align="center"><input  type="submit" value="Login" style="width: 100px;height: 30px;"/></td>
</tr>
</table> 
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
 <strong style="font-family: Arial;font-size: 15px;color: #10006E;">MUTHA GROUP TOP STORIES</strong><br/>
 <hr />
 </div>
  <div id="main" style="overflow: scroll;">
  
  <%  
  String fromdate="",todate="";
  
  PreparedStatement ps_news = con.prepareStatement("select * from  homepage_stories_tbl   where enable_id=1");
  ResultSet rs_news = ps_news.executeQuery();
  while(rs_news.next()){
	  fromdate = formatter.format(rs_news.getDate("visible_fromdate"));
	  todate = formatter.format(rs_news.getDate("visible_todate")); 
	  
  List<Date> dates = new ArrayList<Date>(); 
  Date  startDate = (Date)formatter.parse(fromdate); 
  Date  endDate = (Date)formatter.parse(todate);
  long interval = 24*1000 * 60 * 60; // 1 hour in millis
  long endTime =endDate.getTime() ; // create your endtime here, possibly using Calendar or Date
  long curTime = startDate.getTime();
  while (curTime <= endTime) {
      dates.add(new Date(curTime));
      curTime += interval;
  } 
  
  for(int i=0;i<dates.size();i++){
      Date lDate =(Date)dates.get(i);
      String ds = formatter.format(lDate); 
      if(ds.equalsIgnoreCase(strDate)){ 
    	  list_news.add(rs_news.getInt("homepage_stories_id"));
      }
    }
  }
  ps_news.close();
  rs_news.close();  
    
  for(int j=0;j<list_news.size();j++){
	if(session.getAttribute("uid")==null){
	 
		 PreparedStatement ps_disnews = con.prepareStatement("select * from homepage_stories_tbl where enable_id=1 and homepage_stories_id="+Integer.parseInt(list_news.get(j).toString()) +" and  acc_all=6");
		  ResultSet rs_disnews=ps_disnews.executeQuery();
		  while(rs_disnews.next()){ 
		  %> 
		    <b style="font-family: Arial;font-size: 14px;"><%=rs_disnews.getString("heading") %> &#8680; </b><br/>
		    <% 
		    if(!rs_disnews.getString("photo_filename").equalsIgnoreCase("")){
			    %>
			  <img src="View_photo.jsp?field=<%=rs_disnews.getInt("homepage_stories_id")%>" alt="No Image" title="Click to enlarge"  height="70" width="70" onclick="return hs.expand(this)"  style="cursor:pointer"/><br/>
			    <%
			        	}
		    if(!rs_disnews.getString("doc_filename").equalsIgnoreCase("")){
		    %>
		    <b style="color: #19750D;">Files Attached &#8658;</b><a href="Display_File.jsp?field=<%=rs_disnews.getInt("homepage_stories_id")%>"><%=rs_disnews.getString("doc_filename")%></a><br/>
		    <%
		    }
		    %>
	<span style="font-family: Arial;font-size: 12px;"><%=rs_disnews.getString("details") %></span><br/>
	<%
	PreparedStatement ps_created = con.prepareStatement("select * from user_tbl where u_id="+rs_disnews.getInt("created_by"));
	ResultSet rs_crested = ps_created.executeQuery();
	while(rs_crested.next()){
		PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_crested.getInt("Company_Id"));
		ResultSet rs_comp = ps_comp.executeQuery();
		while(rs_comp.next()){
	%>
	<br/><span style="font-family: Arial;font-size: 9px;background-color: #EDF7EE;">By  <%=rs_crested.getString("u_name") %>&nbsp;(<%=rs_comp.getString("Company_Name") %>)</span>
	    <% 
		}
	}
	%>
	
	<hr />
  <% 
  }
	}
  }
  
  for(int j=0;j<list_news.size();j++){
		if(session.getAttribute("uid")!=null){
		 
			 PreparedStatement ps_disnews = con.prepareStatement("select * from homepage_stories_tbl where enable_id=1 and homepage_stories_id="+Integer.parseInt(list_news.get(j).toString()));
			  ResultSet rs_disnews=ps_disnews.executeQuery();
			  while(rs_disnews.next()){
				  if(rs_disnews.getInt("acc_all")==6 || rs_disnews.getInt("acc_dept")==d_Id  || comp_id == rs_disnews.getInt(company) || rs_disnews.getInt("created_by")== Integer.parseInt(session.getAttribute("uid").toString())){		  
			  %> 
			    <b style="font-family: Arial;font-size: 14px;"><%=rs_disnews.getString("heading") %> &#8680; </b><br/>
			    <% 
			    if(!rs_disnews.getString("photo_filename").equalsIgnoreCase("")){
				    %>
				  <img src="View_photo.jsp?field=<%=rs_disnews.getInt("homepage_stories_id")%>" alt="No Image" title="Click to enlarge"  height="70" width="70" onclick="return hs.expand(this)"  style="cursor:pointer"/><br/>
				    <%
				        	}
			    if(!rs_disnews.getString("doc_filename").equalsIgnoreCase("")){
			    %>
			    <b style="color: #19750D;">Files Attached &#8658; </b><a href="Display_File.jsp?field=<%=rs_disnews.getInt("homepage_stories_id")%>"><%=rs_disnews.getString("doc_filename")%></a><br/>
			    <%
			    }
			    %>
		<span style="font-family: Arial;font-size: 12px;"><%=rs_disnews.getString("details") %></span><br/>
		<%
	PreparedStatement ps_created = con.prepareStatement("select * from user_tbl where u_id="+rs_disnews.getInt("created_by"));
	ResultSet rs_crested = ps_created.executeQuery();
	while(rs_crested.next()){
		PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_crested.getInt("Company_Id"));
		ResultSet rs_comp = ps_comp.executeQuery();
		while(rs_comp.next()){
	%>
	<br/><span style="font-family: Arial;font-size: 9px;background-color: #EDF7EE;">By  <%=rs_crested.getString("u_name") %>&nbsp;(<%=rs_comp.getString("Company_Name") %>)</span>
	    <% 
	    if(rs_disnews.getInt("created_by")==uid){
		    %>
		    &nbsp;&nbsp;&nbsp;<input type="button" onclick="delete_msg(<%=Integer.parseInt(list_news.get(j).toString()) %>)" style="cursor: pointer;font-family: Arial;font-size: 10px;" value="Delete" /><br/>
		    <%
		    } 
		}
	}
	%>
		
		<hr />
	  <% 
	  
	  }
			  }
		}
	  }
  
  
  
  %>  
  <span id="delmsg"></span>
 </div> 
</div>
<div id="footer" style="width: 900px; margin: 0 auto; background: #FFFFFF;">
<a href="http://www.muthagroup.com/"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp; 
<strong>Mail to :</strong>&nbsp;
<a href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top" style="color: blue;">itsupports@muthagroup.com</a>&nbsp; | &nbsp;<a href="HelpLine.html" style="color: blue;">IT SUPPORT</a> &nbsp; | &nbsp;
Date :&nbsp;<strong><%=formatter.format(date) %></strong> 
</div>
</div>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>