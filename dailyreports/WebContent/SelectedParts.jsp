<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Select Parts</title>
</head>
<body>
<span id="getSelectedParts">
<select id="sbTwo" name="sbTwo" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 10px;" title="Please Select all Selected Parameters">
<%
try{
String report = request.getParameter("q");
String comp = request.getParameter("s");
Connection con = null;
if(report.equalsIgnoreCase("")){
}else{

	if(!report.equalsIgnoreCase("3")){
	con = Connection_Util.getLocalDatabase();
	PreparedStatement ps = con.prepareStatement("select * from dailyreports_config_tbl where company_id="+Integer.parseInt(comp)+" and reports_id="+Integer.parseInt(report));
	ResultSet rs = ps.executeQuery();
	while(rs.next()){
%> 
<option value="<%=rs.getString("matcode")%>"><%=rs.getString("matname") %></option>
<%
	}
	}
}
%>
</select>
</span>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>