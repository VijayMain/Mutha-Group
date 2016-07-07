<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%!int i;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Part No</title>
<meta http-equiv="cache-control" content="no-cache" />

</head>
<body>

	<select name="part_no" id="part_no"
		style="cursor: pointer; max-width: 11em;">
		<option value="0">-----Select-----</option>
		<%
			
			String str=null;
			str= request.getParameter("q");
	
			i=Integer.parseInt(str);
			
			PreparedStatement ps_partNo = null;
			ResultSet rs_partNo = null;
			
			PreparedStatement ps_getPartNameId=null;
			ResultSet rs_partNameId=null;
			
			Connection con = null;
			
			String part_No=null;
			
			try {
					con = Connection_Utility.getConnection();
				
				
						ps_partNo = con.prepareStatement("select Part_No,PartNo_Id from cs_part_no_tbl where PartName_Id="+i);
						rs_partNo = ps_partNo.executeQuery();
						
						
						while (rs_partNo.next()) 
						{
				
		%>
							<option value="<%=rs_partNo.getString("PartNo_Id")%>"><%=rs_partNo.getString("Part_No")%></option>
		<%	
						}
					
			} catch (SQLException e) 
			{
				e.printStackTrace();
				return;
			}
		%>
	</select>

</body>
</html>
