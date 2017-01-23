<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
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
<title>Trial Attachment</title>
</head>
<body>


<%
		try {
			final int BUFFER_SIZE = 8096;

			Connection con = Connection_Utility.getConnection();
			int nameId = Integer.parseInt(request.getParameter("field"));
			String name = null;
			if (nameId != 0) {
				System.out.println("In if loop ");
			}

			System.out.println("file name = " + nameId);
			PreparedStatement ps = con
					.prepareStatement("select * from dev_trial_attachment_tbl where trial_attachment_id="
							+ nameId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				name = rs.getString("file_name"); 
				Blob blob = rs.getBlob("attachment");
				InputStream inputStream = blob.getBinaryStream();
				int filelength = inputStream.available(); 
				ServletContext context = getServletContext();

				String mimeType = context.getMimeType(name);
				if (mimeType == null) {
					mimeType = "application/octet-stream";
				}

				response.setContentType(mimeType);
				response.setContentLength(filelength);
				String headerKey = "Content-Disposition";
				String headerValue = String.format(
						"attachment; filename=\"%s\"", name);
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
				// no file found

				response.getWriter().println(
						"File not found for the id: "
								+ request.getParameter("field"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>