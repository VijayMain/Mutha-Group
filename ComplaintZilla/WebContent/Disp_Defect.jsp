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

	<select name="defect_name">
		<%
			String str = request.getParameter("p");
			System.out.println("Ajax code string = " + str);
			i = Integer.parseInt(str);
			try {
				Connection con = Connection_Utility.getConnection();

				PreparedStatement stmt = null;
				PreparedStatement stmt1 = null;
				ArrayList ar = new ArrayList();
				stmt = con.prepareStatement("select Defect_Id from Defect_tbl where Category_Id="+ i);
				ResultSet rs = stmt.executeQuery();

				while (rs.next()) {
					ar.add(rs.getInt("Defect_Id"));
				}

				Iterator it = ar.iterator();

				while (it.hasNext()) {

					stmt1 = con
							.prepareStatement("select * from Defect_tbl where Defect_Id="+ it.next()+" order by Defect_Type");
					ResultSet rs1 = stmt1.executeQuery();
					while (rs1.next()) {
		%>
		<option value="<%=rs1.getInt("Defect_Id")%>"><%=rs1.getString("Defect_Type")%></option>
		<%
			}
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return;
			}
		%>
	</select>

</body>
</html>
