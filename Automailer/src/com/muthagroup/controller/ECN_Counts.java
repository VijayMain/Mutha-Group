package com.muthagroup.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.TimerTask;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class ECN_Counts extends TimerTask {
	@Override
	public void run() {
		try {
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			Date datesq = new Date();
			int day = datesq.getDate();
			
			ArrayList rem = new ArrayList(); 
			if (weekday[d.getDay()].equals("Wednesday") && d.getHours() == 9 && d.getMinutes() == 36) {
			/*if (day==9 && d.getHours() == 17 && d.getMinutes() == 18) {*/
				
				Connection con = Connection_Utility.getConnection();
				 
				Calendar first_Datecal = Calendar.getInstance();   
				first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
				Date dddd = first_Datecal.getTime();  
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy/MM/dd");  
				Date tdate = new Date();
				String firstDate = sdfFIrstDate.format(dddd);
				String nowDate = sdfFIrstDate.format(tdate);
				
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
				
				int count = 0;
				int j = 0;
				
				PreparedStatement ps6 = con.prepareStatement("select count(Email) from vnd_automail where Company_id=6");
				ResultSet rs6 = ps6.executeQuery();
				while (rs6.next()) {
					count = rs6.getInt("count(Email)");
				}
				count++;
				PreparedStatement ps_auto = con.prepareStatement("select * from automail where Company_id=6");
				ResultSet rs_auto = ps_auto.executeQuery();
				String[] recipients = new String[count];
				
				while (rs_auto.next()) {
					recipients[j] = rs_auto.getString("Email");
					j++;
				}
				recipients[j] = "govindmb@muthagroup.com";
				// ********************************************************************************************* 
				SimpleDateFormat formatView = new SimpleDateFormat("dd/MM/yyyy");
				// -----------------------------------------------------------------------------------------------------------------------------
				int totalintECN=0,totalcustECN=0;
				int engct=0,h25ct=0,mfplct=0,dict=0,k1ct=0;
				PreparedStatement ps = con.prepareStatement("select count(*) from cr_tbl");
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					totalintECN = rs.getInt("count(*)");
				}
				PreparedStatement ps_eng = con.prepareStatement("select count(*) from cr_tbl where company_id=1");
				ResultSet rs_eng = ps_eng.executeQuery();
				while(rs_eng.next()){
					engct = rs_eng.getInt("count(*)");
				}
				PreparedStatement ps_h25ct = con.prepareStatement("select count(*) from cr_tbl where company_id=2");
				ResultSet rs_h25ct = ps_h25ct.executeQuery();
				while(rs_h25ct.next()){
					h25ct = rs_h25ct.getInt("count(*)");
				}
				PreparedStatement ps_mfplct = con.prepareStatement("select count(*) from cr_tbl where company_id=3");
				ResultSet rs_mfplct = ps_mfplct.executeQuery();
				while(rs_mfplct.next()){
					mfplct = rs_mfplct.getInt("count(*)");
				}
				PreparedStatement ps_dict = con.prepareStatement("select count(*) from cr_tbl where company_id=5");
				ResultSet rs_dict = ps_dict.executeQuery();
				while(rs_dict.next()){
					dict = rs_dict.getInt("count(*)");
				}
				PreparedStatement ps_k1ct = con.prepareStatement("select count(*) from cr_tbl where company_id=4");
				ResultSet rs_k1ct = ps_k1ct.executeQuery();
				while(rs_k1ct.next()){
					k1ct = rs_k1ct.getInt("count(*)");
				}
				//-----------------------------------------------------------------------------------------------------------------------------

				int custengct=0,custh25ct=0,custmfplct=0,custdict=0,custk1ct=0;
				PreparedStatement pscust = con.prepareStatement("select count(*) from crc_tbl");
				ResultSet rscust = pscust.executeQuery();
				while(rscust.next()){
					totalcustECN = rscust.getInt("count(*)");
				}
				PreparedStatement ps_engcust = con.prepareStatement("select count(*) from crc_tbl where company_id=1");
				ResultSet rs_engcust = ps_engcust.executeQuery();
				while(rs_engcust.next()){
					custengct = rs_engcust.getInt("count(*)");
				}
				PreparedStatement ps_h25ctcust = con.prepareStatement("select count(*) from crc_tbl where company_id=2");
				ResultSet rs_h25ctcust = ps_h25ctcust.executeQuery();
				while(rs_h25ctcust.next()){
					custh25ct = rs_h25ctcust.getInt("count(*)");
				}
				PreparedStatement ps_mfplctcust = con.prepareStatement("select count(*) from crc_tbl where company_id=3");
				ResultSet rs_mfplctcust = ps_mfplctcust.executeQuery();
				while(rs_mfplctcust.next()){
					custmfplct = rs_mfplctcust.getInt("count(*)");
				}
				PreparedStatement ps_dictcust = con.prepareStatement("select count(*) from crc_tbl where company_id=5");
				ResultSet rs_dictcust = ps_dictcust.executeQuery();
				while(rs_dictcust.next()){
					custdict = rs_dictcust.getInt("count(*)");
				}
				PreparedStatement ps_k1ctcust = con.prepareStatement("select count(*) from crc_tbl where company_id=4");
				ResultSet rs_k1ctcust = ps_k1ctcust.executeQuery();
				while(rs_k1ctcust.next()){
					custk1ct = rs_k1ctcust.getInt("count(*)");
				}
				// -----------------------------------------------------------------------------------------------------------------------------
				String lastECN="",lastcustECN="";
				String englastecn="0",h25lastecn="0",mfpllastecn="0",dilastecn="0",k1lastecn="0";
				PreparedStatement pslastecn = con.prepareStatement("select max(cr_date) from cr_tbl");
				ResultSet rslastecn = pslastecn.executeQuery();
				while(rslastecn.next()){
					if(rslastecn.getDate(("max(cr_date)"))!=null){
					lastECN = formatView.format(rslastecn.getDate(("max(cr_date)")));
					}
				}
				PreparedStatement ps_englastecn = con.prepareStatement("select max(cr_date) from cr_tbl where company_id=1");
				ResultSet rs_englastecn = ps_englastecn.executeQuery();
				while(rs_englastecn.next()){
					
					if(rs_englastecn.getDate("max(cr_date)")!=null){
					englastecn = formatView.format(rs_englastecn.getDate("max(cr_date)"));
					}
				}
				PreparedStatement ps_h25lastecn = con.prepareStatement("select max(cr_date) from cr_tbl where company_id=2");
				ResultSet rs_h25lastecn = ps_h25lastecn.executeQuery();
				while(rs_h25lastecn.next()){
					if(rs_h25lastecn.getDate("max(cr_date)")!=null){
					h25lastecn = formatView.format(rs_h25lastecn.getDate("max(cr_date)"));
					}
				}
				PreparedStatement ps_mfpllastecn = con.prepareStatement("select max(cr_date) from cr_tbl where company_id=3");
				ResultSet rs_mfpllastecn = ps_mfpllastecn.executeQuery();
				while(rs_mfpllastecn.next()){
					if(rs_mfpllastecn.getDate("max(cr_date)")!=null){
					mfpllastecn = formatView.format(rs_mfpllastecn.getDate("max(cr_date)"));
					}
				}
				PreparedStatement ps_dictlastecn = con.prepareStatement("select max(cr_date) from cr_tbl where company_id=5");
				ResultSet rs_dictlastecn = ps_dictlastecn.executeQuery();
				while(rs_dictlastecn.next()){
					if(rs_dictlastecn.getDate("max(cr_date)")!=null){
					dilastecn = formatView.format(rs_dictlastecn.getDate("max(cr_date)"));
					}
				}
				PreparedStatement ps_k1lastecn = con.prepareStatement("select max(cr_date) from cr_tbl where company_id=4");
				ResultSet rs_k1lastecn = ps_k1lastecn.executeQuery();
				while(rs_k1lastecn.next()){
					if(rs_k1lastecn.getDate("max(cr_date)")!=null){
					k1lastecn = formatView.format(rs_k1lastecn.getDate("max(cr_date)"));
					}
				}
				// -----------------------------------------------------------------------------------------------------------------------------
				String englastecncust="0",h25lastecncust="0",mfpllastecncust="0",dilastecncust="0",k1lastecncust="0";
				PreparedStatement pslastecncust = con.prepareStatement("select max(CRC_Date) from crc_tbl");
				ResultSet rslastecncust = pslastecncust.executeQuery();
				while(rslastecncust.next()){
					if(rslastecncust.getDate(("max(CRC_Date)"))!=null){
					lastcustECN = formatView.format(rslastecncust.getDate(("max(CRC_Date)")));
					}
				}
				PreparedStatement ps_englastecncust = con.prepareStatement("select max(CRC_Date) from crc_tbl where company_id=1");
				ResultSet rs_englastecncust = ps_englastecncust.executeQuery();
				while(rs_englastecncust.next()){
					
					if(rs_englastecncust.getDate("max(CRC_Date)")!=null){
					englastecncust = formatView.format(rs_englastecncust.getDate("max(CRC_Date)"));
					}
				}
				PreparedStatement ps_h25lastecncust = con.prepareStatement("select max(CRC_Date) from crc_tbl where company_id=2");
				ResultSet rs_h25lastecncust = ps_h25lastecncust.executeQuery();
				while(rs_h25lastecncust.next()){
					if(rs_h25lastecncust.getDate("max(CRC_Date)")!=null){
					h25lastecncust = formatView.format(rs_h25lastecncust.getDate("max(CRC_Date)"));
					}
				}
				PreparedStatement ps_mfpllastecncust = con.prepareStatement("select max(CRC_Date) from crc_tbl where company_id=3");
				ResultSet rs_mfpllastecncust = ps_mfpllastecncust.executeQuery();
				while(rs_mfpllastecncust.next()){
					if(rs_mfpllastecncust.getDate("max(CRC_Date)")!=null){
					mfpllastecncust = formatView.format(rs_mfpllastecncust.getDate("max(CRC_Date)"));
					}
				}
				PreparedStatement ps_dictlastecncust = con.prepareStatement("select max(CRC_Date) from crc_tbl where company_id=5");
				ResultSet rs_dictlastecncust = ps_dictlastecncust.executeQuery();
				while(rs_dictlastecncust.next()){
					if(rs_dictlastecncust.getDate("max(CRC_Date)")!=null){
					dilastecncust = formatView.format(rs_dictlastecncust.getDate("max(CRC_Date)"));
					}
				}
				PreparedStatement ps_k1lastecncust = con.prepareStatement("select max(CRC_Date) from crc_tbl where company_id=4");
				ResultSet rs_k1lastecncust = ps_k1lastecncust.executeQuery();
				while(rs_k1lastecncust.next()){
					if(rs_k1lastecncust.getDate("max(CRC_Date)")!=null){
					k1lastecncust = formatView.format(rs_k1lastecncust.getDate("max(CRC_Date)"));
					}
				}
				// *********************************************************************************************
				
 			String host = "send.one.com";
			String user = "ecn@muthagroup.com";
			String pass = "ecn@xyz";
	 		String from = "ecn@muthagroup.com";
			String subject = "Weekly ECN";
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
			InternetAddress[] addressTo = new InternetAddress[recipients.length];

			for (int p = 0; p < recipients.length; p++) {
				addressTo[p] = new InternetAddress(recipients[p]);
			}
			
			msg.setRecipients(Message.RecipientType.TO, addressTo); 

			msg.setSubject(subject);
			msg.setSentDate(new Date());
	 		
			StringBuilder sb = new StringBuilder();
			sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email from ECN(Engineering Change Note) !!! ***</b>");
			sb.append("<table border='1' style='width: 95%'>"+
					"<tr style='font-size: 15px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<th height='25' colspan='9'><b style='color: green;'>Engineering Change Note(ECN) Dashboard</b></th>"+
		"</tr><tr style='font-size: 15px; background-color: #acc8cc; border-width: 1px; padding: 18px; border-style: solid; border-color: #729ea5;' height='25'>"+
			"<th colspan='2'>Internal Change Request</th>"+
			"<th colspan='2'>Customer Change Request</th> "+
		"</tr><tr style='font-family: Arial;font-size: 13px;' align='left'>"+
		"<td colspan='2'><b>Internal ECN Count&nbsp;</b><b style='color: #241ED6;'>("+totalintECN +")</b>&nbsp;<b style='color: #33BF26;'>&#8681;</b></td>"+ 
		"<td colspan='2'><b>Customer ECN Count&nbsp;</b><b style='color: #241ED6;'>("+totalcustECN +")</b>&nbsp;<b style='color: #33BF26;'>&#8681;</b></td>"+ 
		"</tr><tr style='font-family: Arial;font-size: 13px;' align='left'>"+
		"<td colspan='2' style='color: #0D0738;'>"+
		"&nbsp;MEPL H21&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+engct+"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL H25&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+h25ct +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MFPL&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+mfplct +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL Unit III&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+dict +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;DI&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+k1ct +"</b>&nbsp;&nbsp;&nbsp;"+
		"</td><td colspan='2' style='color: #0D0738;'>"+
		"&nbsp;MEPL H21&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+custengct +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL H25&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+custh25ct +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MFPL&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+custmfplct +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL Unit III&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+custdict +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;DI&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+custk1ct +"</b>&nbsp;&nbsp;&nbsp;</td></tr><tr style='font-family: Arial;font-size: 13px;' align='left'>"+
		"<td colspan='2'><b>Last Request Date &nbsp;</b><b style='color: #241ED6;'>("+lastECN +")</b>&nbsp;<b style='color: #33BF26;'>&#8681;</b></td> "+
		"<td colspan='2'><b>Last Request Date &nbsp;</b><b style='color: #241ED6;'>("+lastcustECN +")</b>&nbsp;<b style='color: #33BF26;'>&#8681;</b></td>"+ 
		"</tr><tr style='font-family: Arial;font-size: 13px;' align='left'>"+
		"<td colspan='2' style='color: #0D0738;'>"+
		"&nbsp;MEPL H21&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+englastecn +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL H25&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+h25lastecn +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MFPL&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+mfpllastecn +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL Unit III&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+dilastecn +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;DI&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+k1lastecn +"</b>&nbsp;&nbsp;&nbsp;"+
		"</td><td colspan='2' style='color: #0D0738;'>"+
		"&nbsp;MEPL H21&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+englastecncust +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL H25&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+h25lastecncust +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MFPL&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+mfpllastecncust +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;MEPL Unit III&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+k1lastecncust +"</b>&nbsp;&nbsp;&nbsp;"+
		"&nbsp;DI&nbsp;&#8680;&nbsp;<b style='color: #241ED6;'>"+dilastecncust +"</b>&nbsp;&nbsp;&nbsp;</td></tr>");
			
			sb.append("</table> <p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
					"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
					"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
					"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
					"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
					"</font></p>");
		 
			msg.setContent(sb.toString(), "text/html");
	 
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			
			// ******************************************************************************
			System.out.println("ECN Count mail sent");
			transport.close(); 
			}
		} catch (Exception e) {
		e.printStackTrace();
		}
	}
}