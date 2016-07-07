<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Project Leader</title>
</head>
<%
	Connection con = Connection_Utility.getConnection();
	int company_id = 0;

	ResultSet rs_leadName = null;
	PreparedStatement ps_leadName = null;

	System.out.println("company id in project leader :" + company_id);
%>
<body>
	<div id="getLeader">
		<select name="project_leader" id="project_leader"
			style="cursor: pointer; max-width: 11em;">
			<option value="">----- Select -----</option>
			<%
				ps_leadName = con
						.prepareStatement("select u_name,u_id from user_tbl where Enable_id!=0 AND dept_id=7 AND grade_id>5 AND company_id<3");
				rs_leadName = ps_leadName.executeQuery();

				while (rs_leadName.next()) {
					System.out.println("In while loop project lead loop");
			%>
			<option value="<%=rs_leadName.getInt("U_Id")%>"><%=rs_leadName.getString("U_Name")%></option>
			<%
				}
			%>
		</select>
	</div>
</body>
</html>