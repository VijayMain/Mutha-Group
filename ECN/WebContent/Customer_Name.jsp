<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
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
<meta http-equiv="cache-control" content="no-cache" />

</head>
<body>
<div id="cust"> 
	
	<select class="validate-email required input_field" onchange="showState(this.value)" style="font-weight:bold;  background-color: #dcf1f8" id="cust_name" name="cust_name">
		<option value="0">--------Select--------</option>
		<% 
			try {
				Connection con = Connection_Utility.getConnection();
				String str = request.getParameter("p");
				System.out.println("Ajax code string = " + str);
				i = Integer.parseInt(str);
				PreparedStatement stmt = null;
				PreparedStatement stmt1 = null;
				ArrayList ar = new ArrayList();
				stmt = con.prepareStatement("select Cust_Id from company_customer_relation_tbl where company_Id=" + i);
				ResultSet rs = stmt.executeQuery(); 
				while (rs.next()) {
					ar.add(rs.getInt("Cust_Id"));
				}

				Iterator it = ar.iterator();

				while (it.hasNext()) {

					stmt1 = con.prepareStatement("select * from customer_tbl where Cust_Id=" + it.next() + " order by Cust_Name");
					ResultSet rs1 = stmt1.executeQuery();
					while (rs1.next()) {
		%>
		<option value="<%=rs1.getInt("Cust_Id")%>"><%=rs1.getString("Cust_Name")%></option>
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
