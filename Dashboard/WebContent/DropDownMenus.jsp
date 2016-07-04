<%@page import="java.util.ArrayList"%>
<%@page import="com.muthahrms.conModel.MyConnection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<html>
<head>  
<script type="text/javascript"> 
	window.onerror = function() {
		return true;
	};
</script>  
<style type="text/css"> 
			.TableLarge td{
				border-style: solid;
                border-width: 1px; 
                border-color: #CAE3EF; 
                padding: 1px;
                white-space: nowrap;
                font-family: Arial;
                font-size: 11px;
			} 

			.TableLarge th{
                border-style: solid;
                border-width: 1px; 
                border-color: #CAE3EF; 
                padding: 1px;
                white-space: nowrap;
                font-family: Arial;
                font-size: 12px;
            }

            .TableLarge{
                border-style: none;
                font-family:Arial;
                border-collapse: collapse;
            }

            #padding_for_test{
                height: 3000px;
                width: 9000px;
            }
</style>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<script src="js/accordian.js"></script>  
<script src="js/freez.js"></script> 
  <script>
  $(function() {
    $( "#tabs" ).tabs();
  }); 
</script> 
<link rel="stylesheet" type="text/css" href="css/formStyle.css"> 
<link rel="stylesheet" type="text/css" href="css/menu.css"/> 
<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
}
function ChangeColorred(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#FFFFFF';
	} else {
		tableRow.style.backgroundColor = '#7be18a';
	}
}

function button1(val,val1) { 
	/* alert("Alert the call = " + val + "  = = = " + val1); */
	window.location="Display_UserInfo.jsp?base_code="+val+"&company="+val1;
}
</script>  

<title>HOME</title> 
</head>
<body>  
<%
	Connection con = null;
		try{
		con =  MyConnection.getHRMSConnection();
		int uid=0;
		int comp = 0,admin=0,compview=0;
		String u_name = "------";
		if(session.getAttribute("uid")!=null){
			uid = Integer.parseInt(session.getAttribute("uid").toString());
			PreparedStatement ps_comp = con.prepareStatement("select * from USER_BASE where CODE="+uid);
			ResultSet rs_comp = ps_comp.executeQuery();
			while(rs_comp.next()){
			 	compview = rs_comp.getInt("COMPANY");
				u_name = rs_comp.getString("NAME");
				admin = rs_comp.getInt("USER_ACC");
				session.setAttribute("u_name", rs_comp.getString("NAME"));
			}
		}
		// System.out.println("comp = " + compview + "Admin = " + admin);
	%>
<!-- ************************************ Header ***************************************** -->
<script type="text/javascript">
<%
if(u_name.equalsIgnoreCase("------")){
%>
alert("Your Session is timed out, Kindly login again.....Thank You.");
window.location="Logout.jsp";
<%
}
%>
</script>
<!-- ****************************************************************************************** -->
	<div id="container" style="height: 600px;">
<!-- ************************************ Side bar ********************************************* -->
 <%
  	int year = Calendar.getInstance().get(Calendar.YEAR);
  	int year_upto = year-5;
  	comp=0;
  %>
<ul>
  <li><a class="active" href="Home.jsp">HOME</a></li>
  <li><a href="Dash.jsp">Dashboard</a></li>
  <li><a href="Sal_Review.jsp">Salary Review</a></li>
  <li><a href="Manage_users.jsp">Manage Users</a></li>
  <li><a href="Reports_Hub.jsp">Reports</a></li>
  <ul style="float:right;list-style-type:none;">
   	<li>
 		<a href="HR_Home.jsp" style="color: white;text-decoration: none;">Setting</a>   
    </li>
    <li><a href="Logout.jsp"><span style="color: #ecf0f1;font-family: Arial;font-size: 14px;">Logout (<%= u_name%>)</span></a></li>
  </ul>
</ul>
<div id="tabs">
  <ul>
  <%
  if(compview==1 || compview==2 || admin>=2){
  %>
    <li><a href="#tabs-1">&nbsp;&nbsp;MEPL H21&nbsp;&nbsp;</a></li>
    <li><a href="#tabs-2">&nbsp;&nbsp;MEPL H25&nbsp;&nbsp;</a></li>
  <%
  }
  if(compview==3 || admin>=2){
  %>   
    <li><a href="#tabs-3">&nbsp;&nbsp;MFPL&nbsp;&nbsp;</a></li>
  <%
  }
  if(compview==4 || admin>=2){
  %>   
    <li><a href="#tabs-4">&nbsp;&nbsp;DI&nbsp;&nbsp;</a></li>
  <%
  }
  if(compview==5 || admin>=2){
  %>   
    <li><a href="#tabs-5">&nbsp;&nbsp;MEPL UNIT III&nbsp;&nbsp;</a></li>
  <%
  }
  %>   
  </ul>
<%
int flag=0,cntr_rs=0;
boolean trans_flag=false;
ArrayList ind_bur = new ArrayList(); 
PreparedStatement ps_indrel = null,ps_rating=null,ps_present = null;
ResultSet rs_indrel = null,rs_rating=null,rs_present=null;
int base_id = 0;
PreparedStatement ps_21 = null;
ResultSet rs_21 = null;
%>  
<!-------------------------------------------------------------------------------------------------------------------------------->
												<!-- Company = 1 -->
<!-------------------------------------------------------------------------------------------------------------------------------->
<%
if(compview==1 || compview==2 || admin>=2){
%> 
<div id="tabs-1" style="height: 530px;">
  	
 <div style="height: 500px; overflow: scroll">
<table class="TableLarge" id="mySpecialHugeTable"> 
  <tr align="center">
    <th><strong style="font-size: 12px;">&nbsp;&nbsp;T. No.&nbsp;&nbsp;</strong></th>
    <th><strong>Name</strong></th>
    <!-- <th><strong>Education</strong></th> -->
    <th><strong>Department</strong></th>
    <th><strong>Designation</strong></th>
    <th><strong>Grade</strong></th>
    <!-- <th><strong>Birth Date </strong></th> -->
    <th><strong>Exp</strong></th>
    <!-- <th><strong>Joining Date in Group</strong></th> -->
    <th><strong>Joining Date</strong></th>
    <th><strong>Current Gross</strong></th> 
    <th><strong>Total CTC PM</strong></th>
    <th><strong>Employee Left ?</strong></th>
  </tr>
  <% 
  comp = 1; 
  ps_21 = con.prepareStatement("select * from BASE_STRUCTURE where COMPANY="+comp +" order by EMPLOYEE_LEFT");
  rs_21 = ps_21.executeQuery();
  while(rs_21.next()){
	  
	  if(rs_21.getString("EMP_STATUS").equalsIgnoreCase("TRAINEE")){
		 trans_flag = true;
	  }
	  
	  base_id = rs_21.getInt("CODE");
		   
	if(trans_flag==true){
  %>
  <tr align="center" title="TRAINEE EMPLOYEE" onmouseover="ChangeColorred(this, true);" onmouseout="ChangeColorred(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;background-color: #7be18a;">
  <%
	}else{
  %>
  <tr align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;">
  <%
	}
  %>
	<td style="font-size: 12px;"><%= rs_21.getString("T_NO")%></td>
	<td align="left"><strong><%= rs_21.getString("NAME")%></strong></td>
	<%-- <td align="left"><%= rs_21.getString("EDUCATION")%></td> --%>
	<td align="left"><%= rs_21.getString("DEPARTMENT")%></td>
	<td align="left"><%=	rs_21.getString("DESIGNATION")%></td>
	<td align="center"><%=	rs_21.getString("GRADE")%></td>
	<%-- <td align="left"><%=	rs_21.getString("BIRTHDATE")%></td> --%>
	<td align="right"><%=	rs_21.getString("TOT_EXP")%></td>
	<%-- <td align="left"><%=	rs_21.getString("JOINING_INGROUP")%></td> --%>
	<td align="left"><%=	rs_21.getString("JOINING_DATE")%></td> 
	<td align="right"><%=	rs_21.getString("CURRENT_GROSS")%></td>
    <td align="right"><%=rs_21.getString("CTC_PM") %></td>
    <%
    if(rs_21.getString("EMPLOYEE_LEFT").equalsIgnoreCase("NO")){
    %>
    <td  align="center"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%
    }else{
    %>
    <td  align="center" style="background-color : red;font-weight: bold;color: white;"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%	
    }
    %> 
  </tr>
  <%
  ind_bur.clear();
  trans_flag = false;
  }
  %>
</table>
</div>
  <script type="text/javascript">
  	table_make_fixed_header(document.getElementById("mySpecialHugeTable"), /*bHorizontal*/ true, /*bVertical*/ true, 1000, /*bWrappedByScrollableDiv*/ true);
  </script>
 
</div>  
<!-------------------------------------------------------------------------------------------------------------------------------->
												<!-- Company = 2 -->
<!-------------------------------------------------------------------------------------------------------------------------------->
 <div id="tabs-2" style="height: 530px;">
  	
 <div style="height: 500px; overflow: scroll">
<table class="TableLarge" id="mySpecialHugeTableH25">
  <!-- <tr align="center">
    <th colspan="10"><strong>BASIC INFORMATION</strong></th>
    <th colspan="16"><strong>SALARY STRUCTURE</strong></th>
    <th colspan="10"><strong>LAST 5 YEARS INCREMENTS</strong></th>
    <th colspan="7"><strong>CURRENT INCREMENTS</strong></th>
  </tr> -->
  <tr align="center">
    <th><strong style="font-size: 12px;">&nbsp;&nbsp;T. No.&nbsp;&nbsp;</strong></th>
    <th><strong>Name</strong></th>
    <!-- <th><strong>Education</strong></th> -->
    <th><strong>Department</strong></th>
    <th><strong>Designation</strong></th>
    <th><strong>Grade</strong></th>
    <!-- <th><strong>Birth Date </strong></th> -->
    <th><strong>Exp</strong></th>
    <!-- <th><strong>Joining Date in Group</strong></th> -->
    <th><strong>Joining Date</strong></th>
    <th><strong>Current Gross</strong></th> 
    <th><strong>Total CTC PM</strong></th>  
    <th><strong>Employee Left ?</strong></th>
  </tr>
  <%
  comp = 2;
  ind_bur.clear(); 
  ps_indrel = null;ps_rating=null;ps_present = null;
  rs_indrel = null;rs_rating=null;rs_present=null;
  base_id = 0;
  ps_21 = con.prepareStatement("select * from BASE_STRUCTURE where COMPANY="+comp+" order by EMPLOYEE_LEFT");
  rs_21 = ps_21.executeQuery();
  while(rs_21.next()){
	  if(rs_21.getString("EMP_STATUS").equalsIgnoreCase("TRAINEE")){
		 trans_flag = true;
	  }
	  base_id = rs_21.getInt("CODE");
		  if(trans_flag==true){
			  %>
			  <tr align="center" title="TRAINEE EMPLOYEE" onmouseover="ChangeColorred(this, true);" onmouseout="ChangeColorred(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;background-color: #7be18a;">
			  <%
				}else{
			  %>
			  <tr align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;">
			  <%
				}
			  %> 
	<td style="font-size: 12px;"><%=rs_21.getString("T_NO")%></td>
	<td align="left"><strong><%=	rs_21.getString("NAME")%></strong></td>
	<%-- <td align="left"><%=	rs_21.getString("EDUCATION")%></td> --%>
	<td align="left"><%=	rs_21.getString("DEPARTMENT")%></td>
	<td align="left"><%=	rs_21.getString("DESIGNATION")%></td>
	<td align="center"><%=	rs_21.getString("GRADE")%></td>
	<%-- <td align="left"><%=	rs_21.getString("BIRTHDATE")%></td> --%>
	<td align="right"><%=	rs_21.getString("TOT_EXP")%></td>
	<%-- <td align="left"><%=	rs_21.getString("JOINING_INGROUP")%></td> --%>
	<td align="left"><%=	rs_21.getString("JOINING_DATE")%></td> 
	<td align="right"><%=	rs_21.getString("CURRENT_GROSS")%></td> 
    <td align="right"><%=rs_21.getString("CTC_PM") %></td>
    
    
    <%
    if(rs_21.getString("EMPLOYEE_LEFT").equalsIgnoreCase("NO")){
    %>
    <td  align="center"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%
    }else{
    %>
    <td  align="center" style="background-color : red;font-weight: bold;color: white;"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%	
    }
    %>
    
     
  </tr>
  
  <%
  ind_bur.clear(); 
  trans_flag=false;
  }
  %>
</table>
</div>
  <script type="text/javascript">
  table_make_fixed_headerh25(document.getElementById("mySpecialHugeTableH25"), /*bHorizontal*/ true, /*bVertical*/ true, 1000, /*bWrappedByScrollableDiv*/ true);
  </script>
 
</div> 
<%
}
%>
<!-------------------------------------------------------------------------------------------------------------------------------->
												<!-- Company = 3 -->
<!-------------------------------------------------------------------------------------------------------------------------------->
<%
if(compview==3 || admin>=2){
%> 
 <div id="tabs-3" style="height: 530px;">
  	
 <div style="height: 500px; overflow: scroll">
<table class="TableLarge" id="mySpecialHugeTablemfpl">
  <!-- <tr align="center">
    <th colspan="10"><strong>BASIC INFORMATION</strong></th>
    <th colspan="16"><strong>SALARY STRUCTURE</strong></th>
    <th colspan="10"><strong>LAST 5 YEARS INCREMENTS</strong></th>
    <th colspan="7"><strong>CURRENT INCREMENTS</strong></th>
  </tr> -->
  <tr align="center">
    <th><strong style="font-size: 12px;">&nbsp;&nbsp;T. No.&nbsp;&nbsp;</strong></th>
    <th><strong>Name</strong></th>
    <!-- <th><strong>Education</strong></th> -->
    <th><strong>Department</strong></th>
    <th><strong>Designation</strong></th>
    <th><strong>Grade</strong></th>
    <!-- <th><strong>Birth Date </strong></th> -->
    <th><strong>Exp</strong></th>
    <!-- <th><strong>Joining Date in Group</strong></th> -->
    <th><strong>Joining Date</strong></th> 
    <th><strong>Current Gross</strong></th> 
    <th><strong>Total CTC PM</strong></th> 
    <th><strong>Employee Left ?</strong></th>
  </tr>
  <%
  comp = 3;
  ind_bur.clear(); 
  ps_indrel = null;ps_rating=null;ps_present = null;
  rs_indrel = null;rs_rating=null;rs_present=null;
  base_id = 0;
  ps_21 = con.prepareStatement("select * from BASE_STRUCTURE where COMPANY="+comp+" order by EMPLOYEE_LEFT");
  rs_21 = ps_21.executeQuery();
  while(rs_21.next()){
	  if(rs_21.getString("EMP_STATUS").equalsIgnoreCase("TRAINEE")){
			 trans_flag = true;
	  }
	  base_id = rs_21.getInt("CODE");
		  if(trans_flag==true){
			  %>
			  <tr align="center" title="TRAINEE EMPLOYEE" onmouseover="ChangeColorred(this, true);" onmouseout="ChangeColorred(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;background-color: #7be18a;">
			  <%
				}else{
			  %>
			  <tr align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;">
			  <%
				}
			  %> 
	<td style="font-size: 12px;"><%=rs_21.getString("T_NO")%></td>
	<td align="left"><strong><%=	rs_21.getString("NAME")%></strong></td>
	<%-- <td align="left"><%=	rs_21.getString("EDUCATION")%></td> --%>
	<td align="left"><%=	rs_21.getString("DEPARTMENT")%></td>
	<td align="left"><%=	rs_21.getString("DESIGNATION")%></td>
	<td align="center"><%=	rs_21.getString("GRADE")%></td>
	<%-- <td align="left"><%=	rs_21.getString("BIRTHDATE")%></td> --%>
	<td align="right"><%=	rs_21.getString("TOT_EXP")%></td>
	<%-- <td align="left"><%=	rs_21.getString("JOINING_INGROUP")%></td> --%>
	<td align="left"><%=	rs_21.getString("JOINING_DATE")%></td>
	<td align="right"><%=	rs_21.getString("CURRENT_GROSS")%></td>
	<td align="right"><%=rs_21.getString("CTC_PM") %></td>  
	
	<%
    if(rs_21.getString("EMPLOYEE_LEFT").equalsIgnoreCase("NO")){
    %>
    <td  align="center"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%
    }else{
    %>
    <td  align="center" style="background-color : red;font-weight: bold;color: white;"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%	
    }
    %>
     
  </tr> 
  <% 
  trans_flag=false;
  }
  %>
</table>
</div>
  <script type="text/javascript">
  	table_make_fixed_headermfpl(document.getElementById("mySpecialHugeTablemfpl"), /*bHorizontal*/ true, /*bVertical*/ true, 1000, /*bWrappedByScrollableDiv*/ true);
  </script>
 
</div> 
<%
}
%>
<!-------------------------------------------------------------------------------------------------------------------------------->
												<!-- Company = 4 -->
<!-------------------------------------------------------------------------------------------------------------------------------->
<%
if(compview==4 || admin>=2){
%> 
 <div id="tabs-4" style="height: 530px;">
  	
 <div style="height: 500px; overflow: scroll">
<table class="TableLarge" id="mySpecialHugeTabledi">
  <!-- <tr align="center">
    <th colspan="10"><strong>BASIC INFORMATION</strong></th>
    <th colspan="16"><strong>SALARY STRUCTURE</strong></th>
    <th colspan="10"><strong>LAST 5 YEARS INCREMENTS</strong></th>
    <th colspan="7"><strong>CURRENT INCREMENTS</strong></th>
  </tr> -->
  <tr align="center">
    <th><strong style="font-size: 12px;">&nbsp;&nbsp;T. No.&nbsp;&nbsp;</strong></th>
    <th><strong>Name</strong></th>
    <!-- <th><strong>Education</strong></th> -->
    <th><strong>Department</strong></th>
    <th><strong>Designation</strong></th>
    <th><strong>Grade</strong></th>
    <!-- <th><strong>Birth Date </strong></th> -->
    <th><strong>Exp</strong></th>
    <!-- <th><strong>Joining Date in Group</strong></th> -->
    <th><strong>Joining Date</strong></th>
    <th><strong>Current Gross</strong></th>
    <th><strong>Total CTC PM</strong></th>
    <th><strong>Employee Left ?</strong></th>
  </tr>
  <%
  comp = 4;
  ind_bur.clear(); 
  ps_indrel = null;ps_rating=null;ps_present = null;
  rs_indrel = null;rs_rating=null;rs_present=null;
  base_id = 0;
  ps_21 = con.prepareStatement("select * from BASE_STRUCTURE where COMPANY="+comp+" order by EMPLOYEE_LEFT");
  rs_21 = ps_21.executeQuery();
  while(rs_21.next()){
	  
	  if(rs_21.getString("EMP_STATUS").equalsIgnoreCase("TRAINEE")){
			 trans_flag = true;
	  }
	  
	  base_id = rs_21.getInt("CODE");  
		  if(trans_flag==true){
			  %>
			  <tr align="center" title="TRAINEE EMPLOYEE" onmouseover="ChangeColorred(this, true);" onmouseout="ChangeColorred(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;background-color: #7be18a;">
			  <%
				}else{
			  %>
			  <tr align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;">
			  <%
				}
			  %> 
	<td style="font-size: 12px;"><%=rs_21.getString("T_NO")%></td>
	<td align="left"><strong><%=	rs_21.getString("NAME")%></strong></td>
	<%-- <td align="left"><%=	rs_21.getString("EDUCATION")%></td> --%>
	<td align="left"><%=	rs_21.getString("DEPARTMENT")%></td>
	<td align="left"><%=	rs_21.getString("DESIGNATION")%></td>
	<td align="center"><%=	rs_21.getString("GRADE")%></td>
	<%-- <td align="left"><%=	rs_21.getString("BIRTHDATE")%></td> --%>
	<td align="right"><%=	rs_21.getString("TOT_EXP")%></td>
	<%-- <td align="left"><%=	rs_21.getString("JOINING_INGROUP")%></td> --%>
	<td align="left"><%=	rs_21.getString("JOINING_DATE")%></td> 
	<td align="right"><%=	rs_21.getString("CURRENT_GROSS")%></td> 
    <td align="right"><%=rs_21.getString("CTC_PM") %></td>
    <%
    if(rs_21.getString("EMPLOYEE_LEFT").equalsIgnoreCase("NO")){
    %>
    <td  align="center"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%
    }else{
    %>
    <td  align="center" style="background-color : red;font-weight: bold;color: white;"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%	
    }
    %>
     
  </tr>
  <% 
  trans_flag = false;
  }
  %>
</table>
</div>
  <script type="text/javascript">
  table_make_fixed_headerdi(document.getElementById("mySpecialHugeTabledi"), /*bHorizontal*/ true, /*bVertical*/ true, 1000, /*bWrappedByScrollableDiv*/ true);
  </script>
 
</div> 
<%
}
%>
<!-------------------------------------------------------------------------------------------------------------------------------->
												<!-- Company = 5 -->
<!-------------------------------------------------------------------------------------------------------------------------------->
<%
if(compview==5 || admin>=2){
%> 
 <div id="tabs-5" style="height: 530px;">
  	
 <div style="height: 500px; overflow: scroll">
<table class="TableLarge" id="mySpecialHugeTablek1">
  <!-- <tr align="center">
    <th colspan="10"><strong>BASIC INFORMATION</strong></th>
    <th colspan="16"><strong>SALARY STRUCTURE</strong></th>
    <th colspan="10"><strong>LAST 5 YEARS INCREMENTS</strong></th>
    <th colspan="7"><strong>CURRENT INCREMENTS</strong></th>
  </tr> -->
  <tr align="center">
    <th><strong style="font-size: 12px;">&nbsp;&nbsp;T. No.&nbsp;&nbsp;</strong></th>
    <th><strong>Name</strong></th>
    <!-- <th><strong>Education</strong></th> -->
    <th><strong>Department</strong></th>
    <th><strong>Designation</strong></th>
    <th><strong>Grade</strong></th>
    <!-- <th><strong>Birth Date </strong></th> -->
    <th><strong>Exp</strong></th>
    <!-- <th><strong>Joining Date in Group</strong></th> -->
    <th><strong>Joining Date</strong></th> 
    <th><strong>Current Gross</strong></th> 
    <th><strong>Total CTC PM</strong></th> 
    <th><strong>Employee Left ?</strong></th>
  </tr>
  <%
  comp = 5; 
  ps_indrel = null;ps_rating=null;ps_present = null;
  rs_indrel = null;rs_rating=null;rs_present=null;
  base_id = 0;
  ps_21 = con.prepareStatement("select * from BASE_STRUCTURE where COMPANY="+comp+" order by EMPLOYEE_LEFT");
  rs_21 = ps_21.executeQuery();
  while(rs_21.next()){ 
	  if(rs_21.getString("EMP_STATUS").equalsIgnoreCase("TRAINEE")){
			 trans_flag = true;
		  }
	  base_id = rs_21.getInt("CODE");  
		  if(trans_flag==true){
			  %>
			  <tr align="center" title="TRAINEE EMPLOYEE" onmouseover="ChangeColorred(this, true);" onmouseout="ChangeColorred(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;background-color: #7be18a;">
			  <%
				}else{
			  %>
			  <tr align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"  onclick="button1('<%=rs_21.getInt("CODE")%>','<%=rs_21.getInt("COMPANY") %>');" style="cursor: pointer;">
			  <%
				}
			  %> 
	<td style="font-size: 12px;"><%=rs_21.getString("T_NO")%></td>
	<td align="left"><strong><%=	rs_21.getString("NAME")%></strong></td>
	<%-- <td align="left"><%=	rs_21.getString("EDUCATION")%></td> --%>
	<td align="left"><%=	rs_21.getString("DEPARTMENT")%></td>
	<td align="left"><%=	rs_21.getString("DESIGNATION")%></td>
	<td align="center"><%=	rs_21.getString("GRADE")%></td>
	<%-- <td align="left"><%=	rs_21.getString("BIRTHDATE")%></td> --%>
	<td align="right"><%=	rs_21.getString("TOT_EXP")%></td>
	<%-- <td align="left"><%=	rs_21.getString("JOINING_INGROUP")%></td> --%>
	<td align="left"><%=	rs_21.getString("JOINING_DATE")%></td> 
	<td align="right"><%=	rs_21.getString("CURRENT_GROSS")%></td> 
    <td align="right"><%=rs_21.getString("CTC_PM") %></td> 
    
    <%
    if(rs_21.getString("EMPLOYEE_LEFT").equalsIgnoreCase("NO")){
    %>
    <td  align="center"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%
    }else{
    %>
    <td  align="center" style="background-color : red;font-weight: bold;color: white;"><%=rs_21.getString("EMPLOYEE_LEFT") %></td>
    <%	
    }
    %>
     
  </tr> 
  <% 
  trans_flag=false;
  }
  %>
</table>
</div>
  <script type="text/javascript">
  table_make_fixed_headerk1(document.getElementById("mySpecialHugeTablek1"), /*bHorizontal*/ true, /*bVertical*/ true, 1000, /*bWrappedByScrollableDiv*/ true);
  </script>
 
</div>
<%
}
%>
<!-- ---------------------------------------------------------------------------------------------------------------------------- -->
</div> 
</div>		 
		<!-- 	
		</div>
			</div>
		</div>  -->
			<%
				}catch(Exception e){
					e.printStackTrace();
				}finally{
					con.close();
				}
			%>
<!-- ******************************************************* Footer ******************************************************** -->	
<div style="width: 100%; padding-top: 7px; height: 30px; background-color: #2c3e50; font-family: Arial; color: white;">
	<marquee behavior="alternate" scrolldelay="150">
		<a href="http://www.muthagroup.com/" style="margin: 20px 0; font-size: 17px; color: white; text-align: center; text-shadow: 0 1px #2a85a1; text-decoration: none;">
			<strong>Welcome to MUTHA DMS.....</strong>from professional  for professional.
		</a> &nbsp;
	</marquee>
</div>
<!-- ********************************************************************************************** -->	
</body>
</html>