package com.muthagroup.dao;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Complaint_Action_VO;

public class Complaint_Action_Dao {

	// System date
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// get current date time with Date()
	Date date = new Date();
	// System.out.println("by date..:" + dateFormat.format(date));

	java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());

	java.sql.Timestamp complaint_date = null, Complaint_Date = null;
	String Complaint_Received_By = null, Complaint_Description = null,
			custName = null, company = null, part = null;
	int cust_id = 0, item_id = 0, Defect_Id = 0, Complaint_Related_To = 0,
			Complaint_Assigned_To = 0, Category_Id = 0, Company_Id = 0,
			P_Id = 0, status_id = 0;
	int count = 0;

	// System.out.println("by TIMESTAMP..:" + timestamp);

	public boolean complaint_action(Complaint_Action_VO bean,
			HttpSession session) {
		boolean flag = false;
		try {
			System.out.println("Test bean == " + bean.getAction_Type());

			// **********************************************************************************
			// Set session attribute
			String complaint_no = session.getAttribute("complaint_no")
					.toString();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());

			System.out.println(complaint_no);
			Connection con = Connection_Utility.getConnection();
			// *********************************************************************************************
			// *********************************************************************************************
			// To Auto Complete Action type logic
			// **********************************************************************************************
			Statement st = con.createStatement();
			ResultSet rs_atype = st
					.executeQuery("select * from Action_Type_Tbl");

			List li = new ArrayList();

			while (rs_atype.next()) {
				li.add(rs_atype.getString("Action_Type"));
			}

			String str1 = null;
			Iterator it = li.iterator();
			str1 = bean.getAction_Type();
			System.out.println("Testing string ==== " + str1);
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
						.prepareStatement("insert into Action_Type_Tbl (Action_Type)values(?)");
				st1.setString(1, str1);
				st1.executeUpdate();

			}

			// *********************************************************************************************
			PreparedStatement ps = con
					.prepareStatement("select * from complaint_tbl where Complaint_No='"
							+ complaint_no + "'");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				complaint_date = rs.getTimestamp("Complaint_Date");
				cust_id = rs.getInt("Cust_Id");
				item_id = rs.getInt("Item_Id");
				Defect_Id = rs.getInt("Defect_Id");
				Complaint_Received_By = rs.getString("Complaint_Received_By");
				Complaint_Description = rs.getString("Complaint_Description");
				Complaint_Related_To = rs.getInt("Complaint_Related_To");
				Complaint_Assigned_To = rs.getInt("Complaint_Assigned_To");
				Category_Id = rs.getInt("Category_Id");
				Company_Id = rs.getInt("Company_Id");
				Complaint_Date = rs.getTimestamp("Complaint_Date");
				P_Id = rs.getInt("P_Id");
				status_id = rs.getInt("Status_Id");

			}
			// *******************************************************************************************************
			PreparedStatement ps_stat_up = con
					.prepareStatement("update complaint_tbl set Status_Id=? where Complaint_No='"
							+ complaint_no + "'");
			ps_stat_up.setInt(1, bean.getStatus());
			ps_stat_up.executeUpdate();

			// *******************************************************************************************
			// Email for status change
			// *******************************************************************************************

			String status_change = null;
			if (bean.getStatus() != status_id) {
				// *****************************************************************************************

				PreparedStatement ps_status = con
						.prepareStatement("select * from status_tbl where Status_Id="
								+ bean.getStatus());
				ResultSet rs_status = ps_status.executeQuery();
				while (rs_status.next()) {
					status_change = rs_status.getString("Status");
					System.out.println("Status = " + status_change);
				}
				// ****************************************************************************************
				String old_status = null;
				PreparedStatement ps_old_stat = con
						.prepareStatement("select * from status_tbl where Status_Id="
								+ status_id);
				ResultSet rs_old_stat = ps_old_stat.executeQuery();
				while (rs_old_stat.next()) {
					old_status = rs_old_stat.getString("Status");
				}

				// ****************************************************************************************
				String user1 = null;
				String assign_mail = null;
				PreparedStatement ps_user = con
						.prepareStatement("select * from user_tbl where U_Id="
								+ uid);
				ResultSet rs_user = ps_user.executeQuery();
				while (rs_user.next()) {
					user1 = rs_user.getString("U_Name");
					assign_mail = rs_user.getString("U_Email");
				}

				PreparedStatement ps_cust = con
						.prepareStatement("select * from customer_tbl where Cust_Id="
								+ cust_id);
				ResultSet rs_cust = ps_cust.executeQuery();
				while (rs_cust.next()) {
					custName = rs_cust.getString("Cust_Name");
				}

				PreparedStatement ps_comp = con
						.prepareStatement("select * from user_tbl_company where Company_Id="
								+ Company_Id);
				ResultSet rs_comp = ps_comp.executeQuery();
				while (rs_comp.next()) {
					company = rs_comp.getString("Company_Name");
				}

				PreparedStatement ps_part = con
						.prepareStatement("select * from customer_tbl_item where Item_Id="
								+ item_id);
				ResultSet rs_part = ps_part.executeQuery();
				while (rs_part.next()) {
					part = rs_part.getString("Item_Name");
				}

				// ***************************************************************************************
				// Email logic
				// ****************************************************************************************
				String host = "send.one.com";
				String user = "complaintzilla@muthagroup.com";
				String pass = "complaintzilla1";
				// String to = "amitpawar4182@gmail.com";

				String from = "complaintzilla@muthagroup.com";
				String subject = company + " " + part + " Complaint Status is "
						+ status_change;
				// String messageText =
				// "\nThis is an automatically generated email from ComplaintZilla "
				// + " \n\n"
				// + "Complaint Received date : "
				// + Complaint_Date
				// + "\n"
				// + "Action Taken By "
				// + user1
				// + "\n"
				// + "Status changed from : "
				// + old_status
				// + " \n"
				// + "to : "
				// + status_change
				// + "\n"
				// + "Action Type : "
				// + bean.getAction_Type()
				// + "\n"
				// + "Complaint Action Description : \n "
				// + bean.getAction_description()
				// + "\n\n"
				// + "For more details visit, "
				// + "http://192.168.0.7/ComplaintZilla/"
				// + " \n\n\nThanks & Regards \n Mutha Group Satara";
				boolean sessionDebug = false;
				// multiple recipients : == >
				// String recipients[] = { "vijaybm@muthagroup.com",
				// "amitcp@muthagroup.com" };

				// *********************************************************************************************
				PreparedStatement ps6 = con
						.prepareStatement("select count(Email) from automail where company_id=6 or company_id="
								+ Company_Id);
				ResultSet rs6 = ps6.executeQuery();
				while (rs6.next()) {
					count = rs6.getInt("count(Email)");
				}

				PreparedStatement ps_auto = con
						.prepareStatement("select * from automail where company_id=6 or company_id="
								+ Company_Id);
				ResultSet rs_auto = ps_auto.executeQuery();
				String[] recipients = new String[count + 1];
				int j = 1;
				recipients[0] = assign_mail;
				while (rs_auto.next()) {
					recipients[j] = rs_auto.getString("Email");
					j++;
				}
				// *********************************************************************************************

				Properties props = System.getProperties();
				props.put("mail.host", host);
				props.put("mail.transport.protocol", "smtp");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.port", 2525);

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

				// Create the message part
				BodyPart messageBodyPart = new MimeBodyPart();
				// Fill the message
				// messageBodyPart.setText("This is message body");
				messageBodyPart
						.setContent(
								"<b>Complaint Number : </b>"
										+ complaint_no
										+ ", "
										+ "<p><b>Status changed from : </b>"
										+ old_status
										+ "<b> to </b>"
										+ status_change
										+ ", "
										+ " </p>"

										+ "<p><b>Action Type : </b>"
										+ bean.getAction_Type()
										+ ", "
										+ " </p>"
										+ "<p><b>Complaint Action Description :</b></p><p>"
										+ bean.getAction_description()
										+ "</p>"

										+ "<p><b>Action Taken By : </b>"
										+ user1
										+ ", "
										+ " </p>"

										+ "<p><b>Complaint Received date :</b>"
										+ Complaint_Date
										+ ", "
										+ " </p>"

										+ "<b style='color: #0B25E3;'><blink>Action taken on complaint</blink></b>"

										+ "<p><font size='2'><b style='color: #0D265E;'>This is an automatically generated email from ComplaintZilla</b></font>"
										+ "</p>"

										+ "<p><b>For more details ,</b> "
										+ "<a href='http://192.168.0.7/ComplaintZilla/'>Click Here</a></p>"
										+ "<p><b style='color: #330B73;'>Thanks & Regards </b></br> Mutha Group Satara </p>"
										+ "<hr>"
										+ "<p><b>Disclaimer :</b></p>"
										+ "<font face='Times New Roman' size='1'>"
										+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
								"Text/html");
				// Create a multipar message
				Multipart multipart = new MimeMultipart();

				// Set text message part
				multipart.addBodyPart(messageBodyPart);

				// Part two is attachment
				messageBodyPart = new MimeBodyPart();

				// _______________________________________________________________________________________________________________
				// ComplaintZilla Report Logic ============== >

				try {

					JasperReport jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/CZReport.jrxml");
					Map parameters = new HashMap();
					JasperPrint jasperPrint = JasperFillManager.fillReport(
							jasperReport, parameters, con);
					JasperExportManager.exportReportToPdfFile(jasperPrint,
							"C:\\ComplaintZilla\\Report.pdf");
					// _______________________________________________________________________________________________________________

					String filename = "C:\\ComplaintZilla\\Report.pdf";
					DataSource source = new FileDataSource(filename);
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(filename);
					multipart.addBodyPart(messageBodyPart);

					// Send the complete message parts
					msg.setContent(multipart);

					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());

					transport.close();
				} catch (Exception e) {
					e.printStackTrace();
				}

				// **********************************************************************************

				// *****************************************************************************************
			}
			// ***************************************************************************************************

			bean.setDate_register(complaint_date);
			// ********************************************************************************************

			System.out.println("Phase no in dao... " + bean.getPhase_id());

			// Register Complaint Action
			PreparedStatement ps_action = con
					.prepareStatement("insert into complaint_tbl_action(Complaint_No,U_Id,Action_Discription,Action_Date,Action_Type,phase_id)values(?,?,?,?,?,?)");
			ps_action.setString(1, complaint_no);
			ps_action.setInt(2, uid);
			ps_action.setString(3, bean.getAction_description());
			ps_action.setTimestamp(4, timestamp);
			ps_action.setString(5, bean.getAction_Type());
			ps_action.setInt(6, bean.getPhase_id());

			int i = ps_action.executeUpdate();

			int Action_Id = 0;

			PreparedStatement ps_a_id = con
					.prepareStatement("select max(Action_Id) from Complaint_Tbl_Action");

			ResultSet rs_a_id = ps_a_id.executeQuery();

			while (rs_a_id.next()) {
				Action_Id = rs_a_id.getInt("max(Action_Id)");
			}

			if (i > 0) {
				PreparedStatement ps_action_hist = con
						.prepareStatement("insert into complaint_tbl_action_hist(Action_Id,Complaint_No,U_Id,Action_Discription,Action_Date,Action_Type,Action_Date_Hist,Phase_Id)values(?,?,?,?,?,?,?,?)");
				ps_action_hist.setInt(1, Action_Id);
				ps_action_hist.setString(2, complaint_no);
				ps_action_hist.setInt(3, uid);
				ps_action_hist.setString(4, bean.getAction_description());
				ps_action_hist.setTimestamp(5, timestamp);
				ps_action_hist.setString(6, bean.getAction_Type());
				ps_action_hist.setTimestamp(7, timestamp);
				ps_action_hist.setInt(8, bean.getPhase_id());
				ps_action_hist.executeUpdate();

			}
			// *********************************************************************************************
			// Register Complaint Action History
			PreparedStatement ps_acthistory = con
					.prepareStatement("insert into complaint_tbl_history(C_History_Date,Complaint_No,U_Id,Cust_Id,Item_Id,Defect_Id,Complaint_Received_By,Complaint_Description,Complaint_Related_To,Complaint_Assigned_To,Category_Id,Status_Id,Company_Id,Complaint_Date,P_Id)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps_acthistory.setTimestamp(1, timestamp);
			ps_acthistory.setString(2, complaint_no);
			ps_acthistory.setInt(3, uid);
			ps_acthistory.setInt(4, cust_id);
			ps_acthistory.setInt(5, item_id);
			ps_acthistory.setInt(6, Defect_Id);
			ps_acthistory.setString(7, Complaint_Received_By);
			ps_acthistory.setString(8, Complaint_Description);
			ps_acthistory.setInt(9, Complaint_Related_To);
			ps_acthistory.setInt(10, Complaint_Assigned_To);
			ps_acthistory.setInt(11, Category_Id);
			ps_acthistory.setInt(12, bean.getStatus());
			ps_acthistory.setInt(13, Company_Id);
			ps_acthistory.setTimestamp(14, Complaint_Date);
			ps_acthistory.setInt(15, P_Id);

			ps_acthistory.executeUpdate();

			flag = true;

			// **********************************************************************************************

			// ***********************************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	public boolean file_upload(Complaint_Action_VO bean, HttpSession session) {
		boolean flag = false;
		Connection con = Connection_Utility.getConnection();

		try {
			// **********************************************************************************

			String complaint_no = session.getAttribute("complaint_no")
					.toString();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int del = 1, company_id = 0;
			// ***********************************************************************************
			// Attach file
			PreparedStatement ps_file = con
					.prepareStatement("insert into complaint_tbl_attachments(Complaint_No,Attachment,Attach_Date,U_Id,File_Name,delete_Status)values(?,?,?,?,?,?)");
			ps_file.setString(1, complaint_no);
			ps_file.setBinaryStream(2, bean.getFile());
			ps_file.setTimestamp(3, timestamp);
			ps_file.setInt(4, uid);
			ps_file.setString(5, bean.getFile_Name());
			ps_file.setInt(6, del);
			ps_file.executeUpdate();
			flag = true;

			// ******************************************************************************************************
			// Delete Row of Attachment if file input is empty
			PreparedStatement ps_deltemp1 = con
					.prepareStatement("delete from complaint_tbl_attachments where File_Name='"
							+ "" + "'");
			ps_deltemp1.executeUpdate();
			flag = true;
			// ******************************************************************************************************
			// Maintain log for attachment.......insert attachment to history
			PreparedStatement ps_attach_history = con
					.prepareStatement("insert into complaint_tbl_attachment_hist(CA_Hist_date,Complaint_No,Attach_Date,U_Id,File_Name,Delete_Status_Hist)values(?,?,?,?,?,?)");
			ps_attach_history.setTimestamp(1, timestamp);
			ps_attach_history.setString(2, complaint_no);
			ps_attach_history.setTimestamp(3, timestamp);
			ps_attach_history.setInt(4, uid);
			ps_attach_history.setString(5, bean.getFile_Name());
			ps_attach_history.setInt(6, del);
			ps_attach_history.executeUpdate();
			flag = true;

			// ************************************************************************************************
			// Delete row if file input is empty
			PreparedStatement ps_deltemp = con
					.prepareStatement("delete from complaint_tbl_attachment_hist where File_Name='"
							+ "" + "'");
			ps_deltemp.executeUpdate();

			// ***************************************************************************************************************************
			// Remainder Logic =============== >
			// ***************************************************************************************************************************
			if (bean.getFile_Name() != "") {

				int count = 0;

				System.out.println("Connection Estab");

				try {
					String company = null, part = null;
					// **************************************************************************
					PreparedStatement ps_email = con
							.prepareStatement("select * from complaint_tbl where Complaint_No='"
									+ complaint_no + "'");
					ResultSet rs_email = ps_email.executeQuery();
					while (rs_email.next()) {
						company_id = rs_email.getInt("Company_Id");
						PreparedStatement ps_ccmp = con
								.prepareStatement("select * from user_tbl_company where Company_Id="
										+ rs_email.getInt("Company_Id"));
						ResultSet rs_cmp = ps_ccmp.executeQuery();
						while (rs_cmp.next()) {
							company = rs_cmp.getString("Company_Name");
						}
						PreparedStatement ps_part = con
								.prepareStatement("select * from customer_tbl_item where Item_Id="
										+ rs_email.getInt("Item_Id"));
						ResultSet rs_part = ps_part.executeQuery();
						while (rs_part.next()) {
							part = rs_part.getString("Item_Name");
						}

					}
					// **************************************************************************
					// **************************************************************************
					// *********** Email logic **********
					// **************************************************************************
					System.out.println("Email Set Up..................");
					String host = "send.one.com";
					String user = "complaintzilla@muthagroup.com";
					String pass = "complaintzilla1";
					// String to = "amitpawar4182@gmail.com";

					Date date = Calendar.getInstance().getTime();
					DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
					String today = formatter.format(date);

					String from = "complaintzilla@muthagroup.com";
					String subject = company + " " + part + " "
							+ "New File attached, Complaint No : "
							+ bean.getComplaint_no();

					boolean sessionDebug = false;
					// *********************************************************************************************
					// multiple recipients : == >
					// *********************************************************************************************
					PreparedStatement ps6 = con
							.prepareStatement("select count(Email) from automail where company_id="
									+ company_id + " or company_id=6");
					ResultSet rs6 = ps6.executeQuery();
					while (rs6.next()) {
						count = rs6.getInt("count(Email)");
					}
					System.out.println("Company_Id ... : " + company_id);
					PreparedStatement ps_auto = con
							.prepareStatement("select * from automail where company_id="
									+ Company_Id + " or company_id=6");
					ResultSet rs_auto = ps_auto.executeQuery();
					String[] recipients = new String[count];
					int j = 0;
					while (rs_auto.next()) {
						recipients[j] = rs_auto.getString("Email");
						j++;
					}
					// *********************************************************************************************
					// String recipients[] = { "vijaybm@muthagroup.com",
					// "amitcp@muthagroup.com" };
					try {

						Properties props = System.getProperties();
						props.put("mail.host", host);
						props.put("mail.transport.protocol", "smtp");
						props.put("mail.smtp.auth", "true");
						props.put("mail.smtp.port", 2525);
						Session mailSession = Session.getDefaultInstance(props,
								null);
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

						// ****************************************************************************************************************************

						// Create the message part
						BodyPart messageBodyPart = new MimeBodyPart();
						// Fill the message
						// messageBodyPart.setText("This is message body");
						messageBodyPart
								.setContent(
										"Please find the newly attached File to Complaint No : "
												+ bean.getComplaint_no()
												+ "</b>"
												+ "<p><font size='2'><b style='color: #0D265E;'>This is an automatically generated email from ComplaintZilla</b></font>"
												+ "</p>"
												+ "<p><b>For more details ,</b> "
												+ "<a href='http://192.168.0.7/ComplaintZilla/'>Click Here</a></p>"
												+ " <p><b style='color: #330B73;'>Thanks & Regards </b></p><p> Mutha Group Satara </p>"
												+ "<hr>"
												+ "</p><b>Disclaimer :</b></p>"
												+ "<font face='Times New Roman' size='1'>"
												+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
										"Text/html");
						// Create a multipar message
						Multipart multipart = new MimeMultipart();

						// Set text message part
						multipart.addBodyPart(messageBodyPart);

						// Part two is attachment
						messageBodyPart = new MimeBodyPart();

						// _______________________________________________________________________________________________________________
						// ComplaintZilla Report Logic ============== >

						try {

							PreparedStatement ps_mail = con
									.prepareStatement("select * from complaint_tbl_attachments where File_Name='"
											+ bean.getFile_Name()
											+ "' and Complaint_No='"
											+ bean.getComplaint_no() + "'");
							ResultSet rs_mail = ps_mail.executeQuery();

							while (rs_mail.next()) {
								Blob bb = rs_mail.getBlob("Attachment");

								InputStream is = bb.getBinaryStream();
								FileOutputStream fos = new FileOutputStream(
										"c:\\EmailFiles"
												+ "\\"
												+ rs_mail
														.getString("File_Name"));
								int b = 0;
								while ((b = is.read()) != -1) {
									fos.write(b);
								}

								/*
								 * JasperReport jasperReport =
								 * JasperCompileManager
								 * .compileReport("C:/JRXMLFILES/CZReport.jrxml"
								 * ); Map parameters = new HashMap();
								 * JasperPrint jasperPrint =
								 * JasperFillManager.fillReport( jasperReport,
								 * parameters, con);
								 * JasperExportManager.exportReportToPdfFile
								 * (jasperPrint,
								 * "C:\\ComplaintZilla\\Report.pdf");
								 */
								// _______________________________________________________________________________________________________________

								String filename = "c:\\EmailFiles" + "\\"
										+ rs_mail.getString("File_Name");

								DataSource source = new FileDataSource(filename);
								messageBodyPart.setDataHandler(new DataHandler(
										source));
								messageBodyPart.setFileName(filename);
								multipart.addBodyPart(messageBodyPart);

								// Send the complete message parts
								msg.setContent(multipart);
							}
							Transport transport = mailSession
									.getTransport("smtp");
							transport.connect(host, user, pass);
							transport.sendMessage(msg, msg.getAllRecipients());

							transport.close();

						} catch (Exception e) {
							e.printStackTrace();
						}

						// ****************************************************************************************************************************

					} catch (Exception e) {
						e.printStackTrace();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			flag = true;

			// ************************************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	public boolean Change_Status(Complaint_Action_VO bean, HttpSession session) {
		boolean flag_status = false;

		try {
			String complaint_no = session.getAttribute("complaint_no")
					.toString();
			int uid = 0;
			uid = Integer.parseInt(session.getAttribute("uid").toString());
			String item = null, defect = null;
			System.out.println("Complaint_No in dao " + complaint_no);
			System.out.println("Uid in dao " + uid);
			System.out.println("Company in dao " + bean.getCompany_name());
			System.out.println("Customer in dao " + bean.getCust_name());
			System.out.println("Item in dao " + bean.getItem_name());
			System.out.println("Status in dao " + bean.getStatus());
			System.out.println("Defect in dao " + bean.getDefect());

			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps = con
					.prepareStatement("select * from complaint_tbl where Complaint_No='"
							+ complaint_no + "'");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				complaint_date = rs.getTimestamp("Complaint_Date");
				cust_id = rs.getInt("Cust_Id");
				item_id = rs.getInt("Item_Id");
				Defect_Id = rs.getInt("Defect_Id");
				Complaint_Received_By = rs.getString("Complaint_Received_By");
				Complaint_Description = rs.getString("Complaint_Description");
				Complaint_Related_To = rs.getInt("Complaint_Related_To");
				Complaint_Assigned_To = rs.getInt("Complaint_Assigned_To");
				Category_Id = rs.getInt("Category_Id");
				Company_Id = rs.getInt("Company_Id");
				Complaint_Date = rs.getTimestamp("Complaint_Date");
				P_Id = rs.getInt("P_Id");
				status_id = rs.getInt("Status_Id");

			}
			// *******************************************************************************************************
			PreparedStatement ps_stat_up = con
					.prepareStatement("update complaint_tbl set Status_Id=? where Complaint_No='"
							+ complaint_no + "'");
			ps_stat_up.setInt(1, bean.getStatus());
			ps_stat_up.executeUpdate();

			// *******************************************************************************************
			// Email for status change
			// *******************************************************************************************

			String status_change = null;
			if (bean.getStatus() != status_id) {
				// *****************************************************************************************

				PreparedStatement ps_status = con
						.prepareStatement("select * from status_tbl where Status_Id="
								+ bean.getStatus());
				ResultSet rs_status = ps_status.executeQuery();
				while (rs_status.next()) {
					status_change = rs_status.getString("Status");
					System.out.println("Status = " + status_change);
				}
				// ****************************************************************************************
				String old_status = null;
				PreparedStatement ps_old_stat = con
						.prepareStatement("select * from status_tbl where Status_Id="
								+ status_id);
				ResultSet rs_old_stat = ps_old_stat.executeQuery();
				while (rs_old_stat.next()) {
					old_status = rs_old_stat.getString("Status");
				}

				// ****************************************************************************************
				String user1 = null;
				String assign_mail = null;
				PreparedStatement ps_user = con
						.prepareStatement("select * from user_tbl where U_Id="
								+ uid);
				ResultSet rs_user = ps_user.executeQuery();
				while (rs_user.next()) {
					user1 = rs_user.getString("U_Name");
					assign_mail = rs_user.getString("U_Email");
				}

				PreparedStatement ps_cust = con
						.prepareStatement("select * from customer_tbl where Cust_Id="
								+ cust_id);
				ResultSet rs_cust = ps_cust.executeQuery();
				while (rs_cust.next()) {
					custName = rs_cust.getString("Cust_Name");
				}

				PreparedStatement ps_comp = con
						.prepareStatement("select * from user_tbl_company where Company_Id="
								+ Company_Id);
				ResultSet rs_comp = ps_comp.executeQuery();
				while (rs_comp.next()) {
					company = rs_comp.getString("Company_Name");
				}

				PreparedStatement ps_item = con
						.prepareStatement("select * from customer_tbl_item where Item_Id="
								+ item_id);
				ResultSet rs_item = ps_item.executeQuery();
				while (rs_item.next()) {
					item = rs_item.getString("Item_Name");
				}

				PreparedStatement ps_defect = con
						.prepareStatement("select * from defect_tbl where Defect_Id="
								+ Defect_Id);
				ResultSet rs_defect = ps_defect.executeQuery();
				while (rs_defect.next()) {
					defect = rs_defect.getString("Defect_Type");
				}

				// ***************************************************************************************
				// Email logic
				// ****************************************************************************************
				String host = "send.one.com";
				String user = "complaintzilla@muthagroup.com";
				String pass = "complaintzilla1";
				// String to = "amitpawar4182@gmail.com";

				String from = "complaintzilla@muthagroup.com";
				String subject = company + " " + item + " Complaint Status is "
						+ status_change;

				boolean sessionDebug = false;

				// *********************************************************************************************
				PreparedStatement ps6 = con
						.prepareStatement("select count(Email) from automail where company_id=6 or company_id="
								+ Company_Id);
				ResultSet rs6 = ps6.executeQuery();
				while (rs6.next()) {
					count = rs6.getInt("count(Email)");
				}

				PreparedStatement ps_auto = con
						.prepareStatement("select * from automail where company_id=6 or company_id="
								+ Company_Id);
				ResultSet rs_auto = ps_auto.executeQuery();
				String[] recipients = new String[count + 1];
				int j = 1;
				recipients[0] = assign_mail;
				while (rs_auto.next()) {
					recipients[j] = rs_auto.getString("Email");
					j++;
				}
				// *********************************************************************************************

				Properties props = System.getProperties();
				props.put("mail.host", host);
				props.put("mail.transport.protocol", "smtp");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.port", 2525);

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

				// Create the message part
				BodyPart messageBodyPart = new MimeBodyPart();
				// Fill the message
				// messageBodyPart.setText("This is message body");
				messageBodyPart
						.setContent(
								"<p><b>Complaint Number :</b>"
										+ complaint_no
										+ ", "

										+ "<p><b>Status changed from : </b>"
										+ old_status
										+ " <b> to </b>  "
										+ status_change
										+ ", "
										+ " </p>"

										+ "<p><b>Action Type : </b>"
										+ bean.getAction_Type()
										+ ", "
										+ " </p>"
										+ "<p><b>Complaint Action Description :</b></p><p>"
										+ bean.getAction_description()
										+ "</p>"

										+ "<p><b>Action Taken By : </b>"
										+ user1
										+ ", "
										+ " </p>"

										+ "<p><b>Company Name :</b>"
										+ company
										+ ", "
										+ " </p>"

										+ "<p><b>Customer Name :</b>"
										+ custName
										+ ", "
										+ " </p>"

										+ "<p><b>Item Name  :</b>"
										+ item
										+ ", "
										+ " </p>"

										+ "<p><b>Defect  :</b>"
										+ defect
										+ ", "
										+ " </p>"

										+ "<p><b>Complaint Received date :</b>"
										+ Complaint_Date
										+ ", "
										+ " </p>"

										+ "<p><font size='2'><b style='color: #0D265E;'>This is an automatically generated email from ComplaintZilla</b></font>"
										+ "</p>"
										+ "<p><b>For more details ,</b> "
										+ "<a href='http://192.168.0.7/ComplaintZilla/'>Click Here</a></p>"
										+ " <p><b style='color: #330B73;'>Thanks & Regards </b></p><p> Mutha Group Satara </p>"
										+ "<hr>"
										+ "<p><b>Disclaimer :</b></p>"
										+ "<font face='Times New Roman' size='1'>"
										+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
								"Text/html");
				// Create a multipar message
				Multipart multipart = new MimeMultipart();

				// Set text message part
				multipart.addBodyPart(messageBodyPart);

				// Part two is attachment
				messageBodyPart = new MimeBodyPart();

				// _______________________________________________________________________________________________________________
				// ComplaintZilla Report Logic ============== >

				try {

					JasperReport jasperReport = JasperCompileManager
							.compileReport("C:/JRXMLFILES/CZReport.jrxml");
					Map parameters = new HashMap();
					JasperPrint jasperPrint = JasperFillManager.fillReport(
							jasperReport, parameters, con);
					JasperExportManager.exportReportToPdfFile(jasperPrint,
							"C:\\ComplaintZilla\\Report.pdf");
					// _______________________________________________________________________________________________________________

					String filename = "C:\\ComplaintZilla\\Report.pdf";
					DataSource source = new FileDataSource(filename);
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(filename);
					multipart.addBodyPart(messageBodyPart);

					// Send the complete message parts
					msg.setContent(multipart);

					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());

					transport.close();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			PreparedStatement ps_status1 = con
					.prepareStatement("update complaint_tbl set status_id=? where complaint_no='"
							+ complaint_no + "'");
			ps_status1.setInt(1, bean.getStatus());
			int i = 0, j1 = 0;
			i = ps_status1.executeUpdate();

			if (i > 0) {
				PreparedStatement ps_getDetails = con
						.prepareStatement("select * from Complaint_tbl where Complaint_no='"
								+ complaint_no + "'");
				ResultSet rs_getDetails = ps_getDetails.executeQuery();

				PreparedStatement ps_addDetails = null;

				while (rs_getDetails.next()) {
					System.out.println("Complaint No when changing status : "
							+ rs_getDetails.getString("Complaint_No"));

					ps_addDetails = con
							.prepareStatement("insert into complaint_tbl_history(C_History_Date,Complaint_No,U_Id,Cust_Id,Item_Id,Defect_Id,Complaint_Received_By,Complaint_Description,Complaint_Related_To,Complaint_Assigned_To,Category_Id,Status_Id,Company_Id,Complaint_Date,P_Id)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

					ps_addDetails.setTimestamp(1, timestamp);
					ps_addDetails.setString(2, complaint_no);
					ps_addDetails.setInt(3, uid);
					ps_addDetails.setInt(4, rs_getDetails.getInt("Cust_Id"));
					ps_addDetails.setInt(5, rs_getDetails.getInt("Item_Id"));
					ps_addDetails.setInt(6, rs_getDetails.getInt("Defect_Id"));
					ps_addDetails.setString(7,
							rs_getDetails.getString("Complaint_Received_By"));
					ps_addDetails.setString(8,
							rs_getDetails.getString("Complaint_Description"));
					ps_addDetails.setInt(9,
							rs_getDetails.getInt("Complaint_Related_To"));
					ps_addDetails.setInt(10,
							rs_getDetails.getInt("Complaint_Assigned_To"));
					ps_addDetails.setInt(11,
							rs_getDetails.getInt("Category_Id"));
					ps_addDetails.setInt(12, rs_getDetails.getInt("Status_Id"));
					ps_addDetails
							.setInt(13, rs_getDetails.getInt("Company_Id"));
					ps_addDetails.setTimestamp(14,
							rs_getDetails.getTimestamp("Complaint_Date"));
					ps_addDetails.setInt(15, rs_getDetails.getInt("P_Id"));

					j1 = ps_addDetails.executeUpdate();

					if (j1 > 0) {
						flag_status = true;
					}
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag_status;
	}
}
