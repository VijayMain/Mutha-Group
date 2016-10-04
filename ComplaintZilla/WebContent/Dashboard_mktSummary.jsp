<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="com.muthagroup.bo.GetUserName_BO"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#fromDate").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#toDate").datepicker({
			changeMonth : true,
			changeYear : true
		});
	});
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = 'white';
		}
	}  
</script>
<title>Report</title> 
<link rel="stylesheet" href="css/style.css">
<script src="js/script.js"></script>
</head>
<body> 
	<%
		try {
			int uid, count = 0;
			Connection con = Connection_Utility.getConnection();
			GetUserName_BO ubo = new GetUserName_BO();
			uid = Integer.parseInt(session.getAttribute("uid").toString());
			String U_Name = ubo.getUserName(uid);
			int dept_id = ubo.getUserDeptID(uid); 
			count = Integer.parseInt(session.getAttribute("count").toString());
			int int_count = Integer.parseInt(session.getAttribute("int_count").toString());
	%>
	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">


				<li class="v-sep"><a href="Marketing_Home.jsp"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a></li>

				<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left" title="New Customer Complaints"><%=count%>
						Customer Complaints</a></li>
						<li><a href="All_Complaint_Int.jsp"
					class="round button dark menu-email-special image-left" title="New Internal Complaints"><%=int_count%>
						Internal Complaints</a></li>
						
						
				<!-- 
				<li><a href="All_Complaint.jsp"
					class="round button dark menu-email-special image-left">All
						Complaints</a></li>
					 -->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>   
			</ul> 

		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->
 
	<!-- HEADER -->
	<div id="header-with-tabs">

		<div class="page-full-width cf">

			<ul id="tabs" class="fl">
				<li><a href="Marketing_Home.jsp" class="active-tab dashboard-tab">Home</a></li>
				<%
				if(dept_id==8){
				%>
				<li><a href="Register_Complaint.jsp" class="active-tab dashboard-tab">Register Complaint</a></li>
				<%
				}
				%>
				<!-- <li><a href="Unassigned_Complaints.jsp"
					class="active-tab dashboard-tab">Unassigned Complaints</a></li> -->
				<li><a href="Report_List.jsp" class="active-tab dashboard-tab">Reports</a></li>
				<li> <a href="Edit_By_Search.jsp" class="active-tab dashboard-tab">Search</a></li>
				<li><a href="Dashboard_mkt.jsp" class="active-tab dashboard-tab">Dashboard</a></li>
			</ul>
			<!-- end tabs -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 30px height. -->
			<a href="Marketing_Home.jsp" id="company-branding-small" class="fr"><img
				src="images/company-logo.png" alt="ComplaintZilla" /></a>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end header -->
 
	<%
	int comp = Integer.parseInt(request.getParameter("comp"));
	int status = Integer.parseInt(request.getParameter("status"));
	String company = "",comp_status="";
	long diff;
	//System.out.println("Data found = = = " + comp + "   " + status);
	SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss"); 
	SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	String oct_date = "2015-10-01 00:00:00";  
	String october_date = "01-10-2015";
	
	Calendar calobj = Calendar.getInstance();
	String todays_date = format2.format(calobj.getTime()); 
	//System.out.println("Todays Date = " + sdf2.format(calobj.getTime())); 
	todays_date = sdf2.format(calobj.getTime());
	PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+comp);
	ResultSet rs_comp = ps_comp.executeQuery();
	while(rs_comp.next()){
		company = rs_comp.getString("Company_Name");
	}
	PreparedStatement ps_status = con.prepareStatement("select * from status_tbl where Status_Id="+status);
	ResultSet rs_status = ps_status.executeQuery();
	while(rs_status.next()){
		comp_status = rs_status.getString("Status");
	} 
	%>
	
	<div style="background-color: white; padding-left: 2px;padding-right: 2px; height: 500px;overflow: scroll;">
		<form name="edit" action="Complaint_Action.jsp" method="post">
 <input type="hidden" name="hid" id="hid">
 		<table width="100%" border="1">
  <tr  style="background-color: #D1CED9;">
    <td colspan="8" align="center" style="height: 28px;"><b><%=comp_status %> Complaint Summary Report for <%=company %></b></td>
  </tr>
  <tr style="background-color: #D1CED9;">
    <th><b>COMPLAINT NO</b></th>
    <th><b>CUSTOMER</b></th>
    <th><b>ITEM</b></th>
    <th><b>REGISTERED BY</b></th>
    <th><b>ASSIGNED TO</b></th>
    <th><b>REGISTERED DATE</b></th>
    <th><b>LAST ACTION DATE</b></th>
    <th style="width: 180px;font-size: 10px;"><b>OVER DUE DAYS<br>( BEYOND 7 DAYS TO CLOSURE )</b></th>
  </tr> 
  <%
  PreparedStatement ps_cust = null,ps_item=null,ps_register=null,ps_assign=null,ps_lastActionDate=null,ps_chkAttach=null;
  ResultSet rs_cust = null,rs_item=null,rs_register=null,rs_assign=null,rs_lastActionDate=null,rs_attach=null;
  String act_date="",date1="",date3="";

  
	PreparedStatement ps_summary = con.prepareStatement("select * from complaint_tbl where Company_Id="+comp+" and Status_Id="+status + "  and complaint_date< '2015-10-01 00:00:00' order by complaint_date");
	ResultSet rs_summary = ps_summary.executeQuery();
	while(rs_summary.next()){
  %>
  <tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=rs_summary.getString("complaint_no")%>');" title="Click to get details">
    <td style="font-size: 10px;text-align: left;"><%=rs_summary.getString("Complaint_No") %></td>
    <%
    ps_cust = con.prepareStatement("select * from customer_tbl where Cust_Id="+rs_summary.getInt("Cust_Id"));
    rs_cust = ps_cust.executeQuery();
    while(rs_cust.next()){
    %>
    <td style="font-size: 10px;text-align: left;"><%=rs_cust.getString("Cust_Name") %></td>
    <%
     }
    ps_item = con.prepareStatement("select * from customer_tbl_item where Item_Id="+rs_summary.getInt("Item_Id"));
    rs_item = ps_item.executeQuery();
    while(rs_item.next()){
    %>
    <td style="font-size: 10px;text-align: left;"><%=rs_item.getString("Item_Name") %></td>
    <%
     }
    ps_register = con.prepareStatement("select * from user_tbl where U_Id="+rs_summary.getInt("U_Id"));
    rs_register = ps_register.executeQuery();
    while(rs_register.next()){
    %>
    <td style="font-size: 10px;text-align: left;"><%=rs_register.getString("U_Name") %></td>
    <%
     }
    ps_assign = con.prepareStatement("select * from user_tbl where U_Id="+rs_summary.getInt("Complaint_Assigned_To"));
    rs_assign = ps_assign.executeQuery();
    while(rs_assign.next()){
    %>
    <td style="font-size: 10px;text-align: left;"><%=rs_assign.getString("U_Name") %></td>
    <%
     }
    %>
    <td style="font-size: 10px;text-align: left;"><%=sdf2.format(rs_summary.getDate("complaint_date")) %></td>
    <%
    
    
    ps_lastActionDate = con.prepareStatement("select max(Action_Date) from complaint_tbl_action where Complaint_No='"+rs_summary.getString("Complaint_No")+"'");
    rs_lastActionDate = ps_lastActionDate.executeQuery();
	while(rs_lastActionDate.next()){
		act_date = rs_lastActionDate.getString("max(Action_Date)"); 
		if(act_date!=null){
			act_date = sdf2.format(rs_lastActionDate.getDate("max(Action_Date)"));
		}else{
			act_date = null;
		}
	}
	if(act_date==null){
		ps_lastActionDate = con.prepareStatement("select max(Attach_Date) from complaint_tbl_attachments where Complaint_No='"+rs_summary.getString("Complaint_No")+"'");
	    rs_lastActionDate = ps_lastActionDate.executeQuery();
		while(rs_lastActionDate.next()){
			act_date = rs_lastActionDate.getString("max(Attach_Date)"); 
			if(act_date!=null){
				act_date = sdf2.format(rs_lastActionDate.getDate("max(Attach_Date)"));
			}else{
				act_date = null;
			}
		}
	}
	%>
	<td style="font-size: 10px;text-align: left;"><%=act_date%></td> 
	<% 
	
    date1 = sdf2.format(rs_summary.getDate("complaint_date")); 
    date3 = todays_date;
    java.util.Date date2cmp;
    java.util.Date date1cmp = sdf2.parse(date1);
    if(act_date!=null){
    	date1cmp = sdf2.parse(october_date);
    	date2cmp = sdf2.parse(todays_date); 	
    	diff = Math.abs(date2cmp.getTime() - date1cmp.getTime()) / (1000 * 60 * 60 * 24);
    	
    }else{
    	date1cmp = sdf2.parse(october_date);
    	date2cmp = sdf2.parse(todays_date);
    	diff = Math.abs(date2cmp.getTime() - date1cmp.getTime()) / (1000 * 60 * 60 * 24);
    } 
   // System.out.println("Date  = = = " + october_date + " to date = " + todays_date);
  diff = diff - 7; 
  if(status<5){
	  if(diff>0){
	%>
	<td style="font-size: 10px;text-align: center;"><b style="font-size: 14px;"><%=diff %></b></td>
	<%	  
	  }else{
	%>
	<td style="font-size: 10px;text-align: center;"><b style="font-size: 14px;">0</b></td>		
	<%	  
	  }
  	}else{
	%>
	<td style="font-size: 10px;text-align: center;">0</td>
	<%  
  	}
    %>
  </tr>
  <%
  diff = 0;
	}
  %>
  <%
  PreparedStatement ps_summary2 = con.prepareStatement("select * from complaint_tbl where Company_Id="+comp+" and Status_Id="+status + "  and complaint_date > '2015-10-01 00:00:00'  order by complaint_date");
	ResultSet rs_summary2 = ps_summary2.executeQuery();
	while(rs_summary2.next()){
		  %>
		  <tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;" onclick="button1('<%=rs_summary2.getString("complaint_no")%>');" title="Click to get details">
		    <td style="font-size: 10px;text-align: left;"><%=rs_summary2.getString("Complaint_No") %></td>
		    <%
		    ps_cust = con.prepareStatement("select * from customer_tbl where Cust_Id="+rs_summary2.getInt("Cust_Id"));
		    rs_cust = ps_cust.executeQuery();
		    while(rs_cust.next()){
		    %>
		    <td style="font-size: 10px;text-align: left;"><%=rs_cust.getString("Cust_Name") %></td>
		    <%
		     }
		    ps_item = con.prepareStatement("select * from customer_tbl_item where Item_Id="+rs_summary2.getInt("Item_Id"));
		    rs_item = ps_item.executeQuery();
		    while(rs_item.next()){
		    %>
		    <td style="font-size: 10px;text-align: left;"><%=rs_item.getString("Item_Name") %></td>
		    <%
		     }
		    ps_register = con.prepareStatement("select * from user_tbl where U_Id="+rs_summary2.getInt("U_Id"));
		    rs_register = ps_register.executeQuery();
		    while(rs_register.next()){
		    %>
		    <td style="font-size: 10px;text-align: left;"><%=rs_register.getString("U_Name") %></td>
		    <%
		     }
		    ps_assign = con.prepareStatement("select * from user_tbl where U_Id="+rs_summary2.getInt("Complaint_Assigned_To"));
		    rs_assign = ps_assign.executeQuery();
		    while(rs_assign.next()){
		    %>
		    <td style="font-size: 10px;text-align: left;"><%=rs_assign.getString("U_Name") %></td>
		    <%
		     }
		    %>
		    <td style="font-size: 10px;text-align: left;"><%=sdf2.format(rs_summary2.getDate("complaint_date")) %></td>
		    <%
		    
		    
		    ps_lastActionDate = con.prepareStatement("select max(Action_Date) from complaint_tbl_action where Complaint_No='"+rs_summary2.getString("Complaint_No")+"'");
		    rs_lastActionDate = ps_lastActionDate.executeQuery();
			while(rs_lastActionDate.next()){
				act_date = rs_lastActionDate.getString("max(Action_Date)"); 
				if(act_date!=null){
					act_date = sdf2.format(rs_lastActionDate.getDate("max(Action_Date)"));
				}else{
					act_date = null;
				}
			}
			if(act_date==null){
				ps_lastActionDate = con.prepareStatement("select max(Attach_Date) from complaint_tbl_attachments where Complaint_No='"+rs_summary2.getString("Complaint_No")+"'");
			    rs_lastActionDate = ps_lastActionDate.executeQuery();
				while(rs_lastActionDate.next()){
					act_date = rs_lastActionDate.getString("max(Attach_Date)"); 
					if(act_date!=null){
						act_date = sdf2.format(rs_lastActionDate.getDate("max(Attach_Date)"));
					}else{
						act_date = null;
					}
				}
			}
			%>
			<td style="font-size: 10px;text-align: left;"><%=act_date%></td> 
			<% 
			
		    date1 = sdf2.format(rs_summary2.getDate("complaint_date")); 
		    date3 = todays_date;
		    java.util.Date date2cmp;
		    java.util.Date date1cmp;
		    
		    	date1cmp = sdf2.parse(date1);
		    	date2cmp = sdf2.parse(todays_date);
		    	diff = Math.abs(date2cmp.getTime() - date1cmp.getTime()) / (1000 * 60 * 60 * 24);
		       
		  diff = diff - 7; 
		  if(status<5){
			  if(diff>0){
			%>
			<td style="font-size: 10px;text-align: center;"><b style="font-size: 14px;"><%=diff %></b></td>
			<%	  
			  }else{
			%>
			<td style="font-size: 10px;text-align: center;"><b style="font-size: 14px;">0</b></td>		
			<%	  
			  }
		  	}else{
			%>
			<td style="font-size: 10px;text-align: center;">0</td>
			<%  
		  	}
		    %>
		  </tr>
		  <%
		  diff = 0;
			}
  %>
</table> 
		</form>
		<hr>
	</div>

	<!-- FOOTER -->
	<div id="footer">

		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries, Satara</a>
		</p>

	</div>
	<!-- end footer -->

<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>