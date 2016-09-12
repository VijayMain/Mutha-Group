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
<span id="exportId">  
<%
try {	   //  xmlhttp.open("POST", "PartywisePorder_xls.jsp?comp=" + comp +"&sup="+sup+"&from="+from+"&to="+to, true);
	 	String CompanyName="";
	    Connection con =null;    
	    String comp =request.getParameter("comp"); 
	    String from =request.getParameter("from"); 
	    String to =request.getParameter("to");  
	    int row=0,col=1;  
	    String group="";
	    int ct=1; ;
	    if(comp.equalsIgnoreCase("101")){
	    	CompanyName = "H-21";
	    	con = ConnectionUrl.getMEPLH21ERP();   
	    }if(comp.equalsIgnoreCase("102")){
	    	CompanyName = "H-25";
	    	con	= ConnectionUrl.getMEPLH25ERP(); 
	    } 
	    if(comp.equalsIgnoreCase("103")){
	    	CompanyName = "MUTHA FOUNDERS PVT. LTD.";
	    	con = ConnectionUrl.getFoundryERPNEWConnection();   
	    }
	    if(comp.equalsIgnoreCase("105")){	
	    	CompanyName = "DHANASHREE INDUSTRIES";
	    	con=ConnectionUrl.getDIERPConnection();
	    }
	    if(comp.equalsIgnoreCase("106")){
	    	CompanyName = "MUTHA ENGINEERING UNIT III";
	    	con = ConnectionUrl.getK1ERPConnection();
	    }
	     
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4); 
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4); 	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
 	int val = listOfFiles.length + 1; 
	File exlFile = new File("C:/reportxls/BillwisePurchase"+val+".xls");
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
    
    writableSheet.setColumnView(0, 9);
    writableSheet.setColumnView(1, 9);
    writableSheet.setColumnView(2, 9);
    writableSheet.setColumnView(3, 9);
    writableSheet.setColumnView(4, 9);
    writableSheet.setColumnView(5, 9);
    writableSheet.setColumnView(6, 9);
    writableSheet.setColumnView(7, 9);
    writableSheet.setColumnView(8, 9);
    writableSheet.setColumnView(9, 9);
    writableSheet.setColumnView(10, 9);
    writableSheet.setColumnView(11, 9);
    writableSheet.setColumnView(12, 9);
    writableSheet.setColumnView(13, 9);
    writableSheet.setColumnView(14, 9);
    writableSheet.setColumnView(15, 9);
    writableSheet.setColumnView(16, 9);
    writableSheet.setColumnView(17, 9);
    writableSheet.setColumnView(18, 9);
    writableSheet.setColumnView(19, 9);
    writableSheet.setColumnView(20, 9);
    writableSheet.setColumnView(21, 9);
    writableSheet.setColumnView(22, 9);
    writableSheet.setColumnView(23, 9);
    writableSheet.setColumnView(24, 9);
    writableSheet.setColumnView(25, 9);
    writableSheet.setColumnView(26, 9);
    writableSheet.setColumnView(27, 9);
    writableSheet.setColumnView(28, 9);
    writableSheet.setColumnView(29, 9);
    writableSheet.setColumnView(30, 9);
    writableSheet.setColumnView(31, 9);
    writableSheet.setColumnView(32, 9);
    writableSheet.setColumnView(33, 9);
    writableSheet.setColumnView(34, 9);
    writableSheet.setColumnView(35, 9);
     
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font); 				
        
    Label label0 = new Label(0, 0,"Tran.No.",cellFormat);
    Label label1 = new Label(1, 0,"Tran Date",cellFormat);
    Label label10 = new Label(2, 0,"PO No",cellFormat);
    Label label11 = new Label(3, 0,"PO Date ",cellFormat);
    Label label12 = new Label(4, 0,"Bill No ",cellFormat);
    Label label13 = new Label(5, 0,"Bill Date ",cellFormat);
    
    Label label2 = new Label(6, 0,"Supplier",cellFormat);
    Label label3 = new Label(7, 0,"SST No",cellFormat);
    Label label4 = new Label(8, 0,"SST Date",cellFormat);
    Label label5 = new Label(9, 0,"CST No",cellFormat);
    Label label6 = new Label(10, 0,"CST Date ",cellFormat);
    Label label7 = new Label(11, 0,"Material Name",cellFormat);
    Label label8 = new Label(12, 0,"Qty",cellFormat);
    Label label9 = new Label(13, 0,"TAX Name",cellFormat);
    
    Label label14 = new Label(14, 0,"Basic Amount",cellFormat);
    Label label15 = new Label(15, 0,"Basic Discount",cellFormat);
    Label label16 = new Label(16, 0,"Basic Freight ",cellFormat);
    Label label17 = new Label(17, 0,"Basic Packing",cellFormat);
    Label label18 = new Label(18, 0,"Basic Other",cellFormat);
    Label label19 = new Label(19, 0,"Asses Amount ",cellFormat);
    Label label20 = new Label(20, 0,"Excise Duty ",cellFormat);
    Label label21 = new Label(21, 0,"CESS ",cellFormat);
    Label label22 = new Label(22, 0,"Service Tax ",cellFormat);
    Label label23 = new Label(23, 0,"Service CESS ",cellFormat);
    Label label24 = new Label(24, 0,"HGSEC CESS ",cellFormat);
    Label label25 = new Label(25, 0,"HGSEC SERV CESS ",cellFormat);
    Label label26 = new Label(26, 0,"Taxable Amt ",cellFormat);
    Label label27 = new Label(27, 0,"Sales Tax ",cellFormat);
    Label label28 = new Label(28, 0,"Discount ",cellFormat);
    Label label29 = new Label(29, 0,"Freight ",cellFormat);
    Label label30 = new Label(30, 0,"Packing ",cellFormat);
    Label label31 = new Label(31, 0,"TCS ",cellFormat);
    Label label32 = new Label(32, 0,"Rounding Off ",cellFormat);
    Label label33 = new Label(33, 0,"Other",cellFormat);
    Label label34 = new Label(34, 0,"Insurance",cellFormat);
    Label label35 = new Label(35, 0,"Total",cellFormat);

  // Add the created Cells to the sheet
 writableSheet.addCell(label0);
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
writableSheet.addCell(label23);
writableSheet.addCell(label24);
writableSheet.addCell(label25);
writableSheet.addCell(label26);
writableSheet.addCell(label27);
writableSheet.addCell(label28);
writableSheet.addCell(label29);
writableSheet.addCell(label30);
writableSheet.addCell(label31);
writableSheet.addCell(label32);
writableSheet.addCell(label33);
writableSheet.addCell(label34);
writableSheet.addCell(label35);
 
    //***********************************************************************************************************************************
 String concat="";
CallableStatement sp = con.prepareCall("{call Sel_PurchaseRegister(?,?,?,?,?,?,?)}");
sp.setString(1, comp);
sp.setString(2, "0");
sp.setString(3, "0");
sp.setString(4, "1165,1169,11610,1167,1164,1163,11613,1161,1162,11612,1166,11616");
sp.setString(5, from);
sp.setString(6, to);
sp.setString(7, String.valueOf("0"));
ResultSet rs = sp.executeQuery();
while(rs.next()){
	concat = "";
	concat = rs.getString("TRAN_NO").substring(rs.getString("TRAN_NO").length()-6);
	Label 	para0	= new Label(row, col, 	concat	,cellRIghtformat);	row++;
	Label 	para1	= new Label(row, col, 	rs.getString("PRN_TRNDATE")	,cellRIghtformat);	row++;
	Label 	para10	= new Label(row, col, 	rs.getString("PONO")	,cellRIghtformat);	row++;
	Label 	para11	= new Label(row, col, 	rs.getString("PO_DATE")	,cellRIghtformat);	row++;
	Label 	para12	= new Label(row, col, 	rs.getString("REF_TRANNO")	,cellRIghtformat);	row++;
	Label 	para13	= new Label(row, col, 	rs.getString("REF_TRANDATE")	,cellRIghtformat);	row++;
	
	Label 	para2	= new Label(row, col, 	rs.getString("SUBGL_LONGNAME")	,cellRIghtformat);	row++;
	Label 	para3	= new Label(row, col, 	rs.getString("SST_NO")	,cellRIghtformat);	row++;
	Label 	para4	= new Label(row, col, 	rs.getString("SST_DATE")	,cellRIghtformat);	row++;
	Label 	para5	= new Label(row, col, 	rs.getString("CST_NO")	,cellRIghtformat);	row++;
	Label 	para6	= new Label(row, col, 	rs.getString("CST_DATE")	,cellRIghtformat);	row++;
	Label 	para7	= new Label(row, col, 	rs.getString("MAT_NAME")	,cellRIghtformat);	row++;
	Label 	para8	= new Label(row, col, 	rs.getString("QTY")	,cellRIghtformat);	row++;
	Label 	para9	= new Label(row, col, 	rs.getString("TAX_NAME")	,cellRIghtformat);	row++;
	
	Label 	para14	= new Label(row, col, 	rs.getString("BASIC_AMT")	,cellRIghtformat);	row++;
	Label 	para15	= new Label(row, col, 	rs.getString("BASIC_DISCOUNT")	,cellRIghtformat);	row++;
	Label 	para16	= new Label(row, col, 	rs.getString("BASIC_FREIGHT")	,cellRIghtformat);	row++;
	Label 	para17	= new Label(row, col, 	rs.getString("BASIC_PACKING")	,cellRIghtformat);	row++;
	Label 	para18	= new Label(row, col, 	rs.getString("BASIC_OTHER")	,cellRIghtformat);	row++;
	Label 	para19	= new Label(row, col, 	rs.getString("ASSES_AMT")	,cellRIghtformat);	row++;
	Label 	para20	= new Label(row, col, 	rs.getString("EXCISE_DUTY")	,cellRIghtformat);	row++;
	Label 	para21	= new Label(row, col, 	rs.getString("CESS")	,cellRIghtformat);	row++;
	Label 	para22	= new Label(row, col, 	rs.getString("SERVICE_TAX")	,cellRIghtformat);	row++;
	Label 	para23	= new Label(row, col, 	rs.getString("SERVICE_CESS")	,cellRIghtformat);	row++;
	Label 	para24	= new Label(row, col, 	rs.getString("HGSEC_CESS")	,cellRIghtformat);	row++;
	Label 	para25	= new Label(row, col, 	rs.getString("HGSEC_SERV_CESS")	,cellRIghtformat);	row++;
	Label 	para26	= new Label(row, col, 	rs.getString("TAXABLE_AMT")	,cellRIghtformat);	row++;
	Label 	para27	= new Label(row, col, 	rs.getString("SALES_TAX")	,cellRIghtformat);	row++;
	Label 	para28	= new Label(row, col, 	rs.getString("DISCOUNT")	,cellRIghtformat);	row++;
	Label 	para29	= new Label(row, col, 	rs.getString("FREIGHT")	,cellRIghtformat);	row++;
	Label 	para30	= new Label(row, col, 	rs.getString("PACKING")	,cellRIghtformat);	row++;
	Label 	para31	= new Label(row, col, 	rs.getString("TCS")	,cellRIghtformat);	row++;
	Label 	para32	= new Label(row, col, 	rs.getString("ROUNDING_OFF")	,cellRIghtformat);	row++;
	Label 	para33	= new Label(row, col, 	rs.getString("OTHER")	,cellRIghtformat);	row++;
	Label 	para34	= new Label(row, col, 	rs.getString("INSURANCE")	,cellRIghtformat);	row++;
	Label 	para35	= new Label(row, col, 	rs.getString("TOTAL")	,cellRIghtformat);	



	writableSheet.addCell(para0);
	writableSheet.addCell(para1);
	writableSheet.addCell(para2);
	writableSheet.addCell(para3);
	writableSheet.addCell(para4);
	writableSheet.addCell(para5);
	writableSheet.addCell(para6);
	writableSheet.addCell(para7);
	writableSheet.addCell(para8);
	writableSheet.addCell(para9);
	writableSheet.addCell(para10);
	writableSheet.addCell(para11);
	writableSheet.addCell(para12);
	writableSheet.addCell(para13);
	writableSheet.addCell(para14);
	writableSheet.addCell(para15);
	writableSheet.addCell(para16);
	writableSheet.addCell(para17);
	writableSheet.addCell(para18);
	writableSheet.addCell(para19);
	writableSheet.addCell(para20);
	writableSheet.addCell(para21);
	writableSheet.addCell(para22);
	writableSheet.addCell(para23);
	writableSheet.addCell(para24);
	writableSheet.addCell(para25);
	writableSheet.addCell(para26);
	writableSheet.addCell(para27);
	writableSheet.addCell(para28);
	writableSheet.addCell(para29);
	writableSheet.addCell(para30);
	writableSheet.addCell(para31);
	writableSheet.addCell(para32);
	writableSheet.addCell(para33);
	writableSheet.addCell(para34);
	writableSheet.addCell(para35);

		row++;
		
		if(row==36){
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
    String filePath = "C:/reportxls/BillwisePurchase"+val+".xls";
    
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

<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer;" disabled="disabled">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>

<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</span> 
</body>
</html>