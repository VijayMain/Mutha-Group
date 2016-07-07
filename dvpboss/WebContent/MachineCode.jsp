<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Machine Code</title>
</head>
<body>

	<select name="machine_code" id="machine_code" style="cursor: pointer;" onclick="getHistoryData(this.value)">
		<option value="0">- - - - - Select - - - - -</option>
		<%
			String str = "";
			str = request.getParameter("q");
			Connection con = null;
			//System.out.println("machine code called for machine..."+str);
			try {
				con = Connection_Utility.getConnection();
				PreparedStatement ps_mcode = con.prepareStatement("select * from mt_machinecode_mst_tbl where machineName_id in(select machineName_Id from dev_machinename_mst_tbl where machine_name ='"+str+"')");
				ResultSet rs_mcode = ps_mcode.executeQuery();
				while (rs_mcode.next()) {
		%>
		<option value="<%=rs_mcode.getInt("machinecode_id")%>"><%=rs_mcode.getString("machinecode")%></option>
		<%
			}

			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</select>

</body>
</html>