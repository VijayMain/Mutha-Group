package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionUtility.Connection_Utility;
import com.muthagroup.vo.Customer_Request_VO;
//============================================================================-->
//============================ Data Access Model =============================-->
//============================================================================-->
public class Customer_Request_DAO {

	public boolean attach_File(Customer_Request_VO bean, HttpSession session) {
		boolean flag = false;
		try {

			// ****************************************************************************************
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			// ****************************************************************************************

			PreparedStatement ps_file = null;
			String sr = session.getAttribute("uid").toString();
			int uid = Integer.parseInt(sr);
			int attach_Id = 0;
			Connection con = Connection_Utility.getConnection();

			Timestamp attach_date = timestamp;
			String file_Name = bean.getFile_Name();
			int del = 1;

			// ****************************************************************************************************************************
			// Save attachment to database
			// ****************************************************************************************************************************

			ps_file = con.prepareStatement("insert into crc_tbl_attachment(CRC_No,CRC_Attachment,CRC_Attach_Date,U_Id,CRC_File_Name,Del_Status)values(?,?,?,?,?,?)");
			ps_file.setInt(1, bean.getCrcno());
			ps_file.setBinaryStream(2, bean.getFile_blob());
			ps_file.setTimestamp(3, attach_date);
			ps_file.setInt(4, uid);
			ps_file.setString(5, file_Name);
			ps_file.setInt(6, del);
			int a = ps_file.executeUpdate();

			// ****************************************************************************************************************************
			int attach = 0;
			PreparedStatement ps_del = con
					.prepareStatement("delete from crc_tbl_attachment where CRC_File_Name='"
							+ "" + "'");
			int d = ps_del.executeUpdate();

			PreparedStatement ps_uid = con
					.prepareStatement("select * from crc_tbl_attachment where CRC_No="
							+ bean.getCrcno());
			ResultSet rs_uid = ps_uid.executeQuery();
			while (rs_uid.next()) {
				attach = rs_uid.getInt("CRC_Attach_Id");
			}

			PreparedStatement ps_history = con
					.prepareStatement("insert into crc_tbl_attachment_hist(CRC_Attach_Date_Hist,CRC_No,CRC_Attach_Date_Original,CRC_Attach_Id,U_Id,CRC_File_Name,Del_Status)values(?,?,?,?,?,?,?) ");
			ps_history.setTimestamp(1, timestamp);
			ps_history.setInt(2, bean.getCrcno());
			ps_history.setTimestamp(3, attach_date);
			ps_history.setInt(4, attach);
			ps_history.setInt(5, uid);
			ps_history.setString(6, file_Name);
			ps_history.setInt(7, del);
			int as = ps_history.executeUpdate();
			flag = true;

			PreparedStatement ps_del1 = con
					.prepareStatement("delete from crc_tbl_attachment_hist where CRC_File_Name='"
							+ "" + "'");
			ps_del1.executeUpdate();
			flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean registerChange(Customer_Request_VO bean, ArrayList app_list,
			ArrayList chang_dept, HttpSession session) {
		boolean flag = false;
		try {

			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int count = 0;
			String Name = "", Cust = "", Comp = "", Item = "";
			System.out.println("UID IS ==== " + uid);

			PreparedStatement ps_crc = con.prepareStatement("insert into crc_tbl(CRC_Date,Company_Id,Cust_Id,Item_Id,Change_For,Existing_Change_level,Existing_Change_level_Date,New_Change_level,New_Change_level_Date,Nature_Of_Change,Reason_For_Change,Existing_WIP_Stock,Existing_As_Cast_Stock,Total_Stock,Tooling_Old,Tooling_New,Fixture_Old,Fixture_New,Gauges_Old,Gauges_New,PPAP,Targated_Impl_Date,Actual_Impl_Date,U_Id,Mail_Status,Change_Level)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps_crc.setTimestamp(1, bean.getCRC_Date());
			ps_crc.setInt(2, bean.getCompany_Id());
			ps_crc.setInt(3, bean.getCust_Id());
			ps_crc.setInt(4, bean.getItem_Id());
			ps_crc.setString(5, bean.getChange_For());
			ps_crc.setString(6, bean.getExisting_Change_level());
			ps_crc.setTimestamp(7, bean.getExisting_Change_level_Date());
			ps_crc.setString(8, bean.getNew_Change_level());
			ps_crc.setTimestamp(9, bean.getNew_Change_level_Date());
			ps_crc.setString(10, bean.getNature_Of_Change());
			ps_crc.setString(11, bean.getReason_For_Change());
			ps_crc.setDouble(12, bean.getExisting_WIP_Stock());
			ps_crc.setDouble(13, bean.getExisting_As_Cast_Stock());
			ps_crc.setDouble(14, bean.getTotal_Stock());
			ps_crc.setDouble(15, bean.getTooling_Old());
			ps_crc.setDouble(16, bean.getTooling_New());
			ps_crc.setDouble(17, bean.getFixture_Old());
			ps_crc.setDouble(18, bean.getFixture_New());
			ps_crc.setDouble(19, bean.getGauges_Old());
			ps_crc.setDouble(20, bean.getGauges_New());
			ps_crc.setString(21, bean.getPPAP());
			ps_crc.setTimestamp(22, bean.getTargated_Impl_Date());
			ps_crc.setTimestamp(23, bean.getActual_Impl_Date());
			ps_crc.setInt(24, uid);
			ps_crc.setInt(25, 1);
			ps_crc.setString(26, bean.getChange_Level());

			int crctbl = ps_crc.executeUpdate();

			PreparedStatement ps_crc_Hist = con
					.prepareStatement("insert into crc_tbl_hist(CRC_Date_Hist,Company_Id,Cust_Id,Item_Id,Change_For,Existing_Change_level,Existing_Change_level_Date,New_Change_level,New_Change_level_Date,Nature_Of_Change,Reason_For_Change,Existing_WIP_Stock,Existing_As_Cast_Stock,Total_Stock,Tooling_Old,Tooling_New,Fixture_Old,Fixture_New,Gauges_Old,Gauges_New,PPAP,Targated_Impl_Date,Actual_Impl_Date,U_Id,Mail_Status,Change_Level,CRC_No,CRC_Date_Original)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps_crc_Hist.setTimestamp(1, bean.getCRC_Date());
			ps_crc_Hist.setInt(2, bean.getCompany_Id());
			ps_crc_Hist.setInt(3, bean.getCust_Id());
			ps_crc_Hist.setInt(4, bean.getItem_Id());
			ps_crc_Hist.setString(5, bean.getChange_For());
			ps_crc_Hist.setString(6, bean.getExisting_Change_level());
			ps_crc_Hist.setTimestamp(7, bean.getExisting_Change_level_Date());
			ps_crc_Hist.setString(8, bean.getNew_Change_level());
			ps_crc_Hist.setTimestamp(9, bean.getNew_Change_level_Date());
			ps_crc_Hist.setString(10, bean.getNature_Of_Change());
			ps_crc_Hist.setString(11, bean.getReason_For_Change());
			ps_crc_Hist.setDouble(12, bean.getExisting_WIP_Stock());
			ps_crc_Hist.setDouble(13, bean.getExisting_As_Cast_Stock());
			ps_crc_Hist.setDouble(14, bean.getTotal_Stock());
			ps_crc_Hist.setDouble(15, bean.getTooling_Old());
			ps_crc_Hist.setDouble(16, bean.getTooling_New());
			ps_crc_Hist.setDouble(17, bean.getFixture_Old());
			ps_crc_Hist.setDouble(18, bean.getFixture_New());
			ps_crc_Hist.setDouble(19, bean.getGauges_Old());
			ps_crc_Hist.setDouble(20, bean.getGauges_New());
			ps_crc_Hist.setString(21, bean.getPPAP());
			ps_crc_Hist.setTimestamp(22, bean.getTargated_Impl_Date());
			ps_crc_Hist.setTimestamp(23, bean.getActual_Impl_Date());
			ps_crc_Hist.setInt(24, uid);
			ps_crc_Hist.setInt(25, 1);
			ps_crc_Hist.setString(26, bean.getChange_Level());
			ps_crc_Hist.setInt(27, bean.getCrcno());
			ps_crc_Hist.setTimestamp(28, bean.getCRC_Date());

			int crc_Hist = ps_crc_Hist.executeUpdate();

			// ***********************************************************************************************************************************

			// **********************************************************************************************************************
			// Get List Of selected Approvers======>>>>

			ResultSet rs_app = null;
			
			/*if(app_list.contains(17)){
				System.out.println("total list" + app_list);
				System.out.println("In loop Approval = Anoop Sir");
			}else {
				app_list.add(17);
				System.out.println("total list else loop = " + app_list);
				
			}*/
			
			PreparedStatement ps_app = null;

			for (int f = 0; f < app_list.size(); f++) {

				PreparedStatement ps_approver = con
						.prepareStatement("insert into crc_tbl_approver_rel(CRC_No,U_Id)values(?,?)");
				ps_approver.setInt(1, bean.getCrcno());
				ps_approver.setInt(2,
						Integer.parseInt(app_list.get(f).toString()));

				int app_ctype = ps_approver.executeUpdate();

			}

			// *********************************************************************************************************************

			// ***********************************************************************************************************
			// To maintain logs for Approvers selected ==== >>>>>

			ArrayList list_approver11 = new ArrayList();

			PreparedStatement ps_approver = con
					.prepareStatement("select * from crc_tbl_approver_rel where CRC_No="
							+ bean.getCrcno());
			ResultSet rs_approver = ps_approver.executeQuery();
			while (rs_approver.next()) {
				list_approver11.add(rs_approver.getInt("U_Id"));
			}
			int app_his = 0;
			int user_id = 0;
			System.out
					.print("Approver list Size === " + list_approver11.size());

			for (int appr = 0; appr < list_approver11.size(); appr++) {
				user_id = Integer
						.parseInt(list_approver11.get(appr).toString());
				PreparedStatement ps_approv = con
						.prepareStatement("insert into crc_tbl_approver_rel_hist(CRC_A_Rel_Hist_Date,CRC_No,U_Id)values(?,?,?)");
				ps_approv.setTimestamp(1, bean.getCRC_Date());
				ps_approv.setInt(2, bean.getCrcno());
				ps_approv.setInt(3, user_id);

				app_his = ps_approv.executeUpdate();

				// *********************************************************************************************************************

				System.out.println("..... user Id inserting.... " + user_id);

				PreparedStatement ps_approval = con
						.prepareStatement("insert into crc_tbl_approval(U_Id,CRC_No,Approval_Id)values(?,?,?)");
				ps_approval.setInt(1, user_id);
				ps_approval.setInt(2, bean.getCrcno());
				ps_approval.setInt(3, 2);

				int ap = ps_approval.executeUpdate();

				PreparedStatement ps_approval_hist = con
						.prepareStatement("insert into crc_tbl_approval_hist(U_Id,CRC_No,Approval_Id)values(?,?,?)");
				ps_approval_hist.setInt(1, user_id);
				ps_approval_hist.setInt(2, bean.getCrcno());
				ps_approval_hist.setInt(3, 2);

				int app = ps_approval_hist.executeUpdate();

				// *********************************************************************************************************************

			}
			// *************************************************************************************************************

			// *********************************************************************************************************************
			// Get selected Departments ======== >>>

			ResultSet rstype = null;
			ArrayList changedept_list = new ArrayList();
			for (int ch = 0; ch < chang_dept.size(); ch++) {
				PreparedStatement pstype_change = con.prepareStatement("select * from user_tbl_dept where Department='"
								+ chang_dept.get(ch).toString() + "'");
				rstype = pstype_change.executeQuery();
				while (rstype.next()) {
					changedept_list.add(rstype.getInt("dept_id"));
				}
			}

			for (int ct = 0; ct < changedept_list.size(); ct++) {

				PreparedStatement ps_cr_change = con.prepareStatement("insert into crc_tbl_cocern_dept(CRC_No,Dept_Id)values(?,?)");
				ps_cr_change.setInt(1, bean.getCrcno());
				ps_cr_change.setInt(2, Integer.parseInt(changedept_list.get(ct).toString()));

				int ctype = ps_cr_change.executeUpdate();
			}

			// *********************************************************************************************************************

			PreparedStatement ps_uid = con.prepareStatement("select * from user_tbl where U_Id="
							+ uid);
			ResultSet rs_uid = ps_uid.executeQuery();
			while (rs_uid.next()) {
				Name = rs_uid.getString("U_Name");
			}
			PreparedStatement ps_cust = con.prepareStatement("select * from customer_tbl where Cust_Id="
							+ bean.getCust_Id());
			ResultSet rs_cust = ps_cust.executeQuery();
			while (rs_cust.next()) {
				Cust = rs_cust.getString("Cust_Name");
			}
			PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="
							+ bean.getCompany_Id());
			ResultSet rs_comp = ps_comp.executeQuery();
			while (rs_comp.next()) {
				Comp = rs_comp.getString("Company_Name");
			}

			PreparedStatement ps_item = con.prepareStatement("select * from customer_tbl_item where Item_Id="
							+ bean.getItem_Id());
			ResultSet rs_item = ps_item.executeQuery();
			while (rs_item.next()) {
				Item = rs_item.getString("Item_Name");
			}

			ArrayList approvers = new ArrayList();

			for (int p = 0; p < app_list.size(); p++) {

				PreparedStatement ps_p = con.prepareStatement("select * from user_tbl where U_Id="
								+ Integer.parseInt(app_list.get(p).toString()));
				ResultSet rs_p = ps_p.executeQuery();
				while (rs_p.next()) {
					approvers.add(rs_p.getString("U_Name"));
				}
			}
			// ***********************************************************************************************************
			// Email Configuration ======= >>

			flag = true;

			String host = "send.one.com";
			String user = "ecn@muthagroup.com";
			String pass = "ecn@xyz";

			Date date11 = Calendar.getInstance().getTime();
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			String today = formatter.format(date11);

			String from = "ecn@muthagroup.com";
			String subject = "New Change Request Received from " + Comp;
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			/*PreparedStatement ps6 = con
					.prepareStatement("select count(Email) from automail where Company_id=6 or company_id="
							+ bean.getCompany_Id());
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Email)");
			}*/

			/*PreparedStatement ps6 = con
					.prepareStatement("select count(Email) from automail where Company_id=6 or company_id="
							+ bean.getCompany_Id());
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Email)");
			}

			PreparedStatement ps_auto = con
					.prepareStatement("select * from automail where Company_id=6 or company_id="
							+ bean.getCompany_Id());
			ResultSet rs_auto = ps_auto.executeQuery();
			String[] recipients = new String[count + app_list.size()];

			ArrayList assign_mail = new ArrayList();

			for (int mail = 0; mail < app_list.size(); mail++) {
				PreparedStatement ps_assign = con
						.prepareStatement("select * from user_tbl where U_Id="
								+ app_list.get(mail));
				ResultSet rs_assign = ps_assign.executeQuery();
				while (rs_assign.next()) {
					recipients[mail] = rs_assign.getString("U_Email");
				}
			}
			int j = app_list.size();
			System.out.println("Size List = " + j);
			while (rs_auto.next()) {
				recipients[j] = rs_auto.getString("Email");
				j++;
			}*/
			ArrayList listemailTo = new ArrayList();
			
			for (int mail = 0; mail < app_list.size(); mail++) {
				PreparedStatement ps_assign = con.prepareStatement("select * from user_tbl where U_Id=" + app_list.get(mail));
				ResultSet rs_assign = ps_assign.executeQuery();
				while (rs_assign.next()) {
					if(rs_assign.getString("U_Email")!=null){
					listemailTo.add(rs_assign.getString("U_Email"));
					}
				}
			}
			
			PreparedStatement ps_assign = con.prepareStatement("select * from user_tbl where U_Id=" + uid);
			ResultSet rs_assign = ps_assign.executeQuery();
			while (rs_assign.next()) {
				if(rs_assign.getString("U_Email")!=null){
				listemailTo.add(rs_assign.getString("U_Email"));
				}
			}
			 
			String recipients[] = new String[listemailTo.size()];  
			for(int i=0;i<listemailTo.size();i++){
				recipients[i] = listemailTo.get(i).toString();
			} 
			
			
			// *********************************************************************************************
			// String recipients[] = { "vijaybm@muthagroup.com",
			// "amitcp@muthagroup.com" };

			Properties props = System.getProperties();
			props.put("mail.host", host);
			
			/*props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 2525);*/
			
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 465);
			
			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(sessionDebug);
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from));
			InternetAddress[] addressTo = new InternetAddress[recipients.length];

			for (int i = 0; i < recipients.length; i++) {
				addressTo[i] = new InternetAddress(recipients[i]);
			}

			msg.setRecipients(Message.RecipientType.TO, addressTo);

			msg.setSubject(subject);
			msg.setSentDate(new Date());


			msg.setContent(
					"<b>Request Number :</b>"
							+ bean.getCrcno()
							+ ", "
							+ "<p><b>Company :  </b>"
							+ Comp
							+ ", "
							+ "</p>"
							+ "<p><b>Customer :  </b>"
							+ Cust
							+ ", "
							+ "</p>"
							+ "<p><b>Part Name : </b>"
							+ Item
							+ ", "
							+ " </p>"

							+ "<p><b>Change For : </b>"
							+ bean.getChange_For()

							+ ", "
							+ "</p>"
							+ "<p><b>Nature of Change : </b>"
							+ bean.getNature_Of_Change()
							+ ", "
							+ "</p>"
							+ "<p><b>Reason for change  : </b>"
							+ bean.getReason_For_Change()

							+ ", "
							+ "</p>"

							+ "<p><b>Total Existing Stock :</b> "
							+ bean.getTotal_Stock()
							+ ", "
							+ " </p>"
							+ "<p><b>Targeted date for implementation: </b>"
							+ bean.getTargated_Impl_Date()
							+ ", "
							+ "</p>"

							+ "<p><b>Approvers : </b>"
							+ approvers
							+ ", "
							+ "</p>"
							+ "<p><b>Concern Dept : </b>"
							+ chang_dept
							+ ", "
							+ "</p>"

							+ "<p><b>Change Request Received from :</b>"
							+ Name
							+ ", "
							+ "</p>"
							+ "<p><b>Change Received date :</b>"
							+ bean.getCRC_Date()
							+ ", "
							+ " </p>"

							+ "<p><font size='2'><b style='color: #0D265E;'>This is an automatically generated email from ECN(Engineering Change Note)</b></font>"
							+ "</p>"
							+ "<p><b>For more details ,</b> "
							+ "<a href='http://192.168.0.7/ECN'>Click Here</a></p>"
							+ " <p><b style='color: #330B73;'>Thanks & Regards </b></p><p> Mutha Group Satara </p>"
							+ "<hr>"
							+ "<p><b>Disclaimer :</b></p>"
							+ "<font face='Times New Roman' size='1'>"
							+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
					"Text/html");

			try {

				Transport transport = mailSession.getTransport("smtp");

				if (transport.equals("")) {

					// transport.connect(host, user, pass);
					// transport.sendMessage(msg, msg.getAllRecipients());
					PreparedStatement ps_mailcheck = con
							.prepareStatement("update crc_tbl set Mail_Status=0 where CRC_No="
									+ bean.getCrcno());
					int mail = ps_mailcheck.executeUpdate();
				} else {
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());
				}
				transport.close();
				flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			// **********************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	//============================================================================-->
	//============================ Attach file Data Access Model =============================-->
	//============================================================================-->
	public boolean Editattach_File(Customer_Request_VO bean, HttpSession session) {
		boolean flag = false;
		try {

			// ****************************************************************************************
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			// ****************************************************************************************

			PreparedStatement ps_file = null;
			String sr = session.getAttribute("uid").toString();
			int uid = Integer.parseInt(sr);
			int attach_Id = 0;
			Connection con = Connection_Utility.getConnection();

			Timestamp attach_date = timestamp;
			String file_Name = bean.getFile_Name();
			int del = 1;

			// ****************************************************************************************************************************
			// Save attachment to database
			// ****************************************************************************************************************************

			ps_file = con
					.prepareStatement("insert into crc_tbl_attachment(CRC_No,CRC_Attachment,CRC_Attach_Date,U_Id,CRC_File_Name,Del_Status)values(?,?,?,?,?,?)");
			ps_file.setInt(1, bean.getCrcno());
			ps_file.setBinaryStream(2, bean.getFile_blob());
			ps_file.setTimestamp(3, attach_date);
			ps_file.setInt(4, uid);
			ps_file.setString(5, file_Name);
			ps_file.setInt(6, del);
			int a = ps_file.executeUpdate();

			// ****************************************************************************************************************************
			int attach = 0;
			PreparedStatement ps_del = con
					.prepareStatement("delete from crc_tbl_attachment where CRC_File_Name='"
							+ "" + "'");
			int d = ps_del.executeUpdate();

			PreparedStatement ps_uid = con
					.prepareStatement("select * from crc_tbl_attachment where CRC_No="
							+ bean.getCrcno());
			ResultSet rs_uid = ps_uid.executeQuery();
			while (rs_uid.next()) {
				attach = rs_uid.getInt("CRC_Attach_Id");
			}

			PreparedStatement ps_history = con
					.prepareStatement("insert into crc_tbl_attachment_hist(CRC_Attach_Date_Hist,CRC_No,CRC_Attach_Date_Original,CRC_Attach_Id,U_Id,CRC_File_Name,Del_Status)values(?,?,?,?,?,?,?) ");
			ps_history.setTimestamp(1, timestamp);
			ps_history.setInt(2, bean.getCrcno());
			ps_history.setTimestamp(3, attach_date);
			ps_history.setInt(4, attach);
			ps_history.setInt(5, uid);
			ps_history.setString(6, file_Name);
			ps_history.setInt(7, del);
			int as = ps_history.executeUpdate();
			flag = true;

			PreparedStatement ps_del1 = con
					.prepareStatement("delete from crc_tbl_attachment_hist where CRC_File_Name='"
							+ "" + "'");
			ps_del1.executeUpdate();
			flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean EditregisterChange(Customer_Request_VO bean,
			ArrayList app_list, ArrayList chang_dept, HttpSession session) {
		boolean flag = false;
		try {

			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int crcno = bean.getCrcno();
			int count = 0;
			String Name = "", Cust = "", Comp = "", Item = "";
			System.out.println("UID IS ==== " + uid);

			PreparedStatement ps_crc = con
					.prepareStatement("update crc_tbl set CRC_Date=?,Company_Id=?,Cust_Id=?,Item_Id=?,Change_For=?,Existing_Change_level=?,Existing_Change_level_Date=?,New_Change_level=?,New_Change_level_Date=?,Nature_Of_Change=?,Reason_For_Change=?,Existing_WIP_Stock=?,Existing_As_Cast_Stock=?,Total_Stock=?,Tooling_Old=?,Tooling_New=?,Fixture_Old=?,Fixture_New=?,Gauges_Old=?,Gauges_New=?,PPAP=?,Targated_Impl_Date=?,Actual_Impl_Date=?,U_Id=?,Mail_Status=?,Change_Level=? where CRC_No="
							+ crcno);
			ps_crc.setTimestamp(1, bean.getCRC_Date());
			ps_crc.setInt(2, bean.getCompany_Id());
			ps_crc.setInt(3, bean.getCust_Id());
			ps_crc.setInt(4, bean.getItem_Id());
			ps_crc.setString(5, bean.getChange_For());
			ps_crc.setString(6, bean.getExisting_Change_level());
			ps_crc.setTimestamp(7, bean.getExisting_Change_level_Date());
			ps_crc.setString(8, bean.getNew_Change_level());
			ps_crc.setTimestamp(9, bean.getNew_Change_level_Date());
			ps_crc.setString(10, bean.getNature_Of_Change());
			ps_crc.setString(11, bean.getReason_For_Change());
			ps_crc.setDouble(12, bean.getExisting_WIP_Stock());
			ps_crc.setDouble(13, bean.getExisting_As_Cast_Stock());
			ps_crc.setDouble(14, bean.getTotal_Stock());
			ps_crc.setDouble(15, bean.getTooling_Old());
			ps_crc.setDouble(16, bean.getTooling_New());
			ps_crc.setDouble(17, bean.getFixture_Old());
			ps_crc.setDouble(18, bean.getFixture_New());
			ps_crc.setDouble(19, bean.getGauges_Old());
			ps_crc.setDouble(20, bean.getGauges_New());
			ps_crc.setString(21, bean.getPPAP());
			ps_crc.setTimestamp(22, bean.getTargated_Impl_Date());
			ps_crc.setTimestamp(23, bean.getActual_Impl_Date());
			ps_crc.setInt(24, uid);
			ps_crc.setInt(25, 1);
			ps_crc.setString(26, bean.getChange_Level());

			int crctbl = ps_crc.executeUpdate();

			PreparedStatement ps_crc_Hist = con
					.prepareStatement("update crc_tbl_hist set CRC_Date_Hist=?,Company_Id=?,Cust_Id=?,Item_Id=?,Change_For=?,Existing_Change_level=?,Existing_Change_level_Date=?,New_Change_level=?,New_Change_level_Date=?,Nature_Of_Change=?,Reason_For_Change=?,Existing_WIP_Stock=?,Existing_As_Cast_Stock=?,Total_Stock=?,Tooling_Old=?,Tooling_New=?,Fixture_Old=?,Fixture_New=?,Gauges_Old=?,Gauges_New=?,PPAP=?,Targated_Impl_Date=?,Actual_Impl_Date=?,U_Id=?,Mail_Status=?,Change_Level=?,CRC_No=?,CRC_Date_Original=? where CRC_No="
							+ crcno);
			ps_crc_Hist.setTimestamp(1, bean.getCRC_Date());
			ps_crc_Hist.setInt(2, bean.getCompany_Id());
			ps_crc_Hist.setInt(3, bean.getCust_Id());
			ps_crc_Hist.setInt(4, bean.getItem_Id());
			ps_crc_Hist.setString(5, bean.getChange_For());
			ps_crc_Hist.setString(6, bean.getExisting_Change_level());
			ps_crc_Hist.setTimestamp(7, bean.getExisting_Change_level_Date());
			ps_crc_Hist.setString(8, bean.getNew_Change_level());
			ps_crc_Hist.setTimestamp(9, bean.getNew_Change_level_Date());
			ps_crc_Hist.setString(10, bean.getNature_Of_Change());
			ps_crc_Hist.setString(11, bean.getReason_For_Change());
			ps_crc_Hist.setDouble(12, bean.getExisting_WIP_Stock());
			ps_crc_Hist.setDouble(13, bean.getExisting_As_Cast_Stock());
			ps_crc_Hist.setDouble(14, bean.getTotal_Stock());
			ps_crc_Hist.setDouble(15, bean.getTooling_Old());
			ps_crc_Hist.setDouble(16, bean.getTooling_New());
			ps_crc_Hist.setDouble(17, bean.getFixture_Old());
			ps_crc_Hist.setDouble(18, bean.getFixture_New());
			ps_crc_Hist.setDouble(19, bean.getGauges_Old());
			ps_crc_Hist.setDouble(20, bean.getGauges_New());
			ps_crc_Hist.setString(21, bean.getPPAP());
			ps_crc_Hist.setTimestamp(22, bean.getTargated_Impl_Date());
			ps_crc_Hist.setTimestamp(23, bean.getActual_Impl_Date());
			ps_crc_Hist.setInt(24, uid);
			ps_crc_Hist.setInt(25, 1);
			ps_crc_Hist.setString(26, bean.getChange_Level());
			ps_crc_Hist.setInt(27, bean.getCrcno());
			ps_crc_Hist.setTimestamp(28, bean.getCRC_Date());

			int crc_Hist = ps_crc_Hist.executeUpdate();

			// ***********************************************************************************************************************************

			// **********************************************************************************************************************
			// Get List Of selected Approvers======>>>>
			PreparedStatement ps_approvaldel = con
					.prepareStatement("delete from crc_tbl_approver_rel where CRC_No="
							+ crcno);
			int psap = ps_approvaldel.executeUpdate();

			if(app_list.contains(17)){
				System.out.println("total list" + app_list);
				System.out.println("In loop Approval = Anoop Sir");
			}else {
				app_list.add(17);
				System.out.println("total list else loop = " + app_list);
				
			}
			
			ResultSet rs_app = null;

			PreparedStatement ps_app = null;

			System.out.println("App list on DAO =  " + app_list);

			for (int f = 0; f < app_list.size(); f++) {

				PreparedStatement ps_approver = con
						.prepareStatement("insert into crc_tbl_approver_rel(CRC_No,U_Id)values(?,?)");
				ps_approver.setInt(1, bean.getCrcno());
				ps_approver.setInt(2,
						Integer.parseInt(app_list.get(f).toString()));

				int app_ctype = ps_approver.executeUpdate();

			}

			// *********************************************************************************************************************

			// ***********************************************************************************************************
			// To maintain logs for Approvers selected ==== >>>>>

			ArrayList list_approver11 = new ArrayList();

			PreparedStatement ps_approver = con
					.prepareStatement("select * from crc_tbl_approver_rel where CRC_No="
							+ bean.getCrcno());
			ResultSet rs_approver = ps_approver.executeQuery();
			while (rs_approver.next()) {
				list_approver11.add(rs_approver.getInt("U_Id"));
			}
			int app_his = 0;
			int user_id = 0;
			System.out
					.print("Approver list Size === " + list_approver11.size());

			for (int appr = 0; appr < list_approver11.size(); appr++) {
				user_id = Integer
						.parseInt(list_approver11.get(appr).toString());
				PreparedStatement ps_approv = con
						.prepareStatement("insert into crc_tbl_approver_rel_hist(CRC_A_Rel_Hist_Date,CRC_No,U_Id)values(?,?,?)");
				ps_approv.setTimestamp(1, bean.getCRC_Date());
				ps_approv.setInt(2, bean.getCrcno());
				ps_approv.setInt(3, user_id);

				app_his = ps_approv.executeUpdate();

				// *********************************************************************************************************************

				PreparedStatement ps_approvalcrcdel = con
						.prepareStatement("delete from crc_tbl_approval where CRC_No="
								+ crcno);
				int crc_psap = ps_approvalcrcdel.executeUpdate();
				for (int appr11 = 0; appr11 < list_approver11.size(); appr11++) {

					System.out
							.println("..... user Id inserting.... " + user_id);

					PreparedStatement ps_approval = con
							.prepareStatement("insert into crc_tbl_approval(U_Id,CRC_No,Approval_Id)values(?,?,?)");
					ps_approval.setInt(1, Integer.parseInt(list_approver11.get(
							appr11).toString()));
					ps_approval.setInt(2, bean.getCrcno());
					ps_approval.setInt(3, 2);

					int ap = ps_approval.executeUpdate();

					PreparedStatement ps_approval_hist = con
							.prepareStatement("insert into crc_tbl_approval_hist(U_Id,CRC_No,Approval_Id)values(?,?,?)");
					ps_approval_hist.setInt(1, Integer.parseInt(list_approver11
							.get(appr11).toString()));
					ps_approval_hist.setInt(2, bean.getCrcno());
					ps_approval_hist.setInt(3, 2);

					int app = ps_approval_hist.executeUpdate();

					// *********************************************************************************************************************
				}
			}
			// *************************************************************************************************************

			// *********************************************************************************************************************
			// Get selected Departments ======== >>>

			PreparedStatement ps_deptcrcdel = con
					.prepareStatement("delete from crc_tbl_cocern_dept where CRC_No="
							+ crcno);
			int crc_dept = ps_deptcrcdel.executeUpdate();

			ResultSet rstype = null;
			ArrayList changedept_list = new ArrayList();
			for (int ch = 0; ch < chang_dept.size(); ch++) {
				PreparedStatement pstype_change = con
						.prepareStatement("select * from user_tbl_dept where Department='"
								+ chang_dept.get(ch).toString() + "'");
				rstype = pstype_change.executeQuery();
				while (rstype.next()) {
					changedept_list.add(rstype.getInt("dept_id"));
				}
			}

			for (int ct = 0; ct < changedept_list.size(); ct++) {

				PreparedStatement ps_cr_change = con
						.prepareStatement("insert into crc_tbl_cocern_dept(CRC_No,Dept_Id)values(?,?)");
				ps_cr_change.setInt(1, bean.getCrcno());
				ps_cr_change.setInt(2,
						Integer.parseInt(changedept_list.get(ct).toString()));

				int ctype = ps_cr_change.executeUpdate();
			}

			// *********************************************************************************************************************

			PreparedStatement ps_uid = con
					.prepareStatement("select * from user_tbl where U_Id="
							+ uid);
			ResultSet rs_uid = ps_uid.executeQuery();
			while (rs_uid.next()) {
				Name = rs_uid.getString("U_Name");
			}
			PreparedStatement ps_cust = con
					.prepareStatement("select * from customer_tbl where Cust_Id="
							+ bean.getCust_Id());
			ResultSet rs_cust = ps_cust.executeQuery();
			while (rs_cust.next()) {
				Cust = rs_cust.getString("Cust_Name");
			}
			PreparedStatement ps_comp = con
					.prepareStatement("select * from user_tbl_company where Company_Id="
							+ bean.getCompany_Id());
			ResultSet rs_comp = ps_comp.executeQuery();
			while (rs_comp.next()) {
				Comp = rs_comp.getString("Company_Name");
			}

			PreparedStatement ps_item = con
					.prepareStatement("select * from customer_tbl_item where Item_Id="
							+ bean.getItem_Id());
			ResultSet rs_item = ps_item.executeQuery();
			while (rs_item.next()) {
				Item = rs_item.getString("Item_Name");
			}

			ArrayList approvers = new ArrayList();

			for (int p = 0; p < app_list.size(); p++) {

				PreparedStatement ps_p = con
						.prepareStatement("select * from user_tbl where U_Id="
								+ Integer.parseInt(app_list.get(p).toString()));
				ResultSet rs_p = ps_p.executeQuery();
				while (rs_p.next()) {
					approvers.add(rs_p.getString("U_Name"));
				}
			}
			// ***********************************************************************************************************
			// Email Configuration =======>>

			flag = true;

			String host = "send.one.com";
			String user = "ecn@muthagroup.com";
			String pass = "ecn@xyz";

			Date date11 = Calendar.getInstance().getTime();
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			String today = formatter.format(date11);

			String from = "ecn@muthagroup.com";
			String subject = "New Change Request Received from  "+Comp;
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			PreparedStatement ps6 = con
					.prepareStatement("select count(Email) from automail where Company_id=6 or company_id="
							+ bean.getCompany_Id());
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Email)");
			}

			PreparedStatement ps_auto = con
					.prepareStatement("select * from automail where Company_id=6 or company_id="
							+ bean.getCompany_Id());
			ResultSet rs_auto = ps_auto.executeQuery();
			String[] recipients = new String[count + app_list.size()];

			ArrayList assign_mail = new ArrayList();

			for (int mail = 0; mail < app_list.size(); mail++) {
				PreparedStatement ps_assign = con
						.prepareStatement("select * from user_tbl where U_Id="
								+ app_list.get(mail));
				ResultSet rs_assign = ps_assign.executeQuery();
				while (rs_assign.next()) {
					recipients[mail] = rs_assign.getString("U_Email");
				}
			}
			int j = app_list.size();
			System.out.println("Size List = " + j);
			while (rs_auto.next()) {
				recipients[j] = rs_auto.getString("Email");
				j++;
			}
			// *********************************************************************************************
			// String recipients[] = { "vijaybm@muthagroup.com",
			// "amitcp@muthagroup.com" };

			Properties props = System.getProperties();
			props.put("mail.host", host);
			
			/*props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 2525);*/
			
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 465);
			
			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(sessionDebug);
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from));
			InternetAddress[] addressTo = new InternetAddress[recipients.length];

			for (int i = 0; i < recipients.length; i++) {
				addressTo[i] = new InternetAddress(recipients[i]);
			}

			msg.setRecipients(Message.RecipientType.TO, addressTo);

			msg.setSubject(subject);
			msg.setSentDate(new Date());

			msg.setContent(
					"<p><b>Request Number :</b>"
							+ bean.getCrcno()
							+ ", "

							+ "<p><b>Company :  </b>"
							+ Comp
							+ ", "
							+ "</p>"
							+ "<p><b>Customer :  </b>"
							+ Cust
							+ ", "
							+ "</p>"
							+ "<p><b>Part Name : </b>"
							+ Item
							+ ", "
							+ " </p>"

							+ "<p><b>Change For : </b>"
							+ bean.getChange_For()

							+ ", "
							+ "</p>"
							+ "<p><b>Nature of Change : </b>"
							+ bean.getNature_Of_Change()
							+ ", "
							+ "</p>"
							+ "<p><b>Reason for change  : </b>"
							+ bean.getReason_For_Change()

							+ ", "
							+ "</p>"

							+ "<p><b>Total Existing Stock :</b> "
							+ bean.getTotal_Stock()
							+ ", "
							+ " </p>"
							+ "<p><b>Targeted date for implementation: </b>"
							+ bean.getTargated_Impl_Date()
							+ ", "
							+ "</p>"

							+ "<p><b>Approvers : </b>"
							+ approvers
							+ ", "
							+ "</p>"
							+ "<p><b>Concern Dept : </b>"
							+ chang_dept
							+ ", "
							+ "</p>"

							+ "<p><b>Change Request Received from :</b>"
							+ Name
							+ ", "
							+ "</p>"

							+ "<p><b>Change Received date :</b>"
							+ bean.getCRC_Date()
							+ ", "
							+ " </p>"

							+ "<p><font size='2'><b style='color: #0D265E;'>This is an automatically generated email from ECN(Engineering Change Note)</b></font>"
							+ "</p>"
							+ "<p><b>For more details ,</b> "
							+ "<a href='http://192.168.0.7/ECN'>Click Here</a></p>"
							+ " <p><b style='color: #330B73;'>Thanks & Regards </b></p><p> Mutha Group Satara </p>"
							+ "<hr>"
							+ "<p><b>Disclaimer :</b></p>"
							+ "<font face='Times New Roman' size='1'>"
							+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
					"Text/html");

			try {

				Transport transport = mailSession.getTransport("smtp");

				if (transport.equals("")) {

					// transport.connect(host, user, pass);
					// transport.sendMessage(msg, msg.getAllRecipients());
					PreparedStatement ps_mailcheck = con
							.prepareStatement("update crc_tbl set Mail_Status=0 where CRC_No="
									+ bean.getCrcno());
					int mail = ps_mailcheck.executeUpdate();
				} else {
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());
				}
				transport.close();
				flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			// **********************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}
