<%@page import="java.sql.Statement"%> 
<%@page import="java.text.Normalizer.Form"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<html>
<head>
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script>
<title>Purchase vs Sale</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 {
	font-size: 10px;
	border-width: 1px;
	border-style: solid;
	border-color: #729ea5;
}

.tftable tr {
	background-color: white;
	font-size: 10px;
}

.th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
}

A:link {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

A:visited {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

.div_freezepanes_wrapper {
	font-size: 10px;
	position: relative;
	width: 99%;
	height: 550px;
	overflow: hidden;
	background: #fff;
	border-style: ridge;
}

.div_verticalscroll {
	font-size: 10px;
	position: absolute;
	right: 0px;
	width: 18px;
	height: 100%;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonUp {
	width: 20px;
	position: absolute;
	top: 2px;
}

.buttonDn {
	width: 20px;
	position: absolute;
	bottom: 22px;
}

.div_horizontalscroll {
	font-size: 10px;
	position: absolute;
	bottom: 0px;
	width: 0%;
	height: 0px;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonRight {
	width: 20px;
	position: absolute;
	left: 0px;
	padding-top: 2px;
}

.buttonLeft {
	width: 20px;
	position: absolute;
	right: 22px;
	padding-top: 2px;
}
</STYLE>
<script type="text/javascript">
	function getExcel_Report(comp,from,to) {
		document.getElementById("fileloading").style.visibility = "visible";
		document.getElementById("filebutton").disabled = true; 
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("exportId").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "RM_Consumption_xl.jsp?comp=" + comp +"&from="+from+"&to="+to, true);
		xmlhttp.send();
	};
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<%
try{
Connection con =null; 
String comp =request.getParameter("comp");
String from =request.getParameter("from"); 
String to =request.getParameter("to");   

String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

DecimalFormat zeroDForm = new DecimalFormat("###0.00");
DecimalFormat noDForm = new DecimalFormat("####0");
 
int ct=0;
String CompanyName="";  
PreparedStatement ps_acctsale=null,ps_matvalue=null,ps_bomraw=null,psname=null,ps_extra=null;
ResultSet rs_acctsale=null,rs_matvalue=null,rs_bomraw=null,rsname=null,rs_extra=null;

ArrayList matcode = new ArrayList();
HashMap refCode = new HashMap();

if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21";
	con = ConnectionUrl.getMEPLH21ERP();
	ps_acctsale=con.prepareStatement("select * from ENGERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE like '10101%' and TRAN_DATE between "+from+" and "+to +" and STATUS_CODE='0'");
	rs_acctsale=ps_acctsale.executeQuery();
	while(rs_acctsale.next()){
		matcode.add(rs_acctsale.getString("MAT_CODE"));
	} 
	ps_matvalue=con.prepareStatement("select * from ENGERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE like '10103%'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to);
	rs_matvalue=ps_matvalue.executeQuery(); 
	
	ps_extra=con.prepareStatement("select * from ENGERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE like '10103%'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to);
	rs_extra=ps_extra.executeQuery();
	
	ps_bomraw=con.prepareStatement("select * from ENGERP..MSTMATBOMRAW");
	rs_bomraw=ps_bomraw.executeQuery();
	while(rs_bomraw.next()){
		refCode.put(rs_bomraw.getString("MAT_CODE"),rs_bomraw.getString("REF_MATCODE"));
	}
	 
	
	/* psname=con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='103'");
	rsname=psname.executeQuery();
	while(rs_bomraw.next()){
		refCode.put(rs_bomraw.getString("MAT_CODE"),rs_bomraw.getString("REF_MATCODE"));
	} */
	
}
if(comp.equalsIgnoreCase("102")){
	CompanyName = "H-25";
	con	= ConnectionUrl.getMEPLH25ERP();
	ps_acctsale=con.prepareStatement("select * from H25ERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE like '10101%'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to);
	rs_acctsale=ps_acctsale.executeQuery();
	while(rs_acctsale.next()){
		matcode.add(rs_acctsale.getString("MAT_CODE")); 
	} 
	ps_matvalue=con.prepareStatement("select * from H25ERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE like '10103%'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to);
	rs_matvalue=ps_matvalue.executeQuery();
	
	ps_extra=con.prepareStatement("select * from H25ERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE like '10103%'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to);
	rs_extra=ps_extra.executeQuery();
	
	ps_bomraw=con.prepareStatement("select * from H25ERP..MSTMATBOMRAW");
	rs_bomraw=ps_bomraw.executeQuery();
	while(rs_bomraw.next()){ 
		refCode.put(rs_bomraw.getString("MAT_CODE"),rs_bomraw.getString("REF_MATCODE"));
	}
} 
double saleqty = 0 , puramt=0 , purQty=0,saleamt=0,purAvg=0,saleAvg=0,per=0;
String name = "",query1="",query2="",query3="",queryasb="";
int sr=1; 

HashSet hs = new HashSet();
hs.addAll(matcode);   
matcode.clear();
matcode.addAll(hs);

PreparedStatement ps_chk=null,ps_chk1=null,ps_matname=null,ps_assembly=null,assemblyPSSale=null;
ResultSet rs_chk=null,rs_chk1=null,rs_matname=null,rs_assembly=null,assemblyRSSale;  

%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD.
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Purchase
		vs Sale &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</strong>
	<br />

	<strong style="font-family: Arial; font-size: 13px;"><a
		href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<%-- <span id="exportId">
		<button id="filebutton"
			onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')"
			style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate
			Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading"
		style="visibility: hidden;" />
	</span> --%>

	<div class="div_freezepanes_wrapper">
		<div class="div_verticalscroll"
			onmouseover="this.style.cursor='pointer'">
			<div style="height: 50%;" onmousedown="upp();" onmouseup="upp(1);">
				<img class="buttonUp" src="images/up.png">
			</div>
			<div style="height: 50%;" onmousedown="down();" onmouseup="down(1);">
				<img class="buttonDn" src="images/down.png">
			</div>
		</div>
		<div class="div_horizontalscroll"
			onmouseover="this.style.cursor='pointer'">
			<div style="float: left; width: 50%; height: 100%;"
				onmousedown="right();" onmouseup="right(1);">
				<img class="buttonRight" src="images/left.png">
			</div>
			<div style="float: right; width: 50%; height: 100%;"
				onmousedown="left();" onmouseup="left(1);">
				<img class="buttonLeft" src="images/forward.png">
			</div>
		</div>
		<table id="t1" class="t1" border="1" style="width: 97%; border: 1px solid #000;">
			<tr style="font-size: 12px; font-family: Arial;">
				<th scope="col" class="th" width="4%">Sr.No</th>
				<th scope="col" class="th" width="45%">Item Name</th>
				<th scope="col" class="th" width="10%">Purchase Qty</th>
				<th scope="col" class="th" width="10%">Sale Qty</th>
				<th scope="col" class="th" width="10%">Purchase Avg Rate Rs.</th>
				<th scope="col" class="th" width="10%">Purchase amt in Rs.</th>
				<th scope="col" class="th" width="10%">Sale Avg Rate Rs.</th>
				<th scope="col" class="th" width="10%">Sale amt in Rs.</th>
				<th scope="col" class="th" width="10%">%</th>
			</tr>
			<%		 
			for(int i=0;i<matcode.size();i++){
				if(comp.equalsIgnoreCase("101")){
					//	System.out.println("System Data = " +matcode.get(i).toString()+"  ==  "+ refCode.get(matcode.get(i).toString()));
					query1 = "select * from ENGERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE like '10101%' and MAT_CODE='"+matcode.get(i).toString()+"'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to;
					
					if(refCode.get(matcode.get(i).toString())!=null){
					query2 = "select * from ENGERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE like '10103%' and MAT_CODE='"+refCode.get(matcode.get(i).toString())+"'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to;
					query3 = "select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='103' and  CODE = '"+refCode.get(matcode.get(i).toString())+"'";
					}else{ 
					queryasb = "select * from ENGERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE =" +matcode.get(i).toString() + " and TRAN_DATE between "+from+" and "+to+" and STATUS_CODE='0'";
 					}
				}
				if(comp.equalsIgnoreCase("102")){
					query1 = "select * from H25ERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE like '10101%' and MAT_CODE='"+matcode.get(i).toString()+"'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to;
					
					if(refCode.get(matcode.get(i).toString())!=null){
					query2 = "select * from H25ERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE like '10103%' and MAT_CODE='"+ refCode.get(matcode.get(i).toString())+"'  and STATUS_CODE='0' and TRAN_DATE between "+from+" and "+to;
					query3 = "select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='103' and CODE ='"+refCode.get(matcode.get(i).toString())+"'";
					}else{
						queryasb = "select * from H25ERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE =" +matcode.get(i).toString() + " and TRAN_DATE between "+from+" and "+to+" and STATUS_CODE='0'";
					}
				}
				
				
				ps_chk = con.prepareStatement(query1);
				rs_chk = ps_chk.executeQuery();
				
				if(refCode.get(matcode.get(i).toString())!=null){
					ps_matname = con.prepareStatement(query3);
					rs_matname = ps_matname.executeQuery();
					while(rs_matname.next()){
						name = rs_matname.getString("NAME");
						// System.out.println("name = "+name+ " mat = "+refCode.get(matcode.get(i).toString()) +" Code = " + matcode.get(i).toString());
					}
				}else{
					ps_assembly = con.prepareStatement(queryasb); 
					rs_assembly = ps_assembly.executeQuery();
					while(rs_assembly.next()){
						name = "=> " + rs_assembly.getString("MAT_NAME");			
						
						if(rs_assembly.getString("TRAN_SUBTYPE").equalsIgnoreCase("10") || 
								rs_assembly.getString("TRAN_SUBTYPE").equalsIgnoreCase("15") || 
								rs_assembly.getString("TRAN_SUBTYPE").equalsIgnoreCase("25")){
							saleamt = saleamt + Double.parseDouble(rs_assembly.getString("AMOUNT"));	
						}else{
							saleqty = saleqty + Double.parseDouble(rs_assembly.getString("QTY"));
							saleamt = saleamt + Double.parseDouble(rs_assembly.getString("AMOUNT"));
						}							
					}
				}
				
						
				while(rs_chk.next()){
					if(rs_chk.getString("TRAN_SUBTYPE").equalsIgnoreCase("10") || 
							rs_chk.getString("TRAN_SUBTYPE").equalsIgnoreCase("15") || 
							rs_chk.getString("TRAN_SUBTYPE").equalsIgnoreCase("25")){
						saleamt = saleamt + Double.parseDouble(rs_chk.getString("AMOUNT"));	
					}else{
						saleqty = saleqty + Double.parseDouble(rs_chk.getString("QTY"));
						saleamt = saleamt + Double.parseDouble(rs_chk.getString("AMOUNT"));
					}					     				    			
				}		
				
				if(refCode.get(matcode.get(i).toString())!=null){
					
					ps_chk1 = con.prepareStatement(query2);
					rs_chk1 = ps_chk1.executeQuery(); 
					
					while(rs_chk1.next()){
						if(rs_chk1.getString("TRAN_SUBTYPE").equalsIgnoreCase("7") || 
								rs_chk1.getString("TRAN_SUBTYPE").equalsIgnoreCase("19")){
							puramt = puramt + Double.parseDouble(rs_chk1.getString("TRAN_AMT"));
						}else{
							purQty = purQty + Double.parseDouble(rs_chk1.getString("QTY")); 
							puramt = puramt + Double.parseDouble(rs_chk1.getString("TRAN_AMT")); 							
						 }
					}
				}	
				purAvg = puramt/purQty;
				saleAvg = saleamt/saleqty;
				per =  purAvg/saleAvg*100;
			%>
			<tr style="font-size: 10px; font-family: Arial;">
				<td  scope="col" align="center"><%=sr %></td>
				<td scope="col" align="left"><%=name %></td>
				<td scope="col" align="right"><%=zeroDForm.format(purQty) %></td>
				<td scope="col" align="right"><%=zeroDForm.format(saleqty) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(purAvg) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(puramt) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(saleAvg) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(saleamt) %></td>
				<td scope="col" align="right"><%=zeroDForm.format(per) %></td>
			</tr>
			<% 
			sr++; 
			saleqty=0;
			name="";
			purQty =0;
			puramt = 0;
			saleamt=0;
			purAvg=0;
			saleAvg=0;
			per=0;
			query1="";
			query2="";
			query3="";
			queryasb="";
	    	}
			
			%>
			<tr style="font-size: 10px; font-family: Arial;">
				<td  scope="col" align="center" colspan="9"><b><hr></b></td>
			</tr>
			
			<%
			//****************************************************************************************************************
			PreparedStatement ps_Braw=null,ps_matbomRaw=null,matisalePS=null;
			ResultSet rs_Braw=null,rs_matbomRaw=null,matisaleRs=null;
			int FxData2 =0,FxData1=0;
			ArrayList codes=new ArrayList();
		while(rs_extra.next()){  
				ps_Braw=con.prepareStatement("select * from ENGERP..MSTMATBOMRAW where REF_MATCODE='"+rs_extra.getString("MAT_CODE")+"'");
				rs_Braw=ps_Braw.executeQuery(); 
				while(rs_Braw.next()){   
					codes.add(rs_Braw.getString("MAT_CODE"));
				} 
		} 
		
		HashSet hsRem = new HashSet();
		hsRem.addAll(codes);
		codes.clear();
		codes.addAll(hsRem); 
		codes.removeAll(matcode); 
		purQty =0;
		puramt=0;
		name = "";
		String codeListBOM="";
		
		
		for(int f=0;f<codes.size();f++){
			// System.out.println(refCode.get(codes.get(f)).toString()); 
			if(comp.equalsIgnoreCase("101")){
				query1 = "select * from ENGERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE="+refCode.get(codes.get(f)).toString()+" and TRAN_DATE between "+from+" and "+to +" and STATUS_CODE='0'";
				query2 = "select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='103' and  CODE = '"+refCode.get(codes.get(f)).toString()+"'";
				query3 = "select * from ENGERP..MSTMATBOMRAW where REF_MATCODE= '"+refCode.get(codes.get(f)).toString()+"'";
			}
			if(comp.equalsIgnoreCase("102")){
				query1 = "select * from H25ERP..TRNACCTMATSTATUS where TRAN_NO like '%20215%' and MAT_CODE="+refCode.get(codes.get(f)).toString()+" and TRAN_DATE between "+from+" and "+to +" and STATUS_CODE='0'";
				query2 = "select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='103' and  CODE = '"+refCode.get(codes.get(f)).toString()+"'";
				query3 = "select * from H25ERP..MSTMATBOMRAW where REF_MATCODE= '"+refCode.get(codes.get(f)).toString()+"'";				
			}
			
			ps_chk1 = con.prepareStatement(query1);
			rs_chk1 = ps_chk1.executeQuery();
			
			ps_chk = con.prepareStatement(query2);
			rs_chk = ps_chk.executeQuery();
			while(rs_chk.next()){
				name = rs_chk.getString("NAME");
			}
			
			while(rs_chk1.next()){
				if(rs_chk1.getString("TRAN_SUBTYPE").equalsIgnoreCase("7") || rs_chk1.getString("TRAN_SUBTYPE").equalsIgnoreCase("19")){
					puramt = puramt + Double.parseDouble(rs_chk1.getString("TRAN_AMT"));
				}else{
					purQty = purQty + Double.parseDouble(rs_chk1.getString("QTY")); 
					puramt = puramt + Double.parseDouble(rs_chk1.getString("TRAN_AMT"));	
				}
			} 
			
			assemblyPSSale = con.prepareStatement(query3);
			assemblyRSSale = assemblyPSSale.executeQuery();
			while(assemblyRSSale.next()){
				if(comp.equalsIgnoreCase("101")){
					query3 = "select * from ENGERP..MSTMATBOM where REF_MATCODE="+assemblyRSSale.getString("MAT_CODE");
					ps_matbomRaw = con.prepareStatement(query3);
					rs_matbomRaw = ps_matbomRaw.executeQuery();
					 
					if (rs_matbomRaw !=null) {
						
					while(rs_matbomRaw.next()){
						matisalePS = con.prepareStatement("select * from ENGERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE ="+rs_matbomRaw.getString("MAT_CODE")+" and TRAN_DATE between "+from+" and "+to +" and STATUS_CODE='0'");
						matisaleRs =matisalePS.executeQuery();
						 
						if (matisaleRs !=null) {
							
						while(matisaleRs.next()){
							if(matisaleRs.getString("TRAN_SUBTYPE").equalsIgnoreCase("10") || 
									matisaleRs.getString("TRAN_SUBTYPE").equalsIgnoreCase("15") || 
									matisaleRs.getString("TRAN_SUBTYPE").equalsIgnoreCase("25")){
								saleamt = saleamt + Double.parseDouble(matisaleRs.getString("AMOUNT"));	
							}else{
								saleqty = saleqty + Double.parseDouble(matisaleRs.getString("QTY"));
								saleamt = saleamt + Double.parseDouble(matisaleRs.getString("AMOUNT"));
							}	
						}
						}
					}
					} 
				}
				if(comp.equalsIgnoreCase("102")){
					query3 = "select * from H25ERP..MSTMATBOM where REF_MATCODE="+assemblyRSSale.getString("MAT_CODE");
					ps_matbomRaw = con.prepareStatement(query3);
					rs_matbomRaw = ps_matbomRaw.executeQuery();
					 
					if (rs_matbomRaw !=null) {
						
					while(rs_matbomRaw.next()){
						matisalePS = con.prepareStatement("select * from H25ERP..TRNACCTMATISALE where TRAN_SUBTYPE NOT IN(6,5,4,13,12,31,36) and MAT_CODE ="+rs_matbomRaw.getString("MAT_CODE")+" and TRAN_DATE between "+from+" and "+to +" and STATUS_CODE='0'");
						matisaleRs =matisalePS.executeQuery();
						 
						if (matisaleRs !=null) {
							
						while(matisaleRs.next()){
							if(matisaleRs.getString("TRAN_SUBTYPE").equalsIgnoreCase("10") || 
									matisaleRs.getString("TRAN_SUBTYPE").equalsIgnoreCase("15") || 
									matisaleRs.getString("TRAN_SUBTYPE").equalsIgnoreCase("25")){
								saleamt = saleamt + Double.parseDouble(matisaleRs.getString("AMOUNT"));	
							}else{
								saleqty = saleqty + Double.parseDouble(matisaleRs.getString("QTY"));
								saleamt = saleamt + Double.parseDouble(matisaleRs.getString("AMOUNT"));
							}	
						}
						}
					}
					} 
				}
				}
			purAvg = puramt/purQty;
			saleAvg = saleamt/saleqty;
			per =  purAvg/saleAvg*100; 
		%>
		<tr style="font-size: 10px; font-family: Arial;">
				<td  scope="col" align="center"><%=sr %></td>
				<td scope="col" align="left"><%=name %></td>
				<td scope="col" align="right"><%=zeroDForm.format(purQty) %></td>
				<td scope="col" align="right"><%=zeroDForm.format(saleqty) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(purAvg) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(puramt) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(saleAvg) %></td> 
				<td scope="col" align="right"><%=zeroDForm.format(saleamt) %></td>
				<td scope="col" align="right"><%=zeroDForm.format(per) %></td>
			</tr>
		<%	
		sr++;
		purQty=0;   
		puramt=0;   
		purAvg=0;
		query1="";
		query2="";
		query3="";
		queryasb="";
		saleamt=0;   
		saleqty=0;   
		saleamt=0;
		saleAvg=0;
		per=0;
		}
		%>
			</table>
<%
con.close();
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%>
	</div>
	<br>
	<br>
	<script type="text/javascript">
		var freezeRow = 1; //change to row to freeze at
		var freezeCol = 7; //change to column to freeze at
		var myRow = freezeRow;
		var myCol = freezeCol;
		var speed = 130; //timeout speed for freez column
		var myTable;
		var noRows;
		var myCells, ID;

		function setUp() {
			if (!myTable) {
				myTable = document.getElementById("t1");
			}
			myCells = myTable.rows[0].cells.length;
			noRows = myTable.rows.length;

			for ( var x = 0; x < myTable.rows[0].cells.length; x++) {
				colWdth = myTable.rows[0].cells[x].offsetWidth;
				myTable.rows[0].cells[x].setAttribute("width", colWdth - 4);
			}
		}

		function right(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myCol < (myCells)) {
				for ( var x = 0; x < noRows; x++) {
					myTable.rows[x].cells[myCol].style.display = "";
				}
				if (myCol > freezeCol) {
					myCol--;
				}
				ID = window.setTimeout('right()', speed);
			}
		}

		function left(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myCol < (myCells - 1)) {
				for ( var x = 0; x < noRows; x++) {
					myTable.rows[x].cells[myCol].style.display = "none";
				}
				myCol++;
				ID = window.setTimeout('left()', speed);

			}
		}

		function down(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myRow < (noRows - 1)) {
				myTable.rows[myRow].style.display = "none";
				myRow++;

				ID = window.setTimeout('down()', speed);
			}
		}

		function upp(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}
			if (myRow <= noRows) {
				myTable.rows[myRow].style.display = "";
				if (myRow > freezeRow) {
					myRow--;
				}
				ID = window.setTimeout('upp()', speed);
			}
		}
	</script>

</body>
</html>