<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>All Reports</title>
</head>
<body>
 <%
try{
Connection con =Connection_Util.getLocalDatabase();	
	
String comp = request.getParameter("q"); 
if(comp.equalsIgnoreCase("")){ 
%>
<span id="getReportvendors">
		<select name="report" id="report" style="height: 25px;background-color: #EBECED;font-family: Arial;font-size: 12px;" onchange="getCompVendors(this.value)">
			<option value="">- - - - - - Select - - - - - -</option> 
        </select>
        </span>
<%	
}else{ 
%>
<span id="getReportvendors"> 
	<select name="report" id="report" style="height: 25px;background-color: #EBECED;font-family: Arial;font-size: 12px;" onchange="getCompVendors(this.value)">
	<option value=""> - - - - - - Select - - - - - - </option>
	 <%
	 PreparedStatement ps_get=null;
	 ResultSet rs_get=null;
	 PreparedStatement ps = con.prepareStatement("select * from company_report_rel_tbl where company_id="+Integer.parseInt(comp));
	 ResultSet rs = ps.executeQuery();
	 while(rs.next()){ 
		 ps_get = con.prepareStatement("select * from reports_tbl where reports_id="+rs.getInt("reports_id"));
		 rs_get = ps_get.executeQuery();
		 while(rs_get.next()){
	 %>
       <option value="<%=rs_get.getInt("reports_id")%>"><%=rs_get.getString("report") %></option>
     <%
		 }
	 }
	 rs.close();
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