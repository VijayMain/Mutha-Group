<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%!int i;
	int j;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>State Page</title>
<meta http-equiv="cache-control" content="no-cache" />
</head>
<body>
	<select name="assigned" id="assigned" style="height: 25px;">
		<option value="0"> - - - - - Select - - - - - </option>
		<%
		try {
			String str = request.getParameter("p");
			//String str1 = request.getParameter("q");

			i = Integer.parseInt(str);
			//j=Integer.parseInt(str1);
			System.out.println("Assigned........");
			Connection connection = null;
			
				connection = Connection_Utility.getConnection();
				PreparedStatement stmt1 = null;
				stmt1 = connection.prepareStatement("select * from user_tbl where Company_Id="+ i + " and dept_id!=8 and dept_id!=9 and Enable_id=1 order by U_Name");
				ResultSet rs1 = stmt1.executeQuery();
				while (rs1.next()) {
					/* out.print(rs1.getString("U_Name")); */
		%>
		<option value="<%=rs1.getInt("U_Id")%>"><%=rs1.getString("U_Name")%></option>
		<%
			}
		PreparedStatement ps_corp = connection.prepareStatement("select * from user_tbl where U_Id in(select u_id from complaint_corporate_tbl)");
		ResultSet rs_copr = ps_corp.executeQuery();
		while(rs_copr.next()){
			%>
			<option value="<%=rs_copr.getInt("U_Id")%>"><%=rs_copr.getString("U_Name")%></option>
			<%	
		}
				
			} catch (SQLException e) {
				e.printStackTrace();
				return;
			}
		%>
	</select>

</body>
</html>
