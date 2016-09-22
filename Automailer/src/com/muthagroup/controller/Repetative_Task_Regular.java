package com.muthagroup.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.TimerTask;
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
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

public class Repetative_Task_Regular extends TimerTask {

	@Override
	public void run() {

		int count = 0, U_Id = 0, Cust_Id = 0, Item_Id = 0, mail_status = 0, P_Id = 0, Company_Id = 0, Defect_Id = 0, Complaint_Related_To = 0, Complaint_Assigned_To = 0, Category_Id = 0;
		String Complaint_Received_By = null, Complaint_Description = null, Complaint_Date = null,complaintType="";
		int dept_id = 0;
		Connection con = Connection_Utility.getConnection();
		try {

			ArrayList list = new ArrayList();
			PreparedStatement ps_st = con
					.prepareStatement("select * from complaint_tbl where mail_status=0");
			ResultSet rs_st = ps_st.executeQuery();
			while (rs_st.next()) {
				list.add(rs_st.getString("Complaint_No"));
			}
			System.out.println("This is thread 1 list is" + list);
			if (list.size() != 0) {

				for (int ch = 0; ch < list.size(); ch++) {

					PreparedStatement ps_complaint = con.prepareStatement("select * from complaint_tbl where Complaint_No='" + list.get(ch).toString() + "'");
					ResultSet rs_complaint = ps_complaint.executeQuery();
					while (rs_complaint.next()) {
						U_Id = rs_complaint.getInt("U_Id");
						complaintType = rs_complaint.getString("complaint_type");
						Cust_Id = rs_complaint.getInt("Cust_Id");
						Item_Id = rs_complaint.getInt("Item_Id");
						Defect_Id = rs_complaint.getInt("Defect_Id");
						Complaint_Received_By = rs_complaint.getString("Complaint_Received_By");
						Complaint_Description = rs_complaint.getString("Complaint_Description");
						Complaint_Related_To = rs_complaint.getInt("Complaint_Related_To");
						Complaint_Assigned_To = rs_complaint.getInt("Complaint_Assigned_To");
						Category_Id = rs_complaint.getInt("Category_Id");
						Complaint_Date = rs_complaint.getString("Complaint_Date");
						Company_Id = rs_complaint.getInt("Company_Id");
						P_Id = rs_complaint.getInt("P_Id");
						mail_status = rs_complaint.getInt("mail_status");
						dept_id = rs_complaint.getInt("Complaint_Related_To");
					}

					// *********************************************************************************
					// for email logic select parameters ====>
					// *********************************************************************************

					String name = null;
					String department = null;
					String company = null; 
					String assignto = null;
					String customer = null;
					String cust_mail = null;
					String item = null;
					String prit = null;
					String categ = null;
					String defect = null;

					// ********************************************************************
					PreparedStatement ps_def = con
							.prepareStatement("select * from category_tbl where Category_Id="
									+ Category_Id);
					ResultSet rs_cat = ps_def.executeQuery();
					while (rs_cat.next()) {
						categ = rs_cat.getString("Category");
					}
					// *******************************************************************
					PreparedStatement ps_sev = con
							.prepareStatement("select * from severity_tbl where P_Id="
									+ P_Id);
					ResultSet rs_sev = ps_sev.executeQuery();
					while (rs_sev.next()) {
						prit = rs_sev.getString("P_Type");
					}
					// *******************************************************************
					PreparedStatement ps_item = con
							.prepareStatement("select * from customer_tbl_item where Item_Id="
									+ Item_Id);
					ResultSet rs_item = ps_item.executeQuery();
					while (rs_item.next()) {
						item = rs_item.getString("Item_Name");
					}
					// ********************************************************************
					PreparedStatement ps_cust = con.prepareStatement("select * from customer_tbl where Cust_Id="
									+ Cust_Id);
					ResultSet rs_cust = ps_cust.executeQuery();
					while (rs_cust.next()) {
						customer = rs_cust.getString("Cust_Name");
						cust_mail = rs_cust.getString("Email");
					}
					// ********************************************************************
					int comapany_id = 0;
					PreparedStatement ps_user = con.prepareStatement("select * from user_tbl where U_Id=" + U_Id);
					ResultSet rs_user = ps_user.executeQuery();

					while (rs_user.next()) {
						name = rs_user.getString("U_Name");

						// ******************************************************************
						PreparedStatement ps_dept = con.prepareStatement("select * from user_tbl_dept where dept_id=" + dept_id);
						ResultSet rs_d = ps_dept.executeQuery();

						while (rs_d.next()) {
							department = rs_d.getString("Department");
						}
					}

					PreparedStatement ps_comp = con
							.prepareStatement("select * from user_tbl_company where Company_Id="
									+ Company_Id);
					ResultSet rs_comp = ps_comp.executeQuery();
					while (rs_comp.next()) {
						company = rs_comp.getString("Company_Name");
					}
					// System.out.println("Company Is = " + company);
					// ***********************************************************************
					String assign_mail = null;
					PreparedStatement ps_assign = con
							.prepareStatement("select * from user_tbl where U_Id="
									+ Complaint_Assigned_To);
					ResultSet rs_assign = ps_assign.executeQuery();
					while (rs_assign.next()) {
						assignto = rs_assign.getString("U_Name");
						assign_mail = rs_assign.getString("U_Email");

					}
					// *************************************************************************
					PreparedStatement ps_defect = con
							.prepareStatement("select * from defect_tbl where Defect_Id="
									+ Defect_Id);
					ResultSet rs_defect = ps_defect.executeQuery();
					while (rs_defect.next()) {
						defect = rs_defect.getString("Defect_Type");
					}
					// *****************************************************************************************************
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
					String subject = company + " " + item
							+ " New Complaint Received";

					boolean sessionDebug = false;
					// *********************************************************************************************
					// multiple recipients : == >
					// *********************************************************************************************
					PreparedStatement ps6 = con.prepareStatement("select count(Email) from automail where Company_id=6 or company_id=" + Company_Id);
					ResultSet rs6 = ps6.executeQuery();
					while (rs6.next()) {
						count = rs6.getInt("count(Email)");
					}

					PreparedStatement ps_auto = con.prepareStatement("select * from automail where Company_id=6 or company_id=" + Company_Id);
					ResultSet rs_auto = ps_auto.executeQuery();
					String[] recipients = new String[count + 1];
					int j = 1;
					recipients[0] = assign_mail;
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

						// Create the message part
						BodyPart messageBodyPart = new MimeBodyPart();
						messageBodyPart
								.setContent(
										"<p><b>Complaint Number :</b>"
												+ list.get(ch).toString()
												+ ", "
												+ " </p>"

												+ "<p><b>Complaint Type : </b>"
												+ complaintType
												+ ", "
												+ " </p>"
												
												+ "<p><b>Customer Name : </b>"
												+ customer
												+ ", "
												+ " </p>"

												+ "<p><b>Item Name : </b>"
												+ item
												+ ", "
												+ " </p>"

												+ "<p><b>Defect : </b>"
												+ defect
												+ ", "
												+ " </p>"

												+ "<p><b>Complaint Description : </b> "
												+ Complaint_Description
												+ "</p>"

												+ "<p><b>Company Name : </b>"
												+ company
												+ ", "
												+ " </p>"

												+ "<p><b>Severity is : </b>"
												+ "<b>"
												+ prit
												+ "</b>"
												+ ", "
												+ " </p>"

												+ "<p><b>Complaint Received date :</b>"
												+ Complaint_Date
												+ ", "
												+ " </p>"

												+ "<p><b>Complaint Received from :</b>"
												+ name
												+ ", "
												+ " </p>"

												+ "<p><b>Complaint Assigned to : </b>"
												+ assignto
												+ ", "
												+ " </p>"

												+ "<p><b>Related Department : </b>"
												+ department
												+ ", "
												+ " </p>"

												+ "<b style='color: #EB2138;'><blink>New Complaint Received</blink></b>"

												+ "<p><font size='2'><b style='color: #0D265E;'>This is an automatically generated email from ComplaintZilla</b></font>"
												+ "</p>"

												+ "<p><b>For more details ,</b> "
												+ "<a href='http://192.168.0.7/ComplaintZilla/'>Click Here</a>"
												+ " </p><p><b style='color: #330B73;'>Thanks & Regards </b></P><p> Mutha Group Satara </p>"
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

						JasperReport jasperReport = JasperCompileManager
								.compileReport("C:/JRXMLFILES/CZReport.jrxml");

						Map parameters = new HashMap();
						JasperPrint jasperPrint = JasperFillManager.fillReport(
								jasperReport, parameters, con);
						JasperExportManager.exportReportToPdfFile(jasperPrint,
								"C:\\ComplaintZilla\\Report.pdf");

						/*JasperReport jasperReport1 = JasperCompileManager
								.compileReport("C:/JRXMLFILES/Unassigned.jrxml");*/

						Map parameters1 = new HashMap();
						
						/* JasperPrint jasperPrint1 = JasperFillManager.fillReport(jasperReport1, parameters1, con);
						JasperExportManager.exportReportToPdfFile(jasperPrint1, "C:\\ComplaintZilla\\Unassigned.pdf");*/

						String filename[] = { "C:\\ComplaintZilla\\Report.pdf" };

						for (int i = 0; i < filename.length; i++) {
							System.out.println(filename[i]);

							messageBodyPart = new MimeBodyPart();
							DataSource source = new FileDataSource(filename[i]);
							messageBodyPart.setDataHandler(new DataHandler(
									source));
							messageBodyPart.setFileName(filename[i]);
							multipart.addBodyPart(messageBodyPart);
							msg.setContent(multipart);
						}

						// _______________________________________________________________________________________________________________

						Transport transport = mailSession.getTransport("smtp");
						transport.connect(host, user, pass);
						transport.sendMessage(msg, msg.getAllRecipients());

						PreparedStatement ps_mail = con
								.prepareStatement("update complaint_tbl set mail_status=1 where Complaint_No='"
										+ list.get(ch).toString() + "'");
						int m = ps_mail.executeUpdate();

						transport.close();

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// System.out.println("In Thread/Timer no 1");
	}
}
