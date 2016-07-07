<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Table trial</title>
</head>
<body>
<%
	try
	{
		Connection con=Connection_Utility.getConnection();	
		
		PreparedStatement ps_getBasic=con.prepareStatement("select * from Customer_tbl");
		
		ResultSet rs_getBasic=ps_getBasic.executeQuery();	
		
	%>
	<table border="1">
		<tr>
			<th>Customer Name</th>
			<th>Part Name</th>
		</tr>
	<%
		
		while(rs_getBasic.next())
		{
	%>
		<tr>
			<td><%=rs_getBasic.getString("Cust_Name") %></td>
			
			<td>
			
				<table>
				<%
					PreparedStatement ps_getDetails=con.prepareStatement("select Item_Id from customer_item_tbl where Cust_Id="+rs_getBasic.getInt("Cust_Id"));
					ResultSet rs_getDetails=ps_getDetails.executeQuery();
					while(rs_getDetails.next())
					{
						PreparedStatement ps_getItemName=con.prepareStatement("select Created_By,Item_Name from customer_tbl_item where Item_Id="+rs_getDetails.getInt("Item_Id"));
						ResultSet rs_getItemName=ps_getItemName.executeQuery();
						
						while(rs_getItemName.next())
						{
							
				%>
					<tr style="background-color: red;">
						<td><%=rs_getItemName.getString("Item_Name") %></td>
						<td>&nbsp;</td>
						<td><%=rs_getItemName.getInt("Created_By") %></td>
					
						<td>
							<%
							for(int i=0;i<=5;i++)
							{
						%>
							<table>
								<tr>
									
									<td style="background-color: green;">testing testing</td>
									<td>
										<%
											for(int j=0;j<3;j++)
											{
												
										%>
											<table>
												<tr>
													<td style="background-color: yellow;">testing 1 testing 1</td>
												</tr>
											</table>
										<%

											}
										%>
									</td>								
								</tr>
							</table>
							<%

							}
						%>
						</td>
						
						
						
						
					</tr>
				<%

						}
					}
					
				%>
				</table>
			</td>
		</tr>
	<%
		}
	%>
	</table>
	
	
	
	
	<%
		
		
		
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	

%>

</body>
</html>