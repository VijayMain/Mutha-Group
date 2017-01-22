package com.muthagroup.automail;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
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

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class SheduleXLSReminder_25 extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("Schedule Report Arial h25");
			//-------------------------------------------------------- Date Logic ---------------------------------------------------------
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };  
			boolean flag = true;
			/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 20) {*/
				if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 12 && d.getMinutes() == 8) {
			//******************************************************************************************************************************
				ArrayList weekOff = new ArrayList(); 
				
					int cnt = 0;
					DecimalFormat zeroDForm = new DecimalFormat("#####0");
					DecimalFormat twoDForm = new DecimalFormat("#####0.00"); 
					
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.DATE, -1);
					SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy");
					SimpleDateFormat sqlDate = new SimpleDateFormat("yyyyMMdd");	
					String todays_date = todaysDate.format(cal.getTime()).toString();
					String sql_date = sqlDate.format(cal.getTime()).toString();				
					 
					// **********************************************************************************************************
					Date dateLogic = todaysDate.parse(todays_date);
					if(weekday[dateLogic.getDay()].equals("Tuesday")){
						cal.add(Calendar.DATE, -1);
						todays_date = todaysDate.format(cal.getTime()).toString();
						sql_date = sqlDate.format(cal.getTime()).toString();
					} 
					// **********************************************************************************************************
					double req_perdayQty=0,avg_perdayQty=0,del_rating=0; 
					// ***************************************************************************************************************
					// *************************************************** Workdays ***************************************************
			Connection conlocal = ConnectionUrl.getLocalDatabase();
			Connection con = null;		
			String comp_id ="";
			String Sheet_Name = "";
			int sheetcnt=1;


			ArrayList alistFile = new ArrayList();
			File folder = new File("C:/reportxls");
			File[] listOfFiles = folder.listFiles();
			String listname = "";
			int val = listOfFiles.length + 1;

			File exlFile = new File("C:/reportxls/Sheduler"+val+".xls");
			WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
			  
				comp_id ="102";
				Sheet_Name = "MEPL H25";
				con = ConnectionUrl.getMEPLH25ERP(); 
			 
					WritableSheet writableSheet = writableWorkbook.createSheet(Sheet_Name, sheetcnt);
					 
					
					String testDate = sql_date.substring(6,8) +"-"+ sql_date.substring(4,6) +"-"+ sql_date.substring(0,4);
					DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
					Date today = formatter.parse(testDate);

					String dayCNT = sql_date.substring(6,8);
					
					int month = Integer.parseInt(sql_date.substring(4,6));
					String fromDate = sql_date.substring(0,4)+sql_date.substring(4,6) +"01";
					 

					Calendar calendar = Calendar.getInstance();  
					calendar.setTime(today);
					calendar.add(Calendar.MONTH, 1);  
					calendar.set(Calendar.DAY_OF_MONTH, 1);  
					calendar.add(Calendar.DATE, -1);
					
					Date lastDayOfMonth = calendar.getTime();


					SimpleDateFormat sdfparse = new SimpleDateFormat("dd/MM/yyyy"); 
					Calendar calAvg = Calendar.getInstance();

				int total_dd = 0;
				int holliday = 0;
				Date datesq = new Date();
				int day = datesq.getDate();

				PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where month=" + month + " and day<" + day);
				ResultSet rs_week = ps_week.executeQuery();
				while (rs_week.next()) {
					holliday = Integer.parseInt(rs_week.getString("count(*)"));
				}

				PreparedStatement ps_holli = conlocal.prepareStatement("select * from montlyweekdays_tbl where day=" + day + " and month=" + month);
				ResultSet rs_holli = ps_holli.executeQuery();
				while (rs_holli.next()) {
					flag = false;
				}

				int dd = today.getDate();
				int tues = 0;
				for (int i = 1; i < dd; i++) {
					calAvg.set(Calendar.DAY_OF_MONTH, i);
					if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY) {
						tues++;
						weekOff.add(i); 
					}
				} 
				int workdays = dd - tues; 
				total_dd = workdays; 
				total_dd = total_dd - holliday; 
				// ***************************************************************************************************************
				int space = 0;
				PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month=" + month);
				ResultSet rs_allHol = ps_allHol.executeQuery();
				while (rs_allHol.next()) { 
					space = Integer.parseInt(rs_allHol.getString("count(montlyWeekdays_id)"));
				}

				PreparedStatement ps_Hol = conlocal.prepareStatement("select day from montlyweekdays_tbl where month=" + month);
				ResultSet rs_Hol = ps_Hol.executeQuery();
				while (rs_Hol.next()) {
					weekOff.add(rs_Hol.getString("day"));
				}

				int count_mnt = lastDayOfMonth.getDate();

				int tue_month = 0;
				for (int i = 1; i < count_mnt; i++) {
					calAvg.set(Calendar.DAY_OF_MONTH, i);
					if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY) {
						tue_month++;
					}
				}

				count_mnt = count_mnt - tue_month; 
				count_mnt = count_mnt - space;
				System.out.println("Total Woring Days = " + count_mnt);
				// ***************************************************************************************************************

				ArrayList getdata = new ArrayList();
				ArrayList setdata = new ArrayList();
				
				for (int i = 1; i <= Integer.parseInt(dayCNT); i++) {
					getdata.add("0");
					setdata.add(i);
				} 
				// ***************************************************************************************************************
					 
					String matcode = "";
					PreparedStatement ps_code = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='11'");
					ResultSet rs_code = ps_code.executeQuery();
					while (rs_code.next()) {
						matcode += rs_code.getString("SUB_GLACNO");
					}
					 
					ArrayList condition = new ArrayList();
					CallableStatement cs = con.prepareCall("{call Sel_RptDespatchPlanSale(?,?,?,?)}");
					cs.setString(1, comp_id);
					cs.setString(2, "0");
					cs.setString(3, matcode);
					cs.setString(4, sql_date);
					ResultSet rs = cs.executeQuery();
					while (rs.next()) {
						condition.add(rs.getString("CUST_CODE"));
					}
					
					CallableStatement cssale = con.prepareCall("{call Sel_RptCustDailySchVsSale(?,?,?,?,?)}");
					cssale.setString(1, comp_id);
					cssale.setString(2, "0");
					cssale.setString(3, fromDate);
					cssale.setString(4, sql_date);
					cssale.setString(5, matcode); 
					ResultSet rssale = null; 
					
					
					rs.close(); 
					Set<String> hs = new HashSet();
					hs.addAll(condition);
					condition.clear();
					condition.addAll(hs);  
					ResultSet rs_disp =null; 
					ArrayList compareList = new ArrayList();
					 int col=10+getdata.size();
					 int c=0,r=4;
					// ***************************************************************************************************************
					if (condition.size() > 0) {
					//***************************************************************************************************************************************************************************************************
						Colour bckcolor = Colour.TURQUOISE;
					    WritableFont font = new WritableFont(WritableFont.ARIAL);
					    font.setColour(Colour.BLACK); 
					    
					    WritableFont fontbold = new WritableFont(WritableFont.ARIAL);
					    fontbold.setColour(Colour.BLACK);
					    fontbold.setBoldStyle(WritableFont.BOLD);
					    
					    WritableCellFormat cellFormat = new WritableCellFormat();
					    cellFormat.setBackground(bckcolor);
					    cellFormat.setAlignment(Alignment.CENTRE);
					    cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK); 
					    cellFormat.setFont(fontbold); 
					    
					    Colour backHcolor = Colour.GRAY_25;
					    WritableCellFormat cellFormat_header = new WritableCellFormat();
					    cellFormat_header.setBackground(backHcolor);
					    cellFormat_header.setAlignment(Alignment.LEFT); 
					    cellFormat_header.setFont(fontbold); 
					  
					    writableSheet.setColumnView(0, 40);
					    writableSheet.setColumnView(1, 14);
					    writableSheet.setColumnView(2, 14);
					    writableSheet.setColumnView(3, 16);
					    writableSheet.setColumnView(4, 14);
					    writableSheet.setColumnView(5, 14);
					    writableSheet.setColumnView(6, 14);
					    writableSheet.setColumnView(7, 14);
					    writableSheet.setColumnView(8, 14);
					     
					    WritableCellFormat cellRIghtformat = new WritableCellFormat();
					    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
					    font.setColour(Colour.BLACK); 
					    cellRIghtformat.setFont(font);
					    cellRIghtformat.setAlignment(Alignment.RIGHT);
					    
					    WritableCellFormat cellRIghtformatWrap = new WritableCellFormat(); 
					    cellRIghtformatWrap.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
					    font.setColour(Colour.BLACK); 
					    cellRIghtformatWrap.setFont(font);
					    cellRIghtformatWrap.setAlignment(Alignment.RIGHT);
					    cellRIghtformatWrap.setWrap(true);
					    
					    WritableCellFormat cellFormatWrap = new WritableCellFormat();
					    cellFormatWrap.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
					    font.setColour(Colour.BLACK); 
					    cellFormatWrap.setBackground(bckcolor);
					    cellFormatWrap.setFont(fontbold);
					    cellFormatWrap.setAlignment(Alignment.RIGHT); 
					    cellFormatWrap.setWrap(true);
					    
					    WritableCellFormat cellleftformat = new WritableCellFormat(); 
					    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
					    font.setColour(Colour.BLACK); 
					    cellleftformat.setFont(font); 	
					    cellleftformat.setAlignment(Alignment.LEFT);
					     
					    writableSheet.mergeCells(0, 2,0, 3);
					    writableSheet.mergeCells(1, 2,0, 3);
					    writableSheet.mergeCells(2, 2,0, 3);
					    writableSheet.mergeCells(3, 2,0, 3);
					    writableSheet.mergeCells(4, 2,5, 2);
					    writableSheet.mergeCells(6, 2,7, 2); 
					    writableSheet.mergeCells(8, 2,9, 2);
					     
					    int mrg = 10,ext=0;
					    for(int i=0;i<setdata.size();i++){
					    	ext = mrg+2; 
					    	writableSheet.mergeCells(mrg, 2,ext, 2);
					    	mrg=mrg+3; 
						}
					    
					    Label label_1 = new Label(0, 0, "Working Days",cellRIghtformat);
					    Label label_2 = new Label(0, 1, "Days Completed",cellRIghtformat);
					    
					    Label label_val1 = new Label(1, 0, zeroDForm.format(count_mnt) , cellRIghtformat); 
					    Label label_val2 = new Label(1, 1, zeroDForm.format(total_dd), cellRIghtformat);
					    
					    Label label = new Label(0, 2, "Name of Item",cellFormat); 
					    Label label1 = new Label(1, 2, "REQ/DAY",cellFormat);
					    Label label2 = new Label(2, 2, "Sale AVG/DAY",cellFormat);
					    Label label3 = new Label(3, 2, "Delivery Rating %",cellFormat);
					    Label label4 = new Label(4, 2, "Despatch Plan",cellFormat);
					    Label label5 = new Label(4, 3, "Qty",cellFormat);
					    Label label6 = new Label(5, 3, "AMT",cellFormat);
					    Label label7 = new Label(6, 2, "Sales",cellFormat);		    
					    Label label8 = new Label(6, 3, "Qty",cellFormat);
					    Label label9 = new Label(7, 3, "AMT",cellFormat);
					    
					    Label label10 = new Label(8, 2, "Pending",cellFormat);
					    Label label11 = new Label(8, 3, "Qty",cellFormat);
					    Label label12 = new Label(9, 3, "AMT",cellFormat);
					     
					    mrg = 10;
					    int daycnr = 0 ;
					    for(int i=0;i<setdata.size();i++){
					    	daycnr = i+1;
						    Label label13 = new Label(mrg+i, 2, "DAY  "+daycnr,cellFormat);
						    writableSheet.addCell(label13);
						    
						    Label label14 = new Label(mrg+i, 3, "SHED",cellFormat);
						    writableSheet.addCell(label14);
						    mrg++;
						    Label label15 = new Label(mrg+i, 3, "Sale",cellFormat);
						    writableSheet.addCell(label15);
						    mrg++;
						    Label label16 = new Label(mrg+i, 3, "%",cellFormat);
						    writableSheet.addCell(label16); 
						}
					     
					 writableSheet.addCell(label_1);
					 writableSheet.addCell(label_2);
					 writableSheet.addCell(label_val1);
					 writableSheet.addCell(label_val2);
					    writableSheet.addCell(label);
					    writableSheet.addCell(label1);
					    writableSheet.addCell(label2);
					    writableSheet.addCell(label3);
					    writableSheet.addCell(label4);
					    writableSheet.addCell(label5);
					    writableSheet.addCell(label6);
					    writableSheet.addCell(label7);
					    writableSheet.addCell(label8);
					    writableSheet.addCell(label9);
					    writableSheet.addCell(label10);
					    writableSheet.addCell(label11);
					    writableSheet.addCell(label12);
					 // ***************************************************************************************************************************************************************************************************
					
							double shedule_id = 0,perShed=0;
								for(int i=0;i<condition.size();i++){
									cnt = 0;
								rs_disp = cs.executeQuery();
								while (rs_disp.next()) {
									if(condition.get(i).toString().equals(rs_disp.getString("CUST_CODE"))){
										if(cnt==0){	
											Label label_space = new Label(0, r, rs_disp.getString("CUST_NAME").toString(),cellFormat_header);
											writableSheet.addCell(label_space); 
											r++;
											cnt=1;
											}
										shedule_id = Double.parseDouble(rs_disp.getString("SCH_QTY"))/count_mnt;
										req_perdayQty = Double.parseDouble(rs_disp.getString("NOS_QTY"))/count_mnt;
										avg_perdayQty = Double.parseDouble(rs_disp.getString("SALE_QTY"))/total_dd;
										del_rating = (avg_perdayQty/req_perdayQty)*100;
										
										Label label_mName = new Label(0, r, rs_disp.getString("MAT_NAME").toString(),cellleftformat);
										Label label_perday = new Label(1, r, zeroDForm.format(req_perdayQty),cellRIghtformat);
										
										Label label_avgperday = new Label(2, r, zeroDForm.format(avg_perdayQty),cellRIghtformat);
										Label label_delrating = new Label(3, r, twoDForm.format(del_rating),cellRIghtformat);
										Label label_des_qty = new Label(4, r, zeroDForm.format(Math.round(Double.parseDouble(rs_disp.getString("NOS_QTY")))),cellRIghtformat);
										Label label_des_amt = new Label(5, r, twoDForm.format(Double.parseDouble(rs_disp.getString("SCH_AMT"))/100000),cellRIghtformat);
										Label label_sale_qty = new Label(6, r, zeroDForm.format(Math.round(Double.parseDouble(rs_disp.getString("SALE_QTY")))),cellRIghtformat);
										Label label_sale_amt = new Label(7, r, twoDForm.format(Double.parseDouble(rs_disp.getString("SALE_AMT"))/100000),cellRIghtformat);
										Label label_pend_qty = new Label(8, r, zeroDForm.format(Math.round(Double.parseDouble(rs_disp.getString("PEND_QTY")))),cellRIghtformat);
										Label label_pend_amt = new Label(9, r, twoDForm.format(Double.parseDouble(rs_disp.getString("PEND_AMT"))/100000),cellRIghtformat);
										  
										writableSheet.addCell(label_mName);
										writableSheet.addCell(label_perday); 
										writableSheet.addCell(label_avgperday);
										writableSheet.addCell(label_delrating);
										writableSheet.addCell(label_des_qty);
										writableSheet.addCell(label_des_amt);
										writableSheet.addCell(label_sale_qty);
										writableSheet.addCell(label_sale_amt);
										writableSheet.addCell(label_pend_qty);
										writableSheet.addCell(label_pend_amt);
										//***************************************************************************************************************************************************************************************************
										 rssale = cssale.executeQuery();
											while(rssale.next()){
												if(rssale.getString("MAT_CODE").equalsIgnoreCase(rs_disp.getString("MAT_CODE"))){
												compareList.add(rssale.getString("SALE_QTY1"));
												compareList.add(rssale.getString("SALE_QTY2"));
												compareList.add(rssale.getString("SALE_QTY3"));
												compareList.add(rssale.getString("SALE_QTY4"));
												compareList.add(rssale.getString("SALE_QTY5"));
												compareList.add(rssale.getString("SALE_QTY6"));
												compareList.add(rssale.getString("SALE_QTY7"));
												compareList.add(rssale.getString("SALE_QTY8"));
												compareList.add(rssale.getString("SALE_QTY9"));
												compareList.add(rssale.getString("SALE_QTY10"));
												compareList.add(rssale.getString("SALE_QTY11"));
												compareList.add(rssale.getString("SALE_QTY12"));
												compareList.add(rssale.getString("SALE_QTY13"));
												compareList.add(rssale.getString("SALE_QTY14"));
												compareList.add(rssale.getString("SALE_QTY15"));
												compareList.add(rssale.getString("SALE_QTY16"));
												compareList.add(rssale.getString("SALE_QTY17"));
												compareList.add(rssale.getString("SALE_QTY18"));
												compareList.add(rssale.getString("SALE_QTY19"));
												compareList.add(rssale.getString("SALE_QTY20"));
												compareList.add(rssale.getString("SALE_QTY21"));
												compareList.add(rssale.getString("SALE_QTY22"));
												compareList.add(rssale.getString("SALE_QTY23"));
												compareList.add(rssale.getString("SALE_QTY24"));
												compareList.add(rssale.getString("SALE_QTY25"));
												compareList.add(rssale.getString("SALE_QTY26"));
												compareList.add(rssale.getString("SALE_QTY27"));
												compareList.add(rssale.getString("SALE_QTY28"));
												compareList.add(rssale.getString("SALE_QTY29"));
												compareList.add(rssale.getString("SALE_QTY30"));
												compareList.add(rssale.getString("SALE_QTY31"));
												}
											}
											mrg = 10;
											for(int i1=0;i1<setdata.size();i1++){
												if(weekOff.contains(setdata.get(i1))){
													Label label_dayrows = new Label(mrg+i1, r,"",cellFormat_header);
													writableSheet.addCell(label_dayrows);
													mrg++;
													Label label_dayrows1 = new Label(mrg+i1, r,"OFF",cellFormat_header);
													writableSheet.addCell(label_dayrows1);
													mrg++;
													Label label_dayrows2 = new Label(mrg+i1, r,"",cellFormat_header);
													writableSheet.addCell(label_dayrows2);
												}else{
													perShed = (Double.parseDouble(compareList.get(i1).toString())/shedule_id)*100;
													
													Label label_dayrows = new Label(mrg+i1, r,zeroDForm.format(shedule_id) ,cellRIghtformat);
													writableSheet.addCell(label_dayrows);
													mrg++;
													Label label_dayrows1 = new Label(mrg+i1, r,zeroDForm.format(Math.round(Double.parseDouble(compareList.get(i1).toString()))) ,cellRIghtformat);
													writableSheet.addCell(label_dayrows1);
													mrg++;
													Label label_dayrows2 = new Label(mrg+i1, r,twoDForm.format(perShed)  ,cellRIghtformat);
													writableSheet.addCell(label_dayrows2);
													perShed=0;
												}
											}
											compareList.clear();
										//***************************************************************************************************************************************************************************************************
										r++;
										}
									}
								c++;
							}
					 // ***************************************************************************************************************************************************************************************************
					    writableWorkbook.write();
					    writableWorkbook.close();
					//***************************************************************************************************************************************************************************************************
					} 
					//***************************************************************************************************************************************************************************************************
					//												<======= End Excel Logic 
					//***************************************************************************************************************************************************************************************************
					
			//***************************************************************************************************************************************************************************************************	
				
				System.out.println("Dispatch Schedule of MEPL H21 Starts !!!");
				
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
		 		String from = "itsupports@muthagroup.com";
				String subject = "Dispatch Schedule of MEPL H21 on "+ todays_date;
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
				  
				String recipients[] = {"nileshss@muthagroup.com"};
				String cc_recipients[] = {"vijaybm@muthagroup.com"};

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
				sb.append("<p style='color: #0D265E; font-family: Arial; font-size: 11px;'>*** This is an automatically generated email for Dispatch Schedule of MEPL H21 ***</p>"+ 
						"<p><b>Please find below attached Dispatch Schedule of MEPL H21 on "+ todays_date+"</p>");				 
	sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
			"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");

	//*******************************************************************************************************************************
	//*******************************************************************************************************************************
	BodyPart messageBodyPart = new MimeBodyPart();
	messageBodyPart.setContent(sb.toString(),"Text/html");
	// Create a multipar message
	Multipart multipart = new MimeMultipart();

	// Set text message part
	multipart.addBodyPart(messageBodyPart);

	// Part two is attachment
	messageBodyPart = new MimeBodyPart();
	
	 String filename = "C:/reportxls/Sheduler"+val+".xls"; 
	DataSource source = new FileDataSource(filename);
	messageBodyPart.setDataHandler(new DataHandler(source));
	messageBodyPart.setFileName(filename);
	multipart.addBodyPart(messageBodyPart);

	// Send the complete message parts
	msg.setContent(multipart);
	
	Transport transport = mailSession.getTransport("smtp");
	transport.connect(host, user, pass);
	transport.sendMessage(msg, msg.getAllRecipients());
			// *******************************************************************************************
			transport.close(); 
			System.out.println("Automail loop End");

			con.close();
			conlocal.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	System.out.println("Sheduler MEPL H25");	
	}

}
