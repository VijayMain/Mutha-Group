<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cust All</title>
</head>
<body>
<%
try{
%>
<span id="getSelectedParts">
    <select id="sbTwo" name="sbTwo" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 12px;" title="Please Select all Selected Parameters">
    <%
    
   	// q=" + str +"&comp="+comp+ "&from="+fromDatehid+"&to="+toDatehid+"&report="+reporthid
    String matname = request.getParameter("q");
    String comp = request.getParameter("comp");
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String report = request.getParameter("report");
    if(matname!=""){
    	Connection con = Connection_Util.getLocalDatabase();
    	PreparedStatement ps_loc = con.prepareStatement("SELECT * FROM  dailyreports_config_tbl where matname='"+matname+"' and company_id="+Integer.parseInt(comp));
    	ResultSet rs_loc = ps_loc.executeQuery();
    	while(rs_loc.next()){
    %>
    <option value="<%=rs_loc.getString("cust_name")%>"><%=rs_loc.getString("cust_name")%></option>
    <%	
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