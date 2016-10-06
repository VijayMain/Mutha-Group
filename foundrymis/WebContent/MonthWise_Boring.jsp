<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script language="JavaScript">
	var nHist = window.history.length;
	if (window.history[nHist] != window.location)
		window.history.forward();
</script>
<title>Month Wise Boring</title>
</head>
<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#F7F5FC';
		} else {
			tableRow.style.backgroundColor = '#DEDFE0';
		}
	}
</script>
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th { 
	background-color: #d6d9fe; 
	border-width: 1px;
	padding: 5px;
	font-size:12px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
}

.tftable tr {
	background-color: white;
	font-size: 12px;
}

.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
<body style="font-family: Arial;">
	<%
		try {
			//		fd="+firstdate+"&ld="+lastdate+"&cp="+company+"&db="+db+"&m="+month+"&y="+year);	
			Connection con = null;
			Connection condisp = null;
			String comp = request.getParameter("cp");
			String db = request.getParameter("db");
			String month = request.getParameter("m");
			String year = request.getParameter("y");
			String firstdate = request.getParameter("fd");
			String lastdate = request.getParameter("ld");

			String CompanyName = "", matcode = "";
			
			String mnth = firstdate.substring(4, 6);
			String yrcal = firstdate.substring(0, 4);

			DecimalFormat zeroDForm = new DecimalFormat("#####0;-#####0");
			DecimalFormat twoDForm = new DecimalFormat("###,##0.00;-###,##0.00");
			DecimalFormat dForm = new DecimalFormat("#####0.00;-#####0.00");

			/******************************************************************************************/
															/* 			            Month Logic                         */
			/******************************************************************************************/
			int mnt = 0;
			String mmnt = "", passval="";
			HashMap<Integer,String>  hm = new HashMap<Integer,String>();  
			for(int h=0;h<12;h++){
			mnt = Integer.parseInt(month)-1;
			mmnt = month;
			month = new DateFormatSymbols().getMonths()[mnt].substring(0, 3);
			 passval = month + " " + year;
			 // System.out.println("Months = " + month + "  = = " + mnt + "  =  " + year.substring(2,4) + " = " + passval); 
			 hm.put((mnt+1), passval); 
			 if(mmnt.equalsIgnoreCase("1")){
					month="12"; 
					year=String.valueOf(Integer.parseInt(year)-1);
				}else{
					month = String.valueOf(Integer.parseInt(mmnt)-1);							
				}
			 if(month.equalsIgnoreCase("3")){
				 h=12;
			 }
			}
		/* 	for(Map.Entry m:hm.entrySet()){
				   System.out.println(m.getKey()+" "+m.getValue());  
			}   */
			
			/******************************************************************************************/
			
			if (comp.equalsIgnoreCase("101")) {
				CompanyName = "H-21";
				con = ConnectionUrl.getMEPLH21FMShop();
				condisp = ConnectionUrl.getMEPLH21ERP();
				PreparedStatement ps = con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='105'");
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					matcode += rs.getString("code");
				}
				rs.close();
			} else {
				CompanyName = "H-25";
				con = ConnectionUrl.getMEPLH25FMShop();
				condisp = ConnectionUrl.getMEPLH25ERP();
				PreparedStatement ps = con.prepareStatement("select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='105'");
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					matcode += rs.getString("code");
				}
				rs.close();
			}
	%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName%>&nbsp;MUTHA ENGINEERING PVT.LTD.
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Month Wise Boring Generation Status &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</strong>
	<br />
	<br />
	<strong style="font-family: Arial; font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong></b></span>
	<br />
	<div style="width: 100%; padding-left: 0.1;">
			
			<table border="1" class="tftable">
				<tbody>
					<tr>
						<th width="20">Sr.No.</th>
						<th width="155">Parameters</th>
						<%
						for(Map.Entry m:hm.entrySet()){ 
						%>
						<th><%= m.getValue().toString().substring(0, 4) %> <%= m.getValue().toString().substring(6, 8) %></th>
						<%
						}
						%>
					</tr>
					<tr>
						<td><b>1</b></td>
						<td><b>Generated Kgs</b></td>
						<%
						ArrayList bor_gentot = new ArrayList();
						ArrayList bor_ventot = new ArrayList();
						for(Map.Entry m:hm.entrySet()){
							   
							   Calendar cal = new GregorianCalendar(Integer.parseInt(m.getValue().toString().substring(4, 8)),Integer.parseInt(m.getKey().toString()), 0);
								Date date = cal.getTime();
								DateFormat sdf = new SimpleDateFormat("yyyyMMdd");			
								String last = sdf.format(date);
								String first = sdf.format(date).substring(0, 6) + "01";
 
							// exec "ENGFMSHOP"."dbo"."Sel_RptMachineWiseSetupStk";1 '101', '20150201', '20150222', 'ENGERP','10105000011010500002101050000310105000041010500005101050000610105000071010500008101050000910105000101010500011101050001210105000131010500014101050001510105000161010500017101050001810105000191010500020101050002110105000221010500023101050002410105000251010500026101050002710105000281010500029101050003010105000311010500032101050003310105000341010500035101050003610105000371010500038101050003910105000401010500041101050004210105000431010500044101050004510105000461010500047101050004810105000491010500050101050005110105000521010500053101050005410105000551010500056101050005710105000581010500059101050006010105000611010500062101050006310105000641010500065101050006610105000671010500068101050006910105000701010500071101050007210105000731010500074101050007810105000821010500083101050008610105000881010500105101050011510105001221010500123101050012410105001271010500128101050012910105001331010500135101050013610105001451010500150101050015110105001521010500158101050016010105001611010500164101050019010105002041010500205101050020810105002091010500210101050021210105002141010500215101050021610105002171010500220101050022110105002221010500223101050022410105002301010500233101050023510105002371010500241101050024210105002431010500244101050024510105002461010500248101050024910105002531010500259101050026610105002671010500272101050027310105002741010500275101050027610105002781010500279101050028110105002861010500287101050028810105002891010500290101050029110105002921010500293101050029410105002951010500296101050029710105002981010500299101050030010105003021010500303101050030410105003081010500326101050032810105003291010500330101050033410105003351010500339101050034210105003431010500344101050035010105003511010500352101050035710105003581010500359101050036010105003611010500364101050036510105003731010500374101050037510105003771010500379101050038010105003851010500386101050038710105003881010500389101050039210105003931010500415101050041910105004201010500421101050042210105004231010500424101050042510105004261010500428101050042910105004341010500435101050043710105004421010500445101050044610105004531010500454101050046910105004711010500472101050048810105004961010500522101050052310105005251010500528101050052910105005511010500552101050055310105005561010500559101050056010105005611010500576101050057710105005861010500624101050062510105006261010500629101050064010105006421010500644101050065610105006571010500661101050066310105006771010500693101050070010105007011010500707101050070810105007151010500718101050072710105007291010500754101050078210105007971010500806101050080710105008201010500992101050099710105009981010500999101050100010105010031010501021101050105810105010711010501073101050107510105010761010501109101050111010105011141010501135101050113610105011371010501138'
							 	double boringwt = 0;
								int dayct = 0;
								CallableStatement cs = con.prepareCall("{call Sel_RptMachineWiseSetupStk(?,?,?,?,?)}");
								cs.setString(1, comp);
								cs.setString(2, first);
								cs.setString(3, last);
								cs.setString(4, db);
								cs.setString(5, matcode); 
								int d = 1;
								String brwt = "", prdqty = "";
								boringwt = 0; 
								ResultSet rs = cs.executeQuery(); 
								while (rs.next()) {
											brwt = rs.getString("BORING_WT");
											prdqty = rs.getString("PROD_QTY");
											if (brwt == null || brwt.length() == 0) {
												brwt = "0";
											} 
											if (prdqty == null || prdqty.length() == 0) {
												prdqty = "0";
											}
											boringwt += (Double.parseDouble(brwt) * Double.parseDouble(prdqty));
									 		d++;
									}
								rs.close();
								String total = dForm.format(boringwt);  
								bor_gentot.add(total);
						%>
						<td align="right"><%=total %> </td>
						<%
						}
						%>
					</tr> 
					<tr>
						<td><b>2</b></td>
						<td><b>Vendor Receipt Kgs</b></td>
				<% 
				for(Map.Entry m:hm.entrySet()){ 
					Calendar cal = new GregorianCalendar(Integer.parseInt(m.getValue().toString().substring(4, 8)),Integer.parseInt(m.getKey().toString()), 0);
					Date date = cal.getTime();
					DateFormat sdf = new SimpleDateFormat("yyyyMMdd");			
					String last = sdf.format(date);
					String first = sdf.format(date).substring(0, 6) + "01";
					
				String chl="",chl_sap="";
				double chqty=0;
				//exec "ENGERP"."dbo"."Sel_BoringRegister";1 '101', '0', '20140401', '20150223', '103,131'
				CallableStatement csvend = condisp.prepareCall("{call Sel_BoringRegister(?,?,?,?,?)}");
				csvend.setString(1,comp);
				csvend.setString(2,"0");
				csvend.setString(3,first);
				csvend.setString(4,last);
				csvend.setString(5,"103,131");
				ResultSet rsvend = csvend.executeQuery();
					while(rsvend.next()){ 
							chl = rsvend.getString("CHLN_QTY");
							if(chl==null || chl.length()==0){
								chl = "0";
							} 
							chqty += Double.parseDouble(chl); 
					}
					bor_ventot.add(dForm.format(chqty));
				/************************************************************************************************************/
				%>
				<td align="right"><%= dForm.format(chqty) %></td>
				<%
				}
				%>
					</tr> 
					<tr>
						<td><b>3</b></td>
						<td><b>Sum of Boring Kgs</b></td>
						<%
						double sum_bor =0;
						for(int br=0;br<bor_gentot.size();br++){
							sum_bor = Double.parseDouble(bor_gentot.get(br).toString()) + Double.parseDouble(bor_ventot.get(br).toString());
						%>
						<td align="right"><%=dForm.format(sum_bor) %></td>
						<%	
						} 
						%>
					</tr>
					<tr>
						<td><b>4</b></td>
						<td><b>Jobwork Boring Issue Kgs</b></td>
						<%   
						for(Map.Entry m:hm.entrySet()){
							Calendar cal = new GregorianCalendar(Integer.parseInt(m.getValue().toString().substring(4, 8)),Integer.parseInt(m.getKey().toString()), 0);
							Date date = cal.getTime();
							DateFormat sdf = new SimpleDateFormat("yyyyMMdd");			
							String last = sdf.format(date);
							String first = sdf.format(date).substring(0, 6) + "01";
		                ArrayList boringlist = new ArrayList();
		                double sumjobwk = 0; 
		                boringlist.add("1013100002");
		                boringlist.add("1013100007");
		                boringlist.add("1013100015");
		                boringlist.add("1013100016");
		                boringlist.add("1013100017"); 
		                CallableStatement cs_jobwork = condisp.prepareCall("{call Sel_RptPurchaseReturn(?,?,?,?,?)}");
		                cs_jobwork.setString(1,comp);
		                cs_jobwork.setString(2,"0");
		                cs_jobwork.setString(3,"21311");
		                cs_jobwork.setString(4,first);
		                cs_jobwork.setString(5,last);
						ResultSet rs_jobwork = cs_jobwork.executeQuery();
						while(rs_jobwork.next()){
							for(int i=0;i<boringlist.size();i++){
								if(boringlist.get(i).toString().equalsIgnoreCase(rs_jobwork.getString("MAT_CODE"))){
									sumjobwk = sumjobwk + Double.parseDouble(rs_jobwork.getString("CHLN_QTY")); 
							}
						} 
						}
		                %> 
						<td align="right"><%= dForm.format(sumjobwk)%></td>
						<%
						}
						%>
					</tr> 
					<tr>
						<td><b>5</b></td>
						<td><b>Dispatched Kgs</b></td> 
				<%
				HashMap brg_dispatch = new HashMap();
				double disQty=0,totalDisp=0;
				// exec "ENGERP"."dbo"."Sel_SaleRegister";1 '101', '0', '20150201', '20150222', '1155', '0'
				CallableStatement csdes = condisp.prepareCall("{call Sel_SaleRegister(?,?,?,?,?,?)}");
				csdes.setString(1,comp);
				csdes.setString(2, "0");
				csdes.setString(3,firstdate);
				csdes.setString(4,lastdate);
				csdes.setString(5,"1155");
				csdes.setString(6,"0");
				ResultSet rsdes = null; 
				for(int i=1;i<=Integer.parseInt(ct);i++){
					disQty=0;
					aFormatted = formatter.format(i);
		 			dateTocomp=st+aFormatted; 
		 			rsdes = csdes.executeQuery();
		 			while(rsdes.next()){
					if(rsdes.getString("TRAN_DATE").equalsIgnoreCase(dateTocomp) &&
							(rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100007") ||
							rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100002") ||
							 rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100016") || 
							 rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100017"))){ 
						 disQty += Double.parseDouble(rsdes.getString("QTY"));
						}
		 			}
		 			brg_dispatch.put(i, disQty);
		 			totalDisp += disQty;
				}
				%>	
						
						<td>&nbsp;</td>
					</tr>
				</tbody>
			</table>
			<!--============================================================================-->
			<!--============================================================================-->
	</div>

	<%
		con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>