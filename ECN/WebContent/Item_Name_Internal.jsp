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
<!--============================================================================-->
<!--==================== Item Name AJAX =================================-->
<!--============================================================================-->
</head>
<body>
	<select name="item_name" class="validate-email required input_field">
		<option value="0">---Select---</option>
		<%
			String str = request.getParameter("q");

			i = Integer.parseInt(str);
			System.out.println("Company ID.."+i);
			Connection connection = null;
			try {
				connection = Connection_Utility.getConnection();
				PreparedStatement stmt = null;
				stmt = connection
						.prepareStatement("select Cust_Id from company_customer_relation_tbl where Company_Id="
								+ i);
				ResultSet rs = null;
				rs = stmt.executeQuery();
				ArrayList ar = new ArrayList();
				while (rs.next()) 
				{
					ar.add(rs.getInt("Cust_Id"));
				}
				
				System.out.println("Customer_IDs " +ar);
				
				Iterator it = ar.iterator();
				
				ArrayList ar_cust = new ArrayList();
				
				PreparedStatement stmt_cust = null;
				
				while (it.hasNext()) 
				{
					stmt_cust = connection.prepareStatement("select Item_Id from customer_item_tbl where Cust_Id="+it.next() );
					ResultSet rs_cust = null;
					rs_cust = stmt_cust.executeQuery();
				
					while (rs_cust.next()) 
					{
						ar_cust.add(rs_cust.getInt("Item_Id"));
					}
				}
				
				System.out.println("Item_IDs " +ar_cust);
				Iterator it_cust=ar_cust.iterator();
				
				while (it_cust.hasNext()) 
				{
					PreparedStatement stmt1 = null;
					stmt1 = connection
							.prepareStatement("select * from customer_tbl_item where item_id="
									+ it_cust.next());
					ResultSet rs1 = stmt1.executeQuery();
					while (rs1.next()) 
					{
						out.print(rs1.getString("Item_Name"));
		%>
		<option value="<%=rs1.getInt("Item_Id")%>"><%=rs1.getString("Item_Name")%></option>
		<%
			}
				}
			
			}catch (SQLException e) {
				e.printStackTrace();
				return;
			}
		%>
	</select>
<!--============================================================================-->
<!--============================================================================-->
</body>
</html>
