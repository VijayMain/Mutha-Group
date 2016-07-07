package com.muthagroup.dao;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;

import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_VO;

public class Edit_DAO {

	Connection con = null;
	PreparedStatement ps = null, ps1 = null, ps2 = null, ps3 = null;
	int i = 0, uid = 0;
	boolean flag = false;
	String complaint_no = null;
	ResultSet rs3 = null;

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// get current date time with Date()
	Date date = new Date();
	// System.out.println("by date..:" + dateFormat.format(date));

	java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());

	// System.out.println("by TIMESTAMP..:" + timestamp);

	public String Edit_Update_dao(Edit_VO bean, HttpSession session) {
		try {

			con = Connection_Utility.getConnection();
			System.out.println("Get Connection edit complaint");
			System.out.println("session DAO : "
					+ session.getAttribute("complaint_no").toString());
			uid = Integer.parseInt(session.getAttribute("uid").toString());
			int j = 0;
			System.out.println("session uid :" + uid);

			System.out
					.println("************* Values In Edit_DAO **************");
			System.out.println("Complaint Date : " + bean.getC_date());
			System.out.println("Comapny id : " + bean.getCompany_id());
			System.out.println("Cust id : " + bean.getCust_id());
			System.out.println("Status :" + bean.getStatus_id());
			System.out.println("Itemid : " + bean.getItem_id());
			System.out.println("Defect : " + bean.getDefect());
			System.out.println("Received : " + bean.getReceived());
			System.out.println("Discription : " + bean.getDiscription());
			System.out.println("Related : " + bean.getRelated());
			System.out.println("Category : " + bean.getCategory());
			System.out.println("Assigned : " + bean.getAssigned());
			System.out.println("Status Id : " + bean.getStatus_id());
			System.out.println("Priority id : " + bean.getPriority());

			complaint_no = session.getAttribute("complaint_no").toString();

			Calendar cal = Calendar.getInstance();
			cal.getTime();
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
			String autoTime = sdf.format(cal.getTime());

			if (bean.getItem_id() != 0 && bean.getAssigned() != 0
					&& bean.getCust_id() != 0 && bean.getDefect() != 0
					&& !bean.getC_date().equals("") && bean.getCategory() != 0
					&& bean.getCompany_id() != 0 && bean.getStatus_id() != 0
					&& !bean.getDiscription().equals("")
					&& bean.getRelated() != 0 && !bean.getReceived().equals("")
					&& bean.getStatus_id() != 0 && bean.getPriority() != 0) {

				// Update complaint
				ps = con.prepareStatement("update complaint_tbl set U_Id=?,cust_id=?,item_id=?,defect_id=?,complaint_received_by=?,complaint_description=?,complaint_related_to=?,complaint_assigned_to=?,category_id=?,complaint_date=?,status_id=?,company_id=?,p_id=?,Automail_time=? where Complaint_No='"
						+ complaint_no + "'");

				ps.setInt(1, uid);
				ps.setInt(2, bean.getCust_id());
				ps.setInt(3, bean.getItem_id());
				ps.setInt(4, bean.getDefect());
				ps.setString(5, bean.getReceived());
				ps.setString(6, bean.getDiscription());
				ps.setInt(7, bean.getRelated());
				ps.setInt(8, bean.getAssigned());
				ps.setInt(9, bean.getCategory());
				ps.setTimestamp(10, bean.getC_date());
				ps.setInt(11, bean.getStatus_id());
				ps.setInt(12, bean.getCompany_id());
				ps.setInt(13, bean.getPriority());
				ps.setString(14, autoTime);

				int i = ps.executeUpdate();

				// To Maintain logs.......update history
				ps1 = con
						.prepareStatement("insert into complaint_tbl_history (C_History_Date,Complaint_No,U_Id,Cust_Id,Item_Id,Defect_Id,Complaint_Received_By,Complaint_Description,Complaint_Related_To,Complaint_Assigned_To,Category_Id,Status_Id,Company_Id,Complaint_Date,p_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps1.setTimestamp(1, timestamp);
				ps1.setString(2, complaint_no);
				ps1.setInt(3, uid);
				ps1.setInt(4, bean.getCust_id());
				ps1.setInt(5, bean.getItem_id());
				ps1.setInt(6, bean.getDefect());
				ps1.setString(7, bean.getReceived());
				ps1.setString(8, bean.getDiscription());
				ps1.setInt(9, bean.getRelated());
				ps1.setInt(10, bean.getAssigned());
				ps1.setInt(11, bean.getCategory());
				ps1.setInt(12, bean.getStatus_id());
				ps1.setInt(13, bean.getCompany_id());
				ps1.setTimestamp(14, bean.getC_date());
				ps1.setInt(15, bean.getPriority());

				j = ps1.executeUpdate();

				if (i > 0 && j > 0) {
					flag = true;
					System.out.println("Updated from dao.....");
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return complaint_no;
	}

	public boolean attach_File(Edit_VO bean, InputStream file_Input,
			HttpSession session) {
		boolean flag = false;

		con = Connection_Utility.getConnection();
		try {
			int del = 1;
			PreparedStatement ps_file = null;
			String sr = session.getAttribute("uid").toString();
			int uid = Integer.parseInt(sr);

			// To attach file
			ps_file = con
					.prepareStatement("insert into complaint_tbl_attachments(Complaint_No,Attachment,Attach_Date,U_Id,File_Name,delete_Status)values(?,?,?,?,?,?)");
			ps_file.setString(1, bean.getComplaint_no());
			ps_file.setBinaryStream(2, file_Input);
			ps_file.setTimestamp(3, bean.getC_date());
			ps_file.setInt(4, uid);
			ps_file.setString(5, bean.getFile_Name_ext());
			ps_file.setInt(6, del);
			ps_file.executeUpdate();
			flag = true;

			// To Maintain logs for attachment.......insert file.....
			PreparedStatement ps_history = con
					.prepareStatement("insert into complaint_tbl_attachment_hist(CA_Hist_date,Complaint_No,Attach_Date,U_Id,File_Name,Delete_Status_Hist)values(?,?,?,?,?,?) ");
			ps_history.setTimestamp(1, timestamp);
			ps_history.setString(2, bean.getComplaint_no());
			ps_history.setTimestamp(3, bean.getC_date());
			ps_history.setInt(4, uid);
			ps_history.setString(5, bean.getFile_Name_ext());
			ps_history.setInt(6, del);
			ps_history.executeUpdate();
			flag = true;

			PreparedStatement ps_del = con
					.prepareStatement("delete from complaint_tbl_attachments where File_Name='"
							+ "" + "'");
			ps_del.executeUpdate();
			flag = true;

			PreparedStatement ps_del1 = con
					.prepareStatement("delete from complaint_tbl_attachment_hist where File_Name='"
							+ "" + "'");
			ps_del1.executeUpdate();

			// ***************************************************************************************************************************
			// Remainder Logic =============== >
			// ***************************************************************************************************************************
			int count = 0;

			System.out.println("Connection Estab");
			// Date d = new Date();
			// String weekday[] = { "Sunday", "Monday", "Tuesday",
			// "Wednesday", "Thursday", "Friday", "Saturday" };
			// ArrayList rem = new ArrayList();
			// // out.println("Day ===== >" + weekday[d.getDay()]);
			// if (weekday[d.getDay()].equals("Wednesday")
			// && d.getHours() == 10 && d.getMinutes() == 10) {

			try {
				String company = null, part = null;
				// **************************************************************************
				PreparedStatement ps_email = con
						.prepareStatement("select * from complaint_tbl where Complaint_No='"
								+ bean.getComplaint_no() + "'");
				ResultSet rs_email = ps_email.executeQuery();
				while (rs_email.next()) {
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
								+ bean.getCompany_id() + " or company_id=6");
				ResultSet rs6 = ps6.executeQuery();
				while (rs6.next()) {
					count = rs6.getInt("count(Email)");
				}
				System.out.println("Company_Id ... : " + bean.getCompany_id());
				PreparedStatement ps_auto = con
						.prepareStatement("select * from automail where company_id="
								+ bean.getCompany_id() + " or company_id=6");
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
									"Please find the newly attached File to Complaint No : <b style='color: #0D265E;'>"
											+ bean.getComplaint_no()
											+ "</b>"
											+ "<p></p>"

											+ "<p><font size='2'><b style='color: #0D265E;'>This is an automatically generated email from ComplaintZilla</b></font>"
											+ "</p>"

											+ "<p> For more details ,  "
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
										+ bean.getFile_Name_ext()
										+ "' and Complaint_No='"
										+ bean.getComplaint_no() + "'");
						ResultSet rs_mail = ps_mail.executeQuery();

						while (rs_mail.next()) {
							Blob bb = rs_mail.getBlob("Attachment");

							InputStream is = bb.getBinaryStream();
							FileOutputStream fos = new FileOutputStream(
									"c:\\EmailFiles" + "\\"
											+ rs_mail.getString("File_Name"));
							int b = 0;
							while ((b = is.read()) != -1) {
								fos.write(b);
							}

							/*
							 * JasperReport jasperReport = JasperCompileManager
							 * .compileReport("C:/JRXMLFILES/CZReport.jrxml");
							 * Map parameters = new HashMap(); JasperPrint
							 * jasperPrint = JasperFillManager.fillReport(
							 * jasperReport, parameters, con);
							 * JasperExportManager.exportReportToPdfFile
							 * (jasperPrint, "C:\\ComplaintZilla\\Report.pdf");
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
						Transport transport = mailSession.getTransport("smtp");
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

			// }

			flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}
}
