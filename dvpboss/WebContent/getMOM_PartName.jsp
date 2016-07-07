<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get MOM</title>
</head>
<body>
<span id="getPart_Name">
			<%
			String str = request.getParameter("q");
			Connection con = null;
			int str_input=0;
			if(str!=""){
				str_input = Integer.parseInt(str);
			%>	
				<select name="part" id="part" style="background-color: #F5F5F5;">
			<% 
			if(str_input==1){
			con = ConnectionUrl.getMEPLH21ERP();
			}
			if(str_input==2){
			con = ConnectionUrl.getMEPLH25ERP();
			}
			if(str_input==3){
			con = ConnectionUrl.getFoundryERPNEWConnection();
			}
			if(str_input==4){
			con = ConnectionUrl.getK1ERPConnection();
			}
			if(str_input==5){
			con = ConnectionUrl.getDIERPConnection();
			} 
				PreparedStatement ps_getpart = con.prepareStatement("select * from MSTMATERIALS where MATERIAL_TYPE='101' order by NAME");
				ResultSet rs_getpart = ps_getpart.executeQuery();
				while(rs_getpart.next()){
				%>
				<option value="<%=rs_getpart.getString("CODE")%>"><%=rs_getpart.getString("NAME")%></option>
				<%
				}
				ps_getpart.close();
				rs_getpart.close();
				%>
				</select> 
			<%
			}else{
			%>		 
				<select name="part" id="part" style="background-color: #F5F5F5;">
				<option value=""></option>
				</select>
			<%
			}
			con.close();
			%>	
		</span>	
</body>
</html>