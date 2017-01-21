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
import com.muthagroup.vo.Cab_ApproveDecline_Request_Vo;
//============================================================================-->
//============================ Data Access Model =============================-->
//============================================================================-->
public class Cab_ApproveDecline_Request_DAO {

	boolean flag = false;

	public boolean registerApproval(Cab_ApproveDecline_Request_Vo bean,
			HttpSession session, ArrayList appsellist) {
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
		String company = null, part = null, Present = null, Proposed = null, Objective = null;
		ArrayList app = new ArrayList();
		ArrayList newuidapp = new ArrayList();
		ArrayList newApprovers = new ArrayList();

		
		cr_no = bean.getCr_no();

		remark = bean.getRemark();

		uid = bean.getUid();

		// To get Todays Date ====== >>>
		Timestamp date_today = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		System.out.println("by date..:" + dateFormat.format(date));

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

				for (int appr = 0; appr < appsellist.size(); appr++) {
					PreparedStatement ps_approvers = con
							.prepareStatement("select * from user_tbl where U_Name='"
									+ appsellist.get(appr).toString() + "'");
					ResultSet rs_appsel = ps_approvers.executeQuery();
					while (rs_appsel.next()) {
						newuidapp.add(rs_appsel.getInt("U_Id"));
					}
				}
				int app_his = 0, apprll = 0;

				int delete_rows = 0, delete_rows1 = 0;

				if (newuidapp.size() > 0) {

					PreparedStatement ps_deleteOrgApprovers = con
							.prepareStatement("delete from cr_approver_relation_tbl where cr_no="
									+ cr_no);

					delete_rows = ps_deleteOrgApprovers.executeUpdate();

				}
				if (delete_rows > 0) {

					for (int appr = 0; appr < newuidapp.size(); appr++) {
						PreparedStatement ps_approver = con
								.prepareStatement("insert into cr_approver_relation_tbl (CR_No,U_Id)values(?,?)");
						ps_approver.setInt(1, cr_no);
						ps_approver.setInt(2, Integer.parseInt(newuidapp.get(
								appr).toString()));
						apprll = ps_approver.executeUpdate();
					}

					for (int appr1 = 0; appr1 < newuidapp.size(); appr1++) {

						PreparedStatement ps_approv = con
								.prepareStatement("insert into cr_approver_relation_tbl_hist(CR_A_Rel_Hist_Date,CR_No,U_Id)values(?,?,?)");
						ps_approv.setTimestamp(1, date_today);
						ps_approv.setInt(2, cr_no);
						ps_approv.setInt(3, Integer.parseInt(newuidapp.get(
								appr1).toString()));

						app_his = ps_approv.executeUpdate();

					}
					int Approval_id = 2, approv = 0;
				}

			}

			// ****************************************************************************************

			PreparedStatement ps_uidappr = con
					.prepareStatement("select * from user_tbl where U_Id="
							+ uid);
			String UName = null;
			ArrayList id1 = new ArrayList();
			ResultSet rs_uidappr = ps_uidappr.executeQuery();
			while (rs_uidappr.next()) {
				UName = rs_uidappr.getString("U_Name");
				PreparedStatement ps_id = con
						.prepareStatement("select * from user_tbl where U_Name='"
								+ UName + "'");
				ResultSet rs_id = ps_id.executeQuery();
				while (rs_id.next()) {
					id1.add(rs_id.getInt("U_Id"));
				}
			}
			// ***********************************************************************************************************************

			PreparedStatement ps_AppUid = con
					.prepareStatement("select * from cr_tbl_approval where CR_No="
							+ cr_no);
			ResultSet rsAppUid = ps_AppUid.executeQuery();

			ArrayList ExtApprovers = new ArrayList();
			ArrayList ExtApproversNames = new ArrayList();
			while (rsAppUid.next()) {

				for (int s = 0; s < id1.size(); s++) {
					if (rsAppUid.getInt("U_Id") == Integer.parseInt(id1.get(s)
							.toString())) {
						// System.out.println("Inside Loop ");
						PreparedStatement ps_approve = con
								.prepareStatement("update cr_tbl_approval set Approval_Id=?,Remark=?,CR_Approval_Date=? where cr_no="
										+ cr_no
										+ " and U_Id="
										+ Integer.parseInt(id1.get(s)
												.toString()));

						ps_approve.setInt(1, approval_type);
						ps_approve.setString(2, remark);
						ps_approve.setTimestamp(3, date_today);

						c = ps_approve.executeUpdate();

						PreparedStatement ps_date = con
								.prepareStatement("select * from cr_tbl_approval where cr_no="
										+ cr_no
										+ " and U_Id="
										+ Integer.parseInt(id1.get(s)
												.toString()));
						ResultSet rs_date = ps_date.executeQuery();
						while (rs_date.next()) {
							original_date = rs_date
									.getTimestamp("CR_Approval_Date");
							// listApprovee.add(rs_date.getInt("Approval_Id"));
							// System.out.println("Approveeeeee ==== " +
							// listApprovee);
						}

						PreparedStatement ps_getU_Id = con
								.prepareStatement("select U_Id from CR_Tbl_Approval where cr_No="
										+ cr_no);
						ResultSet rs_getU_Id = ps_getU_Id.executeQuery();

						while (rs_getU_Id.next()) {
							ExtApprovers.add(rs_getU_Id.getInt("U_Id"));
						}

						for (int ss = 0; ss < ExtApprovers.size(); ss++) {
							PreparedStatement ps_UName = con
									.prepareStatement("select U_Name from User_Tbl where U_Id="
											+ Integer.parseInt(ExtApprovers
													.get(ss).toString()));
							ResultSet rs_UName = ps_UName.executeQuery();

							while (rs_UName.next()) {
								ExtApproversNames.add(rs_UName
										.getString("U_Name"));
							}

						}

						if (appsellist.size() != 0
								&& ExtApproversNames.size() != 0) {
							for (int a1 = 0; a1 < ExtApproversNames.size(); a1++) {
								for (int b1 = 0; b1 < appsellist.size(); b1++) {
									if (ExtApproversNames.contains(appsellist
											.get(b1))) {
										appsellist.remove(b1);

									} else {
										continue;
									}
								}
							}

						}

						int user_id = 0;
						PreparedStatement ps_getUId = null;
						PreparedStatement ps_addUId = null;
						PreparedStatement ps_addUId_Hist = null;

						System.out
								.println("************************* selected approver list.... "
										+ appsellist);
						System.out
								.println("************************* Extra selected approver list.... "
										+ ExtApproversNames);

						for (int dd = 0; dd < appsellist.size(); dd++) {
							ps_getUId = con
									.prepareStatement("select max(U_Id) from User_Tbl where U_name='"
											+ appsellist.get(dd).toString()
											+ "'");

							ResultSet rs_getUId = ps_getUId.executeQuery();

							while (rs_getUId.next()) {
								user_id = rs_getUId.getInt("max(U_Id)");

								// System.out.println("user id for approval.... "+user_id);

								ps_addUId = con
										.prepareStatement("insert into cr_tbl_approval(U_Id,CR_No,Approval_Id)values(?,?,?)");

								ps_addUId.setInt(1, user_id);
								ps_addUId.setInt(2, cr_no);
								ps_addUId.setInt(3, 2);
								// ps_addUId.setTimestamp(4, date_today);

								ps_addUId.executeUpdate();

								ps_addUId_Hist = con
										.prepareStatement("insert into cr_tbl_approval_hist(U_Id,CR_No,Approval_Id,CR_Approval_Date_Hist)values(?,?,?,?)");

								ps_addUId_Hist.setInt(1, user_id);
								ps_addUId_Hist.setInt(2, cr_no);
								ps_addUId_Hist.setInt(3, 2);
								ps_addUId_Hist.setTimestamp(4, date_today);

								ps_addUId_Hist.executeUpdate();

							}

						}
						appsellist.clear();

						PreparedStatement ps_approve_hist = con
								.prepareStatement("insert into cr_tbl_approval_hist(CR_Approval_Date_Hist,U_Id,CR_No,Approval_Id,Remark,CR_Status_Id,CR_Approval_Date)values(?,?,?,?,?,?,?)");

						ps_approve_hist.setTimestamp(1, date_today);
						ps_approve_hist.setInt(2,
								Integer.parseInt(id1.get(s).toString()));
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

						PreparedStatement ps_crtbl = con
								.prepareStatement("select * from cr_tbl where CR_No="
										+ cr_no);
						ResultSet rs_crtbl = ps_crtbl.executeQuery();
						while (rs_crtbl.next()) {
							Cr_Date = rs_crtbl.getString("CR_Date");
							Present = rs_crtbl.getString("Present_System");
							Proposed = rs_crtbl.getString("Proposed_System");
							Objective = rs_crtbl.getString("Objective");

							PreparedStatement ps_comp = con
									.prepareStatement("select * from user_tbl_company where Company_Id="
											+ rs_crtbl.getInt("Company_Id"));
							ResultSet rs_comp = ps_comp.executeQuery();
							while (rs_comp.next()) {
								company = rs_comp.getString("Company_Name");
							}

							PreparedStatement ps_part = con
									.prepareStatement("select * from customer_tbl_item where Item_Id="
											+ rs_crtbl.getInt("Item_Id"));
							ResultSet rs_part = ps_part.executeQuery();
							while (rs_part.next()) {
								part = rs_part.getString("Item_Name");
							}

						}

						ArrayList cno = new ArrayList();

						PreparedStatement ps_crtblapproval = con
								.prepareStatement("select * from cr_tbl_approval where CR_No="
										+ cr_no);
						ResultSet rs_approval = ps_crtblapproval.executeQuery();
						while (rs_approval.next()) {
							System.out.println("appr ids added..."
									+ rs_approval.getInt("Approval_Id"));
							approveID.add(rs_approval.getInt("Approval_Id"));
							App_remark.add(rs_approval.getString("Remark"));
							listApprovee.add(rs_approval.getInt("Approval_Id"));
							app_uid.add(rs_approval.getInt("U_Id"));
							cno.add(rs_approval.getInt("CR_No"));
						}

						for (int ap = 0; ap < app_uid.size(); ap++) {
							PreparedStatement ps_appr = con
									.prepareStatement("select * from user_tbl where U_Id="
											+ Integer.parseInt(app_uid.get(ap)
													.toString()));
							ResultSet rs_Userappr = ps_appr.executeQuery();

							while (rs_Userappr.next()) {
								app.add(rs_Userappr.getString("U_Name"));
							}
						}
						System.out.println("..................." + app);
						PreparedStatement ps_UserTbl = con
								.prepareStatement("select * from user_tbl where U_Id="
										+ Integer.parseInt(id1.get(s)
												.toString()));
						ResultSet rs_User = ps_UserTbl.executeQuery();

						while (rs_User.next()) {
							name = rs_User.getString("U_Name");
						}

						PreparedStatement ps_category = con
								.prepareStatement("select * from cr_category_relation_tbl where CR_No="
										+ cr_no);
						ResultSet rs_category = ps_category.executeQuery();

						while (rs_category.next()) {
							categoryID
									.add(rs_category.getInt("CR_Category_Id"));
						}

						for (int a = 0; a < categoryID.size(); a++) {
							PreparedStatement ps_cat = con
									.prepareStatement("select * from cr_tbl_category where CR_Category_Id="
											+ Integer.parseInt(categoryID
													.get(a).toString()));
							ResultSet rs_cat = ps_cat.executeQuery();
							while (rs_cat.next()) {
								category.add(rs_cat.getString("CR_Category"));
							}
						}

						PreparedStatement ps_ctype = con
								.prepareStatement("select * from cr_ctype_relation_tbl where CR_No="
										+ cr_no);
						ResultSet rs_ctype = ps_ctype.executeQuery();

						while (rs_ctype.next()) {
							ctypeId.add(rs_ctype.getInt("CR_Type_Id"));
						}

						for (int b = 0; b < ctypeId.size(); b++) {
							PreparedStatement ps_ct = con
									.prepareStatement("select * from cr_tbl_type where CR_Type_Id="
											+ Integer.parseInt(ctypeId.get(b)
													.toString()));
							ResultSet rs_ct = ps_ct.executeQuery();

							while (rs_ct.next()) {
								ctype.add(rs_ct.getString("CR_Type"));
							}
						}

						// ******************************************************************************************************************

						for (int apee = 0; apee < listApprovee.size(); apee++) {
							if (Integer.parseInt(listApprovee.get(apee)
									.toString()) == 1) {
								cnt1++;
							} else if (Integer.parseInt(listApprovee.get(apee)
									.toString()) == 2) {
								cnt2++;
							} else if (Integer.parseInt(listApprovee.get(apee)
									.toString()) == 3) {
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
						System.out.println("Approval Type info = = = = "
								+ approval);
						System.out.println("Approve id size...."
								+ listApprovee.size());

						if (approval.equalsIgnoreCase("Pending")) {

							System.out.println("Pending in looop ............");

							String host = "send.one.com";
							String user = "ecn@muthagroup.com";
							String pass = "ecn@xyz";

							Date date111 = Calendar.getInstance().getTime();
							DateFormat formatter = new SimpleDateFormat(
									"dd/MM/yyyy");
							String today = formatter.format(date111);

							String from = "ecn@muthagroup.com";
							String subject = "Change Request Action === > "
									+ approval;

							boolean sessionDebug = false;
							// *********************************************************************************************
							// multiple recipients : == >
							// *********************************************************************************************

							PreparedStatement ps_auto = null;
							ResultSet rs_auto = null;
							ArrayList email = new ArrayList();
							for (int at = 0; at < app_uid.size(); at++) {
								ps_auto = con
										.prepareStatement("select * from user_tbl where U_Id="
												+ Integer.parseInt(app_uid.get(
														at).toString()));
								rs_auto = ps_auto.executeQuery();
								while (rs_auto.next()) {
									email.add(rs_auto.getString("U_Email"));
								}
								// System.out.println("emails ===== " + email);
							}
							ArrayList topEmail = new ArrayList();
							PreparedStatement ps_Topauto = con
									.prepareStatement("select * from automail");
							ResultSet rs_Topauto = ps_Topauto.executeQuery();
							while (rs_Topauto.next()) {
								topEmail.add(rs_Topauto.getString("Email"));
							}

							String[] recipients = new String[email.size()
									+ topEmail.size()];
							for (int g = 0; g < email.size(); g++) {
								recipients[g] = email.get(g).toString();
							}
							for (int tt = 0; tt < topEmail.size(); tt++) {
								recipients[tt + email.size()] = topEmail
										.get(tt).toString();
							}
							// for (int tt1 = 0; tt1 < recipients.length; tt1++)
							// {
							// //System.out.println("Recipients ====== "+
							// recipients[tt1]);
							// }

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
								
								Session mailSession = Session
										.getDefaultInstance(props, null);
								mailSession.setDebug(sessionDebug);
								Message msg = new MimeMessage(mailSession);
								msg.setFrom(new InternetAddress(from));
								InternetAddress[] addressTo = new InternetAddress[recipients.length];

								for (int i = 0; i < recipients.length; i++) {
									addressTo[i] = new InternetAddress(
											recipients[i]);
								}

								msg.setRecipients(Message.RecipientType.TO,
										addressTo);

								msg.setSubject(subject);
								msg.setSentDate(new Date());
								msg.setContent(
										"<b style='color: #A69514;'><blink>Change "
												+ approval
												+ "</b></blink>"
												+ "<p><b>Request Number :</b>"
												+ cr_no
												+ ", "
												+ " </p>"

												+ "<p><b>Company Name :  </b>"
												+ company
												+ ", "
												+ "</p>"
												+ "<p><b>Part Name :  </b>"
												+ part
												+ ", "
												+ "</p>"
												+ "<p><b>Approvers Name :  </b>"
												+ app
												+ ", "
												+ "</p>"
												+ "<p><b>Present_System :  </b>"
												+ Present
												+ ", "
												+ "</p>"
												+ "<p><b>Proposed_System :  </b>"
												+ Proposed
												+ ", "
												+ "</p>"
												+ "<p><b>Objective :  </b>"
												+ Objective
												+ ", "
												+ "</p>"
												+ "<p><b>Related To :  </b>"
												+ category
												+ ", "
												+ "</p>"
												+ "<p><b>Change Type/Types : </b>"
												+ ctype
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
												+ "<p><b style='color: #330B73;'>Thanks & Regards </b></p><p></br> Mutha Group Satara </p>"
												+ "<hr>"
												+ "<p><b>Disclaimer :</b></p>"
												+ "<font face='Times New Roman' size='1'>"
												+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
										"Text/html");

								// msg.setText(messageText);
								Transport transport = mailSession
										.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg,
										msg.getAllRecipients());

								transport.close();
								flag = true;
							} catch (Exception e) {
								e.printStackTrace();
							}
							// **********************************************************************************

							flag = true;

						} else if (approval.equalsIgnoreCase("Approved")) {

							System.out
									.println("Approved in looop ............");

							String host = "send.one.com";
							String user = "ecn@muthagroup.com";
							String pass = "ecn@xyz";

							Date date111 = Calendar.getInstance().getTime();
							DateFormat formatter = new SimpleDateFormat(
									"dd/MM/yyyy");
							String today = formatter.format(date111);

							String from = "ecn@muthagroup.com";
							String subject = "Change Request Action === > "
									+ approval;

							boolean sessionDebug = false;
							// *********************************************************************************************
							// multiple recipients : == >
							// *********************************************************************************************

							PreparedStatement ps_auto = null;
							ResultSet rs_auto = null;
							ArrayList email = new ArrayList();
							for (int at = 0; at < app_uid.size(); at++) {
								ps_auto = con
										.prepareStatement("select * from user_tbl where U_Id="
												+ Integer.parseInt(app_uid.get(
														at).toString()));
								rs_auto = ps_auto.executeQuery();
								while (rs_auto.next()) {
									email.add(rs_auto.getString("U_Email"));
								}
								System.out.println("emails ===== " + email);
							}
							ArrayList topEmail = new ArrayList();
							PreparedStatement ps_Topauto = con
									.prepareStatement("select * from automail");
							ResultSet rs_Topauto = ps_Topauto.executeQuery();
							while (rs_Topauto.next()) {
								topEmail.add(rs_Topauto.getString("Email"));
							}

							String[] recipients = new String[email.size()
									+ topEmail.size()];
							for (int g = 0; g < email.size(); g++) {
								recipients[g] = email.get(g).toString();
							}
							for (int tt = 0; tt < topEmail.size(); tt++) {
								recipients[tt + email.size()] = topEmail
										.get(tt).toString();
							}
							for (int tt1 = 0; tt1 < recipients.length; tt1++) {
								System.out.println("Recipients ====== "
										+ recipients[tt1]);
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

								msg.setRecipients(Message.RecipientType.TO,
										addressTo);

								msg.setSubject(subject);
								msg.setSentDate(new Date());
								msg.setContent(
										"<b style='color: #0C8C06;'><blink>Change "
												+ approval
												+ "</b></blink>"
												+ "<p><b>Request Number :</b>"
												+ cr_no
												+ ", "
												+ " </p>"

												+ "<p><b>Company Name :  </b>"
												+ company
												+ ", "
												+ "</p>"
												+ "<p><b>Part Name :  </b>"
												+ part
												+ ", "
												+ "</p>"
												+ "<p><b>Approvers Name :  </b>"
												+ app
												+ ", "
												+ "</p>"
												+ "<p><b>Present_System :  </b>"
												+ Present
												+ ", "
												+ "</p>"
												+ "<p><b>Proposed_System :  </b>"
												+ Proposed
												+ ", "
												+ "</p>"
												+ "<p><b>Objective :  </b>"
												+ Objective
												+ ", "
												+ "</p>"
												+ "<p><b>Related To :  </b>"
												+ category
												+ ", "
												+ "</p>"
												+ "<p><b>Change Type/Types : </b>"
												+ ctype
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
												+ "<p><b style='color: #330B73;'>Thanks & Regards </b></p><p> Mutha Group Satara </p>"
												+ "<hr>"
												+ "<p><b>Disclaimer :</b></p>"
												+ "<p><font face='Times New Roman' size='1'>"
												+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
										"Text/html");

								// msg.setText(messageText);
								Transport transport = mailSession
										.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg,
										msg.getAllRecipients());

								transport.close();
								flag = true;
							} catch (Exception e) {
								e.printStackTrace();
							}
							// **********************************************************************************

							flag = true;
						} else if (approval.equalsIgnoreCase("Declined")) {
							System.out.println("Decline in looop ............");
							String host = "send.one.com";
							String user = "ecn@muthagroup.com";
							String pass = "ecn@xyz";

							Date date111 = Calendar.getInstance().getTime();
							DateFormat formatter = new SimpleDateFormat(
									"dd/MM/yyyy");
							String today = formatter.format(date111);

							String from = "ecn@muthagroup.com";
							String subject = "Change Request Action === > "
									+ approval;

							boolean sessionDebug = false;
							// *********************************************************************************************
							// multiple recipients : == >
							// *********************************************************************************************

							PreparedStatement ps_auto = null;
							ResultSet rs_auto = null;
							ArrayList email = new ArrayList();
							for (int at = 0; at < app_uid.size(); at++) {
								ps_auto = con
										.prepareStatement("select * from user_tbl where U_Id="
												+ Integer.parseInt(app_uid.get(
														at).toString()));
								rs_auto = ps_auto.executeQuery();
								while (rs_auto.next()) {
									email.add(rs_auto.getString("U_Email"));
								}
								System.out.println("emails ===== " + email);
							}
							ArrayList topEmail = new ArrayList();
							PreparedStatement ps_Topauto = con
									.prepareStatement("select * from automail");
							ResultSet rs_Topauto = ps_Topauto.executeQuery();
							while (rs_Topauto.next()) {
								topEmail.add(rs_Topauto.getString("Email"));
							}

							String[] recipients = new String[email.size()
									+ topEmail.size()];
							for (int g = 0; g < email.size(); g++) {
								recipients[g] = email.get(g).toString();
							}
							for (int tt = 0; tt < topEmail.size(); tt++) {
								recipients[tt + email.size()] = topEmail
										.get(tt).toString();
							}
							for (int tt1 = 0; tt1 < recipients.length; tt1++) {
								System.out.println("Recipients ====== "
										+ recipients[tt1]);
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
								
								Session mailSession = Session
										.getDefaultInstance(props, null);
								mailSession.setDebug(sessionDebug);
								Message msg = new MimeMessage(mailSession);
								msg.setFrom(new InternetAddress(from));
								InternetAddress[] addressTo = new InternetAddress[recipients.length];

								for (int i = 0; i < recipients.length; i++) {
									addressTo[i] = new InternetAddress(
											recipients[i]);
								}

								msg.setRecipients(Message.RecipientType.TO,
										addressTo);

								msg.setSubject(subject);
								msg.setSentDate(new Date());
								msg.setContent(
										"<b style='color: #991724;'><blink>Change "
												+ approval
												+ "</b></blink>"
												+ "<p><b>Request Number :</b>"
												+ cr_no
												+ ", "
												+ " </p>"

												+ "<p><b>Company Name :  </b>"
												+ company
												+ ", "
												+ "</p>"
												+ "<p><b>Part Name :  </b>"
												+ part
												+ ", "
												+ "</p>"
												+ "<p><b>Approvers Name :  </b>"
												+ app
												+ ", "
												+ "</p>"
												+ "<p><b>Present_System :  </b>"
												+ Present
												+ ", "
												+ "</p>"
												+ "<p><b>Proposed_System :  </b>"
												+ Proposed
												+ ", "
												+ "</p>"
												+ "<p><b>Objective :  </b>"
												+ Objective
												+ ", "
												+ "</p>"
												+ "<p><b>Related To :  </b>"
												+ category
												+ ", "
												+ "</p>"
												+ "<p><b>Change Type/Types : </b>"
												+ ctype
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
								Transport transport = mailSession
										.getTransport("smtp");
								transport.connect(host, user, pass);
								transport.sendMessage(msg,
										msg.getAllRecipients());

								transport.close();
								flag = true;
							} catch (Exception e) {
								e.printStackTrace();
							}
							// **********************************************************************************

							flag = true;

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
//============================================================================--> 
//============================================================================-->