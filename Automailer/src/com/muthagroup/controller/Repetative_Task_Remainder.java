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

public class Repetative_Task_Remainder extends TimerTask {

	@Override
	public void run() {
		/*
		Connection con = Connection_Utility.getConnection();
		try {
			int count = 0, U_Id = 0, Cust_Id = 0, Item_Id = 0, mail_status = 0, P_Id = 0, Company_Id = 0, Defect_Id = 0, Complaint_Related_To = 0, Complaint_Assigned_To = 0, Category_Id = 0;
			String Complaint_Received_By = null, Complaint_Description = null, Complaint_Date = null;
			
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday",
					"Thursday", "Friday", "Saturday" };
			ArrayList rem = new ArrayList();
			// System.out.println("Day ===== >" + weekday[d.getDay()]);
			  if (weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 10) {
			//	if (d.getHours() == 11 && d.getMinutes() == 7) {

				
				PreparedStatement ps_czlist = con.prepareStatement("select * from complaint_tbl where Status_Id in(1,2)");
				ResultSet rs_czlist = ps_czlist.executeQuery();
				
				rs_czlist.last();
				int vd = rs_czlist.getRow();
				rs_czlist.beforeFirst();

				if (vd > 0) {
				
				try {

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
					String subject = "Weekly Report from ComplaintZilla";

					boolean sessionDebug = false;
					// *********************************************************************************************
					// multiple recipients : == >
					// *********************************************************************************************
					PreparedStatement ps6 = con
							.prepareStatement("select count(Email) from automail");
					ResultSet rs6 = ps6.executeQuery();
					while (rs6.next()) {
						count = rs6.getInt("count(Email)");
					}

					PreparedStatement ps_auto = con
							.prepareStatement("select * from automail");
					ResultSet rs_auto = ps_auto.executeQuery();
					String[] recipients = new String[count];
					int j = 0;
					while (rs_auto.next()) {
						recipients[j] = rs_auto.getString("Email");
						j++;
					}
					// *********************************************************************************************
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
										"Please find below attached Weekly Report of <b style='color: #960938;'><blink> New & Open Customer complaints </blink></b>"

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

						JasperReport jasperReport = JasperCompileManager.compileReport("C:/JRXMLFILES/CZReport.jrxml");

						Map parameters = new HashMap();
						JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, con);
						JasperExportManager.exportReportToPdfFile(jasperPrint, "C:\\ComplaintZilla\\Report.pdf");

						String filename[] = {"C:\\ComplaintZilla\\Report.pdf"};

						for (int i = 0; i < filename.length; i++) {
							System.out.println(filename[i]);

							messageBodyPart = new MimeBodyPart();
							DataSource source = new FileDataSource(filename[i]);
							messageBodyPart.setDataHandler(new DataHandler(source));
							messageBodyPart.setFileName(filename[i]);
							multipart.addBodyPart(messageBodyPart);
							msg.setContent(multipart);
						}

						// _______________________________________________________________________________________________________________

						Transport transport = mailSession.getTransport("smtp");
						transport.connect(host, user, pass);
						transport.sendMessage(msg, msg.getAllRecipients());

						transport.close();

					} catch (Exception e) {
						e.printStackTrace();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				} 
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				con.close();
			} catch (SQLException e) { 
				e.printStackTrace();
			}
		}
		System.out.println("In Thread/Timer no 2");
		*/
	}
}
