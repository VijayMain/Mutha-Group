package com.muthagroup.automail;
  
import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar; 
import java.util.Collections;
import java.util.Date; 
import java.util.HashMap;
import java.util.HashSet;
import java.util.Properties;
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

public class WO_Expected_Boring extends TimerTask {

	@Override
	public void run() {
		try {
			//-------------------------------------------------------- Date Logic ---------------------------------------------------------

			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			Date datesq = new Date();
			int day = datesq.getDate();
			
			ArrayList rem = new ArrayList(); 
			if (day==1 && d.getHours() == 9 && d.getMinutes() == 42) { 
				
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
			  				
				System.out.println("ERP Work Order Wise Expected Boring Summary Starts !!!");
				
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
		 		String from = "itsupports@muthagroup.com";
				String subject = "Work Order Wise Expected Boring("+dateFrom+" to "+dateTo +")";
				boolean sessionDebug = false;
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
				
				//*******************************************************************************************************************************
				//*********************************************** Excel Logic To Create Report **************************************************
				Connection con_erp = ConnectionUrl.getFoundryERPNEWConnection();   
				String comp = "103";       
				String fromDate = from_date.substring(6,8) +"/"+ from_date.substring(4,6) +"/"+ from_date.substring(0,4);
				String toDate = to_date.substring(6,8) +"/"+ to_date.substring(4,6) +"/"+ to_date.substring(0,4);

				DecimalFormat twoDForm = new DecimalFormat("###0.##"); 
				 
				int ct=0;
				String CompanyName= CompanyName = "MUTHA FOUNDERS PVT. LTD.";
					    
					
				
				ArrayList alistFile = new ArrayList();
				File folder = new File("C:/reportxls");
				File[] listOfFiles = folder.listFiles();
				String listname = "";  
				
			 	int val = listOfFiles.length + 1;
				
				File exlFile = new File("C:/reportxls/" + val + "MFPL_WOBoring"+to_date.substring(4,6) +"_"+ to_date.substring(0,4)+".xls");
			    WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
			    WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
			    
			    Colour bckcolor = Colour.LIGHT_ORANGE;
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
			    
			    writableSheet.setColumnView(0, 6);
			    writableSheet.setColumnView(1, 38);
			    writableSheet.setColumnView(2, 15);
			    writableSheet.setColumnView(3, 15);
			    writableSheet.setColumnView(4, 15);
			    writableSheet.setColumnView(5, 15); 
			    
			    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
			    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			    font.setColour(Colour.BLACK); 
			    cellRIghtformat.setFont(font);
			    
			    WritableCellFormat cellleftformat = new WritableCellFormat(); 
			    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			    font.setColour(Colour.BLACK); 
			    cellleftformat.setFont(font); 				
			        
			    Label label = new Label(0, 0, "Sr.No.",cellFormat);
			    Label label1 = new Label(1, 0, "Party Name",cellFormat);
			    Label label2 = new Label(2, 0, "Opening Bal",cellFormat);
			    Label label3 = new Label(3, 0, "Return Boring",cellFormat);
			    Label label4 = new Label(4, 0, "Expected Boring",cellFormat);
			    Label label5 = new Label(5, 0, "Recovery Bal.",cellFormat); 

			  // Add the created Cells to the sheet
			    writableSheet.addCell(label);
			    writableSheet.addCell(label1);
			    writableSheet.addCell(label2);
			    writableSheet.addCell(label3);
			    writableSheet.addCell(label4);
			    writableSheet.addCell(label5); 
			  	//***********************************************************************************************************************************
			    int cnt=1,row=0,col=1,srno=1; 
				double recovery=0;
				ArrayList party=new ArrayList();
				ArrayList OP_Qty=new ArrayList();
				ArrayList ret_bore=new ArrayList();
				ArrayList exp_bore=new ArrayList();
				ArrayList Rec_bal=new ArrayList();
				ArrayList Subglcode=new ArrayList();
				ArrayList  partyNames = new ArrayList();
				
				HashMap pN = new HashMap();
				HashMap pName = new HashMap(); 
				double expected_Boring=0; 
			 	CallableStatement cs11 = con_erp.prepareCall("{call Sel_RptWOWiseBoringDetail(?,?,?,?)}");
				cs11.setString(1,comp);
				cs11.setString(2,"0");       
				cs11.setString(3,from_date);
				cs11.setString(4,to_date); 
				ResultSet rs1 = cs11.executeQuery(); 
				while(rs1.next()){
					// System.out.println("data inside = " + from_date+" to date = " + to_date);
					recovery =0;
					 party.add(rs1.getString("SUB_GLACNO"));
					 OP_Qty.add(rs1.getString("OPENING_WT"));
					 ret_bore.add(rs1.getString("RETURN_BORING"));
					 pN.put(rs1.getString("SUB_GLACNO"),rs1.getString("PARTY_NAME"));
					 Subglcode.add(rs1.getString("SUB_GLACNO"));
					 if(rs1.getString("EXPECTED_BORING")!=null && Double.parseDouble(rs1.getString("EXPECTED_BORING"))!=0.000000){
						 expected_Boring = Double.parseDouble(rs1.getString("EXPECTED_BORING")); 
					 }else{
						 expected_Boring = 0;
					 }
					 exp_bore.add(expected_Boring);
					 recovery = Double.parseDouble(rs1.getString("OPENING_WT")) + expected_Boring - Double.parseDouble(rs1.getString("RETURN_BORING"));
					 Rec_bal.add(recovery);
				}	 
				HashSet hs = new HashSet();
				hs.addAll(party);
				party.clear();
				party.addAll(hs);
				Collections.sort(party);	
				 
				for(int s=0;s<Subglcode.size();s++){
					 pName.put(Subglcode.get(s).toString(), pN.get(Subglcode.get(s).toString()));
				}
				
				//System.out.println("Pname = " + pName.get("101120421"));
				
				double op=0,rt=0,exp=0,rec=0;
				String data = "";
				ArrayList allData=new ArrayList();  
				for(int i=0;i<party.size();i++){
					op=0;  
					rt=0;  
					exp=0;   
					rec=0;
					for(int j=0;j<Subglcode.size();j++){
							if(party.get(i).toString().equalsIgnoreCase(Subglcode.get(j).toString())){
							op += Double.parseDouble(OP_Qty.get(j).toString());
							rt += Double.parseDouble(ret_bore.get(j).toString());
							exp += Double.parseDouble(exp_bore.get(j).toString());
							rec += Double.parseDouble(Rec_bal.get(j).toString());  
							}
						}
					data = party.get(i).toString()+"$"+String.valueOf(op)+"$"+String.valueOf(rt)+"$"+String.valueOf(exp)+"$"+String.valueOf(rec);
					allData.add(data);  
					}  
				String dataname = "";
				String[] parts = null;
				int sr=1;
				for(int m=0;m<allData.size();m++){
				 dataname = allData.get(m).toString();
				 parts = dataname.split("\\$"); 

			jxl.write.Number sr_nolbl = new jxl.write.Number(row, col,srno ,cellRIghtformat);
			srno ++; 
			row++;
			Label party_lbl = new Label(row, col,pName.get(parts[0].toString()).toString() ,cellleftformat);
			row++;
			jxl.write.Number part1_lbl = new jxl.write.Number(row, col, Double.parseDouble(parts[1].toString()),cellRIghtformat);
			row++;
			jxl.write.Number part2_lbl = new jxl.write.Number(row, col, Double.parseDouble(parts[2].toString()),cellRIghtformat);
			row++;
			jxl.write.Number part3_lbl = new jxl.write.Number(row, col, Double.parseDouble(parts[3].toString()),cellRIghtformat);
			row++;
			jxl.write.Number part4_lbl = new jxl.write.Number(row, col, Double.parseDouble(parts[4].toString()),cellRIghtformat); 

					writableSheet.addCell(sr_nolbl);
					writableSheet.addCell(party_lbl);
					writableSheet.addCell(part1_lbl);
					writableSheet.addCell(part2_lbl);
					writableSheet.addCell(part3_lbl);
					writableSheet.addCell(part4_lbl); 
					row++;
					
					if(row==6){
						row=0;
						col++;   
					} 
			}
			//	System.out.println("Data Updation is done !!!");
			  //************************************************************************************************************************
			  //************************************************ File Output Ligic *****************************************************
			  //************************************************************************************************************************
			    //Write and close the workbook
			    writableWorkbook.write();
			    writableWorkbook.close();
				//*******************************************************************************************************************************
				StringBuilder sb = new StringBuilder();
				//*******************************************************************************************************************************
				sb.append("<p style='color: #0D265E; font-family: Arial; font-size: 11px;'>*** This is an automatically generated email of Work Order Wise Expected Boring Summary Report !!! ***</p>"+ 
						"<p><b>Please find below attached Work Order Wise Expected Boring Summary Report of MFPL from " + dateFrom + " to " + dateTo + "</p>");				 
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
	 
	String filename = "C:/reportxls/" + val + "MFPL_WOBoring"+to_date.substring(4,6) +"_"+ to_date.substring(0,4)+".xls";
	
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
		}	 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	System.out.println("ERP Mailer WO Boring");	
	}
}