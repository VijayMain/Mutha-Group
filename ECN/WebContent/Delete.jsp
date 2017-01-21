<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--======================== Delete Attachment CR_Action Script ====================================-->
<!--============================================================================-->
<title>Delete</title>
</head>
<body>
	<%
		try {

			String IdStr = request.getParameter("q");
			int id = Integer.parseInt(IdStr);
			String complaint_No, date_attached, filename = "";
			int del_stat = 0;
			int uid = 0;
			InputStream file;
			//********************************************************************************
			// Date
			Date d = new Date();

			String date = null, month = null, year = null;
			int date_in = d.getDate();

			if (date_in <= 9) {
				date = "0" + date_in;
			} else {
				date = Integer.toString(date_in);
			}
			if (d.getMonth() <= 9) {
				month = "0" + Integer.toString(d.getMonth() + 1);

			} else {
				month = Integer.toString(d.getMonth() + 1);
			}
			year = Integer.toString(d.getYear() + 1900);
			String today = date + "/" + month + "/" + year;
			//********************************************************************************

			Connection con = Connection_Utility.getConnection();

			//PreparedStatement ps = con
			//	.prepareStatement("delete from complaint_tbl_attachments where Attach_Id="
			//		+ id);

			PreparedStatement ps = con
					.prepareStatement("update cr_tbl_action_attachment set delete_Status=0 where Cr_Attach_Id="
							+ id);
			ps.executeUpdate();

	/*		
	PreparedStatement ps_sel = con
					.prepareStatement("select * from cr_tbl_action_attachment where Attach_Id="
							+ id);
			ResultSet rs_sel = ps_sel.executeQuery();
			while (rs_sel.next()) {
				complaint_No = rs_sel.getString("Complaint_No");
				file = rs_sel.getBinaryStream("Attachment");
				date_attached = rs_sel.getString("Attach_Date");
				uid = rs_sel.getInt("U_Id");
				filename = rs_sel.getString("File_Name");
				del_stat = rs_sel.getInt("delete_Status");

				PreparedStatement ps_his = con
						.prepareStatement("insert into complaint_tbl_attachment_hist(CA_Hist_date,Complaint_No,Attach_Date,U_Id,File_Name,Delete_Status_Hist)values(?,?,?,?,?,?)");
				ps_his.setString(1, today);
				ps_his.setString(2, complaint_No);
				ps_his.setString(3, date_attached);
				ps_his.setInt(4, uid);
				ps_his.setString(5, filename);
				ps_his.setInt(6, rs_sel.getInt("delete_Status"));
				ps_his.executeUpdate();

			}
*/
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>