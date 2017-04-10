<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Closed Requisitions</title>
<link rel="stylesheet" type="text/css" href="styles.css" />

<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
}
</script>
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 12px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 11px; 
	padding: 5px; 
}
</style>
<script language="javascript">
	function button1(val) {
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		edit.submit();
	}
</script>
<%
try {
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	int d_Id=0; 
					
	String uname=null;
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		d_Id = rs_uname.getInt("Dept_Id");
		uname=rs_uname.getString("U_Name");
	}
%>

</head>
<body>
<div id="container">
  <div id="top">
    <h3>Closed Requisitions</h3>
 </div>
  <div id="menu">
   <ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="New_Requisition.jsp">Add New</a></li>
				<li><a href="Requisition_Status.jsp">Status</a></li>
				<li><a href="Closed_Req_User.jsp">Closed</a></li>
				<li><a href="All_Requisitions.jsp">All</a></li>
				<li><a href="Search_Requisitions.jsp">Search</a></li>
				<li><a href="DMS.jsp">DMS</a></li> 
				<li><a href="Reports_User.jsp">Reports</a></li>
				<li><a href="Change_Password.jsp">Change Password</a></li>
				<li><a href="Profile.jsp">My Profile</a></li> 
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: small;"> <%=uname%></strong></li>
			</ul>
  </div>
  <%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.PreparedStatement"%>
 <%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
  %>
    <div style="height: 500px;width:99%; overflow: scroll;">  
  <form method="post" name="edit" action="Closed_Requisition_Details.jsp" id="edit"> 
			<%
				Connection conn = null;
					conn = Connection_Utility.getConnection();

					ResultSet rs_reqDetails = null;
					ResultSet rsRowCnt = null;

					PreparedStatement ps_reqDetails = null;
					PreparedStatement psRowCnt = null; 
					
					String sqlPagination = "SELECT  * FROM it_user_requisition where U_Id="+uid+" and Status='Closed' order by U_Req_Id desc";

					ps_reqDetails = conn.prepareStatement(sqlPagination);
					rs_reqDetails = ps_reqDetails.executeQuery();

					//// this will count total number of rows
					String sqlRowCnt = "SELECT FOUND_ROWS() as cnt";
					psRowCnt = conn.prepareStatement(sqlRowCnt);
					rsRowCnt = psRowCnt.executeQuery();
			%> 
  <table style="width: 100%;" align="center" class="tftable"> 
  	<tr>
  		<th>Req. No.</th>
  		<th>Related To</th>
  		<th>Type</th>
  		<th>Req. Date</th>
  		<th>Status</th>
 		<th>Done By</th>
  	</tr>
  	<%
  		while(rs_reqDetails.next())
  		{
  	%>
 	<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=rs_reqDetails.getInt("U_Req_Id")%>');" style="cursor: pointer;">
 		<td align="center"><%=rs_reqDetails.getInt("U_Req_Id") %></td>
 		<%
 		
 			PreparedStatement ps_related=con.prepareStatement("select Related_To from it_related_problem_tbl where Rel_Id="+rs_reqDetails.getInt("Rel_Id"));
 			ResultSet rs_related=ps_related.executeQuery();
 			while(rs_related.next())
 			{
 		%>
 		<td align="left"><%=rs_related.getString("Related_To") %></td>
 		<%
 			}
 			PreparedStatement ps_type=con.prepareStatement("select Req_Type from it_requisition_type_tbl where Req_Type_Id="+rs_reqDetails.getInt("Req_type_id"));
 			ResultSet rs_type=ps_type.executeQuery();
 			while(rs_type.next())
 			{
 		%>
 		<td align="left"><%=rs_type.getString("Req_Type") %></td>
 		<%
 			}
 		%>
 		<td align="left"><%=rs_reqDetails.getTimestamp("Req_Date") %></td>
 		<td align="left"><%=rs_reqDetails.getString("Status") %></td>
 		<%
 		PreparedStatement ps_doneBy_Id=con.prepareStatement("select max(Req_Remark_Id) from it_requisition_remark_tbl where U_Req_Id="+rs_reqDetails.getInt("U_Req_Id"));		
 		ResultSet rs_doneBy_Id=ps_doneBy_Id.executeQuery();
 		while(rs_doneBy_Id.next())
 		{
 			PreparedStatement ps_doneBy=con.prepareStatement("select * from it_requisition_remark_tbl where Req_Remark_Id="+rs_doneBy_Id.getInt("max(Req_Remark_Id)"));
 			ResultSet rs_doneBy=ps_doneBy.executeQuery();
 			while(rs_doneBy.next()){
 		%>
 		<td align="left"><%=rs_doneBy.getString("Done_by") %></td>
 		<%
 			}
 		}
 		%>
 	</tr>
 	<%
   		}
			} catch (Exception e) {
				e.printStackTrace();
			}
 %> 
  </table>
  <input type="hidden" name="hid" id="hid"> 
  </form> 
   </div>
   <div id="footer">
    <p class="style2"><a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a> <a href="All_Requisitions.jsp">All Requisitions</a> <a href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div>
   </div>
</body>
</html>