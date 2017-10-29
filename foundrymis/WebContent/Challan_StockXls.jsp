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
	    String comp =request.getParameter("company"); 
	    String from =request.getParameter("date_from"); 
	    String to =request.getParameter("date_to");
	   
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
	     
	    String fromDate = from.substring(8,10) +"/"+ from.substring(5,7) +"/"+ from.substring(0,4);
	    String toDate = to.substring(8,10) +"/"+ to.substring(5,7) +"/"+ to.substring(0,4);

	    String sqlfromDate = from.substring(0,4)   + from.substring(5,7)  + from.substring(8,10);
	    String sqltoDate = to.substring(0,4) + to.substring(5,7) + to.substring(8,10);  
	    
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
 	int val = listOfFiles.length + 1; 
	File exlFile = new File("C:/reportxls/ChallanStock"+val+".xls");
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
    
    writableSheet.setColumnView(0, 10);
    writableSheet.setColumnView(1, 25);
    writableSheet.setColumnView(2, 25);
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
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font); 				
        
    Label label0 = new Label(0, 0,"Desp. No.",cellFormat);
    Label label1 = new Label(1, 0,"Supplier Name",cellFormat);
    Label label10 = new Label(2, 0,"Item Name",cellFormat);
    Label label11 = new Label(3, 0,"Date",cellFormat);
    Label label12 = new Label(4, 0,"Desp. Qty.",cellFormat);
    Label label13 = new Label(5, 0,"Rec. No.",cellFormat); 
    Label label2 = new Label(6, 0,"Chln No.",cellFormat);
    Label label3 = new Label(7, 0,"Date",cellFormat);
    Label label4 = new Label(8, 0,"OK",cellFormat);
    Label label5 = new Label(9, 0,"MR",cellFormat);
    Label label6 = new Label(10, 0,"CR",cellFormat);
    Label label7 = new Label(11, 0,"CAST",cellFormat);
    Label label8 = new Label(12, 0,"SCRAP",cellFormat);
    Label label9 = new Label(13, 0,"Total Rec.",cellFormat); 
    Label label14 = new Label(14, 0,"Chln. Balance",cellFormat);
    Label label15 = new Label(15, 0,"Balance",cellFormat);
    Label label16 = new Label(16, 0,"Process Type",cellFormat); 

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
 
    //***********************************************************************************************************************************
ArrayList codes = new ArrayList();
PreparedStatement ps=con.prepareStatement("SELECT SUB_GLACNO FROM MSTACCTGLSUB WHERE SUB_GLCODE =12");
 ResultSet rs3=ps.executeQuery();
 while(rs3.next()){
	  codes.add(rs3.getString("SUB_GLACNO"));
 }
 
 Connection conLocal = ConnectionUrl.getLocalDatabase();
 
 PreparedStatement ps_local = null,ps_localmax = null,ps_localPrev = null; 
 ResultSet rs_localmax=null,rs_localPrev=null; 
 for(int i=0;i<codes.size();i++){
	  if(i==0){
 ps_local = conLocal.prepareStatement("insert into purchase_overdues_tbl(value,enable)values(?,?)");
 ps_local.setString(1, codes.get(i).toString());
 ps_local.setInt(2, 1);
 ps_local.executeUpdate(); 
	  }else{
		  ps_localmax = conLocal.prepareStatement("select max(overdue_id) from purchase_overdues_tbl");
		  rs_localmax = ps_localmax.executeQuery();
		  while (rs_localmax.next()) {
			 ct = rs_localmax.getInt("max(overdue_id)");
		}
		  ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
		  rs_localPrev=ps_localPrev.executeQuery();
		  while (rs_localPrev.next()) { 	  
		  ps_local = conLocal.prepareStatement("update purchase_overdues_tbl set value=? where overdue_id="+ct);
		  ps_local.setString(1, rs_localPrev.getString("value") + codes.get(i).toString()); 
		  ps_local.executeUpdate(); 
		  }
	  }
 }
 
CallableStatement cs = con.prepareCall("{call Sel_SubContractStockLedgerMutha(?,?,?,?,?,?)}");
cs.setString(1, comp);
cs.setString(2, "0");
ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
rs_localPrev=ps_localPrev.executeQuery();
while (rs_localPrev.next()) {
cs.setString (3,rs_localPrev.getString("value"));
}
cs.setString(4, sqlfromDate);
cs.setString(5, sqltoDate);
cs.setString(6, "101");
ResultSet rs = cs.executeQuery();
double tot_rec = 0,chl_bal=0,TRNNO=0,DESP_QTY=0,RCPT_TRNNO=0,RCPT_DC_QTY=0,RCPT_SCRAP_QTY=0,
								RCPT_CR_QTY=0,RCPT_CAST_QTY=0,tr_chl_bal=0,tr_desp_Qty=0,trno = 0;
boolean flagchk = false;
while(rs.next()){
	if(!rs.getString("TRNNO").equalsIgnoreCase("")){
		TRNNO = Double.valueOf(rs.getString("TRNNO"));
	}
	if(!rs.getString("DESP_QTY").equalsIgnoreCase("")){
		DESP_QTY = Double.valueOf(rs.getString("DESP_QTY"));
	} 
	if(!rs.getString("RCPT_TRNNO").equalsIgnoreCase("")){
		RCPT_TRNNO = Double.valueOf(rs.getString("RCPT_TRNNO"));
	} 
	if(!rs.getString("RCPT_DC_QTY").equalsIgnoreCase("")){
		RCPT_DC_QTY = Double.valueOf(rs.getString("RCPT_DC_QTY"));
	}
if(!rs.getString("RCPT_SCRAP_QTY").equalsIgnoreCase("")){
	RCPT_SCRAP_QTY = Double.valueOf(rs.getString("RCPT_SCRAP_QTY"));
	}
if(!rs.getString("RCPT_CR_QTY").equalsIgnoreCase("")){
	RCPT_CR_QTY = Double.valueOf(rs.getString("RCPT_CR_QTY"));
}
if(!rs.getString("RCPT_CAST_QTY").equalsIgnoreCase("")){
	RCPT_CAST_QTY = Double.valueOf(rs.getString("RCPT_CAST_QTY"));
}
if(!rs.getString("RCPT_SCRAP_QTY").equalsIgnoreCase("")){
	RCPT_SCRAP_QTY = Double.valueOf(rs.getString("RCPT_SCRAP_QTY"));
}


if(trno!=0 && trno==TRNNO){
	tr_desp_Qty = tr_chl_bal;
	flagchk =true;
}else{
	tr_desp_Qty = DESP_QTY;
}


	Number 	para0	= new Number(row, col,TRNNO ,cellRIghtformat);	row++;
	Label 	para1	= new Label(row, col, 	rs.getString("AC_NAME")	,cellRIghtformat);	row++;
	Label 	para10	= new Label(row, col, 	rs.getString("NAME")	,cellRIghtformat);	row++;
	Label 	para11	= new Label(row, col, 	rs.getString("PRN_TRANDATE")	,cellRIghtformat);	row++;
	 
	if(flagchk==true){
		Label 	para12	= new Label(row, col, "" ,cellRIghtformat);	row++;
		writableSheet.addCell(para12);
	}else{
	Number 	para12	= new Number(row, col, DESP_QTY,cellRIghtformat);	row++;
	writableSheet.addCell(para12);
	}
	
	Number 	para13	= new Number(row, col, RCPT_TRNNO	,cellRIghtformat);	row++; 
	Label 	para2	= new Label(row, col, rs.getString("RCPT_CHLNNO")	,cellRIghtformat);	row++;
	Label 	para3	= new Label(row, col, 	rs.getString("RCPT_TRAN_DATE")	,cellRIghtformat);	row++;
	Number 	para4	= new Number(row, col, RCPT_DC_QTY,cellRIghtformat);	row++;
	Number 	para5	= new Number(row, col, RCPT_SCRAP_QTY	,cellRIghtformat);	row++;
	Number 	para6	= new Number(row, col, RCPT_CR_QTY	,cellRIghtformat);	row++;
	Number 	para7	= new Number(row, col, RCPT_CAST_QTY,cellRIghtformat);	row++;
	Number 	para8	= new Number(row, col, RCPT_SCRAP_QTY	,cellRIghtformat);	row++;
	
	tot_rec = Double.valueOf(rs.getString("RCPT_DC_QTY")) +
			Double.valueOf(rs.getString("RCPT_SCRAP_QTY")) +
			Double.valueOf(rs.getString("RCPT_CR_QTY"))+
			Double.valueOf(rs.getString("RCPT_CAST_QTY"))+
			Double.valueOf(rs.getString("RCPT_SCRAP_QTY"));
	chl_bal = Double.valueOf(rs.getString("DESP_QTY")) - tot_rec;
	
	Number 	para9	= new Number(row, col, 	tot_rec	,cellRIghtformat);	row++; 
	Number 	para14	= new Number(row, col, 	chl_bal	,cellRIghtformat);	row++;
	Number 	para15	= new Number(row, col, 	chl_bal	,cellRIghtformat);	row++;
	Label 	para16	= new Label(row, col, 	rs.getString("PROCESS_TYPE")	,cellRIghtformat);	row++;
	
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
	
	writableSheet.addCell(para13);
	writableSheet.addCell(para14);
	writableSheet.addCell(para15);
	writableSheet.addCell(para16); 

		row++;
		
		trno = TRNNO;
		tr_chl_bal = chl_bal; 
		flagchk=false;
		
		tot_rec = 0;
		chl_bal =0;
		TRNNO=0;
		DESP_QTY=0;RCPT_TRNNO=0;RCPT_DC_QTY=0;
		RCPT_SCRAP_QTY=0;RCPT_CR_QTY=0;RCPT_CAST_QTY=0;
		if(row==18){
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
    String filePath = "C:/reportxls/ChallanStock"+val+".xls";
    
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