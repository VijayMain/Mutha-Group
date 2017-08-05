<%@page import="com.muthagroup.connection.ConnectionModel"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display PO</title>
</head>
<body>
	<%
		try {
			final int BUFFER_SIZE = 8096; 
			Connection con =ConnectionModel.getConnection(); 
			int nameString = Integer.parseInt(request.getParameter("field")); 
			PreparedStatement ps = con.prepareStatement("select * from events_units_mom where code=" + nameString); 
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Blob blob = rs.getBlob("mom_attached");
				InputStream inputStream = blob.getBinaryStream();
				int filelength = inputStream.available();
				System.out.println("File length = " + filelength);
				ServletContext context = getServletContext();

				String mimeType = context.getMimeType(rs.getString("file_name"));
				if (mimeType == null) {
					mimeType = "application/octet-stream";
				}

				response.setContentType(mimeType);
				response.setContentLength(filelength);
				String headerKey = "Content-Disposition";
				String headerValue = String.format("attachment; filename=\"%s\"",rs.getString("file_name"));
				response.setHeader(headerKey, headerValue); 
				OutputStream outStream = response.getOutputStream(); 
				byte[] buffer = new byte[BUFFER_SIZE];
				int bytesRead = -1; 
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outStream.write(buffer, 0, bytesRead);
				} 
				inputStream.close();
				outStream.close();
			} else { 
				response.getWriter().println("File not found for the id: " + request.getParameter("field"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>


</body>
</html>