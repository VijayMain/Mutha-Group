<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>IT Tracker Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<script language="javascript" type="text/javascript"
	src="datetimepicker.js"></script>
<link rel="stylesheet" type="text/css" href="styles.css" />
<link href="tab_trial.css" rel="stylesheet" />
<script language="JavaScript" src="gen_validatorv4.js"
	type="text/javascript" xml:space="preserve"></script>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
 
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 11px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5; 
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 10px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
</style>  
<%
	try {
		String fromdate = request.getParameter("from");
		String todate = request.getParameter("to");
		
		Calendar first_Datecal = Calendar.getInstance();   
		first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
		Date dddd = first_Datecal.getTime();  
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
		Date tdate = new Date();
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con.prepareStatement("select U_Name from User_tbl where U_Id=" + uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}
%>
</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Reports</h3>
		</div>
		<div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li>
				<!-- <li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> -->
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
		</div> 
<div style="height: 80%;width: 99%;overflow: scroll;">
<table border="1" class="tftable">
  <tr>
    <th colspan="5"><strong>INHOUSE SOFTWARE USAGE FROM <b style="color: green;background-color: yellow;"><%=fromdate %> TO <%=todate %></b></strong></th>
  </tr>
  <tr align="center"> 
    <th><strong>STATUS</strong></th>
    <th><strong>USER NAME</strong></th>
    <th><strong>COMPANY</strong></th>
    <th><strong>TOTAL</strong></th>
  </tr>
  <!-- IT Tracker start -->
  <tr>
    <td colspan="4" style="background-color:#f9f799 "><strong style="font-size: 12px;">IT Tracker &#8680;</strong></td>
  </tr>
  <%
  int cnt=0;
  String query = "SELECT * FROM it_user_requisition where Status='Pending' and Req_Date between " + fromdate + " and " + todate;
  PreparedStatement ps_new = con.prepareStatement(query);
  ResultSet rs_new = ps_new.executeQuery();
  while(rs_new.next()){ 
  %>
  <tr>
    <td>Hardware</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td> 
  </tr>
  <%
  }
  %>
  <!-- IT Tracker End -->
  <!-- ComplaintZilla start -->
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <!-- ComplaintZilla End -->
  <!-- ECN start -->
  <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <!-- ECN End -->
   <!-- DVP BOSS start -->
  <tr>
    <td>&nbsp;</td> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <!-- DVP BOSS End -->
</table>	 
	</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		<!-- <div id="footer">
			<p class="style2">
				<a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New
					Requisition</a> <a href="Closed_Requisitions.jsp">Closed
					Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a>
				<a href="IT_Reports.jsp">Reports</a> <a href="Software_Access.jsp">Software
					Access</a> <a href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara </a>
			</p>
		</div> -->
	</div>
</body>
</html>
