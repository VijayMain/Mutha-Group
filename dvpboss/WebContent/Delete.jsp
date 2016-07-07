
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<title>Delete</title>
</head>
<body>
	<%
		try {
			int basic_id = Integer.parseInt(request
					.getParameter("basic_id"));
			int field = Integer.parseInt(request.getParameter("field"));
			String action = request.getParameter("action");
			Connection con = Connection_Utility.getConnection();
			Date curr_Date = new java.sql.Date(System.currentTimeMillis());
			int uid = Integer.parseInt(session.getAttribute("uid")
					.toString());
			int d = 0, u = 0;

			System.out.print("ids" + basic_id + "action =" + action
					+ "field = " + field + "\n");

			if (action.equalsIgnoreCase("delpo")) {

				PreparedStatement ps_potbl = con
						.prepareStatement("select * from dev_basicinfo_po_attachment_tbl where Basic_Id="
								+ basic_id
								+ " and BI_PO_Attach_Id="
								+ field);
				ResultSet rs_potbl = ps_potbl.executeQuery();
				while (rs_potbl.next()) {
					PreparedStatement ps_pohist = con
							.prepareStatement("insert into dev_basicinfo_po_attachment_tbl_hist (basic_id,bi_po_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_id) values(?,?,?,?,?,?,?,?)");
					ps_pohist.setInt(1, basic_id);
					ps_pohist.setInt(2, field);
					ps_pohist.setString(3, rs_potbl.getString("file_name"));
					ps_pohist.setBinaryStream(4,
							rs_potbl.getBinaryStream("attachment"));
					ps_pohist.setInt(5, uid);
					ps_pohist.setDate(6, curr_Date);
					ps_pohist.setDate(7, rs_potbl.getDate("attached_date"));
					ps_pohist.setInt(8, 0);
					d = ps_pohist.executeUpdate();

				}

				if (d > 0) {
					PreparedStatement ps_podelete = con
							.prepareStatement("update dev_basicinfo_po_attachment_tbl set Enable_id=0 where Basic_Id="
									+ basic_id
									+ " and bi_po_attach_id="
									+ field);
					u = ps_podelete.executeUpdate();
				}
				if (d > 0 && u > 0) {
					System.out.print("Bascic update");
	%>
	<span id="delPO"><img alt="" src="images/valid.png">&nbsp;&nbsp;File Deleted</span>
	<%
		}

			} else if (action.equalsIgnoreCase("delpart")) {

				int p = 0, q = 0;
				PreparedStatement ps_part = con
						.prepareStatement("select * from dev_partno_photo_tbl where part_photo_id="
								+ field);
				ResultSet rs_part = ps_part.executeQuery();
				while (rs_part.next()) {
					PreparedStatement ps_histpart = con
							.prepareStatement("insert into dev_partno_photo_tbl_hist(part_photo_id,attachment,file_name,created_by,created_date,created_date_hist,partno_id) values(?,?,?,?,?,?,?)");
					ps_histpart.setInt(1, field);
					ps_histpart.setBinaryStream(2,
							rs_part.getBinaryStream("attachment"));
					ps_histpart
							.setString(3, rs_part.getString("file_name"));
					ps_histpart.setInt(4, uid);
					ps_histpart.setDate(5, curr_Date);
					ps_histpart.setDate(6, rs_part.getDate("created_date"));
					ps_histpart.setInt(7, rs_part.getInt("partno_id"));
					p = ps_histpart.executeUpdate();

				}
				if (p > 0) {
					PreparedStatement ps_delpart = con
							.prepareStatement("update dev_partno_photo_tbl set Enable_Id=0 where part_photo_id="
									+ field);
					q = ps_delpart.executeUpdate();
				}
				if (p > 0 && q > 0) {
	%>
	<span id="delPart"><img alt="" src="images/valid.png">&nbsp;&nbsp;File Deleted</span>

	<%
		}

			} else if (action.equalsIgnoreCase("del3dmodel")) {
				int m = 0, m1 = 0;
				PreparedStatement ps_3dModel = con
						.prepareStatement("select * from dev_3d_drawing_attachment_tbl where Basic_Id="
								+ basic_id
								+ " and 3D_drawing_attach_id="
								+ field);
				ResultSet rs_3dModel = ps_3dModel.executeQuery();
				while (rs_3dModel.next()) {

					PreparedStatement ps_hist3dmodel = con
							.prepareStatement("insert into dev_3d_drawing_attachment_tbl_hist(Basic_Id,3D_drawing_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id) values(?,?,?,?,?,?,?,?)");
					ps_hist3dmodel.setInt(1, basic_id);
					ps_hist3dmodel.setInt(2, field);
					ps_hist3dmodel.setString(3,
							rs_3dModel.getString("file_name"));
					ps_hist3dmodel.setBinaryStream(4,
							rs_3dModel.getBinaryStream("attachment"));
					ps_hist3dmodel.setInt(5, uid);
					ps_hist3dmodel.setDate(6, curr_Date);
					ps_hist3dmodel.setDate(7,
							rs_3dModel.getDate("attached_date"));
					ps_hist3dmodel.setInt(8, 0);
					m = ps_hist3dmodel.executeUpdate();

				}
				if (m > 0) {
					PreparedStatement ps_3dMOd = con
							.prepareStatement("update dev_3d_drawing_attachment_tbl set Enable_id=0 where Basic_Id="
									+ basic_id
									+ " and 3D_drawing_attach_id=" + field);
					m1 = ps_3dMOd.executeUpdate();
					
				}
				if(m>0 && m1>0){
					%>
					<span id="del3d"><img alt="" src="images/valid.png">&nbsp;&nbsp;File Deleted</span>
					
					<%
				}

			}else if(action.equalsIgnoreCase("del2dmodel")){
				
				int del=0,del1=0;
				PreparedStatement ps_2dMod=con.prepareStatement("select* from dev_2d_drawing_attachment where Basic_Id="+basic_id + " and 2D_drawing_attach_id="+field);
				ResultSet rs_2dMod=ps_2dMod.executeQuery();
				
				while(rs_2dMod.next()){
					PreparedStatement ps_hist2dMod=con.prepareStatement("insert into dev_2d_drawing_attachment_hist(Basic_Id,2d_drawing_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id) values(?,?,?,?,?,?,?,?)");
					ps_hist2dMod.setInt(1, basic_id);
					ps_hist2dMod.setInt(2, field);
					ps_hist2dMod.setString(3, rs_2dMod.getString("file_name"));
					ps_hist2dMod.setBinaryStream(4, rs_2dMod.getBinaryStream("attachment"));
					ps_hist2dMod.setInt(5, uid);
					ps_hist2dMod.setDate(6, curr_Date);
					ps_hist2dMod.setDate(7, rs_2dMod.getDate("attached_date"));
					ps_hist2dMod.setInt(8, 0);
					del=ps_hist2dMod.executeUpdate();
				}
				if(del>0){
					PreparedStatement ps_del2dModel=con.prepareStatement("update dev_2d_drawing_attachment set Enable_Id=0 where Basic_Id="+basic_id+" and 2D_drawing_attach_id="+field);
					del1=ps_del2dModel.executeUpdate();
				}
				if(del>0 && del1>0){
					%>
					<span id="del2D"><img alt="" src="images/valid.png">&nbsp;&nbsp;File Deleted</span>
					<%
				}
			} if(action.equalsIgnoreCase("other")){
				int other=0,other1=0;
				PreparedStatement ps_other=con.prepareStatement("select * from dev_other_attachement where Basic_Id="+basic_id+" and other_attach_id="+field);
				ResultSet rs_other=ps_other.executeQuery();
				while(rs_other.next()){
					PreparedStatement ps_otherHist=con.prepareStatement("insert into dev_other_attachement_hist(Basic_Id,other_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id)values(?,?,?,?,?,?,?,?)");
					ps_otherHist.setInt(1, basic_id);
					ps_otherHist.setInt(2, field);
					ps_otherHist.setString(3, rs_other.getString("file_name"));
					ps_otherHist.setBinaryStream(4, rs_other.getBinaryStream("attachment"));
					ps_otherHist.setInt(5, uid);
					ps_otherHist.setDate(6, curr_Date);
					ps_otherHist.setDate(7, rs_other.getDate("attached_date"));
					ps_otherHist.setInt(8, 0);
					other=ps_otherHist.executeUpdate();
				}
				if(other>0){
					PreparedStatement ps_delOther=con.prepareStatement("update dev_other_attachement set Enable_Id=0 where Basic_Id="+basic_id+" and other_attach_id="+field);
					other1=ps_delOther.executeUpdate();
				}
				if(other>0 && other1>0){
					%>
					<span id="delOther"><img alt="" src="images/valid.png">&nbsp;&nbsp;File Deleted</span>
					<%
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>