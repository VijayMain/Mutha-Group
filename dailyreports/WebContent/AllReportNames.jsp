<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<title>Get All MatNames</title>
</head>
<body>	
<%
try{
Connection con =Connection_Util.getLocalDatabase();	
	
String comp = request.getParameter("q"); 
if(comp.equalsIgnoreCase("")){ 
%>
<span id="getvendorname"> 			
	<select id="sbOne" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 12px;"> 
       <option value="">Please Select Company Name</option> 
   </select>
</span>
<%	
}else{ 
%>
<span id="getvendorname"> 			
	<select id="sbOne" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 12px;">
	 <%
	 PreparedStatement ps = con.prepareStatement("select * from reports_tbl");
	 ResultSet rs = ps.executeQuery();
	 while(rs.next()){ 
	 %>
       <option value="<%=rs.getInt("reports_id")%>"><%=rs.getString("report") %></option>
     <%
	 }
     %>   
   </select>
</span>
<%	
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>