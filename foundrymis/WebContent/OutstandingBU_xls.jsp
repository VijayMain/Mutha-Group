<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
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
<title>Internal Rejection EXCEL</title>
</head>
<body> 
<%
try {
	Connection con =null;
	String comp = request.getParameter("comp");
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String cust = request.getParameter("cust");
	
	Calendar cal = new GregorianCalendar(Integer.parseInt(year),Integer.parseInt(month),0);
	Date date = cal.getTime();
	DateFormat sdf = new SimpleDateFormat("yyyyMMdd");			
	String lastdate = sdf.format(date);
	String firstdate = sdf.format(date).substring(0, 6) + "01";
	
	String fromDate = firstdate.substring(6,8) +"/"+ firstdate.substring(4,6) +"/"+ firstdate.substring(0,4);
	String toDate = lastdate.substring(6,8) +"/"+ lastdate.substring(4,6) +"/"+ lastdate.substring(0,4);

	DecimalFormat twoDForm = new DecimalFormat("###0.00");
	int row=0,col=1;  
	
	String group="";
	int ct=0;
	String CompanyName="",trn_no="",cust_name ="";
	if(comp.equalsIgnoreCase("101")){
		CompanyName = "H-21";
		con = ConnectionUrl.getMEPLH21ERP();
		trn_no = "101161711511";
		PreparedStatement ps_gl = con.prepareStatement(" select * from MSTACCTGLSUB where SUB_GLACNO="+cust);
		ResultSet rs_gl = ps_gl.executeQuery();
		while(rs_gl.next()){
			cust_name = rs_gl.getString("SUBGL_LONGNAME");
		} 
	}else{
		CompanyName = "H-25";
		con	= ConnectionUrl.getMEPLH25ERP();
		trn_no = "102161711511";
		PreparedStatement ps_gl = con.prepareStatement(" select * from MSTACCTGLSUB where SUB_GLACNO="+cust);
		ResultSet rs_gl = ps_gl.executeQuery();
		while(rs_gl.next()){
			cust_name = rs_gl.getString("SUBGL_LONGNAME");
		} 
	}
	 
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";  
	
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/OutstandBU"+val+".xls");
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
 
    writableSheet.setColumnView(0, 15);
    writableSheet.setColumnView(1, 15);
    writableSheet.setColumnView(2, 15);  
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    cellRIghtformat.setAlignment(Alignment.RIGHT);
    
    WritableCellFormat cellFormatWrap = new WritableCellFormat();
    cellFormatWrap.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellFormatWrap.setFont(font);
    cellFormatWrap.setAlignment(Alignment.RIGHT); 
    cellFormatWrap.setWrap(true);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font); 	
    cellleftformat.setAlignment(Alignment.LEFT);
    
    Label label = new Label(0, 0, "INVOICE NO",cellFormat);
    Label label1 = new Label(1, 0, "INVOICE DATE",cellFormat);
    Label label2 = new Label(2, 0, "INVOICE AMT",cellFormat); 
  
 // Add the created Cells to the sheet
    writableSheet.addCell(label);
    writableSheet.addCell(label1);
    writableSheet.addCell(label2);   

    
PreparedStatement psBU = con.prepareStatement("select RIGHT(CONVERT( VARCHAR, TRNACCTMATH.TRAN_NO), 6)  AS INV_NO,DBO.FORMAT_DATE(TRAN_DATE) as TRAN_DATE, TRAN_AMT from TRNACCTMATH where TRAN_NO LIKE '"+trn_no+"%' AND SUB_GLACNO1 ="+cust+" AND TRAN_DATE BETWEEN  "+firstdate+"  AND "+lastdate+" AND STATUS_CODE =0");
ResultSet rsBU = psBU.executeQuery();
while(rsBU.next()){

Label po_nolbl = new Label(row, col, rsBU.getString("INV_NO"),cellRIghtformat);
row++;
Label amdatelbl = new Label(row, col,rsBU.getString("TRAN_DATE"),cellRIghtformat);
row++;
Label witheffectlbl = new Label(row, col,rsBU.getString("TRAN_AMT"),cellRIghtformat);
row++; 
writableSheet.addCell(po_nolbl); 
writableSheet.addCell(amdatelbl);
writableSheet.addCell(witheffectlbl); 
if(row==3){
	row=0;
	col++;
}
}

	//Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/OutstandBU"+val+".xls"; 
%>
<span id="exportId"> 
<button id="filebutton"  onclick="getExcel_Report('<%=comp%>','<%=month%>','<%=year %>','<%=cust %>')"  style="cursor: pointer;" disabled="disabled">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>