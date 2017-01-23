<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Operation Name</title>
</head>
<%
	Connection con=Connection_Utility.getConnection();
	int company_id=0;
	String str=null;
	
	str=request.getParameter("opn_no");
	
	ResultSet rs_opnNoId=null;
	PreparedStatement ps_opnNoId=null;
	
	System.out.println("Operation names for operation no :"+str);
%>
<body>
					<div id="opn_names">
						<select name="operation" id="operation" style="cursor: pointer; max-width: 11em;">
							<option value="null">----- Select -----</option>
							<%
								ps_opnNoId=con.prepareStatement("select opnNo_id from dev_operation_no_mst_tbl where opn_no='"+str+"'");
								rs_opnNoId=ps_opnNoId.executeQuery();
							
								while(rs_opnNoId.next())
								{
									PreparedStatement ps_getOpnIds=con.prepareStatement("select opn_id from dev_opn_opnno_rel_tbl where opnno_id="+rs_opnNoId.getInt("opnno_id"));
									ResultSet rs_getOpnIds=ps_getOpnIds.executeQuery();
									while(rs_getOpnIds.next())
									{
										PreparedStatement ps_getOpnNames=con.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="+rs_getOpnIds.getInt("opn_id"));
										ResultSet rs_getOpnNames=ps_getOpnNames.executeQuery();
										while(rs_getOpnNames.next())
										{
											
							%>
								<option value="<%=rs_getOpnNames.getString("operation") %>"><%=rs_getOpnNames.getString("operation") %></option>
							<%		
										}
										rs_getOpnNames.close();
										ps_getOpnNames.close();

									}	
									rs_getOpnIds.close();
									ps_getOpnIds.close();
								}
								rs_opnNoId.close();
								ps_opnNoId.close();
							%>
						</select>
					</div>
</body>
</html>