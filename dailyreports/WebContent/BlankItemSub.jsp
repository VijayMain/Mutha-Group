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
<title>Insert title here</title>
</head>
<body>
<%
try{
	String report = request.getParameter("q");
	String comp = request.getParameter("comp"); 
	Connection con = null;
%>
<span id="getParts"> 
	<select name="sbOne" id="sbOne" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 12px;">
<%
if(Integer.parseInt(report)==3){
	
}else{
	
	if(comp.equalsIgnoreCase("101")){	
		con = Connection_Util.getMEPLH21ERP();
	}
	if(comp.equalsIgnoreCase("102")){	
		con = Connection_Util.getMEPLH25ERP();
	}		 
	if(comp.equalsIgnoreCase("103")){
		con = Connection_Util.getFoundryERPNEWConnection();
	}
	if(comp.equalsIgnoreCase("105")){
		con = Connection_Util.getDIERPConnection();
	}
	if(comp.equalsIgnoreCase("106")){
		con = Connection_Util.getK1ERPConnection();
	}
 
	 PreparedStatement ps = con.prepareStatement("select * from MSTMATERIALS where MATERIAL_TYPE in(101,103) order by NAME");
	 ResultSet rs = ps.executeQuery();
	 while(rs.next()){
	 %>
      <option value="<%=rs.getString("CODE")%>"><%=rs.getString("NAME") %></option>
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