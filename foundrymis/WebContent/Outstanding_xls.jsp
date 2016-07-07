<%@page import="java.util.Collections"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="jxl.write.Number"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="jxl.write.Label"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.format.Colour"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<html>
<head> 
<title>Outstanding xls</title>
</head>
<body>
<%
try { 
	Connection con = null;
	String comp =request.getParameter("comp");
	
	
	
	String datefrom =request.getParameter("from");
	String date_From = datefrom.substring(6,8) +"/"+ datefrom.substring(4,6) +"/"+ datefrom.substring(0,4);
	String nameComp="",code="1010011101000210100141010008101001510100091010006101000310100121010007101000110100161010005101001010100041010013";



	DecimalFormat zeroDForm = new DecimalFormat("##0");
	DecimalFormat twoDForm = new DecimalFormat("##0.00");

	String datetab = datefrom.substring(4,6);
	String[] mm = new DateFormatSymbols().getMonths();
	 int tab = Integer.parseInt(datetab);
	 int taby = Integer.parseInt(datefrom.substring(0,4));
	 ArrayList monthlist = new ArrayList();
	 for(int s=0;s<6;s++){
			if(tab==0){
				tab = 12;
				taby = taby-1; 
				monthlist.add(mm[tab-1]+taby);
	 			
			}else{ 
				monthlist.add(mm[tab-1]+taby);
			}
			tab--; 
	 }
	 Collections.reverse(monthlist); 
	 
	if(comp.equalsIgnoreCase("103")){
		con = ConnectionUrl.getFoundryERPNEWConnection(); 
		nameComp = "MUTHA FOUNDERS PVT.LTD.";
	}
	if(comp.equalsIgnoreCase("105")){
		con = ConnectionUrl.getDIERPConnection();
		nameComp = "DHANASHREE INDUSTRIES";
	}
	if(comp.equalsIgnoreCase("106")){
		con = ConnectionUrl.getK1ERPConnection(); 
		nameComp = "MUTHA ENGINEERING PVT.LTD.UNIT III ";
	}
	if(comp.equalsIgnoreCase("101")){
		con = ConnectionUrl.getMEPLH21ERP();
		nameComp = "H21 MUTHA ENGINEERING PVT.LTD.";
	}
	if(comp.equalsIgnoreCase("102")){
		con = ConnectionUrl.getMEPLH25ERP();
		nameComp = "H25 MUTHA ENGINEERING PVT.LTD.";
	}
	
	if(comp.equalsIgnoreCase("111")){ 
		con = ConnectionUrl.getENGH25CONSConnection();
		nameComp = "MEPL H21 & MEPL H25 Consolidated";
	}
	int srno=1; 
	double otsum = 0;
	CallableStatement cs = con.prepareCall("{call Sel_RptOutstanding(?,?,?,?,?,?)}");
	
	if(comp.equalsIgnoreCase("111")){
	 	cs.setString(1, "0");
	 	cs.setString(2, "0");
		cs.setString(3, code);
		cs.setString(4, datefrom); 
		cs.setString(5, "0"); 
		cs.setString(6, "0"); 
		}else{
			cs.setString(1, comp);
		 	cs.setString(2, "0");
			cs.setString(3, code);
			cs.setString(4, datefrom); 
			cs.setString(5, "0"); 
			cs.setString(6, "0");
		}
	
	
	ResultSet rs122 = cs.executeQuery();
	
	
	
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	
	// System.out.println("In lOop" + listOfFiles.length);
	/* if(listOfFiles.length!=0){
	    for (int i = 0; i < listOfFiles.length; i++) {
	      if (listOfFiles[i].isFile()) {
	       System.out.println("File " + listOfFiles[i].getName());
	        listname = listOfFiles[i].getName().substring(8); 
	        alistFile.add(listname);
	      } 
	    }
	}else{
		alistFile.add("0");
	} */
	  
 	//int val = Integer.parseInt(alistFile.get(alistFile.size()-1).toString()) + 1;
	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/ReportOS"+val+".xls");
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
    //font.setBoldStyle(WritableFont.BOLD);
    
    writableSheet.setColumnView(0, 6);
    writableSheet.setColumnView(1, 40);
    writableSheet.setColumnView(2, 12);
    writableSheet.setColumnView(3, 12);
    writableSheet.setColumnView(4, 12);
    writableSheet.setColumnView(5, 12);
    writableSheet.setColumnView(6, 12);
    writableSheet.setColumnView(7, 12);
    writableSheet.setColumnView(8, 12);
    writableSheet.setColumnView(9, 12);
    /* writableSheet.setColumnView(10, 12);
    writableSheet.setColumnView(11, 8);
    writableSheet.setColumnView(12, 8); */
    
    
    
    
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font);
    
   
    
 	     
    Label label = new Label(0, 0, "Sr. No",cellFormat);
    Label label1 = new Label(1, 0, "Name Of The Party",cellFormat);
    Label label2 = new Label(2, 0,"Before " + monthlist.get(0).toString()+ " Amount",cellFormat);
    Label label22 = new Label(3, 0,monthlist.get(0).toString()+ " Amount",cellFormat);
    Label label3 = new Label(4, 0, monthlist.get(1).toString() + " Amount",cellFormat);
    Label label4 = new Label(5, 0, monthlist.get(2).toString()+ " Amount",cellFormat);
    Label label5 = new Label(6, 0, monthlist.get(3).toString()+ " Amount",cellFormat);
    Label label6 = new Label(7, 0, monthlist.get(4).toString()+ " Amount",cellFormat);
    Label label7 = new Label(8, 0, monthlist.get(5).toString()+ " Amount",cellFormat); 
    Label label8 = new Label(9, 0, "Total Amount",cellFormat);
    /* Label label10 = new Label(10, 0, "Min Qty",cellFormat);
    Label label11 = new Label(11, 0, "Max Qty",cellFormat); */

  //Add the created Cells to the sheet
    writableSheet.addCell(label);
    writableSheet.addCell(label1);
    writableSheet.addCell(label2);
    writableSheet.addCell(label22);
    writableSheet.addCell(label3);
    writableSheet.addCell(label4);
    writableSheet.addCell(label5);
    writableSheet.addCell(label6);
    writableSheet.addCell(label7);
    writableSheet.addCell(label8);
    /*  writableSheet.addCell(label9);
    writableSheet.addCell(label10);
    writableSheet.addCell(label11); */
     
    
  	//***********************************************************************************************************************************
    //***********************************************************************************************************************************
    int row=0,col=1; 
    
    double add1=0;
	while(rs122.next()){
		Number srno_lable = new Number(row, col,Integer.parseInt(String.valueOf(srno)) ,cellRIghtformat);
		srno ++;
		row++;
		Label supname = new Label(row, col,rs122.getString("SUPP_NAME"),cellleftformat);
		row++;
		Number before = new Number(row, col,Double.parseDouble(zeroDForm.format(Double.parseDouble(rs122.getString("B4CurAMOUNT_6")))),cellRIghtformat);
		row++;
		add1 = Double.parseDouble(rs122.getString("B4CurAMOUNT_6"))+Double.parseDouble(rs122.getString("CurAMOUNT_5"));
		Number before1 = new Number(row, col,Double.parseDouble(twoDForm.format(add1)),cellRIghtformat);
		row++;
		add1 = add1 + Double.parseDouble(rs122.getString("CurAMOUNT_4"));
		Number before2 = new Number(row, col,Double.parseDouble(twoDForm.format(add1)),cellRIghtformat);
		row++;
		add1 = add1 + Double.parseDouble(rs122.getString("CurAMOUNT_3"));
		Number before3 = new Number(row, col,Double.parseDouble(twoDForm.format(add1)),cellRIghtformat);
		row++;
		add1 = add1 + Double.parseDouble(rs122.getString("CurAMOUNT_2"));
		Number before4 = new Number(row, col,Double.parseDouble(twoDForm.format(add1)),cellRIghtformat);
		row++;
		add1 = add1 + Double.parseDouble(rs122.getString("CurAMOUNT_1"));
		Number before5 = new Number(row, col,Double.parseDouble(twoDForm.format(add1)),cellRIghtformat);
		row++;
		add1 = add1 + Double.parseDouble(rs122.getString("CurAMOUNT"));
		Number before6 = new Number(row, col,Double.parseDouble(twoDForm.format(add1)),cellRIghtformat);
		row++;
		otsum =  Double.parseDouble(rs122.getString("B4CurAMOUNT_6"))+
				 Double.parseDouble(rs122.getString("CurAMOUNT_5"))+
				 Double.parseDouble(rs122.getString("CurAMOUNT_4"))+
				 Double.parseDouble(rs122.getString("CurAMOUNT_3"))+
				 Double.parseDouble(rs122.getString("CurAMOUNT_2"))+
				 Double.parseDouble(rs122.getString("CurAMOUNT_1"))+
				 Double.parseDouble(rs122.getString("CurAMOUNT"));
		Number total = new Number(row, col,Double.parseDouble(twoDForm.format(otsum)),cellRIghtformat); 
		
		writableSheet.addCell(srno_lable);
		writableSheet.addCell(supname);
		writableSheet.addCell(before);
		writableSheet.addCell(before1);
		writableSheet.addCell(before2);
		writableSheet.addCell(before3);
		writableSheet.addCell(before4);
		writableSheet.addCell(before5);
		writableSheet.addCell(before6); 
		writableSheet.addCell(total); 		 
		row++; 
		if(row==10){
			row=0;
			col++;
		}
	} 
  //************************************************************************************************************************
  //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
    //Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/ReportOS"+val+".xls";
    
   /*  File downloadFile = new File(filePath);
    FileInputStream inStream = new FileInputStream(downloadFile);
      
    ServletContext context = getServletContext();
     
    // gets MIME type of the file
    String mimeType = context.getMimeType(filePath);
    if (mimeType == null) {        
        // set to binary type if MIME mapping not found
        mimeType = "application/octet-stream";
    }
      
    // modifies response
    response.setContentType(mimeType);
    response.setContentLength((int) downloadFile.length());
    
    //forces download
    String headerKey = "Content-Disposition";
    String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
    response.setHeader(headerKey, headerValue);
      
    inStream.close();
   */
%>
<span id="exportId"> 
<button id="filebutton"  onclick="getExcel_Report('<%=comp%>','<%=datefrom%>')"  style="cursor: pointer;">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>