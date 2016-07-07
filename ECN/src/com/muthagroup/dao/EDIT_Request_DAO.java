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
import com.muthagroup.vo.change_Request_Vo;
//============================================================================-->
//============================ Data Access Model =============================-->
//============================================================================-->
public class EDIT_Request_DAO {

	// *********************************************************************************************************************************
	public boolean Edit_ChangeRequest(change_Request_Vo bean,
			ArrayList app_list, ArrayList chang_list, HttpSession session,
			ArrayList trk_list) {

		boolean flag = false;

		if (bean.getApproved() != "") {
			int app_ctype = 0, count = 0, crno = 0;
			int ctype = 0;

			try {

				String complaint_no = null;
				int c = 0;
				complaint_no = bean.getComplaint_No();
				System.out.println("Complaint No in dao ... :" + complaint_no);
				// ******************************************************************************************************************
				// Get Change number ====== >>>
				crno = bean.getCrno();
				// *******************************************************************************************************************
				// *********************************************************************************************************************
				// Register change ======= >>>
				Connection con = Connection_Utility.getConnection();
				int status = 1;

				if (complaint_no.equalsIgnoreCase("null")) {

					PreparedStatement ps_change = con
							.prepareStatement("update cr_tbl set Company_Id=?,Item_Id=?,Present_System=?,Proposed_System=?,Objective=?,CR_Date=?,Proposed_Impl_Date=?,Actual_Impl_Date=?,CR_Status_Id=?,U_Id=? where CR_No="
									+ crno);
					ps_change.setInt(1, bean.getCompany_Id());
					ps_change.setInt(2, bean.getItem_Id());
					ps_change.setString(3, bean.getPresent_System());
					ps_change.setString(4, bean.getProposed_System());
					ps_change.setString(5, bean.getObjective());
					ps_change.setTimestamp(6, bean.getCR_Date());
					ps_change.setTimestamp(7, bean.getProposed_Impl_Date());
					ps_change.setTimestamp(8, bean.getActual_Impl_Date());
					ps_change.setInt(9, status);
					ps_change.setInt(10, Integer.parseInt(session.getAttribute(
							"uid").toString()));
					c = ps_change.executeUpdate();
				}

				else {
					PreparedStatement ps_change = con
							.prepareStatement("update cr_tbl set Company_Id=?,Item_Id=?,Present_System=?,Proposed_System=?,Objective=?,CR_Date=?,Proposed_Impl_Date=?,Actual_Impl_Date=?,Complaint_No=?,CR_Status_Id=?,U_Id=? where CR_No="
									+ crno);
					ps_change.setInt(1, bean.getCompany_Id());
					ps_change.setInt(2, bean.getItem_Id());
					ps_change.setString(3, bean.getPresent_System());
					ps_change.setString(4, bean.getProposed_System());
					ps_change.setString(5, bean.getObjective());
					ps_change.setTimestamp(6, bean.getCR_Date());
					ps_change.setTimestamp(7, bean.getProposed_Impl_Date());
					ps_change.setTimestamp(8, bean.getActual_Impl_Date());
					ps_change.setString(9, bean.getComplaint_No());
					ps_change.setInt(10, status);
					ps_change.setInt(11, Integer.parseInt(session.getAttribute(
							"uid").toString()));
					c = ps_change.executeUpdate();

				}

				// *********************************************************************************************************************

				// *********************************************************************************************************************
				// Tracking changes======>
				ResultSet rs_tr = null;
				ArrayList listtr = new ArrayList();
				PreparedStatement ps_tr = null;
				System.out.println("Trk === " + trk_list);
				for (int tr = 0; tr < trk_list.size(); tr++) {
					ps_tr = con
							.prepareStatement("select * from cr_tracking_change where TC_Type='"
									+ trk_list.get(tr).toString() + "'");
					rs_tr = ps_tr.executeQuery();
					while (rs_tr.next()) {

						listtr.add(rs_tr.getInt("TC_Id"));
					}
				}

				System.out.println("list trk ====== " + listtr);
				PreparedStatement ps_trset_del = con
						.prepareStatement("delete from cr_tc_rel_tbl where cr_no="
								+ crno);
				int f1 = 0;

				f1 = ps_trset_del.executeUpdate();

				for (int trset = 0; trset < listtr.size(); trset++) {
					PreparedStatement ps_trcg = con
							.prepareStatement("insert into cr_tc_rel_tbl(CR_No,TC_Id)values(?,?)");
					ps_trcg.setInt(1, crno);
					ps_trcg.setInt(2,
							Integer.parseInt(listtr.get(trset).toString()));
					int trchg = ps_trcg.executeUpdate();
				}

				// **********************************************************************************************************************

				// **********************************************************************************************************************
				// Get List Of selected Approvers======>>>>
				PreparedStatement ps_del = con
						.prepareStatement("delete from cr_approver_relation_tbl where CR_No="
								+ crno);
				int delapp = ps_del.executeUpdate();

				if(app_list.contains(17)){
					System.out.println("total list" + app_list);
					System.out.println("In loop Approval = Anoop Sir");
				}else {
					app_list.add(17);
					System.out.println("total list else loop = " + app_list);
					
				}
				
				ResultSet rs_app = null;
				// ArrayList approver_list = new ArrayList();
				PreparedStatement ps_app = null;

				for (int f = 0; f < app_list.size(); f++) {

					PreparedStatement ps_approver = con
							.prepareStatement("insert into cr_approver_relation_tbl(CR_No,U_Id)values(?,?)");
					ps_approver.setInt(1, crno);
					ps_approver.setInt(2,
							Integer.parseInt(app_list.get(f).toString()));

					app_ctype = ps_approver.executeUpdate();

				}

				// *********************************************************************************************************************
				// *********************************************************************************************************************
				// Get selected Change Type ======== >>>

				PreparedStatement ps_delcat = con
						.prepareStatement("delete from cr_ctype_relation_tbl where CR_No="
								+ crno);
				int delcat = ps_delcat.executeUpdate();

				ResultSet rstype = null;
				ArrayList changetype_list = new ArrayList();
				for (int ch = 0; ch < chang_list.size(); ch++) {
					PreparedStatement pstype_change = con
							.prepareStatement("select * from cr_tbl_type where CR_Type='"
									+ chang_list.get(ch).toString() + "'");
					rstype = pstype_change.executeQuery();
					while (rstype.next()) {
						changetype_list.add(rstype.getInt("CR_Type_Id"));
					}
				}

				for (int ct = 0; ct < changetype_list.size(); ct++) {

					PreparedStatement ps_cr_change = con
							.prepareStatement("insert into cr_ctype_relation_tbl(CR_No,CR_Type_Id)values(?,?)");
					ps_cr_change.setInt(1, crno);
					ps_cr_change.setInt(2, Integer.parseInt(changetype_list
							.get(ct).toString()));

					ctype = ps_cr_change.executeUpdate();
				}

				// *********************************************************************************************************************
				// *********************************************************************************************************************
				// Insert into Change Category ===== >>>>
				PreparedStatement ps_delrel = con
						.prepareStatement("delete from cr_category_relation_tbl where CR_No="
								+ crno);
				int delrel = ps_delrel.executeUpdate();

				ArrayList categoryList = new ArrayList();

				categoryList.add(bean.getCost());
				categoryList.add(bean.getQuality());
				categoryList.add(bean.getDelivery());
				categoryList.add(bean.getMaterial());
				categoryList.add(bean.getSafety());
				categoryList.add(bean.getDimensional());
				System.out.println("Testing Category List ====== "
						+ categoryList);
				for (java.util.Iterator itr = categoryList.iterator(); itr
						.hasNext();) {
					if (itr.next() == null) {
						itr.remove();
					}

				}

				for (int list = 0; list < categoryList.size(); list++) {
					System.out.println("Category List = "
							+ categoryList.get(list).toString());
					PreparedStatement ps_category = con
							.prepareStatement("insert into cr_category_relation_tbl(CR_No,CR_Category_Id)values(?,?)");
					ps_category.setInt(1, crno);
					ps_category
							.setInt(2, Integer.parseInt(categoryList.get(list)
									.toString()));
					count = ps_category.executeUpdate();

				}
				// *********************************************************************************************************************
				// ****************************************************************************************

				// To get Todays Date ====== >>>
				DateFormat dateFormat = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				// get current date time with Date()
				Date date = new Date();
				System.out.println("by date..:" + dateFormat.format(date));

				java.sql.Timestamp timestamp = new java.sql.Timestamp(
						date.getTime());

				System.out.println("by TIMESTAMP..:" + timestamp);

				// ****************************************************************************************
				// To Maintain Logs ======= >>>>

				int his = 0;

				if (complaint_no.equalsIgnoreCase("null")) {

					PreparedStatement ps_ctype_hist = con
							.prepareStatement("insert into cr_tbl_hist(CR_Hist_Date,CR_No,Company_Id,Item_Id,Present_System,Proposed_System,Objective,CR_Date,Proposed_Impl_Date,Actual_Impl_Date,U_Id)values(?,?,?,?,?,?,?,?,?,?,?)");
					ps_ctype_hist.setTimestamp(1, timestamp);
					ps_ctype_hist.setInt(2, crno);
					ps_ctype_hist.setInt(3, bean.getCompany_Id());
					ps_ctype_hist.setInt(4, bean.getItem_Id());
					ps_ctype_hist.setString(5, bean.getPresent_System());
					ps_ctype_hist.setString(6, bean.getProposed_System());
					ps_ctype_hist.setString(7, bean.getObjective());
					ps_ctype_hist.setTimestamp(8, bean.getCR_Date());
					ps_ctype_hist.setTimestamp(9, bean.getProposed_Impl_Date());
					ps_ctype_hist.setTimestamp(10, bean.getActual_Impl_Date());
					ps_ctype_hist.setInt(11, Integer.parseInt(session
							.getAttribute("uid").toString()));

					his = ps_ctype_hist.executeUpdate();

				}

				else {
					PreparedStatement ps_ctype_hist = con
							.prepareStatement("insert into cr_tbl_hist(CR_Hist_Date,CR_No,Company_Id,Item_Id,Present_System,Proposed_System,Objective,CR_Date,Proposed_Impl_Date,Actual_Impl_Date,Complaint_No,U_Id)values(?,?,?,?,?,?,?,?,?,?,?,?)");
					ps_ctype_hist.setTimestamp(1, timestamp);
					ps_ctype_hist.setInt(2, crno);
					ps_ctype_hist.setInt(3, bean.getCompany_Id());
					ps_ctype_hist.setInt(4, bean.getItem_Id());
					ps_ctype_hist.setString(5, bean.getPresent_System());
					ps_ctype_hist.setString(6, bean.getProposed_System());
					ps_ctype_hist.setString(7, bean.getObjective());
					ps_ctype_hist.setTimestamp(8, bean.getCR_Date());
					ps_ctype_hist.setTimestamp(9, bean.getProposed_Impl_Date());
					ps_ctype_hist.setTimestamp(10, bean.getActual_Impl_Date());
					ps_ctype_hist.setString(11, complaint_no);
					ps_ctype_hist.setInt(12, Integer.parseInt(session
							.getAttribute("uid").toString()));
					his = ps_ctype_hist.executeUpdate();

				}

				// **************************************************************************************************************
				// **************************************************************************************************************
				// Maintain Logs for Change type ======== >>>

				ArrayList hist_ctype = new ArrayList();
				ArrayList hist_ctypeID = new ArrayList();
				PreparedStatement ps_CR_T_Rel_Id = con
						.prepareStatement("select * from cr_ctype_relation_tbl where CR_No="
								+ crno);
				ResultSet rs_CR_T_Rel_Id = ps_CR_T_Rel_Id.executeQuery();
				while (rs_CR_T_Rel_Id.next()) {
					// hist_ctype.add(rs_CR_T_Rel_Id.getInt("CR_T_Rel_Id"));
					hist_ctypeID.add(rs_CR_T_Rel_Id.getInt("CR_Type_Id"));

				}
				int b = 0;

				for (int hist = 0; hist < hist_ctypeID.size(); hist++) {

					PreparedStatement cr_ctype_hist = con
							.prepareStatement("insert into cr_ctype_relation_tbl_hist(CR_T_Rel_Hist_Date,CR_No,CR_Type_Id)values(?,?,?)");
					cr_ctype_hist.setTimestamp(1, timestamp);
					cr_ctype_hist.setInt(2, crno);
					cr_ctype_hist
							.setInt(3, Integer.parseInt(hist_ctypeID.get(hist)
									.toString()));

					b = cr_ctype_hist.executeUpdate();
				}
				// ***********************************************************************************************************
				// ***********************************************************************************************************
				// To maintain logs for Change category ========>>>>>
				ArrayList hiscat = new ArrayList();
				ArrayList hiscat11 = new ArrayList();
				PreparedStatement ps_category_hist = con
						.prepareStatement("select * from cr_category_relation_tbl where CR_No="
								+ crno);
				ResultSet rs_hiscat = ps_category_hist.executeQuery();
				while (rs_hiscat.next()) {
					// hiscat.add(rs_hiscat.getInt("CR_C_Rel_Id"));
					hiscat11.add(rs_hiscat.getInt("CR_Category_Id"));
				}

				int a = 0;
				for (int cathis = 0; cathis < hiscat11.size(); cathis++) {

					PreparedStatement ps_cathisrel = con
							.prepareStatement("insert into cr_category_relation_tbl_hist(CR_C_Rel_Hist_Date,CR_No,CR_Category_Id)values(?,?,?)");
					ps_cathisrel.setTimestamp(1, timestamp);
					ps_cathisrel.setInt(2, crno);
					ps_cathisrel.setInt(3,
							Integer.parseInt(hiscat11.get(cathis).toString()));

					a = ps_cathisrel.executeUpdate();
				}

				// ***********************************************************************************************************
				// ***********************************************************************************************************
				// To maintain logs for Approvers selected ==== >>>>>

				ArrayList list_approver11 = new ArrayList();

				PreparedStatement ps_approver = con
						.prepareStatement("select * from cr_approver_relation_tbl where CR_No="
								+ bean.getCrno());
				ResultSet rs_approver = ps_approver.executeQuery();
				while (rs_approver.next()) {
					list_approver11.add(rs_approver.getInt("U_Id"));
				}
				int app_his = 0;
				for (int appr = 0; appr < list_approver11.size(); appr++) {

					PreparedStatement ps_approv = con
							.prepareStatement("insert into cr_approver_relation_tbl_hist(CR_A_Rel_Hist_Date,CR_No,U_Id)values(?,?,?)");
					ps_approv.setTimestamp(1, timestamp);
					ps_approv.setInt(2, crno);
					ps_approv.setInt(3, Integer.parseInt(list_approver11.get(
							appr).toString()));

					app_his = ps_approv.executeUpdate();

				}
				// *************************************************************************************************************
				// *************************************************************************************************************
				// ... Add the data to the Cr_Tbl_Approval to add the default
				// approval type as a Pending......

				PreparedStatement ps_approvaldel = con
						.prepareStatement("delete from cr_tbl_approval where CR_No="
								+ crno);
				int psap = ps_approvaldel.executeUpdate();

				int approval_id = 2;

				System.out.println("USER ID... :"
						+ Integer.parseInt(session.getAttribute("uid")
								.toString()));

				PreparedStatement ps_approv = null;
				int approval_hist = 0;
				int approval = 0;
				int approv_id = 0;
				String or_date = null;
				for (int appr = 0; appr < list_approver11.size(); appr++) {

					ps_approv = con
							.prepareStatement("insert into cr_tbl_approval(CR_No,U_Id,Approval_Id,CR_Approval_Date)values(?,?,?,?)");

					ps_approv.setInt(1, crno);
					ps_approv.setInt(2, Integer.parseInt(list_approver11.get(
							appr).toString()));
					ps_approv.setInt(3, approval_id);
					ps_approv.setTimestamp(4, timestamp);

					approval = ps_approv.executeUpdate();

					// PreparedStatement
					// ps_approv_id=con.prepareStatement("select max(CR_No) from cr_tbl_Approval");
					// ResultSet rs_approv_id=ps_approv_id.executeQuery();
					//
					// while(rs_approv_id.next())
					// {
					// approv_id=rs_approv_id.getInt("max(CR_No)");
					// }
					//
					// PreparedStatement
					// ps_approv_date=con.prepareStatement("select CR_Approval_Date from cr_tbl_Approval where CR_No="+approv_id);
					// ResultSet rs_approv_date=ps_approv_date.executeQuery();
					//
					// while(rs_approv_date.next())
					// {
					// or_date=rs_approv_date.getString("CR_Approval_Date");
					// }
					//

					PreparedStatement ps_approv_hist = con
							.prepareStatement("insert into cr_tbl_approval_hist(CR_Approval_Date_Hist,U_Id,CR_No,Approval_Id,CR_Approval_Date)values(?,?,?,?,?)");

					ps_approv_hist.setTimestamp(1, timestamp);
					ps_approv_hist.setInt(2, Integer.parseInt(list_approver11
							.get(appr).toString()));
					ps_approv_hist.setInt(3, crno);
					ps_approv_hist.setInt(4, approval_id);
					ps_approv_hist.setTimestamp(5, timestamp);

					approval_hist = ps_approv_hist.executeUpdate();

				}

				// ***********************************************************************************************************
				// ***********************************************************************************************************
				// Email BAckEnd ========== >>>
				ArrayList crCategory = new ArrayList();
				PreparedStatement ps_approvers = null;
				ResultSet ps_appro = null;
				for (int ccat = 0; ccat < categoryList.size(); ccat++) {
					ps_approvers = con
							.prepareStatement("select * from cr_tbl_category where CR_Category_Id="
									+ categoryList.get(ccat).toString());
					ps_appro = ps_approvers.executeQuery();
					while (ps_appro.next()) {
						crCategory.add(ps_appro.getString("CR_Category"));
					}
				}
				String comp = null;
				PreparedStatement ps_comp = con
						.prepareStatement("select * from user_tbl_company where Company_Id="
								+ bean.getCompany_Id());
				ResultSet rs_comp = ps_comp.executeQuery();
				while (rs_comp.next()) {
					comp = rs_comp.getString("Company_Name");

				}

				String Part = null;
				PreparedStatement ps_part = con
						.prepareStatement("select * from customer_tbl_item where Item_Id="
								+ bean.getItem_Id());
				ResultSet rs_part = ps_part.executeQuery();
				while (rs_part.next()) {
					Part = rs_part.getString("Item_Name");

				}
				String Name = null;
				PreparedStatement ps_uid = con
						.prepareStatement("select * from user_tbl where U_Id="
								+ Integer.parseInt(session.getAttribute("uid")
										.toString()));
				ResultSet rs_uid = ps_uid.executeQuery();
				while (rs_uid.next()) {
					Name = rs_uid.getString("U_Name");
				}

				// ***********************************************************************************************************
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
				String subject = "New Change Request Received from " + comp;
				// String messageText =
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

				ArrayList Approvers = new ArrayList();

				for (int mail = 0; mail < app_list.size(); mail++) {
					PreparedStatement ps_assign = con
							.prepareStatement("select * from user_tbl where U_Id="
									+ app_list.get(mail));
					ResultSet rs_assign = ps_assign.executeQuery();
					while (rs_assign.next()) {
						recipients[mail] = rs_assign.getString("U_Email");
						Approvers.add(rs_assign.getString("U_Name"));
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
				msg.setContent(
						"<b>Request Number :</b>"
								+ crno
								+ ", "

								+ "<p><b>Company Name : </b>"
								+ comp
								+ ", "
								+ " </p>"
								+ "<p><b>Part Name :  </b>"
								+ Part
								+ ", "
								+ " </p>"

								+ "<p><b>Related To :  </b>"
								+ crCategory
								+ ", "
								+ " </p>"
								+ "<p><b>Change Type/Types : </b>"
								+ chang_list
								+ ", "
								+ " </p>"
								+ "<p><b>Approvers : </b>"
								+ Approvers
								+ ", "
								+ " </p>"

								+ "<p><b>Present System : </b>"
								+ bean.getPresent_System()
								+ ", "
								+ " </p>"
								+ "<p><b>Proposed System : </b>"
								+ bean.getProposed_System()
								+ ", "
								+ " </p>"
								+ "<p><b>Objective : </b>"
								+ bean.getObjective()

								+ "</p>"

								+ "<p><b>Proposed date :</b> "
								+ bean.getProposed_Impl_Date()
								+ ", "
								+ " </p>"

								+ "<p><b>Change Request Received from :</b>"
								+ Name
								+ ", "
								+ " </p>"

								+ "<p><b>Change Received date :</b>"
								+ timestamp
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
				// **********************************************************************************

				// ***********************************************************************************************************
				// ***********************************************************************************************************
				if (c > 0 && app_ctype > 0 && ctype > 0 && count > 0 && his > 0
						&& b > 0 && a > 0 && app_his > 0 && approval > 0
						&& approval_hist > 0) {

					flag = true;
				} else {
					flag = false;
				}
				// ***********************************************************************************************************
			} catch (Exception e) {
				e.printStackTrace();
			}
			return flag;

		} else {

			try {

				// To get Todays Date ====== >>>
				DateFormat dateFormat = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				// get current date time with Date()
				Date date = new Date();
				System.out.println("by date..:" + dateFormat.format(date));

				java.sql.Timestamp timestamp = new java.sql.Timestamp(
						date.getTime());

				System.out.println("by TIMESTAMP..:" + timestamp);

				String complaint_no = null;
				int c = 0;
				complaint_no = bean.getComplaint_No();
				System.out.println("Complaint No in dao ... :" + complaint_no);
				// ******************************************************************************************************************
				// Get Change number ====== >>>
				int crno = bean.getCrno();
				// *******************************************************************************************************************
				// *********************************************************************************************************************
				// Register change ======= >>>
				Connection con = Connection_Utility.getConnection();
				int status = 1;

				if (complaint_no.equalsIgnoreCase("null")) {

					PreparedStatement ps_change = con
							.prepareStatement("update cr_tbl set Company_Id=?,Item_Id=?,Present_System=?,Proposed_System=?,Objective=?,CR_Date=?,Proposed_Impl_Date=?,Actual_Impl_Date=?,CR_Status_Id=?,U_Id=? where  CR_No="
									+ bean.getCrno());
					ps_change.setInt(1, bean.getCompany_Id());
					ps_change.setInt(2, bean.getItem_Id());
					ps_change.setString(3, bean.getPresent_System());
					ps_change.setString(4, bean.getProposed_System());
					ps_change.setString(5, bean.getObjective());
					ps_change.setTimestamp(6, bean.getCR_Date());
					ps_change.setTimestamp(7, bean.getProposed_Impl_Date());
					ps_change.setTimestamp(8, bean.getActual_Impl_Date());
					ps_change.setInt(9, status);
					ps_change.setInt(10, Integer.parseInt(session.getAttribute(
							"uid").toString()));
					c = ps_change.executeUpdate();
				}

				else {
					PreparedStatement ps_change = con
							.prepareStatement("update cr_tbl set Company_Id=?,Item_Id=?,Present_System=?,Proposed_System=?,Objective=?,CR_Date=?,Proposed_Impl_Date=?,Actual_Impl_Date=?,Complaint_No=?,CR_Status_Id=?,U_Id=? where CR_No="
									+ bean.getCrno());
					ps_change.setInt(1, bean.getCompany_Id());
					ps_change.setInt(2, bean.getItem_Id());
					ps_change.setString(3, bean.getPresent_System());
					ps_change.setString(4, bean.getProposed_System());
					ps_change.setString(5, bean.getObjective());
					ps_change.setTimestamp(6, bean.getCR_Date());
					ps_change.setTimestamp(7, bean.getProposed_Impl_Date());
					ps_change.setTimestamp(8, bean.getActual_Impl_Date());
					ps_change.setString(9, bean.getComplaint_No());
					ps_change.setInt(10, status);
					ps_change.setInt(11, Integer.parseInt(session.getAttribute(
							"uid").toString()));
					c = ps_change.executeUpdate();

				}

				// *********************************************************************************************************************

				if (complaint_no.equalsIgnoreCase("null")) {

					PreparedStatement ps_ctype_hist = con
							.prepareStatement("insert into cr_tbl_hist(CR_Hist_Date,CR_No,Company_Id,Item_Id,Present_System,Proposed_System,Objective,CR_Date,Proposed_Impl_Date,Actual_Impl_Date,CR_Status_Id)values(?,?,?,?,?,?,?,?,?,?,?)");
					ps_ctype_hist.setTimestamp(1, timestamp);
					ps_ctype_hist.setInt(2, bean.getCrno());
					ps_ctype_hist.setInt(3, bean.getCompany_Id());
					ps_ctype_hist.setInt(4, bean.getItem_Id());
					ps_ctype_hist.setString(5, bean.getPresent_System());
					ps_ctype_hist.setString(6, bean.getProposed_System());
					ps_ctype_hist.setString(7, bean.getObjective());
					ps_ctype_hist.setTimestamp(8, bean.getCR_Date());
					ps_ctype_hist.setTimestamp(9, bean.getProposed_Impl_Date());
					ps_ctype_hist.setTimestamp(10, bean.getActual_Impl_Date());
					ps_ctype_hist.setInt(11, status);

					int his = ps_ctype_hist.executeUpdate();
				}

				else {
					// To Maintain Logs ======= >>>>
					PreparedStatement ps_ctype_hist = con
							.prepareStatement("insert into cr_tbl_hist(CR_Hist_Date,CR_No,Company_Id,Item_Id,Present_System,Proposed_System,Objective,CR_Date,Proposed_Impl_Date,Actual_Impl_Date,Complaint_No,CR_Status_Id)values(?,?,?,?,?,?,?,?,?,?,?,?)");
					ps_ctype_hist.setTimestamp(1, timestamp);
					ps_ctype_hist.setInt(2, bean.getCrno());
					ps_ctype_hist.setInt(3, bean.getCompany_Id());
					ps_ctype_hist.setInt(4, bean.getItem_Id());
					ps_ctype_hist.setString(5, bean.getPresent_System());
					ps_ctype_hist.setString(6, bean.getProposed_System());
					ps_ctype_hist.setString(7, bean.getObjective());
					ps_ctype_hist.setTimestamp(8, bean.getCR_Date());
					ps_ctype_hist.setTimestamp(9, bean.getProposed_Impl_Date());
					ps_ctype_hist.setTimestamp(10, bean.getActual_Impl_Date());
					ps_ctype_hist.setString(11, bean.getComplaint_No());
					ps_ctype_hist.setInt(12, status);

					int his = ps_ctype_hist.executeUpdate();

				}

				// ******************************************************************************************************************************************************

				// To Edit Change Type ======= >>>

				PreparedStatement ps_delCT = con
						.prepareStatement("delete from cr_ctype_relation_tbl where CR_No="
								+ bean.getCrno());
				int delCT = ps_delCT.executeUpdate();

				PreparedStatement ps_ct = null, ps_CTUP = null, ps_ctHis = null;
				int ct = 0, ctHis = 0, ctUp = 0;
				ResultSet rs_CT = null;
				ArrayList listCT = new ArrayList();
				for (int a = 0; a < chang_list.size(); a++) {
					ps_ct = con
							.prepareStatement("select * from cr_tbl_type where CR_Type='"
									+ chang_list.get(a).toString() + "'");
					rs_CT = ps_ct.executeQuery();
					while (rs_CT.next()) {
						listCT.add(rs_CT.getInt("CR_Type_Id"));
					}
				}

				for (int b = 0; b < listCT.size(); b++) {
					ps_CTUP = con
							.prepareStatement("insert into cr_ctype_relation_tbl(CR_No,CR_Type_Id)values(?,?)");
					ps_CTUP.setInt(1, bean.getCrno());
					ps_CTUP.setInt(2,
							Integer.parseInt(listCT.get(b).toString()));
					ctUp = ps_CTUP.executeUpdate();

					ps_ctHis = con
							.prepareStatement("insert into cr_ctype_relation_tbl_hist(CR_T_Rel_Hist_Date,CR_No,CR_Type_Id)values(?,?,?)");
					ps_ctHis.setTimestamp(1, timestamp);
					ps_ctHis.setInt(2, bean.getCrno());
					ps_ctHis.setInt(3,
							Integer.parseInt(listCT.get(b).toString()));
					ctHis = ps_ctHis.executeUpdate();

				}

				// **********************************************************************************************************************
				// Edit Category =======>

				PreparedStatement ps_delca = con
						.prepareStatement("delete from cr_category_relation_tbl where CR_No="
								+ bean.getCrno());
				int delca = ps_delca.executeUpdate();

				ArrayList categoryList = new ArrayList();

				// categoryList.add(bean.getCost());
				// categoryList.add(bean.getQuality());
				// categoryList.add(bean.getDelivery());
				// categoryList.add(bean.getMaterial());
				// categoryList.add(bean.getSafety());
				// categoryList.add(bean.getDimensional());

				for (java.util.Iterator itr = categoryList.iterator(); itr
						.hasNext();) {
					if (itr.next() == null) {
						itr.remove();
					}
				}

				PreparedStatement ps_cat = null;
				ResultSet rs_cat = null;

				PreparedStatement ps_upca = null, ps_cahis = null;
				int CThis = 0, CTup = 0;
				for (int cc = 0; cc < categoryList.size(); cc++) {

					ps_upca = con
							.prepareStatement("insert into cr_category_relation_tbl(CR_No,CR_Category_Id)values(?,?)");
					ps_upca.setInt(1, bean.getCrno());
					ps_upca.setInt(2,
							Integer.parseInt(categoryList.get(cc).toString()));
					CTup = ps_upca.executeUpdate();

					ps_cahis = con
							.prepareStatement("insert into cr_category_relation_tbl_hist(CR_C_Rel_Hist_Date,CR_No,CR_Category_Id)values(?,?,?)");
					ps_cahis.setTimestamp(1, timestamp);
					ps_cahis.setInt(2, bean.getCrno());
					ps_cahis.setInt(3,
							Integer.parseInt(categoryList.get(cc).toString()));
					CThis = ps_cahis.executeUpdate();
				}

				// **********************************************************************************************************************
				// Edit Approvers =======>

				PreparedStatement ps_appr = con
						.prepareStatement("delete from cr_approver_relation_tbl where CR_No="
								+ bean.getCrno());
				int apr = ps_appr.executeUpdate();

				ArrayList listapr = new ArrayList();
				PreparedStatement ps_ap = null;
				ResultSet rs_ap = null;
				int aprs = 0;
				ArrayList appid = new ArrayList();

				for (int ap = 0; ap < app_list.size(); ap++) {
					ps_ap = con
							.prepareStatement("select * from user_tbl where U_Name='"
									+ app_list.get(ap).toString() + "'");
					rs_ap = ps_ap.executeQuery();
					while (rs_ap.next()) {
						appid.add(rs_ap.getInt("U_Id"));
					}
				}

				PreparedStatement ps_appUp = null, ps_appHisUp = null;
				int appup = 0, apphis = 0;

				for (int upap = 0; upap < appid.size(); upap++) {
					ps_appUp = con
							.prepareStatement("insert into cr_approver_relation_tbl(CR_No,U_Id)values(?,?)");
					ps_appUp.setInt(1, bean.getCrno());
					ps_appUp.setInt(2,
							Integer.parseInt(appid.get(upap).toString()));
					appup = ps_appUp.executeUpdate();

					ps_appHisUp = con
							.prepareStatement("insert into cr_approver_relation_tbl_hist(CR_A_Rel_Hist_Date,CR_No,U_Id)values(?,?,?)");
					ps_appHisUp.setTimestamp(1, timestamp);
					ps_appHisUp.setInt(2, bean.getCrno());
					ps_appHisUp.setInt(3,
							Integer.parseInt(appid.get(upap).toString()));
					apphis = ps_appHisUp.executeUpdate();

				}
				// **********************************************************************************************************************

				flag = true;

			} catch (Exception e) {
				e.printStackTrace();
			}

			return flag;
		}
	}
	//============================================================================-->
	//====================== Attach File ===================================-->
	//============================================================================-->
	public boolean attach_File(change_Request_Vo bean, HttpSession session) {
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

			int comp_no = bean.getCrno();
			Timestamp attach_date = timestamp;
			String file_Name = bean.getFile_Name();
			int del = 1;

			ps_file = con
					.prepareStatement("insert into cr_tbl_attachment(CR_No,Attachment,Attach_Date,U_Id,File_Name,Del_Status)values(?,?,?,?,?,?)");
			ps_file.setInt(1, comp_no);
			ps_file.setBinaryStream(2, bean.getFile_blob());
			ps_file.setTimestamp(3, attach_date);
			ps_file.setInt(4, uid);
			ps_file.setString(5, file_Name);
			ps_file.setInt(6, del);
			int a = ps_file.executeUpdate();

			// ****************************************************************************************************************************

			PreparedStatement ps_del = con
					.prepareStatement("delete from cr_tbl_attachment where File_Name='"
							+ "" + "'");
			int d = ps_del.executeUpdate();

			PreparedStatement ps_history = con
					.prepareStatement("insert into cr_tbl_attachment_hist(Attach_Date_HIst,CR_No,Attach_Date_original,U_Id,File_Name,Del_Status)values(?,?,?,?,?,?) ");
			ps_history.setTimestamp(1, timestamp);
			ps_history.setInt(2, comp_no);
			ps_history.setTimestamp(3, attach_date);
			ps_history.setInt(4, uid);
			ps_history.setString(5, file_Name);
			ps_history.setInt(6, del);
			ps_history.executeUpdate();
			flag = true;

			PreparedStatement ps_del1 = con
					.prepareStatement("delete from cr_tbl_attachment_hist where File_Name='"
							+ "" + "'");
			ps_del1.executeUpdate();
			flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}
//============================================================================-->
//============================================================================-->