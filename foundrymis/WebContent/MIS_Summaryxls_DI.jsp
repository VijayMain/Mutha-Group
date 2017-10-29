<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.security.AllPermission"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="jxl.format.BoldStyle"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.format.Colour"%> 
<%@page import="jxl.format.UnderlineStyle"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.write.WritableCell"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="jxl.write.Number"%>
<%@page import="java.util.Date"%>
<%@page import="jxl.write.Boolean"%>
<%@page import="jxl.write.DateTime"%>
<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.File"%>
<html>
<head>
<title>AJAX EXCEL</title>
</head>
<body> 
<%
try {
	String comp =request.getParameter("comp");
	String OnDateMIS =request.getParameter("OnDateMIS"); 
	String db =request.getParameter("db");
	
	System.out.println("data = " + comp + OnDateMIS + db);
	
	Connection con = null;
	String CompanyName="",maindb="";

	if(comp.equalsIgnoreCase("103")){
		con = ConnectionUrl.getFoundryFMShopConnection(); 
		maindb = "FOUNDRYERP";
		CompanyName = "MUTHA FOUNDERS";
	}
	if(comp.equalsIgnoreCase("105")){
		con = ConnectionUrl.getDIFMShopConnection(); 
		maindb = "DIERP";
		CompanyName = "DHANASHREE INDUSTRIES";
	}
	if(comp.equalsIgnoreCase("106")){
		con = ConnectionUrl.getK1FMShopConnection(); 
		maindb = "K1ERP";
		CompanyName = "MUTHA ENGINEERING UNIT III ";
	} 
	int j=10;
	String OnDate = OnDateMIS.substring(6,8) +"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);
	String batchonDate = "01"+"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);
	String bdateto = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+OnDateMIS.substring(6,8);
	String bdatefrom = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+"01";
			//***************************************************************************************************************
			//***************************************************************************************************************
			String testDate = OnDateMIS.substring(6,8) +"-"+ OnDateMIS.substring(4,6) +"-"+ OnDateMIS.substring(0,4); 
			String from_date = OnDateMIS.substring(0,4) + OnDateMIS.substring(4,6) +"01"; 
			DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			Date today = formatter.parse(testDate); 
	        Calendar calendar = Calendar.getInstance();  
	        calendar.setTime(today); 
	        calendar.add(Calendar.MONTH, 1);  
	        calendar.set(Calendar.DAY_OF_MONTH, 1);  
	        calendar.add(Calendar.DATE, -1); 
	        Date lastDayOfMonth = calendar.getTime(); 
	//****************************************************************************************************************************************
	double avg2=0;
Connection conlocal = ConnectionUrl.getLocalDatabase();
Calendar calAvg = Calendar.getInstance();
int month = Integer.parseInt(OnDateMIS.substring(4,6));
				int total_dd = 0;
				int holliday = 0;
				Date datesq = new Date(); 
				int day = Integer.parseInt(OnDateMIS.substring(6,8));
				PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where month="+month+" and day<"+day);
				ResultSet rs_week = ps_week.executeQuery();
				while (rs_week.next()) {
					holliday = Integer.parseInt(rs_week.getString("count(*)"));
				}
				
				PreparedStatement ps_holli = conlocal.prepareStatement("select * from montlyweekdays_tbl where day="+day+" and month="+month);
				ResultSet rs_holli = ps_holli.executeQuery();
				while (rs_holli.next()) { 
					System.out.println("Its a holliday !!!");
				}				
				
				int dd =  today.getDate(); 
				int tues=0;
				for(int i = 1 ; i < dd ; i++)
				{      
					calAvg.set(Calendar.DAY_OF_MONTH, i);
				    if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
				    	tues++;      
				    }
				}
				System.out.println("month  tues "+ tues +"\t"+ dd);
				int workdays = dd-tues; 
				
				total_dd = workdays;
				
				System.out.println("total_dd  =====================>  "+ total_dd);
				
				workdays = total_dd - holliday;
				
				System.out.println("Holliday = "+holliday);
				System.out.println("total_dd afer =====================>  "+ workdays);
				// ***************************************************************************************************************
				int space = 0; 	
				PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month="+month);
				ResultSet rs_allHol = ps_allHol.executeQuery();
				while (rs_allHol.next()) {
					System.out.println(rs_allHol.getString("count(montlyWeekdays_id)"));
					space = Integer.parseInt(rs_allHol.getString("count(montlyWeekdays_id)"));
				}
				
				int count_mnt = lastDayOfMonth.getDate();
				
				int tue_month=0;
				for(int i = 1 ; i < count_mnt ; i++)
				{      
					calAvg.set(Calendar.DAY_OF_MONTH, i);
				    if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
				    	tue_month++;      
				    }
				}

				count_mnt = count_mnt - tue_month;
				System.out.println("Space = " + space);
				System.out.println("Tuesday before = " + count_mnt);
				count_mnt = count_mnt - space;
				System.out.println("Tuesday = " + count_mnt);
				total_dd = count_mnt; 
				// ***************************************************************************************************************

	
	 DecimalFormat zeroDForm = new DecimalFormat("##0.00");
	 double total1=0,total2=0;
	 double yield1 =0,yield2=0,yield=0,yieldtt1 =0,yieldtt2=0,yieldtt=0;
	 
		ArrayList cast=new ArrayList();
		ArrayList al=new ArrayList();
		ArrayList head=new ArrayList();
		
		double inh_rej_total1 = 0,inh_rej_total2 = 0;
		double inh_rej_total11 = 0,inh_rej_total22 = 0;
		
		double cust_rej_total1 = 0,cust_rej_total2 = 0;
		double cust_rej_total12 = 0,cust_rej_total22 = 0;
		
		head.add("TOTAL MELTING , MT");
		head.add("TOTAL PROD, MT");
		head.add("YIELD, %");
		head.add("INHOUSE REJ, MT");
		head.add("GOOD PROD, MT");
		head.add("SALES, MT");
		head.add("CUSTOMER RETURNS, MT");
		head.add("INHOUSE REJ %");
		head.add("CUSTOMER RET, %");
		head.add("SALES, Rs Lacs"); 

		
		CallableStatement cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		cs.setString(1, comp);
		cs.setString(2, OnDateMIS);
		cs.setString(3, db); 
		ResultSet rs1 = cs.executeQuery(); 
		while(rs1.next()){
			if(rs1.getString("GRADE").equalsIgnoreCase("104")){
				al.add(rs1.getString("OD_TOTAL_MELTING"));
				al.add(rs1.getString("OD_TOTAL_PROD"));
				al.add(rs1.getString("OD_YIELD"));
				al.add(rs1.getString("OD_REJ_QTY"));
				al.add(rs1.getString("OD_GOOD_PROD"));
				al.add(rs1.getString("OD_DESP_QTY"));
				al.add(rs1.getString("OD_CUST_RTN"));
				al.add(rs1.getString("OD_REJ_PER"));
				al.add(rs1.getString("OD_CUST_RTN_PER"));
				al.add(rs1.getString("OD_DESP_AMT"));
				al.add(rs1.getString("TD_TOTAL_MELTING"));
				al.add(rs1.getString("TD_TOTAL_PROD"));
				al.add(rs1.getString("TD_YIELD"));
				al.add(rs1.getString("TD_REJ_QTY"));
				al.add(rs1.getString("TD_GOOD_PROD"));
				al.add(rs1.getString("TD_DESP_QTY"));
				al.add(rs1.getString("TD_CUST_RTN"));
				al.add(rs1.getString("TD_REJ_PER"));
				al.add(rs1.getString("TD_CUST_RTN_PER"));
				al.add(rs1.getString("TD_DESP_AMT"));
			}    
			if(rs1.getString("GRADE").equalsIgnoreCase("102")){
				cast.add(rs1.getString("OD_TOTAL_MELTING"));
				cast.add(rs1.getString("OD_TOTAL_PROD"));
				cast.add(rs1.getString("OD_YIELD"));
				cast.add(rs1.getString("OD_REJ_QTY"));
				cast.add(rs1.getString("OD_GOOD_PROD"));
				cast.add(rs1.getString("OD_DESP_QTY"));
				cast.add(rs1.getString("OD_CUST_RTN"));
				cast.add(rs1.getString("OD_REJ_PER"));
				cast.add(rs1.getString("OD_CUST_RTN_PER"));
				cast.add(rs1.getString("OD_DESP_AMT"));
				cast.add(rs1.getString("TD_TOTAL_MELTING"));
				cast.add(rs1.getString("TD_TOTAL_PROD"));
				cast.add(rs1.getString("TD_YIELD"));
				cast.add(rs1.getString("TD_REJ_QTY"));
				cast.add(rs1.getString("TD_GOOD_PROD"));
				cast.add(rs1.getString("TD_DESP_QTY"));
				cast.add(rs1.getString("TD_CUST_RTN"));
				cast.add(rs1.getString("TD_REJ_PER"));
				cast.add(rs1.getString("TD_CUST_RTN_PER"));
				cast.add(rs1.getString("TD_DESP_AMT"));
			}
		}
		
	//****************************************************************************************************************************************
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	int val = listOfFiles.length + 1;

	File exlFile = new File("C:/reportxls/FoundryMIS"+val+".xls");
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

	Colour backHcolor = Colour.GRAY_25;
	WritableCellFormat cellFormat_header = new WritableCellFormat();
	// cellFormat_header.setBackground(backHcolor);
	cellFormat_header.setAlignment(Alignment.CENTRE); 
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
	WritableSheet writableSheet = writableWorkbook.createSheet("TestSheet", 1);

	writableSheet.setColumnView(0, 20);
	writableSheet.setColumnView(1, 10);
	writableSheet.setColumnView(2, 10);
	writableSheet.setColumnView(3, 10);
	writableSheet.setColumnView(4, 10);
	writableSheet.setColumnView(5, 10);
	writableSheet.setColumnView(6, 10);
	writableSheet.setColumnView(7, 10);
	writableSheet.setColumnView(9, 18);
	writableSheet.setColumnView(10, 10);
	writableSheet.setColumnView(11, 15);
	writableSheet.setColumnView(12, 12);
	writableSheet.setColumnView(13, 10);
	writableSheet.setColumnView(14, 10);
	writableSheet.setColumnView(15, 10);

	writableSheet.mergeCells(0, 0,13, 0);
	//  Cell rows 0,1
	writableSheet.mergeCells(0, 1,0, 2);
	writableSheet.mergeCells(1, 1,3, 1);
	writableSheet.mergeCells(2, 1,0, 1);
	writableSheet.mergeCells(3, 1,0, 1);
	writableSheet.mergeCells(4, 1,6, 1);
	writableSheet.mergeCells(5, 1,0, 1);
	writableSheet.mergeCells(6, 1,0, 1);
	writableSheet.mergeCells(7, 1,0, 2);
	writableSheet.mergeCells(9, 1,11, 1);

	Label ReportName = new Label(0, 0, CompanyName + " MIS Summary Report " + OnDate + "       (Total Working Days : " + count_mnt + " and Working Days Over : " + workdays + ")",cellFormat_header);
	writableSheet.addCell(ReportName);
	Label label3 = new Label(0, 1, "Head",cellFormat);
	Label label4 = new Label(1, 1, "On Date",cellFormat);
	Label label5 = new Label(1, 2, "CI",cellFormat);
	Label label6 = new Label(2, 2, "Aluminum",cellFormat);
	Label lab6 = new Label(3, 2, "Total",cellFormat);
	Label label7 = new Label(4, 1, "To Date",cellFormat);
	Label label8 = new Label(4, 2, "CI",cellFormat);
	Label label9 = new Label(5, 2, "Aluminum",cellFormat);
	Label lab9 = new Label(6, 2, "Total",cellFormat);
	Label label13 = new Label(7, 1, "Average",cellFormat);
	   // -----------------------------------------------------------------------------------------------------------------------
	   writableSheet.addCell(label3);
	   writableSheet.addCell(label4);
	   writableSheet.addCell(label5);
	   writableSheet.addCell(label6);
	   writableSheet.addCell(lab6);
	   writableSheet.addCell(label7);
	   writableSheet.addCell(label8);
	   writableSheet.addCell(label9);
	   writableSheet.addCell(lab9);
	   writableSheet.addCell(label13);    
	   // -------------------------------------------------------------------------------------------------------------
	int l=0,r=3;
	for(int i=0;i<10;i++){
		   Label la0 = new Label(l, r, head.get(i).toString(),cellRIghtformat);
		   l++;
		   Label la1 = new Label(l, r, cast.get(i).toString(),cellRIghtformat);
		   l++;
		   Label la2 = new Label(l, r, al.get(i).toString(),cellRIghtformat);
		   l++; 
		   writableSheet.addCell(la0);
		   writableSheet.addCell(la1);
		   writableSheet.addCell(la2);
			//System.out.println("Header = " + i + "  " +head.get(i).toString());
			total1 = Double.parseDouble(cast.get(i).toString()) + Double.parseDouble(al.get(i).toString());
			total2 = Double.parseDouble(cast.get(j).toString()) + Double.parseDouble(al.get(j).toString());
			
			if(head.get(i).toString().equalsIgnoreCase("INHOUSE REJ, MT")){
				inh_rej_total1 = total1;
				inh_rej_total2 = total2;
			//	System.out.println("data = " + inh_rej_total1 + " = " + inh_rej_total2);
			}
			if(head.get(i).toString().equalsIgnoreCase("TOTAL PROD, MT")){
				inh_rej_total11 = total1;
				inh_rej_total22 = total2;
				
			}
			
			if(head.get(i).toString().equalsIgnoreCase("INHOUSE REJ %")){ 
				total1 = (inh_rej_total1/inh_rej_total11)*100;
				total2 = (inh_rej_total2/inh_rej_total22)*100; 
			}					
			
			if(head.get(i).toString().equalsIgnoreCase("CUSTOMER RETURNS, MT")){
				cust_rej_total1 = total1;
				cust_rej_total2 = total2;
			//	System.out.println("one = " + cust_rej_total1 + " = " +cust_rej_total2);
			}
			if(head.get(i).toString().equalsIgnoreCase("SALES, MT")){
				cust_rej_total12 = total1;
				cust_rej_total22 = total2;
			//	System.out.println("Two = " + cust_rej_total12 + " = " +cust_rej_total22);
			}
			if(head.get(i).toString().equalsIgnoreCase("CUSTOMER RET, %")){
				total2 = (cust_rej_total2/cust_rej_total22)*100;
				total1 = (cust_rej_total1/cust_rej_total12)*100;
			}
			
			if(i==0){
				yield1 = total1;
				yieldtt1 = total2;
			}
			if(i==1){
				yield2 = total1;
				yieldtt2 = total2;
			}
			if(i==2){
				yield = yield2/yield1*100;
				yieldtt = yieldtt2/yieldtt1*100;				
				Label la3 = new Label(l, r, zeroDForm.format(yield),cellRIghtformat);
				   l++;
				   Label la4 = new Label(l, r, cast.get(j).toString(),cellRIghtformat);
				   l++;
				   Label la5 = new Label(l, r, al.get(j).toString(),cellRIghtformat);
				   l++;
				   Label la6 = new Label(l, r, zeroDForm.format(yieldtt),cellRIghtformat);
				   writableSheet.addCell(la3);
				   writableSheet.addCell(la4);
				   writableSheet.addCell(la5);
				   writableSheet.addCell(la6); 
			yield1=0;yield2=0;yield=0;
			}
			if(i!=2){
				
				Label la3 = new Label(l, r, zeroDForm.format(total1),cellRIghtformat);
				   l++;
				   Label la4 = new Label(l, r,cast.get(j).toString(),cellRIghtformat);
				   l++;
				   Label la5 = new Label(l, r, al.get(j).toString(),cellRIghtformat);
				   l++;
				   Label la6 = new Label(l, r, zeroDForm.format(total2),cellRIghtformat);
				   writableSheet.addCell(la3);
				   writableSheet.addCell(la4);
				   writableSheet.addCell(la5);
				   writableSheet.addCell(la6); 
			}
			if(head.get(i).toString().equalsIgnoreCase("TOTAL MELTING , MT") || head.get(i).toString().equalsIgnoreCase("TOTAL PROD, MT") || head.get(i).toString().equalsIgnoreCase("INHOUSE REJ, MT") 
					|| head.get(i).toString().equalsIgnoreCase("GOOD PROD, MT") || head.get(i).toString().equalsIgnoreCase("SALES, Rs Lacs") || head.get(i).toString().equalsIgnoreCase("CUSTOMER RETURNS, MT")){
			avg2 = Double.parseDouble(zeroDForm.format(total2))/workdays;
			}else{
				avg2 = 0;
			}
			   
			l++;
			Label la7 = new Label(l, r, zeroDForm.format(avg2),cellRIghtformat);
			writableSheet.addCell(la7);
			   
			if(l==7){
			   r++;
			   l=0;
			} 
			
		j++;
	 	}
	
	
	// -------------------------------------------------------------------------------------------------------------------------
		Set<String> ondateci = new HashSet();
		Set<String> todateci = new HashSet();
		Set<String> ondateal = new HashSet();
		Set<String> todateal = new HashSet();
		
		//	exec "FOUNDRYFMSHOP"."dbo"."Sel_RptGrdWiseDailyProd";1 '103', '652', '101102103', '20151106', '20151106', 'FOUNDRYERP', 'FOUNDRYFMSHOP'	
		CallableStatement cs_heat = con.prepareCall("{call Sel_RptGrdWiseDailyProd(?,?,?,?,?,?,?)}");
		cs_heat.setString(1, comp);
		cs_heat.setString(2, "652");
		cs_heat.setString(3, "101102103104");
		cs_heat.setString(4, OnDateMIS);
		cs_heat.setString(5, OnDateMIS);
		cs_heat.setString(6, "DIERP");
		cs_heat.setString(7, "DIFMSHOP");
		ResultSet rs_heat = cs_heat.executeQuery(); 
		while(rs_heat.next()){
			if(rs_heat.getString("GRADE").equalsIgnoreCase("102")){
			//	ondate_ci++;
				ondateci.add(rs_heat.getString("TRAN_NO"));
			}
			if(rs_heat.getString("GRADE").equalsIgnoreCase("104")){
			//	ondate_al++;
				ondateal.add(rs_heat.getString("TRAN_NO"));
			}
		}
		CallableStatement cs_ondate = con.prepareCall("{call Sel_RptGrdWiseDailyProd(?,?,?,?,?,?,?)}");
		cs_ondate.setString(1, comp);
		cs_ondate.setString(2, "652");
		cs_ondate.setString(3, "101102103104");
		cs_ondate.setString(4, from_date);
		cs_ondate.setString(5, OnDateMIS);
		cs_ondate.setString(6, "DIERP");
		cs_ondate.setString(7, "DIFMSHOP");
		ResultSet rs_ondate = cs_ondate.executeQuery(); 
		while(rs_ondate.next()){
			if(rs_ondate.getString("GRADE").equalsIgnoreCase("102")){
			//	todate_ci++;
			todateci.add(rs_ondate.getString("TRAN_NO"));
			}
			if(rs_ondate.getString("GRADE").equalsIgnoreCase("104")){
			//	todate_al++;
			todateal.add(rs_ondate.getString("TRAN_NO"));
			}
		} 
		
				int heatavg1 = todateci.size()/workdays; 
				int heatavg2 = todateal.size()/workdays; 
				int  total_ci = ondateci.size() + ondateal.size();
				int total_al = todateci.size() + todateal.size(); 
				int total_average = total_al/workdays; 
					
	
	   Label la0 = new Label(l, r, "HEATS",cellRIghtformat);
	   l++;
	   Label la1 = new Label(l, r, String.valueOf(ondateci.size()),cellRIghtformat);
	   l++;
	   Label la2 = new Label(l, r, String.valueOf(ondateal.size()),cellRIghtformat);
	   l++;
	   Label la3 = new Label(l, r, String.valueOf(total_ci),cellRIghtformat);
	   l++;
	   Label la4 = new Label(l, r, String.valueOf(todateci.size()),cellRIghtformat);
	   l++;
	   Label la5 = new Label(l, r, String.valueOf(todateal.size()),cellRIghtformat);
	   l++;
	   Label la6 = new Label(l, r, String.valueOf(total_al),cellRIghtformat);
	   l++;
	   Label la7 = new Label(l, r, String.valueOf(total_average),cellRIghtformat);
	   
	   writableSheet.addCell(la0);
	   writableSheet.addCell(la1);
	   writableSheet.addCell(la2);
	   writableSheet.addCell(la3);
	   writableSheet.addCell(la4);
	   writableSheet.addCell(la5);
	   writableSheet.addCell(la6);
	   writableSheet.addCell(la7);
	// --------------------------------------------------------------------------------------------------------------
	
	/*
	
	   double sumrc = 0,sumrs=0,summix=0;
	   
		CallableStatement batch = con.prepareCall("{call Sel_RptBatchProduction(?,?,?,?)}");
		batch.setString(1, comp);
		batch.setString(2, bdatefrom);
		batch.setString(3, bdateto); 
		batch.setString(4, db); 
		ResultSet rabatch = batch.executeQuery(); 
		while(rabatch.next()){
			 if(rabatch.getString("MAT_CODE").equalsIgnoreCase("1011400003")){
			 sumrc = sumrc + Double.parseDouble(rabatch.getString("QTY"));		
			 summix = summix + Double.parseDouble(rabatch.getString("TOT_MIXES"));
			 }
			 if(rabatch.getString("MAT_CODE").equalsIgnoreCase("1010403133")){ 
			 sumrs = sumrs + Double.parseDouble(rabatch.getString("QTY"));
			 }
		}
		DecimalFormat threeDForm = new DecimalFormat("0.000"); 
		
		//----------------------------------------------------------------------------------------------------------
		Label label14 = new Label(9, 1, "Batch Production From " +  batchonDate + " to " + OnDate , cellFormat);
		Label label15 = new Label(9, 2, "Item",cellFormat);
		Label label16 = new Label(10, 2, "Qty",cellFormat);
		Label label17 = new Label(11, 2, "Total Mixes",cellFormat);
		   writableSheet.addCell(label14);
		   writableSheet.addCell(label15);
		   writableSheet.addCell(label16);
		   writableSheet.addCell(label17);
		   
		   Label la8 = new Label(9, 3, "RESINE COATED SAND 3.8 %",cellRIghtformat);
		   Label la9 = new Label(10, 3, threeDForm.format(sumrc/1000),cellRIghtformat);
		   Label la10 = new Label(11, 3, String.valueOf(summix),cellRIghtformat);
		   
		   Label la111 = new Label(9, 4, "RAW SILICA SAND RECLAIMED",cellRIghtformat);
		   Label la122 = new Label(10, 4, threeDForm.format(sumrs/1000),cellRIghtformat);
		   Label la133 = new Label(11, 4, "",cellRIghtformat);
		   writableSheet.addCell(la8);
		   writableSheet.addCell(la9);
		   writableSheet.addCell(la10);
		   
		   writableSheet.addCell(la111);
		   writableSheet.addCell(la122);
		   writableSheet.addCell(la133);
		   
		   
		   
		   */
	// -------------------------------------------------------------------------------------------------------------
		Label label18 = new Label(9, 6, "FURNACE HEATS",cellFormat);
		Label label19 = new Label(10, 6, "SHIFT 1",cellFormat);
		Label label20 = new Label(11, 6, "SHIFT 2",cellFormat);
		Label label21 = new Label(12, 6, "SHIFT 3",cellFormat);
		Label label22 = new Label(13, 6, "TOTAL",cellFormat);
		   writableSheet.addCell(label18);
		   writableSheet.addCell(label19);
		   writableSheet.addCell(label20);
		   writableSheet.addCell(label21);
		   writableSheet.addCell(label22);
	
		  	ArrayList refcode = new ArrayList();
			ArrayList refname = new ArrayList();
			
			ArrayList shift1 = new ArrayList();
			ArrayList shift2 = new ArrayList();
			ArrayList shift3 = new ArrayList();
			ArrayList total = new ArrayList();
			
			PreparedStatement ps_refCode = con.prepareStatement("SELECT * FROM MSTCOMMFURNACE");
			ResultSet rs_refCode = ps_refCode.executeQuery();
			while(rs_refCode.next()){
				refcode.add(rs_refCode.getString("CODE"));
				refname.add(rs_refCode.getString("NAME"));
			}
			
			int fc=0;
			int shift=1;
			int qty_fc=0;
			PreparedStatement ps_fc = null;
			ResultSet rs_fc = null;
			l=9;
			r=7;
			for(int i=0;i<refcode.size();i++){
				Label la11 = new Label(l, r, refname.get(i).toString(),cellRIghtformat);
				writableSheet.addCell(la11);
				l++;
				ps_fc = con.prepareStatement("select COUNT(*) as count from TRNWIPMATH where TRAN_NO LIKE'%652110%' AND TRAN_DATE BETWEEN '"+OnDateMIS+"' AND '"+OnDateMIS+"' AND SHIFT='"+shift+"' AND REF_CODE='"+refcode.get(i).toString()+"'");
				rs_fc = ps_fc.executeQuery();
				while(rs_fc.next()){
					shift1.add(Integer.parseInt(rs_fc.getString("count")));
				Label la12 = new Label(l, r, rs_fc.getString("count"),cellRIghtformat);
					writableSheet.addCell(la12);
					l++; 
					qty_fc = Integer.parseInt(rs_fc.getString("count")) ;
				}
				shift++;
				ps_fc = con.prepareStatement("select COUNT(*) as count from TRNWIPMATH where TRAN_NO LIKE'%652110%' AND TRAN_DATE BETWEEN '"+OnDateMIS+"' AND '"+OnDateMIS+"' AND SHIFT='"+shift+"' AND REF_CODE='"+refcode.get(i).toString()+"'");
				rs_fc = ps_fc.executeQuery();
				while(rs_fc.next()){
					shift2.add(Integer.parseInt(rs_fc.getString("count")));
				Label la13 = new Label(l, r, rs_fc.getString("count"),cellRIghtformat);
					writableSheet.addCell(la13);
					l++; 
					qty_fc = Integer.parseInt(rs_fc.getString("count")) +qty_fc;
				}
						shift++;
						ps_fc = con.prepareStatement("select COUNT(*) as count from TRNWIPMATH where TRAN_NO LIKE'%652110%' AND TRAN_DATE BETWEEN '"+OnDateMIS+"' AND '"+OnDateMIS+"' AND SHIFT='"+shift+"' AND REF_CODE='"+refcode.get(i).toString()+"'");
						rs_fc = ps_fc.executeQuery();
						while(rs_fc.next()){
							shift3.add(Integer.parseInt(rs_fc.getString("count")));
							Label la14 = new Label(l, r, rs_fc.getString("count"),cellRIghtformat);
							writableSheet.addCell(la14);
							l++; 
						qty_fc = Integer.parseInt(rs_fc.getString("count")) +qty_fc;
						}
						Label la15 = new Label(l, r, String.valueOf(qty_fc),cellRIghtformat);
						writableSheet.addCell(la15); 
						if(l==13){
							   r++;
							   l=9;
						   }
						total.add(qty_fc);
						shift=1;
						fc=0;
			}
			
			double sum1 = 0;
			double sum2 = 0;
			double sum3 = 0;
			double sum4 = 0;
			for(int i = 0; i < shift1.size(); i++){
			    sum1 += Double.parseDouble(shift1.get(i).toString());
			}
			for(int i1 = 0; i1 < shift2.size(); i1++){
				sum2 += Double.parseDouble(shift2.get(i1).toString());
			}
			for(int i2 = 0; i2 < shift3.size(); i2++){
				sum3 += Double.parseDouble(shift3.get(i2).toString());
			} 
			for(int i3 = 0; i3 < total.size(); i3++){
				sum4 += Double.parseDouble(total.get(i3).toString());
			}

	   Label la11 = new Label(l, r, "TOTAL ",cellRIghtformat);
	   writableSheet.addCell(la11);
	   l++;
	   Number la12 = new Number(l, r, Math.round(sum1),cellRIghtformat);
	   writableSheet.addCell(la12);
	   l++;
	   Number la13 = new Number(l, r, Math.round(sum2),cellRIghtformat);
	   writableSheet.addCell(la13);
	   l++;
	   Number la14 = new Number(l, r, Math.round(sum3),cellRIghtformat);
	   writableSheet.addCell(la14);
	   l++;
	   Number la15 = new Number(l, r, Math.round(sum4),cellRIghtformat);
	   writableSheet.addCell(la15);
	   if(l==13){
		   r++;
		   l=9;
	   }
	   
	// --------------------------------------------------------------------------------------------------------------
	   writableWorkbook.write();
	   writableWorkbook.close();
	
   String filePath = "C:/reportxls/FoundryMIS" + val + ".xls";
%>
<span id="exportId">
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=OnDateMIS%>','<%=db%>')" style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> 
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a><img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
</span>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>