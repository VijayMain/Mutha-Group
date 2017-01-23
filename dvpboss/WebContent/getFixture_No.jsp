<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Fixture</title>
</head>
<%

	try
	{
		Connection con=Connection_Utility.getConnection();
		int company_id=0;
		String str=null;
	
		str=request.getParameter("fixture_no");
	
		ResultSet rs_opnNoId=null;
		PreparedStatement ps_opnNoId=null;
	
		System.out.println("Fixture Name :"+str);
%>
<body>
					<div id="fixt_no">
						<select name="fixture_no" id="fixture_no" style="cursor: pointer; max-width: 11em;">
							<option value="null">----- Select -----</option>
							<%
									PreparedStatement ps_getFixtureId=con.prepareStatement("select Fixture_Id from dev_fixture_mst_tbl where Fixture_Name='"+str+"'");
									ResultSet rs_getFixtureId=ps_getFixtureId.executeQuery();
									while(rs_getFixtureId.next())
									{
										System.out.println("fixture Id..... "+rs_getFixtureId.getInt("Fixture_Id"));
										PreparedStatement ps_getRelatedFixtureNo=con.prepareStatement("select FixtureNo_Id from dev_fixture_fixtureno_rel_tbl where fixture_id="+rs_getFixtureId.getInt("fixture_id"));	
										ResultSet rs_getRelatedFixtureNo=ps_getRelatedFixtureNo.executeQuery();
										while(rs_getRelatedFixtureNo.next())
										{
											PreparedStatement ps_getFixtureNo=con.prepareStatement("select Fixture_No from dev_fixture_no_mst_tbl where FixtureNo_Id="+rs_getRelatedFixtureNo.getInt("FixtureNo_Id"));
											ResultSet rs_getFixtureNo=ps_getFixtureNo.executeQuery();
											while(rs_getFixtureNo.next())
											{
							%>
								<option value="<%=rs_getFixtureNo.getString("Fixture_No") %>"><%=rs_getFixtureNo.getString("Fixture_No") %></option>
							<%		
											}
										}
									}
						}catch(Exception e)
						{
							e.printStackTrace();
						}
							%>
						</select>
					</div>
</body>
</html>