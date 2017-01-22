package com.muthagroup.automail;

import java.sql.CallableStatement; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.DecimalFormat;
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

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class SisterCompanySale_Report extends TimerTask {

	@Override
	public void run() {
		try {
			//-------------------------------------------------------- Date Logic ---------------------------------------------------------

			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			Date datesq = new Date();
			int day = datesq.getDate();
			
			ArrayList rem = new ArrayList(); 
			if (day==1 && d.getHours() == 9 && d.getMinutes() == 40) {
			Connection con = ConnectionUrl.getLocalDatabase();
				
			SimpleDateFormat formatView = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat formatsql = new SimpleDateFormat("yyyyMMdd"); 
			DecimalFormat mytotals = new DecimalFormat( "######0.00" );

			Calendar aCalendar = Calendar.getInstance();
			//add -1 month to current month
			aCalendar.add(Calendar.MONTH, -1);
			//set DATE to 1, so first date of previous month
			aCalendar.set(Calendar.DATE, 1);
			Date firstDateOfPreviousMonth = aCalendar.getTime();
			//set actual maximum date of previous month
			aCalendar.set(Calendar.DATE,aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			//read it
			Date lastDateOfPreviousMonth = aCalendar.getTime();
			String from_date = formatsql.format(firstDateOfPreviousMonth);
			String to_date = formatsql.format(lastDateOfPreviousMonth);
			String dateFrom = formatView.format(firstDateOfPreviousMonth); 
			String dateTo = formatView.format(lastDateOfPreviousMonth);

			/*System.out.println("fdate = " + from_date + "\nLast day = " + to_date);
			System.out.println("fdate view = " + dateFrom + "\nLast day view = " + dateTo);*/				
			  				
				System.out.println("ERP Sister Company Automailer Starts !!!");
				
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
		 		String from = "itsupports@muthagroup.com";
				String subject = "Sister Company Sale From "+dateFrom+" to "+dateTo ; 
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
				ArrayList listemailTo = new ArrayList();
				ArrayList listemailCc = new ArrayList();
				
				PreparedStatement psauto = con.prepareStatement("select * from automailer_config where Automailer_Reports_id=1");
				ResultSet rsauto = psauto.executeQuery();
				while (rsauto.next()) {
					if(rsauto.getString("Email_id_to")!=null){ 
						listemailTo.add(rsauto.getString("Email_id_to"));
					}
					if(rsauto.getString("Email_id_cc")!=null){
						listemailCc.add(rsauto.getString("Email_id_cc"));
					}
				}
				
				String recipients[] = new String[listemailTo.size()];
				String cc_recipients[] = new String[listemailCc.size()]; 
				
				for(int i=0;i<listemailTo.size();i++){
					recipients[i] = listemailTo.get(i).toString();
				}
				for(int j=0;j<listemailCc.size();j++){
					cc_recipients[j] = listemailCc.get(j).toString();
				} 
				
				// *********************************************************************************************
				
				/*String recipients[] = {"vijaybm@muthagroup.com"};
				String cc_recipients[] = {"vijaybm@muthagroup.com"};*/

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

				for (int p = 0; p < recipients.length; p++) {
					addressTo[p] = new InternetAddress(recipients[p]);
				}
				
				InternetAddress[] addressCc = new InternetAddress[cc_recipients.length];
				for (int p = 0; p < cc_recipients.length; p++) {
					addressCc[p] = new InternetAddress(cc_recipients[p]);
				}

				msg.setRecipients(Message.RecipientType.TO, addressTo);
				msg.setRecipients(Message.RecipientType.CC, addressCc);

				msg.setSubject(subject);
				msg.setSentDate(new Date());
				
				StringBuilder sb = new StringBuilder();
				
	//*******************************************************************************************************************************
				sb.append("<p style='color: #0D265E; font-family: Arial; font-size: 11px;'>*** This is an automatically generated email of Sister Company Sale Report !!! ***</p>");
				
				sb.append("<table  border='1'><tr style='background-color: #D1CED9;'>"+
						"<td align='center' scope='col' colspan='7'><strong style='font-size: 15px;font-family: Arial;'>Sister Company Sale From  "+dateFrom +" to "+dateTo +"</strong> <strong style='color: green;'>in Rs.</strong> </td>"+ 
						"</tr><tr style='font-family: Arial;font-size: 11px;'>"+
						"<th align='center' scope='col' width='18%'>"+
						"<strong>CUSTOMERS&#8658; </strong><hr/>"+
						"<strong>COMPANY&#8659;</strong></th>"+
						"<th align='center' scope='col' width='15%'><strong>MEPL H21</strong></th>"+
						"<th align='center' scope='col' width='15%'><strong>MEPL H25</strong></th>"+
						"<th align='center' scope='col' width='15%'><strong>MFPL</strong></th>"+
						"<th align='center' scope='col' width='15%'><strong>DI</strong></th>"+
						"<th align='center' scope='col' width='15%'><strong>MEPL Unit III</strong></th>"+
						"<th align='center' scope='col' width='18%'><strong>Total</strong></th></tr>");
				
				double sumH21_ToH25 = 0;
				double sumH21_Total = 0;
				ArrayList listH21_ToH25 = new ArrayList();
				//H21 to H25 exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110205', '20141201', '20141231'
				Connection con_H21_toH25 = ConnectionUrl.getMEPLH21ERP();
				CallableStatement H21_toH25 = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_toH25.setString(1, "101");
				H21_toH25.setString(2, "0");
				H21_toH25.setString(3, "101110205");
				H21_toH25.setString(4, from_date);
				H21_toH25.setString(5, to_date);
				ResultSet rs_H21_toH25 = H21_toH25.executeQuery();
				while(rs_H21_toH25.next()){
					 listH21_ToH25.add(Double.parseDouble(rs_H21_toH25.getString("SALES_AMOUNT"))); 
				 }
				 for(int i = 0; i < listH21_ToH25.size(); i++)
				  {
					 sumH21_ToH25 += (Double.parseDouble(listH21_ToH25.get(i).toString()));
				  }
				double sumH21_Tomfpl = 0;
				ArrayList listH21_Tomfpl = new ArrayList();
				//H21 to mfpl exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110070101110032101110060101110100', '20141201', '20141231'
				
				CallableStatement H21_tomfpl = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_tomfpl.setString(1, "101");
				H21_tomfpl.setString(2, "0");
				H21_tomfpl.setString(3, "101110070101110032101110060101110100");
				H21_tomfpl.setString(4, from_date);
				H21_tomfpl.setString(5, to_date);
				ResultSet rs_H21_tomfpl = H21_tomfpl.executeQuery();
				 while(rs_H21_tomfpl.next()){ 
					 listH21_Tomfpl.add(Double.parseDouble(rs_H21_tomfpl.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH21_Tomfpl.size(); i++)
				  {
					 sumH21_Tomfpl += (Double.parseDouble(listH21_Tomfpl.get(i).toString()));
				  }   
				double sumH21_Todi = 0; 
				ArrayList listH21_Todi = new ArrayList();
				//H21 to di exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110012101110084', '20141201', '20141231'
				
				CallableStatement H21_todi = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_todi.setString(1, "101");
				H21_todi.setString(2, "0");
				H21_todi.setString(3, "101110012101110084");
				H21_todi.setString(4, from_date);
				H21_todi.setString(5, to_date);
				ResultSet rs_H21_todi = H21_todi.executeQuery();
				 while(rs_H21_todi.next()){ 
					 listH21_Todi.add(Double.parseDouble(rs_H21_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH21_Todi.size(); i++)
				  {
					 sumH21_Todi += (Double.parseDouble(listH21_Todi.get(i).toString()));
				  } 
				double sumH21_TounitIII = 0; 
				ArrayList listH21_TounitIII = new ArrayList();
				//H21 to unitIII exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110347', '20141201', '20141231'
				
				CallableStatement H21_tounitIII = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_tounitIII.setString(1, "101");
				H21_tounitIII.setString(2, "0");
				H21_tounitIII.setString(3, "101110347");
				H21_tounitIII.setString(4, from_date);
				H21_tounitIII.setString(5, to_date);
				ResultSet rs_H21_tounitIII = H21_tounitIII.executeQuery();
				 while(rs_H21_tounitIII.next()){ 
					 listH21_TounitIII.add(Double.parseDouble(rs_H21_tounitIII.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH21_TounitIII.size(); i++)
				  {
					 sumH21_TounitIII += (Double.parseDouble(listH21_TounitIII.get(i).toString()));
				  }
				 
				sumH21_Total = sumH21_ToH25 + sumH21_Tomfpl + sumH21_Todi + sumH21_TounitIII;
				
				sb.append("<tr><th  align='left'><strong>MEPL H21</strong></th>"+ 
					"<td align='right' style='background-color: #ED723E;'></td>"+
					"<td align='right'><strong>"+mytotals.format(sumH21_ToH25)+"</strong> </td>"+
					"<td align='right'><strong>"+mytotals.format(sumH21_Tomfpl)+"</strong> </td>"+
					"<td align='right'><strong>"+mytotals.format(sumH21_Todi)+"</strong> </td>"+
					"<td align='right'><strong>"+mytotals.format(sumH21_TounitIII)+"</strong> </td>"+
					"<td align='right'><strong>"+mytotals.format(sumH21_Total)+"</strong></td></tr>");
				
				double sumH25_ToH21 = 0;
				double sumH25_Total = 0;
				ArrayList listH25_toH21 = new ArrayList();
				//H25 to H21 exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110054101110233101110100101110069', '20141201', '20141231' 
				Connection con_H25_toH21 = ConnectionUrl.getMEPLH25ERP();
				CallableStatement H25_toH21 = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_toH21.setString(1, "102");
				H25_toH21.setString(2, "0");
				H25_toH21.setString(3, "101110054101110233101110100101110069");
				H25_toH21.setString(4, from_date);
				H25_toH21.setString(5, to_date);
				ResultSet rs_H25_toH21 = H25_toH21.executeQuery();
				 while(rs_H25_toH21.next()){ 
					 listH25_toH21.add(Double.parseDouble(rs_H25_toH21.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH25_toH21.size(); i++)
				  {
					 sumH25_ToH21 += (Double.parseDouble(listH25_toH21.get(i).toString()));
				  } 
				double sumH25_Tomfpl = 0; 
				ArrayList listH25_tomfpl = new ArrayList();
				//H25 to mfpl exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110070101110032101110060101110100', '20141201', '20141231' 
				
				CallableStatement H25_tomfpl = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_tomfpl.setString(1, "102");
				H25_tomfpl.setString(2, "0");
				H25_tomfpl.setString(3, "101110070101110032101110060101110100");
				H25_tomfpl.setString(4, from_date);
				H25_tomfpl.setString(5, to_date);
				ResultSet rs_H25_tomfpl = H25_tomfpl.executeQuery();
				 while(rs_H25_tomfpl.next()){ 
					 listH25_tomfpl.add(Double.parseDouble(rs_H25_tomfpl.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH25_tomfpl.size(); i++)
				  {
					 sumH25_Tomfpl += (Double.parseDouble(listH25_tomfpl.get(i).toString()));
				  } 
				double sumH25_Todi = 0; 
				ArrayList listH25_todi = new ArrayList();
				//H25 to di exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110012101110084', '20141201', '20141231' 
				CallableStatement H25_todi = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_todi.setString(1, "102");
				H25_todi.setString(2, "0");
				H25_todi.setString(3, "101110012101110084");
				H25_todi.setString(4, from_date);
				H25_todi.setString(5, to_date);
				ResultSet rs_H25_todi = H25_todi.executeQuery();
				 while(rs_H25_todi.next()){ 
					 listH25_todi.add(Double.parseDouble(rs_H25_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH25_todi.size(); i++)
				  {
					 sumH25_Todi += (Double.parseDouble(listH25_todi.get(i).toString()));
				  } 
				double sumH25_Tok1 = 0; 
				ArrayList listH25_tok1 = new ArrayList();
				//H25 to k1 exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110347', '20141201', '20141231' 
				CallableStatement H25_tok1 = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_tok1.setString(1, "102");
				H25_tok1.setString(2, "0");
				H25_tok1.setString(3, "101110347");
				H25_tok1.setString(4, from_date);
				H25_tok1.setString(5, to_date);
				ResultSet rs_H25_tok1 = H25_tok1.executeQuery();
				 while(rs_H25_tok1.next()){ 
					 listH25_tok1.add(Double.parseDouble(rs_H25_tok1.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH25_tok1.size(); i++)
				  {
					 sumH25_Tok1 += (Double.parseDouble(listH25_tok1.get(i).toString()));
				  }  				
				sumH25_Total = sumH25_ToH21 + sumH25_Tomfpl + sumH25_Todi  +  sumH25_Tok1;
				
				sb.append("<tr><th  align='left'><strong>MEPL H25</strong></th>"+
					"<td align='right'><strong>"+mytotals.format(sumH25_ToH21)+"</strong> </td>"+
					"<td align='right' style='background-color: #ED723E;'></td>"+
					"<td align='right'><strong>"+mytotals.format(sumH25_Tomfpl)+"</strong> </td>"+
					"<td align='right'><strong>"+mytotals.format(sumH25_Todi)+"</strong> </td>"+
					"<td align='right'><strong>"+mytotals.format(sumH25_Tok1)+"</strong> </td>"+
					"<td align='right'><strong>"+mytotals.format(sumH25_Total)+"</strong></td></tr>");
				
				double summfpl_ToH21 = 0;
				double summfpl_Total = 0;
				ArrayList listmfpl_toH21 = new ArrayList();
				//K1 to H21 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110070101110032101110060101110100', '20141001', '20141231'
				Connection con_mfpl_toH21 = ConnectionUrl.getFoundryERPNEWConnection();
				CallableStatement mfpl_toH21 = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_toH21.setString(1, "103");
				mfpl_toH21.setString(2, "0");
				mfpl_toH21.setString(3, "101110070101110032101110060101110100");
				mfpl_toH21.setString(4, from_date);
				mfpl_toH21.setString(5, to_date);
				ResultSet rs_mfpl_toH21 = mfpl_toH21.executeQuery();
				 while(rs_mfpl_toH21.next()){ 
					 listmfpl_toH21.add(Double.parseDouble(rs_mfpl_toH21.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_toH21.size(); i++)
				  {
					 summfpl_ToH21 += (Double.parseDouble(listmfpl_toH21.get(i).toString()));
				  } 
				double summfpl_ToH25 = 0; 
				ArrayList listmfpl_toH25 = new ArrayList();
				//K1 to H25 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110205', '20141001', '20141231' 
				CallableStatement mfpl_toH25 = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_toH25.setString(1, "103");
				mfpl_toH25.setString(2, "0");
				mfpl_toH25.setString(3, "101110205");
				mfpl_toH25.setString(4, from_date);
				mfpl_toH25.setString(5, to_date);
				ResultSet rs_mfpl_toH25 = mfpl_toH25.executeQuery();
				 while(rs_mfpl_toH25.next()){ 
					 listmfpl_toH25.add(Double.parseDouble(rs_mfpl_toH25.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_toH25.size(); i++)
				  {
					 summfpl_ToH25 += (Double.parseDouble(listmfpl_toH25.get(i).toString()));
				  } 
				double summfpl_Todi = 0; 
				ArrayList listmfpl_todi = new ArrayList();
				//K1 to di exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110012101110084', '20141001', '20141231' 
				CallableStatement mfpl_todi = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_todi.setString(1, "103");
				mfpl_todi.setString(2, "0");
				mfpl_todi.setString(3, "101110012101110084");
				mfpl_todi.setString(4, from_date);
				mfpl_todi.setString(5, to_date);
				ResultSet rs_mfpl_todi = mfpl_todi.executeQuery();
				 while(rs_mfpl_todi.next()){ 
					 listmfpl_todi.add(Double.parseDouble(rs_mfpl_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_todi.size(); i++)
				  {
					 summfpl_Todi += (Double.parseDouble(listmfpl_todi.get(i).toString()));
				  } 
				double summfpl_TounitIII = 0; 
				ArrayList listmfpl_tounitIII = new ArrayList();
				//K1 to unitIII exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110347', '20141001', '20141231' 
				CallableStatement mfpl_tounitIII = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_tounitIII.setString(1, "103");
				mfpl_tounitIII.setString(2, "0");
				mfpl_tounitIII.setString(3, "101110347");
				mfpl_tounitIII.setString(4, from_date);
				mfpl_tounitIII.setString(5, to_date);
				ResultSet rs_mfpl_tounitIII = mfpl_tounitIII.executeQuery();
				 while(rs_mfpl_tounitIII.next()){ 
					 listmfpl_tounitIII.add(Double.parseDouble(rs_mfpl_tounitIII.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_tounitIII.size(); i++)
				  {
					 summfpl_TounitIII += (Double.parseDouble(listmfpl_tounitIII.get(i).toString()));
				  }
				 summfpl_Total = summfpl_ToH21 + summfpl_ToH25 + summfpl_Todi + summfpl_TounitIII;
				 
			sb.append("<tr><th  align='left'><strong>MFPL</strong></th>"+
				"<td align='right'><strong>"+mytotals.format(summfpl_ToH21)+"</strong> </td>"+
				"<td align='right'><strong>"+mytotals.format(summfpl_ToH25)+"</strong> </td>"+
				"<td align='right' style='background-color: #ED723E;'></td>"+
				"<td align='right'><strong>"+mytotals.format(summfpl_Todi)+"</strong> </td>"+
				"<td align='right'><strong>"+mytotals.format(summfpl_TounitIII)+"</strong> </td>"+
				"<td align='right'><strong>"+mytotals.format(summfpl_Total)+"</strong></td></tr>");	
			
			double sumdi_toH21 = 0;
			double sumdi_Total = 0;
			ArrayList listdi_toH21 = new ArrayList();
			//DI to H21 exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110054101110233101110100101110069', '20141001', '20141231'
			Connection con_di_toH21 = ConnectionUrl.getDIERPConnection();
			CallableStatement di_toH21 = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
			di_toH21.setString(1, "105");
			di_toH21.setString(2, "0");
			di_toH21.setString(3, "101110054101110233101110100101110069");
			di_toH21.setString(4, from_date);
			di_toH21.setString(5, to_date);
			ResultSet rs_di_toH21 = di_toH21.executeQuery();
			 while(rs_di_toH21.next()){ 
				 listdi_toH21.add(Double.parseDouble(rs_di_toH21.getString("SALES_AMOUNT"))); 
			 } 				
			 for(int i = 0; i < listdi_toH21.size(); i++)
			  {
				 sumdi_toH21 += (Double.parseDouble(listdi_toH21.get(i).toString()));
			  } 
			double sumdi_toH25 = 0; 
			ArrayList listdi_toH25 = new ArrayList();
			//DI to H25 exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110205', '20141001', '20141231' 
			CallableStatement di_toH25 = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
			di_toH25.setString(1, "105");
			di_toH25.setString(2, "0");
			di_toH25.setString(3, "101110205");
			di_toH25.setString(4, from_date);
			di_toH25.setString(5, to_date);
			ResultSet rs_di_toH25 = di_toH25.executeQuery();
			 while(rs_di_toH25.next()){ 
				 listdi_toH25.add(Double.parseDouble(rs_di_toH25.getString("SALES_AMOUNT"))); 
			 } 				
			 for(int i = 0; i < listdi_toH25.size(); i++)
			  {
				 sumdi_toH25 += (Double.parseDouble(listdi_toH25.get(i).toString()));
			  } 
			double sumdi_tomfpl = 0; 
			ArrayList listdi_tomfpl = new ArrayList();
			//DI to mfpl exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110070101110032101110060101110100', '20141001', '20141231' 
			CallableStatement di_tomfpl = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
			di_tomfpl.setString(1, "105");
			di_tomfpl.setString(2, "0");
			di_tomfpl.setString(3, "101110070101110032101110060101110100");
			di_tomfpl.setString(4, from_date);
			di_tomfpl.setString(5, to_date);
			ResultSet rs_di_tomfpl = di_tomfpl.executeQuery();
			 while(rs_di_tomfpl.next()){ 
				 listdi_tomfpl.add(Double.parseDouble(rs_di_tomfpl.getString("SALES_AMOUNT"))); 
			 } 				
			 for(int i = 0; i < listdi_tomfpl.size(); i++)
			  {
				 sumdi_tomfpl += (Double.parseDouble(listdi_tomfpl.get(i).toString()));
			  } 
			double sumdi_tounitIII = 0; 
			ArrayList listdi_tounitIII = new ArrayList();
			//DI to unitIII exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110347', '20141001', '20141231' 
			CallableStatement di_tounitIII = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
			di_tounitIII.setString(1, "105");
			di_tounitIII.setString(2, "0");
			di_tounitIII.setString(3, "101110347");
			di_tounitIII.setString(4, from_date);
			di_tounitIII.setString(5, to_date);
			ResultSet rs_di_tounitIII = di_tounitIII.executeQuery();
			 while(rs_di_tounitIII.next()){ 
				 listdi_tounitIII.add(Double.parseDouble(rs_di_tounitIII.getString("SALES_AMOUNT"))); 
			 } 				
			 for(int i = 0; i < listdi_tounitIII.size(); i++)
			  {
				 sumdi_tounitIII += (Double.parseDouble(listdi_tounitIII.get(i).toString()));
			  }				 
			 sumdi_Total = sumdi_toH21 + sumdi_toH25 + sumdi_tomfpl + sumdi_tounitIII;	
			 
			 sb.append("<tr><th  align='left'><strong>DI</strong></th>"+
				"<td align='right'><strong>"+mytotals.format(sumdi_toH21)+"</strong> </td>"+
				"<td align='right'><strong>"+mytotals.format(sumdi_toH25)+"</strong> </td>"+
				"<td align='right'><strong>"+mytotals.format(sumdi_tomfpl)+"</strong> </td>"+
				"<td align='right' style='background-color: #ED723E;'></td>"+
				"<td align='right'><strong>"+mytotals.format(sumdi_tounitIII)+"</strong> </td>"+
				"<td align='right'><strong>"+mytotals.format(sumdi_Total)+"</strong> </td></tr>");
			 double sumk1_ToH21 = 0;
				double sumk1_Total = 0;
				ArrayList listk1_ToH21 = new ArrayList();
				//K1 to H21 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110054101110233101110100101110069', '20141001', '20141231'
				Connection con_k1_toH21 = ConnectionUrl.getK1ERPConnection();
				CallableStatement k1_toH21 = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_toH21.setString(1, "106");
				k1_toH21.setString(2, "0");
				k1_toH21.setString(3, "101110054101110233101110100101110069");
				k1_toH21.setString(4, from_date);
				k1_toH21.setString(5, to_date);
				ResultSet rs_k1_toH21 = k1_toH21.executeQuery();
				 while(rs_k1_toH21.next()){ 
					 listk1_ToH21.add(Double.parseDouble(rs_k1_toH21.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listk1_ToH21.size(); i++)
				  {
				 	sumk1_ToH21 += (Double.parseDouble(listk1_ToH21.get(i).toString()));
				  }  
				double sumk1_ToH25 = 0;	 
				ArrayList listk1_ToH25 = new ArrayList();
				//K1 to H25 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110205', '20141001', '20141231'
				CallableStatement k1_toH25 = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_toH25.setString(1, "106");
				k1_toH25.setString(2, "0");
				k1_toH25.setString(3, "101110205");
				k1_toH25.setString(4, from_date);
				k1_toH25.setString(5, to_date);
				ResultSet rs_k1_toH25 = k1_toH25.executeQuery();
				 while(rs_k1_toH25.next()){ 
					 listk1_ToH25.add(Double.parseDouble(rs_k1_toH25.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listk1_ToH25.size(); i++)
				  {
				 	sumk1_ToH25 += (Double.parseDouble(listk1_ToH25.get(i).toString()));
				  }  
				double sumk1_Tomfpl = 0;	  
				ArrayList listk1_Tomfpl = new ArrayList();
				//K1 to mfpl exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110070101110032101110060101110100', '20141001', '20141231'
				CallableStatement k1_tomfpl = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_tomfpl.setString(1, "106");
				k1_tomfpl.setString(2, "0");
				k1_tomfpl.setString(3, "101110070101110032101110060101110100");
				k1_tomfpl.setString(4, from_date);
				k1_tomfpl.setString(5, to_date);
				ResultSet rs_k1_tomfpl = k1_tomfpl.executeQuery();
				 while(rs_k1_tomfpl.next()){ 
					 listk1_Tomfpl.add(Double.parseDouble(rs_k1_tomfpl.getString("SALES_AMOUNT"))); 
					} 				
				 for(int i = 0; i < listk1_Tomfpl.size(); i++)
				  {
				 	sumk1_Tomfpl += (Double.parseDouble(listk1_Tomfpl.get(i).toString()));
				  }  
				double sumk1_Todi = 0;	  
				ArrayList listk1_Todi = new ArrayList();
				//K1 to di exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110012101110084', '20141001', '20141231'
				CallableStatement k1_todi = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_todi.setString(1, "106");
				k1_todi.setString(2, "0");
				k1_todi.setString(3, "101110012101110084");
				k1_todi.setString(4, from_date);
				k1_todi.setString(5, to_date);
				ResultSet rs_k1_todi = k1_todi.executeQuery();
				 while(rs_k1_todi.next()){ 
					 listk1_Todi.add(Double.parseDouble(rs_k1_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listk1_Todi.size(); i++)
				  {
				 	sumk1_Todi += (Double.parseDouble(listk1_Todi.get(i).toString()));
				  } 	 
				 sumk1_Total = sumk1_ToH21 + sumk1_ToH25 + sumk1_Tomfpl + sumk1_Todi;
				 
				 sb.append("<tr><th  align='left'><strong>MEPL Unit III</strong></th>"+
					"<td align='right'> <strong>"+mytotals.format(sumk1_ToH21)+"</strong> </td>"+
					"<td align='right'> <strong>"+mytotals.format(sumk1_ToH25)+"</strong> </td>"+
					"<td align='right'> <strong>"+mytotals.format(sumk1_Tomfpl)+"</strong> </td>"+
					"<td align='right'> <strong>"+mytotals.format(sumk1_Todi)+"</strong> </td>"+
					"<td align='right' style='background-color: #ED723E;'></td>"+
					"<td align='right'><strong>"+mytotals.format(sumk1_Total)+"</strong></td></tr>");
				
				 String h21sum = "0.00";
					double totalH21 =  sumH25_ToH21  +  summfpl_ToH21  +  sumdi_toH21  + sumk1_ToH21; 
					if(totalH21==.00){
						totalH21 = 0;
					}else{
						h21sum = mytotals.format(totalH21);
					} 
					String h25sum = "0.00";
					double totalH25 =  sumH21_ToH25 +  summfpl_ToH25  +   sumdi_toH25 +  sumk1_ToH25;
					if(totalH25==.00){
						totalH25 = 0;
					}else{
						h25sum = mytotals.format(totalH25);
					} 
					String mfplsum = "0.00";
					double totalmfpl =  sumH21_Tomfpl +  sumH25_Tomfpl  +   sumdi_tomfpl +  sumk1_Tomfpl;
				 
					if(totalmfpl==.00){
						totalmfpl = 0;
					}else{
						mfplsum = mytotals.format(totalmfpl);
					} 
					String disum = "0.00";
					double totaldi =  sumH21_Todi +  sumH25_Todi  +   summfpl_Todi +  sumk1_Todi;
					if(totaldi==.00){
						totaldi = 0;
					}else{
						disum = mytotals.format(totaldi);
					} 
					String k1sum = "0.00";
					double totalk1 =  sumH21_TounitIII +  sumH25_Tok1  +   summfpl_TounitIII +  sumdi_tounitIII;
					if(totalk1==.00){
						totalk1 = 0;
					}else{
						k1sum = mytotals.format(totalk1);
					} 
					String allsum = "0.00";
					double totalall =  sumH21_Total  +  sumH25_Total  + summfpl_Total  +  sumdi_Total  +  sumk1_Total;
					if(totalall==.00){
						totalall = 0;
					}else{
						allsum = mytotals.format(totalall);
					}
					
					
				sb.append("<tr><th  align='left'><strong>TOTAL &#8658;</strong></th>"+
					"<td align='right'><strong>"+h21sum+"</strong></td>"+
					"<td align='right'><strong>"+h25sum+"</strong> </td>"+
					"<td align='right'><strong> "+mfplsum+"</strong> </td>"+
					"<td align='right'><strong>"+disum+" </strong></td>"+
					"<td align='right'><strong>"+k1sum+"</strong></td>"+
					"<td align='right'><strong>"+allsum+"</strong></td></tr>");	
				 
				 
	sb.append("</table> <p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
			"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");

	//*******************************************************************************************************************************
	//*******************************************************************************************************************************
			msg.setContent(sb.toString(), "text/html");
	 
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			// *******************************************************************************************
			transport.close(); 
			System.out.println("Automail loop End");			
		}	 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	System.out.println("ERP Mailer sister company");	
	}

}
