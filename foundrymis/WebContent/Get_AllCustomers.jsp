<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<html>
<head> 
<title>all customers</title>
</head>
<body style="font-family: Arial;">
	<span id="getCustAuto">
	<%
	try{
	Connection con=null; 
	String get = "";
	get = request.getParameter("q");
	
	if(!get.equalsIgnoreCase("")){
	if(get.equalsIgnoreCase("103")){
		con=ConnectionUrl.getFoundryERPNEWConnection();
	}
	if(get.equalsIgnoreCase("105")){	
		con=ConnectionUrl.getDIERPConnection();
	}
	if(get.equalsIgnoreCase("106")){	
		con = ConnectionUrl.getK1ERPConnection();
	}
	if(get.equalsIgnoreCase("101")){	
		con = ConnectionUrl.getMEPLH21ERP();
	}
	if(get.equalsIgnoreCase("102")){	
		con = ConnectionUrl.getMEPLH25ERP();
	}
		
	%>
			<select name="cust" id="custdPlan" style="font-family: Arial;font-size: 10px;"> 
			<option value=""> - - - - - Select - - - - - </option> 
			<%
			 PreparedStatement ps=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=11");
			 ResultSet rs=ps.executeQuery();
			  while(rs.next()){ 	 
			%>
			<option value="<%=rs.getString("SUB_GLACNO")%>"><%=rs.getString("SUBGL_LONGNAME") %></option> 
			<%
			  }
			%> 
			</select>  &nbsp;
			<span id="waitcustdPlan" style="visibility: hidden;"><strong style="color: blue;font-family: Arial;font-size: 10px;">Please Wait.....</strong></span>
	<%		
	}else{
	%>
	<select name="cust" id="custdPlan" style="font-family: Arial;font-size: 10px;"> 
	<option value=""> - - - - - Select - - - - - </option> 
	</select>  &nbsp;
 <span id="waitcustdPlan" style="visibility: hidden;"><strong style="color: blue;">Please Wait.....</strong></span>
	<%	
	} 
	con.close();
	}catch(Exception e){
		e.printStackTrace();
	} 
	%>			 
				 </span>
</body>
</html>