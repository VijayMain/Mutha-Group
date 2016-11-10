package com.muthagroup.dao;
import java.sql.CallableStatement;
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

	public void add_newERPitems(int uid, HttpServletResponse response,
			ItemCreation_Approval_vo vo) {
		try {
			Connection con = ConnectionUrl.getLocalDatabase();
			Connection conlocal = Connection_Utility.getConnection();
			Connection conERP = ConnectionUrl.getBWAYSERPMASTERConnection();
			String uname = "",approval_status=""; 
			int srno=0;
			PreparedStatement ps_uname=conlocal.prepareStatement("select * from User_tbl where U_Id="+uid);
			ResultSet rs_uname=ps_uname.executeQuery();
			while(rs_uname.next())
			{
				uname=rs_uname.getString("U_Name").toUpperCase(); 
			}
			Date date = new Date(); 
			java.sql.Timestamp todaysDate = new java.sql.Timestamp(date.getTime());
			PreparedStatement ps =null; 
			ResultSet rs =null;
			
			ps = con.prepareStatement("select * from new_item_creation where enable=1 and supplier='"+vo.getSupplier()+"'");
			rs = ps.executeQuery();
			while (rs.next()) {
				response.sendRedirect("ERPNew_Item.jsp?repMsg='Supplier is Already Available !!!'");
			}
			
			ps = conERP.prepareStatement("select * from MSTACCTGLSUB where SUBGL_LONGNAME='"+vo.getSupplier()+"'");
			rs = ps.executeQuery();
			while(rs.next()){
				response.sendRedirect("ERPNew_Item.jsp?repMsg='Supplier is Already Available !!!'");
			}
			
			ps = con.prepareStatement("insert into new_item_creation(supplier,short_supplier,supp_address,supp_city,pin_supplier,vendor_code,fax_supplier,email_supplier,website_supplier,work_address,credit_days,tin_sst,tin_sst_date,cst_number,cst_number_date,service_tax,service_tax_date,ecc_no,excise_range,division,collectorate,supp_category,category,pan_no,tan_no,lbt_no,tds_code,indus_type,tds_method,excise_round,excise_cessround,service_taxround,service_cessround,vat_round,net_amountRound,is_overseas,account_name,account_number,bank_name,branch,ifsc_rtgs,ifsc_neft,micr_code,phone_number1,phone_number2,bank_address1,bank_address2,bank_address3,registered_by,registered_date,update_by,update_date,enable,approval_status,supplier_phone1,supplier_phone2)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1,vo.getSupplier());
			ps.setString(2,vo.getShort_supplier());
			ps.setString(3,vo.getSupp_address());
			ps.setString(4,vo.getSupp_city());
			ps.setString(5,vo.getPin_supplier());
			ps.setString(6,vo.getVendor_code());
			ps.setString(7,vo.getFax_supplier());
			ps.setString(8,vo.getEmail_supplier());
			ps.setString(9,vo.getWebsite_supplier());
			ps.setString(10,vo.getWork_address());
			ps.setString(11,vo.getCredit_days());
			ps.setString(12,vo.getTin_sst());
			ps.setString(13,vo.getTin_sst_date());
			ps.setString(14,vo.getCst_number());
			ps.setString(15,vo.getCst_number_date());
			ps.setString(16,vo.getService_tax());
			ps.setString(17,vo.getService_tax_date());
			ps.setString(18,vo.getEcc_no());
			ps.setString(19,vo.getExcise_range());
			ps.setString(20,vo.getDivision());
			ps.setString(21,vo.getCollectorate());
			ps.setString(22,vo.getSupp_category());
			ps.setString(23,vo.getCategory());
			ps.setString(24,vo.getPan_no());
			ps.setString(25,vo.getTan_no());
			ps.setString(26,vo.getLbt_no());
			ps.setString(27,vo.getTds_code());
			ps.setString(28,vo.getIndus_type());
			ps.setString(29,vo.getTds_method());
			ps.setString(30,vo.getExcise_round());
			ps.setString(31,vo.getExcise_cessround());
			ps.setString(32,vo.getService_taxround());
			ps.setString(33,vo.getService_cessround());
			ps.setString(34,vo.getVat_round());
			ps.setString(35,vo.getNet_amountRound());
			ps.setString(36,vo.getIs_overseas());
			ps.setString(37,vo.getAccount_name());
			ps.setString(38,vo.getAccount_number());
			ps.setString(39,vo.getBank_name());
			ps.setString(40,vo.getBranch());
			ps.setString(41,vo.getIfsc_rtgs());
			ps.setString(42,vo.getIfsc_neft());
			ps.setString(43,vo.getMicr_code());
			ps.setString(44,vo.getPhone_number1());
			ps.setString(45,vo.getPhone_number2());
			ps.setString(46,vo.getBank_address1());
			ps.setString(47,vo.getBank_address2());
			ps.setString(48,vo.getBank_address3());
			ps.setString(49,uname);
			ps.setTimestamp(50,todaysDate);
			ps.setString(51,uname);
			ps.setTimestamp(52,todaysDate);
			ps.setString(53,"1");
			ps.setString(54,"0");
			ps.setString(55,vo.getSupplier_phone1());
			ps.setString(56,vo.getSupplier_phone2());

			int up = ps.executeUpdate();
			
			if(up>0){
				
			/**************************************************************************************************/
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			String sql_date = sdfFIrstDate.format(cal.getTime()).toString();
			boolean sent=false;
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
			String report = "NewERPItem_Approval";
			ArrayList to_emails = new ArrayList();
			ArrayList name_emails = new ArrayList();
			
			PreparedStatement ps_rec = con.prepareStatement("select * from pending_approvee where type='to' and report='"+report+"'");
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				to_emails.add(rs_rec.getString("email"));
				name_emails.add(rs_rec.getString("validlimit"));
			}
			
			InternetAddress[] addressBcc = new InternetAddress[to_emails.size()];
			for (int p = 0; p < to_emails.size(); p++) {
			StringBuilder sb = new StringBuilder();
			ps = con.prepareStatement("select * from new_item_creation where enable=1 and approval_status=0");
			rs = ps.executeQuery();
			sb.append("<b style='color: #0D265E; font-family: Arial;font-size: 11px;'>This is an automatically generated email for ERP Pending Approval - To add new suppliers in ERP System !!!</b>"+ 
					"<p><b>To Approve ,</b><a href='http://localhost/foundrymis/approve.jsp?userName="+name_emails.get(p).toString()+"'>Click Here</a></p>"+
					"<table border='1' width='97%' style='font-family: Arial;'>"+
					"<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
					"<th height='24'>S.No</th><th>Supplier</th><th>Request Date</th><th>Logged By</th><th>Approval</th></tr>");
		
			while (rs.next()) {
				srno++;
			sb.append("<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
						"<td align='center'>"+srno+"</td>"+
						"<td  align='left'>"+rs.getString("supplier")+"</td>"+ 
						"<td  align='left'>"+rs.getString("registered_date")+"</td>"+
						"<td  align='left'>"+rs.getString("registered_by")+"</td>"+
						"<td  align='left'>Pending</td>"+
						"</tr>");
			sent = true;
			}
			
			sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
			"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");
		 
		addressBcc[p] = new InternetAddress(to_emails.get(p).toString());
		msg.setRecipients(Message.RecipientType.TO, addressBcc);
		msg.setSubject(subject);
		msg.setSentDate(new Date());
		msg.setContent(sb.toString(), "text/html");
		if(sent==true){
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients()); 
			transport.close(); 
		}
		}
			/*************************************************************************************************/
				response.sendRedirect("ERPNew_Item.jsp?repMsg='Success.....Request is sent to Approve !!!'");
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}