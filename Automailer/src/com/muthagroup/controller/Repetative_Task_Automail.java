package com.muthagroup.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.TimerTask;

import javax.activation.DataHandler;
import javax.mail.BodyPart;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.internet.MimeBodyPart;

import com.sun.mail.pop3.POP3Store;

public class Repetative_Task_Automail extends TimerTask {

	@Override
	public void run() {
		Connection con = Connection_Utility.getConnection();
		int un_id = 0, rct = 0;
		try {

			// Get database connection
			Class.forName("com.mysql.jdbc.Driver");
			

			int a = 0, b = 0,unnassignedId=0,maxUID=0;
			// Properties
			String pop3Host = "pop.muthagroup.com";
			String storeType = "pop3";

			HashMap hm = new HashMap();
			PreparedStatement ps_getmail = con.prepareStatement("select * from user_tbl_company where mail_id !=''");
			ResultSet rs_getmail = ps_getmail.executeQuery();
			while (rs_getmail.next()) {
				hm.put(rs_getmail.getString("mail_id"), rs_getmail.getString("mail_password"));
			}

			// Get a set of the entries
			Set set = hm.entrySet();
			// Get an iterator
			Iterator ii = set.iterator();
			// Display elements
			while (ii.hasNext()) {
				Map.Entry me = (Map.Entry) ii.next();
				//System.out.print(me.getKey() + ": ");
				// System.out.println(me.getValue());

				// ************************************************************************************************************************************

				String user = (String) me.getKey();
				String password = (String) me.getValue();

				int comp_id = 0;
				//System.out.println("User Password == " + user + "\n" + password);

				PreparedStatement ps_usr = con
						.prepareStatement("select Company_Id from user_tbl_company where mail_id='"
								+ user + "'");
				ResultSet rs_comp = ps_usr.executeQuery();
				while (rs_comp.next()) {
					comp_id = rs_comp.getInt("Company_Id");
				}
				int leng = 0;
				BodyPart bodyPart = null;
				String mailContents = null;
				Properties properties = new Properties();
				properties.put("mail.pop3.host", pop3Host);

				Session emailSession = Session.getDefaultInstance(properties);
				// to get INBOX
				POP3Store emailStore = (POP3Store) emailSession
						.getStore(storeType);
				emailStore.connect(pop3Host, user, password);
				Folder emailFolder = emailStore.getFolder("INBOX");
				emailFolder.open(Folder.READ_WRITE);
				// get all inbox mail messages

				PreparedStatement ps_sel = con
						.prepareStatement("select count(Company_Id) from complaint_tbl_unassigned where Company_Id="
								+ comp_id);
				ResultSet rs_sel = ps_sel.executeQuery();
				int count = 0;
				while (rs_sel.next()) {
					count = rs_sel.getInt("count(Company_Id)");
				}
				Message[] messages = emailFolder.getMessages();

				if (count < messages.length) {

					for (int i = count; i < messages.length; i++) {

						Message message = messages[i];

						SimpleDateFormat formatter = new SimpleDateFormat(
								"dd-MM-yyyy HH:mm:ss");
						Timestamp convertedDate = null;
						Date date = message.getSentDate();
						String today = formatter.format(date);
						convertedDate = new java.sql.Timestamp(formatter.parse(
								today).getTime());

						// ****************************************************************************************************************************

						String fr = message.getFrom()[0].toString();
						// System.out.println("from messages = " + fr);

						String from = message.getFrom()[0].toString();
						int enable = 1;

						if (message.getContent() instanceof javax.mail.internet.MimeMultipart) {
							// ---------------------------------------------------------------------------------------------------------
							String getReply = message.getSubject().substring(0,
									4);
							String subjectMatch = message.getSubject()
									.substring(4);
						//	System.out.println("Reply subject = "+ subjectMatch);

							if (getReply.equalsIgnoreCase("Re: ")) {
								//System.out.println("In reply mail at loop");
								// ************************************************************************************************************************
								PreparedStatement ps_replyContent = con.prepareStatement("select * from complaint_unassigned_reply_tbl where reply_content='"+ getText(message) + "'");
								ResultSet rs_replyContent = ps_replyContent.executeQuery();

								rs_replyContent.last(); 
								rct = rs_replyContent.getRow();
								rs_replyContent.beforeFirst();
								
							//	System.out.println("00000000000000000000000000000000000=="+rct);
								  if (rct > 0) {
								  }else{
									//System.out.println("Reply attach mail-----------------------------------------------------------");

									PreparedStatement ps_Umail = con.prepareStatement("select * from complaint_tbl_unassigned where Mail_Subject='" + subjectMatch + "'");
									ResultSet rs_Umail = ps_Umail.executeQuery();
									while (rs_Umail.next()) {
										
										maxUID = rs_Umail.getInt("unassign_id");
										
										PreparedStatement ps_reply = con
												.prepareStatement("insert into complaint_unassigned_reply_tbl (unassign_id,reply_content,enable_id) values(?,?,?)");
										ps_reply.setInt(1,
												rs_Umail.getInt("unassign_id"));
										ps_reply.setString(2, getText(message));
										ps_reply.setInt(3, 1);
										int r = ps_reply.executeUpdate();

									}
									//System.out.println("Unassigned Id messages ======================================== "+ maxUID);
								}

								// ************************************************************************************************************************
							} else {
								int c=0;
								PreparedStatement ps_uu=con.prepareStatement("select * from complaint_tbl_unassigned where Mail_Content='"+getText(message)+"'");
								ResultSet rs_uu=ps_uu.executeQuery();
								while(rs_uu.next()){
									c=rs_uu.getInt("unassign_id");
								}
								if(c>0){
									//System.out.println("in loop");
								}else {
								//	System.out.println("Text Attach Mail"); 									
									PreparedStatement ps_inc = con.prepareStatement("insert into complaint_tbl_unassigned(Mail_Subject,Mail_From,Mail_Content,Enable_Id,Mail_Received_Date,Company_Id)values(?,?,?,?,?,?)");
									ps_inc.setString(1, message.getSubject());
									ps_inc.setString(2, from);
									ps_inc.setString(3, getText(message));
									ps_inc.setInt(4, enable);
									ps_inc.setTimestamp(5, convertedDate);
									ps_inc.setInt(6, comp_id);
									a = ps_inc.executeUpdate();
	
									PreparedStatement ps_id=con.prepareStatement("select max(unassign_id) from complaint_tbl_unassigned");
									ResultSet rs_id=ps_id.executeQuery();
									while(rs_id.next()){
										maxUID=rs_id.getInt("max(unassign_id)");
									}
									
								}
								
							}

							// ---------------------------------------------------------------------------------------------------------

						} else {
							// ---------------------------------------------------------------------------------------------------------
							String getReply = message.getSubject().substring(0, 4);
							String subjectMatch = message.getSubject().substring(4);
						//	System.out.println("Reply subject = " + subjectMatch);
							if (getReply.equalsIgnoreCase("Re: ")) {
								int rr=0;
							//	System.out.println("Text mail");
								
								PreparedStatement ps_replyContent = con.prepareStatement("select * from complaint_unassigned_reply_tbl where reply_content='"+ getText(message) + "'");
								ResultSet rs_replyContent = ps_replyContent.executeQuery();

								while (rs_replyContent.next()) {
									rr = rs_replyContent.getInt("customer_unassigned_reply_id");
								}
								//	System.out.println("rct varia" + rct);
								if (rr > 0) {
								//	System.out.println("IN LOOP Same");
								} else if (rr == 0) {
									
									PreparedStatement ps_Umail = con.prepareStatement("select * from complaint_tbl_unassigned where Mail_Subject='"
												+ subjectMatch + "'");
								ResultSet rs_Umail = ps_Umail.executeQuery();
								while (rs_Umail.next()) {
									PreparedStatement ps_reply = con
											.prepareStatement("insert into complaint_unassigned_reply_tbl (unassign_id,reply_content,enable_id) values(?,?,?)");
									ps_reply.setInt(1,
											rs_Umail.getInt("unassign_id"));
									ps_reply.setString(2, getText(message));
									ps_reply.setInt(3, 1);
									int r = ps_reply.executeUpdate();
									maxUID = rs_Umail.getInt("unassign_id");
									}
								}

							} else {
								int ch=0;
								PreparedStatement ps_newun=con.prepareStatement("select * from complaint_tbl_unassigned where Mail_Content='"+getText(message)+"'");
								ResultSet rs_newun=ps_newun.executeQuery();
								while(rs_newun.next()){
									ch=rs_newun.getInt("unassign_id");
								}
								if(ch>0){
								//	System.out.println("In Loop 2");
								}else {
								//	System.out.println("Text Mail");
									PreparedStatement ps_inc = con.prepareStatement("insert into complaint_tbl_unassigned(Mail_Subject,Mail_From,Mail_Content,Enable_Id,Mail_Received_Date,Company_Id)values(?,?,?,?,?,?)");
									ps_inc.setString(1, message.getSubject());
									ps_inc.setString(2, from);
									ps_inc.setString(3, getText(message));
									ps_inc.setInt(4, enable);
									ps_inc.setTimestamp(5, convertedDate);
									ps_inc.setInt(6, comp_id);
									a = ps_inc.executeUpdate();
									
									PreparedStatement ps_id1=con.prepareStatement("select max(unassign_id) from complaint_tbl_unassigned");
									ResultSet rs_id1=ps_id1.executeQuery();
									while(rs_id1.next()){
										maxUID=rs_id1.getInt("max(unassign_id)");
									}
								}
						}

							// ---------------------------------------------------------------------------------------------------------

						}

						// ****************************************************************************************************************************
						String contentType = message.getContentType();
						String messageContent = "";
						// store attachment file name, separated by comma
						String attachFiles = "";
						if (contentType.contains("multipart")) {
							// content may contain attachments
							Multipart multiPart = (Multipart) message.getContent();
							int numberOfParts = multiPart.getCount();
							for (int partCount = 0; partCount < numberOfParts; partCount++) {
								MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
								// System.out.println("encoding == "
								// + part.getEncoding());
								if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
									// this part is attachment
									String fileName = part.getFileName();
									attachFiles += fileName + ", ";
									// part.saveFile("d:/EmailFiles/" +
									// fileName);

									String strFilePath = "c:/EmailFiles/" + fileName;

									InputStream is = part.getInputStream();

									FileOutputStream fos = new FileOutputStream(strFilePath);
									File yourFile = new File("strFilePath");

									if (!yourFile.exists()) {
									//	System.out.println("File not exist... at location..");
										yourFile.createNewFile();
									}
									// Part strContent = (Part)
									// part.getContent();
									int ijk = 0;

									while ((ijk = is.read()) != -1) {
										// System.out.println("writing file...");
										fos.write(ijk);
									}

									// *****************************************************************************************************************
									File file = new File("c:/EmailFiles/" + fileName);
									InputStream f = new FileInputStream(file);
									if (leng != messages.length) {
										//System.out.println("Unassigned Id Attachments = " + maxUID);
										// -------------------------------------------------------------------------------------------------------------------------
										if (maxUID != 0) {
										//	System.out.println("In loop file name is ================================= "+ fileName);
											PreparedStatement ps_inc1 = con.prepareStatement("insert into complaint_tbl_unassigned_attachment(Mail_Attachment,File_Name,unassign_Id,Recieved_Date,Delete_Status)values(?,?,?,?,?)");
											ps_inc1.setBinaryStream(1, f);
											ps_inc1.setString(2, fileName);
											ps_inc1.setInt(3, maxUID);
											ps_inc1.setTimestamp(4,convertedDate);
											ps_inc1.setInt(5, 1);
											b = ps_inc1.executeUpdate();
										} 
										/*else {
											
											PreparedStatement ps_inc1 = con.prepareStatement("insert into complaint_tbl_unassigned_attachment(Mail_Attachment,File_Name,unassign_Id,Recieved_Date,Delete_Status)values(?,?,?,?,?)");
											ps_inc1.setBinaryStream(1, f);
											ps_inc1.setString(2, fileName);
											ps_inc1.setInt(3, maxUID);
											ps_inc1.setTimestamp(4, convertedDate);
											ps_inc1.setInt(5, 1);
											b = ps_inc1.executeUpdate();
										} */
										// -------------------------------------------------------------------------------------------------------------------------
								 	}

									// *****************************************************************************************************************

								} else {
									// this part may be the message content
									messageContent = part.getContent()
											.toString();

									Object msgContent = messages[i]
											.getContent();

									String content = "";

									/*
									 * Check if content is pure text/html or in
									 * parts
									 */
									if (msgContent instanceof Multipart) {

										Multipart multipart = (Multipart) msgContent;

										// Log.e("BodyPart",
										// "MultiPartCount: "+multipart.getCount());

										for (int j = 0; j < multipart
												.getCount(); j++) {

											bodyPart = multipart.getBodyPart(j);

											String disposition = bodyPart
													.getDisposition();

											if (disposition != null
													&& (disposition
															.equalsIgnoreCase("ATTACHMENT"))) {
												//System.out.println("Mail have some attachment");

												DataHandler handler = bodyPart
														.getDataHandler();
												//System.out.println("file name : "+ handler.getName());
											} else {
												// System.out.println("Contents = "
												// + messages[i].getContent());

											}
										}
									} else
										// content =
										// messages[i].getContent().toString();

										content = (bodyPart.getContent()
												.toString());
									// System.out.println("Contents of mail ==== "
									// + content);
								}
							}

							if (attachFiles.length() > 1) {
								attachFiles = attachFiles.substring(0,
										attachFiles.length() - 2);
							}
						}
					}
				}
				emailFolder.close(false);
				emailStore.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	//	System.out.println("In Thread/Timer no 4");
	}

	private boolean textIsHtml = false;

	private String getText(Part p) throws MessagingException, IOException {
		if (p.isMimeType("text/*")) {
			String s = (String) p.getContent();
			textIsHtml = p.isMimeType("text/html");
			return s;
		}

		if (p.isMimeType("multipart/alternative")) {
			// prefer html text over plain text
			Multipart mp = (Multipart) p.getContent();
			String text = null;
			for (int i = 0; i < mp.getCount(); i++) {
				Part bp = mp.getBodyPart(i);
				if (bp.isMimeType("text/plain")) {
					if (text == null)
						text = getText(bp);
					continue;
				} else if (bp.isMimeType("text/html")) {
					String s = getText(bp);
					if (s != null)
						return s;
				} else {
					return getText(bp);
				}
			}
			return text;
		} else if (p.isMimeType("multipart/*")) {
			Multipart mp = (Multipart) p.getContent();
			for (int i = 0; i < mp.getCount(); i++) {
				String s = getText(mp.getBodyPart(i));
				if (s != null)
					return s;
			}
		}

		return null;
	}

}
