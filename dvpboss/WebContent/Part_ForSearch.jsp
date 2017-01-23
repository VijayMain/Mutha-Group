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
<title>Part</title>
<meta http-equiv="cache-control" content="no-cache" />

</head>
<body>

	<select id="part_name" name="part_name" onchange="getpartno(this.value)" style="cursor: pointer; max-width: 11em;">
		<option value="0">--------Select--------</option>
		<%
				
			String str=null;
			
			str = request.getParameter("q");
			
			i=Integer.parseInt(str);
			
			PreparedStatement ps_getPart_Ids = null;
			PreparedStatement ps_partName = null;
			
			PreparedStatement ps_getCust_Id=null;
			
			ArrayList<Integer> partName_Ids = new ArrayList<Integer>();
			
			Connection con = null;
			try {
				con = Connection_Utility.getConnection();
				
				
					ps_getPart_Ids = con
							.prepareStatement("select PartName_Id from cs_cust_partname_rel_tbl where Cust_Id="+ i);
					ResultSet  rs_getPart_Ids= ps_getPart_Ids.executeQuery();

						while (rs_getPart_Ids.next()) 
						{
							partName_Ids.add(rs_getPart_Ids.getInt("PartName_Id"));
						}
			
				System.out.println("List = " + partName_Ids);
				Iterator<Integer> it = partName_Ids.iterator();
				String partName=null;
				while (it.hasNext()) 
				{

					ps_partName = con
							.prepareStatement("select Part_Name,PartName_Id from cs_part_name_tbl where PartName_Id="+ it.next());
					ResultSet rs_partName = ps_partName.executeQuery();
					while (rs_partName.next()) 
					{
						
		%>
		<option value="<%=rs_partName.getString("PartName_Id")%>"><%=rs_partName.getString("Part_Name")%></option>
		<%
					}
				}
			} catch (SQLException e)
			{
				e.printStackTrace();
			}
		%>
	</select>

</body>
</html>
