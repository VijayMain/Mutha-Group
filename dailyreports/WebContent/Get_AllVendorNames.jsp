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
Connection con =null;	
	
String comp = request.getParameter("q"); 
if(comp.equalsIgnoreCase("")){ 
%>
<span id="getvendorname"> 			
	<select id="sbOne" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 10px;"> 
       <option value="">Please Select Company Name</option> 
   </select>
</span>
<%	
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
%>
<span id="getvendorname"> 			
	<select id="sbOne" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;font-family: Arial;font-size: 10px;">
	 <%
	 PreparedStatement ps = con.prepareStatement("select * from MSTACCTGLSUB order by SUBGL_LONGNAME");
	 ResultSet rs = ps.executeQuery();
	 while(rs.next()){ 
	 %>
       <option value="<%=rs.getString("SUB_GLACNO")%>"><%=rs.getString("SUBGL_LONGNAME") %></option>
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