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
	
	String comp="",from="",to="";
	comp = request.getParameter("comp");
	from = request.getParameter("from");
	to = request.getParameter("to");
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	 
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/cast_stk"+val+".xls");
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
    writableSheet.setColumnView(1, 20);
    writableSheet.setColumnView(2, 36);
    writableSheet.setColumnView(3, 12);
    writableSheet.setColumnView(4, 12);
    writableSheet.setColumnView(5, 12);
    writableSheet.setColumnView(6, 12);
    writableSheet.setColumnView(7, 12);
    writableSheet.setColumnView(8, 12);
    writableSheet.setColumnView(9, 12);
    writableSheet.setColumnView(10, 12);
    writableSheet.setColumnView(11, 8);
    writableSheet.setColumnView(12, 8);
    
    
    
    
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font);
    
    
 	     
    Label label = new Label(0, 0, "Sr. No",cellFormat);
    Label label1 = new Label(1, 0, "Company Name",cellFormat);
    Label label2 = new Label(2, 0, "Item Name",cellFormat);
    Label label3 = new Label(3, 0, "Opening Qty",cellFormat);
    Label label4 = new Label(4, 0, "Purchase Qty",cellFormat);
    Label label5 = new Label(5, 0, "Sale Return",cellFormat);
    Label label6 = new Label(6, 0, "Sale Qty",cellFormat);
    Label label7 = new Label(7, 0, "Purchase Return",cellFormat);
    Label label8 = new Label(8, 0, "Line Rejection",cellFormat);
    Label label9 = new Label(9, 0, "Closing Balance",cellFormat);
    Label label10 = new Label(10, 0, "Min Qty",cellFormat);
    Label label11 = new Label(11, 0, "Max Qty",cellFormat);

  //Add the created Cells to the sheet
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
     
    String CompanyName="",matcode="";
    Connection con = null;
    if(comp.equalsIgnoreCase("101")){
    	CompanyName = "H-21";
    	con = ConnectionUrl.getMEPLH21ERP(); 
    	
    	  PreparedStatement ps=con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='103'");
    	  ResultSet rs=ps.executeQuery();
    	  while(rs.next()){
    		  matcode+=rs.getString("CODE");		  
    	  } 
    	 // System.out.println("code = " + matcode);
    }else{
    	CompanyName = "H-25";
    	con	= ConnectionUrl.getMEPLH25ERP();
    	 PreparedStatement ps=con.prepareStatement("select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='103'");
    	  ResultSet rs=ps.executeQuery();
    	  while(rs.next()){
    		  matcode+=rs.getString("CODE");
    	  }
    } 
    
  	//***********************************************************************************************************************************
    //***********************************************************************************************************************************
    int srno=1,row=0,col=1;
    DecimalFormat zeroDForm = new DecimalFormat("0");
    CallableStatement cs11 = con.prepareCall("{call Sel_MatStockStatementKranti(?,?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,matcode);
	cs11.setString(4,from);
	cs11.setString(5,to);
	ResultSet rs122 = cs11.executeQuery();
	while(rs122.next()){
		Number srno_lable = new Number(row, col,Integer.parseInt(String.valueOf(srno)) ,cellRIghtformat);
		srno ++;
		row++;
		Label comp_lable = new Label(row, col,rs122.getString("GROUP_NAME"),cellleftformat);
		row++;
		Label item_lable = new Label(row, col,rs122.getString("MAT_NAME"),cellleftformat);
		row++;
		//Number opqty_lable = new Number(row, col,zeroDForm.format(Double.parseDouble(rs122.getString("OPENING_QTY"))),cellRIghtformat);
		Number opqty_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("OPENING_QTY")))),cellRIghtformat);
		row++;
		Number purqty_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("RECEIPT_QTY")))),cellRIghtformat);
		row++;
		Number salertn_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("SRTN_QTY")))),cellRIghtformat);
		row++;
		Number saleqty_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("ISSUE_QTY")))),cellRIghtformat);
		row++;
		Number purReturn_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("PURT_QTY")))),cellRIghtformat);
		row++;
		Number linerej_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("REJ_QTY")))),cellRIghtformat);
		row++;
		Number closeBal_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("CLOSING_QTY")))),cellRIghtformat);
		row++;
		Number minqty_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("MIN_QTY")))),cellRIghtformat);
		row++;
		Number maxqty_lable = new Number(row, col,Integer.parseInt(zeroDForm.format(Double.parseDouble(rs122.getString("MAX_QTY")))),cellRIghtformat);  
		
		writableSheet.addCell(srno_lable);
		writableSheet.addCell(comp_lable);
		writableSheet.addCell(item_lable);
		writableSheet.addCell(opqty_lable);
		writableSheet.addCell(purqty_lable);
		writableSheet.addCell(salertn_lable);
		writableSheet.addCell(saleqty_lable);
		writableSheet.addCell(purReturn_lable);
		writableSheet.addCell(linerej_lable);
		writableSheet.addCell(closeBal_lable);
		writableSheet.addCell(minqty_lable);
		writableSheet.addCell(maxqty_lable); 
		 
		row++;
		if(row==12){
			row=0;
			col++;
		}
	}
  
		// data ==== >
	 	/* second row
	    Label d0 = new Label(0, 1, "Data Inserted",cellRIghtformat);
	    Label d1 = new Label(1, 1, "Data Inserted",cellRIghtformat);
	 	// Third row
	    Label d2 = new Label(0, 2, "Data Inserted 2222",cellRIghtformat);
	    Label d3 = new Label(1, 2, "Data Inserted 2222",cellRIghtformat);
    
    	writableSheet.addCell(d0);
    	writableSheet.addCell(d1);
    	writableSheet.addCell(d2);
    	writableSheet.addCell(d3); */
     
    
  //************************************************************************************************************************
  //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
    //Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/cast_stk"+val+".xls";
    
    /* File downloadFile = new File(filePath);
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
    response.setHeader(headerKey, headerValue); */
     
     /*obtains response's output stream
    OutputStream outStream = response.getOutputStream();
     
    byte[] buffer = new byte[4096];
    int bytesRead = -1;
     
    while ((bytesRead = inStream.read(buffer)) != -1) {
        outStream.write(buffer, 0, bytesRead);
    }
     */
    //outStream.close();  
   // inStream.close();
  
%>
<span id="exportId"> 
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer;">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>