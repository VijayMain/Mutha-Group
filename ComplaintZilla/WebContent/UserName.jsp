<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%!int i;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>State Page</title>


</head>
<body>
	<select name="user_id">
		<%
			String str = request.getParameter("q");

			i = Integer.parseInt(str);

			Connection connection = Connection_Utility.getConnection();
			try {

				PreparedStatement stmt1 = null;
				stmt1 = connection
						.prepareStatement("SELECT * FROM user_tbl where Company_id="+i+" and u_id not in (select u_id from automail where Company_id="+ i+")");
				ResultSet rs1 = stmt1.executeQuery();
				while (rs1.next()) {
					out.print(rs1.getString("U_Name"));
		%>
		<option value="<%=rs1.getInt("U_Id")%>"><%=rs1.getString("U_Name")%></option>
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
