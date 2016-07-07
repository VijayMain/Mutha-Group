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
if(report.equalsIgnoreCase("")){ 
}else{ 
	PreparedStatement ps_rep = null;
	ResultSet rs_rep = null;
	String report_Name = "";
	Connection con = Connection_Util.getLocalDatabase();
	PreparedStatement ps = con.prepareStatement("select * from company_report_rel_tbl where company_id="+Integer.parseInt(report));
	ResultSet rs = ps.executeQuery();
	while(rs.next()){ 
		ps_rep = con.prepareStatement("select * from reports_tbl where reports_id="+rs.getInt("reports_id"));
		rs_rep = ps_rep.executeQuery();
		while(rs_rep.next()){
			report_Name = rs_rep.getString("report");
		}
%>
<option value="<%=rs.getString("reports_id")%>"><%=report_Name%></option>
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