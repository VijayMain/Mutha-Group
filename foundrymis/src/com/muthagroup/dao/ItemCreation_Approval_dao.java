package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.connectionUtil.ConnectionUrl;
import com.muthagroup.vo.ItemCreation_Approval_vo;

public class ItemCreation_Approval_dao {

public void add_newERPitems(int uid, HttpServletResponse response, ItemCreation_Approval_vo vo) {
		try {
			Connection con = ConnectionUrl.getLocalDatabase();
			Connection conlocal = Connection_Utility.getConnection();
			Connection conERP = ConnectionUrl.getBWAYSERPMASTERConnection();
			String uname = "", approval_status = "",email="";
			int srno = 0;
			boolean flag_check=false;
			PreparedStatement ps_uname = conlocal.prepareStatement("select * from User_tbl where U_Id=" + uid);
			ResultSet rs_uname = ps_uname.executeQuery();
			while (rs_uname.next()) {
				uname = rs_uname.getString("U_Name").toUpperCase();
				email = rs_uname.getString("U_Email");
			}
			Date date = new Date();
			java.sql.Timestamp todaysDate = new java.sql.Timestamp(date.getTime());
			PreparedStatement ps = null;
			ResultSet rs = null;

			ps = con.prepareStatement("select * from new_item_creation where enable=1 and supplier='" + vo.getSupplier() + "'");
			rs = ps.executeQuery();
			while (rs.next()) {
				flag_check = true;
				response.sendRedirect("ERPNew_Item.jsp?repMsg='Supplier is Already Available !!!'");
			}

			ps = conERP.prepareStatement("select * from MSTACCTGLSUB where SUBGL_LONGNAME='" + vo.getSupplier() + "'");
			rs = ps.executeQuery();
			while (rs.next()) {
				flag_check = true;
				response.sendRedirect("ERPNew_Item.jsp?repMsg='Supplier is Already Available !!!'");
			}
if(flag_check==false){
			ps = con.prepareStatement("insert into new_item_creation(supplier,short_supplier,supp_address,supp_city,pin_supplier,vendor_code,fax_supplier,email_supplier,website_supplier,work_address,credit_days,tin_sst,tin_sst_date,cst_number,cst_number_date,service_tax,service_tax_date,ecc_no,excise_range,division,collectorate,supp_category,category,pan_no,tan_no,lbt_no,tds_code,indus_type,tds_method,excise_round,excise_cessround,service_taxround,service_cessround,vat_round,net_amountRound,is_overseas,account_name,account_number,bank_name,branch,ifsc_rtgs,ifsc_neft,micr_code,phone_number1,phone_number2,bank_address1,bank_address2,bank_address3,registered_by,registered_date,update_by,update_date,enable,approval_status,supplier_phone1,supplier_phone2,email_logger,relative_flag,relative_name,turnover_year1,turnover_year2,turnover_year3,turnover1,turnover2,turnover3,owner_name,supplier_phone3,phone_number3)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, vo.getSupplier());
			ps.setString(2, vo.getShort_supplier());
			ps.setString(3, vo.getSupp_address());
			ps.setString(4, vo.getSupp_city());
			ps.setString(5, vo.getPin_supplier());
			ps.setString(6, vo.getVendor_code());
			ps.setString(7, vo.getFax_supplier());
			ps.setString(8, vo.getEmail_supplier());
			ps.setString(9, vo.getWebsite_supplier());
			ps.setString(10, vo.getWork_address());
			ps.setString(11, vo.getCredit_days());
			ps.setString(12, vo.getTin_sst());
			ps.setString(13, vo.getTin_sst_date());
			ps.setString(14, vo.getCst_number());
			ps.setString(15, vo.getCst_number_date());
			ps.setString(16, vo.getService_tax());
			ps.setString(17, vo.getService_tax_date());
			ps.setString(18, vo.getEcc_no());
			ps.setString(19, vo.getExcise_range());
			ps.setString(20, vo.getDivision());
			ps.setString(21, vo.getCollectorate());
			ps.setString(22, vo.getSupp_category());
			ps.setString(23, vo.getCategory());
			ps.setString(24, vo.getPan_no());
			ps.setString(25, vo.getTan_no());
			ps.setString(26, vo.getLbt_no());
			ps.setString(27, vo.getTds_code());
			ps.setString(28, vo.getIndus_type());
			ps.setString(29, vo.getTds_method());
			ps.setString(30, vo.getExcise_round());
			ps.setString(31, vo.getExcise_cessround());
			ps.setString(32, vo.getService_taxround());
			ps.setString(33, vo.getService_cessround());
			ps.setString(34, vo.getVat_round());
			ps.setString(35, vo.getNet_amountRound());
			ps.setString(36, vo.getIs_overseas());
			ps.setString(37, vo.getAccount_name());
			ps.setString(38, vo.getAccount_number());
			ps.setString(39, vo.getBank_name());
			ps.setString(40, vo.getBranch());
			ps.setString(41, vo.getIfsc_rtgs());
			ps.setString(42, vo.getIfsc_neft());
			ps.setString(43, vo.getMicr_code());
			ps.setString(44, vo.getPhone_number1());
			ps.setString(45, vo.getPhone_number2());
			ps.setString(46, vo.getBank_address1());
			ps.setString(47, vo.getBank_address2());
			ps.setString(48, vo.getBank_address3());
			ps.setString(49, uname);
			ps.setTimestamp(50, todaysDate);
			ps.setString(51, uname);
			ps.setTimestamp(52, todaysDate);
			ps.setString(53, "1");
			ps.setString(54, "0");
			ps.setString(55, vo.getSupplier_phone1());
			ps.setString(56, vo.getSupplier_phone2());
			ps.setString(57, email);
			ps.setString(58, vo.getRelativeinMutha());
			ps.setString(59, vo.getRelative_name());
			ps.setString(60, vo.getTurnYear1());
			ps.setString(61, vo.getTurnYear2());
			ps.setString(62, vo.getTurnYear3());
			ps.setString(63, vo.getTurnover1());
			ps.setString(64, vo.getTurnover2());
			ps.setString(65, vo.getTurnover3());
			ps.setString(66, vo.getOwners_name());
			ps.setString(67, vo.getSupplier_phone3());
			ps.setString(68, vo.getPhone_number3()); 
			int up = ps.executeUpdate();

			if (up > 0) {

				System.out.println("In loop of value = " + vo.getAttachment_name());
				
				if(!vo.getAttachment_name().equalsIgnoreCase(null)){
					
					System.out.println("In loop of attachment");
					
					int item_codeNo=0;
					PreparedStatement ps_prev = con.prepareStatement("select max(code) as code from new_item_creation");
					ResultSet rs_prev = ps_prev.executeQuery();
					while (rs_prev.next()) {
						item_codeNo = rs_prev.getInt("code");
					}
					
					System.out.println("attachment code number" + item_codeNo);
					
					ps_prev = con.prepareStatement("insert into new_item_attach(item_code,attachment,attach_name,enable,date_update,created_by)values(?,?,?,?,?,?)");
					ps_prev.setInt(1, item_codeNo);
					ps_prev.setBlob(2, vo.getAttachment());
					ps_prev.setString(3, vo.getAttachment_name());
					ps_prev.setInt(4, 1);
					ps_prev.setTimestamp(5, todaysDate);
					ps_prev.setString(6, uname);
					
					int up_prev = ps_prev.executeUpdate();
					
				}
				/**************************************************************************************************/
				String report = "NewERPItem_Approval";
				ArrayList to_emails = new ArrayList();
				ArrayList name_emails = new ArrayList();

				PreparedStatement ps_rec = con.prepareStatement("select * from pending_approvee where type='to' and report='"+ report + "'");
				ResultSet rs_rec = ps_rec.executeQuery();
				while (rs_rec.next()) {
					to_emails.add(rs_rec.getString("email"));
					name_emails.add(rs_rec.getString("validlimit"));
				}
				  
				InternetAddress[] addressBcc = new InternetAddress[1];
				for (int p = 0; p < to_emails.size(); p++) {
					
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
				Calendar cal = Calendar.getInstance();
				String sql_date = sdfFIrstDate.format(cal.getTime()).toString();
				boolean sent = false;
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
				String from = "itsupports@muthagroup.com";
				String subject = "Approval Required to create New Supplier in ERP System !!!";
				boolean sessionDebug = false;

				Properties props = System.getProperties();
				props.put("mail.host", host);
				props.put("mail.transport.protocol", "smtp");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.port", 2525);
				Session mailSession = Session.getDefaultInstance(props, null);
				mailSession.setDebug(sessionDebug);
				Message msg = new MimeMessage(mailSession);
				msg.setFrom(new InternetAddress(from));
				/******************************************************************************************************** */
				
					
					
					StringBuilder sb = new StringBuilder();
					ps = con.prepareStatement("select * from new_item_creation where enable=1 and approval_status=0");
					rs = ps.executeQuery();
					sb.append("<b style='color: #0D265E; font-family: Arial;font-size: 11px;'>This is an automatically generated email for ERP Pending Approval - To add new suppliers in ERP System !!!</b>"
							+ "<p><b>To Approve ,</b><a href='http://192.168.0.7/foundrymis/approve.jsp?userName=" + name_emails.get(p).toString() + "'>Click Here</a></p>"
							+ "<table border='1' width='97%' style='font-family: Arial;'>"
							+ "<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"
							+ "<th height='24'>S.No</th><th>Supplier</th><th>Request Date</th><th>Logged By</th><th>Approval</th></tr>");

					while (rs.next()) {
						srno++;
						sb.append("<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"
								+ "<td align='center'>"
								+ srno
								+ "</td>"
								+ "<td  align='left'>"
								+ rs.getString("supplier")
								+ "</td>"
								+ "<td  align='left'>"
								+ rs.getString("registered_date")
								+ "</td>"
								+ "<td  align='left'>"
								+ rs.getString("registered_by")
								+ "</td>"
								+ "<td  align='left'>Pending</td>" + "</tr>");
						sent = true;
					}
					srno=0;
					sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"
							+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
							+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
							+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
							+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
							+ "</font></p>");

					
					
					addressBcc[0] = new InternetAddress(to_emails.get(p).toString());
					
					msg.setRecipients(Message.RecipientType.TO, addressBcc);
					msg.setSubject(subject);
					msg.setSentDate(new Date());
					msg.setContent(sb.toString(), "text/html");
					if (sent == true) {
						Transport transport = mailSession.getTransport("smtp");
						transport.connect(host, user, pass);
						transport.sendMessage(msg, msg.getAllRecipients());
						transport.close();
					} 
				}
				/*************************************************************************************************/
				response.sendRedirect("ERPNew_Item.jsp?repMsg='Success.....Request is sent to Approve !!!'");
			}
}			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	
	/*_________________________________________________________________________________________________________*/
	
	public void approvalStatus_Update(String status, String code,
			HttpServletResponse response, String userName) {
	try {
			/* 1 approve, 0 declined */
			Connection con = ConnectionUrl.getLocalDatabase();
			/*Connection conlocal = Connection_Utility.getConnection();*/
			Connection conERP = ConnectionUrl.getBWAYSERPMASTERConnection();
			Date date = new Date();
			java.sql.Timestamp todaysDate = new java.sql.Timestamp(date.getTime());
			
			String ap_status="";
			int up = 0;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			ps = con.prepareStatement("update new_item_creation set approval_status=?,update_by=?,update_date=? where code="+Integer.parseInt(code));
			ps.setString(1, status);
			ps.setString(2, userName);
			ps.setTimestamp(3, todaysDate);
			up = ps.executeUpdate();
			
			// Approved
			if(status.equalsIgnoreCase("1")){
				 ap_status = "Approved";
			} 
			// Declined
			if(status.equalsIgnoreCase("3")){
				ap_status = "Declined";
			} 
			
			
			
	/*____________________________________________________________________________________________________*/
	
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
			String from = "itsupports@muthagroup.com";
			String subject = "New Supplier in ERP System is " + ap_status + " !!!";
			boolean sessionDebug = false;

			Properties props = System.getProperties();
			props.put("mail.host", host);
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 2525);
			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(sessionDebug);
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from));
			/******************************************************************************************************** */
			String report = "ApprovedERP_Items";
			ArrayList to_emails = new ArrayList();
			ArrayList name_emails = new ArrayList();
			String city_up="",sup_cat="",categ="",tds_code=""; 
			PreparedStatement ps_rec = con.prepareStatement("select * from pending_approvee where type='to' and report='" + report + "'");
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				to_emails.add(rs_rec.getString("email"));
				name_emails.add(rs_rec.getString("validlimit"));
			}

				StringBuilder sb = new StringBuilder();
				
				sb.append("<b style='color: #0D265E; font-family: Arial;font-size: 11px;'>This is an automatically generated email for ERP Approval - For new suppliers !!!</b>"
						+ "<p><b>To Approval Status : </b>" + ap_status + " by " + userName + "</p>"
						+ "<table border='1' width='97%' style='font-family: Arial;'>");
				
		ps_rec = con.prepareStatement("select * from new_item_creation where code="+Integer.parseInt(code));
		rs_rec = ps_rec.executeQuery();		
		while(rs_rec.next()){
			
			to_emails.add(rs_rec.getString("email_logger"));
			
			 ps = conERP.prepareStatement("select * from MSTCOMMCITY where code='"+rs_rec.getString("supp_city")+"'");
		     rs = ps.executeQuery();
		     while(rs.next()){
		    	city_up = rs.getString("NAME");
		     }
		     ps = conERP.prepareStatement("select * from MSTMATCATAG where code='"+rs_rec.getString("supp_category")+"'");
		      rs = ps.executeQuery();
		      while(rs.next()){
		    	  sup_cat = rs.getString("NAME");
		      }
		      if(rs_rec.getString("category").equalsIgnoreCase("0")){
		    	  categ = "Manufacturer";
		      }else if(rs_rec.getString("category").equalsIgnoreCase("1")){
		    	  categ = "Dealer/Traders";
		      }else if(rs_rec.getString("category").equalsIgnoreCase("2")){
		    	  categ = "Importer";
			}else if(rs_rec.getString("category").equalsIgnoreCase("3")){
				categ = "Other";
			}
		    
		      ps = conERP.prepareStatement("select * from CNFRATETDS where code='"+rs_rec.getString("tds_code")+"'");
		      rs = ps.executeQuery();
		      while(rs.next()){
		    	  tds_code = rs.getString("NAME");
		      }
		      
		sb.append("<table class='tftable' style='border: 0px;'>"+
		// supplier,short_supplier,supp_address,supp_city,pin_supplier,vendor_code,fax_supplier,email_supplier,website_supplier,work_address,credit_days,
		// tin_sst,tin_sst_date,cst_number,cst_number_date,service_tax,service_tax_date,ecc_no,excise_range,division,collectorate,supp_category,
		// category,pan_no,tan_no,lbt_no,tds_code,indus_type,tds_method,excise_round,excise_cessround,service_taxround,service_cessround,vat_round,
		// net_amountRound,is_overseas,account_name,account_number,bank_name,branch,ifsc_rtgs,ifsc_neft,micr_code,phone_number1,phone_number2,bank_address1,bank_address2,bank_address3
"<tr><td colspan='4' align='left' bgcolor='#999999'><strong>Supplier Details</strong></td></tr><tr><td width='23%'>Supplier Name</td>"+
"<td colspan='3'>"+rs_rec.getString("supplier")+"</td></tr><tr><td>Supplier Short Name</td><td colspan='3'>"+rs_rec.getString("short_supplier")+"</td></tr><tr>"+
"<td>Address</td><td colspan='3'>"+rs_rec.getString("supp_address")+"</td></tr><tr><td>City</td><td width='27%'>"+city_up+"</td><td width='21%'>Pin Code</td>"+
"<td width='29%'>"+rs_rec.getString("pin_supplier")+"</td></tr><tr><td>Vendor Code</td><td>"+rs_rec.getString("vendor_code")+"</td><td>&nbsp;</td><td>&nbsp;</td></tr>"+
"<tr><td>Phone Number</td><td>"+rs_rec.getString("supplier_phone1")+"</td><td>"+rs_rec.getString("supplier_phone2")+"</td><td>&nbsp;</td></tr><tr><td>Fax Number</td><td>"+rs_rec.getString("fax_supplier")+"</td><td>&nbsp;</td>"+
"<td>&nbsp;</td></tr><tr><td>E-mail ID</td><td colspan='3'>"+rs_rec.getString("email_supplier")+"</td></tr><tr><td>Website</td>"+
"<td colspan='3'>"+rs_rec.getString("website_supplier")+"</td></tr><tr><td>Work Address</td><td colspan='3'>"+rs_rec.getString("work_address")+"</td></tr><tr>"+
"<td colspan='4' align='left' bgcolor='#999999'><strong>Taxation Details</strong></td></tr><tr><td>Credit Days</td>"+
"<td colspan='3'>"+rs_rec.getString("credit_days")+"</td></tr><tr><td>TIN/SST Number</td><td>"+rs_rec.getString("tin_sst")+"</td><td>Date</td>"+
"<td>"+rs_rec.getString("tin_sst_date")+"</td></tr><tr><td>CST Number</td><td>"+rs_rec.getString("cst_number")+"</td><td>Date</td>"+
"<td>"+rs_rec.getString("cst_number_date")+"</td></tr><tr><td>Service Tax Number</td><td>"+rs_rec.getString("service_tax")+"</td><td>Date</td>"+
"<td>"+rs_rec.getString("service_tax_date")+"</td></tr><tr><td>ECC Number</td><td colspan='3'>"+rs_rec.getString("ecc_no")+"</td></tr>"+
"<tr><td>Exceise Range</td><td>"+rs_rec.getString("excise_range")+"</td><td>Division</td><td>"+rs_rec.getString("division")+"</td></tr><tr><td>Collectorate</td>"+
"<td colspan='3'>"+rs_rec.getString("collectorate")+"</td></tr><tr><td>Supplier Category</td><td>"+sup_cat+"</td><td>Category</td>"+
"<td>"+categ+"</td></tr><tr><td>PAN Number</td><td>"+rs_rec.getString("pan_no")+"</td><td>TAN Number</td>"+
"<td>"+rs_rec.getString("tan_no")+"</td></tr><tr><td>LBT Number</td><td colspan='3'>"+rs_rec.getString("lbt_no")+"</td></tr><tr><td>TDS Code</td>"+
"<td colspan='3'>"+tds_code+"</td></tr><tr><td>Industry Type</td><td colspan='3'>"+rs_rec.getString("indus_type")+"</td></tr><tr><td>TDS Method</td><td colspan='3'>"+
rs_rec.getString("tds_method") +"* Checked TDS Posting Entry Wise and Unchecked for TDS Debit Note"+
"</td></tr><tr><td>Excise Round</td><td>"+rs_rec.getString("excise_round")+"</td>"+
"<td>Excise Cess Round</td><td>"+rs_rec.getString("excise_cessround")+"</td>"+
"</tr><tr><td>Service Tax Round</td><td>"+rs_rec.getString("service_taxround")+"</td>"+
"<td>Service Cess Round</td><td>"+rs_rec.getString("service_cessround")+"</td>"+
"</tr><tr><td>VAT Round</td><td>"+rs_rec.getString("vat_round")+"</td>"+
"<td>Net Amount Round</td><td>"+rs_rec.getString("net_amountRound")+"</td></tr><tr><td>Is Overseas</td>"+
"<td colspan='3'>"+rs_rec.getString("is_overseas")+"</td>"+
"</tr><tr><td colspan='4' align='left' bgcolor='#999999'><strong>Bank Details</strong></td>"+ 
"<tr><td>Account Name*</td><td colspan='3'>"+rs_rec.getString("account_name")+"</td></tr><tr><td>Account Number</td>"+
"<td colspan='3'>"+rs_rec.getString("account_number")+"</td></tr><tr><td>Bank Name</td><td colspan='3'>"+rs_rec.getString("bank_name")+"</td></tr><tr><td>Branch</td>"+
"<td colspan='3'>"+rs_rec.getString("branch")+"</td></tr><tr><td>IFSC Code for RTGS</td><td colspan='3'>"+rs_rec.getString("ifsc_rtgs")+"</td>"+
"</tr><tr><td>IFSC Code NEFT</td><td colspan='3'>"+rs_rec.getString("ifsc_neft")+"</td></tr><tr><td>MICR Code</td>"+
"<td colspan='3'>"+rs_rec.getString("micr_code")+"</td></tr><tr><td>Phone Number</td><td>"+rs_rec.getString("phone_number1")+"</td>"+
"<td colspan='2'>"+rs_rec.getString("phone_number2")+"</td></tr><tr><td rowspan='3'>Bank Address</td><td colspan='3'>"+rs_rec.getString("bank_address1")+"</td></tr><tr>"+
"<td colspan='3'>"+rs_rec.getString("bank_address2")+"</td></tr><tr><td colspan='3'>"+rs_rec.getString("bank_address3")+"</td></tr>");
	 
}
				
				sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"
						+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
						+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
						+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
						+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
						+ "</font></p>");
				
				
				InternetAddress[] addressBcc = new InternetAddress[to_emails.size()];
				for (int p = 0; p < to_emails.size(); p++) {
				addressBcc[p] = new InternetAddress(to_emails.get(p).toString());
				}
				
				msg.setRecipients(Message.RecipientType.TO, addressBcc);
				msg.setSubject(subject);
				msg.setSentDate(new Date());
				msg.setContent(sb.toString(), "text/html"); 
				Transport transport = mailSession.getTransport("smtp");
				transport.connect(host, user, pass);
				transport.sendMessage(msg, msg.getAllRecipients());
				transport.close(); 
	/*_________________________________________________________________________________________________________*/			
			
			response.sendRedirect("approve.jsp?userName="+userName);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/*_________________________________________________________________________________________________________*/
}