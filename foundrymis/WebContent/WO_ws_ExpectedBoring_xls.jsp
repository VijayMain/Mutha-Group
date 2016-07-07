<%@page import="java.util.Collections"%>
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
	Connection con =null;   
	String comp =request.getParameter("comp"); 
	String from =request.getParameter("from");
	String to =request.getParameter("to");  
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

	DecimalFormat twoDForm = new DecimalFormat("###0.00"); 
	 
	int ct=0;
	String CompanyName="";  
	if(comp.equalsIgnoreCase("103")){
		CompanyName = "MUTHA FOUNDERS PVT. LTD.";
		con = ConnectionUrl.getFoundryERPNEWConnection();   
	} 
		
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";  
	
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/ReportBS"+val+".xls");
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
 	CallableStatement cs11 = con.prepareCall("{call Sel_RptWOWiseBoringDetail(?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,from);
	cs11.setString(4,to); 
	ResultSet rs1 = cs11.executeQuery(); 
	while(rs1.next()){
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

Number sr_nolbl = new Number(row, col,srno ,cellRIghtformat);
srno ++; 
row++;
Label party_lbl = new Label(row, col,pName.get(parts[0].toString()).toString() ,cellleftformat);
row++;
Number part1_lbl = new Number(row, col, Double.parseDouble(parts[1].toString()),cellRIghtformat);
row++;
Number part2_lbl = new Number(row, col, Double.parseDouble(parts[2].toString()),cellRIghtformat);
row++;
Number part3_lbl = new Number(row, col, Double.parseDouble(parts[3].toString()),cellRIghtformat);
row++;
Number part4_lbl = new Number(row, col, Double.parseDouble(parts[4].toString()),cellRIghtformat); 

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
  //************************************************************************************************************************
  //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
    //Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/ReportBS"+val+".xls";
    
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