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
<title>Master Selected</title>
</head>
<body>
<%
try{
	Connection con_local = ConnectionUrl.getLocalDatabase();
	String master_code = request.getParameter("q"); 
%>
<div id="soft">
					<table align="center">
						<tr>
							<td colspan="1"><b>MIS Report</b></td>
							<td></td>
							<td colspan="1"><b>Selected MIS Report</b></td>
						</tr>
						<tr>
							<td colspan="1" align="left">
							<select id="software_name" name="software_name" multiple="multiple" size="5"
								style="width: 250px;height: 250px;font-size: 13px;font-family: Arial;" title="MIS Report"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"> 
									<%
									PreparedStatement ps_soft = con_local.prepareStatement("SELECT * FROM erp_database.erp_itemmaster_list where code not in (SELECT list_id FROM erp_database.erp_itemmaster_rel where master_code like ('"+master_code+"'))");
									ResultSet rs_soft = ps_soft.executeQuery();
									while (rs_soft.next()) {
									%>
									<option value="<%=rs_soft.getString("lable")%>"><%=rs_soft.getString("lable")%></option>
									<%
										}
									%>
							</select>
							</td>
							<td  align="center">
								<input value="&#8658;" onclick="move('right', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 15px;"><br>
								<input value="&#8656;" onclick="move('left', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 15px;"></td>
							<td colspan="1" align="right">
							<select id="software_selected" name="software_selected" multiple="multiple" size="5"
								style="width: 250px;height: 250px;font-size: 13px;font-family: Arial;" title="Selected MIS Report"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
									<% 
									ps_soft = con_local.prepareStatement("select * from erp_itemmaster_rel where master_code='"+master_code+"'");
									rs_soft = ps_soft.executeQuery();
									while (rs_soft.next()) {						
									%>
									<option value="<%=rs_soft.getString("list_name")%>"><%=rs_soft.getString("list_name")%></option>
									<%
										}
									%>
							</select>
							</td>
						</tr>
					</table>
	</div>
	<%
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>