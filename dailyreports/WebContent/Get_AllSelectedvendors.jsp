<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<html>
<head>
<title>All MatNames</title>
</head>
<body>
<span id="getvendors">
<select id="sbTwo" name="sbTwo" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 10px;">
<%
try{
String report = request.getParameter("q");
String comp = request.getParameter("comp");
if(report.equalsIgnoreCase("")){
}else{ 
	Connection con = Connection_Util.getLocalDatabase();
	PreparedStatement ps = con.prepareStatement("select * from company_vendor_rel_tbl where reports_id="+Integer.parseInt(report) + " and company_id="+Integer.parseInt(comp));
	ResultSet rs = ps.executeQuery();
	while(rs.next()){ 
%>
<option value="<%=rs.getString("vendor_code")%>"><%=rs.getString("vendor_name")%></option>
<%		
	}
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</select>
</span>
</body>
</html>