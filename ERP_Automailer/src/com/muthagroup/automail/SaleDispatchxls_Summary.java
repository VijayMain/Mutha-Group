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
import jxl.write.Number;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class SaleDispatchxls_Summary extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("Schedule Report Loop Start");
			//-------------------------------------------------------- Date Logic ---------------------------------------------------------
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			boolean flag = true;
			 /*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 15 && d.getMinutes() == 12) {*/
		  if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 23 && d.getMinutes() == 30) {
			//******************************************************************************************************************************
				 	ArrayList weekOff = new ArrayList();
					int cnt = 0;
					DecimalFormat zeroDForm = new DecimalFormat("#####0");
					DecimalFormat twoDForm = new DecimalFormat("#####0.00");
					
					Calendar cal = Calendar.getInstance();
					// cal.add(Calendar.DATE, -1);
					SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy");
					SimpleDateFormat sqlDate = new SimpleDateFormat("yyyyMMdd");
					String todays_date = todaysDate.format(cal.getTime()).toString();
					String sql_date = sqlDate.format(cal.getTime()).toString();
					
					//System.out.println("Sql Date = = " + sql_date);
					
					// **********************************************************************************************************
					Date dateLogic = todaysDate.parse(todays_date);
					if(weekday[dateLogic.getDay()].equals("Tuesday")){
						cal.add(Calendar.DATE, -1);
						todays_date = todaysDate.format(cal.getTime()).toString();
						sql_date = sqlDate.format(cal.getTime()).toString();
					}
					cal.add(Calendar.DATE, -1);
					String  sql_date_prev = sqlDate.format(cal.getTime()).toString();
					
					// **********************************************************************************************************
					double req_perdayQty=0,avg_perdayQty=0,del_rating=0; 
					// ***************************************************************************************************************
					// *************************************************** Workdays ***************************************************
			Connection conlocal = ConnectionUrl.getLocalDatabase();
			Connection con = null;
			String comp_id ="";
			String Sheet_Name = "";
			int sheetcnt=0;

			ArrayList alistFile = new ArrayList();
			File folder = new File("C:/reportxls");
			File[] listOfFiles = folder.listFiles();
			String listname = "";
			int val = listOfFiles.length + 1;

			File exlFile = new File("C:/reportxls/Sheduler"+val+".xls");
			WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
	
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
		    
		    Colour backHcolor = Colour.CORAL;
		    WritableCellFormat cellFormat_header = new WritableCellFormat();
		    cellFormat_header.setBackground(backHcolor);
		    cellFormat_header.setAlignment(Alignment.LEFT); 
		    cellFormat_header.setFont(fontbold); 
		    
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
			//-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
			  		String testDate = sql_date.substring(6,8) +"-"+ sql_date.substring(4,6) +"-"+ sql_date.substring(0,4);
			  		
			  		//System.out.println("Date Logic = " + sql_date + " prev = " + sql_date_prev + " main date = "  + testDate);
			  		
			  		DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
					Date today = formatter.parse(testDate);
 					String dayCNT = sql_date.substring(6,8);
 				//	System.err.println("Day = " + sql_date.substring(6,8) + "    " + dayCNT);
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
				int day = Integer.parseInt(dayCNT);

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
				// System.out.println("Hollidays = " + holliday + " Total dd = " + total_dd);
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
					weekOff.add(rs_Hol.getInt("day"));
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
				// System.out.println("Total Woring Days = " + count_mnt);
				// *************************************************************************************************************** 
				//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
				 
				ArrayList	sch_qtyalist	= new	ArrayList();
				ArrayList	sch_amtalist	= new	ArrayList();
				ArrayList	sch_wtalist	= new	ArrayList();  
				ArrayList	yes_qtyalist	= new	ArrayList();
				ArrayList	yes_amtalist	= new	ArrayList();
				ArrayList	yes_wtalist	= new	ArrayList(); 
				ArrayList	sale_qtyalist	= new	ArrayList();
				ArrayList	sale_amtalist	= new	ArrayList();
				ArrayList	sale_wtalist	 = new	ArrayList();
				ArrayList	pend_qtyalist	= new	ArrayList();
				ArrayList	pend_amtalist	= new	ArrayList(); 
				//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
				comp_id ="101";
				Sheet_Name = "MEPL H21";
				con = ConnectionUrl.getMEPLH21ERP();
				// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
				sch_qtyalist.clear();
				sch_amtalist.clear();
				sch_wtalist.clear(); 
				yes_qtyalist.clear();
				yes_amtalist.clear();
				yes_wtalist.clear(); 
				sale_qtyalist.clear();
				sale_amtalist.clear();
				sale_wtalist.clear(); 
				pend_qtyalist.clear();
				pend_amtalist.clear();
				// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
			  	WritableSheet writableSheet = writableWorkbook.createSheet(Sheet_Name, sheetcnt);
				StringBuilder sb2 = new StringBuilder(); 
					PreparedStatement ps_code = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='11'");
					ResultSet rs_code = ps_code.executeQuery();
					while (rs_code.next()) {
						sb2.append(rs_code.getString("SUB_GLACNO"));
					}
					
					// exec "ENGERP"."dbo"."Sel_RptDespatchPlanSaleMUTA";1 '101', '0', '101110001101110002101110003101110004101110005101110006101110007101110008101110009101110010101110011101110012101110013101110014101110015101110016101110017101110018101110019101110020101110021101110022101110023101110024101110025101110026101110027101110028101110029101110030101110031101110032101110033101110034101110035101110036101110037101110038101110039101110040101110041101110042101110043101110044101110045101110046101110047101110048101110049101110050101110051101110052101110055101110058101110059101110062101110063101110077101110081101110082101110094101110117101110129101110130101110131101110132101110135101110140101110141101110144101110148101110149101110150101110151101110160101110161101110162101110164101110165101110168101110179101110180101110181101110183101110184101110185101110186101110187101110191101110192101110193101110198101110199101110200101110202101110203101110205101110209101110210101110212101110230101110240101110247101110248101110249101110250101110251101110258101110261101110266101110269101110272101110280101110281101110282101110284101110287101110288101110291101110293101110298101110299101110300101110302101110304101110305101110307101110309101110311101110312101110313101110315101110316101110318101110322101110324101110325101110326101110327101110331101110342101110343101110344101110346101110347101110350101110353101110354101110362101110368101110369101110370101110371101110373101110374101110376101110379101110382101110383101110384101110387101110388101110389101110390101110391101110393101110394101110396101110399101110400101110402101110407101110408101110411101110418101110420101110426101110428101110442101110444101110454101110455101110460101110462101110463101110467101110469101110470101110471101110475101110476101110478101110479101110481101110483101110484101110493101110494101110495101110496101110497101110507101110508101110510101110515101110516101110517101110518101110519101110520101110523101110526101110529101110530101110539101110543101110544101110546101110547101110548101110550101110555101110556101110557101110558101110559101110561101110572' , '20170712'
					ArrayList custcodes=new ArrayList();
					CallableStatement cs = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
					cs.setString(1, comp_id);
					cs.setString(2, "0");
					  cs.setString(3, sb2.toString());
					cs.setString(4, sql_date);
					ResultSet rs = cs.executeQuery();
					while (rs.next()) {
					custcodes.add(rs.getString("CUST_CODE"));
					} 					  
					
					Set<String> hs = new HashSet();
					hs.addAll(custcodes);
					custcodes.clear();
					custcodes.addAll(hs);  
					
					System.out.println("SQl Date = " + sql_date + "Sql YEst Date = " + sql_date_prev);
					
					CallableStatement cs_prev = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
					cs_prev.setString(1, comp_id);
					cs_prev.setString(2, "0"); 
					cs_prev.setString(3, sb2.toString());
					cs_prev.setString(4, sql_date_prev);
					ResultSet rs_prev=null;
					String sale_qtyyes="",sale_amtyes="",tonnage_yes="";
					double complSaleper=0;
					// ***************************************************************************************************************
					if (custcodes.size() > 0) {
					//***************************************************************************************************************************************************************************************************
						writableSheet.setColumnView(0, 40);
					    writableSheet.setColumnView(1, 12);
					    writableSheet.setColumnView(2, 12);
					    writableSheet.setColumnView(3, 12);
					    writableSheet.setColumnView(4, 12);
					    writableSheet.setColumnView(5, 12);
					    writableSheet.setColumnView(6, 12);
					    writableSheet.setColumnView(7, 12);
					    writableSheet.setColumnView(8, 12);
					    writableSheet.setColumnView(9, 12);
					    writableSheet.setColumnView(10, 12);
					    writableSheet.setColumnView(11, 12);
					    writableSheet.setColumnView(12, 12);
					    writableSheet.setColumnView(13, 12);
					  
					    writableSheet.mergeCells(0, 2,0, 3);  
					    writableSheet.mergeCells(1, 2,3, 2); 
					    writableSheet.mergeCells(4, 2,6, 2);  
					    writableSheet.mergeCells(7, 2,9, 2); 
					    writableSheet.mergeCells(10, 2,11, 2);
					    writableSheet.mergeCells(12,2,12,3);   
					    writableSheet.mergeCells(13, 2,13, 3); 
					    
					    Label label1 = new Label(0, 0, "Working Days",cellRIghtformat);
					    Label label2 = new Label(0, 1, "Days Completed",cellRIghtformat);
					    Label label3 = new Label(3, 0, "Schedule V/s Sales on " + testDate,cellRIghtformat);
					    Label label4 = new Label(1, 0, zeroDForm.format(count_mnt) , cellRIghtformat); 
					    Label label5 = new Label(1, 1, zeroDForm.format(total_dd), cellRIghtformat);
					    Label label6 = new Label(0, 2, "Name of Item",cellFormat);  
					    
					    Label label7 = new Label(1, 2, "Schedule",cellFormat);				
					    Label label8 = new Label(1, 3, "Qty",cellFormat);						
					    Label label9 = new Label(2, 3, "AMT",cellFormat);					
					    
					    Label label10 = new Label(3, 3, "Wt. in Tons",cellFormat);     
					    
					    Label label11 = new Label(4, 2, "Yesterday's Sales",cellFormat_header);    
					    Label label12 = new Label(4, 3, "Qty",cellFormat);                  
					    Label label13 = new Label(5, 3, "AMT",cellFormat); 					
					    
					    Label label14 = new Label(6, 3, "Wt. in Tons",cellFormat);      
					    
					    Label label15 = new Label(7, 2, "Sales",cellFormat);		  
					    Label label16 = new Label(7, 3, "Qty",cellFormat);			
					    Label label17 = new Label(8, 3, "AMT",cellFormat);			
					    
					    Label label18 = new Label(9, 3, "Wt. in Tons",cellFormat);   
					    
					    Label label19 = new Label(10, 2, "Pending",cellFormat);    
					    Label label20 = new Label(10, 3, "Qty",cellFormat);				
					    Label label21 = new Label(11, 3, "AMT",cellFormat);			
					     
					    /* Label label22 = new Label(11, 2, "Wt. in Tons",cellFormat); */
					    Label label22 = new Label(12, 2, "Schedule Compliance%",cellFormat);
					     
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
					 writableSheet.addCell(label13); 
					 writableSheet.addCell(label14); 
					 writableSheet.addCell(label15); 
					 writableSheet.addCell(label16);
					 writableSheet.addCell(label17);
					 writableSheet.addCell(label18);
					 writableSheet.addCell(label19);
					 writableSheet.addCell(label20);
					 writableSheet.addCell(label21);
					 writableSheet.addCell(label22); 
					}
					 
					int count=0;
					int col=4; 
					for(int i=0;i<custcodes.size();i++){
					count=0; 
					rs = cs.executeQuery(); 
					while(rs.next()){
						
						if(rs.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString())){
							
						if(count==0){
							Label customer = new  Label(0, col, rs.getString("CUST_NAME"),cellFormat_header);
							writableSheet.addCell(customer);
							count ++;
							col++;
						} 
						
						rs_prev = cs_prev.executeQuery();
						sale_qtyyes="0";
						sale_amtyes="0";
						tonnage_yes="0";
						complSaleper=0;
						while(rs_prev.next()){
							if(rs_prev.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString()) && 
								rs_prev.getString("MAT_CODE").equalsIgnoreCase(rs.getString("MAT_CODE"))){ 
								sale_qtyyes=rs_prev.getString("SALE_QTY");
								sale_amtyes=rs_prev.getString("SALE_AMT"); 
								tonnage_yes = rs_prev.getString("SALE_TONAGE");
							}
						}
						complSaleper =Double.parseDouble(rs.getString("SALE_QTY"))/ Double.parseDouble(rs.getString("SCH_QTY"))*100;
						
						Label matName = new  Label(0, col, rs.getString("MAT_NAME"),cellleftformat);
						writableSheet.addCell(matName);
						
						Number label_des_qty = new Number(1, col, Math.round(Double.parseDouble(rs.getString("SCH_QTY"))),cellRIghtformat);
						writableSheet.addCell(label_des_qty);
						
						
						Number label_des_amt = new Number(2, col, Double.parseDouble(rs.getString("SCH_AMT"))/100000,cellRIghtformat);
						writableSheet.addCell(label_des_amt);
						
						 
						Number label_sch_tons = new Number(3, col, Double.parseDouble(rs.getString("SCH_TONAGE")),cellRIghtformat);
						writableSheet.addCell(label_sch_tons);
						
						
						Number yes_sale_qty = new Number(4, col, Math.round(Double.parseDouble(sale_qtyyes)),cellRIghtformat);
						writableSheet.addCell(yes_sale_qty);
						
						
						
						Number yes_sale_amt = new Number(5, col, Double.parseDouble(sale_amtyes)/100000,cellRIghtformat);
						writableSheet.addCell(yes_sale_amt);
						
						
						
						Number label_saleyes_tons = new Number(6, col, Double.parseDouble(tonnage_yes),cellRIghtformat);
						writableSheet.addCell(label_saleyes_tons);
						
						
						
						Number label_sale_qty = new Number(7, col, Math.round(Double.parseDouble(rs.getString("SALE_QTY"))),cellRIghtformat);
						writableSheet.addCell(label_sale_qty);
						
						
						
						Number label_sale_amt = new Number(8, col, Double.parseDouble(rs.getString("SALE_AMT"))/100000,cellRIghtformat);
						writableSheet.addCell(label_sale_amt);
						
						
						
						Number label_sale_tons = new Number(9, col, Double.parseDouble(rs.getString("SALE_TONAGE")),cellRIghtformat);
						writableSheet.addCell(label_sale_tons);
						
						
						
						Number label_pend_qty = new Number(10, col, Math.round(Double.parseDouble(rs.getString("PEND_QTY"))),cellRIghtformat);
						writableSheet.addCell(label_pend_qty);
						
						
						
						Number label_pend_amt = new Number(11, col, Math.round(Double.parseDouble(rs.getString("PEND_AMT"))/100000),cellRIghtformat);
						writableSheet.addCell(label_pend_amt);
						 
						Number label_schCompl = new Number(12, col, Math.round(complSaleper),cellRIghtformat);
						writableSheet.addCell(label_schCompl);
						
						sch_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SCH_QTY"))));
						sch_amtalist.add(Double.parseDouble(rs.getString("SCH_AMT"))/100000);
						sch_wtalist.add(Double.parseDouble(rs.getString("SCH_TONAGE")));
						yes_qtyalist.add(Math.round(Double.parseDouble(sale_qtyyes)));
						yes_amtalist.add(Double.parseDouble(sale_amtyes)/100000);
						yes_wtalist.add(Double.parseDouble(tonnage_yes));
						sale_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SALE_QTY"))));
						sale_amtalist.add(Double.parseDouble(rs.getString("SALE_AMT"))/100000);
						sale_wtalist.add(Double.parseDouble(rs.getString("SALE_TONAGE")));
						pend_qtyalist.add(Math.round(Double.parseDouble(rs.getString("PEND_QTY"))));
						pend_amtalist.add(Double.parseDouble(rs.getString("PEND_AMT"))/100000);
						
						col++;
					  }
					} 
					}
				//--------------------------------------------	
					double sum = 0;
					
					Label grd0 = new Label(0, col, "Grand Total",cellFormat);   
					writableSheet.addCell(grd0);
					//--------------------------------------------	
					for(int i=0; i<sch_qtyalist.size(); i++){
						  sum += Double.parseDouble(sch_qtyalist.get(i).toString());
					} 
					Number grd1 = new Number(1, col, sum,cellRIghtformat);		
					writableSheet.addCell(grd1);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<sch_amtalist.size(); i++){
						  sum += Double.parseDouble(sch_amtalist.get(i).toString());
					} 
					
					Number grd2 = new Number(2, col, sum,cellRIghtformat);
					writableSheet.addCell(grd2);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<sch_wtalist.size(); i++){
						  sum += Double.parseDouble(sch_wtalist.get(i).toString());
					} 
					Number grd3 = new Number(3, col, sum,cellRIghtformat);
					writableSheet.addCell(grd3);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<yes_qtyalist.size(); i++){
						  sum += Double.parseDouble(yes_qtyalist.get(i).toString());
					} 
					Number grd4 = new Number(4, col, sum,cellRIghtformat);
					writableSheet.addCell(grd4);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<yes_amtalist.size(); i++){
						  sum += Double.parseDouble(yes_amtalist.get(i).toString());
					}
					Number grd5 = new Number(5, col, sum,cellRIghtformat);
					writableSheet.addCell(grd5);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<yes_wtalist.size(); i++){
						  sum += Double.parseDouble(yes_wtalist.get(i).toString());
					} 
					Number grd6 = new Number(6, col, sum,cellRIghtformat);
					writableSheet.addCell(grd6);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<sale_qtyalist.size(); i++){
						  sum += Double.parseDouble(sale_qtyalist.get(i).toString());
					}
					Number grd7 = new Number(7, col, sum,cellRIghtformat);
					writableSheet.addCell(grd7);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<sale_amtalist.size(); i++){
						  sum += Double.parseDouble(sale_amtalist.get(i).toString());
					}
					Number grd8 = new Number(8, col, sum,cellRIghtformat);
					writableSheet.addCell(grd8);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<sale_wtalist.size(); i++){
						  sum += Double.parseDouble(sale_wtalist.get(i).toString());
					}
					Number grd9 = new Number(9, col, sum,cellRIghtformat);
					writableSheet.addCell(grd9);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<pend_qtyalist.size(); i++){
						  sum += Double.parseDouble(pend_qtyalist.get(i).toString());
					}
					Number grd10 = new Number(10, col, sum,cellRIghtformat);
					writableSheet.addCell(grd10);
					//--------------------------------------------
					sum=0;
					for(int i=0; i<pend_amtalist.size(); i++){
						  sum += Double.parseDouble(pend_amtalist.get(i).toString());
					}
					Number grd11 = new Number(11, col, sum,cellRIghtformat);
					writableSheet.addCell(grd11);
					//--------------------------------------------
					sum=0;
					//--------------------------------------------
					Label grd12 = new Label(12, col, "",cellRIghtformat);
					writableSheet.addCell(grd12);
					//--------------------------------------------
					
					
					//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
					//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
					comp_id ="102";
					Sheet_Name = "MEPL H25";
					con = ConnectionUrl.getMEPLH25ERP();
					// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
					sch_qtyalist.clear();
					sch_amtalist.clear();
					sch_wtalist.clear(); 
					yes_qtyalist.clear();
					yes_amtalist.clear();
					yes_wtalist.clear(); 
					sale_qtyalist.clear();
					sale_amtalist.clear();
					sale_wtalist.clear(); 
					pend_qtyalist.clear();
					pend_amtalist.clear();
					// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
					sheetcnt++;
				  	WritableSheet writableSheet2 = writableWorkbook.createSheet(Sheet_Name, sheetcnt); 
				  	sb2.setLength(0); 
						ps_code = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='11'");
						rs_code = ps_code.executeQuery();
						while (rs_code.next()) {
							sb2.append(rs_code.getString("SUB_GLACNO"));
						}
						
						// exec "ENGERP"."dbo"."Sel_RptDespatchPlanSaleMUTA";1 '101', '0', '101110001101110002101110003101110004101110005101110006101110007101110008101110009101110010101110011101110012101110013101110014101110015101110016101110017101110018101110019101110020101110021101110022101110023101110024101110025101110026101110027101110028101110029101110030101110031101110032101110033101110034101110035101110036101110037101110038101110039101110040101110041101110042101110043101110044101110045101110046101110047101110048101110049101110050101110051101110052101110055101110058101110059101110062101110063101110077101110081101110082101110094101110117101110129101110130101110131101110132101110135101110140101110141101110144101110148101110149101110150101110151101110160101110161101110162101110164101110165101110168101110179101110180101110181101110183101110184101110185101110186101110187101110191101110192101110193101110198101110199101110200101110202101110203101110205101110209101110210101110212101110230101110240101110247101110248101110249101110250101110251101110258101110261101110266101110269101110272101110280101110281101110282101110284101110287101110288101110291101110293101110298101110299101110300101110302101110304101110305101110307101110309101110311101110312101110313101110315101110316101110318101110322101110324101110325101110326101110327101110331101110342101110343101110344101110346101110347101110350101110353101110354101110362101110368101110369101110370101110371101110373101110374101110376101110379101110382101110383101110384101110387101110388101110389101110390101110391101110393101110394101110396101110399101110400101110402101110407101110408101110411101110418101110420101110426101110428101110442101110444101110454101110455101110460101110462101110463101110467101110469101110470101110471101110475101110476101110478101110479101110481101110483101110484101110493101110494101110495101110496101110497101110507101110508101110510101110515101110516101110517101110518101110519101110520101110523101110526101110529101110530101110539101110543101110544101110546101110547101110548101110550101110555101110556101110557101110558101110559101110561101110572' , '20170712'
						custcodes.clear();
						cs = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
						cs.setString(1, comp_id);
						cs.setString(2, "0"); 
						cs.setString(3, sb2.toString());
						cs.setString(4, sql_date);
						rs = cs.executeQuery();
						while (rs.next()) {
						custcodes.add(rs.getString("CUST_CODE"));
						} 					 
						
						hs.clear();
						hs.addAll(custcodes);
						custcodes.clear();
						custcodes.addAll(hs);  
						
						cs_prev = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
						cs_prev.setString(1, comp_id);
						cs_prev.setString(2, "0"); 
						cs_prev.setString(3, sb2.toString());
						cs_prev.setString(4, sql_date_prev);
						rs_prev=null;
						sale_qtyyes="";sale_amtyes="";tonnage_yes="";
						complSaleper=0;
						// ***************************************************************************************************************
						if (custcodes.size() > 0) {
						//***************************************************************************************************************************************************************************************************
							writableSheet2.setColumnView(0, 40);
						    writableSheet2.setColumnView(1, 12);
						    writableSheet2.setColumnView(2, 12);
						    writableSheet2.setColumnView(3, 12);
						    writableSheet2.setColumnView(4, 12);
						    writableSheet2.setColumnView(5, 12);
						    writableSheet2.setColumnView(6, 12);
						    writableSheet2.setColumnView(7, 12);
						    writableSheet2.setColumnView(8, 12);
						    writableSheet2.setColumnView(9, 12);
						    writableSheet2.setColumnView(10, 12);
						    writableSheet2.setColumnView(11, 12);
						    writableSheet2.setColumnView(12, 12);
						    writableSheet2.setColumnView(13, 12); 
						    		
						    		writableSheet2.mergeCells(0, 2,0, 3);  
						    		writableSheet2.mergeCells(1, 2,3, 2); 
						    		writableSheet2.mergeCells(4, 2,6, 2);  
						    		writableSheet2.mergeCells(7, 2,9, 2); 
						    		writableSheet2.mergeCells(10, 2,11, 2);
						    		writableSheet2.mergeCells(12,2,12,3);   
						    		writableSheet2.mergeCells(13, 2,13, 3); 		
						    		
						    
						    Label label1 = new Label(0, 0, "Working Days",cellRIghtformat);
						    Label label2 = new Label(0, 1, "Days Completed",cellRIghtformat);
						    Label label3 = new Label(3, 0, "Schedule V/s Sales on " + testDate,cellRIghtformat);
						    Label label4 = new Label(1, 0, zeroDForm.format(count_mnt) , cellRIghtformat); 
						    Label label5 = new Label(1, 1, zeroDForm.format(total_dd), cellRIghtformat);
						    Label label6 = new Label(0, 2, "Name of Item",cellFormat);  
						    
						    Label label7 = new Label(1, 2, "Schedule",cellFormat);
						    Label label8 = new Label(1, 3, "Qty",cellFormat);
						    Label label9 = new Label(2, 3, "AMT",cellFormat);
						    
						    Label label10 = new Label(3, 3, "Wt. in Tons",cellFormat);
						     
						    Label label11 = new Label(4, 2, "Yesterday's Sales",cellFormat_header);
						    Label label12 = new Label(4, 3, "Qty",cellFormat);
						    Label label13 = new Label(5, 3, "AMT",cellFormat); 
						    
						    Label label14 = new Label(6, 3, "Wt. in Tons",cellFormat);
						    
						    Label label15 = new Label(7, 2, "Sales",cellFormat);
						    Label label16 = new Label(7, 3, "Qty",cellFormat);
						    Label label17 = new Label(8, 3, "AMT",cellFormat);
						    
						    Label label18 = new Label(9, 3, "Wt. in Tons",cellFormat);
						    
						    Label label19 = new Label(10, 2, "Pending",cellFormat);
						    Label label20 = new Label(10, 3, "Qty",cellFormat);
						    Label label21 = new Label(11, 3, "AMT",cellFormat);
						     
						    /* Label label22 = new Label(11, 2, "Wt. in Tons",cellFormat); */
						    Label label22 = new Label(12, 2, "Schedule Compliance%",cellFormat);
						     
						 writableSheet2.addCell(label1);
						 writableSheet2.addCell(label2);
						 writableSheet2.addCell(label3);
						 writableSheet2.addCell(label4);
						 writableSheet2.addCell(label5);
						 writableSheet2.addCell(label6);
						 writableSheet2.addCell(label7);
						 writableSheet2.addCell(label8);
						 writableSheet2.addCell(label9);
						 writableSheet2.addCell(label10);
						 writableSheet2.addCell(label11);
						 writableSheet2.addCell(label12); 
						 writableSheet2.addCell(label13); 
						 writableSheet2.addCell(label14); 
						 writableSheet2.addCell(label15); 
						 writableSheet2.addCell(label16);
						 writableSheet2.addCell(label17);
						 writableSheet2.addCell(label18);
						 writableSheet2.addCell(label19);
						 writableSheet2.addCell(label20);
						 writableSheet2.addCell(label21);
						 writableSheet2.addCell(label22); 
						}
						
						count=0;
						col=4;
						for(int i=0;i<custcodes.size();i++){
						count=0; 
						rs = cs.executeQuery(); 
						while(rs.next()){ 
							if(rs.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString())){
							if(count==0){
								Label customer = new  Label(0, col, rs.getString("CUST_NAME"),cellFormat_header);
								writableSheet2.addCell(customer);
								count ++;
								col++;
							} 
							
							rs_prev = cs_prev.executeQuery(); 
							sale_qtyyes="0";
							sale_amtyes="0";
							tonnage_yes="0";
							complSaleper=0; 
							while(rs_prev.next()){
								if(rs_prev.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString()) && 
									rs_prev.getString("MAT_CODE").equalsIgnoreCase(rs.getString("MAT_CODE"))){ 
									sale_qtyyes=rs_prev.getString("SALE_QTY");
									sale_amtyes=rs_prev.getString("SALE_AMT"); 
									tonnage_yes = rs_prev.getString("SALE_TONAGE");
								}
							} 
							 
							complSaleper =Double.parseDouble(rs.getString("SALE_QTY"))/ Double.parseDouble(rs.getString("SCH_QTY"))*100;
							
							Label matName = new  Label(0, col, rs.getString("MAT_NAME"),cellleftformat);
							writableSheet2.addCell(matName); 
							
							Number label_des_qty = new Number(1, col, Math.round(Double.parseDouble(rs.getString("SCH_QTY"))),cellRIghtformat);
							writableSheet2.addCell(label_des_qty);
							
							Number label_des_amt = new Number(2, col, Double.parseDouble(rs.getString("SCH_AMT"))/100000,cellRIghtformat);
							writableSheet2.addCell(label_des_amt);
							 
							Number label_sch_tons = new Number(3, col, Double.parseDouble(rs.getString("SCH_TONAGE")),cellRIghtformat);
							writableSheet2.addCell(label_sch_tons);
												
							
							Number yes_sale_qty = new Number(4, col, Math.round(Double.parseDouble(sale_qtyyes)),cellRIghtformat);
							writableSheet2.addCell(yes_sale_qty);
							
							Number yes_sale_amt = new Number(5, col, Double.parseDouble(sale_amtyes)/100000,cellRIghtformat);
							writableSheet2.addCell(yes_sale_amt);

							Number label_saleyes_tons = new Number(6, col, Double.parseDouble(tonnage_yes),cellRIghtformat);
							writableSheet2.addCell(label_saleyes_tons);
							
							
							Number label_sale_qty = new Number(7, col, Math.round(Double.parseDouble(rs.getString("SALE_QTY"))),cellRIghtformat);
							writableSheet2.addCell(label_sale_qty);
							
							Number label_sale_amt = new Number(8, col, Double.parseDouble(rs.getString("SALE_AMT"))/100000,cellRIghtformat);
							writableSheet2.addCell(label_sale_amt);
							
							Number label_sale_tons = new Number(9, col,Double.parseDouble(rs.getString("SALE_TONAGE")),cellRIghtformat);
							writableSheet2.addCell(label_sale_tons);
							
							
							Number label_pend_qty = new Number(10, col,Math.round(Double.parseDouble(rs.getString("PEND_QTY"))),cellRIghtformat);
							writableSheet2.addCell(label_pend_qty);
							
							Number label_pend_amt = new Number(11, col, Double.parseDouble(rs.getString("PEND_AMT"))/100000,cellRIghtformat);
							writableSheet2.addCell(label_pend_amt);
							 	
							Number label_schCompl = new Number(12, col, Math.round(complSaleper),cellRIghtformat);
							writableSheet2.addCell(label_schCompl);
						    
							sch_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SCH_QTY"))));
							sch_amtalist.add(Double.parseDouble(rs.getString("SCH_AMT"))/100000);
							sch_wtalist.add(Double.parseDouble(rs.getString("SCH_TONAGE")));
							yes_qtyalist.add(Math.round(Double.parseDouble(sale_qtyyes)));
							yes_amtalist.add(Double.parseDouble(sale_amtyes)/100000);
							yes_wtalist.add(Double.parseDouble(tonnage_yes));
							sale_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SALE_QTY"))));
							sale_amtalist.add(Double.parseDouble(rs.getString("SALE_AMT"))/100000);
							sale_wtalist.add(Double.parseDouble(rs.getString("SALE_TONAGE")));
							pend_qtyalist.add(Math.round(Double.parseDouble(rs.getString("PEND_QTY"))));
							pend_amtalist.add(Double.parseDouble(rs.getString("PEND_AMT"))/100000);
							
							col++;
						  }
						} 
						}
						//--------------------------------------------	
						sum = 0; 
						grd0 = new Label(0, col, "Grand Total",cellFormat);   
						writableSheet2.addCell(grd0);
						//--------------------------------------------	
						for(int i=0; i<sch_qtyalist.size(); i++){
							  sum += Double.parseDouble(sch_qtyalist.get(i).toString());
						} 
						grd1 = new Number(1, col, sum,cellRIghtformat);		
						writableSheet2.addCell(grd1);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<sch_amtalist.size(); i++){
							  sum += Double.parseDouble(sch_amtalist.get(i).toString());
						} 

						grd2 = new Number(2, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd2);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<sch_wtalist.size(); i++){
							  sum += Double.parseDouble(sch_wtalist.get(i).toString());
						} 
						grd3 = new Number(3, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd3);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<yes_qtyalist.size(); i++){
							  sum += Double.parseDouble(yes_qtyalist.get(i).toString());
						} 
						grd4 = new Number(4, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd4);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<yes_amtalist.size(); i++){
							  sum += Double.parseDouble(yes_amtalist.get(i).toString());
						}
						grd5 = new Number(5, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd5);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<yes_wtalist.size(); i++){
							  sum += Double.parseDouble(yes_wtalist.get(i).toString());
						} 
						grd6 = new Number(6, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd6);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<sale_qtyalist.size(); i++){
							  sum += Double.parseDouble(sale_qtyalist.get(i).toString());
						}
						grd7 = new Number(7, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd7);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<sale_amtalist.size(); i++){
							  sum += Double.parseDouble(sale_amtalist.get(i).toString());
						}
						grd8 = new Number(8, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd8);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<sale_wtalist.size(); i++){
							  sum += Double.parseDouble(sale_wtalist.get(i).toString());
						}
						grd9 = new Number(9, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd9);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<pend_qtyalist.size(); i++){
							  sum += Double.parseDouble(pend_qtyalist.get(i).toString());
						}
						grd10 = new Number(10, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd10);
						//--------------------------------------------
						sum=0;
						for(int i=0; i<pend_amtalist.size(); i++){
							  sum += Double.parseDouble(pend_amtalist.get(i).toString());
						}
						grd11 = new Number(11, col, sum,cellRIghtformat);
						writableSheet2.addCell(grd11);
						//--------------------------------------------
						sum=0;
						//--------------------------------------------
						grd12 = new Label(12, col, "",cellRIghtformat);
						writableSheet2.addCell(grd12);
						//--------------------------------------------  
						//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
						//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
						comp_id ="103";
						Sheet_Name = "MFPL";
						con = ConnectionUrl.getFoundryERPNEWConnection();
						// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
						sch_qtyalist.clear();
						sch_amtalist.clear();
						sch_wtalist.clear(); 
						yes_qtyalist.clear();
						yes_amtalist.clear();
						yes_wtalist.clear(); 
						sale_qtyalist.clear();
						sale_amtalist.clear();
						sale_wtalist.clear(); 
						pend_qtyalist.clear();
						pend_amtalist.clear();
						// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
						sheetcnt++;
						WritableSheet writableSheet3 = writableWorkbook.createSheet(Sheet_Name, sheetcnt);
					  	sb2.setLength(0);
							ps_code = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='11'");
							rs_code = ps_code.executeQuery();
							while (rs_code.next()) {
								sb2.append(rs_code.getString("SUB_GLACNO"));
							}
							
							// exec "ENGERP"."dbo"."Sel_RptDespatchPlanSaleMUTA";1 '101', '0', '101110001101110002101110003101110004101110005101110006101110007101110008101110009101110010101110011101110012101110013101110014101110015101110016101110017101110018101110019101110020101110021101110022101110023101110024101110025101110026101110027101110028101110029101110030101110031101110032101110033101110034101110035101110036101110037101110038101110039101110040101110041101110042101110043101110044101110045101110046101110047101110048101110049101110050101110051101110052101110055101110058101110059101110062101110063101110077101110081101110082101110094101110117101110129101110130101110131101110132101110135101110140101110141101110144101110148101110149101110150101110151101110160101110161101110162101110164101110165101110168101110179101110180101110181101110183101110184101110185101110186101110187101110191101110192101110193101110198101110199101110200101110202101110203101110205101110209101110210101110212101110230101110240101110247101110248101110249101110250101110251101110258101110261101110266101110269101110272101110280101110281101110282101110284101110287101110288101110291101110293101110298101110299101110300101110302101110304101110305101110307101110309101110311101110312101110313101110315101110316101110318101110322101110324101110325101110326101110327101110331101110342101110343101110344101110346101110347101110350101110353101110354101110362101110368101110369101110370101110371101110373101110374101110376101110379101110382101110383101110384101110387101110388101110389101110390101110391101110393101110394101110396101110399101110400101110402101110407101110408101110411101110418101110420101110426101110428101110442101110444101110454101110455101110460101110462101110463101110467101110469101110470101110471101110475101110476101110478101110479101110481101110483101110484101110493101110494101110495101110496101110497101110507101110508101110510101110515101110516101110517101110518101110519101110520101110523101110526101110529101110530101110539101110543101110544101110546101110547101110548101110550101110555101110556101110557101110558101110559101110561101110572' , '20170712'
							custcodes.clear();
							cs = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
							cs.setString(1, comp_id);
							cs.setString(2, "0"); 
							cs.setString(3, sb2.toString());
							cs.setString(4, sql_date);
							rs = cs.executeQuery();
							while (rs.next()) {
							custcodes.add(rs.getString("CUST_CODE"));
							} 					 
							
							hs.clear();
							hs.addAll(custcodes);
							custcodes.clear();
							custcodes.addAll(hs);  
							
							cs_prev = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
							cs_prev.setString(1, comp_id);
							cs_prev.setString(2, "0"); 
							cs_prev.setString(3, sb2.toString());
							cs_prev.setString(4, sql_date_prev);
							rs_prev=null;
							sale_qtyyes="";sale_amtyes="";tonnage_yes="";
							complSaleper=0;
							// ***************************************************************************************************************
							if (custcodes.size() > 0) {
							//***************************************************************************************************************************************************************************************************
								writableSheet3.setColumnView(0, 40);
							    writableSheet3.setColumnView(1, 12);
							    writableSheet3.setColumnView(2, 12);
							    writableSheet3.setColumnView(3, 12);
							    writableSheet3.setColumnView(4, 12);
							    writableSheet3.setColumnView(5, 12);
							    writableSheet3.setColumnView(6, 12);
							    writableSheet3.setColumnView(7, 12);
							    writableSheet3.setColumnView(8, 12);
							    writableSheet3.setColumnView(9, 12);
							    writableSheet3.setColumnView(10, 12);
							    writableSheet3.setColumnView(11, 12);
							    writableSheet3.setColumnView(12, 12);
							    writableSheet3.setColumnView(13, 12);
							    
							    writableSheet3.mergeCells(0, 2,0, 3);  
							    writableSheet3.mergeCells(1, 2,3, 2); 
							    writableSheet3.mergeCells(4, 2,6, 2);  
							    writableSheet3.mergeCells(7, 2,9, 2); 
							    writableSheet3.mergeCells(10, 2,11, 2);
							    writableSheet3.mergeCells(12,2,12,3);   
							    writableSheet3.mergeCells(13, 2,13, 3); 	
							    
							    Label label1 = new Label(0, 0, "Working Days",cellRIghtformat);
							    Label label2 = new Label(0, 1, "Days Completed",cellRIghtformat);
							    Label label3 = new Label(3, 0, "Schedule V/s Sales on " + testDate,cellRIghtformat);
							    Label label4 = new Label(1, 0, zeroDForm.format(count_mnt) , cellRIghtformat); 
							    Label label5 = new Label(1, 1, zeroDForm.format(total_dd), cellRIghtformat);
							    Label label6 = new Label(0, 2, "Name of Item",cellFormat);  
							    
							    Label label7 = new Label(1, 2, "Schedule",cellFormat);
							    Label label8 = new Label(1, 3, "Qty",cellFormat);
							    Label label9 = new Label(2, 3, "AMT",cellFormat);
							    
							    Label label10 = new Label(3, 3, "Wt. in Tons",cellFormat);
							     
							    Label label11 = new Label(4, 2, "Yesterday's Sales",cellFormat_header);
							    Label label12 = new Label(4, 3, "Qty",cellFormat);
							    Label label13 = new Label(5, 3, "AMT",cellFormat); 
							    
							    Label label14 = new Label(6, 3, "Wt. in Tons",cellFormat);
							    
							    Label label15 = new Label(7, 2, "Sales",cellFormat);		    
							    Label label16 = new Label(7, 3, "Qty",cellFormat);
							    Label label17 = new Label(8, 3, "AMT",cellFormat);
							    
							    Label label18 = new Label(9, 3, "Wt. in Tons",cellFormat);
							    
							    Label label19 = new Label(10, 2, "Pending",cellFormat);
							    Label label20 = new Label(10, 3, "Qty",cellFormat);
							    Label label21 = new Label(11, 3, "AMT",cellFormat);
							     
							    /* Label label22 = new Label(11, 2, "Wt. in Tons",cellFormat); */
							    Label label22 = new Label(12, 2, "Schedule Compliance%",cellFormat);
							     
							 writableSheet3.addCell(label1);
							 writableSheet3.addCell(label2);
							 writableSheet3.addCell(label3);					 
							 writableSheet3.addCell(label4);
							 writableSheet3.addCell(label5);
							 writableSheet3.addCell(label6);
							 writableSheet3.addCell(label7);
							 writableSheet3.addCell(label8);
							 writableSheet3.addCell(label9);
							 writableSheet3.addCell(label10);
							 writableSheet3.addCell(label11);
							 writableSheet3.addCell(label12); 
							 writableSheet3.addCell(label13); 
							 writableSheet3.addCell(label14); 
							 writableSheet3.addCell(label15); 
							 writableSheet3.addCell(label16);
							 writableSheet3.addCell(label17);
							 writableSheet3.addCell(label18);
							 writableSheet3.addCell(label19);
							 writableSheet3.addCell(label20);
							 writableSheet3.addCell(label21);
							 writableSheet3.addCell(label22); 
							}
							
							count=0;
							col=4;
							for(int i=0;i<custcodes.size();i++){
							count=0; 
							rs = cs.executeQuery(); 
							while(rs.next()){ 
								if(rs.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString())){
								if(count==0){
									Label customer = new  Label(0, col, rs.getString("CUST_NAME"),cellFormat_header);
									writableSheet3.addCell(customer);
									count ++;
									col++;
								} 
								
								rs_prev = cs_prev.executeQuery(); 
								sale_qtyyes="0";
								sale_amtyes="0";
								tonnage_yes="0";
								complSaleper=0; 
								while(rs_prev.next()){
									if(rs_prev.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString()) && 
										rs_prev.getString("MAT_CODE").equalsIgnoreCase(rs.getString("MAT_CODE"))){ 
										sale_qtyyes=rs_prev.getString("SALE_QTY");
										sale_amtyes=rs_prev.getString("SALE_AMT"); 
										tonnage_yes = rs_prev.getString("SALE_TONAGE");
									}
								} 
								 
								complSaleper =Double.parseDouble(rs.getString("SALE_QTY"))/ Double.parseDouble(rs.getString("SCH_QTY"))*100;
								
								Label matName = new  Label(0, col, rs.getString("MAT_NAME"),cellleftformat);
								writableSheet3.addCell(matName); 
								
								Number label_des_qty = new Number(1, col, Math.round(Double.parseDouble(rs.getString("SCH_QTY"))),cellRIghtformat);
								writableSheet3.addCell(label_des_qty);
								
								Number label_des_amt = new Number(2, col,  Double.parseDouble(rs.getString("SCH_AMT"))/100000,cellRIghtformat);
								writableSheet3.addCell(label_des_amt);
								 
								Number label_sch_tons = new Number(3, col, Double.parseDouble(rs.getString("SCH_TONAGE")),cellRIghtformat);
								writableSheet3.addCell(label_sch_tons);
								
								
								
								Number yes_sale_qty = new Number(4, col, Math.round(Double.parseDouble(sale_qtyyes)),cellRIghtformat);
								writableSheet3.addCell(yes_sale_qty);
								
								Number yes_sale_amt = new Number(5, col, Double.parseDouble(sale_amtyes)/100000,cellRIghtformat);
								writableSheet3.addCell(yes_sale_amt);

								Number label_saleyes_tons = new Number(6, col, Double.parseDouble(tonnage_yes),cellRIghtformat);
								writableSheet3.addCell(label_saleyes_tons);
								
								
								Number label_sale_qty = new Number(7, col,Math.round(Double.parseDouble(rs.getString("SALE_QTY"))),cellRIghtformat);
								writableSheet3.addCell(label_sale_qty);
								
								Number label_sale_amt = new Number(8, col, Double.parseDouble(rs.getString("SALE_AMT"))/100000,cellRIghtformat);
								writableSheet3.addCell(label_sale_amt);
								
								Number label_sale_tons = new Number(9, col, Double.parseDouble(rs.getString("SALE_TONAGE")),cellRIghtformat);
								writableSheet3.addCell(label_sale_tons);
								
								
								Number label_pend_qty = new Number(10, col, Math.round(Double.parseDouble(rs.getString("PEND_QTY"))),cellRIghtformat);
								writableSheet3.addCell(label_pend_qty);
								
								Number label_pend_amt = new Number(11, col, Double.parseDouble(rs.getString("PEND_AMT"))/100000,cellRIghtformat);
								writableSheet3.addCell(label_pend_amt);
								 	
								Number label_schCompl = new Number(12, col, Math.round(complSaleper),cellRIghtformat);
								writableSheet3.addCell(label_schCompl);
								
								sch_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SCH_QTY"))));
								sch_amtalist.add(Double.parseDouble(rs.getString("SCH_AMT"))/100000);
								sch_wtalist.add(Double.parseDouble(rs.getString("SCH_TONAGE")));
								yes_qtyalist.add(Math.round(Double.parseDouble(sale_qtyyes)));
								yes_amtalist.add(Double.parseDouble(sale_amtyes)/100000);
								yes_wtalist.add(Double.parseDouble(tonnage_yes));
								sale_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SALE_QTY"))));
								sale_amtalist.add(Double.parseDouble(rs.getString("SALE_AMT"))/100000);
								sale_wtalist.add(Double.parseDouble(rs.getString("SALE_TONAGE")));
								pend_qtyalist.add(Math.round(Double.parseDouble(rs.getString("PEND_QTY"))));
								pend_amtalist.add(Double.parseDouble(rs.getString("PEND_AMT"))/100000);
								
								col++;
							  }
							} 
							}
							//--------------------------------------------	
							sum = 0; 
							grd0 = new Label(0, col, "Grand Total",cellFormat);   
							writableSheet3.addCell(grd0);
							//--------------------------------------------	
							for(int i=0; i<sch_qtyalist.size(); i++){
								  sum += Double.parseDouble(sch_qtyalist.get(i).toString());
							} 
							grd1 = new Number(1, col, sum,cellRIghtformat);		
							writableSheet3.addCell(grd1);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<sch_amtalist.size(); i++){
								  sum += Double.parseDouble(sch_amtalist.get(i).toString());
							} 

							grd2 = new Number(2, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd2);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<sch_wtalist.size(); i++){
								  sum += Double.parseDouble(sch_wtalist.get(i).toString());
							} 
							grd3 = new Number(3, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd3);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<yes_qtyalist.size(); i++){
								  sum += Double.parseDouble(yes_qtyalist.get(i).toString());
							} 
							grd4 = new Number(4, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd4);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<yes_amtalist.size(); i++){
								  sum += Double.parseDouble(yes_amtalist.get(i).toString());
							}
							grd5 = new Number(5, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd5);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<yes_wtalist.size(); i++){
								  sum += Double.parseDouble(yes_wtalist.get(i).toString());
							} 
							grd6 = new Number(6, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd6);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<sale_qtyalist.size(); i++){
								  sum += Double.parseDouble(sale_qtyalist.get(i).toString());
							}
							grd7 = new Number(7, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd7);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<sale_amtalist.size(); i++){
								  sum += Double.parseDouble(sale_amtalist.get(i).toString());
							}
							grd8 = new Number(8, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd8);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<sale_wtalist.size(); i++){
								  sum += Double.parseDouble(sale_wtalist.get(i).toString());
							}
							grd9 = new Number(9, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd9);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<pend_qtyalist.size(); i++){
								  sum += Double.parseDouble(pend_qtyalist.get(i).toString());
							}
							grd10 = new Number(10, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd10);
							//--------------------------------------------
							sum=0;
							for(int i=0; i<pend_amtalist.size(); i++){
								  sum += Double.parseDouble(pend_amtalist.get(i).toString());
							}
							grd11 = new Number(11, col, sum,cellRIghtformat);
							writableSheet3.addCell(grd11);
							//--------------------------------------------
							sum=0;
							//--------------------------------------------
							grd12 = new Label(12, col, "",cellRIghtformat);
							writableSheet3.addCell(grd12);
							//--------------------------------------------  
							
							//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
							//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
							comp_id ="105";
							Sheet_Name = "DI";
							con = ConnectionUrl.getDIERPConnection();
							// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
							sch_qtyalist.clear();
							sch_amtalist.clear();
							sch_wtalist.clear(); 
							yes_qtyalist.clear();
							yes_amtalist.clear();
							yes_wtalist.clear(); 
							sale_qtyalist.clear();
							sale_amtalist.clear();
							sale_wtalist.clear(); 
							pend_qtyalist.clear();
							pend_amtalist.clear();
							// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
							sheetcnt++;
							WritableSheet writableSheet4 = writableWorkbook.createSheet(Sheet_Name, sheetcnt);
						  	sb2.setLength(0);
								ps_code = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='11'");
								rs_code = ps_code.executeQuery();
								while (rs_code.next()) {
									sb2.append(rs_code.getString("SUB_GLACNO"));
								}
								
								// exec "ENGERP"."dbo"."Sel_RptDespatchPlanSaleMUTA";1 '101', '0', '101110001101110002101110003101110004101110005101110006101110007101110008101110009101110010101110011101110012101110013101110014101110015101110016101110017101110018101110019101110020101110021101110022101110023101110024101110025101110026101110027101110028101110029101110030101110031101110032101110033101110034101110035101110036101110037101110038101110039101110040101110041101110042101110043101110044101110045101110046101110047101110048101110049101110050101110051101110052101110055101110058101110059101110062101110063101110077101110081101110082101110094101110117101110129101110130101110131101110132101110135101110140101110141101110144101110148101110149101110150101110151101110160101110161101110162101110164101110165101110168101110179101110180101110181101110183101110184101110185101110186101110187101110191101110192101110193101110198101110199101110200101110202101110203101110205101110209101110210101110212101110230101110240101110247101110248101110249101110250101110251101110258101110261101110266101110269101110272101110280101110281101110282101110284101110287101110288101110291101110293101110298101110299101110300101110302101110304101110305101110307101110309101110311101110312101110313101110315101110316101110318101110322101110324101110325101110326101110327101110331101110342101110343101110344101110346101110347101110350101110353101110354101110362101110368101110369101110370101110371101110373101110374101110376101110379101110382101110383101110384101110387101110388101110389101110390101110391101110393101110394101110396101110399101110400101110402101110407101110408101110411101110418101110420101110426101110428101110442101110444101110454101110455101110460101110462101110463101110467101110469101110470101110471101110475101110476101110478101110479101110481101110483101110484101110493101110494101110495101110496101110497101110507101110508101110510101110515101110516101110517101110518101110519101110520101110523101110526101110529101110530101110539101110543101110544101110546101110547101110548101110550101110555101110556101110557101110558101110559101110561101110572' , '20170712'
								custcodes.clear();
								cs = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
								cs.setString(1, comp_id);
								cs.setString(2, "0"); 
								cs.setString(3, sb2.toString());
								cs.setString(4, sql_date);
								rs = cs.executeQuery();
								while (rs.next()) {
								custcodes.add(rs.getString("CUST_CODE"));
								} 					 
								
								hs.clear();
								hs.addAll(custcodes);
								custcodes.clear();
								custcodes.addAll(hs);  
								
								cs_prev = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
								cs_prev.setString(1, comp_id);
								cs_prev.setString(2, "0"); 
								cs_prev.setString(3, sb2.toString());
								cs_prev.setString(4, sql_date_prev);
								rs_prev=null;
								sale_qtyyes="";sale_amtyes="";tonnage_yes="";
								complSaleper=0;
								// ***************************************************************************************************************
								if (custcodes.size() > 0) {
								//***************************************************************************************************************************************************************************************************
									writableSheet4.setColumnView(0, 40);
								    writableSheet4.setColumnView(1, 12);
								    writableSheet4.setColumnView(2, 12);
								    writableSheet4.setColumnView(3, 12);
								    writableSheet4.setColumnView(4, 12);
								    writableSheet4.setColumnView(5, 12);
								    writableSheet4.setColumnView(6, 12);
								    writableSheet4.setColumnView(7, 12);
								    writableSheet4.setColumnView(8, 12);
								    writableSheet4.setColumnView(9, 12);
								    writableSheet4.setColumnView(10, 12);
								    writableSheet4.setColumnView(11, 12);
								    writableSheet4.setColumnView(12, 12);
								    writableSheet4.setColumnView(13, 12);
								   
								    
								    
								    writableSheet4.mergeCells(0, 2,0, 3);  
								    writableSheet4.mergeCells(1, 2,3, 2); 
								    writableSheet4.mergeCells(4, 2,6, 2);  
								    writableSheet4.mergeCells(7, 2,9, 2); 
								    writableSheet4.mergeCells(10, 2,11, 2);
								    writableSheet4.mergeCells(12,2,12,3);   
								    writableSheet4.mergeCells(13, 2,13, 3); 	
								    
								    Label label1 = new Label(0, 0, "Working Days",cellRIghtformat);
								    Label label2 = new Label(0, 1, "Days Completed",cellRIghtformat);
								    Label label3 = new Label(3, 0, "Schedule V/s Sales on " + testDate,cellRIghtformat);
								    Label label4 = new Label(1, 0, zeroDForm.format(count_mnt) , cellRIghtformat); 
								    Label label5 = new Label(1, 1, zeroDForm.format(total_dd), cellRIghtformat);
								    Label label6 = new Label(0, 2, "Name of Item",cellFormat);  
								    
								    Label label7 = new Label(1, 2, "Schedule",cellFormat);
								    Label label8 = new Label(1, 3, "Qty",cellFormat);
								    Label label9 = new Label(2, 3, "AMT",cellFormat);
								    
								    Label label10 = new Label(3, 3, "Wt. in Tons",cellFormat);
								     
								    Label label11 = new Label(4, 2, "Yesterday's Sales",cellFormat_header);
								    Label label12 = new Label(4, 3, "Qty",cellFormat);
								    Label label13 = new Label(5, 3, "AMT",cellFormat); 
								    
								    Label label14 = new Label(6, 3, "Wt. in Tons",cellFormat);
								    
								    Label label15 = new Label(7, 2, "Sales",cellFormat);		    
								    Label label16 = new Label(7, 3, "Qty",cellFormat);
								    Label label17 = new Label(8, 3, "AMT",cellFormat);
								    
								    Label label18 = new Label(9, 3, "Wt. in Tons",cellFormat);
								    
								    Label label19 = new Label(10, 2, "Pending",cellFormat);
								    Label label20 = new Label(10, 3, "Qty",cellFormat);
								    Label label21 = new Label(11, 3, "AMT",cellFormat);
								     
								    /* Label label22 = new Label(11, 2, "Wt. in Tons",cellFormat); */
								    Label label22 = new Label(12, 2, "Schedule Compliance%",cellFormat);
								     
								 writableSheet4.addCell(label1);
								 writableSheet4.addCell(label2);
								 writableSheet4.addCell(label3);					 
								 writableSheet4.addCell(label4);
								 writableSheet4.addCell(label5);
								 writableSheet4.addCell(label6);
								 writableSheet4.addCell(label7);
								 writableSheet4.addCell(label8);
								 writableSheet4.addCell(label9);
								 writableSheet4.addCell(label10);
								 writableSheet4.addCell(label11);
								 writableSheet4.addCell(label12); 
								 writableSheet4.addCell(label13); 
								 writableSheet4.addCell(label14); 
								 writableSheet4.addCell(label15); 
								 writableSheet4.addCell(label16);
								 writableSheet4.addCell(label17);
								 writableSheet4.addCell(label18);
								 writableSheet4.addCell(label19);
								 writableSheet4.addCell(label20);
								 writableSheet4.addCell(label21);
								 writableSheet4.addCell(label22); 
								}
								
								count=0;
								col=4;
								for(int i=0;i<custcodes.size();i++){
								count=0; 
								rs = cs.executeQuery(); 
								while(rs.next()){ 
									if(rs.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString())){
									if(count==0){
										Label customer = new  Label(0, col, rs.getString("CUST_NAME"),cellFormat_header);
										writableSheet4.addCell(customer);
										count ++;
										col++;
									} 
									
									rs_prev = cs_prev.executeQuery(); 
									sale_qtyyes="0";
									sale_amtyes="0";
									tonnage_yes="0";
									complSaleper=0; 
									while(rs_prev.next()){
										if(rs_prev.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString()) && 
											rs_prev.getString("MAT_CODE").equalsIgnoreCase(rs.getString("MAT_CODE"))){ 
											sale_qtyyes=rs_prev.getString("SALE_QTY");
											sale_amtyes=rs_prev.getString("SALE_AMT"); 
											tonnage_yes = rs_prev.getString("SALE_TONAGE");
										}
									}
									 
									complSaleper =Double.parseDouble(rs.getString("SALE_QTY"))/ Double.parseDouble(rs.getString("SCH_QTY"))*100;
									
									Label matName = new  Label(0, col, rs.getString("MAT_NAME"),cellleftformat);
									writableSheet4.addCell(matName); 
									
									Number label_des_qty = new Number(1, col, Math.round(Double.parseDouble(rs.getString("SCH_QTY"))),cellRIghtformat);
									writableSheet4.addCell(label_des_qty);
									
									Number label_des_amt = new Number(2, col, Double.parseDouble(rs.getString("SCH_AMT"))/100000,cellRIghtformat);
									writableSheet4.addCell(label_des_amt);
									 
									Number label_sch_tons = new Number(3, col, Double.parseDouble(rs.getString("SCH_TONAGE")),cellRIghtformat);
									writableSheet4.addCell(label_sch_tons);
									 
									Number yes_sale_qty = new Number(4, col, Math.round(Double.parseDouble(sale_qtyyes)),cellRIghtformat);
									writableSheet4.addCell(yes_sale_qty);
									
									Number yes_sale_amt = new Number(5, col, Double.parseDouble(sale_amtyes)/100000,cellRIghtformat);
									writableSheet4.addCell(yes_sale_amt);

									Number label_saleyes_tons = new Number(6, col, Double.parseDouble(tonnage_yes),cellRIghtformat);
									writableSheet4.addCell(label_saleyes_tons);
									
									
									Number label_sale_qty = new Number(7, col, Math.round(Double.parseDouble(rs.getString("SALE_QTY"))),cellRIghtformat);
									writableSheet4.addCell(label_sale_qty);
									
									Number label_sale_amt = new Number(8, col, Double.parseDouble(rs.getString("SALE_AMT"))/100000,cellRIghtformat);
									writableSheet4.addCell(label_sale_amt);
									
									Number label_sale_tons = new Number(9, col, Double.parseDouble(rs.getString("SALE_TONAGE")),cellRIghtformat);
									writableSheet4.addCell(label_sale_tons);
									
									
									Number label_pend_qty = new Number(10, col, Math.round(Double.parseDouble(rs.getString("PEND_QTY"))),cellRIghtformat);
									writableSheet4.addCell(label_pend_qty);
									
									Number label_pend_amt = new Number(11, col, Double.parseDouble(rs.getString("PEND_AMT"))/100000,cellRIghtformat);
									writableSheet4.addCell(label_pend_amt);
									 	
									Number label_schCompl = new Number(12, col, Math.round(complSaleper),cellRIghtformat);
									writableSheet4.addCell(label_schCompl);
									
									sch_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SCH_QTY"))));
									sch_amtalist.add(Double.parseDouble(rs.getString("SCH_AMT"))/100000);
									sch_wtalist.add(Double.parseDouble(rs.getString("SCH_TONAGE")));
									yes_qtyalist.add(Math.round(Double.parseDouble(sale_qtyyes)));
									yes_amtalist.add(Double.parseDouble(sale_amtyes)/100000);
									yes_wtalist.add(Double.parseDouble(tonnage_yes));
									sale_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SALE_QTY"))));
									sale_amtalist.add(Double.parseDouble(rs.getString("SALE_AMT"))/100000);
									sale_wtalist.add(Double.parseDouble(rs.getString("SALE_TONAGE")));
									pend_qtyalist.add(Math.round(Double.parseDouble(rs.getString("PEND_QTY"))));
									pend_amtalist.add(Double.parseDouble(rs.getString("PEND_AMT"))/100000);
									
									col++;
								  }
								} 
								}
								//--------------------------------------------	
								sum = 0; 
								grd0 = new Label(0, col, "Grand Total",cellFormat);   
								writableSheet4.addCell(grd0);
								//--------------------------------------------	
								for(int i=0; i<sch_qtyalist.size(); i++){
									  sum += Double.parseDouble(sch_qtyalist.get(i).toString());
								} 
								grd1 = new Number(1, col, sum,cellRIghtformat);		
								writableSheet4.addCell(grd1);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<sch_amtalist.size(); i++){
									  sum += Double.parseDouble(sch_amtalist.get(i).toString());
								} 

								grd2 = new Number(2, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd2);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<sch_wtalist.size(); i++){
									  sum += Double.parseDouble(sch_wtalist.get(i).toString());
								} 
								grd3 = new Number(3, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd3);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<yes_qtyalist.size(); i++){
									  sum += Double.parseDouble(yes_qtyalist.get(i).toString());
								} 
								grd4 = new Number(4, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd4);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<yes_amtalist.size(); i++){
									  sum += Double.parseDouble(yes_amtalist.get(i).toString());
								}
								grd5 = new Number(5, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd5);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<yes_wtalist.size(); i++){
									  sum += Double.parseDouble(yes_wtalist.get(i).toString());
								} 
								grd6 = new Number(6, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd6);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<sale_qtyalist.size(); i++){
									  sum += Double.parseDouble(sale_qtyalist.get(i).toString());
								}
								grd7 = new Number(7, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd7);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<sale_amtalist.size(); i++){
									  sum += Double.parseDouble(sale_amtalist.get(i).toString());
								}
								grd8 = new Number(8, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd8);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<sale_wtalist.size(); i++){
									  sum += Double.parseDouble(sale_wtalist.get(i).toString());
								}
								grd9 = new Number(9, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd9);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<pend_qtyalist.size(); i++){
									  sum += Double.parseDouble(pend_qtyalist.get(i).toString());
								}
								grd10 = new Number(10, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd10);
								//--------------------------------------------
								sum=0;
								for(int i=0; i<pend_amtalist.size(); i++){
									  sum += Double.parseDouble(pend_amtalist.get(i).toString());
								}
								grd11 = new Number(11, col, sum,cellRIghtformat);
								writableSheet4.addCell(grd11);
								//--------------------------------------------
								sum=0;
								//--------------------------------------------
								grd12 = new Label(12, col, "",cellRIghtformat);
								writableSheet4.addCell(grd12);
								//--------------------------------------------  
								//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
								//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
								comp_id ="106";
								Sheet_Name = "MEPL Unit III";
								con = ConnectionUrl.getK1ERPConnection();
								// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
								sch_qtyalist.clear();
								sch_amtalist.clear();
								sch_wtalist.clear(); 
								yes_qtyalist.clear();
								yes_amtalist.clear();
								yes_wtalist.clear(); 
								sale_qtyalist.clear();
								sale_amtalist.clear();
								sale_wtalist.clear(); 
								pend_qtyalist.clear();
								pend_amtalist.clear();
								// -------------------------------------------------------------------------------------------------------------------------------------------------------------------
								sheetcnt++;
								WritableSheet writableSheet5 = writableWorkbook.createSheet(Sheet_Name, sheetcnt);
							  	sb2.setLength(0);
									ps_code = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='11'");
									rs_code = ps_code.executeQuery();
									while (rs_code.next()) {
										sb2.append(rs_code.getString("SUB_GLACNO"));
									}
									
									// exec "ENGERP"."dbo"."Sel_RptDespatchPlanSaleMUTA";1 '101', '0', '101110001101110002101110003101110004101110005101110006101110007101110008101110009101110010101110011101110012101110013101110014101110015101110016101110017101110018101110019101110020101110021101110022101110023101110024101110025101110026101110027101110028101110029101110030101110031101110032101110033101110034101110035101110036101110037101110038101110039101110040101110041101110042101110043101110044101110045101110046101110047101110048101110049101110050101110051101110052101110055101110058101110059101110062101110063101110077101110081101110082101110094101110117101110129101110130101110131101110132101110135101110140101110141101110144101110148101110149101110150101110151101110160101110161101110162101110164101110165101110168101110179101110180101110181101110183101110184101110185101110186101110187101110191101110192101110193101110198101110199101110200101110202101110203101110205101110209101110210101110212101110230101110240101110247101110248101110249101110250101110251101110258101110261101110266101110269101110272101110280101110281101110282101110284101110287101110288101110291101110293101110298101110299101110300101110302101110304101110305101110307101110309101110311101110312101110313101110315101110316101110318101110322101110324101110325101110326101110327101110331101110342101110343101110344101110346101110347101110350101110353101110354101110362101110368101110369101110370101110371101110373101110374101110376101110379101110382101110383101110384101110387101110388101110389101110390101110391101110393101110394101110396101110399101110400101110402101110407101110408101110411101110418101110420101110426101110428101110442101110444101110454101110455101110460101110462101110463101110467101110469101110470101110471101110475101110476101110478101110479101110481101110483101110484101110493101110494101110495101110496101110497101110507101110508101110510101110515101110516101110517101110518101110519101110520101110523101110526101110529101110530101110539101110543101110544101110546101110547101110548101110550101110555101110556101110557101110558101110559101110561101110572' , '20170712'
									custcodes.clear();
									cs = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
									cs.setString(1, comp_id);
									cs.setString(2, "0"); 
									cs.setString(3, sb2.toString());
									cs.setString(4, sql_date);
									rs = cs.executeQuery();
									while (rs.next()) {
									custcodes.add(rs.getString("CUST_CODE"));
									} 					 
									
									hs.clear();
									hs.addAll(custcodes);
									custcodes.clear();
									custcodes.addAll(hs);  
									
									cs_prev = con.prepareCall("{call Sel_RptDespatchPlanSaleMUTA(?,?,?,?)}");
									cs_prev.setString(1, comp_id);
									cs_prev.setString(2, "0"); 
									cs_prev.setString(3, sb2.toString());
									cs_prev.setString(4, sql_date_prev);
									rs_prev=null;
									sale_qtyyes="";sale_amtyes="";tonnage_yes="";
									complSaleper=0;
									// ***************************************************************************************************************
									if (custcodes.size() > 0) {
									//***************************************************************************************************************************************************************************************************
										writableSheet5.setColumnView(0, 40);
									    writableSheet5.setColumnView(1, 12);
									    writableSheet5.setColumnView(2, 12);
									    writableSheet5.setColumnView(3, 12);
									    writableSheet5.setColumnView(4, 12);
									    writableSheet5.setColumnView(5, 12);
									    writableSheet5.setColumnView(6, 12);
									    writableSheet5.setColumnView(7, 12);
									    writableSheet5.setColumnView(8, 12);
									    writableSheet5.setColumnView(9, 12);
									    writableSheet5.setColumnView(10, 12);
									    writableSheet5.setColumnView(11, 12);
									    writableSheet5.setColumnView(12, 12);
									    writableSheet5.setColumnView(13, 12);
									    
									    writableSheet5.mergeCells(0, 2,0, 3);  
									    writableSheet5.mergeCells(1, 2,3, 2); 
									    writableSheet5.mergeCells(4, 2,6, 2);  
									    writableSheet5.mergeCells(7, 2,9, 2); 
									    writableSheet5.mergeCells(10, 2,11, 2);
									    writableSheet5.mergeCells(12,2,12,3);   
									    writableSheet5.mergeCells(13, 2,13, 3); 	
									    
									    Label label1 = new Label(0, 0, "Working Days",cellRIghtformat);
									    Label label2 = new Label(0, 1, "Days Completed",cellRIghtformat);
									    Label label3 = new Label(3, 0, "Schedule V/s Sales on " + testDate,cellRIghtformat);
									    Label label4 = new Label(1, 0, zeroDForm.format(count_mnt) , cellRIghtformat); 
									    Label label5 = new Label(1, 1, zeroDForm.format(total_dd), cellRIghtformat);
									    Label label6 = new Label(0, 2, "Name of Item",cellFormat);  
									    
									    Label label7 = new Label(1, 2, "Schedule",cellFormat);
									    Label label8 = new Label(1, 3, "Qty",cellFormat);
									    Label label9 = new Label(2, 3, "AMT",cellFormat);
									    
									    Label label10 = new Label(3, 3, "Wt. in Tons",cellFormat);
									     
									    Label label11 = new Label(4, 2, "Yesterday's Sales",cellFormat_header);
									    Label label12 = new Label(4, 3, "Qty",cellFormat);
									    Label label13 = new Label(5, 3, "AMT",cellFormat); 
									    
									    Label label14 = new Label(6, 3, "Wt. in Tons",cellFormat);
									    
									    Label label15 = new Label(7, 2, "Sales",cellFormat);		    
									    Label label16 = new Label(7, 3, "Qty",cellFormat);
									    Label label17 = new Label(8, 3, "AMT",cellFormat);
									    
									    Label label18 = new Label(9, 3, "Wt. in Tons",cellFormat);
									    
									    Label label19 = new Label(10, 2, "Pending",cellFormat);
									    Label label20 = new Label(10, 3, "Qty",cellFormat);
									    Label label21 = new Label(11, 3, "AMT",cellFormat);
									     
									    /* Label label22 = new Label(11, 2, "Wt. in Tons",cellFormat); */
									    Label label22 = new Label(12, 2, "Schedule Compliance%",cellFormat);
									     
									 writableSheet5.addCell(label1);
									 writableSheet5.addCell(label2);
									 writableSheet5.addCell(label3);					 
									 writableSheet5.addCell(label4);
									 writableSheet5.addCell(label5);
									 writableSheet5.addCell(label6);
									 writableSheet5.addCell(label7);
									 writableSheet5.addCell(label8);
									 writableSheet5.addCell(label9);
									 writableSheet5.addCell(label10);
									 writableSheet5.addCell(label11);
									 writableSheet5.addCell(label12); 
									 writableSheet5.addCell(label13); 
									 writableSheet5.addCell(label14); 
									 writableSheet5.addCell(label15); 
									 writableSheet5.addCell(label16);
									 writableSheet5.addCell(label17);
									 writableSheet5.addCell(label18);
									 writableSheet5.addCell(label19);
									 writableSheet5.addCell(label20);
									 writableSheet5.addCell(label21);
									 writableSheet5.addCell(label22); 
									}
									
									count=0;
									col=4;
									for(int i=0;i<custcodes.size();i++){
									count=0; 
									rs = cs.executeQuery(); 
									while(rs.next()){ 
										if(rs.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString())){
										if(count==0){
											Label customer = new  Label(0, col, rs.getString("CUST_NAME"),cellFormat_header);
											writableSheet5.addCell(customer);
											count ++;
											col++;
										} 
										
										rs_prev = cs_prev.executeQuery(); 
										sale_qtyyes="0";
										sale_amtyes="0";
										tonnage_yes="0";
										complSaleper=0; 
										while(rs_prev.next()){
											if(rs_prev.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString()) && 
												rs_prev.getString("MAT_CODE").equalsIgnoreCase(rs.getString("MAT_CODE"))){ 
												sale_qtyyes=rs_prev.getString("SALE_QTY");
												sale_amtyes=rs_prev.getString("SALE_AMT"); 
												tonnage_yes = rs_prev.getString("SALE_TONAGE");
											}
										} 
										 
										complSaleper =Double.parseDouble(rs.getString("SALE_QTY"))/ Double.parseDouble(rs.getString("SCH_QTY"))*100;
										
										Label matName = new  Label(0, col, rs.getString("MAT_NAME"),cellleftformat);
										writableSheet5.addCell(matName); 
										
										Number label_des_qty = new Number(1, col, Math.round(Double.parseDouble(rs.getString("SCH_QTY"))),cellRIghtformat);
										writableSheet5.addCell(label_des_qty);
										
										Number label_des_amt = new Number(2, col, Double.parseDouble(rs.getString("SCH_AMT"))/100000,cellRIghtformat);
										writableSheet5.addCell(label_des_amt);
										 
										Number label_sch_tons = new Number(3, col, Double.parseDouble(rs.getString("SCH_TONAGE")),cellRIghtformat);
										writableSheet5.addCell(label_sch_tons);
										 
										Number yes_sale_qty = new Number(4, col, Math.round(Double.parseDouble(sale_qtyyes)),cellRIghtformat);
										writableSheet5.addCell(yes_sale_qty);
										
										Number yes_sale_amt = new Number(5, col, Double.parseDouble(sale_amtyes)/100000,cellRIghtformat);
										writableSheet5.addCell(yes_sale_amt);

										Number label_saleyes_tons = new Number(6, col, Double.parseDouble(tonnage_yes),cellRIghtformat);
										writableSheet5.addCell(label_saleyes_tons);
										
										
										Number label_sale_qty = new Number(7, col, Math.round(Double.parseDouble(rs.getString("SALE_QTY"))),cellRIghtformat);
										writableSheet5.addCell(label_sale_qty);
										
										Number label_sale_amt = new Number(8, col, Double.parseDouble(rs.getString("SALE_AMT"))/100000,cellRIghtformat);
										writableSheet5.addCell(label_sale_amt);
										
										Number label_sale_tons = new Number(9, col, Double.parseDouble(rs.getString("SALE_TONAGE")),cellRIghtformat);
										writableSheet5.addCell(label_sale_tons);
										
										Number label_pend_qty = new Number(10, col, Math.round(Double.parseDouble(rs.getString("PEND_QTY"))),cellRIghtformat);
										writableSheet5.addCell(label_pend_qty);
										
										Number label_pend_amt = new Number(11, col,Double.parseDouble(rs.getString("PEND_AMT"))/100000,cellRIghtformat);
										writableSheet5.addCell(label_pend_amt);
										 	
										Number label_schCompl = new Number(12, col, Math.round(complSaleper),cellRIghtformat);
										writableSheet5.addCell(label_schCompl);		
										
										sch_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SCH_QTY"))));
										sch_amtalist.add(Double.parseDouble(rs.getString("SCH_AMT"))/100000);
										sch_wtalist.add(Double.parseDouble(rs.getString("SCH_TONAGE")));
										yes_qtyalist.add(Math.round(Double.parseDouble(sale_qtyyes)));
										yes_amtalist.add(Double.parseDouble(sale_amtyes)/100000);
										yes_wtalist.add(Double.parseDouble(tonnage_yes));
										sale_qtyalist.add(Math.round(Double.parseDouble(rs.getString("SALE_QTY"))));
										sale_amtalist.add(Double.parseDouble(rs.getString("SALE_AMT"))/100000);
										sale_wtalist.add(Double.parseDouble(rs.getString("SALE_TONAGE")));
										pend_qtyalist.add(Math.round(Double.parseDouble(rs.getString("PEND_QTY"))));
										pend_amtalist.add(Double.parseDouble(rs.getString("PEND_AMT"))/100000);
										
										col++;
										
									 }
									}
									}
									//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
						
									//--------------------------------------------	
									sum = 0; 
									grd0 = new Label(0, col, "Grand Total",cellFormat);   
									writableSheet5.addCell(grd0);
									//--------------------------------------------	
									for(int i=0; i<sch_qtyalist.size(); i++){
										  sum += Double.parseDouble(sch_qtyalist.get(i).toString());
									} 
									grd1 = new Number(1, col, sum,cellRIghtformat);		
									writableSheet5.addCell(grd1);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<sch_amtalist.size(); i++){
										  sum += Double.parseDouble(sch_amtalist.get(i).toString());
									} 

									grd2 = new Number(2, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd2);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<sch_wtalist.size(); i++){
										  sum += Double.parseDouble(sch_wtalist.get(i).toString());
									} 
									grd3 = new Number(3, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd3);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<yes_qtyalist.size(); i++){
										  sum += Double.parseDouble(yes_qtyalist.get(i).toString());
									} 
									grd4 = new Number(4, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd4);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<yes_amtalist.size(); i++){
										  sum += Double.parseDouble(yes_amtalist.get(i).toString());
									}
									grd5 = new Number(5, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd5);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<yes_wtalist.size(); i++){
										  sum += Double.parseDouble(yes_wtalist.get(i).toString());
									} 
									grd6 = new Number(6, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd6);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<sale_qtyalist.size(); i++){
										  sum += Double.parseDouble(sale_qtyalist.get(i).toString());
									}
									grd7 = new Number(7, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd7);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<sale_amtalist.size(); i++){
										  sum += Double.parseDouble(sale_amtalist.get(i).toString());
									}
									grd8 = new Number(8, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd8);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<sale_wtalist.size(); i++){
										  sum += Double.parseDouble(sale_wtalist.get(i).toString());
									}
									grd9 = new Number(9, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd9);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<pend_qtyalist.size(); i++){
										  sum += Double.parseDouble(pend_qtyalist.get(i).toString());
									}
									grd10 = new Number(10, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd10);
									//--------------------------------------------
									sum=0;
									for(int i=0; i<pend_amtalist.size(); i++){
										  sum += Double.parseDouble(pend_amtalist.get(i).toString());
									}
									grd11 = new Number(11, col, sum,cellRIghtformat);
									writableSheet5.addCell(grd11);
									//--------------------------------------------
									sum=0;
									//--------------------------------------------
									grd12 = new Label(12, col, "",cellRIghtformat);
									writableSheet5.addCell(grd12);
									//--------------------------------------------  
					
					
					
					
					
					
					
					
					
					
					 // ***************************************************************************************************************************************************************************************************
					    writableWorkbook.write();
					    writableWorkbook.close();
					//***************************************************************************************************************************************************************************************************
					//												<======= End Excel Logic 
					//***************************************************************************************************************************************************************************************************
				System.out.println("Shedule Mailer Start");
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
		 		String from = "itsupports@muthagroup.com";
				String subject = "Schedule V/s Sales Report  "+ todays_date;
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
				
				/*String recipients[] = {"nandkumar@muthagroup.com","h25supervisor@muthagroup.com","asshete@muthagroup.com","arif@muthagroup.com","dmvhankade@muthagroup.com","ankatariya@muthagroup.com","vmjoshi@muthagroup.com","meplunit3production@muthagroup.com" ,"pdpatil@muthagroup.com","jangam@muthagroup.com","sunilpb@muthagroup.com","takalena@muthagroup.com","brchourasiya@muthagroup.com","anoop@muthagroup.com","marketing@muthagroup.com","parikshitap@muthagroup.com","nrfirodia@muthagroup.com","kunalvm@muthagroup.com" ,"vahalkar@muthagroup.com","asbe@muthagroup.com","sanjay@muthagroup.com","prbhosale@muthagroup.com","prmallewadikar@muthagroup.com","kamlesh@muthagroup.com","gdc@muthagroup.com","srpatekar@muthagroup.com","jbaphna@muthagroup.com","ssgare@muthagroup.com","vvsamant@muthagroup.com","jginamdar@muthagroup.com","vishal@muthagroup.com","unpatil@muthagroup.com","ppch21@muthagroup.com"};
				String cc_recipients[] = {"nileshss@muthagroup.com"};*/
				
				ArrayList listemailTo = new ArrayList();
				String report = "DayWiseDispatchSchedule";
				Connection conMailer = ConnectionUrl.getLocalDatabase();
				PreparedStatement psauto = conMailer.prepareStatement("select * from pending_approvee where report='"+report+"'");
				ResultSet rsauto = psauto.executeQuery();
				while (rsauto.next()) {
						listemailTo.add(rsauto.getString("email"));
				}
				
				String recipients[] = new String[listemailTo.size()];
				for(int i=0;i<listemailTo.size();i++){
					recipients[i] = listemailTo.get(i).toString();
				}
				
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

				msg.setRecipients(Message.RecipientType.TO, addressTo); 

				msg.setSubject(subject);
				msg.setSentDate(new Date());
				 
				
				StringBuilder sb = new StringBuilder();
				
				//*******************************************************************************************************************************
				sb.append("<p style='color: #0D265E; font-family: Arial; font-size: 11px;'>*** This is an automatically generated email for Schedule V/s Sales Report ***</p>"+ 
						"<p><b>Please find below attached Schedule V/s Sales Report on "+ todays_date+"</p>");				 
	sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
			"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");
	
	con.close();
	conlocal.close();
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
	transport.close();
	// System.out.println("Data file sent to host....");
	// ********************************************************************************************************************
			System.out.println("Shedule Mailer End");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("Schedule Report Loop END");

	}

}
