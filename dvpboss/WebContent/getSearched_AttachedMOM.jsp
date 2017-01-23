<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GET ATTCHED MOM</title>
</head>
<body>
<%
	try{
		Connection con = Connection_Utility.getConnection();
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		String user = request.getParameter("q");
		String momcode = request.getParameter("r");   
%>
 <span id="getMOM_Data"> 
			<table width="100%" border="1" class="gridtable">
				<tr align="center" style="background-color: #B0C9D6"> 
					<th scope="col" height="30">USER NAME
							<select name="s_name" id="s_name" style="width : 20px;"  onchange="getMOM_AttachData(this.value,<%=momcode%>)">
								<option value=""></option> 
								<%
									PreparedStatement ps_sname = con.prepareStatement("SELECT * FROM user_tbl where u_id in(SELECT created_by FROM  dev_mom_history_tbl where mom_code="+momcode+")");
									ResultSet rs_sname = ps_sname.executeQuery();
									while(rs_sname.next()){
								%>					
								<option value="<%=rs_sname.getInt("U_Id")%>"><%=rs_sname.getString("U_Name") %></option>
					 			<%
									}
									ps_sname.close();
									rs_sname.close();
					 			%>
							</select>
							
					</th> 
					<th scope="col">TITLE</th>
					<th scope="col">DESCRIPTION</th> 
					<th scope="col">MOM ATTACHED</th> 
					<th scope="col">MOM UPDATE DATE</th>
				</tr>  
				<%
				PreparedStatement ps_uname = null;
				ResultSet rs_uname = null;
				PreparedStatement ps_his = con.prepareStatement("select * from dev_mom_history_tbl where mom_code="+momcode +" and created_by="+ user+" order by created_by,attach_date desc");
				ResultSet rs_his = ps_his.executeQuery();
				while(rs_his.next()){
				%>
				<tr>
				 <%
				 ps_uname = con.prepareStatement("select * from user_tbl where U_Id=" + rs_his.getInt("created_by"));
				 rs_uname = ps_uname.executeQuery();
				 while(rs_uname.next()){
				 %>
					<td scope="col"><%=rs_uname.getString("U_Name") %></td>
				<%
				 }
				%>
					<td scope="col"><%=rs_his.getString("title") %></td>
					<td scope="col"><%=rs_his.getString("description") %></td> 
					<td scope="col"><a href="Get_MOMAttach_hist.jsp?field=<%=rs_his.getInt("code")%>"><%=rs_his.getString("attach_name")%></a></td> 
					<td scope="col"><%= sdf.format(rs_his.getDate("attach_date")) %></td>
				</tr>
				<%
				}
				%>
				</table> 
				</span>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>