<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
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
<title>Part Image View</title>
</head>
<body>
	<%
	OutputStream oImage=null;
	String name = null;
		try {
			final int BUFFER_SIZE = 8096;

			Connection con = Connection_Utility.getConnection();
			int nameId = Integer.parseInt(request.getParameter("field"));
			
			if (nameId != 0) {
				System.out.println("In if loop ");
			}

			System.out.println("file name = " + nameId);
			PreparedStatement ps = con
					.prepareStatement("select * from dev_partno_photo_tbl where part_photo_id="
							+ nameId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				
				byte barray[] = rs.getBytes("Attachment");
		        response.setContentType("image/gif");
		        oImage=response.getOutputStream();
		        oImage.write(barray);
		        oImage.flush();
		        oImage.close();
				
				
				/* name = rs.getString("file_name");
				System.out.println("Part Image name = " + name);
				Blob blob = rs.getBlob("Attachment");
				InputStream inputStream = blob.getBinaryStream();
				int filelength = inputStream.available();
				System.out.println("File length = " + filelength);
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
				outStream.close(); */
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			oImage.flush();
	        oImage.close();
		}
	%>


</body>
</html>