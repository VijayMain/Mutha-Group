<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%!int i;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>State Page</title>
</head>
<body>
	<%@ page import="com.muthagroup.bo.GetUserName_BO"%>

	<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>

	<select name="item_no" onchange="showState(this.value)">
		<%
			String str = request.getParameter("p");
			System.out.println("Ajax code string = " + str);
			i = Integer.parseInt(str);
			try {
				Connection con = Connection_Utility.getConnection();

				PreparedStatement stmt = null;
				PreparedStatement stmt1 = null;
				ArrayList ar = new ArrayList();
				stmt = con
						.prepareStatement("select In_Id from customer_tbl_item_no where Item_Id="
								+ i);
				ResultSet rs = stmt.executeQuery();

				while (rs.next()) {
		%>
		<option value="<%=rs.getInt("In_Id")%>"><%=rs.getString("Item_No")%></option>
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
