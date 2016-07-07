package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpSession;
import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Register_VO;
import com.muthagroup.vo.UserVO;

public class Register_Complaint_DAO {

	boolean flag = false;
	Connection con = null;
	PreparedStatement ps = null, ps1 = null;
	ResultSet rs = null, rs1 = null;
	int count = 0;

	@SuppressWarnings({ "unused", "rawtypes", "unchecked" })
	public boolean saveToDatabase(Register_VO beans, UserVO userVO,
			HttpSession session) {

		try {

			int update = 0;
			String sr = session.getAttribute("uid").toString();
			int uid = Integer.parseInt(sr);
			System.out.println("uid is =" + uid);

			int u_id = beans.getAssigned();

			int stat_id = 1;
			int def_id = 0;
			con = Connection_Utility.getConnection();

			// **********************************************************************************************
			// Auto-Complete Defect input logic ====>
			// **********************************************************************************************
			Statement st_defect = con.createStatement();
			ResultSet rs_defecttype = st_defect
					.executeQuery("select * from Defect_Tbl");

			List li = new ArrayList();

			while (rs_defecttype.next()) {
				li.add(rs_defecttype.getString("Defect_Type"));
			}

			String str1 = null;
			Iterator it = li.iterator();
			str1 = beans.getDefect();
			int Company_id_mail = beans.getCust_comp_id();
			boolean flag1 = false;
			do {

				String p = (String) it.next();
				if (p.equals(str1)) {
					flag1 = true;
					break;
				}
			} while (it.hasNext());

			if (flag1 == false) {
				PreparedStatement st1 = con
						.prepareStatement("insert into Defect_Tbl (Defect_Type) values(?)");
				st1.setString(1, str1);
				st1.executeUpdate();
			}

			PreparedStatement st_def_id = con
					.prepareStatement("select defect_id from Defect_Tbl where defect_type='"
							+ beans.getDefect() + "'");
			ResultSet rs_def_id = st_def_id.executeQuery();

			while (rs_def_id.next()) {
				def_id = rs_def_id.getInt("defect_id");
				System.out.println("********* New Defect Id =" + def_id
						+ "    ******************");
			}
			rs_def_id.close();

			// *********************************************************************************************************
			// *********************************************************************************************************

			Calendar cal = Calendar.getInstance();
			cal.getTime();
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
			String autoTime = sdf.format(cal.getTime());

			System.out.println("Discription Value in DAo ::: "
					+ beans.getDiscription());
			// *********************************************************************************************************
			// *********************************************************************************************************
			ps = con.prepareStatement("insert into complaint_tbl(Complaint_No,U_Id,Cust_Id,Item_id,Defect_Id,Complaint_Received_by,"
					+ "Complaint_Description,Complaint_Related_To,Complaint_Assigned_To,Category_Id,Complaint_Date,Status_Id,Company_Id,P_Id,Automail_time,mail_status)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, userVO.getComplaint_Number());
			ps.setInt(2, uid);
			ps.setInt(3, beans.getCust_id());
			ps.setInt(4, beans.getItem_id());
			ps.setInt(5, def_id);
			ps.setString(6, beans.getReceived());
			ps.setString(7, beans.getDiscription());
			ps.setInt(8, beans.getRelated());
			ps.setInt(9, beans.getAssigned());
			ps.setInt(10, beans.getCategory());
			ps.setTimestamp(11, beans.getDate());
			ps.setInt(12, stat_id);
			ps.setInt(13, beans.getCust_comp_id());
			ps.setInt(14, beans.getSeverity());
			ps.setString(15, autoTime);
			ps.setInt(16, 0);

			update = ps.executeUpdate();

			System.out.println("Unregistered id = " + beans.getUnregistered());
			if (beans.getUnregistered() != 0) {

				PreparedStatement ps_unreg1 = con
						.prepareStatement("update complaint_tbl_unassigned set Enable_Id=0 where unassign_id="
								+ beans.getUnregistered());
				ps_unreg1.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public String getCust_Name(int cid) {

		// ***********************************************************************************************************
		// Get Customer Name
		// ***********************************************************************************************************
		String cust_Name = null;
		try {

			System.out.println("CID = " + cid);
			con = Connection_Utility.getConnection();
			ps = con.prepareStatement("select * from customer_tbl where Cust_Id='"
					+ cid + "'");

			rs = ps.executeQuery();
			while (rs.next()) {
				cust_Name = rs.getString("Cust_Name");
				System.out.println(cust_Name);
			}
			// ***********************************************************************************************************
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cust_Name;
	}

	public String Get_Count() {

		// ***********************************************************************************************************
		// code for new complaint count
		// ***********************************************************************************************************
		String Count = null;
		int cnt = 0;

		try {
			con = Connection_Utility.getConnection();
			ps = con.prepareStatement("select count(Complaint_No) from complaint_tbl");
			rs = ps.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt("count(Complaint_No)") + 1;
			}

			Count = Integer.toString(cnt);
			System.out.println("Count is = " + Count);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return Count;
		// **************************************************************************************************************
	}

	public boolean attach_File(Register_VO bean, HttpSession session) {
		boolean flag = false;
		try {
			PreparedStatement ps_file = null;
			String sr = session.getAttribute("uid").toString();
			int uid = Integer.parseInt(sr);

			con = Connection_Utility.getConnection();

			String comp_no = bean.getComplaint_No();
			Timestamp attach_date = bean.getDate();
			String file_Name = bean.getFile_Name_ext();
			int del = 1;

			// ****************************************************************************************************************************
			// Save attachment to database
			// ****************************************************************************************************************************

			ps_file = con
					.prepareStatement("insert into complaint_tbl_attachments(Complaint_No,Attachment,Attach_Date,U_Id,File_Name,delete_Status)values(?,?,?,?,?,?)");
			ps_file.setString(1, comp_no);
			ps_file.setBinaryStream(2, bean.getFile_blob());
			ps_file.setTimestamp(3, attach_date);
			ps_file.setInt(4, uid);
			ps_file.setString(5, file_Name);
			ps_file.setInt(6, del);
			ps_file.executeUpdate();

			// ****************************************************************************************************************************

			PreparedStatement ps_del = con
					.prepareStatement("delete from complaint_tbl_attachments where File_Name='"
							+ "" + "'");
			ps_del.executeUpdate();

			// ****************************************************************************************
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			// ****************************************************************************************

			PreparedStatement ps_history = con
					.prepareStatement("insert into complaint_tbl_attachment_hist(CA_Hist_date,Complaint_No,Attach_Date,U_Id,File_Name,Delete_Status_Hist)values(?,?,?,?,?,?) ");
			ps_history.setTimestamp(1, timestamp);
			ps_history.setString(2, comp_no);
			ps_history.setTimestamp(3, attach_date);
			ps_history.setInt(4, uid);
			ps_history.setString(5, file_Name);
			ps_history.setInt(6, del);
			ps_history.executeUpdate();
			flag = true;

			PreparedStatement ps_del1 = con
					.prepareStatement("delete from complaint_tbl_attachment_hist where File_Name='"
							+ "" + "'");
			ps_del1.executeUpdate();

			if (flag == true && bean.getUnregistered() != 0) {

				PreparedStatement ps_unreg = con
						.prepareStatement("select * from complaint_tbl_unassigned_attachment where unassign_Id="
								+ bean.getUnregistered());

				ResultSet rs_unreg = ps_unreg.executeQuery();

				while (rs_unreg.next()) {

					PreparedStatement ps_unregatt = con
							.prepareStatement("insert into complaint_tbl_attachments(Complaint_No,Attachment,Attach_Date,U_Id,File_Name,delete_Status)values(?,?,?,?,?,?)");
					ps_unregatt.setString(1, comp_no);
					ps_unregatt.setBlob(2, rs_unreg.getBlob("Mail_Attachment"));
					ps_unregatt.setTimestamp(3,
							rs_unreg.getTimestamp("Recieved_Date"));
					ps_unregatt.setInt(4, uid);
					ps_unregatt.setString(5, rs_unreg.getString("File_Name"));
					ps_unregatt.setInt(6, 1);

					ps_unregatt.executeUpdate();

					PreparedStatement ps_unregHis = con
							.prepareStatement("insert into complaint_tbl_attachment_hist(CA_Hist_date,Complaint_No,Attach_Date,U_Id,File_Name,Delete_Status_Hist)values(?,?,?,?,?,?) ");
					ps_unregHis.setTimestamp(1, bean.getDate());
					ps_unregHis.setString(2, comp_no);
					ps_unregHis.setTimestamp(3,
							rs_unreg.getTimestamp("Recieved_Date"));
					ps_unregHis.setInt(4, uid);
					ps_unregHis.setString(5, rs_unreg.getString("File_Name"));
					ps_unregHis.setInt(6, 1);

					ps_unregHis.executeUpdate();

					System.out.println("Testing file system");
				}

				PreparedStatement ps_unreg1 = con
						.prepareStatement("update complaint_tbl_unassigned_attachment set Delete_Status=1 where unassign_id="
								+ bean.getUnregistered());
				ps_unreg1.executeUpdate();

			}

			flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	public void registered_Unassigned(Register_VO bean) {
		try {
			con = Connection_Utility.getConnection();
			PreparedStatement ps_getreply = con
					.prepareStatement("insert into complaint_unassigned_rel_tbl(unassign_id,complaint_no)values(?,?)");
			ps_getreply.setInt(1, bean.getUnregistered());
			ps_getreply.setString(2, bean.getComplaint_No());
			int reply = ps_getreply.executeUpdate();
			System.out.println("Unassigned Complaint no="
					+ bean.getUnregistered() + " is registered");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
