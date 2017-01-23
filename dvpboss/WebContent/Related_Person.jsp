<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Related Person</title>
</head>
<%
	Connection con=Connection_Utility.getConnection();
	
	
	String str1=null;
	int company_id=0;
	
	str1=request.getParameter("rel");
	
	if(str1 !=null)
	{
		company_id=Integer.parseInt(str1);	
	}
	PreparedStatement ps_relPerson=null;
	ResultSet rs_relPerson=null;
	
	System.out.println("company id in related person :"+company_id);
%>
<body>
		<div id="getRelated">
						<select name="related_person" id="related_person" style="cursor: pointer; max-width: 11em;">
								<option value="0">------- Select -------</option>
							<%
								ps_relPerson=con.prepareStatement("select U_Id,U_Name from User_Tbl where dept_id=7 AND grade_id>5 and enable_id!=0 and company_id="+company_id);
								rs_relPerson=ps_relPerson.executeQuery();
								while(rs_relPerson.next())
								{
									System.out.println("Into related while .....");
							%>
								<option value="<%=rs_relPerson.getInt("U_Id") %>"><%=rs_relPerson.getString("U_Name") %></option>
							<%
								}
							%>	
						</select>
					</div>
</body>
</html>