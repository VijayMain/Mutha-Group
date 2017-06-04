<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
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
</head>
<body>
<div id="item">
	<select name="item_name" id="item_name" class="validate-email required input_field" style="font-weight:bold;  background-color: #dcf1f8">
		<option value="0"> - - - Select - - - </option>
		<%
			Connection connection = null;
			try {
				connection = Connection_Utility.getConnection();
				String str = request.getParameter("q");
				i = Integer.parseInt(str); 
				PreparedStatement stmt = null;
				stmt = connection.prepareStatement("select Item_Id from customer_item_tbl where Cust_Id=" + i);
				ResultSet rs = null;
				rs = stmt.executeQuery();
				ArrayList ar = new ArrayList();
				while (rs.next()) {
					ar.add(rs.getInt("Item_Id"));
				}

				Iterator it = ar.iterator();

				while (it.hasNext()) {
					PreparedStatement stmt1 = null;
					stmt1 = connection.prepareStatement("select * from customer_tbl_item where Item_Id=" + it.next());
					ResultSet rs1 = stmt1.executeQuery();
					while (rs1.next()) {
						// System.out.print(rs1.getString("Item_Name"));
		%>
		<option value="<%=rs1.getInt("Item_Id")%>"><%=rs1.getString("Item_Name")%></option>
		<%
			}
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return;
			}
		%>
	</select>
</div>
</body>
</html>
