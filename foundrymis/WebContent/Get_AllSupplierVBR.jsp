<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<title>Get all Supplier</title>
</head>
<body style="font-family: Arial;"> 
	<span id="getsupplierVBR">
	<%
	try{
	Connection con=null; 
	String get = "";
	get = request.getParameter("q"); 
	
	if(!get.equalsIgnoreCase("")){
	if(get.equalsIgnoreCase("101")){	
		con = ConnectionUrl.getMEPLH21ERP();
	}
	if(get.equalsIgnoreCase("102")){	
		con = ConnectionUrl.getMEPLH25ERP();
	}
		
	%>
			<select name="sup" id="supVBR"  style="font-family: Arial;font-size: 10px;">
			<option value=""> - - - - - Select - - - - - </option>
			<option value="All_Suppliers">    All Suppliers    </option> 
			<%
			 PreparedStatement ps=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=12");
			 ResultSet rs=ps.executeQuery();
			  while(rs.next()){ 
			%>			
			<option value="<%=rs.getString("SUBGL_LONGNAME")%>"><%=rs.getString("SUBGL_LONGNAME") %></option> 
			<%
			  }
			%> 
			</select> &nbsp;
				 <span id="waitVBR" style="visibility: hidden;"><strong style="color: blue; font-family: Arial;font-size: 10px;">Please Wait.....</strong></span>
	<%		
	}else{
	%>
	<select name="sup" id="supVBR"  style="font-family: Arial;font-size: 10px;">
	<option value=""> - - - - - Select - - - - - </option> 
	</select> &nbsp;
	<span id="waitVBR" style="visibility: hidden;"><strong style="color: blue; font-family: Arial;font-size: 10px;">Please Wait.....</strong></span>
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