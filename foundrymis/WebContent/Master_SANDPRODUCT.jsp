<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>New Item IN ERP</title> 
<link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<script> 			         
	 $(function() {
		 $( "#tin_sst_date").datepicker({
		      changeMonth: true,
		      changeYear: true
		}); 
	});
	 
	 function button1(val) {
			var val1 = val; 
			document.getElementById("hid_code").value = val1;
			edit.submit();
		}

	 function ChangeColor(tableRow, highLight) {
			if (highLight) {
				tableRow.style.backgroundColor = '#CFCFCF';
			} else {
				tableRow.style.backgroundColor = '#FFFFFF';
			}
		}  
</script>
<STYLE TYPE="text/css" MEDIA=all>
input{
background-color: #e6e6ff; 
}
textarea{
background-color: #e6e6ff; 
}
select{
background-color: #e6e6ff;
}
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%; 
	border: 1px solid #963;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 5px; 
	border: 1px solid #963;
}

.tftable tr {
	background-color: #ffffff;
	border: 1px solid #963;
}

.tftable td {
	font-size: 12px;
	padding: 2px;  
	border: 1px solid #963;
	font-weight: bold;
}
.tft {
	font-size: 12px;
	color: #333333;
	width: 100%; 
	border: 1px solid #963;
}

.tft th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 3px; 
	border: 1px solid #963;
}

.tft tr {
	background-color: #ffffff;
	border: 1px solid #963;
}

.tft td {
	font-size: 12px;   
	border: 1px solid #963;
}
</STYLE>
<script type="text/javascript">
function validateNewItemForm() {
	document.getElementById("submit").disabled = true; 
	var supplier = document.getElementById("supplier"); 
	  	if (supplier.value=="0" || supplier.value==null || supplier.value=="" || supplier.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Supplier Name !!!");  
			return false;
		} 
} 
</script>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script> 
<script type="text/javascript">
<%
if(request.getParameter("status")!=null){
%>
alert("Done");
<%
}
%>
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<%
	try {
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");
		Date tdate = new Date(); 
		String todaysDate = sdfFIrstDate.format(tdate);
		Connection con = ConnectionUrl.getBWAYSERPMASTERConnection();
		Connection conlocal = ConnectionUrl.getLocalDatabase();
		PreparedStatement ps=null;
		ResultSet rs = null;
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		if(request.getParameter("repMsg")!=null){
	  %>
	  <script type="text/javascript">
	  alert("<%=request.getParameter("repMsg") %>");
	  </script>
	  <%
		}
	  %>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">New Item Creation in ERP System</strong> 
<br/>
<strong style="font-family: Arial;font-size: 14px;font-weight: bold;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr; BACK</a></strong>
&nbsp;&nbsp;&nbsp;<b style="font-size: 11px;color: #555306">Note : Please Use Mozilla Firefox Web Browser for full control.......</b>
<br>
<div style="overflow: scroll;background-color: white;width:70%;float:left">
<form action="Master_NewCasting" method="post"  onSubmit="return validateNewItemForm();"  enctype="multipart/form-data">
 
<table class="tftable" style="width: 100%">
	<tr>
    	<td><label class="caption">Product Description*</label></td>
				<td><Input Type="Text" Id="txtName" name="txtName" TabIndex=2  Size="70" MaxLength="100" ></td>
			</tr>
			<tr>	
			  <td><label class="caption" >Additional Specification</label></td>
<td>
<textarea id="txtAddSpec" name="txtAddSpec" TabIndex=3  Cols=52 rows=3 OnKeyup="CheckTextAreaLength(this , 500)" OnKeyDown="CheckTextAreaLength(this , 500)" ></textarea>				</td>
</tr>
<tr>
<td> <label class="caption">Product Group</label></td>
<td>
<Select id="drpMatGroup" name="drpMatGroup"  Tabindex=4 >
 <Option Value="1010197" >SAND PLANT</Option>
</select>				</td>
</tr>
<tr>
<td><label class="caption" >Item Type</label>				</td>
<td>
				<Select id="drpItemType" name="drpItemType" TabIndex="5" >
					<Option Value="0"> Purchase or Own Production </Option>
					<Option Value="1"> Job Work Machining </Option>
					<Option Value="2"> Own Production </Option>
					<Option Value="3"> Job Work or Own Production </Option>
					</select>				</td>
			</tr>			
			<tr>
			  <td><label class="caption">Stock Unit</label>				</td>
				<td>
					<Select id="drpUnitCode" name="drpUnitCode"  Tabindex=6 >
					
					<Option Value="BOOK " >BOOK</Option> 
					
					<Option Value="BOX  " >BOX</Option> 
					
					<Option Value="BRS  " >BRASS</Option> 
					
					<Option Value="COIL " >COIL</Option> 
					
					<Option Value="CUB  " >CUBIC FEET</Option> 
					
					<Option Value="DOZZE" >DOZZEN</Option> 
					
					<Option Value="FT   " >FEET</Option> 
					
					<Option Value="HOURS" >HOURS</Option> 
					
					<Option Value="JOINT" >JOINT</Option> 
					
					<Option Value="KG   " >KILOGRAM</Option> 
					
					<Option Value="KWH  " >KWH</Option> 
					
					<Option Value="LTR  " >LITTER</Option> 
					
					<Option Value="LT   " >LOT</Option> 
					
					<Option Value="MTR  " >METER</Option> 
					
					<Option Value="MT   " >METRIC TON</Option> 
					
					<Option Value="MM   " >MM</Option> 
					
					<Option Value="NOS  " >NUMBERS</Option> 
					
					<Option Value="PKT  " >PACKET</Option> 
					
					<Option Value="PAIR " >PAIR</Option> 
					
					<Option Value="Quart" >Quarter</Option> 
					
					<Option Value="RIM  " >RIM</Option> 
					
					<Option Value="ROLL " >ROLL</Option> 
					
					<Option Value="RUFT " >RUNNING FEET</Option> 
					
					<Option Value="SET  " >SET</Option> 
					
					<Option Value="SHEET" >SHEET</Option> 
					
					<Option Value="SLOT " >SLOT</Option> 
					
					<Option Value="SQFT " >Square Feet</Option> 
					
					<Option Value="SQIN " >SQUARE INCH</Option> 
					
					<Option Value="SQ.IN" >SQUARE INCH</Option> 
					
					<Option Value="SQMT " >Square Meter</Option> 
					
					<Option Value="TIN  " >TIN</Option> 
					
					<Option Value="TRIP " >TRIP</Option> 
					
					<Option Value="YEAR " >YEAR</Option> 
					</select>				</td>
			</tr>
			<tr> <td><label class="caption" >Location Code</label>				</td>
				<td>
					<Select id="drpLocCode" name="drpLocCode"  Tabindex=8  >
					
					<Option Value="101002" >FINISH STOCK YARD</Option> 
					
					<Option Value="101001" >STORE</Option> 
					</select>				</Td>
			</tr>
			<tr><td><label class="caption" >Purchase GL</label>				</td>
				<td>
					<Select id="drpPurhGlAcNo" name="drpPurhGlAcNo"  Tabindex=9 >	
					<Option Value="101001032| 0 | 0" >ACMA CLUSTER EXPENSES   MFPL</Option>  
 					<Option Value="101001023| 0 | 0" >ADVANCE LAPS (SALARY)   MFPL</Option>  
 
 
					<Option Value="101001125| 0 | 0" >ADVANCE W/OFF - (DWARKADAS SHAMKUMAR TEXTILES PVT.LTD.   MFPL</Option>  
 
 
					<Option Value="101000082| 0 | 0" >ADVERTISEMENT & PUBLICITY   com</Option>  
 
 
					<Option Value="101000901| 0 | 0" >ADVOCATE FEES   </Option>  
 
 
					<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option>  
 
 
					<Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option>  
 
 
					<Option Value="101000330| 0 | 0" >ASSEMENT DUES (GOVT. AGENCIES)   MFPL</Option>  
 
 
					<Option Value="101000761| 0 | 0" >AUDIT FEES   MSIPL</Option>  
 
 
					<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option>  
 
 
					<Option Value="101000084| 0 | 0" >BAD & DOUBTFUL DEBTS   com</Option>  
 
 
					<Option Value="101000983| 0 | 0" >BAL.IN DEPB W/OFF   MEPL</Option>  
 
 
					<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option>  
 
 
					<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option>  
 
 
					<Option Value="101000093| 0 | 0" >BOOKS & PERIODICALS   com</Option>  
 
 
					<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option>  
 
 
					<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option>  
 
 
					<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option>  
 
 
					<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option>  
 
 
					<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option>  
 
 
					<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option>  
 
 
					<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option>  
 
 
					<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option>  
 
 
					<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option>  
 
 
					<Option Value="101000897| 0 | 0" >CAR EXPENSES (BEAT+INNOVA)   MEPL</Option>  
 
 
					<Option Value="101000902| 0 | 0" >CAR EXPENSES (ELENTRA+INDICA)   </Option>  
 
 
					<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option>  
 
 
					<Option Value="101000905| 0 | 0" >CAR REPAIRS AND MAINTENANCE   </Option>  
 
 
					<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>  
 
 
					<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>  
 
 
					<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option>  
 
 
					<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option>  
 
 
					<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option>  
 
 
					<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option>  
 
 
					<Option Value="101001028| 0 | 0" >CLEANING CHARGES   MEPL</Option>  
 
 
					<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option>  
 
 
					<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option>  
 
 
					<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option>  
 
 
					<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option>  
 
 
					<Option Value="101000006|101140004|0" >COMPUTER   COM</Option>  
 
 
					<Option Value="101000102| 0 | 0" >COMPUTER REPAIRING & MAINT   com</Option>  
 
 
					<Option Value="101000257| 0 | 0" >CONFERANCE EXPENSES   msipl</Option>  
 
 
					<Option Value="101000995| 0 | 0" >CONSULTANCY CHARGES   </Option>  
 
 
					<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option>  
 
 
					<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option>  
 
 
					<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option>  
 
 
					<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option>  
 
 
					<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option>  
 
 
					<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option>  
 
 
					<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option>  
 
 
					<Option Value="101000032| 0 | 0" >CURRENCY FLUCTUATION ACCOUNT   COM</Option>  
 
 
					<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option>  
 
 
					<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option>  
 
 
					<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option>  
 
 
					<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option>  
 
 
					<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option>  
 
 
					<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option>  
 
 
					<Option Value="101000474| 0 | 0" >DEPB LICENCE PROF.EXPS.   MEPL</Option>  
 
 
					<Option Value="101000862| 0 | 0" >DEPB PURCHASE A/C   ME</Option>  
 
 
					<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option>  
 
 
					<Option Value="101000863| 0 | 0" >DIMINUTION IN VALUE OF SHARES   </Option>  
 
 
					<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option>  
 
 
					<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option>  
 
 
					<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option>  
 
 
					<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option>  
 
 
					<Option Value="101000112| 0 | 0" >DONATION   com</Option>  
 
 
					<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option>  
 
 
					<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option>  
 
 
					<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option>  
 
 
					<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option>  
 
 
					<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option>  
 
 
					<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option>  
 
 
					<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option>  
 
 
					<Option Value="101000006|101140099|0" >ELECTRIFICATION H-25 PART-II   MEPL</Option>  
 
 
					<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option>  
 
 
					<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option>  
 
 
					<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option>  
 
 
					<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option>  
 
 
					<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option>  
 
 
					<Option Value="101000982| 0 | 0" >ERP SOFTWARE AMC CHARGES   ME</Option>  
 
 
					<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option>  
 
 
					<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option>  
 
 
					<Option Value="101000119| 0 | 0" >E-TDS FILING FEE   com</Option>  
 
 
					<Option Value="101000674| 0 | 0" >EX.DUTY ON SALES RET.(LAPSED)   COM</Option>  
 
 
					<Option Value="101000675| 0 | 0" >EXCISE APPEAL FILING FEE   COM</Option>  
 
 
					<Option Value="101001039| 0 | 0" >EXCISE DUTY LAPSED   </Option>  
 
 
					<Option Value="101000907| 0 | 0" >EXCISE DUTY ON DRAWING & DESIGN   MEPL</Option>  
 
 
					<Option Value="101000676| 0 | 0" >EXCISE DUTY PENALTY   COM</Option>  
 
 
					<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option>  
 
 
					<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option>  
 
 
					<Option Value="101000122| 0 | 0" >EXHIBITION EXPENSES   com</Option>  
 
 
					<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option>  
 
 
					<Option Value="101000124| 0 | 0" >EXPORT EXPENSES (OTHERS)   MEPL</Option>  
 
 
					<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option>  
 
 
					<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option>  
 
 
					<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option>  
 
 
					<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option>  
 
 
					<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option>  
 
 
					<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option>  
 
 
					<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option>  
 
 
					<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option>  
 
 
					<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option>  
 
 
					<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option>  
 
 
					<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option>  
 
 
					<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option>  
 
 
					<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option>  
 
 
					<Option Value="101000006|101140098|0" >FACTORY BUILDING H-25 PART-II   MEPL</Option>  
 
 
					<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option>  
 
 
					<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option>  
 
 
					<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option>  
 
 
					<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option>  
 
 
					<Option Value="101000006|101140100|0" >FACTORY BUILDINGâPOWDER COATING PLANT   MEPL III</Option>  
 
 
					<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option>  
 
 
					<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option>  
 
 
					<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option>  
 
 
					<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option>  
 
 
					<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option>  
 
 
					<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option>  
 
 
					<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000130| 0 | 0" >FESTIVAL EXPENSES   com</Option>  
 
 
					<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option>  
 
 
					<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option>  
 
 
					<Option Value="101000837| 0 | 0" >FINE   MFPL</Option>  
 
 
					<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option>  
 
 
					<Option Value="101000134| 0 | 0" >FOREIGN TOUR EXPENSES   com</Option>  
 
 
					<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option>  
 
 
					<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option>  
 
 
					<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option>  
 
 
					<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option>  
 
 
					<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option>  
 
 
					<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option>  
 
 
					<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option>  
 
 
					<Option Value="101000006|101140068|0" >FURNITURE   DI</Option>  
 
 
					<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option>  
 
 
					<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option>  
 
 
					<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option>  
 
 
					<Option Value="101000135| 0 | 0" >GARDENING EXPENSES   com</Option>  
 
 
					<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option>  
 
 
					<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option>  
 
 
					<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option>  
 
 
					<Option Value="101000136| 0 | 0" >GENERAL REPAIRS & MAINT   com</Option>  
 
 
					<Option Value="101000138| 0 | 0" >GIFTS & PRESENTATION   com</Option>  
 
 
					<Option Value="101000913| 0 | 0" >GRAMPANCHAYAT TAX   MSIPL</Option>  
 
 
					<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000858| 0 | 0" >HOLIDAY RESORT TIME SHARES DIMINISHED   MFPL</Option>  
 
 
					<Option Value="101000268| 0 | 0" >HOUSEKEEPING  CHARGES   msipl</Option>  
 
 
					<Option Value="101000508| 0 | 0" >INCOME TAX APPEAL FILING FEES   MEPL</Option>  
 
 
					<Option Value="101000509| 0 | 0" >INCOME TAX FILING FEES   MEPL</Option>  
 
 
					<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option>  
 
 
					<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option>  
 
 
					<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option>  
 
 
					<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option>  
 
 
					<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option>  
 
 
					<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option>  
 
 
					<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option>  
 
 
					<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option>  
 
 
					<Option Value="101000269| 0 | 0" >INSPECTION FEES TRANSFORMER   msipl</Option>  
 
 
					<Option Value="101000151| 0 | 0" >INSURANCE   com</Option>  
 
 
					<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option>  
 
 
					<Option Value="101000963| 0 | 0" >INSURANCE-EXPORT SHIPMENT POLICY   ME</Option>  
 
 
					<Option Value="101001030| 0 | 0" >INSURANCE-WINDMILL   ME</Option>  
 
 
					<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option>  
 
 
					<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option>  
 
 
					<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option>  
 
 
					<Option Value="101000801| 0 | 0" >INTEREST ON RATE DIFFERENCE INVOICES   MSIPL</Option>  
 
 
					<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option>  
 
 
					<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option>  
 
 
					<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option>  
 
 
					<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option>  
 
 
					<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option>  
 
 
					<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option>  
 
 
					<Option Value="101000994| 0 | 0" >INVESTMENT W/OFF A/C   </Option>  
 
 
					<Option Value="101001165| 0 | 0" >IPS SUBSIDY 2012-13 (OTHER INCOME)   DI</Option>  
 
 
					<Option Value="101000154| 0 | 0" >ISO / TS / TPM / UNIDO EXPENSES   com</Option>  
 
 
					<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option>  
 
 
					<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option>  
 
 
					<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option>  
 
 
					<Option Value="101000722| 0 | 0" >JOB WORK CHARGES LABOUR MSIPL   MSIPL</Option>  
 
 
					<Option Value="101000373| 0 | 0" >KEY MAN INSURANCE PREMIMUM   MFPL</Option>  
 
 
					<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option>  
 
 
					<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option>  
 
 
					<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option>  
 
 
					<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option>  
 
 
					<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option>  
 
 
					<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option>  
 
 
					<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option>  
 
 
					<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option>  
 
 
					<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option>  
 
 
					<Option Value="101000899| 0 | 0" >LATE DELIVERY EXTRA CHARGES   </Option>  
 
 
					<Option Value="101000859| 0 | 0" >LEASE FOR EXPIRED PERIOD OF MIDC LAND   MFPL</Option>  
 
 
					<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option>  
 
 
					<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option>  
 
 
					<Option Value="101000162| 0 | 0" >LEGAL EXPENSES   com</Option>  
 
 
					<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option>  
 
 
					<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option>  
 
 
					<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option>  
 
 
					<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option>  
 
 
					<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option>  
 
 
					<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option>  
 
 
					<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option>  
 
 
					<Option Value="101000164| 0 | 0" >LOCAL CONVEYANCE   com</Option>  
 
 
					<Option Value="101001003| 0 | 0" >LOSS ON MOULDING BOXES SCRAP   DI</Option>  
 
 
					<Option Value="101001160| 0 | 0" >LOSS ON SALE OF  PLANT & MACHINERY   MEPL</Option>  
 
 
					<Option Value="101001002| 0 | 0" >LOSS ON SALE OF CAR   DI</Option>  
 
 
					<Option Value="101000977| 0 | 0" >LOSS ON SALE OF DEPB LICENCE   MEPL</Option>  
 
 
					<Option Value="101000590| 0 | 0" >LOSS ON SALE OF DSP BLACKROCK MUTUAL FUND   MEPL</Option>  
 
 
					<Option Value="101001037| 0 | 0" >LOSS ON SALE OF SHARES/CONVERSION OF SHARES   MEPL</Option>  
 
 
					<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option>  
 
 
					<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option>  
 
 
					<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option>  
 
 
					<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option>  
 
 
					<Option Value="101001069| 0 | 0" >MACHINING DEFECTIVE-REJECTION   MEPL</Option>  
 
 
					<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option>  
 
 
					<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option>  
 
 
					<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option>  
 
 
					<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option>  
 
 
					<Option Value="101000841| 0 | 0" >MAX NEWYORK LIFE PARTNER INSURANCE PREMIUM   MEPL</Option>  
 
 
					<Option Value="101000380| 0 | 0" >MEMBERSHIP FEES A/C   MFPL</Option>  
 
 
					<Option Value="101000595| 0 | 0" >MIDC EXPENSES   MEPL</Option>  
 
 
					<Option Value="101001149| 0 | 0" >MIDC NAME CHANGE CHARGES   MSIPL</Option>  
 
 
					<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option>  
 
 
					<Option Value="101000168| 0 | 0" >MISCELLENIOUS EXPENSES.   com</Option>  
 
 
					<Option Value="101000169| 0 | 0" >MOBILE EXPENSES   com</Option>  
 
 
					<Option Value="101000306| 0 | 0" >MONITORING AGENCY FEES   msipl</Option>  
 
 
					<Option Value="101000006|101140101|0" >MONO RAIL   MEPL-III</Option>  
 
 
					<Option Value="101000006|101140030|0" >MONO RAIL   MSIPL</Option>  
 
 
					<Option Value="101001243| 0 | 0" >MONO RAIL   U-III</Option>  
 
 
					<Option Value="101000945| 0 | 0" >MONO RAIL C WIP W/OFF   MSIPL</Option>  
 
 
					<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option>  
 
 
					<Option Value="101000307| 0 | 0" >MPC BOARD REGD. CHARGES   msipl</Option>  
 
 
					<Option Value="101000916| 0 | 0" >NICKEL PURCHASE   </Option>  
 
 
					<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option>  
 
 
					<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option>  
 
 
					<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option>  
 
 
					<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option>  
 
 
					<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option>  
 
 
					<Option Value="101000172| 0 | 0" >OFFICE EXPENSES   com</Option>  
 
 
					<Option Value="101000173| 0 | 0" >OFFICE -RENT   com</Option>  
 
 
					<Option Value="101000962| 0 | 0" >OFFICERS CLUB EXPENSES   </Option>  
 
 
					<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option>  
 
 
					<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option>  
 
 
					<Option Value="101000310| 0 | 0" >P.F DAMAGES 09.10   msipl</Option>  
 
 
					<Option Value="101000311| 0 | 0" >P.F. DAMAGES 08.09   msipl</Option>  
 
 
					<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option>  
 
 
					<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option>  
 
 
					<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option>  
 
 
					<Option Value="101000849| 0 | 0" >PARTNERS REMUNERATION   </Option>  
 
 
					<Option Value="101000006|101140037|0" >PATTERN   DI</Option>  
 
 
					<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option>  
 
 
					<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option>  
 
 
					<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option>  
 
 
					<Option Value="101000937| 0 | 0" >PENALTY ON SERVICE TAX   ME</Option>  
 
 
					<Option Value="101000844| 0 | 0" >PENALTY ON VAT TAX   </Option>  
 
 
					<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option>  
 
 
					<Option Value="101000183| 0 | 0" >PIG IRON   com</Option>  
 
 
					<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option>  
 
 
					<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option>  
 
 
					<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option>  
 
 
					<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option>  
 
 
					<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option>  
 
 
					<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option>  
 
 
					<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option>  
 
 
					<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option>  
 
 
					<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option>  
 
 
					<Option Value="101000184| 0 | 0" >POLUTION CONTROL FEES   com</Option>  
 
 
					<Option Value="101000185| 0 | 0" >POSTAGE & COURIER CHARGES   com</Option>  
 
 
					<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option>  
 
 
					<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option>  
 
 
					<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option>  
 
 
					<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option>  
 
 
					<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option>  
 
 
					<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option>  
 
 
					<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option>  
 
 
					<Option Value="101000188| 0 | 0" >PRINTING & STATIONERY   com</Option>  
 
 
					<Option Value="101000976| 0 | 0" >PRIOR YEAR ADJUSTMENT CST 2%   </Option>  
 
 
					<Option Value="101001051| 0 | 0" >PRIOR YEAR MOBILE EXPENSES   MSIPL</Option>  
 
 
					<Option Value="101000192| 0 | 0" >PROFESSION TAX (COMPANY)   com</Option>  
 
 
					<Option Value="101000194| 0 | 0" >PROFESSIONAL CHARGES   com</Option>  
 
 
					<Option Value="101001261| 0 | 0" >PROFIT ON CUPOLA MACHINE - SCRAP   DI</Option>  
 
 
					<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option>  
 
 
					<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option>  
 
 
					<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option>  
 
 
					<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option>  
 
 
					<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option>  
 
 
					<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option>  
 
 
					<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option>  
 
 
					<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option>  
 
 
					<Option Value="101001265| 0 | 0" >PROFIT ON SALE OF VEHICLE (ACTIVA)   MFPL</Option>  
 
 
					<Option Value="101000930| 0 | 0" >PROFIT/LOSS ON SALE OF SHARES   ME</Option>  
 
 
					<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option>  
 
 
					<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option>  
 
 
					<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option>  
 
 
					<Option Value="101001239| 0 | 0" >PUR.AGRO CHARCOAL   MFPL</Option>  
 
 
					<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option>  
 
 
					<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option>  
 
 
					<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option>  
 
 
					<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option>  
 
 
					<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option>  
 
 
					<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option>  
 
 
					<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option>  
 
 
					<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option>  
 
 
					<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option>  
 
 
					<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option>  
 
 
					<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option>  
 
 
					<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option>  
 
 
					<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option>  
 
 
					<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option>  
 
 
					<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option>  
 
 
					<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option>  
 
 
					<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option>  
 
 
					<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option>  
 
 
					<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option>  
 
 
					<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option>  
 
 
					<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option>  
 
 
					<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option>  
 
 
					<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option>  
 
 
					<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option>  
 
 
					<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option>  
 
 
					<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option>  
 
 
					<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option>  
 
 
					<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option>  
 
 
					<Option Value="101000205| 0 | 0" >R.O.C. EXPENSES   com</Option>  
 
 
					<Option Value="101001240| 0 | 0" >RATE AMENDMENT - CI/SGI CASTINGS PURCHASE (DOMESTIC)   ME</Option>  
 
 
					<Option Value="101000866| 0 | 0" >RATE AMENDMENT - SALES CI/SGI MACH.CASTINGS (DOMESTIC)   MEPL</Option>  
 
 
					<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option>  
 
 
					<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option>  
 
 
					<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option>  
 
 
					<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option>  
 
 
					<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option>  
 
 
					<Option Value="101001008| 0 | 0" >REC TRADE EXPENSES   ME</Option>  
 
 
					<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option>  
 
 
					<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option>  
 
 
					<Option Value="101000207| 0 | 0" >RENT ,RATES &TAXES   com</Option>  
 
 
					<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MEPL</Option>  
 
 
					<Option Value="101000318| 0 | 0" >RENT TO MUTHA ENGINEERING   msipl</Option>  
 
 
					<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option>  
 
 
					<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option>  
 
 
					<Option Value="101000208| 0 | 0" >REPAIRS & MAINTAINANCE-GENERAL   com</Option>  
 
 
					<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option>  
 
 
					<Option Value="101001231| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY ( LABOUR )   MSIPL</Option>  
 
 
					<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000211| 0 | 0" >RETAINERSHIP CHARGES   com</Option>  
 
 
					<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option>  
 
 
					<Option Value="101000212| 0 | 0" >ROC FILING FEES   com</Option>  
 
 
					<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option>  
 
 
					<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option>  
 
 
					<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option>  
 
 
					<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option>  
 
 
					<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option>  
 
 
					<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option>  
 
 
					<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option>  
 
 
					<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option>  
 
 
					<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option>  
 
 
					<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option>  
 
 
					<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option>  
 
 
					<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option>  
 
 
					<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option>  
 
 
					<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option>  
 
 
					<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option>  
 
 
					<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option>  
 
 
					<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option>  
 
 
					<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option>  
 
 
					<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option>  
 
 
					<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option>  
 
 
					<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option>  
 
 
					<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option>  
 
 
					<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option>  
 
 
					<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option>  
 
 
					<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option>  
 
 
					<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option>  
 
 
					<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option>  
 
 
					<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option>  
 
 
					<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option>  
 
 
					<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option>  
 
 
					<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option>  
 
 
					<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option>  
 
 
					<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option>  
 
 
					<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option>  
 
 
					<Option Value="101000829| 0 | 0" >SALE TAX DUES   DI</Option>  
 
 
					<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option>  
 
 
					<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option>  
 
 
					<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option>  
 
 
					<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option>  
 
 
					<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option>  
 
 
					<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option>  
 
 
					<Option Value="101001184| 0 | 0" >SALES  TAX APPEAL FILING FEES   MEPL</Option>  
 
 
					<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option>  
 
 
					<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option>  
 
 
					<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option>  
 
 
					<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option>  
 
 
					<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option>  
 
 
					<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option>  
 
 
					<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option>  
 
 
					<Option Value="101001230| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) RATE REDUCTION   MEPL</Option>  
 
 
					<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option>  
 
 
					<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option>  
 
 
					<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option>  
 
 
					<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option>  
 
 
					<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option>  
 
 
					<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option>  
 
 
					<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option>  
 
 
					<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option>  
 
 
					<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option>  
 
 
					<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option>  
 
 
					<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option>  
 
 
					<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option>  
 
 
					<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option>  
 
 
					<Option Value="101000637| 0 | 0" >SALES PROMOTION   COM</Option>  
 
 
					<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option>  
 
 
					<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option>  
 
 
					<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option>  
 
 
					<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option>  
 
 
					<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option>  
 
 
					<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option>  
 
 
					<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option>  
 
 
					<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option>  
 
 
					<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option>  
 
 
					<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option>  
 
 
					<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option>  
 
 
					<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option>  
 
 
					<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option>  
 
 
					<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option>  
 
 
					<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option>  
 
 
					<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option>  
 
 
					<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option>  
 
 
					<Option Value="101000216| 0 | 0" >SEMINAR & CONFERANCE CHARGES   com</Option>  
 
 
					<Option Value="101000648| 0 | 0" >SHORT/EXCESS IN EXCHANGE OF FORIEGN  CURRENCY   MEPL</Option>  
 
 
					<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option>  
 
 
					<Option Value="101001120| 0 | 0" >SOCIAL WELFARE EXPENSES   MFPL</Option>  
 
 
					<Option Value="101001052| 0 | 0" >SOFTWARE EXPENSES   MEPL</Option>  
 
 
					<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option>  
 
 
					<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option>  
 
 
					<Option Value="101000896| 0 | 0" >SPONSORSHIP CHARGES   </Option>  
 
 
					<Option Value="101000221| 0 | 0" >SUBSCRIPTION   com</Option>  
 
 
					<Option Value="101000873| 0 | 0" >SUNDRY CREDITORS W/OFF ACCOUNT   MFPL</Option>  
 
 
					<Option Value="101000048| 0 | 0" >SUNDRY CRS. WRITTEN OFF   COM</Option>  
 
 
					<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option>  
 
 
					<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option>  
 
 
					<Option Value="101000651| 0 | 0" >SUNDRY DRS. WRITTEN/OFF   MEPL</Option>  
 
 
					<Option Value="101001129| 0 | 0" >SWACHH BAHART CESS   MEPL</Option>  
 
 
					<Option Value="101001178| 0 | 0" >SWACHH BHARAT CESS EXPENSES ACCOUNT   </Option>  
 
 
					<Option Value="101000800| 0 | 0" >T.S.PROGRAM EXPENSES   </Option>  
 
 
					<Option Value="101000238| 0 | 0" >TEA & HOTEL EXP (GUEST)   com</Option>  
 
 
					<Option Value="101000241| 0 | 0" >TELEPHONE CHARGES   com</Option>  
 
 
					<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option>  
 
 
					<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option>  
 
 
					<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option>  
 
 
					<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option>  
 
 
					<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option>  
 
 
					<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option>  
 
 
					<Option Value="101000657| 0 | 0" >TPM MEMBERSHIP FEES   MEPL</Option>  
 
 
					<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option>  
 
 
					<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option>  
 
 
					<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option>  
 
 
					<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option>  
 
 
					<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option>  
 
 
					<Option Value="101000658| 0 | 0" >TRAVELLING EXPENSES   COM</Option>  
 
 
					<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option>  
 
 
					<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option>  
 
 
					<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option>  
 
 
					<Option Value="101000663| 0 | 0" >VAT REDUCTION 2%   MEPL</Option>  
 
 
					<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option>  
 
 
					<Option Value="101000960| 0 | 0" >VAT TAX APPEAL FEE   MEPL</Option>  
 
 
					<Option Value="101000842| 0 | 0" >VAT TAX DUES   </Option>  
 
 
					<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option>  
 
 
					<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option>  
 
 
					<Option Value="101000248| 0 | 0" >VEHICLE REPAIRS & MAINT   com</Option>  
 
 
					<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option>  
 
 
					<Option Value="101000669| 0 | 0" >WARRANTY CLAIM   MEPL</Option>  
 
 
					<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option>  
 
 
					<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option>  
 
 
					<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option>  
 
 
					<Option Value="101000465| 0 | 0" >WATER PLOUTION   DI </Option>  
 
 
					<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option>  
 
 
					<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option>  
 
 
					<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option>  
 
 
					<Option Value="101000880| 0 | 0" >WINDMILL EXPENSES   MEPL</Option>  
 
 
					<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option>  
 
 
					<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option>  
 
 
					<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option>  
 
 
					<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option>  
 
 
					<Option Value="101001143| 0 | 0" >WMDC DUES   DI</Option>  
 
 
					<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option>  
 
 
					<Option Value="101000815| 0 | 0" >XEROX MACHINE RENT PAID   ME</Option>  
 
 
					<Option Value="101001242| 0 | 0" >Z CLOSED FACTORY BUILDING â POWDER COATING PLANT   U-III</Option>  
					</select>				</Td>
			</tr>
			<tr>
			  <td>
					<label class="caption" >Purchase Return</label>				</td>
				<td>
					<Select id="drpPurhRetAcNo" name="drpPurhRetAcNo"  Tabindex=10 >
					
 
					<Option Value="101001032| 0 | 0" >ACMA CLUSTER EXPENSES   MFPL</Option>
 
 
					<Option Value="101001023| 0 | 0" >ADVANCE LAPS (SALARY)   MFPL</Option>
 
 
					<Option Value="101001125| 0 | 0" >ADVANCE W/OFF - (DWARKADAS SHAMKUMAR TEXTILES PVT.LTD.   MFPL</Option>
 
 
					<Option Value="101000082| 0 | 0" >ADVERTISEMENT & PUBLICITY   com</Option>
 
 
					<Option Value="101000901| 0 | 0" >ADVOCATE FEES   </Option>
 
 
					<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option>
 
 
					<Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option>
 
 
					<Option Value="101000330| 0 | 0" >ASSEMENT DUES (GOVT. AGENCIES)   MFPL</Option>
 
 
					<Option Value="101000761| 0 | 0" >AUDIT FEES   MSIPL</Option>
 
 
					<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option>
 
 
					<Option Value="101000084| 0 | 0" >BAD & DOUBTFUL DEBTS   com</Option>
 
 
					<Option Value="101000983| 0 | 0" >BAL.IN DEPB W/OFF   MEPL</Option>
 
 
					<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option>
 
 
					<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option>
 
 
					<Option Value="101000093| 0 | 0" >BOOKS & PERIODICALS   com</Option>
 
 
					<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option>
 
 
					<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option>
 
 
					<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option>
 
 
					<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option>
 
 
					<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option>
 
 
					<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option>
 
 
					<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option>
 
 
					<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option>
 
 
					<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option>
 
 
					<Option Value="101000897| 0 | 0" >CAR EXPENSES (BEAT+INNOVA)   MEPL</Option>
 
 
					<Option Value="101000902| 0 | 0" >CAR EXPENSES (ELENTRA+INDICA)   </Option>
 
 
					<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option>
 
 
					<Option Value="101000905| 0 | 0" >CAR REPAIRS AND MAINTENANCE   </Option>
 
 
					<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>
 
 
					<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option>
 
 
					<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option>
 
 
					<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option>
 
 
					<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option>
 
 
					<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option>
 
 
					<Option Value="101001028| 0 | 0" >CLEANING CHARGES   MEPL</Option>
 
 
					<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option>
 
 
					<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option>
 
 
					<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option>
 
 
					<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option>
 
 
					<Option Value="101000006|101140004|0" >COMPUTER   COM</Option>
 
 
					<Option Value="101000102| 0 | 0" >COMPUTER REPAIRING & MAINT   com</Option>
 
 
					<Option Value="101000257| 0 | 0" >CONFERANCE EXPENSES   msipl</Option>
 
 
					<Option Value="101000995| 0 | 0" >CONSULTANCY CHARGES   </Option>
 
 
					<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option>
 
 
					<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option>
 
 
					<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option>
 
 
					<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option>
 
 
					<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option>
 
 
					<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option>
 
 
					<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option>
 
 
					<Option Value="101000032| 0 | 0" >CURRENCY FLUCTUATION ACCOUNT   COM</Option>
 
 
					<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option>
 
 
					<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option>
 
 
					<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option>
 
 
					<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option>
 
 
					<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option>
 
 
					<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option>
 
 
					<Option Value="101000474| 0 | 0" >DEPB LICENCE PROF.EXPS.   MEPL</Option>
 
 
					<Option Value="101000862| 0 | 0" >DEPB PURCHASE A/C   ME</Option>
 
 
					<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option>
 
 
					<Option Value="101000863| 0 | 0" >DIMINUTION IN VALUE OF SHARES   </Option>
 
 
					<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option>
 
 
					<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option>
 
 
					<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option>
 
 
					<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option>
 
 
					<Option Value="101000112| 0 | 0" >DONATION   com</Option>
 
 
					<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option>
 
 
					<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option>
 
 
					<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option>
 
 
					<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option>
 
 
					<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option>
 
 
					<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option>
 
 
					<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option>
 
 
					<Option Value="101000006|101140099|0" >ELECTRIFICATION H-25 PART-II   MEPL</Option>
 
 
					<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option>
 
 
					<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option>
 
 
					<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option>
 
 
					<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option>
 
 
					<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option>
 
 
					<Option Value="101000982| 0 | 0" >ERP SOFTWARE AMC CHARGES   ME</Option>
 
 
					<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option>
 
 
					<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option>
 
 
					<Option Value="101000119| 0 | 0" >E-TDS FILING FEE   com</Option>
 
 
					<Option Value="101000674| 0 | 0" >EX.DUTY ON SALES RET.(LAPSED)   COM</Option>
 
 
					<Option Value="101000675| 0 | 0" >EXCISE APPEAL FILING FEE   COM</Option>
 
 
					<Option Value="101001039| 0 | 0" >EXCISE DUTY LAPSED   </Option>
 
 
					<Option Value="101000907| 0 | 0" >EXCISE DUTY ON DRAWING & DESIGN   MEPL</Option>
 
 
					<Option Value="101000676| 0 | 0" >EXCISE DUTY PENALTY   COM</Option>
 
 
					<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option>
 
 
					<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option>
 
 
					<Option Value="101000122| 0 | 0" >EXHIBITION EXPENSES   com</Option>
 
 
					<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option>
 
 
					<Option Value="101000124| 0 | 0" >EXPORT EXPENSES (OTHERS)   MEPL</Option>
 
 
					<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option>
 
 
					<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option>
 
 
					<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option>
 
 
					<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option>
 
 
					<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option>
 
 
					<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option>
 
 
					<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option>
 
 
					<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option>
 
 
					<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option>
 
 
					<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option>
 
 
					<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option>
 
 
					<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option>
 
 
					<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option>
 
 
					<Option Value="101000006|101140098|0" >FACTORY BUILDING H-25 PART-II   MEPL</Option>
 
 
					<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option>
 
 
					<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option>
 
 
					<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option>
 
 
					<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option>
 
 
					<Option Value="101000006|101140100|0" >FACTORY BUILDINGâPOWDER COATING PLANT   MEPL III</Option>
 
 
					<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option>
 
 
					<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option>
 
 
					<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option>
 
 
					<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option>
 
 
					<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option>
 
 
					<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option>
 
 
					<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000130| 0 | 0" >FESTIVAL EXPENSES   com</Option>
 
 
					<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option>
 
 
					<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option>
 
 
					<Option Value="101000837| 0 | 0" >FINE   MFPL</Option>
 
 
					<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option>
 
 
					<Option Value="101000134| 0 | 0" >FOREIGN TOUR EXPENSES   com</Option>
 
 
					<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option>
 
 
					<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option>
 
 
					<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option>
 
 
					<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option>
 
 
					<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option>
 
 
					<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option>
 
 
					<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option>
 
 
					<Option Value="101000006|101140068|0" >FURNITURE   DI</Option>
 
 
					<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option>
 
 
					<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option>
 
 
					<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option>
 
 
					<Option Value="101000135| 0 | 0" >GARDENING EXPENSES   com</Option>
 
 
					<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option>
 
 
					<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option>
 
 
					<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option>
 
 
					<Option Value="101000136| 0 | 0" >GENERAL REPAIRS & MAINT   com</Option>
 
 
					<Option Value="101000138| 0 | 0" >GIFTS & PRESENTATION   com</Option>
 
 
					<Option Value="101000913| 0 | 0" >GRAMPANCHAYAT TAX   MSIPL</Option>
 
 
					<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000858| 0 | 0" >HOLIDAY RESORT TIME SHARES DIMINISHED   MFPL</Option>
 
 
					<Option Value="101000268| 0 | 0" >HOUSEKEEPING  CHARGES   msipl</Option>
 
 
					<Option Value="101000508| 0 | 0" >INCOME TAX APPEAL FILING FEES   MEPL</Option>
 
 
					<Option Value="101000509| 0 | 0" >INCOME TAX FILING FEES   MEPL</Option>
 
 
					<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option>
 
 
					<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option>
 
 
					<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option>
 
 
					<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option>
 
 
					<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option>
 
 
					<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option>
 
 
					<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option>
 
 
					<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option>
 
 
					<Option Value="101000269| 0 | 0" >INSPECTION FEES TRANSFORMER   msipl</Option>
 
 
					<Option Value="101000151| 0 | 0" >INSURANCE   com</Option>
 
 
					<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option>
 
 
					<Option Value="101000963| 0 | 0" >INSURANCE-EXPORT SHIPMENT POLICY   ME</Option>
 
 
					<Option Value="101001030| 0 | 0" >INSURANCE-WINDMILL   ME</Option>
 
 
					<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option>
 
 
					<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option>
 
 
					<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option>
 
 
					<Option Value="101000801| 0 | 0" >INTEREST ON RATE DIFFERENCE INVOICES   MSIPL</Option>
 
 
					<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option>
 
 
					<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option>
 
 
					<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option>
 
 
					<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option>
 
 
					<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option>
 
 
					<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option>
 
 
					<Option Value="101000994| 0 | 0" >INVESTMENT W/OFF A/C   </Option>
 
 
					<Option Value="101001165| 0 | 0" >IPS SUBSIDY 2012-13 (OTHER INCOME)   DI</Option>
 
 
					<Option Value="101000154| 0 | 0" >ISO / TS / TPM / UNIDO EXPENSES   com</Option>
 
 
					<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option>
 
 
					<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option>
 
 
					<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option>
 
 
					<Option Value="101000722| 0 | 0" >JOB WORK CHARGES LABOUR MSIPL   MSIPL</Option>
 
 
					<Option Value="101000373| 0 | 0" >KEY MAN INSURANCE PREMIMUM   MFPL</Option>
 
 
					<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option>
 
 
					<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option>
 
 
					<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option>
 
 
					<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option>
 
 
					<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option>
 
 
					<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option>
 
 
					<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option>
 
 
					<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option>
 
 
					<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option>
 
 
					<Option Value="101000899| 0 | 0" >LATE DELIVERY EXTRA CHARGES   </Option>
 
 
					<Option Value="101000859| 0 | 0" >LEASE FOR EXPIRED PERIOD OF MIDC LAND   MFPL</Option>
 
 
					<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option>
 
 
					<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option>
 
 
					<Option Value="101000162| 0 | 0" >LEGAL EXPENSES   com</Option>
 
 
					<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option>
 
 
					<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option>
 
 
					<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option>
 
 
					<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option>
 
 
					<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option>
 
 
					<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option>
 
 
					<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option>
 
 
					<Option Value="101000164| 0 | 0" >LOCAL CONVEYANCE   com</Option>
 
 
					<Option Value="101001003| 0 | 0" >LOSS ON MOULDING BOXES SCRAP   DI</Option>
 
 
					<Option Value="101001160| 0 | 0" >LOSS ON SALE OF  PLANT & MACHINERY   MEPL</Option>
 
 
					<Option Value="101001002| 0 | 0" >LOSS ON SALE OF CAR   DI</Option>
 
 
					<Option Value="101000977| 0 | 0" >LOSS ON SALE OF DEPB LICENCE   MEPL</Option>
 

 
					<Option Value="101000590| 0 | 0" >LOSS ON SALE OF DSP BLACKROCK MUTUAL FUND   MEPL</Option>
 
 
					<Option Value="101001037| 0 | 0" >LOSS ON SALE OF SHARES/CONVERSION OF SHARES   MEPL</Option>
 
 
					<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option>
 
 
					<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option>
 
 
					<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option>
 
 
					<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option>
 
 
					<Option Value="101001069| 0 | 0" >MACHINING DEFECTIVE-REJECTION   MEPL</Option>
 
 
					<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option>
 
 
					<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option>
 
 
					<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option>
 
 
					<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option>
 
 
					<Option Value="101000841| 0 | 0" >MAX NEWYORK LIFE PARTNER INSURANCE PREMIUM   MEPL</Option>
 
 
					<Option Value="101000380| 0 | 0" >MEMBERSHIP FEES A/C   MFPL</Option>
 
 
					<Option Value="101000595| 0 | 0" >MIDC EXPENSES   MEPL</Option>
 
 
					<Option Value="101001149| 0 | 0" >MIDC NAME CHANGE CHARGES   MSIPL</Option>
 
 
					<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option>
 
 
					<Option Value="101000168| 0 | 0" >MISCELLENIOUS EXPENSES.   com</Option>
 
 
					<Option Value="101000169| 0 | 0" >MOBILE EXPENSES   com</Option>
 
 
					<Option Value="101000306| 0 | 0" >MONITORING AGENCY FEES   msipl</Option>
 
 
					<Option Value="101000006|101140101|0" >MONO RAIL   MEPL-III</Option>
 
 
					<Option Value="101000006|101140030|0" >MONO RAIL   MSIPL</Option>
 
 
					<Option Value="101001243| 0 | 0" >MONO RAIL   U-III</Option>
 
 
					<Option Value="101000945| 0 | 0" >MONO RAIL C WIP W/OFF   MSIPL</Option>
 
 
					<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option>
 
 
					<Option Value="101000307| 0 | 0" >MPC BOARD REGD. CHARGES   msipl</Option>
 
 
					<Option Value="101000916| 0 | 0" >NICKEL PURCHASE   </Option>
 
 
					<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option>
 
 
					<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option>
 
 
					<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option>
 
 
					<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option>
 
 
					<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option>
 
 
					<Option Value="101000172| 0 | 0" >OFFICE EXPENSES   com</Option>
 
 
					<Option Value="101000173| 0 | 0" >OFFICE -RENT   com</Option>
 
 
					<Option Value="101000962| 0 | 0" >OFFICERS CLUB EXPENSES   </Option>
 
 
					<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option>
 
 
					<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option>
 
 
					<Option Value="101000310| 0 | 0" >P.F DAMAGES 09.10   msipl</Option>
 
 
					<Option Value="101000311| 0 | 0" >P.F. DAMAGES 08.09   msipl</Option>
 
 
					<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option>
 
 
					<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option>
 
 
					<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option>
 
 
					<Option Value="101000849| 0 | 0" >PARTNERS REMUNERATION   </Option>
 
 
					<Option Value="101000006|101140037|0" >PATTERN   DI</Option>
 
 
					<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option>
 
 
					<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option>
 
 
					<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option>
 
 
					<Option Value="101000937| 0 | 0" >PENALTY ON SERVICE TAX   ME</Option>
 
 
					<Option Value="101000844| 0 | 0" >PENALTY ON VAT TAX   </Option>
 
 
					<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option>
 
 
					<Option Value="101000183| 0 | 0" >PIG IRON   com</Option>
 
 
					<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option>
 
 
					<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option>
 
 
					<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option>
 
 
					<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option>
 
 
					<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option>
 
 
					<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option>
 
 
					<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option>
 
 
					<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option>
 
 
					<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option>
 
 
					<Option Value="101000184| 0 | 0" >POLUTION CONTROL FEES   com</Option>
 
 
					<Option Value="101000185| 0 | 0" >POSTAGE & COURIER CHARGES   com</Option>
 
 
					<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option>
 
 
					<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option>
 
 
					<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option>
 
 
					<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option>
 
 
					<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option>
 
 
					<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option>
 
 
					<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option>
 
 
					<Option Value="101000188| 0 | 0" >PRINTING & STATIONERY   com</Option>
 
 
					<Option Value="101000976| 0 | 0" >PRIOR YEAR ADJUSTMENT CST 2%   </Option>
 
 
					<Option Value="101001051| 0 | 0" >PRIOR YEAR MOBILE EXPENSES   MSIPL</Option>
 
 
					<Option Value="101000192| 0 | 0" >PROFESSION TAX (COMPANY)   com</Option>
 
 
					<Option Value="101000194| 0 | 0" >PROFESSIONAL CHARGES   com</Option>
 
 
					<Option Value="101001261| 0 | 0" >PROFIT ON CUPOLA MACHINE - SCRAP   DI</Option>
 
 
					<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option>
 
 
					<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option>
 
 
					<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option>
 
 
					<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option>
 
 
					<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option>
 
 
					<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option>
 
 
					<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option>
 
 
					<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option>
 
 
					<Option Value="101001265| 0 | 0" >PROFIT ON SALE OF VEHICLE (ACTIVA)   MFPL</Option>
 
 
					<Option Value="101000930| 0 | 0" >PROFIT/LOSS ON SALE OF SHARES   ME</Option>
 
 
					<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option>
 
 
					<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option>
 
 
					<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option>
 
 
					<Option Value="101001239| 0 | 0" >PUR.AGRO CHARCOAL   MFPL</Option>
 
 
					<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option>
 
 
					<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option>
 
 
					<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option>
 
 
					<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option>
 
 
					<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option>
 
 
					<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option>
 
 
					<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option>
 
 
					<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option>
 
 
					<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option>
 
 
					<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option>
 
 
					<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option>
 
 
					<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option>
 
 
					<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option>
 
 
					<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option>
 
 
					<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option>
 
 
					<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option>
 
 
					<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option>
 
 
					<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option>
 
 
					<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option>
 
 
					<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option>
 
 
					<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option>
 
 
					<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option>
 
 
					<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option>
 
 
					<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option>
 
 
					<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option>
 
 
					<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option>
 
 
					<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option>
 
 
					<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option>
 
 
					<Option Value="101000205| 0 | 0" >R.O.C. EXPENSES   com</Option>
 
 
					<Option Value="101001240| 0 | 0" >RATE AMENDMENT - CI/SGI CASTINGS PURCHASE (DOMESTIC)   ME</Option>
 
 
					<Option Value="101000866| 0 | 0" >RATE AMENDMENT - SALES CI/SGI MACH.CASTINGS (DOMESTIC)   MEPL</Option>
 
 
					<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option>
 
 
					<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option>
 
 
					<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option>
 
 
					<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option>
 
 
					<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option>
 
 
					<Option Value="101001008| 0 | 0" >REC TRADE EXPENSES   ME</Option>
 
 
					<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option>
 
 
					<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option>
 
 
					<Option Value="101000207| 0 | 0" >RENT ,RATES &TAXES   com</Option>
 
 
					<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MEPL</Option>
 
 
					<Option Value="101000318| 0 | 0" >RENT TO MUTHA ENGINEERING   msipl</Option>
 
 
					<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option>
 
 
					<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option>
 
 
					<Option Value="101000208| 0 | 0" >REPAIRS & MAINTAINANCE-GENERAL   com</Option>
 
 
					<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option>
 
 
					<Option Value="101001231| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY ( LABOUR )   MSIPL</Option>
 
 
					<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000211| 0 | 0" >RETAINERSHIP CHARGES   com</Option>
 
 
					<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option>
 
 
					<Option Value="101000212| 0 | 0" >ROC FILING FEES   com</Option>
 
 
					<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option>
 
 
					<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option>
 
 
					<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option>
 
 
					<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option>
 
 
					<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option>
 
 
					<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option>
 
 
					<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option>
 
 
					<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option>
 
 
					<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option>
 
 
					<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option>
 
 
					<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option>
 
 
					<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option>
 
 
					<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option>
 
 
					<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option>
 
 
					<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option>
 
 
					<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option>
 
 
					<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option>
 
 
					<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option>
 
 
					<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option>
 
 
					<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option>
 
 
					<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option>
 
 
					<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option>
 
 
					<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option>
 
 
					<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option>
 
 
					<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option>
 
 
					<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option>
 
 
					<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option>
 
 
					<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option>
 
 
					<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option>
 
 
					<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option>
 
 
					<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option>
 
 
					<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option>
 
 
					<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option>
 
 
					<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option>
 
 
					<Option Value="101000829| 0 | 0" >SALE TAX DUES   DI</Option>
 
 
					<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option>
 
 
					<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option>
 
 
					<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option>
 
 
					<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option>
 
 
					<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option>
 
 
					<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option>
 
 
					<Option Value="101001184| 0 | 0" >SALES  TAX APPEAL FILING FEES   MEPL</Option>
 
 
					<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option>
 
 
					<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option>
 
 
					<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option>
 
 
					<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option>
 
 
					<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option>
 
 
					<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option>
 
 
					<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option>
 
 
					<Option Value="101001230| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) RATE REDUCTION   MEPL</Option>
 
 
					<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option>
 
 
					<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option>
 
 
					<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option>
 
 
					<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option>
 
 
					<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option>
 
 
					<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option>
 
 
					<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option>
 
 
					<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option>
 
 
					<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option>
 
 
					<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option>
 
 
					<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option>
 
 
					<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option>
 
 
					<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option>
 
 
					<Option Value="101000637| 0 | 0" >SALES PROMOTION   COM</Option>
 
 
					<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option>
 
 
					<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option>
 
 
					<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option>
 
 
					<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option>
 
 
					<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option>
 
 
					<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option>
 
 
					<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option>
 
 
					<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option>
 
 
					<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option>
 
 
					<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option>
 
 
					<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option>
 
 
					<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option>
 
 
					<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option>
 
 
					<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option>
 
 
					<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option>
 
 
					<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option>
 
 
					<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option>
 
 
					<Option Value="101000216| 0 | 0" >SEMINAR & CONFERANCE CHARGES   com</Option>
 
 
					<Option Value="101000648| 0 | 0" >SHORT/EXCESS IN EXCHANGE OF FORIEGN  CURRENCY   MEPL</Option>
 
 
					<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option>
 
 
					<Option Value="101001120| 0 | 0" >SOCIAL WELFARE EXPENSES   MFPL</Option>
 
 
					<Option Value="101001052| 0 | 0" >SOFTWARE EXPENSES   MEPL</Option>
 
 
					<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option>
 
 
					<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option>
 
 
					<Option Value="101000896| 0 | 0" >SPONSORSHIP CHARGES   </Option>
 
 
					<Option Value="101000221| 0 | 0" >SUBSCRIPTION   com</Option>
 
 
					<Option Value="101000873| 0 | 0" >SUNDRY CREDITORS W/OFF ACCOUNT   MFPL</Option>
 
 
					<Option Value="101000048| 0 | 0" >SUNDRY CRS. WRITTEN OFF   COM</Option>

 
 
					<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option>
 
 
					<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option>
 
 
					<Option Value="101000651| 0 | 0" >SUNDRY DRS. WRITTEN/OFF   MEPL</Option>
 
 
					<Option Value="101001129| 0 | 0" >SWACHH BAHART CESS   MEPL</Option>
 
 
					<Option Value="101001178| 0 | 0" >SWACHH BHARAT CESS EXPENSES ACCOUNT   </Option>
 
 
					<Option Value="101000800| 0 | 0" >T.S.PROGRAM EXPENSES   </Option>
 
 
					<Option Value="101000238| 0 | 0" >TEA & HOTEL EXP (GUEST)   com</Option>
 
 
					<Option Value="101000241| 0 | 0" >TELEPHONE CHARGES   com</Option>
 
 
					<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option>
 
 
					<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option>
 
 
					<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option>
 
 
					<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option>
 
 
					<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option>
 
 
					<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option>
 
 
					<Option Value="101000657| 0 | 0" >TPM MEMBERSHIP FEES   MEPL</Option>
 
 
					<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option>
 
 
					<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option>
 
 
					<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option>
 
 
					<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option>
 
 
					<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option>
 
 
					<Option Value="101000658| 0 | 0" >TRAVELLING EXPENSES   COM</Option>
 
 
					<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option>
 
 
					<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option>
 
 
					<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option>
 
 
					<Option Value="101000663| 0 | 0" >VAT REDUCTION 2%   MEPL</Option>
 
 
					<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option>
 
 
					<Option Value="101000960| 0 | 0" >VAT TAX APPEAL FEE   MEPL</Option>
 
 
					<Option Value="101000842| 0 | 0" >VAT TAX DUES   </Option>
 
 
					<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option>
 
 
					<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option>
 
 
					<Option Value="101000248| 0 | 0" >VEHICLE REPAIRS & MAINT   com</Option>
 
 
					<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option>
 
 
					<Option Value="101000669| 0 | 0" >WARRANTY CLAIM   MEPL</Option>
 
 
					<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option>
 
 
					<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option>
 
 
					<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option>
 
 
					<Option Value="101000465| 0 | 0" >WATER PLOUTION   DI </Option>
 
 
					<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option>
 
 
					<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option>
 
 
					<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option>
 
 
					<Option Value="101000880| 0 | 0" >WINDMILL EXPENSES   MEPL</Option>
 
 
					<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option>
 
 
					<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option>
 
 
					<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option>
 
 
					<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option>
 
 
					<Option Value="101001143| 0 | 0" >WMDC DUES   DI</Option>
 
 
					<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option>
 
 
					<Option Value="101000815| 0 | 0" >XEROX MACHINE RENT PAID   ME</Option>
 
 
					<Option Value="101001242| 0 | 0" >Z CLOSED FACTORY BUILDING â POWDER COATING PLANT   U-III</Option>
					</select>				</Td>
			</tr>
			<tr>
			  <td>
					<label class="caption">Sales GL</label>				</td>
				<td>
					<Select id="drpSaleGlAcno" name="drpSaleGlAcno"  Tabindex=11 >	
					<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option> 
 <Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option> 
 
 
					<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option> 
 
 
					<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option> 
 
 
					<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option> 
 
 
					<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option> 
 
 
					<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option> 
 
 
					<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option> 
 
 
					<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option> 
 
 
					<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option> 
 
 
					<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option> 
 
 
					<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option> 
 
 
					<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option> 
 
 
					<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option> 
 
 
					<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option> 
 
 
					<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option> 
 
 
					<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option> 
 
 
					<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option> 
 
 
					<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option> 
 
 
					<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option> 
 
 
					<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option> 
 
 
					<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option> 
 
 
					<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option> 
 
 
					<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option> 
 
 
					<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option> 
 
 
					<Option Value="101000006|101140004|0" >COMPUTER   COM</Option> 
 
 
					<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option> 
 
 
					<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option> 
 
 
					<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option> 
 
 
					<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option> 
 
 
					<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option> 
 
 
					<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option> 
 
 
					<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option> 
 
 
					<Option Value="101000032| 0 | 0" >CURRENCY FLUCTUATION ACCOUNT   COM</Option> 
 
 
					<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option> 
 
 
					<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option> 
 
 
					<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option> 
 
 
					<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option> 
 
 
					<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option> 
 
 
					<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option> 
 
 
					<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option> 
 
 
					<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option> 
 
 
					<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option> 
 
 
					<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option> 
 
 
					<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option> 
 
 
					<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option> 
 
 
					<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option> 
 
 
					<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option> 
 
 
					<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option> 
 
 
					<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option> 
 
 
					<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option> 
 
 
					<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option> 
 
 
					<Option Value="101000006|101140099|0" >ELECTRIFICATION H-25 PART-II   MEPL</Option> 
 
 
					<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option> 
 
 
					<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option> 
 
 
					<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option> 
 
 
					<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option> 
 
 
					<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option> 
 
 
					<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option> 
 
 
					<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option> 
 
 
					<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option> 
 
 
					<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option> 
 
 
					<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option> 
 
 
					<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option> 
 
 
					<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option> 
 
 
					<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option> 
 
 
					<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option> 
 
 
					<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option> 
 
 
					<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option> 
 
 
					<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option> 
 
 
					<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option> 
 
 
					<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option> 
 
 
					<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option> 
 
 
					<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option> 
 
 
					<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option> 
 
 
					<Option Value="101000006|101140098|0" >FACTORY BUILDING H-25 PART-II   MEPL</Option> 
 
 
					<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option> 
 
 
					<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option> 
 
 
					<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140100|0" >FACTORY BUILDINGâPOWDER COATING PLANT   MEPL III</Option> 
 
 
					<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option> 
 
 
					<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option> 
 
 
					<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option> 
 
 
					<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option> 
 
 
					<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option> 
 
 
					<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option> 
 
 
					<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option> 
 
 
					<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option> 
 
 
					<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option> 
 
 
					<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option> 
 
 
					<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option> 
 
 
					<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option> 
 
 
					<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option> 
 
 
					<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option> 
 
 
					<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option> 
 
 
					<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option> 
 
 
					<Option Value="101000006|101140068|0" >FURNITURE   DI</Option> 
 
 
					<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option> 
 
 
					<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option> 
 
 
					<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option> 
 
 
					<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option> 
 
 
					<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option> 
 
 
					<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option> 
 
 
					<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option> 
 
 
					<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option> 
 
 
					<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option> 
 
 
					<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option> 
 
 
					<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option> 
 
 
					<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option> 
 
 
					<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option> 
 
 
					<Option Value="101000151| 0 | 0" >INSURANCE   com</Option> 
 
 
					<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option> 
 
 
					<Option Value="101000963| 0 | 0" >INSURANCE-EXPORT SHIPMENT POLICY   ME</Option> 
 
 
					<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option> 
 
 
					<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option> 
 
 
					<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option> 
 
 
					<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option> 
 
 
					<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option> 
 
 
					<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option> 
 

 
					<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option> 
 
 
					<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option> 
 
 
					<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option> 
 
 
					<Option Value="101001165| 0 | 0" >IPS SUBSIDY 2012-13 (OTHER INCOME)   DI</Option> 
 
 
					<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option> 
 
 
					<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option> 
 
 
					<Option Value="101000722| 0 | 0" >JOB WORK CHARGES LABOUR MSIPL   MSIPL</Option> 
 
 
					<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option> 
 
 
					<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option> 
 
 
					<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option> 
 
 
					<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option> 
 
 
					<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option> 
 
 
					<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option> 
 
 
					<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option> 
 
 
					<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option> 
 
 
					<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option> 
 
 
					<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option> 
 
 
					<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option> 
 
 
					<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option> 
 
 
					<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option> 
 
 
					<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option> 
 
 
					<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option> 
 
 
					<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option> 
 
 
					<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option> 
 
 
					<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option> 
 
 
					<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option> 
 
 
					<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option> 
 
 
					<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option> 
 
 
					<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option> 
 
 
					<Option Value="101001069| 0 | 0" >MACHINING DEFECTIVE-REJECTION   MEPL</Option> 
 
 
					<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option> 
 
 
					<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option> 
 
 
					<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option> 
 
 
					<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option> 
 
 
					<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option> 
 
 
					<Option Value="101000006|101140101|0" >MONO RAIL   MEPL-III</Option> 
 
 
					<Option Value="101000006|101140030|0" >MONO RAIL   MSIPL</Option> 
 
 
					<Option Value="101001243| 0 | 0" >MONO RAIL   U-III</Option> 
 
 
					<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option> 
 
 
					<Option Value="101000916| 0 | 0" >NICKEL PURCHASE   </Option> 
 
 
					<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option> 
 
 
					<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option> 
 
 
					<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option> 
 
 
					<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option> 
 
 
					<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option> 
 
 
					<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option> 
 
 
					<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option> 
 
 
					<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option> 
 
 
					<Option Value="101000006|101140037|0" >PATTERN   DI</Option> 
 
 
					<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option> 
 
 
					<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option> 
 
 
					<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option> 
 
 
					<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option> 
 
 
					<Option Value="101000183| 0 | 0" >PIG IRON   com</Option> 
 
 
					<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option> 
 
 
					<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option> 
 
 
					<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option> 
 
 
					<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option> 
 
 
					<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option> 
 
 
					<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option> 
 
 
					<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option> 
 
 
					<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option> 
 
 
					<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option> 
 
 
					<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option> 
 
 
					<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option> 
 
 
					<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option> 
 
 
					<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option> 
 
 
					<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option> 
 
 
					<Option Value="101001261| 0 | 0" >PROFIT ON CUPOLA MACHINE - SCRAP   DI</Option> 
 
 
					<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option> 
 
 
					<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option> 
 
 
					<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option> 
 
 
					<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option> 
 
 
					<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option> 
 
 
					<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option> 
 
 
					<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option> 
 
 
					<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option> 
 
 
					<Option Value="101001265| 0 | 0" >PROFIT ON SALE OF VEHICLE (ACTIVA)   MFPL</Option> 
 
 
					<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option> 
 
 
					<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option> 
 
 
					<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option> 
 
 
					<Option Value="101001239| 0 | 0" >PUR.AGRO CHARCOAL   MFPL</Option> 
 
 
					<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option> 
 
 
					<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option> 
 
 
					<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option> 
 
 
					<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option> 
 
 
					<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option> 
 
 
					<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option> 
 
 
					<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option> 
 
 
					<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option> 
 
 
					<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option> 
 
 
					<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option> 
 
 
					<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option> 
 
 
					<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option> 
 
 
					<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option> 
 
 
					<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option> 
 
 
					<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option> 
 
 
					<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option> 
 
 
					<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option> 
 
 
					<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option> 
 
 
					<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option> 
 
 
					<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option> 
 
 
					<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option> 
 
 
					<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option> 
 
 
					<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option> 
 
 
					<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option> 
 
 
					<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option> 
 
 
					<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option> 
 
 
					<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option> 
 
 
					<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option> 
 
 
					<Option Value="101001240| 0 | 0" >RATE AMENDMENT - CI/SGI CASTINGS PURCHASE (DOMESTIC)   ME</Option> 
 
 
					<Option Value="101000866| 0 | 0" >RATE AMENDMENT - SALES CI/SGI MACH.CASTINGS (DOMESTIC)   MEPL</Option> 
 
 
					<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option> 
 
 
					<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option> 
 
 
					<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option> 
 
 
					<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option> 
 
 
					<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option> 
 
 
					<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option> 
 
 
					<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option> 
 
 
					<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MEPL</Option> 
 
 
					<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option> 
 
 
					<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option> 
 
 
					<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option> 
 
 
					<Option Value="101001231| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY ( LABOUR )   MSIPL</Option> 
 
 
					<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option> 
 
 
					<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option> 
 
 
					<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option> 
 
 
					<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option> 
 
 
					<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option> 
 
 
					<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option> 
 
 
					<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option> 
 
 
					<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option> 
 
 
					<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option> 
 
 
					<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option> 
 
 
					<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option> 
 
 
					<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option> 
 
 
					<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option> 
 
 
					<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option> 
 
 
					<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option> 
 
 
					<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option> 
 
 
					<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option> 
 
 
					<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option> 
 
 
					<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option> 
 
 
					<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option> 
 
 
					<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option> 
 
 
					<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option> 
 
 
					<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option> 
 
 
					<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option> 
 
 
					<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option> 
 
 
					<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option> 
 
 
					<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option> 
 
 
					<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option> 
 
 
					<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option> 
 
 
					<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option> 
 
 
					<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option> 
 
 
					<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option> 
 
 
					<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option> 
 
 
					<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option> 
 
 
					<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option> 
 
 
					<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option> 
 
 
					<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option> 
 
 
					<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option> 
 
 
					<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option> 
 
 
					<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option> 
 
 
					<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option> 
 
 
					<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option> 
 
 
					<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option> 
 
 
					<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option> 
 
 
					<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option> 
 
 
					<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option> 
 
 
					<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option> 
 
 
					<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option> 
 
 
					<Option Value="101001230| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) RATE REDUCTION   MEPL</Option> 
 
 
					<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option> 
 
 
					<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option> 
 
 
					<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option> 
 
 
					<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option> 
 
 
					<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option> 
 
 
					<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option> 
 
 
					<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option> 
 
 
					<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option> 
 
 
					<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option> 
 
 
					<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option> 
 
 
					<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option> 
 
 
					<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option> 
 
 
					<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option> 
 
 
					<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option> 
 
 
					<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option> 
 
 
					<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option> 
 
 
					<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option> 
 
 
					<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option> 
 
 
					<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option> 
 
 
					<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option> 
 
 
					<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option> 
 
 
					<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option> 
 
 
					<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option> 
 
 
					<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option> 
 
 
					<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option> 
 
 
					<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option> 
 
 
					<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option> 
 
 
					<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option> 
 
 
					<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option> 
 
 
					<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option> 
 
 
					<Option Value="101000648| 0 | 0" >SHORT/EXCESS IN EXCHANGE OF FORIEGN  CURRENCY   MEPL</Option> 
 
 
					<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option> 
 
 
					<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option> 
 
 
					<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option> 
 
 
					<Option Value="101000048| 0 | 0" >SUNDRY CRS. WRITTEN OFF   COM</Option> 
 
 
					<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option> 
 
 
					<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option> 
 
 
					<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option> 
 
 
					<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option> 
 
 
					<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option> 
 
 
					<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option> 
 
 
					<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option> 
 
 
					<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option> 
 
 
					<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option> 
 
 
					<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option> 
 
 
					<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option> 
 
 
					<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option> 
 
 
					<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option> 
 
 
					<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option> 
 
 
					<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option> 
 
 
					<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option> 
 
 
					<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option> 
 
 
					<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option> 
 
 
					<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option> 
 
 
					<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option> 
 
 
					<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option> 
 
 
					<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option> 
 
 
					<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option> 
 
 
					<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option> 
 
 
					<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option> 
 
 
					<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option> 
 
 
					<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option> 
 
 
					<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option> 
 
 
					<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option> 
 
 
					<Option Value="101001242| 0 | 0" >Z CLOSED FACTORY BUILDING â POWDER COATING PLANT   U-III</Option> 
					</select>				</Td>
			</tr>
 
			<tr>
			  <td>
					<label class="caption" >Sales Return</label>				</td>
				<Td>
					<Select id="drpSaleRetAcno" name="drpSaleRetAcno"  Tabindex=12 >
					
 
					<Option Value="101000255| 0 | 0" >ANNEALING  CHARGES   msipl</Option> 
 
 
					<Option Value="101000040| 0 | 0" >APPRICIATION VALUE OF SHARE   MEPL</Option> 
 
 
					<Option Value="101000006|101140071|0" >AUTO TRUCK TRIALOR   DI</Option> 
 
 
					<Option Value="101000086| 0 | 0" >BANK DIVIDEND   com</Option> 
 
 
					<Option Value="101000089| 0 | 0" >BILL DISCOUNTING CHARGES RECEIVED   com</Option> 
 
 
					<Option Value="101000993| 0 | 0" >BOUGHTOUT ITEM FOR FORCE MOTORS -RAW MATERIAL   MEPL</Option> 
 
 
					<Option Value="101000957| 0 | 0" >BOUGHTOUT ITEM FOR JCB -RAW MATERIAL   ME</Option> 
 
 
					<Option Value="101001186| 0 | 0" >BOUGHTOUT ITEM FOR -TACO ASSEMBLY   MEPL</Option> 
 
 
					<Option Value="101000975| 0 | 0" >BOX TRANSFER CHARGES   </Option> 
 
 
					<Option Value="101000333| 0 | 0" >C.I.BOARING PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000334| 0 | 0" >C.I.INNOCULIN PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000335| 0 | 0" >C.I.SCRAP PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000336| 0 | 0" >C.R.C. SCRAP PURCHASE  A/C   MFPL</Option> 
 
 
					<Option Value="101000337| 0 | 0" >CAPATIVE CON R.C.SAND   MFPL</Option> 
 
 
					<Option Value="101000338| 0 | 0" >CAPATIVE CONS.SHELL-MOULD   MFPL</Option> 
 
 
					<Option Value="101000006|101140073|0" >CAPITAL EXPS. OTHER BUILDING. D-11 (WIP)   DI</Option> 
 
 
					<Option Value="101000006|101140090|0" >CAR - FORCE ONE SX  MH-11-BH-4110   MEPL</Option> 
 
 
					<Option Value="101000006|101140003|0" >CAR INNOVA MH-11-Y-7629   MEPL</Option> 
 
 
					<Option Value="101000814| 0 | 0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option> 
 
 
					<Option Value="101000006|101140076|0" >CAR-CHEVROLET BEAT LTO TCDI   ME</Option> 
 
 
					<Option Value="101000101| 0 | 0" >CASTING PURCHASE A/C   com</Option> 
 
 
					<Option Value="101000006|101140084|0" >CENTRALISED COOLENT SYSTEM   MEPL</Option> 
 
 
					<Option Value="101000339| 0 | 0" >CI NICKEL PURCHASE   MFPL</Option> 
 
 
					<Option Value="101001163| 0 | 0" >CLAIM FOR NON DELIVERING OF MATERIAL   MEPL</Option> 
 
 
					<Option Value="101000924| 0 | 0" >CLEARING FORWARDING CHARGES   </Option> 
 
 
					<Option Value="101001173| 0 | 0" >CMM INSPECTION CHARGES (INCOME)   MEPL</Option> 
 
 
					<Option Value="101000955| 0 | 0" >COMPENSATION  OF GENERATON CLAIM   MEPL</Option> 
 
 
					<Option Value="101000340| 0 | 0" >COMPENSATION RECD. FROM INSURANCE   MFPL</Option> 
 
 
					<Option Value="101000006|101140004|0" >COMPUTER   COM</Option> 
 
 
					<Option Value="101000104| 0 | 0" >CONSULTATION FEES-TECHNICAL   com</Option> 
 
 
					<Option Value="101000105| 0 | 0" >CONSUMABLE PURCHASE   com</Option> 
 
 
					<Option Value="101000411| 0 | 0" >CONSUMABLE STORES   DI </Option> 
 
 
					<Option Value="101000412| 0 | 0" >CONSUMABLE TOOLS   DI </Option> 
 
 
					<Option Value="101000341| 0 | 0" >COPPER SCRAP PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000109| 0 | 0" >CORE MAKING CHARGES   com</Option> 
 
 
					<Option Value="101000342| 0 | 0" >CPC PUR.   MFPL</Option> 
 
 
					<Option Value="101001084| 0 | 0" >CST 14% NO C FORM   MFPL</Option> 
 
 
					<Option Value="101000032| 0 | 0" >CURRENCY FLUCTUATION ACCOUNT   COM</Option> 
 
 
					<Option Value="101000006|101140069|0" >DEAD STOCK   DI</Option> 
 
 
					<Option Value="101000695| 0 | 0" >DEEMED EXPORT   COM</Option> 
 
 
					<Option Value="101000111| 0 | 0" >DEEMED EXPORT SALES   com</Option> 
 
 
					<Option Value="101000978| 0 | 0" >DEPB CREDIT (BAL.)   MEPL</Option> 
 
 
					<Option Value="101000992| 0 | 0" >DEPB CREDIT A/C   MEPL</Option> 
 
 
					<Option Value="101000344| 0 | 0" >DEPB LICANCE   MFPL</Option> 
 
 
					<Option Value="101000006|101140005|0" >DIES & FIXTURE   DI</Option> 
 
 
					<Option Value="101000413| 0 | 0" >DISCOUNT RECEIVED ACCOUNT   DI </Option> 
 
 
					<Option Value="101000959| 0 | 0" >DIVIDEND RECEIVED - KUB BANK LIMITED   DI</Option> 
 
 
					<Option Value="101000691| 0 | 0" >DIVIDEND RECEIVED A/C   </Option> 
 
 
					<Option Value="101000488| 0 | 0" >DOMESTIC PACKING   MEPL</Option> 
 
 
					<Option Value="101000117| 0 | 0" >ELECTRIC INSPECTION FEES   com</Option> 
 
 
					<Option Value="101001123| 0 | 0" >ELECTRICAL LINING EXPENSES   MFPL</Option> 
 
 
					<Option Value="101000788| 0 | 0" >ELECTRICITY CHARGES   DI</Option> 
 
 
					<Option Value="101001016| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-21)   MEPL</Option> 
 
 
					<Option Value="101001017| 0 | 0" >ELECTRICITY DUTY EXCEMPTION (H-25)   MEPL</Option> 
 
 
					<Option Value="101000006|101140006|0" >ELECTRIFICATION   DI/MFPL</Option> 
 
 
					<Option Value="101000006|101140081|0" >ELECTRIFICATION H-25   H21 WIP</Option> 
 
 
					<Option Value="101000006|101140099|0" >ELECTRIFICATION H-25 PART-II   MEPL</Option> 
 
 
					<Option Value="101000006|101140008|0" >ELECTRIFICATION U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140009|0" >ELECTRIFICATION U-2   MEPL</Option> 
 
 
					<Option Value="101000006|101140010|0" >ELECTRIFICATION WIP  (H-21)   MEPL</Option> 
 
 
					<Option Value="101000006|101140011|0" >ELECTRIFICATION WIP (H-25)   MEPL</Option> 
 
 
					<Option Value="101000006|101140064|0" >ERECTION  CHARGES   DI</Option> 
 
 
					<Option Value="101000689| 0 | 0" >ESCORT AND OCTROI EXPENSES   </Option> 
 
 
					<Option Value="101000918| 0 | 0" >ESCORT/OCTORI REFUND A/C   ME</Option> 
 
 
					<Option Value="101000906| 0 | 0" >EXCISE REFUND (DRAWING & DESIGN)   ME</Option> 
 
 
					<Option Value="101000692| 0 | 0" >EXCISE REFUND ACCOUNT   </Option> 
 
 
					<Option Value="101000123| 0 | 0" >EXPORT- AIR FREIGHT   MEPL</Option> 
 
 
					<Option Value="101000041| 0 | 0" >EXPORT SALES   COM</Option> 
 
 
					<Option Value="101000490| 0 | 0" >EXPORT-CARRIAGE INWARD   MEPL</Option> 
 
 
					<Option Value="101000491| 0 | 0" >EXPORT-CONSUMABLES   MEPL</Option> 
 
 
					<Option Value="101000492| 0 | 0" >EXPORT-ELECTROPLATING CHARGES   MEPL</Option> 
 
 
					<Option Value="101000493| 0 | 0" >EXPORT-MACHINING CHARGES   MEPL</Option> 
 
 
					<Option Value="101000496| 0 | 0" >EXPORT-PACKING   MEPL</Option> 
 
 
					<Option Value="101000497| 0 | 0" >EXPORT-REJECTION & REWORK   MEPL</Option> 
 
 
					<Option Value="101000498| 0 | 0" >EXPORT-TOOLING   MEPL</Option> 
 
 
					<Option Value="101000499| 0 | 0" >EXPORT-TRANSPORT   MEPL</Option> 
 
 
					<Option Value="101000415| 0 | 0" >FACOTRY INSURANCE   DI </Option> 
 
 
					<Option Value="101000006|101140013|0" >FACTORY BUILDING - WIP (H-25)   MEPL</Option> 
 
 
					<Option Value="101000006|101140078|0" >FACTORY BUILDING (CF)   DI</Option> 
 
 
					<Option Value="101000006|101140082|0" >FACTORY BUILDING H-25   FB H-25</Option> 
 
 
					<Option Value="101000006|101140098|0" >FACTORY BUILDING H-25 PART-II   MEPL</Option> 
 
 
					<Option Value="101000006|101140094|0" >FACTORY BUILDING H-25 PART-II   UNIT-IV (WIP)   MEPL</Option> 
 
 
					<Option Value="101000350| 0 | 0" >FACTORY BUILDING REPAIRS MAINT   MFPL</Option> 
 
 
					<Option Value="101000006|101140014|0" >FACTORY BUILDING U-1   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140015|0" >FACTORY BUILDING U-2   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140100|0" >FACTORY BUILDINGâPOWDER COATING PLANT   MEPL III</Option> 
 
 
					<Option Value="101000006|101140086|0" >FACTORY EQUIPMENTS   </Option> 
 
 
					<Option Value="101000125| 0 | 0" >FACTORY EXPENSES   com</Option> 
 
 
					<Option Value="101000126| 0 | 0" >FACTORY INSPECTION FEES   com</Option> 
 
 
					<Option Value="101000127| 0 | 0" >FACTORY LICENCE FEES   com</Option> 
 
 
					<Option Value="101000352| 0 | 0" >FERRO CHROMIMUM PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000353| 0 | 0" >FERRO MANGANSE PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000354| 0 | 0" >FERRO MOLLY PURCHASE A\C   MFPL</Option> 
 
 
					<Option Value="101000355| 0 | 0" >FERRO PHOSPORUS PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000356| 0 | 0" >FERRO SILICON MANGANSE PURCHASES A/C   MFPL</Option> 
 
 
					<Option Value="101000357| 0 | 0" >FERRO SILICON PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000131| 0 | 0" >FETTLING & PAINTING & GATE CUTTING & OTHER CHRGES   com</Option> 
 
 
					<Option Value="101000971| 0 | 0" >FETTLING CHARGES   </Option> 
 
 
					<Option Value="101000133| 0 | 0" >FINE RECOVERY A/C   com</Option> 
 
 
					<Option Value="101000006|101140017|0" >FORKLIFT TRUCK   MEPL</Option> 
 
 
					<Option Value="101000416| 0 | 0" >FOUNDRY EXPENSES   DI </Option> 
 
 
					<Option Value="101000006|101140088|0" >FREEHOLD LAND-NAGEWADI TAL. & DIST.SATARA (GAT NO.291)   MEPL</Option> 
 
 
					<Option Value="101000501| 0 | 0" >FREEHOLD PLOT NAIGAON KESURDI(INVESTMESNT)   MEPL</Option> 
 
 
					<Option Value="101000006|101140019|0" >FREEHOLD PLOT-KESURDI NAIGAON(ASSET)   MEPL</Option> 
 
 
					<Option Value="101001134| 0 | 0" >FURNACE HEAT CHARGES   MSIPL</Option> 
 
 
					<Option Value="101000358| 0 | 0" >FURNACE LINING EXPENSES   MFPL</Option> 
 
 
					<Option Value="101000006|101140068|0" >FURNITURE   DI</Option> 
 
 
					<Option Value="101000006|101140074|0" >FURNITURE & DEAD STOCK H-25   MEPL</Option> 
 
 
					<Option Value="101000006|101140021|0" >FURNITURE & DEAD STOCK U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140022|0" >FURNITURE & DEAD STOCK U-2   MEPL</Option> 
 
 
					<Option Value="101000359| 0 | 0" >GAS PURCHASE (SAND-RECLAMATION)   MFPL</Option> 
 
 
					<Option Value="101000006|101140023|0" >GATE AND WATCHMAN CABIN   MSIPL</Option> 
 
 
					<Option Value="101000973| 0 | 0" >GATE CUTTING CHARGES   </Option> 
 
 
					<Option Value="101000360| 0 | 0" >HARDNER PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101001011| 0 | 0" >INCOME TAX REFUND (A.Y.2004-05)   ME</Option> 
 
 
					<Option Value="101000418| 0 | 0" >INDUCTION FURNASE LINING CHARGES   DI </Option> 
 
 
					<Option Value="101001096| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2013-14   DI</Option> 
 
 
					<Option Value="101001119| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) 2014-15   MEPL</Option> 
 
 
					<Option Value="101000939| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2011-12   MEPL</Option> 
 
 
					<Option Value="101001026| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY (IPS) MEGA PROJECT  2012-13   MEPL</Option> 
 
 
					<Option Value="101000936| 0 | 0" >INDUSTRIAL PROMOTION SUBSIDY-EXPANSION-PSI 2007-12   </Option> 
 
 
					<Option Value="101000419| 0 | 0" >INSPECTION CHARGES   DI </Option> 
 
 
					<Option Value="101000151| 0 | 0" >INSURANCE   com</Option> 
 
 
					<Option Value="101000988| 0 | 0" >INSURANCE  CLAIM RECEIVED   ME</Option> 
 
 
					<Option Value="101000963| 0 | 0" >INSURANCE-EXPORT SHIPMENT POLICY   ME</Option> 
 
 
					<Option Value="101000954| 0 | 0" >INTEREST ON AXIS BANK FD   DI</Option> 
 
 
					<Option Value="101001068| 0 | 0" >INTEREST ON FD SARASWAT CO-OP.BANK LTD. A/C NO.370   U-III</Option> 
 
 
					<Option Value="101000524| 0 | 0" >INTEREST ON INCOME TAX REFUND   MEPL</Option> 
 
 
					<Option Value="101000877| 0 | 0" >INTEREST RECEIVED ON ADVANCES   </Option> 
 
 
					<Option Value="101001138| 0 | 0" >INTEREST RECEIVED ON INVESTMENT   ME</Option> 
 
 
					<Option Value="101000871| 0 | 0" >INTEREST RECEIVED ON MSEB DEPOSIT   DI</Option> 
 
 
					<Option Value="101001124| 0 | 0" >INTEREST RECEIVED ON RECURING DEPOSIT   MFPL</Option> 
 
 
					<Option Value="101001155| 0 | 0" >INTEREST RECEIVED ON ROHA MEGACITY DEVELOPERS LLP   </Option> 
 
 
					<Option Value="101001108| 0 | 0" >INTEREST RECEIVED ON WATER DEPOSIT (MIDC)   MFPL</Option> 
 
 
					<Option Value="101001165| 0 | 0" >IPS SUBSIDY 2012-13 (OTHER INCOME)   DI</Option> 
 
 
					<Option Value="101000006|101140024|0" >JIG DIES & FIXTURE U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140025|0" >JIG DIES & FIXTURE U-2   MEPL</Option> 
 
 
					<Option Value="101000301| 0 | 0" >JOB WORK CHARGES   msipl</Option> 
 
 
					<Option Value="101000722| 0 | 0" >JOB WORK CHARGES LABOUR MSIPL   MSIPL</Option> 
 
 
					<Option Value="101000972| 0 | 0" >KNOCKOUT CHARGES   </Option> 
 
 
					<Option Value="101000006|101140063|0" >LABORATORY EQUIPMENT   MSIPL</Option> 
 
 
					<Option Value="101000374| 0 | 0" >LABORATORY EXPENSES   MFPL</Option> 
 
 
					<Option Value="101000709| 0 | 0" >LABOUR CHARGES A/C   </Option> 
 
 
					<Option Value="101000044| 0 | 0" >LABOUR PURCHASE ACCOUNT   COM</Option> 
 
 
					<Option Value="101000038| 0 | 0" >LABOUR SALES ACCOUNT   COM</Option> 
 
 
					<Option Value="101000006|101140077|0" >LAND (CF)   DI</Option> 
 
 
					<Option Value="101000006|101140067|0" >LAND (LEASEHOLD)   MFPL</Option> 
 
 
					<Option Value="101000006|101140085|0" >LAND (WINDMILL)   MEPL</Option> 
 
 
					<Option Value="101000006|101140028|0" >LEASEHOLD LAND (PLOT NO.H-21)   MEPL</Option> 
 
 
					<Option Value="101000006|101140093|0" >LEASEHOLD LAND (PLOT NO.H-25) PART-II   H25</Option> 
 
 
					<Option Value="101001136| 0 | 0" >LICENCE - FOCUS PRODUCT SCHEME   MEPL</Option> 
 
 
					<Option Value="101001185| 0 | 0" >LICENCE - MERCHANDISE EXPORTS OF INDIA SCHEME (MEIS)   MEPL</Option> 
 
 
					<Option Value="101000303| 0 | 0" >LICENCES RENEWAL FEES   msipl</Option> 
 
 
					<Option Value="101000941| 0 | 0" >LICENSE (STATUS HOLDER INCENTIVE SCRIP)   MEPL</Option> 
 
 
					<Option Value="101001079| 0 | 0" >LINER CUTTING CHARGES   MSIPL</Option> 
 
 
					<Option Value="101000961| 0 | 0" >LOADING & UNLOADING CHARGES   ALL</Option> 
 
 
					<Option Value="101001025| 0 | 0" >LOCAL BODY TAX (LBT)   MEPL</Option> 
 
 
					<Option Value="101000378| 0 | 0" >M.S.ROUND BAR   MFPL</Option> 
 
 
					<Option Value="101000379| 0 | 0" >M.S.SCRAP PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000591| 0 | 0" >MACHINE SHOP EXPENSES   MEPL</Option> 
 
 
					<Option Value="101000592| 0 | 0" >MACHINERY RENT PAID   MEPL</Option> 
 
 
					<Option Value="101000710| 0 | 0" >MACHINING CHARGES   </Option> 
 
 
					<Option Value="101001069| 0 | 0" >MACHINING DEFECTIVE-REJECTION   MEPL</Option> 
 
 
					<Option Value="101000165| 0 | 0" >MACHINING/LABOUR CHARGES   com</Option> 
 
 
					<Option Value="101000781| 0 | 0" >MANUFACTURING SALES RETURN   </Option> 
 
 
					<Option Value="101000935| 0 | 0" >MANUFACTURING SALES RETURN SHELL MOULD   </Option> 
 
 
					<Option Value="101000782| 0 | 0" >MANUFACTURING SALES RETURN-OMS   </Option> 
 
 
					<Option Value="101000167| 0 | 0" >MISC.INCOME   com</Option> 
 
 
					<Option Value="101000006|101140101|0" >MONO RAIL   MEPL-III</Option> 
 
 
					<Option Value="101000006|101140030|0" >MONO RAIL   MSIPL</Option> 
 
 
					<Option Value="101001243| 0 | 0" >MONO RAIL   U-III</Option> 
 
 
					<Option Value="101000381| 0 | 0" >MOULDING CHARGES   MFPL</Option> 
 
 
					<Option Value="101000916| 0 | 0" >NICKEL PURCHASE   </Option> 
 
 
					<Option Value="101000384| 0 | 0" >NOTICE PAY A/C   COM</Option> 
 
 
					<Option Value="101000006|101140033|0" >OFFICE BUILDING (PUNE FLAT)   MEPL</Option> 
 
 
					<Option Value="101000006|101140034|0" >OFFICE BUILDING U-1   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140035|0" >OFFICE BUILDING U-2   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140036|0" >OFFICE EQUIPMENT   MEPL/MFPL</Option> 
 
 
					<Option Value="101000934| 0 | 0" >ONE MONTH NOTICE PAYMENT   ME</Option> 
 
 
					<Option Value="101000385| 0 | 0" >OTHER RAW MATERIAL   MFPL</Option> 
 
 
					<Option Value="101000784| 0 | 0" >PACKING & FORWARDING-SALES   </Option> 
 
 
					<Option Value="101000696| 0 | 0" >PACKING & FORWARIDNG PURCHASE   </Option> 
 
 
					<Option Value="101000974| 0 | 0" >PAINTING CHARGES   </Option> 
 
 
					<Option Value="101000006|101140037|0" >PATTERN   DI</Option> 
 
 
					<Option Value="101000006|101140038|0" >PATTERN - JIG & DIES   MSIPL</Option> 
 
 
					<Option Value="101000398| 0 | 0" >PATTERN MAINTAINCES CHARGES   COM</Option> 
 
 
					<Option Value="101000772| 0 | 0" >PATTERN REPAIRS   MFPL</Option> 
 
 
					<Option Value="101000312| 0 | 0" >PF DAMAGES RECOVERED   msipl</Option> 
 
 
					<Option Value="101000183| 0 | 0" >PIG IRON   com</Option> 
 
 
					<Option Value="101000006|101140039|0" >PLANT & MACHINERY   DI/MSIPL</Option> 
 
 
					<Option Value="101000006|101140040|0" >PLANT & MACHINERY  (WIP)   DI</Option> 
 
 
					<Option Value="101000006|101140072|0" >PLANT & MACHINERY (H-25) WIP   MEPL</Option> 
 
 
					<Option Value="101000006|101140055|0" >PLANT & MACHINERY (WEIGHBRIDGE)   MFPL</Option> 
 
 
					<Option Value="101000006|101140092|0" >PLANT & MACHINERY ERRECTION   DI</Option> 
 
 
					<Option Value="101000006|101140079|0" >PLANT & MACHINERY H-25   H-21</Option> 
 
 
					<Option Value="101000006|101140041|0" >PLANT & MACHINERY U-1   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140042|0" >PLANT & MACHINERY U-2   MEPL/MFPL</Option> 
 
 
					<Option Value="101000006|101140043|0" >PLANT & MACHINERY U-3   MEPL</Option> 
 
 
					<Option Value="101000603| 0 | 0" >POWDER COATING CHARGES(DOMESTIC)   MEPL</Option> 
 
 
					<Option Value="101000604| 0 | 0" >POWDER COATING CHARGES(EXPORT)   MEPL</Option> 
 
 
					<Option Value="101000006|101140095|0" >POWDER COATING WIP   U-III</Option> 
 
 
					<Option Value="101001222| 0 | 0" >POWER & ELECTRICITY CHARGES - POWDER COATING PLANT   MFPL</Option> 
 
 
					<Option Value="101000874| 0 | 0" >POWER & ELECTRICITY CHARGES (H-25)   ME H25</Option> 
 
 
					<Option Value="101000186| 0 | 0" >POWER & ELECTRICITY EXPENSES   com</Option> 
 
 
					<Option Value="101001140| 0 | 0" >POWER CONSULTANCY CHARGES   DI/MFPL</Option> 
 
 
					<Option Value="101001261| 0 | 0" >PROFIT ON CUPOLA MACHINE - SCRAP   DI</Option> 
 
 
					<Option Value="101000609| 0 | 0" >PROFIT ON SALE OF  FREEHOLD LAND-KHINDWADI   MEPL</Option> 
 
 
					<Option Value="101000779| 0 | 0" >PROFIT ON SALE OF DEPB LICENCE   MEPL</Option> 
 
 
					<Option Value="101001152| 0 | 0" >PROFIT ON SALE OF FIXTURE   MEPL</Option> 
 
 
					<Option Value="101001194| 0 | 0" >PROFIT ON SALE OF INNOVA CAR (MH-11-Y-7629)   MEPL</Option> 
 
 
					<Option Value="101000195| 0 | 0" >PROFIT ON SALE OF MACHINERY   com</Option> 
 
 
					<Option Value="101000196| 0 | 0" >PROFIT ON SALE OF RELIANCE GROWTH FUND (D)   com</Option> 
 
 
					<Option Value="101000884| 0 | 0" >PROFIT ON SALE OF SCRAP CAR MH-18 B - 875   </Option> 
 
 
					<Option Value="101000197| 0 | 0" >PROFIT ON SALE OF SHARES   com</Option> 
 
 
					<Option Value="101001265| 0 | 0" >PROFIT ON SALE OF VEHICLE (ACTIVA)   MFPL</Option> 
 
 
					<Option Value="101001174| 0 | 0" >PROVISION FOR RATE REDUCTION   </Option> 
 
 
					<Option Value="101000433| 0 | 0" >PUR S.G CRC SCRAP   DI </Option> 
 
 
					<Option Value="101000434| 0 | 0" >PUR. C.I.SCRAP   DI </Option> 
 
 
					<Option Value="101001239| 0 | 0" >PUR.AGRO CHARCOAL   MFPL</Option> 
 
 
					<Option Value="101000435| 0 | 0" >PUR.ALUMINIUM SCRAP   DI </Option> 
 
 
					<Option Value="101000436| 0 | 0" >PUR.C.I.BOARING   DI </Option> 
 
 
					<Option Value="101000437| 0 | 0" >PUR.C.I.CASTINGS   DI </Option> 
 
 
					<Option Value="101000438| 0 | 0" >PUR.COKE   DI </Option> 
 
 
					<Option Value="101000611| 0 | 0" >PUR.CONS.STORES   MEPL</Option> 
 
 
					<Option Value="101000612| 0 | 0" >PUR.CONS.TOOLS   MEPL</Option> 
 
 
					<Option Value="101000439| 0 | 0" >PUR.M.S.SCRAP   DI </Option> 
 
 
					<Option Value="101000440| 0 | 0" >PUR.OTHER RAW MATERIAL   DI </Option> 
 
 
					<Option Value="101000441| 0 | 0" >PUR.PIG IRON   DI </Option> 
 
 
					<Option Value="101000442| 0 | 0" >PUR:-M.S.ROUND BAR   DI </Option> 
 
 
					<Option Value="101000613| 0 | 0" >PURCHASE (CI+SGI) CASTINGS   MEPL</Option> 
 
 
					<Option Value="101000614| 0 | 0" >PURCHASE CI SCRAP   MEPL</Option> 
 
 
					<Option Value="101001000| 0 | 0" >PURCHASE CI/SGI CASTINGS H-25   H25</Option> 
 
 
					<Option Value="101000615| 0 | 0" >PURCHASE EXPORT CASTING (SGI+CI)   MEPL</Option> 
 
 
					<Option Value="101000723| 0 | 0" >PURCHASE OF ALUMN.CASTINGS (DOM+EXPORT)   </Option> 
 
 
					<Option Value="101000387| 0 | 0" >PURCHASE OF CONSUMABLE STORES   MFPL</Option> 
 
 
					<Option Value="101001081| 0 | 0" >PURCHASE RETURN   </Option> 
 
 
					<Option Value="101000764| 0 | 0" >PURCHASE RETURN - ALUMN.CASTINGS -DOMESTIC    MEPL</Option> 
 
 
					<Option Value="101001001| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS H-25    H25</Option> 
 
 
					<Option Value="101000762| 0 | 0" >PURCHASE RETURN - CI/SGI CASTINGS-DOMESTIC    MEPL</Option> 
 
 
					<Option Value="101000763| 0 | 0" >PURCHASE RETURN - S.G.I CASTINGS-EXPORT    MEPL</Option> 
 
 
					<Option Value="101000688| 0 | 0" >PURCHASE S G I CASTING   MSIPL</Option> 
 
 
					<Option Value="101000616| 0 | 0" >PURCHASE SGI SCRAP   MEPL</Option> 
 
 
					<Option Value="101000443| 0 | 0" >PURCHASE SHELL MOULD (CORE MAKING)   DI </Option> 
 
 
					<Option Value="101001099| 0 | 0" >PURCHASE TIN INGOT   DI</Option> 
 
 
					<Option Value="101000444| 0 | 0" >PURCHASE-C.P.COKE   DI </Option> 
 
 
					<Option Value="101000314| 0 | 0" >QUALITY CONTROL EXPS   msipl</Option> 
 
 
					<Option Value="101000315| 0 | 0" >R.M. (OTHER)   msipl</Option> 
 
 
					<Option Value="101001240| 0 | 0" >RATE AMENDMENT - CI/SGI CASTINGS PURCHASE (DOMESTIC)   ME</Option> 
 
 
					<Option Value="101000866| 0 | 0" >RATE AMENDMENT - SALES CI/SGI MACH.CASTINGS (DOMESTIC)   MEPL</Option> 
 
 
					<Option Value="101000915| 0 | 0" >RATE DIFFERANCE   </Option> 
 
 
					<Option Value="101000970| 0 | 0" >RATE DIFFERANCE OMS   </Option> 
 
 
					<Option Value="101000316| 0 | 0" >RAW MATERIAL PURCHASE   msipl</Option> 
 
 
					<Option Value="101000388| 0 | 0" >RAW SILICA SAND PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000943| 0 | 0" >RAW SILICA SAND RECLAIMED PURCHASE   </Option> 
 
 
					<Option Value="101001007| 0 | 0" >REC TRADE  INCOME (INDIAN ENERGY EXCHANGE)   ME</Option> 
 
 
					<Option Value="101000914| 0 | 0" >REJECTION CHARGES   </Option> 
 
 
					<Option Value="101000445| 0 | 0" >REJECTION INWORD EXPENSES   DI </Option> 
 
 
					<Option Value="101001220| 0 | 0" >RENT FOR POWDER COATING PLANT   MEPL</Option> 
 
 
					<Option Value="101000622| 0 | 0" >RENTING OF IMMOVIABLE PROPERTY-CORP.OFFICE   MEPL</Option> 
 
 
					<Option Value="101000045| 0 | 0" >REPAIR SALES ACCOUNT   COM</Option> 
 
 
					<Option Value="101000209| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY   com</Option> 
 
 
					<Option Value="101001231| 0 | 0" >REPAIRS & MAINTAINANCE-MACHINERY ( LABOUR )   MSIPL</Option> 
 
 
					<Option Value="101000389| 0 | 0" >RESIN COATED SAND PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000390| 0 | 0" >RESIN LIQUID PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101001013| 0 | 0" >REWORK CHARGES - DOMESTIC   ME</Option> 
 
 
					<Option Value="101000009| 0 | 0" >ROUNDING OFF ACCOUNT   erp a/c</Option> 
 
 
					<Option Value="101000780| 0 | 0" >SALE ALUMINIUM  BORING   MEPL</Option> 
 
 
					<Option Value="101001040| 0 | 0" >SALE ALUMINIUM  SCRAP   MEPL</Option> 
 
 
					<Option Value="101000767| 0 | 0" >SALE ALUMN..MACH.CASTINGS -SALES RETURN   MEPL</Option> 
 
 
					<Option Value="101000786| 0 | 0" >SALE ALUMN.CASTING OMS 2%   DI</Option> 
 
 
					<Option Value="101000624| 0 | 0" >SALE C.I.BOARING   MEPL</Option> 
 
 
					<Option Value="101000948| 0 | 0" >SALE C.I.BOARING SALES RETURN   ME</Option> 
 
 
					<Option Value="101000785| 0 | 0" >SALE C.I.CASTINGS OMS 2%   DI</Option> 
 
 
					<Option Value="101000776| 0 | 0" >SALE C.I.MACH.CASTINGS -OMS 2%   MEPL</Option> 
 
 
					<Option Value="101000766| 0 | 0" >SALE C.I.MACH.CASTINGS -SALES RETURN   MEPL</Option> 
 
 
					<Option Value="101001207| 0 | 0" >SALE CASTINGS EXPORT  (U-III)   MSIPL</Option> 
 
 
					<Option Value="101000998| 0 | 0" >SALE CI/SGI CASTINGS    H-25   H25</Option> 
 
 
					<Option Value="101000999| 0 | 0" >SALE CI/SGI CASTINGS - SALES RETURN H-25   H25</Option> 
 
 
					<Option Value="101000996| 0 | 0" >SALE CI/SGI MACHINED CASTING  H-25   H25</Option> 
 
 
					<Option Value="101000997| 0 | 0" >SALE CI/SGI MACHINED CASTING - SALE RETURN  H25   H25</Option> 
 
 
					<Option Value="101000789| 0 | 0" >SALE- CORES & MOULD   </Option> 
 
 
					<Option Value="101000951| 0 | 0" >SALE MACH.CASTINGS EXPORT-SALE RETURN   ME</Option> 
 
 
					<Option Value="101000777| 0 | 0" >SALE MACH.CASTINGS -OMS2% SALES RETURN   MEPL</Option> 
 
 
					<Option Value="101001070| 0 | 0" >SALE MACHINING DEFECTIVES- REJECTION   MEPL</Option> 
 
 
					<Option Value="101000950| 0 | 0" >SALE MACHINING/LABOUR CHARGES SALE RETURN   ME</Option> 
 
 
					<Option Value="101000797| 0 | 0" >SALE MOULDING BOX   DI</Option> 
 
 
					<Option Value="101000625| 0 | 0" >SALE OF DEPB LICENCE   MEPL</Option> 
 
 
					<Option Value="101000980| 0 | 0" >SALE OF WIND POWER ELECTRICITY   MEPL</Option> 
 
 
					<Option Value="101000790| 0 | 0" >SALE OTHER   DI</Option> 
 
 
					<Option Value="101000833| 0 | 0" >SALE PIG IRON   DI</Option> 
 
 
					<Option Value="101000765| 0 | 0" >SALE PURCHASE (REJ.) ALUMN.CASTINGS -EXPORT   MEPL</Option> 
 
 
					<Option Value="101001075| 0 | 0" >SALE RATE REDUCTION ALUMN.CASTINGS   DI</Option> 
 
 
					<Option Value="101001074| 0 | 0" >SALE RATE REDUCTION C.I.CASTINGS   DI</Option> 
 
 
					<Option Value="101000931| 0 | 0" >SALE RATE REDUCTION -DOMESTIC   MEPL</Option> 
 
 
					<Option Value="101001209| 0 | 0" >SALE RATE REDUCTION -DOMESTIC H-25   MEPL II</Option> 
 
 
					<Option Value="101000933| 0 | 0" >SALE RATE REDUCTION -EXPORT   MEPL</Option> 
 
 
					<Option Value="101000932| 0 | 0" >SALE RATE REDUCTION OMS 2%   ME</Option> 
 
 
					<Option Value="101000944| 0 | 0" >SALE RAW SILICA SAND RECLAIMED   </Option> 
 
 
					<Option Value="101000949| 0 | 0" >SALE S.G.I.BOARING SALE RETURN   MEPL</Option> 
 
 
					<Option Value="101000629| 0 | 0" >SALE-AIR FREIGHT-(INCOME)   MEPL</Option> 
 
 
					<Option Value="101000630| 0 | 0" >SALE-MACHINED CASTINGS-DOMESTIC   MEPL</Option> 
 
 
					<Option Value="101000631| 0 | 0" >SALE-MACHINED CASTINGS-EXPORT   MEPL</Option> 
 
 
					<Option Value="101000773| 0 | 0" >SALE-MACHINING/LABOUR CHARGES   </Option> 
 
 
					<Option Value="101000632| 0 | 0" >SALE-PLANT &MACHINERY U3   MEPL</Option> 
 
 
					<Option Value="101000392| 0 | 0" >SALES - EXPORT   MFPL</Option> 
 
 
					<Option Value="101000633| 0 | 0" >SALES - TOOL COST   MEPL</Option> 
 
 
					<Option Value="101001218| 0 | 0" >SALES - TOOLS COST EXPORT   MEPL</Option> 
 
 
					<Option Value="101000447| 0 | 0" >SALES ALUMN.CASTINGS   DI </Option> 
 
 
					<Option Value="101001172| 0 | 0" >SALES ALUMN.CASTINGS - SALES RETURN   DI</Option> 
 
 
					<Option Value="101000774| 0 | 0" >SALES ALUMN.CASTINGS (DOMESTIC)   </Option> 
 
 
					<Option Value="101000775| 0 | 0" >SALES ALUMN.CASTINGS (EXPORT)   </Option> 
 
 
					<Option Value="101001082| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%)   ME</Option> 
 
 
					<Option Value="101001230| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) RATE REDUCTION   MEPL</Option> 
 
 
					<Option Value="101001083| 0 | 0" >SALES ALUMN.CASTINGS (OMS 2%) SALES RETURN   ME</Option> 
 
 
					<Option Value="101000448| 0 | 0" >SALES C.I.CASTINGS   COM</Option> 
 
 
					<Option Value="101001170| 0 | 0" >SALES C.I.CASTINGS - SALES RETURN   DI</Option> 
 
 
					<Option Value="101001171| 0 | 0" >SALES C.I.CASTINGS OMS 2% - SALES RETURN   DI</Option> 
 
 
					<Option Value="101000634| 0 | 0" >SALES C.I.SCRAP   MEPL</Option> 
 
 
					<Option Value="101001085| 0 | 0" >SALES CAS 4   </Option> 
 
 
					<Option Value="101000783| 0 | 0" >SALES CASTING -OMS   </Option> 
 
 
					<Option Value="101001010| 0 | 0" >SALES COMPUTER   </Option> 
 
 
					<Option Value="101000891| 0 | 0" >SALES CONSUMABLE MATERIAL   MSIPL</Option> 
 
 
					<Option Value="101000865| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY   MSIPL</Option> 
 
 
					<Option Value="101001169| 0 | 0" >SALES CREDIT NOTE ACCOUNTS ONLY - OMS   MSIPL</Option> 
 
 
					<Option Value="101000460| 0 | 0" >SALES OF DEPB LICENCE   MEPL/DI</Option> 
 
 
					<Option Value="101000451| 0 | 0" >SALES- PLANT & MACHINERY   DI </Option> 
 
 
					<Option Value="101000394| 0 | 0" >SALES R.C. SAND   MFPL</Option> 
 
 
					<Option Value="101000890| 0 | 0" >SALES RAW MATERIAL   MSIPL</Option> 
 
 
					<Option Value="101000319| 0 | 0" >SALES S. G. IRON CASTINGS   COM</Option> 
 
 
					<Option Value="101000864| 0 | 0" >SALES S. G. IRON CASTINGS- OMS   MSIPL</Option> 
 
 
					<Option Value="101000638| 0 | 0" >SALES S.G.I. SCRAP   MEPL</Option> 
 
 
					<Option Value="101000639| 0 | 0" >SALES S.G.I.BOARING   MEPL</Option> 
 
 
					<Option Value="101000395| 0 | 0" >SALES SHELL MOULD   MFPL</Option> 
 
 
					<Option Value="101001077| 0 | 0" >SALES TAX REFUND 2005-06   MEPL</Option> 
 
 
					<Option Value="101000456| 0 | 0" >SALES-C. I. BOARING   DI </Option> 
 
 
					<Option Value="101000641| 0 | 0" >SALES-MACHINING CHARGES   MEPL</Option> 
 
 
					<Option Value="101000642| 0 | 0" >SALES-TOOL/DRILL/TAPS (SCRAP)   MEPL</Option> 
 
 
					<Option Value="101001071| 0 | 0" >SALES-TOOLS & EQUIPMENTS   MFPL</Option> 
 
 
					<Option Value="101000947| 0 | 0" >SCHEDULE ADHELS PENALTY   ME</Option> 
 
 
					<Option Value="101000822| 0 | 0" >SCHEME OF DUTY DRAWBACK RECEIPT   MEPL</Option> 
 
 
					<Option Value="101000039| 0 | 0" >SCRAP SALES   COM</Option> 
 
 
					<Option Value="101000215| 0 | 0" >SECURITY EXPENSES   com</Option> 
 
 
					<Option Value="101000938| 0 | 0" >SEGREGATION & REWORK CHARGES   </Option> 
 
 
					<Option Value="101000648| 0 | 0" >SHORT/EXCESS IN EXCHANGE OF FORIEGN  CURRENCY   MEPL</Option> 
 
 
					<Option Value="101000321| 0 | 0" >SHOTBLASTING EXPS   msipl</Option> 
 
 
					<Option Value="101000322| 0 | 0" >SPECTRO TESTING  CHARGES   msipl</Option> 
 
 
					<Option Value="101001135| 0 | 0" >SPILLAGE COLLECTION CHARGES   MSIPL</Option> 
 
 
					<Option Value="101000048| 0 | 0" >SUNDRY CRS. WRITTEN OFF   COM</Option> 
 
 
					<Option Value="101001100| 0 | 0" >SUNDRY DEBTORS SETTLEMENT ACCOUNT   MEPL </Option> 
 
 
					<Option Value="101001101| 0 | 0" >SUNDRY DEBTORS SETTLMENT A/C   MEPL</Option> 
 
 
					<Option Value="101000403| 0 | 0" >TIN PURCHASE A/C   MFPL</Option> 
 
 
					<Option Value="101000006|101140066|0" >TOOLS & EQUIPMENT   MFPL</Option> 
 
 
					<Option Value="101000006|101140045|0" >TOOLS & EQUIPMENT U-1   MEPL</Option> 
 
 
					<Option Value="101000006|101140046|0" >TOOLS & EQUIPMENT U-2   MEPL</Option> 
 
 
					<Option Value="101000989| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-DOMESTIC   ME</Option> 
 
 
					<Option Value="101000990| 0 | 0" >TOOLS GRINDING/RESHARPNING CHARGES-EXPORT   ME</Option> 
 
 
					<Option Value="101000006|101140080|0" >TRACTOR TRAILOR RED (TROLLEY)   MEPL</Option> 
 
 
					<Option Value="101000099| 0 | 0" >TRANSPORT  CHARGES (INWARD)   com</Option> 
 
 
					<Option Value="101000242| 0 | 0" >TRANSPORT CHARGES (OUTWARD)   com</Option> 
 
 
					<Option Value="101000461| 0 | 0" >TRANSPORT CHARGES (SALES)   DI </Option> 
 
 
					<Option Value="101000243| 0 | 0" >TRANSPORT CHARGES LOCAL   com</Option> 
 
 
					<Option Value="101000006|101140047|0" >TYPE WRITER   MEPL</Option> 
 
 
					<Option Value="101000981| 0 | 0" >VALUE OF UNITS GENERATED-WTG   MEPL</Option> 
 
 
					<Option Value="101001012| 0 | 0" >VANEDIUM PURCHASE   </Option> 
 
 
					<Option Value="101001131| 0 | 0" >VAT REFUND 2010-11   DI</Option> 
 
 
					<Option Value="101000006|101140091|0" >VEHICLE - FORD ECO SPORTS   DI</Option> 
 
 
					<Option Value="101000006|101140097|0" >VEHICLE - INNOVA CRYSTA MH-11-BV-7022   DI</Option> 
 
 
					<Option Value="101000667| 0 | 0" >VENDOR MACHINE SHOP EXPS.   MEPL</Option> 
 
 
					<Option Value="101000251| 0 | 0" >WATER CHARGES   com</Option> 
 
 
					<Option Value="101001221| 0 | 0" >WATER CHARGES - POWDER COATING PLANT   MFPL</Option> 
 
 
					<Option Value="101000875| 0 | 0" >WATER CHARGES (H-25)   MEPL</Option> 
 
 
					<Option Value="101000253| 0 | 0" >WEIGHMENT CHARGES   com</Option> 
 
 
					<Option Value="101000929| 0 | 0" >WIND ENERGY CHARGES RECEIVED FROM MSEDCL   MEPL</Option> 
 
 
					<Option Value="101000006|101140083|0" >WINDMILL   MEPL</Option> 
 
 
					<Option Value="101000006|101140089|0" >WIP LINER PROJECT   </Option> 
 
 
					<Option Value="101000006|101140096|0" >WIP PLANT & MACHINERY (POWDER COATING PLANT)   MFPL</Option> 
 
 
					<Option Value="101000006|101140075|0" >WIP PLANT AND MACHINARY   MSIPL</Option> 
 
 
					<Option Value="101000006|101140065|0" >WIP VINAR & PAINT SHOP PROJECT   MFPL</Option> 
 
 
					<Option Value="101000006|101140070|0" >WORKS EQUIPMENTS   DI</Option> 
 
 
					<Option Value="101001242| 0 | 0" >Z CLOSED FACTORY BUILDING â POWDER COATING PLANT   U-III</Option> 
					</select>				</Td>
			</tr>
			
			<tr>
			  <td>
					<label class="caption" >Drawing Number</label>				</td>
				
				<td>
					<Input Type="Text" Id="txtDrgNo" name="txtDrgNo" TabIndex=14 Size="20" MaxLength="20" >				</td>
  </tr>
			<tr>
			  <td><label class="caption" >Reference Party Code</label></td>
			  <td><input type="Text" id="txtRefPartCode" name="txtRefPartCode" tabindex=15 size="15" maxlength="20" ></td>
  </tr>
			<tr>
			  <td>
					<label class="caption" >Drawing Location</label>				</td>
				
				<td>
					<Input Type="Text" Id="txtDrgLocation" name="txtDrgLocation" TabIndex=16 Size="70" MaxLength="70" >				</td>
			</tr>
			<tr>
			  <td>
					<label class="caption" >Finished Weight</label>				</td>
				
				<td>
					<Input Type="Text" Id="txtFinishWt" name="txtFinishWt" TabIndex=17  value="0" Size="10" MaxLength="10" OnBlur="chkValidNoValue(this,3,'Finished Weight')" style="Text-align:Right" >				</td>
			</tr>
			<tr>
			  <td>
					<label class="caption" >Sales classification</label>				</td>
 
				
				<td>
					<Select id="drpSaleAs" name="drpSaleAs"  Tabindex=19 >	
					
					<Option Value="101001" >SALES</Option> 
					</select>				</Td> 
			</tr>
			<tr>
			  <td>
					<label class="caption" >HS Number</label>				</td>				
				<td>
					<Select id="drpChapterNo" name="drpChapterNo" style="width: 500px;">
					
					<Option Value="1010001" >0000 00 00  NO EXCISE</Option> 
					
					<Option Value="1010428" >1325 99 10  PROTECTION PLATE</Option> 
					
					<Option Value="1010147" >2503 00 10  Refind Sulphur</Option> 
					
					<Option Value="1010385" >25051019  Silica sand - Other</Option> 
					
					<Option Value="1010426" >2508 10 98  BENTONITE POWDER AND OTHER</Option> 
					
					<Option Value="1010327" >2523 29 30  CEMENT</Option> 
					
					<Option Value="1010264" >2530 10 20  PERLITE ORE</Option> 
					
					<Option Value="1010284" >2530 10 20  COMPAX-RESIN</Option> 
					
					<Option Value="1010391" >2618  Wastage Sand</Option> 
					
					<Option Value="1010392" >2618  Tumbling Sand</Option> 
					
					<Option Value="1010390" >2619  Wastage Slag</Option> 
					
					<Option Value="1010024" >2620 40 10   --- Aluminium dross</Option> 
					
					<Option Value="1010401" >2621  Perlit Ore</Option> 
					
					<Option Value="1010136" >2704 00 30  Hard Coke of Coal</Option> 
					
					<Option Value="1010069" >2710 19 90  CIRCULATING OIL</Option> 
					
					<Option Value="1010028" >2711 19 00   - Liquified: -- Other</Option> 
					
					<Option Value="1010308" >2713 11 00  Graphitizied Petroleum Coke</Option> 
					
					<Option Value="1010033" >2713 12 00   - Petroleum coke: -- Calcined</Option> 
					
					<Option Value="1010249" >2803 00 90  GRAPHITE</Option> 
					
					<Option Value="1010062" >2804 21 00  ARGOAN</Option> 
					
					<Option Value="1010157" >2811 21 90  Other</Option> 
					
					<Option Value="1010036" >2819 19 00   - Of sodium : -- Other</Option> 
					
					<Option Value="1010214" >2836 20 20  SODA ASH</Option> 
					
					<Option Value="1010091" >2836 20 90  SODA ASH</Option> 
					
					<Option Value="1010369" >2836 20 90  2836 20 90</Option> 
					
					<Option Value="1010451" >2839 19 00  - Of sodium silicate : -- Other</Option> 
					
					<Option Value="1010241" >2849 20 90  SILICO CARBIDE</Option> 
					
					<Option Value="1010030" >3208 10 30   --- Varnishes (Red - Oxide)</Option> 
					
					<Option Value="1010324" >3208 10 90  PAINT</Option> 
					
					<Option Value="1010311" >3208 20 90  PAINT</Option> 
					
					<Option Value="1010082" >3209 10 10  EMULASION PAINT</Option> 
					
					<Option Value="1010025" >3212 90 30   --- Aluminium paste</Option> 
					
					<Option Value="1010343" >3402 90 92  Neutracare</Option> 
					
					<Option Value="1010149" >34029092  TECHLINE 995 JCN Oil</Option> 
					
					<Option Value="1010263" >3403 19 00  CONTAINING PETROLIUM OILS</Option> 
					
					<Option Value="1010138" >34039900  Supercut 5050 EP Oil</Option> 
					
					<Option Value="1010046" >3505 10 10  Dextrins & Other modified Starches</Option> 
					
					<Option Value="1010422" >3506   SOLUTION PVC</Option> 
					
					<Option Value="1010068" >3801 10 00  GRAPHAITE POWDER</Option> 
					
					<Option Value="1010297" >3801 90 00  GRAPHITE FINE</Option> 
					
					<Option Value="1010277" >3809 91 90  SUPERCIDE OIL</Option> 
					
					<Option Value="1010341" >3811 90 00  other</Option> 
					
					<Option Value="1010029" >3814 00 10   --- Organic composite solvents and thinners,</Option> 
					
					<Option Value="1010166" >3815 90 00  CATALYST</Option> 
					
					<Option Value="1010377" >3815 90 00  OTHER</Option> 
					
					<Option Value="1010071" >3816 00 00  WHYTHEAT</Option> 
					
					<Option Value="1010022" >3824 10 00   - Prepared binders for foundry moulds or cores</Option> 
					
					<Option Value="1010199" >3824 10 10  INOCULANT</Option> 
					
					<Option Value="1010034" >3824 40 90   --- Other</Option> 
					
					<Option Value="1010393" >3824 50 10  Parting Agent</Option> 
					
					<Option Value="1010394" >3824 50 10  Silicon Compound</Option> 
					
					<Option Value="1010174" >3824 90 12  MECATEC EXPRESS</Option> 
					
					<Option Value="1010404" >3824 90 22  PH + CHEMICAL</Option> 
					
					<Option Value="1010354" >3824 90 90  3824 90 90</Option> 
					
					<Option Value="1010175" >3849 20 10  SILICON CARBIDE</Option> 
					
					<Option Value="1010331" >3907 30 90  MAHACOAT HR BLACK 250C</Option> 
					
					<Option Value="1010395" >3915  Plastic Scrap</Option> 
					
					<Option Value="1010425" >3917  SOCKET PVC</Option> 
					
					<Option Value="1010421" >3917 31 00  TUBE PU BLUE OD 8</Option> 
					
					<Option Value="1010125" >3919 10 00  BOPP TAPE.</Option> 
					
					<Option Value="1010224" >3919 90 20  BOPE TAPE</Option> 
					
					<Option Value="1010124" >39191000  BOPP TAPE</Option> 
					
					<Option Value="1010074" >3920 10 12  POLYTHENE SHEET /FILM</Option> 
					
					<Option Value="1010269" >3920 10 99  OTHER</Option> 
					
					<Option Value="1010435" >3921 00 00  PU SEALS</Option> 
					
					<Option Value="1010047" >3923 10 90  Plastic Crates,Bins & Pallets</Option> 
					
					<Option Value="1010073" >3923 21 00  POLYTHENE BAGS / COVERS</Option> 
					
					<Option Value="1010070" >3923 90 90  THERMOCOLE PACKING BUFFER</Option> 
					
					<Option Value="1010307" >3923 90 90  THERMOCOLE PACKING BUFFER</Option> 
					
					<Option Value="1010292" >3923 90 90  PACKAGING BUFFER</Option> 
					
					<Option Value="1010293" >3923 90 90  PACKAGING BUFFER</Option> 
					
					<Option Value="1010203" >39231090  Plastic scrap</Option> 
					
					<Option Value="1010423" >3924  MUG JAR</Option> 
					
					<Option Value="1010089" >3926 90 29  PLASTIC CARET</Option> 
					
					<Option Value="1010332" >4006 90 90  TOP DEGREE SEAL DIA</Option> 
					
					<Option Value="1010424" >4008  SPONGE</Option> 
					
					<Option Value="1010411" >4009 42 00  HYD HOSE PIPE 1/4 INCH R2 X 1/4 INCH BSP X ST X ST X 3 MTR</Option> 
					
					<Option Value="1010304" >4010 31 90  V BELT</Option> 
					
					<Option Value="1010448" >4011   REAR TRACTOR TYRE TUBE</Option> 
					
					<Option Value="1010440" >4016 93 30  OIL SEAL</Option> 
					
					<Option Value="1010329" >4016 93 30  SEAL</Option> 
					
					<Option Value="1010276" >4016 93 30  RUBBER & PLASTICS RINGS</Option> 
					
					<Option Value="1010278" >4016 93 90  OTHER</Option> 
					
					<Option Value="1010072" >4016 99 90  INTEGRAL DAMPER</Option> 
					
					<Option Value="1010441" >42032910  GLOVES FOR USE IN INDUSTRY</Option> 
					
					<Option Value="1010442" >4403 49 10  Teak wood</Option> 
					
					<Option Value="1010444" >4407 91 00  OAK WOOD</Option> 
					
					<Option Value="1010235" >44151000  44151000 WOODEN CASE</Option> 
					
					<Option Value="1010429" >46150  46150</Option> 
					
					<Option Value="1010430" >46151  46151</Option> 
					
					<Option Value="1010443" >4704 00 00  MICA LAMINATE</Option> 
					
					<Option Value="1010396" >4707  Scrap Corrugated Box</Option> 
					
					<Option Value="1010460" >4802 56 90  UNCOATED PAPER AND PAPERBOARD, OF A KIND USED FOR WRITING, PRINTING OR OTHER GRAPHIC PURPOSES, AND N</Option> 
					
					<Option Value="1010450" >4818 20 00  Handkerchiefs, cleansing or facial tissues and towels</Option> 
					
					<Option Value="1010027" >4819 10 10   --- Boxes</Option> 
					
					<Option Value="1010456" >4820 10 10  REGISTERS, ACCOUNT BOOKS, NOTE BOOKS, ORDER BOOKS, RECEIPT BOOKS, LETTER PADS, MEMORANDUM PADS, DIAR</Option> 
					
					<Option Value="1010384" >6116 10 00  -COATED HAND GLOVES COATED</Option> 
					
					<Option Value="1010379" >61161000  GLOVES - Impregnated, coated or covered with plastics or Rubber</Option> 
					
					<Option Value="1010459" >6310 10 20  USED OR NEW RAGS, SCRAP TWINE, CORDAGE, ROPE AND CABLES AND WORN OUT ARTICLES OF TWINE, CORDAGE, ROP</Option> 
					
					<Option Value="1010413" >6504  Hats and other headgear,plaited or made by assembling strips of any material</Option> 
					
					<Option Value="1010380" >6506 10 10  HELMET</Option> 
					
					<Option Value="1010167" >6804 22 10  D C WHEEL</Option> 
					
					<Option Value="1010285" >6804 22 10  GRINDING WHEEL</Option> 
					
					<Option Value="1010178" >68042210  68042210</Option> 
					
					<Option Value="1010236" >6805 10 10  Abrasive cloth</Option> 
					
					<Option Value="1010322" >6806 10 00  CERAMIC FIBER BLANKET</Option> 
					
					<Option Value="1010032" >6807 90 90   --- Other ( Resin Coated sand)</Option> 
					
					<Option Value="1010414" >6811 21 00  BAND BOX</Option> 
					
					<Option Value="1010222" >6812 92 11  ASBESTOS SHEET</Option> 
					
					<Option Value="1010344" >6814 90 90  other</Option> 
					
					<Option Value="1010454" >6815 99 10  OTHER ARTICLES: OTHER: BRICKS AND TILES OF FLY ASH</Option> 
					
					<Option Value="1010189" >6902 20 90  REMMING MASS</Option> 
					
					<Option Value="1010035" >6903 20 10   --- Silicon carbide crucibles</Option> 
					
					<Option Value="1010306" >6903 90 30  Ceramic fibres</Option> 
					
					<Option Value="1010328" >6903 90 30  CERAMIC BLANKET</Option> 
					
					<Option Value="1010372" >6903 90 40  6903 90 40</Option> 
					
					<Option Value="1010288" >6903 90 90  CERAMIC FOME FILTER</Option> 
					
					<Option Value="1010173" >6909 90 00  CERAMIC FILTER</Option> 
					
					<Option Value="1010083" >6909 90 00  CERAMIC FOAM FILTER</Option> 
					
					<Option Value="1010172" >6909 90 99  CERAMIC FILTER</Option> 
					
					<Option Value="1010213" >6914 90 00  INSULATING SLEEVE</Option> 
					
					<Option Value="1010031" >7201 10 00   - Non-alloy pig iron containing by weight 0.5% or less of phosphorus</Option> 
					
					<Option Value="1010009" >7202 11 00  - Ferro-manganese : -- Containing by weight more than 2% of carbon</Option> 
					
					<Option Value="1010010" >7202 19 00   - Ferro-manganese : -- Other</Option> 
					
					<Option Value="1010008" >7202 21 00  FERRO SILICON Containing by weight more than 55% of silicon</Option> 
					
					<Option Value="1010011" >7202 29 00   - Ferro-silicon: -- Other</Option> 
					
					<Option Value="1010012" >7202 30 00   - Ferro-silico-manganese</Option> 
					
					<Option Value="1010295" >7202 36 90  M.S.WASTE & SCRAP</Option> 
					
					<Option Value="1010013" >7202 41 00   - Ferro-chromium : -- Containing by weight more than 4% of carbon</Option> 
					
					<Option Value="1010014" >7202 49 00   - Ferro-chromium : -- Other</Option> 
					
					<Option Value="1010015" >7202 50 00   - Ferro-silico-chromium</Option> 
					
					<Option Value="1010042" >7202 70 00   - Ferro-molybdenum</Option> 
					
					<Option Value="1010043" >7202 92 00   - Other : -- Ferro-vanadium</Option> 
					
					<Option Value="1010066" >7202 99 11  FERRO PHOSPHORUS</Option> 
					
					<Option Value="1010346" >7202 99 22  OTHER</Option> 
					
					<Option Value="1010342" >7202 99 22  Ferro sil Magnesium</Option> 
					
					<Option Value="1010347" >7202 99 32  Chrome</Option> 
					
					<Option Value="1010400" >7204  CRCA Scrap</Option> 
					
					<Option Value="1010021" >7204 00 12   --- Of copper : ---- Copper scrap,</Option> 
					
					<Option Value="1010016" >7204 10 00   - Waste and scrap of cast iron</Option> 
					
					<Option Value="1010007" >7204 21 00  Waste & Scrap of Alloy Steel :-- of Stainless Steel</Option> 
					
					<Option Value="1010076" >7204 21 90  MS SCRAP</Option> 
					
					<Option Value="1010045" >7204 29 90   --- Other (Scrap)</Option> 
					
					<Option Value="1010017" >7204 30 00   - Waste and scrap of tinned iron or steel</Option> 
					
					<Option Value="1010018" >7204 41 00   - Other waste and scrap : -- Turnings, Milling waste, fillings, trimming</Option> 
					
					<Option Value="1010019" >7204 49 00   - Other waste and scrap : -- Other</Option> 
					
					<Option Value="1010020" >7204 50 00   - Remelting scrap ingots</Option> 
					
					<Option Value="1010312" >7204 90 00  M.S.SCRAP</Option> 
					
					<Option Value="1010056" >7204 90 10  SCRAP SALE</Option> 
					
					<Option Value="1010037" >7205 10 11   --- Of iron : ---- Shot and angular grit</Option> 
					
					<Option Value="1010169" >7205 10 21  STEEL SHOTS</Option> 
					
					<Option Value="1010064" >7205 10 90  STEEL SHOTS</Option> 
					
					<Option Value="1010272" >7206 10 10  M.S. SCRAP</Option> 
					
					<Option Value="1010374" >7207 19 20  Mild steel billets</Option> 
					
					<Option Value="1010245" >7208 27 40  HR COIL</Option> 
					
					<Option Value="1010296" >7208 36 90  M.S.WASTE & SCRAP</Option> 
					
					<Option Value="1010100" >7208 37 40  CHEQURED COIL</Option> 
					
					<Option Value="1010254" >7208 38 40  M S SCRAP</Option> 
					
					<Option Value="1010253" >7208 39 40  M S SCRAP</Option> 
					
					<Option Value="1010262" >7208 52 10  H.R.PLATE</Option> 
					
					<Option Value="1010360" >7209 15 90  7209 15 90</Option> 
					
					<Option Value="1010366" >7209 16 10  7209 16 10</Option> 
					
					<Option Value="1010044" >7209 16 30   --- Strip (Endcut Scrap)</Option> 
					
					<Option Value="1010349" >7209 17 30  7209 17 30</Option> 
					
					<Option Value="1010093" >7209 18 20  CR MIXED CUT PIECES</Option> 
					
					<Option Value="1010363" >7209 18 90  7209 18 90</Option> 
					
					<Option Value="1010081" >7209 90 00  CRC SCARP</Option> 
					
					<Option Value="1010164" >7209 90 00  CR side slits & CR coil end</Option> 
					
					<Option Value="1010065" >7209 99 90  ELMAG 5800</Option> 
					
					<Option Value="1010096" >7210 30 90  M.S.SHEET SCRAP</Option> 
					
					<Option Value="1010103" >7210 49 00  GI COIL</Option> 
					
					<Option Value="1010313" >7210 49 00  G. P. SI COIL</Option> 
					
					<Option Value="1010315" >7210 61 00  M.S.AZ COILS SECOND</Option> 
					
					<Option Value="1010338" >7210 70 00  SHEET SCRAP</Option> 
					
					<Option Value="1010351" >7211 19 40  72111940</Option> 
					
					<Option Value="1010084" >7211 19 90  PLATE CUTTING</Option> 
					
					<Option Value="1010335" >7211 29 40  HR SLIT PO CTL</Option> 
					
					<Option Value="1010445" >7212  FORMER</Option> 
					
					<Option Value="1010209" >7214 10 90  NAS ROUND BAR</Option> 
					
					<Option Value="1010326" >7214 20 90  TMT BARS</Option> 
					
					<Option Value="1010434" >7215 90 20  HCP DIA 45 X 1000 MM L</Option> 
					
					<Option Value="1010290" >7216 31 00  M.S. BEAM</Option> 
					
					<Option Value="1010151" >7216 50 00  M.S.SCRAP</Option> 
					
					<Option Value="1010075" >7216 50 00  MS ANGLES</Option> 
					
					<Option Value="1010246" >7216 69 00  SCRAP OF IRON & STEEL</Option> 
					
					<Option Value="1010340" >72165000  M.S ISBM BEAM</Option> 
					
					<Option Value="1010261" >7219 22 19  M.S PLATE CUTTING (CRC WASTED)</Option> 
					
					<Option Value="1010250" >7219 90 90  M.S PLATE CUTTING (CRC WASTED)</Option> 
					
					<Option Value="1010325" >7220 11 90  M.S. PLATE CUTTING</Option> 
					
					<Option Value="1010194" >7220 20 90  CRC WASTE</Option> 
					
					<Option Value="1010223" >7220 90 90  M.S.PLATE CUTTING (CRC WASTAGE)</Option> 
					
					<Option Value="1010248" >7222 40 20  M.S PLATE (CRC WASTED)</Option> 
					
					<Option Value="1010255" >7225 30 90  HR COIL CUT TO LENGTH</Option> 
					
					<Option Value="1010266" >7228 60 92  Spring Steel</Option> 
					
					<Option Value="1010427" >7301  7301</Option> 
					
					<Option Value="1010410" >7304  Display Board</Option> 
					
					<Option Value="1010200" >7306 10 29  CRC WASTED</Option> 
					
					<Option Value="1010359" >7306 90 19  7306 90 19</Option> 
					
					<Option Value="1010330" >7306 90 90  M.S. SCRAP /TUBE</Option> 
					
					<Option Value="1010420" >7307 19 00  NIPPLE HEX</Option> 
					
					<Option Value="1010353" >7307 19 90  7307 19 90</Option> 
					
					<Option Value="1010352" >7307 21 00  7307 21 00</Option> 
					
					<Option Value="1010095" >7308 90 10  M.S.PLATES/SCRAP</Option> 
					
					<Option Value="1010215" >7308 90 90  Other</Option> 
					
					<Option Value="1010398" >7309 00 20  Empty Barral</Option> 
					
					<Option Value="1010399" >7309 00 20  Empty Tin of thinner and Paint</Option> 
					
					<Option Value="1010160" >7310 10 10  Spares of Container</Option> 
					
					<Option Value="1010145" >73110090  Air Receiver</Option> 
					
					<Option Value="1010314" >7314 19 10  Wire gauze</Option> 
					
					<Option Value="1010431" >7315   M.S GLVANIZED CABLE DEAG CHAIN</Option> 
					
					<Option Value="1010432" >7315 90 20  HCP DIA 45 X 1000 MM L</Option> 
					
					<Option Value="1010133" >7318 11 90  STUD</Option> 
					
					<Option Value="1010226" >7318 15 00  BANJO BOLT</Option> 
					
					<Option Value="1010449" >7318 19 00  Drilling screw</Option> 
					
					<Option Value="1010370" >7320 90 90  7320 90 90</Option> 
					
					<Option Value="1010373" >7320 90 90  7320 90 90</Option> 
					
					<Option Value="1010039" >7322 90 10   --- Air heaters and hot air distributors</Option> 
					
					<Option Value="1010355" >73239200  Cast Iron, Enamelled</Option> 
					
					<Option Value="1010002" >7325 99 10  Other Cast Articals of Iron & Steel</Option> 
					
					<Option Value="1010054" >7325 99 10  7325 99 10</Option> 
					
					<Option Value="1010247" >7325 99 20  BMD NARROW BLADE</Option> 
					
					<Option Value="1010048" >7325 99 99  RAW SG IRON CASTING</Option> 
					
					<Option Value="1010388" >73251000  OTHER CAST ARTICLES OF IRON OR STEEL  OF NON-MALLEABLE CAST IRON</Option> 
					
					<Option Value="1010455" >7326 9099   OTHER ARTICLES OF IRON OR STEEL - OTHER : OTHER : OTHER</Option> 
					
					<Option Value="1010171" >7408 19 90  BARE COPPER WIRE</Option> 
					
					<Option Value="1010260" >7409 11 00  COPPER STRIPS</Option> 
					
					<Option Value="1010152" >74091900   COPPER STRIPS</Option> 
					
					<Option Value="1010461" >7412 2019  COPPER TUBE OR PIPE FITTINGS (FOR EXAMPLE, COUPLINGS, ELBOWS, SLEEVES) - OF COPPER ALLOYS : BRASS :</Option> 
					
					<Option Value="1010165" >7502 10 00  NICKEL CATHODES</Option> 
					
					<Option Value="1010026" >7601 20 10   - Aluminium alloys : Ingots</Option> 
					
					<Option Value="1010289" >76020090   Aluminium Boaring</Option> 
					
					<Option Value="1010102" >7616 99 00  ALLUMINUM ELBOW</Option> 
					
					<Option Value="1010003" >7616 99 90  Other - Aluminium Casting</Option> 
					
					<Option Value="1010077" >8001 10 90  TIN METAL</Option> 
					
					<Option Value="1010383" >81019990  All Othr Artcls of Tngstn & Its base Alloy</Option> 
					
					<Option Value="1010230" >8200 10 90  BORING BAR</Option> 
					
					<Option Value="1010158" >8202 20 00  Band Saw Blade</Option> 
					
					<Option Value="1010196" >82021010  Hexa Blade  82021010</Option> 
					
					<Option Value="1010453" >8203 10 00  FILES,RASPS & SMRL TOOLS</Option> 
					
					<Option Value="1010233" >82051000  82051000 Consumable Tools</Option> 
					
					<Option Value="1010237" >8207 13 00  Tooling Aceessaries</Option> 
					
					<Option Value="1010146" >8207 20 00  DIES & CORE BOX</Option> 
					
					<Option Value="1010273" >8207 30 00  TOOLS</Option> 
					
					<Option Value="1010201" >8207 40 90  TOOLS</Option> 
					
					<Option Value="1010381" >8207 40 90  Interchangeable tools for hand tools, whether or not power- operated, or for machine tools</Option> 
					
					<Option Value="1010057" >8207 50 00  8207 50 00 TOOLS</Option> 
					
					<Option Value="1010275" >8207 50 50  HSS TOOLS</Option> 
					
					<Option Value="1010281" >8207 60 10  STD EXPANDABLE REMAX TS</Option> 
					
					<Option Value="1010181" >8207 80 00  8207 80 00 TOOLS</Option> 
					
					<Option Value="1010198" >8207 90 10  TOOLS</Option> 
					
					<Option Value="1010185" >8207 90 90  PATTERN</Option> 
					
					<Option Value="1010058" >8207 90 90  PATTERN & DIES</Option> 
					
					<Option Value="1010139" >82075000  SC Self Centering Drill</Option> 
					
					<Option Value="1010183" >82075000  8207 50 00 TOOLS</Option> 
					
					<Option Value="1010234" >82076010  82076010 TOOLS</Option> 
					
					<Option Value="1010180" >82077010  TOOLS 8207 70 10</Option> 
					
					<Option Value="1010389" >82079030  Interchangeable Tools For Hand Tools, Whether Or Not Power-operated, Or For Machine-tools</Option> 
					
					<Option Value="1010382" >82089010  Knives and cutting blades, for machines or for mechanical appliances</Option> 
					
					<Option Value="1010059" >8209 00 10  8209 00 10 TOOLS</Option> 
					
					<Option Value="1010123" >8209 00 90  8209 00 90 TOOLS</Option> 
					
					<Option Value="1010211" >824269990  EOT CRANE PARTS</Option> 
					
					<Option Value="1010436" >8301  PDLCKS LOCKS(KEY ETC) OF BASE MTL;CLSPS & FRMS WTH CLSPS,INCRPRTNG LCKS,OF BASE MTL;KEYS FOR</Option> 
					
					<Option Value="1010190" >83025000  Domestic fixtures</Option> 
					
					<Option Value="1010090" >8311 10 00  XUPUR 2240</Option> 
					
					<Option Value="1010163" >84 74 9000  PARTS OF MACHINE</Option> 
					
					<Option Value="1010055" >8409 91 99  Part for Enginer parts</Option> 
					
					<Option Value="1010239" >8409 91 99  PARTS OF ENGINE</Option> 
					
					<Option Value="1010004" >8409 99 41  Parts Suitable for use Solely or Principally with the Engine - Disel</Option> 
					
					<Option Value="1010051" >8409 99 90  Part suitable for use solely or principally with the engine petrol</Option> 
					
					<Option Value="1010049" >84099191  Part suitable for use solely or principally with the engine petrol</Option> 
					
					<Option Value="1010356" >8412 10 00  84121000</Option> 
					
					<Option Value="1010376" >84122990  OTHER</Option> 
					
					<Option Value="1010406" >8413 50 10  DOSING PUMPS</Option> 
					
					<Option Value="1010197" >8413 91 90  M.S.SCRAP</Option> 
					
					<Option Value="1010176" >84137010  Primarily designed to handle water</Option> 
					
					<Option Value="1010321" >8414 40 30  Screw air compressors</Option> 
					
					<Option Value="1010184" >8414 40 90  Other</Option> 
					
					<Option Value="1010350" >8414 59 10  8414 59 10</Option> 
					
					<Option Value="1010128" >8414 59 30  DUST COLLECTOR</Option> 
					
					<Option Value="1010186" >8414 90 11  PART OF COMPRESSORS</Option> 
					
					<Option Value="1010240" >8414 90 19  Air or Vacuum Pumps and Compressors</Option> 
					
					<Option Value="1010144" >84148090  Electricpower Screw Compressor</Option> 
					
					<Option Value="1010457" >8416 10 00  FURNACE BURNERS FOR LIQUID FUEL, FOR PULVERISED SOLID FUEL OR FOR GAS; MECHANICAL STOKERS, INCLUDING</Option> 
					
					<Option Value="1010156" >8417 90 00  PARTS FOR THERMAL SAND RECLAMATION SYATEM</Option> 
					
					<Option Value="1010270" >8419 50 20  Assly of PHE</Option> 
					
					<Option Value="1010251" >8421 19 99  OTHER</Option> 
					
					<Option Value="1010323" >8423 81 90  ELE.WEIGH SCALE</Option> 
					
					<Option Value="1010291" >8423 82 90  PARTS OF ELE WEIGH SCALE SPP</Option> 
					
					<Option Value="1010242" >8424 89 10  Spraying Equipment,Coponents, & Accessories</Option> 
					
					<Option Value="1010208" >8424 90 00  BARE WHEELPLATE R</Option> 
					
					<Option Value="1010299" >8425 11 10  WIRE ROPE</Option> 
					
					<Option Value="1010336" >8425 11 10  CHAIN ELECTRIC HOIST</Option> 
					
					<Option Value="1010137" >8426 11 00  Overhead travelling cranes on fixed support</Option> 
					
					<Option Value="1010148" >8426 99 90  Other</Option> 
					
					<Option Value="1010348" >8427 90 00  8427 90 00</Option> 
					
					<Option Value="1010218" >8428 20 11  Belt Conveyors</Option> 
					
					<Option Value="1010094" >8428 20 19  PNEUMATIC CONVEYING SYSTEM</Option> 
					
					<Option Value="1010221" >8428 90 00  Others</Option> 
					
					<Option Value="1010162" >8428 90 90  Other Parts  suitable for use with particular machine</Option> 
					
					<Option Value="1010154" >8431 39 10  PARTS OF ELECTRIC</Option> 
					
					<Option Value="1010300" >8431 39 90  Spare & Components of Conveyor Machinery</Option> 
					
					<Option Value="1010378" >84314930  OF Other excavating Levelling,Tamping or excavating Machinery for earth,minieral or ores.</Option> 
					
					<Option Value="1010079" >8432 10 10  DISC PLUGHS</Option> 
					
					<Option Value="1010310" >8454 90 00  MACHINERY SPARE</Option> 
					
					<Option Value="1010078" >8457 10 20  MACHINARY</Option> 
					
					<Option Value="1010099" >8458 11 00  CNC LATHE</Option> 
					
					<Option Value="1010098" >84589990   Turning Machine</Option> 
					
					<Option Value="1010120" >8459 29 90  Drilling Machine</Option> 
					
					<Option Value="1010280" >8459 2950   AIR GAP 4 SENSOR</Option> 
					
					<Option Value="1010193" >8459 4020   Boaring Machine</Option> 
					
					<Option Value="1010238" >8459 59 90  Pneumatic Tool</Option> 
					
					<Option Value="1010301" >8459 70 20  TAPPING MACHINE</Option> 
					
					<Option Value="1010204" >845961  SPM MACHINE</Option> 
					
					<Option Value="1010362" >8460 90 90  8460 90 90</Option> 
					
					<Option Value="1010153" >8461 50 11  Sawing machines</Option> 
					
					<Option Value="1010130" >8466 10 10  TOOL HOLDER</Option> 
					
					<Option Value="1010061" >8466 10 10  TOOLS</Option> 
					
					<Option Value="1010231" >8466 10 20  BORING BAR</Option> 
					
					<Option Value="1010202" >8466 10 20  TOOLS</Option> 
					
					<Option Value="1010129" >8466 30 10  CHUCKS & CHUCK SPARES</Option> 
					
					<Option Value="1010086" >8466 30 20  FIXTURE HYDROLIC BLOCK</Option> 
					
					<Option Value="1010415" >8466 30 21  RECEIVING GAUGE FOR ENG.MTG.ARM 278922123712</Option> 
					
					<Option Value="1010416" >8466 30 22  RECEIVING GAUGE FOR ENG.MTG.ARM 278922123709</Option> 
					
					<Option Value="1010417" >8466 30 23  RECEIVING GAUGE FOR ENG.MTG.ARM 278922123710</Option> 
					
					<Option Value="1010418" >8466 30 24  RECEIVING GAUGE FOR ENG.MTG.ARM 278922123711</Option> 
					
					<Option Value="1010361" >8466 30 90  8466 30 90</Option> 
					
					<Option Value="1010302" >8466 93 10  PARTS AND ACCESSORIES CYLINDER</Option> 
					
					<Option Value="1010159" >8466 93 90  Other</Option> 
					
					<Option Value="1010179" >84662000  84662000</Option> 
					
					<Option Value="1010256" >8467 11 10  WASHING MACHINE</Option> 
					
					<Option Value="1010170" >8467 19 00  BENCH RAMMER</Option> 
					
					<Option Value="1010220" >8467 89 20  Vibrators</Option> 
					
					<Option Value="1010320" >8467 99 00  SEAL KIT</Option> 
					
					<Option Value="1010257" >8471 60 30  HONING MACHINE</Option> 
					
					<Option Value="1010412" >8474   UNION EQUAL LIGHT DUTY 12 OD</Option> 
					
					<Option Value="1010150" >8474 80 30  FOUNDRY EQUIPMENTS,MACHINERIES AND ITS SPARES.</Option> 
					
					<Option Value="1010087" >8474 80 30  FOUNDRY MACHINE</Option> 
					
					<Option Value="1010088" >8474 80 90  FOUNDRY MACHINE PART</Option> 
					
					<Option Value="1010131" >8474 90 00  MACHINES/PARTS</Option> 
					
					<Option Value="1010140" >84779072  CHUTE MANUFACTURING/FABRICATION</Option> 
					
					<Option Value="1010141" >8479 89 99  ROTEX MAKE CYLINDER</Option> 
					
					<Option Value="1010345" >8479 90 90  OTHER</Option> 
					
					<Option Value="1010191" >84796000  PANEL COOLER</Option> 
					
					<Option Value="1010023" >8480 10 00   - Moulding boxes for metal foundry</Option> 
					
					<Option Value="1010217" >8480 20 00  Mould Bases</Option> 
					
					<Option Value="1010040" >8480 30 00   - Moulding patterns</Option> 
					
					<Option Value="1010041" >8480 49 00   - Moulds for metal or metal carbides: -- Other</Option> 
					
					<Option Value="1010206" >8480 81 30  INDUSTRIAL VALVES</Option> 
					
					<Option Value="1010265" >8481 10 00  PARTS OF ELECTRIC</Option> 
					
					<Option Value="1010419" >8481 80 30  PRESSURSE RELIEF VALVE DPRH 06 100 BAR SUBPLATE</Option> 
					
					<Option Value="1010258" >8481 80 90  MICRO RATIO VALVE</Option> 
					
					<Option Value="1010439" >8482 10 00  BEARING</Option> 
					
					<Option Value="1010447" >8482 10 11  BEARINGS</Option> 
					
					<Option Value="1010316" >8482 10 20  BEARING</Option> 
					
					<Option Value="1010219" >8482 20 11  Tapered roller bearings</Option> 
					
					<Option Value="1010080" >8483 30 00  PLAIN SHAFT BEARINGS</Option> 
					
					<Option Value="1010339" >8483 30 00  BUSH ASSEMBLY</Option> 
					
					<Option Value="1010334" >8483 40 00  WARM SHAFT</Option> 
					
					<Option Value="1010283" >8483 60 10  US CI  CPLG</Option> 
					
					<Option Value="1010052" >8483 90 00  Parts of Gear Box</Option> 
					
					<Option Value="1010005" >8483 99 90  Other Transmission Elements Presented Separately;Parts</Option> 
					
					<Option Value="1010298" >8486 90 00  SMC VALUE</Option> 
					
					<Option Value="1010142" >85021100  accoustic diesel genset and</Option> 
					
					<Option Value="1010168" >8503 00 29  COPPER WIRE SCRAP</Option> 
					
					<Option Value="1010287" >8504 10 90  ELECTRICAL PARTS</Option> 
					
					<Option Value="1010268" >8504 22 00  FURANE TRANSFORMER</Option> 
					
					<Option Value="1010228" >8504 40 10  ELECTRIC INVERTER</Option> 
					
					<Option Value="1010267" >8504 40 90  PANEL ACCESSARIES</Option> 
					
					<Option Value="1010229" >8504 90 9   OTHER</Option> 
					
					<Option Value="1010104" >85042100  Transformer</Option> 
					
					<Option Value="1010135" >8505 19 00  ARTICALS IN TO B.P.MAGNET</Option> 
					
					<Option Value="1010212" >8505 20 00  A C COIL</Option> 
					
					<Option Value="1010333" >8505 90 00  CIRCULAR LIFTING MAGNET</Option> 
					
					<Option Value="1010357" >8511 20 90  8511 20 90</Option> 
					
					<Option Value="1010207" >8514 30 10  PART OF FURNACE</Option> 
					
					<Option Value="1010092" >8514 90 00  COMPONENT OF I.M.F</Option> 
					
					<Option Value="1010437" >851531  FULLY/PARTLY AUTOMATIC MCHNS & APPRTS FR ARC(INCL PLASMA ARC)WLDNG OF MTL</Option> 
					
					<Option Value="1010192" >85176290  85176290 SWITCH -SOARES FOR VMC,CNC M/C</Option> 
					
					<Option Value="1010063" >8519 00 00  PART OF OVEN & FURNACE ELECTRIC</Option> 
					
					<Option Value="1010177" >85311020  83111020</Option> 
					
					<Option Value="1010121" >85321000  LCV CAPACITORS</Option> 
					
					<Option Value="1010318" >8534 00 00  Encoder cap</Option> 
					
					<Option Value="1010274" >8535 21 21  22kv Combination panel outdoor</Option> 
					
					<Option Value="1010294" >8536 20 10  AIR CIRCUIT BREAKE</Option> 
					
					<Option Value="1010126" >8536 50 90  PARTS FOR SAND RECLAIMATION SYSTEM</Option> 
					
					<Option Value="1010127" >8536 50 90  PARTS SAND RECL</Option> 
					
					<Option Value="1010210" >8536 90 90  SWITCHES ,RELAYS & ACCESSORIES</Option> 
					
					<Option Value="1010433" >8537 00 00  VACUUM LOAD BREAKER SWITCH WITH PANAL 33 KVA</Option> 
					
					<Option Value="1010216" >8537 10 00  Voltage not exceeding 1000 V</Option> 
					
					<Option Value="1010286" >8538 10 10  CONTROL PARTS</Option> 
					
					<Option Value="1010101" >8538 90 00  ACCESSORY</Option> 
					
					<Option Value="1010452" >85423100  MONOLITHIC INTEGRATED CIRCUITS - DIGITAL</Option> 
					
					<Option Value="1010367" >8544 11 90  8544 11 90</Option> 
					
					<Option Value="1010364" >8544 20 90  8544 20 90</Option> 
					
					<Option Value="1010225" >8544 60 90  ELECTIRCAL MATERIAL  CABLE</Option> 
					
					<Option Value="1010375" >85459010  Arc-lamp carbon</Option> 
					
					<Option Value="1010397" >8548 10 90  Other Wastage Scrap</Option> 
					
					<Option Value="1010386" >87060031  Chassis fitted with enginees for the motor vehicles</Option> 
					
					<Option Value="1010182" >87078000  8207 80 00 TOOLS</Option> 
					
					<Option Value="1010337" >8708 10 90  M.S.SCRAP</Option> 
					
					<Option Value="1010227" >8708 29 00  PARTS OF VEHICALS</Option> 
					
					<Option Value="1010067" >8708 94 00  M.V. PARTS</Option> 
					
					<Option Value="1010006" >8708 99 00  Parts & Accessories of Motor Vehicle</Option> 
					
					<Option Value="1010371" >8708 99 00  8708 99 00</Option> 
					
					<Option Value="1010387" >87083000  Brakes and servo-brakes; parts thereof</Option> 
					
					<Option Value="1010358" >8714 92 90  8714 92 90</Option> 
					
					<Option Value="1010050" >8714 94 00  Parts & Accessories of Motor Vehicle</Option> 
					
					<Option Value="1010053" >87141900  Parts and Accessories of Motor Vehicle</Option> 
					
					<Option Value="1010161" >8716 20 00  Parts of Mechinical and electric material</Option> 
					
					<Option Value="1010259" >87169010  Parts & Accessories of Trailers</Option> 
					
					<Option Value="1010195" >90158000  Gauges - 90158000</Option> 
					
					<Option Value="1010187" >9017 30 00  GAUGES</Option> 
					
					<Option Value="1010409" >9017 30 10  Mathemetical instruments and pantograph</Option> 
					
					<Option Value="1010244" >9017 30 21  Plug - Guages</Option> 
					
					<Option Value="1010402" >9017 30 22  Ring Gauges</Option> 
					
					<Option Value="1010403" >9017 30 23  Slip Gauges</Option> 
					
					<Option Value="1010155" >9017 30 29  OTHER GUAGES</Option> 
					
					<Option Value="1010407" >9017 30 30  AIR PLUG GAUGES</Option> 
					
					<Option Value="1010408" >9017 30 31  AIR RING GAUGE</Option> 
					
					<Option Value="1010282" >9017 80 90  GAUGES</Option> 
					
					<Option Value="1010097" >90179000  Relation Gauge</Option> 
					
					<Option Value="1010243" >9018 90 29  Gauges - Other</Option> 
					
					<Option Value="1010132" >90248099  SPECIAL TESTING MACHINE</Option> 
					
					<Option Value="1010305" >9025 19 20  BATTERY BOARD</Option> 
					
					<Option Value="1010368" >9025 80 90  9025 80 90</Option> 
					
					<Option Value="1010038" >9025 90 00   - Parts and accessories           Measuring Instruments</Option> 
					
					<Option Value="1010309" >9027 30 10  SPECTROMETRE  COMPLETE WITH ACEESSARIES</Option> 
					
					<Option Value="1010232" >9027 30 90  SPECTRA MACHINE PARTS</Option> 
					
					<Option Value="1010405" >9027 80 30  CHLOROSCOPE</Option> 
					
					<Option Value="1010252" >9027 80 90  COATING THICKNESS GAUGE</Option> 
					
					<Option Value="1010205" >9027 90 90  PARTS FOR SPECTROMETER</Option> 
					
					<Option Value="1010458" >9028 90 90  GAS, LIQUID OR ELECTRICITY SUPPLY OR PRODUCTION METERS, INCLUDING CALIBRATING METERS THEREFOR - PART</Option> 
					
					<Option Value="1010105" >90289090  22 KV HT METERING CUBICLE</Option> 
					
					<Option Value="1010122" >9031 80 00  CMM MACHINE</Option> 
					
					<Option Value="1010365" >9031 80 00  9031 80 00</Option> 
					
					<Option Value="1010085" >9031 90 00  RELATIONAL  GUAGES</Option> 
					
					<Option Value="1010188" >90311000  REALATION GAUGES</Option> 
					
					<Option Value="1010271" >90314900  MEASURING STATION</Option> 
					
					<Option Value="1010279" >9032 89 10  Electronic automatic regulators</Option> 
					
					<Option Value="1010319" >9032 90 00  PLC CARDS</Option> 
					
					<Option Value="1010143" >90328990  consudigital powder conditioner</Option> 
					
					<Option Value="1010303" >9033 00 00  MINI TIPS/THERMOCOUPLE</Option> 
					
					<Option Value="1010317" >9131 80 00  Encoder BTP</Option> 
					
					<Option Value="1010446" >9405 00 00  LED (light emitting diode) driver and MCPCB (Metal Core Printed Circuit Board)</Option> 
					
					<Option Value="1010438" >9603  BROOMS, BRUSHES (INCLUDING BRUSHES CONSTITUTING PARTS OF MACHINES, APPLIANCES OR VEHICLES)</Option> 
					
					<Option Value="1010134" >9603 50 50  STEEL WIRE BRUSH</Option> 
					</select>				</td>
			</tr>
			<tr>
			  <td>
					<label class="caption" >Old Code</label>				</td>
				
				<td>
					<Input Type="Text" Id="txtOldCode" name="txtOldCode" TabIndex=21  Size="15" MaxLength="10" >				</td>
			</tr>	
			<tr>
			  <Td>
					<label class="caption">Goods Category </label>				</Td>
				<Td>
					
					<Select id="drpGoodsCat" name="drpGoodsCat"  TabIndex="22" >
					 
						<Option Value="101" >Exempted Categories</Option>
						 
						<Option Value="102" >Tax Free (Zero Rate)</Option>
						 
						<Option Value="103" >Commonly used Goods and Services â 5%</Option>
						 
						<Option Value="104" >Standard Goods fall under 1st slab â 12%</Option>
						 
						<Option Value="105" >Standard Goods  fall under 2nd Slab â 18%</Option>
						 
						<Option Value="106" >Special category of Goods including luxury - 28%</Option>
					</select>				</Td>
			</tr>
			<tr>
			  <Td>&nbsp;</Td>
			  <Td>&nbsp;</Td>
  </tr>
		</table>
 

</form>
</div>

<div style="height:550px; overflow: scroll;background-color: white;width:29%;float:right;">
<form action="Supplier_Summary.jsp" method="post" name="edit" id="edit">
<input type="hidden" name="hid_code" id="hid_code"> 
<span id="autofind">
<table class="tftable">
<tr>
    <th>
    <select name="supplier_name" id="supplier_name" onChange="getSupplier(this.value)">
    <option value="">All</option>
    <option value="0">Pending</option>
    <option value="1">Approved</option>
    <option value="3">Declined</option> 
    </select> Supplier</th>
    <th>Request Date</th>
    <th>Created By</th>
    <th>Status</th>
    <th>Created in ERP</th>
  </tr>
  <%
  int created_erp =0;
  ps = conlocal.prepareStatement("select DATE_FORMAT(registered_date, \"%d/%m/%Y %l:%i\") as registered_date,created_inERP,code,supplier,registered_by,approval_status  from new_item_creation where enable=1 and approval_status!=3 order by created_inERP");
  rs = ps.executeQuery();
  while(rs.next()){
	  created_erp = rs.getInt("created_inERP");
  %>
  <tr  onmouseover="ChangeColor(this, true);" onMouseOut="ChangeColor(this, false);" onClick="button1('<%=rs.getInt("code")%>')" style="cursor: pointer;">
  <td align="left" style="font-family: Arial;font-size: 10px;"><%=rs.getString("supplier").toUpperCase() %></td>
  <td><%=rs.getString("registered_date") %></td>
  <td><%=rs.getString("registered_by") %></td>
  <%
  if(rs.getString("approval_status").equalsIgnoreCase("0")){
  %>
  <td>Pending</td>
  <%
  } 
  if(rs.getString("approval_status").equalsIgnoreCase("1")){
  %>
  <td>Approved</td>
  <%
  } 
  if(rs.getString("approval_status").equalsIgnoreCase("3")){
  %>
  <td>Declined</td>
  <%
  }
  if(created_erp==0){
  %>  
 <td><b> - - - - </b></td>
 <%
  }else{
%>
 <td><b>Created</b></td>
<%	  
  }
 %>
  </tr>
  <%
  }
  %>
</table>
</span>
</form>
</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	%>
</body>
</html>