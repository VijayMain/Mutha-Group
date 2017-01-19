package it.muthagroup.dao;

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

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.DMS_VO;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DMS_DevDAO {

	public void uploadFileDevDMS(HttpSession session, DMS_VO bean, HttpServletResponse response) { 
			boolean flag=false;
			try {
				java.util.Date date= new java.util.Date();
				Timestamp sqlDate = new Timestamp(date.getTime());
				Calendar cal = Calendar.getInstance();
		        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		        String strDate = sdf.format(cal.getTime());
				
				
				Connection con = Connection_Utility.getConnection();
				int uid = Integer.parseInt(session.getAttribute("uid").toString());
				PreparedStatement ps = con.prepareStatement("insert into tarn_dms(TRAN_NO,FILE,FILE_NAME,USER,TRAN_DATE,STATUS,NOTE,SYS_DATE)values(?,?,?,?,?,?,?,?)");
				ps.setInt(1, bean.getCode());
				ps.setBlob(2, bean.getBlob_file());
				ps.setString(3, bean.getBlob_name());
				ps.setInt(4, uid);
				ps.setTimestamp(5, sqlDate);
				ps.setInt(6, 1);
				ps.setString(7, bean.getNote());
				ps.setTimestamp(8, sqlDate);
				
				int up = ps.executeUpdate();
				if(up>0){
					String reg_uname = "";
					int trncode=0;
					PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
					ResultSet rs_uname = ps_uname.executeQuery();
					while (rs_uname.next()) { 
						reg_uname = rs_uname.getString("U_Name");
					}
					
					ps_uname = con.prepareStatement("select max(CODE) from tarn_dms");
					rs_uname = ps_uname.executeQuery();
					while (rs_uname.next()) { 
						trncode = rs_uname.getInt("max(CODE)");
					}
					
					
					PreparedStatement ps_fileHist = con.prepareStatement("insert into mst_dmshist(DMS_CODE,TRAN_FILE,USER,DATE,STATUS,TRAN_CODE)values(?,?,?,?,?,?)");
					ps_fileHist.setInt(1, bean.getCode());
					ps_fileHist.setString(2, bean.getBlob_name());
					ps_fileHist.setString(3, reg_uname);
					ps_fileHist.setTimestamp(4, sqlDate);
					ps_fileHist.setString(5, "New File");
					ps_fileHist.setInt(6, trncode);
					
					int up_hist =  ps_fileHist.executeUpdate();
			 		
					
					PreparedStatement ps_devinfo = con.prepareStatement("insert into tarn_dms_devrel(tran_code,carried_out,bill_no,dated,forrs,pur_order,creator,logDate)values(?,?,?,?,?,?,?,?)");
					ps_devinfo.setInt(1, trncode);
					ps_devinfo.setString(2, bean.getCarriedout());
					ps_devinfo.setString(3, bean.getVidebill());
					ps_devinfo.setTimestamp(4, bean.getDemo4());
					ps_devinfo.setString(5, bean.getForrs());
					ps_devinfo.setString(6, bean.getPurorder());
					ps_devinfo.setString(7, reg_uname);
					ps_devinfo.setTimestamp(8, sqlDate);
					
					up_hist = ps_devinfo.executeUpdate();
					 
						boolean sent = false;
						String host = "send.one.com";
						String user = "itsupports@muthagroup.com";
						String pass = "itsupports@xyz";
						String from = "itsupports@muthagroup.com";
						String subject = "Development Record Attached in DMS system";
						boolean sessionDebug = false;
						// *********************************************************************************************
						// multiple recipients : == >
						// *********************************************************************************************
						String report = "DMS_NewFile";
						ArrayList to_emails = new ArrayList();
						Connection conLocal = Connection_Utility.getLocalDatabase();
						PreparedStatement ps_rec = conLocal.prepareStatement("select * from pending_approvee where type='to' and report='"+ report + "'");
						ResultSet rs_rec = ps_rec.executeQuery();
						while (rs_rec.next()) {
							to_emails.add(rs_rec.getString("email"));
						}
						  
						Properties props = System.getProperties();
						props.put("mail.host", host);
						props.put("mail.transport.protocol", "smtp");
						props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
						props.put("mail.smtp.auth", "true");
						props.put("mail.smtp.port", 465);
						
						Session mailSession = Session.getDefaultInstance(props, null);
						mailSession.setDebug(sessionDebug);
						Message msg = new MimeMessage(mailSession);
						msg.setFrom(new InternetAddress(from)); 
						StringBuilder sb = new StringBuilder(); 
						sb.append("<b style='color: #0D265E;font-size: 9px;'>This is an automatically generated email from IT Tracker - Document Approval system</p>");
						sb.append("<p style='font-size: 12px;'>Please Note : Below attached document is pending for approval, Please Approve using IT Tracker-DMS</p>"+
								"<table border='1' width='97%' style='font-family: Arial;'><tr style='font-size: 12px;background-color:#94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+ 
								"<th height='25'>File Name</th>"+
								"<th>Carried Out By</th>"+
								"<th>Vide Bill No</th>"+
								"<th>Dated</th>"+
								"<th>For Rs.</th>"+
								"<th>Work / Purchase Order No</th>"+
								"<th>Creator</th>"+
								"<th>Created Date</th>"+
								"<th>Approval</th>"+
								"</tr>");
						
							sb.append("<tr>"+
								"<td>"+bean.getBlob_name()+"</td>"+
								"<td>"+bean.getCarriedout()+"</td>"+
								"<td align='right'>"+bean.getVidebill()+"</td>"+
								"<td>"+bean.getDate_dms()+"</td>"+
								"<td align='right'>"+bean.getForrs()+"</td>"+
								"<td>"+bean.getPurorder()+"</td>"+
								"<td>"+reg_uname+"</td>"+
								"<td>"+strDate+"</td>"+
								"<td><b>Pending</b></td>"+
								"</tr>");
							
							
		 				sb.append("</table><p>"
								+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
								+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
								+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
								+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
								+ "</font></p>");
		 				
		 				InternetAddress[] addressBcc = new InternetAddress[1];
						for (int p = 0; p < to_emails.size(); p++) {
		 				addressBcc[0] = new InternetAddress(to_emails.get(p).toString()); 
						msg.setRecipients(Message.RecipientType.TO, addressBcc);  
						 }   
						
						msg.setSubject(subject);
						msg.setSentDate(new Date());
						msg.setContent(sb.toString(), "text/html"); 
							Transport transport = mailSession.getTransport("smtp");
							transport.connect(host, user, pass);
							transport.sendMessage(msg, msg.getAllRecipients());
							transport.close(); 
					 
					flag=true;
				}
				if(flag==true){
					String msg = "Successfully Submitted !!!"; 
					response.sendRedirect("DMS.jsp?msg=" + msg);
					}else{
						String msg = "Data upload failed !!!"; 
						response.sendRedirect("DMS.jsp?msg=" + msg);	
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
}