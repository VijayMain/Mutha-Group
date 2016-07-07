<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%!int company_id;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Casting Vendor</title>
</head>

<body>
	<div id="getRelated">
		<%
			Connection con = Connection_Utility.getConnection();

			String str1 = null;

			str1 = request.getParameter("rel");
			//System.out.println("company id in related person :" + company_id);

			
	%>
		<select name="related_person" id="related_person"
			style="cursor: pointer; max-width: 11em;">User Person
			<option value="0">------- Select -------</option>
			<%
				PreparedStatement ps_relPerson = con
							.prepareStatement("select * from User_Tbl where dept_id=7 AND grade_id>5 and Company_Id  BETWEEN 3 AND 5");
					ResultSet rs_relPerson = ps_relPerson.executeQuery();

					while (rs_relPerson.next()) {
						System.out.println("Into related while ok");
			%>
			<option value="<%=rs_relPerson.getInt("U_Id")%>"><%=rs_relPerson.getString("U_Name")%></option>
			<%
				}
			%>
		</select>

		<%
			ps_relPerson.close();
				rs_relPerson.close();

			
		%>

	</div>
</body>
</html>