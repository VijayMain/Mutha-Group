<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete</title>
</head>
<body>
<%
try{
	Connection conextra = ConnectionUrl.getLocalDatabase();
	int delid=Integer.parseInt(request.getParameter("q"));
%>
<span id="delId">
				<table class="tft" border="1"> 
					<tr align="center">
						<th width="3%">H.No.</th>  
						<th>Holiday (In DD/MM/YYYY)</th>
						<th>Remark</th>
						<th>Remove</th> 
					</tr>
				<%
				PreparedStatement psDel = conextra.prepareStatement("delete FROM montlyweekdays_tbl where montlyWeekdays_id="+delid);
				int del = psDel.executeUpdate();
				
				int hcnt=1;
				PreparedStatement ps_wekk = conextra.prepareStatement("select * from montlyweekdays_tbl order by year desc");
				ResultSet rs_wekk = ps_wekk.executeQuery();
				while(rs_wekk.next()){
				%>
					<tr>
						<td align="center"><%=hcnt %></td>
						<td align="center"><%=rs_wekk.getString("day") %>/<%=rs_wekk.getString("month") %>/<%=rs_wekk.getString("year") %></td>
						<td><%=rs_wekk.getString("remark") %></td>
						<td align="center"><input type="button" value="DELETE" onclick="deleteRec('<%=rs_wekk.getInt("montlyWeekdays_id")%>')"></td>
					</tr>
				<%
				hcnt++;
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