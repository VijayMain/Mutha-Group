<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
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
	 	 String CompanyName="";
	    Connection con =null;    
	    String comp =request.getParameter("comp");
	    String from =request.getParameter("from"); 
	    String to =request.getParameter("to"); 
	    String matcode = "",matcode1 = "",matcode_stk="";
	    ArrayList matList = new ArrayList();  
	
	DecimalFormat zeroDForm = new DecimalFormat("##0.00");
	DecimalFormat noDForm = new DecimalFormat("##0");
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";  
	
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/ReportPS"+val+".xls");
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
    writableSheet.setColumnView(1, 45);
    writableSheet.setColumnView(2, 12);
    writableSheet.setColumnView(3, 12);
    writableSheet.setColumnView(4, 12);
    writableSheet.setColumnView(5, 12);
    writableSheet.setColumnView(6, 12);
    writableSheet.setColumnView(7, 12);
    writableSheet.setColumnView(8, 12);
  /*   writableSheet.setColumnView(9, 12);
    writableSheet.setColumnView(10, 12);  */
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font);
        
    Label label = new Label(0, 0, "Sr. No",cellFormat);
    Label label1 = new Label(1, 0, "Item Name",cellFormat);
    Label label2 = new Label(2, 0, "Purchase Qty",cellFormat);
    Label label3 = new Label(3, 0, "Purchase Avg",cellFormat);
    Label label4 = new Label(4, 0, "Purchase amt",cellFormat);
    Label label5 = new Label(5, 0, "Sale Qty",cellFormat);
    Label label6 = new Label(6, 0, "Sale Avg",cellFormat);
    Label label7 = new Label(7, 0, "Sale amt",cellFormat);
    Label label8 = new Label(8, 0, "%",cellFormat); 
    /* Label label9 = new Label(9, 0, "Diff Amt",cellFormat);
    Label label10 = new Label(10, 0, "%",cellFormat); */

  // Add the created Cells to the sheet
    writableSheet.addCell(label);
    writableSheet.addCell(label1);
    writableSheet.addCell(label2);
    writableSheet.addCell(label3);
    writableSheet.addCell(label4);
    writableSheet.addCell(label5);
    writableSheet.addCell(label6);
    writableSheet.addCell(label7);
    writableSheet.addCell(label8);
   /*  writableSheet.addCell(label9);
    writableSheet.addCell(label10);  */
     
  

    String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
    String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);
 

    String group="";
    int ct=1; ;
    if(comp.equalsIgnoreCase("101")){
    	CompanyName = "H-21";
    	con = ConnectionUrl.getMEPLH21ERP();  
    	  PreparedStatement ps=con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='101'");
    	  ResultSet rs=ps.executeQuery();
    	  while(rs.next()){
    		  matList.add(rs.getString("code"));		  
    	  } 
    	  PreparedStatement ps1=con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='103'");
    	  ResultSet rs1=ps1.executeQuery();
    	  while(rs1.next()){
    		  matcode_stk +=rs1.getString("code");		  
    	  } 
    }else{
    	CompanyName = "H-25";
    	con	= ConnectionUrl.getMEPLH25ERP();
    	 PreparedStatement ps=con.prepareStatement("select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='101'");
    	  ResultSet rs=ps.executeQuery();
    	  while(rs.next()){
    		  matList.add(rs.getString("code")); 
    	  } 
    	  PreparedStatement ps1=con.prepareStatement("select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='103'");
    	  ResultSet rs1=ps1.executeQuery();
    	  while(rs1.next()){
    		  matcode_stk +=rs1.getString("code");
    	  } 
    }
    int one = matList.size()/2; 
    int m1=0;

    for(int m=0;m<one;m++){
    	matcode+=matList.get(m).toString(); 
    	m1 = m;
    }
    m1 = matList.size() - m1;
    for(int m=m1-1;m<matList.size();m++){
    	matcode1+=matList.get(m).toString();  
    }
  	//***********************************************************************************************************************************
    //***********************************************************************************************************************************
    int srno=1,row=0,col=1;
  	
    ArrayList perQty = new ArrayList();
	ArrayList selQty = new ArrayList();
	
	double pur_avg = 0,pur_amt=0; 
	double sale_avg = 0,sale_amt=0,per=0; 
	
	CallableStatement cs11 = con.prepareCall("{call Sel_MatStockStatementKranti(?,?,?,?,?)}");
cs11.setString(1,comp);
cs11.setString(2,"0");
cs11.setString(3,matcode_stk);
cs11.setString(4,from);
cs11.setString(5,to);
ResultSet rs122 = cs11.executeQuery(); 
	
while(rs122.next()){
	
	if(Double.parseDouble(rs122.getString("RECEIPT_QTY")) > 0){
		perQty.add(Double.parseDouble(rs122.getString("RECEIPT_QTY")));
		} 
		if(Double.parseDouble(rs122.getString("ISSUE_QTY")) > 0){
		selQty.add(Double.parseDouble(rs122.getString("ISSUE_QTY")));
		}
		 
		pur_avg = Double.parseDouble(rs122.getString("PURCHASE_VALUE"))/Double.parseDouble(rs122.getString("RECEIPT_QTY"));
		pur_amt = Double.parseDouble(rs122.getString("RECEIPT_QTY")) * pur_avg;
		
		sale_avg = Double.parseDouble(rs122.getString("SALE_VALUE"))/Double.parseDouble(rs122.getString("ISSUE_QTY"));
		sale_amt = Double.parseDouble(rs122.getString("ISSUE_QTY")) * sale_avg;
		per =  pur_avg/sale_avg*100;
		
		
Number srno_lbl = new Number(row, col,Integer.parseInt(String.valueOf(srno)) ,cellRIghtformat);
srno ++; 
row++;
Label item_lbl = new Label(row, col,rs122.getString("MAT_NAME"),cellleftformat);
row++;
Number purqty_lbl = new Number(row, col, Double.parseDouble(rs122.getString("RECEIPT_QTY")),cellRIghtformat);
row++;
Number puravg_lbl = new Number(row, col,Double.parseDouble(rs122.getString("ISSUE_QTY")),cellRIghtformat);
row++;
Number puramt_lbl = new Number(row, col,pur_avg,cellRIghtformat);
row++;
Number saleamt_lbl = new Number(row, col, pur_amt,cellRIghtformat);
row++;
Number saleqty_lbl = new Number(row, col,sale_avg,cellRIghtformat);
row++;
Number saamt_lbl = new Number(row, col, sale_amt,cellRIghtformat);
row++; 
Number per_lbl = new Number(row, col, per,cellRIghtformat); 
		
		writableSheet.addCell(srno_lbl);
		writableSheet.addCell(item_lbl);
		writableSheet.addCell(purqty_lbl);
		writableSheet.addCell(puravg_lbl);
		writableSheet.addCell(puramt_lbl);
		writableSheet.addCell(saleamt_lbl);
		writableSheet.addCell(saleqty_lbl);
		writableSheet.addCell(saamt_lbl);	 
		writableSheet.addCell(per_lbl);
		row++;
		
		if(row==9){
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
    
    String filePath = "C:/reportxls/ReportPS"+val+".xls";
    
    File downloadFile = new File(filePath);
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
    // forces download
    String headerKey = "Content-Disposition";
    String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
    response.setHeader(headerKey, headerValue); 
    inStream.close(); 
%>
<span id="exportId"> 
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer;" disabled="disabled">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>