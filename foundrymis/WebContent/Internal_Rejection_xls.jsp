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
	String comp =request.getParameter("comp");
	String from =request.getParameter("from");
	String to =request.getParameter("to");
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

	DecimalFormat twoDForm = new DecimalFormat("###0.00");
	int row=0,col=1,srno=1;  
	
	HashMap res_hm = new HashMap();
	int ct=0;
	String CompanyName="",maindb="",par="";

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
	
	
	// exec "DIFMSHOP"."dbo"."Sel_RptInternalRejection_MARV";1 '105', '0', '20150701', '20150726', 'DIERP'		
			ArrayList matList = new ArrayList();
			ArrayList reasonList = new ArrayList();
			ResultSet rs_temp = null;
			
			CallableStatement cs11 = con.prepareCall("{call Sel_RptInternalRejection_MARV(?,?,?,?,?)}");
			cs11.setString(1,comp);
			cs11.setString(2,"0");
			cs11.setString(3,from);
			cs11.setString(4,to);
			cs11.setString(5,maindb);
			ResultSet rs = cs11.executeQuery();
			
			while(rs.next()){
				matList.add(rs.getString("MAT_NAME"));
				reasonList.add(rs.getString("REASON")); 
			}
			rs.close();
			
			HashSet hs_mat = new HashSet();
			hs_mat.addAll(matList);
			matList.clear();
			matList.addAll(hs_mat); 
			
			HashSet hs_res = new HashSet();
			hs_res.addAll(reasonList);
			reasonList.clear();
			reasonList.addAll(hs_res);
			
			ArrayList temp = new ArrayList();	
			
			
			
	
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";  
	
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/InterRej"+val+".xls");
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
    
 
    
    writableSheet.setColumnView(0, 40);
    writableSheet.setColumnView(1, 10);
    writableSheet.setColumnView(2, 10);
    writableSheet.setColumnView(3, 10);
    writableSheet.setColumnView(4, 10);
    
    int res = 5;
    for(int i=0;i<reasonList.size();i++){
    
    writableSheet.setColumnView(res, 10);
    res++;
    writableSheet.setColumnView(res, 10);
    res++;
    
    }
    
    writableSheet.setColumnView(res, 10);
    res++;
    writableSheet.setColumnView(res, 10);
    
    
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
    
    Label label = new Label(0, 0, "Name of Item",cellFormat);
    Label label1 = new Label(1, 0, "Casting Wt",cellFormat);
    Label label2 = new Label(2, 0, "Production Qty",cellFormat);
    Label label3 = new Label(3, 0, "Production Wgt",cellFormat);
    Label label4 = new Label(4, 0, "Total Rej %",cellFormat);
  
 // Add the created Cells to the sheet
    writableSheet.addCell(label);
    writableSheet.addCell(label1);
    writableSheet.addCell(label2);
    writableSheet.addCell(label3);
    writableSheet.addCell(label4);
    
    int res1 = 5;
    for(int i=0;i<reasonList.size();i++){
    Label label5 = new Label(res1, 0, reasonList.get(i).toString(),cellFormat);
    writableSheet.addCell(label5);
    res1++;
    // Label label6 = new Label(res1, 0, "%" + reasonList.get(i).toString(),cellFormat);
    // writableSheet.addCell(label6);
    // res1++;
    }
    
    Label label7 = new Label(res1, 0, "Total No",cellFormat);
    res1++;
    Label label8 = new Label(res1, 0, "Total wgt.",cellFormat);
   
    writableSheet.addCell(label7);
    writableSheet.addCell(label8);    
  	//***********************************************************************************************************************************
    double qty = 0,tot_no=0,perRej=0;
	String ctwt = "",prd_qty="",prd_wt="";
	
	ResultSet rs_ctwt = null;
	for(int i3=0;i3<matList.size();i3++){
		rs_ctwt = cs11.executeQuery();
		while(rs_ctwt.next()){
			if(rs_ctwt.getString("MAT_NAME").equalsIgnoreCase(matList.get(i3).toString())){
				ctwt = rs_ctwt.getString("CASTING_WT");
				prd_qty = rs_ctwt.getString("PRODUCT_QTY");
				prd_wt = rs_ctwt.getString("PRODUCT_WGT");
				tot_no = Double.parseDouble(rs_ctwt.getString("QTY")) + tot_no;
			}
		}
		if(prd_qty==null){
			prd_qty = "0";
		}
		if(prd_wt==null){
			prd_wt ="0";
		}
		perRej = (tot_no/ Double.parseDouble(prd_qty))*100; 
    //***********************************************************************************************************************************

Label po_nolbl = new Label(row, col, matList.get(i3).toString(),cellleftformat);
srno ++; 
row++; 
Label amdatelbl = new Label(row, col, twoDForm.format(Double.parseDouble(ctwt)),cellRIghtformat);
row++;
Label witheffectlbl = new Label(row, col,twoDForm.format(Double.parseDouble(prd_qty)),cellRIghtformat);
row++;
Label srnolbl = new Label(row, col,twoDForm.format(Double.parseDouble(prd_wt)),cellRIghtformat);
row++;
Label supnamelbl = new Label(row, col,twoDForm.format(perRej),cellRIghtformat);
row++;


writableSheet.addCell(po_nolbl); 
writableSheet.addCell(amdatelbl);
writableSheet.addCell(witheffectlbl);
writableSheet.addCell(srnolbl);
writableSheet.addCell(supnamelbl);


for(int i1=0;i1<reasonList.size();i1++){
	qty = 0;
rs_temp = cs11.executeQuery();
while(rs_temp.next()){
	if(matList.get(i3).toString().equalsIgnoreCase(rs_temp.getString("MAT_NAME")) && rs_temp.getString("REASON").equalsIgnoreCase(reasonList.get(i1).toString())){
		res_hm.put(reasonList.get(i1).toString(), rs_temp.getString("QTY"));
	}
}
if(res_hm.get(reasonList.get(i1).toString())==null){
	Number wtkglbl = new Number(row, col,0,cellRIghtformat);
	row++;
	/* Number rskglbl = new Number(row, col,0,cellRIghtformat);
	row++; */
	writableSheet.addCell(wtkglbl);
	// writableSheet.addCell(rskglbl); 
}else{
	par = res_hm.get(reasonList.get(i1).toString()).toString();
	qty = (Double.parseDouble(par) / Double.parseDouble(prd_qty))*100;

Label wtkglbl = new Label(row, col,twoDForm.format(Double.parseDouble(par)) +" " +twoDForm.format(qty)+"%",cellFormatWrap);
row++;
/* Label rskglbl = new Label(row, col,twoDForm.format(qty),cellRIghtformat);
row++; */ 
writableSheet.addCell(wtkglbl);
// writableSheet.addCell(rskglbl); 
} 
}
Label totnolbl = new Label(row, col,twoDForm.format(tot_no),cellRIghtformat);
row++;
Label qtylbl = new Label(row, col,twoDForm.format(qty),cellRIghtformat);
row++;

writableSheet.addCell(totnolbl);
writableSheet.addCell(qtylbl);
System.out.println("Rows = "+row);
		row=0;
		col++; 
		par="";
		prd_qty="";
		tot_no=0;
		qty = 0;
		res_hm.clear();
	}		
  //************************************************************************************************************************
  //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
    //Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/InterRej"+val+".xls";
    
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
    // forces download
    String headerKey = "Content-Disposition";
    String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
    response.setHeader(headerKey, headerValue); 
    inStream.close(); */ 
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