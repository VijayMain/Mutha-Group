
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%!int i;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>State Page</title>

<script type="text/javascript" src="jquery-1.6.1.min.js"></script>

<link rel="stylesheet" href="css/style.css">

</head>
<body>

	<%
		String str = request.getParameter("q");
		System.out.print(str);

		try {
			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_It = con
					.prepareStatement("select * from user_tbl_dept where dept_id=(select dept_id from user_tbl where Login_name='"
							+ str + "')");

			ResultSet rs_It = ps_It.executeQuery();

			while (rs_It.next()) {
	%>
	<div id="content">
		<label for="login-department">Department</label> <input type="hidden"
			name="U_Dept" value="<%=rs_It.getInt("Dept_Id")%>"
			class="round full-width-input"> <input type="text" name="U_Dept"
			value="<%=rs_It.getString("Department")%>"
			class="round full-width-input" disabled="disabled">
	</div>
	<%
		}

		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
	%>


</body>
</html>
