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
import com.muthagroup.vo.Cab_ApproveDecline_Request_Customer_Vo;
//============================================================================-->
//============================ Data Access Model =============================-->
//============================================================================-->
public class Cab_ApproveDecline_Request_Customer_DAO {
	boolean flag = false;

	public boolean registerApproval(Cab_ApproveDecline_Request_Customer_Vo bean, HttpSession session, ArrayList appsellist) {
		int approval_type = 0;
		int cr_no = 0;
		String remark = null;
		int uid = 0;
		int c = 0, d = 0;
		Timestamp original_date = null;
		String approval = null;
		int cnt1 = 0, cnt2 = 0, cnt3 = 0;
		int Status_id = 1;
		ArrayList listApprovee = new ArrayList();
		approval_type = bean.getApproval_type();
		cr_no = bean.getCr_no();
		remark = bean.getRemark();
		uid = bean.getUid();
		// To get Todays Date ====== >>>
		Timestamp date_today = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		//System.out.println("by date..:" + dateFormat.format(date));
		date_today = new java.sql.Timestamp(date.getTime());
		// ****************************************************************************************
		try {
			Connection con = Connection_Utility.getConnection();
			String approalGiven = "";
			PreparedStatement ps_appThis = con.prepareStatement("select * from cr_tbl_approval_Type where Approval_Id="+bean.getApproval_type());
			ResultSet rs_appthis = ps_appThis.executeQuery();
			while(rs_appthis.next()){
				approalGiven = rs_appthis.getString("Approval_Type");
			}
			// ****************************************************************************************

			if (appsellist.size() != 0) {

				ArrayList newuidapp = new ArrayList();
				for (int appr = 0; appr < appsellist.size(); appr++) {
					PreparedStatement ps_approvers = con.prepareStatement("select * from user_tbl where U_Name='"+ appsellist.get(appr).toString() + "'");
					ResultSet rs_appsel = ps_approvers.executeQuery();
					while (rs_appsel.next()) {
						newuidapp.add(rs_appsel.getInt("U_Id"));
					}
				}
				int app_his = 0, apprll = 0;
				for (int appr = 0; appr < newuidapp.size(); appr++) {
					PreparedStatement ps_approver = con.prepareStatement("insert into crc_tbl_approver_rel (CRC_No,U_Id)values(?,?)");
					ps_approver.setInt(1, cr_no);
					ps_approver.setInt(2,
							Integer.parseInt(newuidapp.get(appr).toString()));
					apprll = ps_approver.executeUpdate();
				}

				for (int appr1 = 0; appr1 < newuidapp.size(); appr1++) {

					PreparedStatement ps_approv = con
							.prepareStatement("insert into crc_tbl_approver_rel_hist(CRC_A_Rel_Hist_Date,CRC_No,U_Id)values(?,?,?)");
					ps_approv.setTimestamp(1, date_today);
					ps_approv.setInt(2, cr_no);
					ps_approv.setInt(3,
							Integer.parseInt(newuidapp.get(appr1).toString()));

					app_his = ps_approv.executeUpdate();

				}
				int Approval_id = 2, approv = 0;
				for (int a = 0; a < newuidapp.size(); a++) {
					PreparedStatement ps_approv = con.prepareStatement("insert into crc_tbl_approval(CRC_No,U_Id,Approval_Id)values(?,?,?)");
					ps_approv.setInt(1, cr_no);
					ps_approv.setInt(2, Integer.parseInt(newuidapp.get(a).toString()));
					ps_approv.setInt(3, Approval_id);
					approv = ps_approv.executeUpdate();
					PreparedStatement ps_approv_hist = con.prepareStatement("insert into crc_tbl_approval_hist(CRC_Approval_Date_Hist,U_Id,CRC_No,Approval_Id)values(?,?,?,?)");
					ps_approv_hist.setTimestamp(1, date_today);
					ps_approv_hist.setInt(2, Integer.parseInt(newuidapp.get(a).toString()));
					ps_approv_hist.setInt(3, cr_no);
					ps_approv_hist.setInt(4, Approval_id); 
					int approval_hist = ps_approv_hist.executeUpdate(); 
				}
			}
			// ****************************************************************************************
			PreparedStatement ps_uidappr = con.prepareStatement("select * from user_tbl where U_Id=" + uid);
			String UName = null;
			ArrayList id1 = new ArrayList();
			ResultSet rs_uidappr = ps_uidappr.executeQuery();
			while (rs_uidappr.next()) {
				UName = rs_uidappr.getString("U_Name");
				PreparedStatement ps_id = con.prepareStatement("select * from user_tbl where U_Name='" + UName + "'");
				ResultSet rs_id = ps_id.executeQuery();
				while (rs_id.next()) {
					id1.add(rs_id.getInt("U_Id"));
				}
			}
			// *****************************************************************************************

			PreparedStatement ps_AppUid = con.prepareStatement("select * from crc_tbl_approval where CRC_No=" + cr_no);
			ResultSet rsAppUid = ps_AppUid.executeQuery();
			while (rsAppUid.next()) {
				for (int s = 0; s < id1.size(); s++) {
					if (rsAppUid.getInt("U_Id") == Integer.parseInt(id1.get(s).toString())) {
						//System.out.println("Inside Loop ");
						PreparedStatement ps_approve = con.prepareStatement("update crc_tbl_approval set Approval_Id=?,Remark=?,CRC_Approval_Date=? where crc_no=" + cr_no
										+ " and U_Id="
										+ Integer.parseInt(id1.get(s).toString()));
						ps_approve.setInt(1, approval_type);
						ps_approve.setString(2, remark);
						ps_approve.setTimestamp(3, date_today); 
						c = ps_approve.executeUpdate(); 
						PreparedStatement ps_date = con.prepareStatement("select * from crc_tbl_approval where crc_no="
										+ cr_no
										+ " and U_Id="
										+ Integer.parseInt(id1.get(s).toString()));
						ResultSet rs_date = ps_date.executeQuery();
						while (rs_date.next()) {
							original_date = rs_date.getTimestamp("CRC_Approval_Date");
							// listApprovee.add(rs_date.getInt("Approval_Id"));
							//System.out.println("Approveeeeee ==== "+ listApprovee.size());
						}

						PreparedStatement ps_approve_hist = con.prepareStatement("insert into crc_tbl_approval_hist(CRC_Approval_Date_Hist,U_Id,CRC_No,Approval_Id,Remark,CR_Status_Id,CRC_Approval_Date)values(?,?,?,?,?,?,?)");
						ps_approve_hist.setTimestamp(1, date_today);
						ps_approve_hist.setInt(2, Integer.parseInt(id1.get(s).toString()));
						ps_approve_hist.setInt(3, cr_no);
						ps_approve_hist.setInt(4, approval_type);
						ps_approve_hist.setString(5, remark);
						ps_approve_hist.setInt(6, Status_id);
						ps_approve_hist.setTimestamp(7, original_date);

						d = ps_approve_hist.executeUpdate();

						// *****************************************************************************************************************
						// *****************************************************************************************************************
						// Email Configuration ====== >>

						ArrayList uidList = new ArrayList();
						String name = null, Cr_Date = null;

						ArrayList categoryID = new ArrayList();
						ArrayList category = new ArrayList();
						ArrayList ctypeId = new ArrayList();
						ArrayList ctype = new ArrayList();
						ArrayList app_uid = new ArrayList();
						ArrayList approveID = new ArrayList();
						ArrayList App_remark = new ArrayList();

						int company_id = 0, Item_Id = 0;
						double total_stock = 0, existwip = 0, ascast = 0, toolold = 0, toolnew = 0, oldfix = 0, newfix = 0;
						String Change_For = null, PPAP = null, company = null, item = null, cust = null, existchlevel = null, newchangelevel = null, nature = null, reason = null;
						double oldg = 0, newg = 0;
						PreparedStatement ps_crtbl = con.prepareStatement("select * from crc_tbl where CRC_No=" + cr_no);
						ResultSet rs_crtbl = ps_crtbl.executeQuery();
						while (rs_crtbl.next()) {
							Cr_Date = rs_crtbl.getString("CRC_Date");
							company_id = rs_crtbl.getInt("Company_id");
							total_stock = rs_crtbl.getDouble("Total_Stock");
							Item_Id = rs_crtbl.getInt("Item_Id");
							Change_For = rs_crtbl.getString("Change_For");
							PPAP = rs_crtbl.getString("PPAP");
							existwip = rs_crtbl.getDouble("Existing_WIP_Stock");
							toolold = rs_crtbl.getDouble("Tooling_Old");
							toolnew = rs_crtbl.getDouble("Tooling_New");
							oldfix = rs_crtbl.getDouble("Fixture_Old");
							newfix = rs_crtbl.getDouble("Fixture_New");
							oldg = rs_crtbl.getDouble("Gauges_Old");
							newg = rs_crtbl.getDouble("Gauges_New");
							ascast = rs_crtbl.getDouble("Existing_As_Cast_Stock");
							existchlevel = rs_crtbl.getString("Existing_Change_level");
							newchangelevel = rs_crtbl.getString("New_Change_level");
							PreparedStatement ps_cust = con.prepareStatement("select * from customer_tbl where Cust_Id=" + rs_crtbl.getString("Cust_Id"));
							ResultSet rs_cust = ps_cust.executeQuery();
							while (rs_cust.next()) {
								cust = rs_cust.getString("Cust_Name");
							}
						}
						PreparedStatement ps_company = con.prepareStatement("select Company_Name from user_tbl_company where company_id="
										+ company_id);
						ResultSet rs_company = ps_company.executeQuery();
						while (rs_company.next()) {
							company = rs_company.getString("Company_Name");
						}
						rs_company.close();

						PreparedStatement ps_item = con.prepareStatement("select Item_Name from customer_tbl_item where Item_id=" + Item_Id);
						ResultSet rs_item = ps_item.executeQuery();

						while (rs_item.next()) {
							item = rs_item.getString("Item_Name");
						}
						rs_company.close();

						ArrayList cno = new ArrayList();

						PreparedStatement ps_crtblapproval = con.prepareStatement("select * from crc_tbl_approval where CRC_No=" + cr_no);
						ResultSet rs_approval = ps_crtblapproval.executeQuery();
						while (rs_approval.next()) {
							//System.out.println("appr ids added..." + rs_approval.getInt("Approval_Id"));
							approveID.add(rs_approval.getInt("Approval_Id"));
							App_remark.add(rs_approval.getString("Remark"));
							listApprovee.add(rs_approval.getInt("Approval_Id"));
							app_uid.add(rs_approval.getInt("U_Id"));
							cno.add(rs_approval.getInt("CRC_No"));
						}

						PreparedStatement ps_UserTbl = con.prepareStatement("select * from user_tbl where U_Id=" + Integer.parseInt(id1.get(s).toString()));
						ResultSet rs_User = ps_UserTbl.executeQuery();
						while (rs_User.next()) {
							name = rs_User.getString("U_Name");
						}

						// ******************************************************************************************************************
						ArrayList dept = new ArrayList();
						PreparedStatement ps_dept = con.prepareStatement("select * from crc_tbl_cocern_dept where CRC_No=" + cr_no);
						ResultSet rs_dept = ps_dept.executeQuery();
						while (rs_dept.next()) {
							PreparedStatement ps_deptcon = con.prepareStatement("select * from user_tbl_dept where dept_id=" + rs_dept.getInt("dept_id"));
							ResultSet rsdeptcon = ps_deptcon.executeQuery();
							while (rsdeptcon.next()) {
								dept.add(rsdeptcon.getString("Department"));
							}
						}

						for (int apee = 0; apee < listApprovee.size(); apee++) {
							if (Integer.parseInt(listApprovee.get(apee).toString()) == 1) {
								cnt1++;
							} else if (Integer.parseInt(listApprovee.get(apee).toString()) == 2) {
								cnt2++;
							} else if (Integer.parseInt(listApprovee.get(apee).toString()) == 3) {
								cnt3++;
							}
						}

						if (cnt1 == listApprovee.size() && cnt2 == 0
								&& cnt3 == 0) {
							approval = "Approved";
						} else if (cnt1 >= 0 && cnt2 > 0 && cnt3 == 0) {
							approval = "Pending";
						} else if (cnt1 >= 0 && cnt2 >= 0 && cnt3 > 0) {
							approval = "Declined";
						}
						//System.out.println("Approval Type info = = = = "  + approval);
						//System.out.println("Approve id size...." + listApprovee.size());

						PreparedStatement ps_auto = null;
						ResultSet rs_auto = null;
						ArrayList email = new ArrayList();
						ArrayList approvee = new ArrayList();

						for (int at = 0; at < app_uid.size(); at++) {
							ps_auto = con.prepareStatement("select * from user_tbl where U_Id=" + Integer.parseInt(app_uid.get(at).toString()));
							rs_auto = ps_auto.executeQuery();
							while (rs_auto.next()) {
								email.add(rs_auto.getString("U_Email"));
								approvee.add(rs_auto.getString("U_Name"));
							}
						}

						if (approval.equalsIgnoreCase("Approved")) {
							//System.out.println("Testing approved...........");

							String host = "send.one.com";
							String user = "ecn@muthagroup.com";
							String pass = "ecn@xyz";

							Date date111 = Calendar.getInstance().getTime();
							DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
							String today = formatter.format(date111);

							String from = "ecn@muthagroup.com";
							String subject = "Change Request Action === > " + approval;

							boolean sessionDebug = false;
							// *********************************************************************************************
							// multiple recipients : == >
							// *********************************************************************************************
							/*ArrayList topEmail = new ArrayList();
							PreparedStatement ps_Topauto = con.prepareStatement("select * from automail");
							ResultSet rs_Topauto = ps_Topauto.executeQuery();
							while (rs_Topauto.next()) {
								topEmail.add(rs_Topauto.getString("Email"));
							}*/
							String[] recipients = new String[email.size()];
							
							for (int g = 0; g < email.size(); g++) {
								recipients[g] = email.get(g).toString();
							}

							// *********************************************************************************************
							try {

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
									addressTo[i] = new InternetAddress(
											recipients[i]);
								}
 								msg.setRecipients(Message.RecipientType.TO,addressTo);
								msg.setSubject(subject);
								msg.setSentDate(new Date());
								msg.setContent(
										"<b style='color: #0C8C06;'><blink> Change "
												+ approval
												+ "</blink> </b>"
												+ "<p> <b>Request Number :</b>"
												+ cr_no
												+ ", </p>"

												+ "<p><b>Customer Name : </b>"
												+ cust
												+ ", "
												+ "</p>"

												+ "<p><b>Item Name : </b>"
												+ item
												+ ", "
												+ "</p>"

												+ "<p><b>Change Request For : </b>"
												+ company
												+ "</p>"

												+ "<p><b>Change For : </b>"
												+ Change_For

												+ ", "
												+ "</p>"
												+ "<p><b>Existing change level : </b>"
												+ existchlevel

												+ ", "
												+ "</p>"
												+ "<p><b>New change level : </b>"
												+ newchangelevel

												+ ", "
												+ "</p>"
												+ "<p><b>Nature of Change  : </b>"
												+ nature

												+ ", "
												+ "</p>"
												+ "<p><b>Reason for change  : </b>"
												+ reason

												+ ", "
												+ "</p>"
												+ "<p><b>Existing Stock ===> </br>WIP  : </b>"
												+ existwip

												+ "<b>As Cast  : </b>"
												+ ascast

												+ ", "
												+ "</p>"
												+ "<p><b>Total Stock Avilable : </b>"
												+ total_stock

												+ ", "
												+ "</p>"
												+ "<p><b>Tooling ===> </br>Old  : </b>"
												+ toolold

												+ "</p><b>New  : </b>"
												+ toolnew

												+ ", "
												+ "</p>"
												+ "<p><b>Old Fixture : </b>"
												+ oldfix

												+ "</p><b>New Fixture : </b>"
												+ newfix

												+ ", "
												+ "</p>"
												+ "<p><b>Gauges ===> </p><p>Old Gauges  : </b>"
												+ oldg

												+ "</p><b>New Gauges : </b>"
												+ newg
												+ ", "
												+ "</p>"
												+ "<p><b>PPAP : </b>"
												+ PPAP

												+ ", "
												+ "</p>"
												+ "<p><b>Concern Department : </b>"
												+ dept

												+ ", "
												+ "</p>"
												+ "<p><b>Approvers Name : </b>"
												+ approvee

												+ "<p><b>Change Request is "+ approalGiven + " by :</b>"
												+ name
												+ ", "
												+ "</p>"

												+ "<p><b>Remark Given :</b>"
												+ remark
												+ ", "
												+ "</p>"

												+ "<p><b>Change Received date :</b>"
												+ Cr_Date
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

								// msg.setText(messageText);
								Transport transport = mailSession.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg,msg.getAllRecipients());
								transport.close();
								flag = true;
							} catch (Exception e) {
								e.printStackTrace();
							}
							// **********************************************************************************

						} else if (approval.equalsIgnoreCase("Pending")) {
							//System.out.println("Testing Pending...........");

							String host = "send.one.com";
							String user = "ecn@muthagroup.com";
							String pass = "ecn@xyz";

							Date date111 = Calendar.getInstance().getTime();
							DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
							String today = formatter.format(date111);

							String from = "ecn@muthagroup.com";
							String subject = "Change Request Action === > " + approval;

							boolean sessionDebug = false;
							// *********************************************************************************************
							// multiple recipients : == >
							// *********************************************************************************************

							/*ArrayList topEmail = new ArrayList();
							PreparedStatement ps_Topauto = con.prepareStatement("select * from automail");
							ResultSet rs_Topauto = ps_Topauto.executeQuery();
							while (rs_Topauto.next()) {
								topEmail.add(rs_Topauto.getString("Email"));
							}*/

							String[] recipients = new String[email.size()];
							for (int g = 0; g < email.size(); g++) {
								recipients[g] = email.get(g).toString();
							}
							
							/*for (int tt = 0; tt < topEmail.size(); tt++) {
								recipients[tt + email.size()] = topEmail
										.get(tt).toString();
							}*/ 
							// ********************************************************************************************* 
							try {

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

								msg.setRecipients(Message.RecipientType.TO,addressTo);

								msg.setSubject(subject);
								msg.setSentDate(new Date());
								msg.setContent(

										"<b style='color: #0C8C06;'><blink> Change "
												+ approval
												+ "</blink></b>"
												+

												"<p><b>Request Number :</b>"
												+ cr_no
												+ ", </p>"

												+ "<p><b>Customer Name : </b>"
												+ cust
												+ ", "
												+ "</p>"

												+ "<p><b>Item Name : </b>"
												+ item
												+ ", "
												+ "</p>"

												+ "<p><b>Change Request For : </b>"
												+ company
												+ "</p>"

												+ "<p><b>Change For : </b>"
												+ Change_For

												+ ", "
												+ "</p>"
												+ "<p><b>Existing change level : </b>"
												+ existchlevel

												+ ", "
												+ "</p>"
												+ "<p><b>New change level : </b>"
												+ newchangelevel

												+ ", "
												+ "</p>"
												+ "<p><b>Nature of Change  : </b>"
												+ nature

												+ ", "
												+ "</p>"
												+ "<p><b>Reason for change  : </b>"
												+ reason

												+ ", "
												+ "</p>"
												+ "<p><b>Existing Stock ===> </br>WIP  : </b>"
												+ existwip

												+ "<b>As Cast  : </b>"
												+ ascast

												+ ", "
												+ "</p>"
												+ "<p><b>Total Stock Avilable : </b>"
												+ total_stock

												+ ", "
												+ "</p>"
												+ "<p><b>Tooling ===> </br>Old  : </b>"
												+ toolold

												+ "</p><b>New  : </b>"
												+ toolnew

												+ ", "
												+ "</p>"
												+ "<p><b>Old Fixture : </b>"
												+ oldfix

												+ "</p><b>New Fixture : </b>"
												+ newfix

												+ ", "
												+ "</p>"
												+ "<p><b>Gauges ===> </p><p>Old Gauges  : </b>"
												+ oldg

												+ "</p><b>New Gauges : </b>"
												+ newg
												+ ", "
												+ "</p>"
												+ "<p><b>PPAP : </b>"
												+ PPAP

												+ ", "
												+ "</p>"
												+ "<p><b>Concern Department : </b>"
												+ dept

												+ ", "
												+ "</p>"
												+ "<p><b>Approvers Name : </b>"
												+ approvee

												+ "</p>"

+ "<p><b>Change Request is "+ approalGiven + " by :</b>"
+ name
+ ", "
+ "</p>"

+ "<p><b>Remark Given :</b>"
+ remark
+ ", "
+ "</p>"

												+ "<p><b>Change Received date :</b>"
												+ Cr_Date
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

								// msg.setText(messageText);
								Transport transport = mailSession.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg, msg.getAllRecipients());

								transport.close();
								flag = true;
							} catch (Exception e) {
								e.printStackTrace();
							}
							// **********************************************************************************

						} else if (approval.equalsIgnoreCase("Declined")) {
							//System.out.println("Testing Declined...........");
							String host = "send.one.com";
							String user = "ecn@muthagroup.com";
							String pass = "ecn@xyz";

							Date date111 = Calendar.getInstance().getTime();
							DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
							String today = formatter.format(date111);

							String from = "ecn@muthagroup.com";
							String subject = "Change Request Action === > " + approval;

							boolean sessionDebug = false;
							// *********************************************************************************************
							// multiple recipients : == >
							// *********************************************************************************************

							/*ArrayList topEmail = new ArrayList();
							PreparedStatement ps_Topauto = con.prepareStatement("select * from automail");
							ResultSet rs_Topauto = ps_Topauto.executeQuery();
							while (rs_Topauto.next()) {
								topEmail.add(rs_Topauto.getString("Email"));
							}*/
							
							String[] recipients = new String[email.size()];
							for (int g = 0; g < email.size(); g++) {
								recipients[g] = email.get(g).toString();
							}
							/*
							for (int tt = 0; tt < topEmail.size(); tt++) {
								recipients[tt + email.size()] = topEmail.get(tt).toString();
							}
							*/
							// *********************************************************************************************
							try { 
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

								msg.setRecipients(Message.RecipientType.TO,addressTo);

								msg.setSubject(subject);
								msg.setSentDate(new Date());
								msg.setContent(
										"<b style='color: #0C8C06;'>Change "
												+ approval
												+ "</b>"
												+ "<p><b>Request Number :</b>"
												+ cr_no
												+ ", "
												+ " </p>"

												+ "<p><b>Customer Name : </b>"
												+ cust
												+ ", "
												+ "</p>"

												+ "<p><b>Item Name : </b>"
												+ item
												+ ", "
												+ "</p>"

												+ "<p><b>Change Request For : </b>"
												+ company
												+ "</p>"

												+ "<p><b>Change For : </b>"
												+ Change_For

												+ ", "
												+ "</p>"
												+ "<p><b>Existing change level : </b>"
												+ existchlevel

												+ ", "
												+ "</p>"
												+ "<p><b>New change level : </b>"
												+ newchangelevel

												+ ", "
												+ "</p>"
												+ "<p><b>Nature of Change  : </b>"
												+ nature

												+ ", "
												+ "</p>"
												+ "<p><b>Reason for change  : </b>"
												+ reason

												+ ", "
												+ "</p>"
												+ "<p><b>Existing Stock ===> </br>WIP  : </b>"
												+ existwip

												+ "<b>As Cast  : </b>"
												+ ascast

												+ ", "
												+ "</p>"
												+ "<p><b>Total Stock Avilable : </b>"
												+ total_stock

												+ ", "
												+ "</p>"
												+ "<p><b>Tooling ===> </br>Old  : </b>"
												+ toolold

												+ "</p><b>New  : </b>"
												+ toolnew

												+ ", "
												+ "</p>"
												+ "<p><b>Old Fixture : </b>"
												+ oldfix

												+ "</p><b>New Fixture : </b>"
												+ newfix

												+ ", "
												+ "</p>"
												+ "<p><b>Gauges ===> </p><p>Old Gauges  : </b>"
												+ oldg

												+ "</p><b>New Gauges : </b>"
												+ newg
												+ ", "
												+ "</p>"
												+ "<p><b>PPAP : </b>"
												+ PPAP

												+ ", "
												+ "</p>"
												+ "<p><b>Concern Department : </b>"
												+ dept

												+ ", "
												+ "</p>"
												+ "<p><b>Approvers Name : </b>"
												+ approvee

												+ "</p>"

+ "<p><b>Change Request is "+ approalGiven + " by :</b>"
+ name
+ ", "
+ "</p>"

+ "<p><b>Remark Given :</b>"
+ remark
+ ", "
+ "</p>"

												+ "<p><b>Change Received date :</b>"
												+ Cr_Date
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

								// msg.setText(messageText);
								Transport transport = mailSession.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg,msg.getAllRecipients());

								transport.close();
								flag = true;
							} catch (Exception e) {
								e.printStackTrace();
							}
							// **********************************************************************************
						}
					}
				} 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}
