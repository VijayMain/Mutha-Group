<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
<meta charset="utf-8">
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>Machine Shop MIS HOME</title>
<link rel="stylesheet"
	href="js/jquery-ui.css">
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<script>
	$(function() {
		$("#tabs").tabs();
	});
	
	$(document).ready(
	function () {   
			    $( "#fromdate" ).datepicker({
			      changeMonth: true,
			      changeYear: true 
			    });
			    $( "#onDate_ots" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });                              
			    $( "#todate" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#custdPlanDate" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_fromrm" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_torm" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_fromb" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_tob" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });        
			    $( "#date_frompurorder" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_topurorder" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });				     
			    $( "#todate_amend" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#fromdate_amend" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_fromVBR" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_toVBR" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_fromWorkOrder" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#date_toWorkOrder" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#FromDate_cashbook" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				});
			    $( "#ToDate_cashbook" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				});
			    $( "#FromDatebillwisepurchase" ).datepicker({
				      changeMonth: true,
				      changeYear: true 				         
				}); 
			    $( "#ToDatebillwisepurchase" ).datepicker({
				      changeMonth: true,
				      changeYear: true 				         
				}); 
	}
	);
	 	
</script> 
<script type="text/javascript">
	function navigateToMIS(target, newWindow) {
		window.location = "HomePage.jsp";
	}
	
	function getAllCustomers(str) {
		document.getElementById("waitcustdPlan").style.visibility = "visible";
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
				document.getElementById("getCustAuto").innerHTML = xmlhttp.responseText; 
			}
		};
		xmlhttp.open("GET", "Get_AllCustomers.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	
	function getAllSupplier(str) {
		document.getElementById("waitsup").style.visibility = "visible";
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
				document.getElementById("getsupplier").innerHTML = xmlhttp.responseText; 
			}
		};
		xmlhttp.open("GET", "Get_AllSupplier.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	
	// companyWorkOrder   sup_WorkOrder   waitWorkOrder    date_fromWorkOrder   date_toWorkOrder   ADDWorkOrder    waitWorkOrder   
	
	function getAllSupplierWorkOrder(str) {
		document.getElementById("waitWorkOrder").style.visibility = "visible";
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
				document.getElementById("getsupplierWorkOrder").innerHTML = xmlhttp.responseText; 
			}
		};
		xmlhttp.open("GET", "Get_AllSupplierWorkOrder.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	
	function get_AllSupplierVBR(str) {
		document.getElementById("waitVBR").style.visibility = "visible";
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
				document.getElementById("getsupplierVBR").innerHTML = xmlhttp.responseText; 
			}
		};
		xmlhttp.open("GET", "Get_AllSupplierVBR.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	function validateCashBook() {
		document.getElementById("ADD_cashbook").disabled = true;
		document.getElementById("waitImage_cashbook").style.visibility = "visible";		
		return true;
	}
	
	function updateHid(str) {
		document.getElementById("buttonChg").value = str;
	}
</script>
<style type="text/css">
.tftable {
	font-size: 12px;
	font-family: Arial;
	color: #333333;  
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 2px; 
	text-align: center;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px; 
	padding: 2px; 
}
</style>
<script type="text/javascript">
function validatedPlanForm(){
	var company = document.getElementById("companydPlan");
	var custdPlan = document.getElementById("custdPlan"); 
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDdPlan").disabled = false;
			document.getElementById("waitImagedPlan").style.visibility = "hidden";
			return false;
		}
		if (custdPlan.value=="0" || custdPlan.value==null || custdPlan.value=="" || custdPlan.value=="null") {
			alert("Please Select Customer !!!"); 
			document.getElementById("ADDdPlan").disabled = false;
			document.getElementById("waitImagedPlan").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("ADDdPlan").disabled = true;
		document.getElementById("waitImagedPlan").style.visibility = "visible";
		
		return true;
}


function validateForm() {
	var company = document.getElementById("company");
	var fromdate = document.getElementById("fromdate");
	var todate = document.getElementById("todate");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADD").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		}
		if (fromdate.value=="0" || fromdate.value==null || fromdate.value=="" || fromdate.value=="null") {
			alert("Please Select Date From !!!"); 
			document.getElementById("ADD").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		}
		if (todate.value=="0" || todate.value==null || todate.value=="" || todate.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADD").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADD").disabled = true;
		document.getElementById("waitImage").style.visibility = "visible";
		
		return true;
}		
</script> 
 <script type="text/javascript">
function validateDispForm() {
	var company = document.getElementById("companyDisp");
	var month = document.getElementById("monthDisp");
	var year = document.getElementById("yearDisp");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDDisp").disabled = false;
			document.getElementById("waitImageDisp").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDDisp").disabled = false;
			document.getElementById("waitImageDisp").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDDisp").disabled = false;
			document.getElementById("waitImageDisp").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDDisp").disabled = true;
		document.getElementById("waitImageDisp").style.visibility = "visible";
		
		return true;
}		
</script>
<script type="text/javascript">
function validateProdForm() {
	var company = document.getElementById("companyProd");
	var month = document.getElementById("monthProd");
	var year = document.getElementById("yearProd");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDProd").disabled = false;
			document.getElementById("waitImageProd").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDProd").disabled = false;
			document.getElementById("waitImageProd").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDProd").disabled = false;
			document.getElementById("waitImageProd").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDProd").disabled = true;
		document.getElementById("waitImageProd").style.visibility = "visible";
		
		return true;
}		
</script>
<script type="text/javascript">
function validateGRNForm() {                  
	var company = document.getElementById("companyGRN");
	var month = document.getElementById("monthGRN");
	var year = document.getElementById("yearGRN");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDGRN").disabled = false;
			document.getElementById("waitImageGRN").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDGRN").disabled = false;
			document.getElementById("waitImageGRN").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDGRN").disabled = false;
			document.getElementById("waitImageGRN").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDGRN").disabled = true;
		document.getElementById("waitImageGRN").style.visibility = "visible";
		
		return true;
}		
</script>
<script type="text/javascript">
function validat_boring() {    
		document.getElementById("ADDb").disabled = true;	
		document.getElementById("ADDmonthbor").disabled = true;
		document.getElementById("waitImageb").style.visibility = "visible";
		
		return true;
}		
function validateBillWisePurchase() {
	document.getElementById("ADDbillwisepurchase").disabled = true;
	document.getElementById("waitImagebillwisepurchase").style.visibility = "visible";		
	return true;
}
function validateVAT_ledger(){
	document.getElementById("ADD_vatledger").disabled = true;
	document.getElementById("waitImage_vatledger").style.visibility = "visible";		
	return true;
}
</script>
<script type="text/javascript">
function validateMacRejForm() {                  
	var company = document.getElementById("companymacRej");
	var month = document.getElementById("monthmacRej");
	var year = document.getElementById("yearmacRej");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDmacRej").disabled = false;
			document.getElementById("waitImagemacRej").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDmacRej").disabled = false;
			document.getElementById("waitImagemacRej").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDmacRej").disabled = false;
			document.getElementById("waitImagemacRej").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDmacRej").disabled = true;
		document.getElementById("waitImagemacRej").style.visibility = "visible";
		
		return true;
}		


function validatedPartPorderForm() {         
	var company = document.getElementById("companyporder");
	var sup_order = document.getElementById("sup_order");
	var date_frompurorder = document.getElementById("date_frompurorder");
	var date_topurorder = document.getElementById("date_topurorder");
	
	// companyporder   sup_order   date_frompurorder   date_topurorder   ADDp_order   waitImagep_order
	
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		if (sup_order.value=="0" || sup_order.value==null || sup_order.value=="" || sup_order.value=="null") {
			alert("Please Select Supplier !!!"); 
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		if (date_frompurorder.value=="0" || date_frompurorder.value==null || date_frompurorder.value=="" || date_frompurorder.value=="null") {
			alert("Please Select From Date !!!"); 
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		if (date_topurorder.value=="0" || date_topurorder.value==null || date_topurorder.value=="" || date_topurorder.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDp_order").disabled = true;
		document.getElementById("waitImagep_order").style.visibility = "visible";
		
		return true;
}


function validatedPartWorkorderForm() {
	var company = document.getElementById("companyWorkOrder");
	var sup_order = document.getElementById("sup_WorkOrder");
	var date_frompurorder = document.getElementById("date_fromWorkOrder");
	var date_topurorder = document.getElementById("date_toWorkOrder");
	
	// companyWorkOrder   sup_WorkOrder   waitWorkOrder    date_fromWorkOrder   date_toWorkOrder   ADDWorkOrder    waitWorkOrder   
	
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDWorkOrder").disabled = false;
			document.getElementById("waitWorkOrder").style.visibility = "hidden";
			return false;
		}
		if (sup_order.value=="0" || sup_order.value==null || sup_order.value=="" || sup_order.value=="null") {
			alert("Please Select Supplier !!!"); 
			document.getElementById("ADDWorkOrder").disabled = false;
			document.getElementById("waitWorkOrder").style.visibility = "hidden";
			return false;
		}
		if (date_frompurorder.value=="0" || date_frompurorder.value==null || date_frompurorder.value=="" || date_frompurorder.value=="null") {
			alert("Please Select From Date !!!"); 
			document.getElementById("ADDWorkOrder").disabled = false;
			document.getElementById("waitWorkOrder").style.visibility = "hidden";
			return false;
		}
		if (date_topurorder.value=="0" || date_topurorder.value==null || date_topurorder.value=="" || date_topurorder.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADDWorkOrder").disabled = false;
			document.getElementById("waitWorkOrder").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDWorkOrder").disabled = true;
		document.getElementById("waitWorkOrder").style.visibility = "visible";
		
		return true;
}


function validVBR_Form() {              
	var company = document.getElementById("companyVBR");
	var sup_order = document.getElementById("supVBR");
	var date_frompurorder = document.getElementById("date_fromVBR");
	var date_topurorder = document.getElementById("date_toVBR");
	
	// companyporder   sup_order   date_frompurorder   date_topurorder   ADDp_order   waitImagep_order
	
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDVBR").disabled = false;
			document.getElementById("waitImageVBR").style.visibility = "hidden";
			return false;
		}
		if (sup_order.value=="0" || sup_order.value==null || sup_order.value=="" || sup_order.value=="null") {
			alert("Please Select Supplier !!!"); 
			document.getElementById("ADDVBR").disabled = false;
			document.getElementById("waitImageVBR").style.visibility = "hidden";
			return false;
		}
		if (date_frompurorder.value=="0" || date_frompurorder.value==null || date_frompurorder.value=="" || date_frompurorder.value=="null") {
			alert("Please Select From Date !!!"); 
			document.getElementById("ADDVBR").disabled = false;
			document.getElementById("waitImageVBR").style.visibility = "hidden";
			return false;
		}
		if (date_topurorder.value=="0" || date_topurorder.value==null || date_topurorder.value=="" || date_topurorder.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADDVBR").disabled = false;
			document.getElementById("waitImageVBR").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDVBR").disabled = true;
		document.getElementById("waitImageVBR").style.visibility = "visible";
		
		return true;
}




</script>
<script type="text/javascript">
function validateCastRejForm() {        
	var company = document.getElementById("companycastRej");
	var month = document.getElementById("monthcastRej");
	var year = document.getElementById("yearcastRej");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDcastRej").disabled = false;
			document.getElementById("waitImagecastRej").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDcastRej").disabled = false;
			document.getElementById("waitImagecastRej").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDcastRej").disabled = false;
			document.getElementById("waitImagecastRej").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDcastRej").disabled = true;
		document.getElementById("waitImagecastRej").style.visibility = "visible";
		
		return true;
}		

function validateCatoutForm(){       
	document.getElementById("ADDots").disabled = true;
	document.getElementById("waitImageots").style.visibility = "visible";		
	return true;
}

function validateBU(){
	document.getElementById("ADDUB").disabled = true;
	document.getElementById("waitImageUB").style.visibility = "visible";
	
	var companyBU = document.getElementById("companyBU").value;
	var monthBU = document.getElementById("monthBU").value;
	var yearBU = document.getElementById("yearBU").value;
	var custUB = document.getElementById("custUB").value;
		
	document.getElementById("compBU_hid").value = companyBU;
	document.getElementById("monthBU_hid").value = monthBU;
	document.getElementById("yearBU_hid").value = yearBU;
	document.getElementById("custBU_hid").value = custUB;
	
	// compBU_hid   monthBU_hid   yearBU_hid   custBU_hid
	// companyBU   monthBU    yearBU  custUB
	
	return true;
}
</script>
<script type="text/javascript">
function validat_rmcomsume() {      
	var companyrm = document.getElementById("companyrm"); 
	 
		if (companyrm.value=="0" || companyrm.value==null || companyrm.value=="" || companyrm.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDrm").disabled = false;
			document.getElementById("waitImagerm").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("ADDrm").disabled = true;
		document.getElementById("waitImagerm").style.visibility = "visible";
		
		return true;
}		
</script>

<script type="text/javascript">
function validateRateAmend() {
	var company_amend = document.getElementById("company_amend");
	var fromdate_amend = document.getElementById("fromdate_amend"); 
	var todate_amend = document.getElementById("todate_amend");  
	 
		if (company_amend.value=="0" || company_amend.value==null || company_amend.value=="" || company_amend.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADD_amend").disabled = false;
			document.getElementById("waitImage_amend").style.visibility = "hidden";
			return false;
		}
		if (fromdate_amend.value=="0" || fromdate_amend.value==null || fromdate_amend.value=="" || fromdate_amend.value=="null") {
			alert("Please Select From Date !!!"); 
			document.getElementById("ADD_amend").disabled = false;
			document.getElementById("waitImage_amend").style.visibility = "hidden";
			return false;
		}
		if (todate_amend.value=="0" || todate_amend.value==null || todate_amend.value=="" || todate_amend.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADD_amend").disabled = false;
			document.getElementById("waitImage_amend").style.visibility = "hidden";
			return false;
		}
		
		document.getElementById("ADD_amend").disabled = true;
		document.getElementById("waitImage_amend").style.visibility = "visible";
		
		return true;
}
</script>
</head>
<body  style="font-family: Arial;">
<%
try{
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String uname=null;
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		uname=rs_uname.getString("U_Name"); 
	}
%>

<%
if(request.getParameter("successasm")!=null){
%>
<script type="text/javascript">
alert("Success, Please Download file from ERP System !");
</script>
<%
}
%>
<div style="width: 100%">
<a href="Logout.jsp" style="text-decoration: none;color: #110966;background-color: #F0F0AF;font-family: Arial;font-size: 13px;"><b>LogOut ( <%=uname %> )</b></a> 
</div>
<div align="left" style="float: left;width: 20%">
<br>
<input type="button" value="Foundry MIS System" onclick="navigateToMIS('window', false);" style="width: 200px;height: 40px;">
</div>
<div align="center" style="float:left; width: 55%">
<img src="images/machinemis.png"><br/> 
<strong style="font-size: 12px;font-family:Arial; color: blue;">MUTHA GROUP OF FOUNDRIES</strong><br/>
</div>
<div align="center" style="float: left;width: 24%;">
<img src="images/MUTHA LOGO.JPG"><br><b style="font-size: 12px;font-family: Arial;color: blue;">Mutha Group Of Industries Satara</b>
</div>
<br/> <br/> <br/> <br/> <br/> <br/>  
<% 

SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
Date tdate = new Date();
//-------------------------------------------------------- Date Logic --------------------------------------------------------- 
Calendar first_Datecal = Calendar.getInstance();   
first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
Date dddd = first_Datecal.getTime();  

String firstDate = sdfFIrstDate.format(dddd);
String nowDate = sdfFIrstDate.format(tdate);

	String[] mm = new DateFormatSymbols().getMonths();
	int getcalmn = Calendar.getInstance().get(Calendar.MONTH);
	String getcalName = mm[Calendar.getInstance().get(Calendar.MONTH)]; 

//-----------------------------------------------------------------------------------------------------------------------------  

ArrayList reportList = new ArrayList();
PreparedStatement ps = con.prepareStatement("select * from  mis_access_tbl  where  u_id =" + uid + " and mis_type_id=1 and Enable_Id=1");
ResultSet rs = ps.executeQuery();
while(rs.next()){
	PreparedStatement ps_rep = con.prepareStatement("select * from  mis_report_tbl  where  report_id="+rs.getInt("report_id"));
	ResultSet rs_rep = ps_rep.executeQuery();
	while(rs_rep.next()){
	reportList.add(rs_rep.getString("report_name"));
	}
} 
%>
	<div id="tabs">
		<ul>
		<%
		if(reportList.contains("Casting Stock Report")){
		%>
			<li><a href="#tabs-1">Casting Stock</a></li>
		<%
		}if(reportList.contains("Monthly Dispatch Report")){
		%>	
			<li><a href="#tabs-2">Monthly Despatch</a></li>
			<%
		}if(reportList.contains("Monthly Production Report")){
		%> 
			<li><a href="#tabs-3">Monthly Production</a></li>
			<%
		}if(reportList.contains("Dispatch Plan Vs Sale Report")){
		%>
			<li><a href="#tabs-4">Dispatch Plan Vs Sale</a></li>
			<%
		}if(reportList.contains("Monthly Machining Rejection Report")){
		%>
			<li><a href="#tabs-5">Machining Rejection</a></li>
			<%
		}if(reportList.contains("Purchase vs Sale Report")){
		%>
			<li><a href="#tabs-6">Purchase vs Sale</a></li>
			<%
		}if(reportList.contains("Daywise Boring Report")){
		%>
			<li><a href="#tabs-7">Daywise Boring</a></li>
			<%
		}if(reportList.contains("Category Wise Outstanding Report")){
		%> 
			<li><a href="#tabs-8">Category Wise Outstanding</a></li>
			<%
		}if(reportList.contains("Party Wise Purchase Order Report")){
		%>
			<li><a href="#tabs-9">Party Wise Purchase Order</a></li>
			<%
		}if(reportList.contains("Rate Amendment Summary Report")){
		%>
			<li><a href="#tabs-10">Rate Amendment Summary</a></li>
		<%
		}if(reportList.contains("Vendor Boring Receipt Report")){
		%>
			<li><a href="#tabs-11">Vendor Boring Receipt</a></li>
		<%
		}if(reportList.contains("Party Wise Work Order Report")){
		%> 	
			<li><a href="#tabs-12">Party Wise Work Order Report</a></li>
		<%	
		}if(reportList.contains("CashBook Report")){
		%>
			<li><a href="#tabs-13">Cash Book Report</a></li>
		<% 
		}if(reportList.contains("ASN Generation")){
		%>
			<li><a href="#tabs-14">ASN Generation</a></li>
		<%
		}if(reportList.contains("Bill Wise Purchase Details")){
		%>
				<li><a href="#tabs-15">Bill Wise Purchase Details</a></li> 
		<%
		}if(reportList.contains("Outstanding Bajaj and Umasons")){
		%> 	
			<li><a href="#tabs-16">Outstanding Bajaj and Umasons</a></li>
		<%  
		}if(reportList.contains("VAT_ledger")){
		%>
			<li><a href="#tabs-17">VAT Ledger</a></li>
		<%
		}if(reportList.size()==0){			
		%> 	
			<li><a href="#tabs-18">Work In Progress</a></li>
		<%
		}
		%>
		
		
			<!-- 
			<li><a href="#tabs-6">Casting Rejection</a></li>
			 -->						  
		</ul>  
		<%
		if(reportList.contains("Casting Stock Report")){
		%>
		<div id="tabs-1" align="left">
			<br/>
			<br/> 
 <form action="Get_CastingStock_MSController" method="post"  onSubmit="return validateForm();">
 <!--
 // *******************************************************************************************************************************
 // ********************************************* Casting Stock REPORT FORM ****************************************************
 // *******************************************************************************************************************************
  -->
  
	<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Casting Stock Report<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="company"> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>    
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>From Date :</td>
				<td> <input type="text" id="fromdate" name="fromdate" value="<%=sdfFIrstDate.format(dddd) %>" readonly="readonly"></td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td><input type="text" id="todate" name="todate" value="<%=sdfFIrstDate.format(tdate) %>" readonly="readonly"></td>
			</tr> 
			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD" value="Get Casting Stock Report" style="background-color: #BABABA;width: 255px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImage" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
  
 <!-- 
 // *******************************************************************************************************************************
  -->
		</div>
		<%
		}if(reportList.contains("Monthly Dispatch Report")){
		%>
	<div id="tabs-2">
			<br/>
			<br/>
 <!-- 
 // *******************************************************************************************************************************
 // *********************************************** Dispatch Report REPORT FORM ***************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_MonthlyDispatch_Controller" method="post"  onSubmit="return validateDispForm();">
			<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Dispatch Report<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyDisp">
 				<!-- <option value=""> - - - - - Select - - - - -</option>  -->
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthDisp"> 
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<%
 		for (int i = 0; i < 12; i++) {
	   	String mmname = mm[i]; 
 		%>
 			<option value="<%=i+1%>"><%=mmname %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearDisp">
 		<%

 		int yr = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = yr; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDDisp" value="Get Dispatch Report" style="background-color: #BABABA;width: 255px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageDisp" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
	
	<!-- 
 // *******************************************************************************************************************************
  -->	 			 
		</div>
		 <%
		}if(reportList.contains("Monthly Production Report")){
		 %> 
		<div id="tabs-3">
			<br/>
			<br/>
  <!-- 
 // *******************************************************************************************************************************
 // *********************************************** Monthly Production REPORT FORM ***************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_MonthlyProduction_Controller" method="post"  onSubmit="return validateProdForm();">
			<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Monthly Production Report<br/></strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyProd">
 				<option value=""> - - - - - Select - - - - -</option> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthProd">
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] mnt = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String mmname = mnt[i]; 
 		%>
 			<option value="<%=i+1%>"><%=mmname %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearProd"> 
 		<%

 		int year = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = year; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDProd" value="Get Production Report" style="background-color: #BABABA;width: 265px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageProd" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 	
	<!-- 
 // *******************************************************************************************************************************
  -->	 			 
		</div>
		<%
		}if(reportList.contains("Dispatch Plan Vs Sale Report")){
		%>
		<div id="tabs-4">
			<br/><br/>
				<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Dispatch Plan Vs Sale Report **************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_DispPlanV_Sale_Controller" method="post"  onSubmit="return validatedPlanForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Dispatch Plan Vs Sale Report<br/> </strong> <br/>
				 </td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companydPlan" onchange="getAllCustomers(this.value)">
 				<option value=""> - - - - - Select - - - - -</option>
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Customer :</td>
				<td>
				<span id="getCustAuto">
					<select name="cust" id="custdPlan"> 
					<option value=""> - - - - - Select - - - - - </option>
			 </select>  &nbsp;
				 <span id="waitcustdPlan" style="visibility: hidden;"><strong style="color: blue;">Please Wait.....</strong></span>
				 </span>
				 </td> 
			</tr>
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="custdPlanDate" value="<%=sdfFIrstDate.format(tdate) %>" id="custdPlanDate" readonly="readonly"/>  
				</td>
			</tr> 
  			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDdPlan" value="Get Dispatch Plan Vs Sale Report" style="background-color: #BABABA;width: 320px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImagedPlan" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
	
	<!-- 
 // *******************************************************************************************************************************
  --> 		 
		</div>
		<%
		}if(reportList.contains("Monthly Machining Rejection Report")){
		%>
		<div id="tabs-5">
			<br/>
			<br/>
  <!-- 
 // *******************************************************************************************************************************
 // *********************************************** MONTHLY MACHINING REJECTION REPORT FORM ****************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_MachiningRejection_Controller" method="post"  onSubmit="return validateMacRejForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Monthly Machining Rejection Report<br/></strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companymacRej">
 				<option value=""> - - - - - Select - - - - -</option> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthmacRej">
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] monthmacRej = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String mmname = monthmacRej[i]; 
 		%>
 			<option value="<%=i+1%>"><%=mmname %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearmacRej"> 
 		<%
 		int yearmacRej = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = yearmacRej; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDmacRej" value="Get Production Report" style="background-color: #BABABA;width: 255px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImagemacRej" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 	
	<!-- 
 // *******************************************************************************************************************************
  -->	 			 
		</div>
		<%
		}if(reportList.contains("Purchase vs Sale Report")){
		%>
		<div id="tabs-6">
		<form action="Get_rmComsume_Controller" method="post"  onSubmit="return validat_rmcomsume();">
		<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Purchase vs Sale<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyrm"> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>    
				<td>From Date :</td>     
				<td> <input type="text" name="date_fromrm" value="<%=sdfFIrstDate.format(dddd) %>" id="date_fromrm" readonly="readonly"/>  
				 </td>
			</tr>
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="date_torm" value="<%=sdfFIrstDate.format(tdate) %>" id="date_torm" readonly="readonly"/>  
				</td>
			</tr>  			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDrm" value="Get Purchase vs Sale" style="background-color: #BABABA;width: 255px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImagerm" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
		</form>
		</div>
		
		<%
		}if(reportList.contains("Daywise Boring Report")){
		%>
		
		<div id="tabs-7">
		<form action="Get_DaywiseBoring_Controller" method="post" onSubmit="return validat_boring();">
		<input type="hidden" name="buttonChg" id="buttonChg">
		<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Daywise Boring Report<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyb"> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 				</select>
				 </td>
			</tr>			
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthb">
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] monthb = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String nameb = monthb[i]; 
 		%>
 			<option value="<%=i+1%>"><%=nameb %></option>
		 <% 
	 			}
 		 %>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearb"> 
 		<%
 		int yearb = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = yearb; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr>

  			
			<tr> 
			<td colspan="2" align="center">
				<input type="submit" name="ADD" id="ADDb" value="Daywise Boring" onclick="updateHid(this.value)" style="background-color: #BABABA;width: 150px;height: 35px;"/>
				<input type="submit" name="ADDmonthbor" id="ADDmonthbor"  onclick="updateHid(this.value)" value="Monthwise Boring" style="background-color: #BABABA;width: 150px;height: 35px;"/>
			 </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageb" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
		</form>
		</div>
		<%
		}if(reportList.contains("Category Wise Outstanding Report")){
		%>
		<div id="tabs-8">
		
		<br/><br/>
			<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Category Wise Outstanding  ******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_CatWiseOut_Controller" method="post"  onSubmit="return validateCatoutForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Category Wise Outstanding<br/> </strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyots">
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 				<option value="111">Consolidated</option>
 			</select> 
				 </td>
			</tr> 
			<tr>
				<td>On Date :</td>
				<td> <input type="text" name="onDate_ots" value="<%=sdfFIrstDate.format(tdate) %>" id="onDate_ots" readonly="readonly"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="left"><input type="submit" name="ADD" id="ADDots" value="Get Category Wise Outstanding" style="background-color: #BABABA;width: 300px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImageots" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>						 
		</table>
	</form>	 		


 
		</div>
		<%
		}if(reportList.contains("Party Wise Purchase Order Report")){
		%>
		<div id="tabs-9">
		<br/><br/>
 <!-- 
 // *******************************************************************************************************************************
 // *********************************************** Party Wise Purchase Order Report **************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_PartywsPurOrder_Controller" method="post"  onSubmit="return validatedPartPorderForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">Party Wise Purchase Order Report<br/> </strong> <br/>
				 </td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyporder"  onchange="getAllSupplier(this.value)">
 				<option value=""> - - - - - Select - - - - -</option>
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Supplier :</td>
				<td>
				<span id="getsupplier">
					<select name="sup" id="sup_order"> 
					<option value=""> - - - - - Select - - - - - </option>
			 </select>  &nbsp;
				 <span id="waitsup" style="visibility: hidden;"><strong style="color: blue; font-family: Arial;font-size: 10px;">Please Wait.....</strong></span>
				  </span>
				 
				 </td> 
			</tr>
			<tr>    
				<td>From Date :</td>     
				<td> <input type="text" name="date_frompurorder" value="<%=sdfFIrstDate.format(dddd) %>" id="date_frompurorder" readonly="readonly"/>  
				 </td>
			</tr>
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="date_topurorder" value="<%=sdfFIrstDate.format(tdate) %>" id="date_topurorder" readonly="readonly"/>  
				</td>
			</tr>  
  			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDp_order" value="Get Party Wise Purchase Order Report" style="background-color: #BABABA;width: 320px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImagep_order" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>						 
		</table>
	</form>	
	<!-- 
 // *******************************************************************************************************************************
  --> 		 
		</div>	
		<%
		}if(reportList.contains("Rate Amendment Summary Report")){
		%>	
		<div id="tabs-10">
			<br/>
			<br/> 
 <form action="Get_RateAmend_Controller" method="post"  onSubmit="return validateRateAmend();">
 <!--
 // *******************************************************************************************************************************
 // ********************************************* Rate Amendment Summary REPORT FORM **********************************************
 // *******************************************************************************************************************************
  -->
	<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Rate Amendment Summary Report<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="company_amend"> 
				<option value="all">All</option>
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>    
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>From Date :</td>
				<td> <input type="text" id="fromdate_amend" name="fromdate" value="<%=sdfFIrstDate.format(dddd) %>" readonly="readonly"></td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td><input type="text" id="todate_amend" name="todate" value="<%=sdfFIrstDate.format(tdate) %>" readonly="readonly"></td>
			</tr> 
			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD_amend" value="Get Rate Amendment Summary Report" style="background-color: #BABABA;width: 310px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImage_amend" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
  
 <!-- 
 // *******************************************************************************************************************************
  -->
		</div>
		<%
		}if(reportList.contains("Vendor Boring Receipt Report")){
		%>
		<div id="tabs-11"> 
		
		<br/><br/>
				<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Vendor Boring Receipt Report ********************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_VendorBoringReceipt_Controller" method="post"  onSubmit="return validVBR_Form();">
			<table class="tftable" style="border: 0px;">
			<tr>
				 <td colspan="2"><strong style="font-size: 12px;">To Get Vendor Boring Receipt Report<br/> </strong> <br/>
				 </td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td>
				<select name="company" id="companyVBR"  onchange="get_AllSupplierVBR(this.value)">
				<option value="">- - - - - Select - - - - - </option> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 				</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Supplier :</td>
				<td>
				<span id="getsupplierVBR">
					<select name="sup" id="supVBR"> 
					<option value=""> - - - - - Select - - - - - </option>
			 </select>  &nbsp;
				 <span id="waitVBR" style="visibility: hidden;"><strong style="color: blue; font-family: Arial;font-size: 10px;">Please Wait.....</strong></span>
				  </span>
				 </td> 
			</tr>
			<tr>    
				<td>From Date :</td>     
				<td> <input type="text" name="date_from" value="<%=sdfFIrstDate.format(dddd) %>" id="date_fromVBR" readonly="readonly"/>  
				 </td>
			</tr>
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="date_to" value="<%=sdfFIrstDate.format(tdate) %>" id="date_toVBR" readonly="readonly"/>  
				</td>
			</tr>  
  			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDVBR" value="Get Vendor Boring Receipt Report" style="background-color: #BABABA;width: 330px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageVBR" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>						 
		</table>
	</form>	
	<!-- 
 // *******************************************************************************************************************************
  --> 	 
		</div>
		<%
		}if(reportList.contains("Party Wise Work Order Report")){
		%>
		<div id="tabs-12"> 
		<br/><br/>
 <!-- 
 // *******************************************************************************************************************************
 // *********************************************** Party Wise Work Order Report **************************************
 // *******************************************************************************************************************************
 -->		
  <form action="Get_PartyWorkOrder_Controller" method="post"  onSubmit="return validatedPartWorkorderForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">Party Wise Work Order Report<br/> </strong> <br/>
				 </td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyWorkOrder" onchange="getAllSupplierWorkOrder(this.value)">
 				<option value=""> - - - - - Select - - - - -</option>
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Supplier :</td>
				<td>
				<span id="getsupplierWorkOrder">
					<select name="sup" id="sup_WorkOrder"> 
					<option value=""> - - - - - Select - - - - - </option>
			 </select>  &nbsp;
				 <span id="waitWorkOrder" style="visibility: hidden;"><strong style="color: blue; font-family: Arial;font-size: 10px;">Please Wait.....</strong></span>
				  </span>
				 
				 </td> 
			</tr>
			<tr>    
				<td>From Date :</td>     
				<td> <input type="text" name="date_fromWorkOrder" value="<%=sdfFIrstDate.format(dddd) %>" id="date_fromWorkOrder" readonly="readonly"/>  
				 </td>
			</tr>
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="date_toWorkOrder" value="<%=sdfFIrstDate.format(tdate) %>" id="date_toWorkOrder" readonly="readonly"/>  
				</td>
			</tr>  
  			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDWorkOrder" value="Get Party Wise Work Order Report" style="background-color: #BABABA;width: 320px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitWorkOrder" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>						 
		</table>
	</form>	
	<!-- 
 // *******************************************************************************************************************************
  --> 		  
		</div>
			<%		
			}if(reportList.contains("CashBook Report")){
		%>
			<div id="tabs-13">
				<form action="CashBook_Controller" method="post"  onSubmit="return validateCashBook();">
		<br/>
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To get Cash Book Report<br/> </strong> <br/>
			</td>
			</tr>  
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companycashbook"> 
				<option value="101102">ALL</option>
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>From Date :</td>
				<td> <input type="text" name="FromDate_cashbook" value="<%=sdfFIrstDate.format(dddd) %>" id="FromDate_cashbook" readonly="readonly" style="width: 200px;"/>  
				 </td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="ToDate_cashbook" value="<%=sdfFIrstDate.format(tdate) %>" id="ToDate_cashbook" readonly="readonly" style="width: 200px;"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD_cashbook" value="Get Cash Book Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImage_cashbook" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	
			</div>
		<%
			}if(reportList.contains("ASN Generation")){
		%>
		<div id="tabs-14">
		
		<form action="Get_ASMFile_Controller" method="post"  onSubmit="return validateDispForm();">
			<table class="tftable" style="border: 0px;width: 27%">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Generate ASN in ERP<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td>
				<select name="company" id="companyasm" style="height: 25px;"> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 				</select>
				 </td>
			</tr>
			<tr>
				<td>Select File format :</td>
				<td style="height: 25px;">
				<select name="file_typeasn" id="file_typeasn" style="height: 25px;"> 
 				<option value="txt">.txt</option> 
 				<option value="csv">.csv</option>  
 				</select> 
				</td>
			</tr>
			<tr>
			<td colspan="2" align="center">
			<br>
				<input type="submit" name="ADD" id="ADD_ASM" value=" Enable " style="background-color: #BABABA;width: 255px;height: 35px;"/> </td>
			</tr> 
		</table>
	</form>
		</div>
		<%
			}if(reportList.contains("Bill Wise Purchase Details")){
		%>
			<div id="tabs-15">
			<form action="BillWisePurchase_Controller" method="post" onSubmit="return validateBillWisePurchase();">
			<br/>
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get Bill Wise Purchase Details<br/></strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companybillwisepurchase"> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>    
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>From Date :</td>
				<td> <input type="text" name="FromDatebillwisepurchase" value="<%=sdfFIrstDate.format(dddd) %>" id="FromDatebillwisepurchase" readonly="readonly" style="width: 200px;"/>  
				 </td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="ToDatebillwisepurchase" value="<%=sdfFIrstDate.format(tdate) %>" id="ToDatebillwisepurchase" readonly="readonly" style="width: 200px;"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDbillwisepurchase" value="Bill Wise Purchase Details" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImagebillwisepurchase" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form> 		
			</div>
		<% 
			}if(reportList.contains("Outstanding Bajaj and Umasons")){
		%>
		<div id="tabs-16"> 
		<form action="Get_Outstanding_BU.jsp" method="post" onSubmit="return validateBU();">
		
		<input type="hidden" name="compBU_hid"  id="compBU_hid">
		<input type="hidden" name="monthBU_hid"  id="monthBU_hid">
		<input type="hidden" name="yearBU_hid"  id="yearBU_hid"> 
		<input type="hidden" name="custBU_hid"  id="custBU_hid"> 
		
		<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Outstanding Bajaj and Umasons<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyBU"> 
 				<!-- <option value="101">MEPL H21</option>  -->
 				<option value="102">MEPL H25</option>  
 				</select>
				 </td>
			</tr>			
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthBU">
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] monthb = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String nameb = monthb[i]; 
 		%>
 			<option value="<%=i+1%>"><%=nameb %></option>
		 <% 
	 			}
 		 %>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearBU"> 
 		<%
 		int yearb = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = yearb; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr>
			<tr>
				<td>Select Customer :</td>
				<td>
				<select name="cust" id="custUB"> 
 		<option value="101110004">BAJAJ AUTO LIMITED (AURANGABAD)</option> 
 		<option value="101110384">UMASONS AUTO COMPO PVT.LTD.</option> 
 			</select>
				 </td>
			</tr>
			<tr>
			<td colspan="2" align="center">
				<input type="submit" name="ADD" id="ADDUB" value="Generate Report"  style="font-weight:bold;background-color: #BABABA;width: 150px;height: 35px;"/> 
			 </td>
			</tr>
			<tr>
			<td colspan="2" align="center"><span id="waitImageUB" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
		</form> 
		
		
			</div>
		<%
			}if(reportList.contains("VAT_ledger")){
				%>
				 <div id="tabs-17">
				<!--
				exec "DIERP"."dbo"."Sel_RptAcctLedger";1 
				'105', '0', '101001024101001056101000928101000110101000144101001210101000145101000146101000147101000148101001080101001211101000149101000150101000179101001212101000180101000181101001144101001213', 
				'20170401', '20170428', 0
				 -->
				<form action="VAT_ledger.jsp" method="post"  onSubmit="return validateVAT_ledger();">
					<br/>
					<table class="tftable" style="border: 0px;">
					<tr>
						<td colspan="2"><strong>VAT Ledger<br/> </strong> <br/>
					</td>
					</tr>
					<tr>
						<td>Select Company :</td>
						<td>
						<select name="company" id="companyvatledger"> 
 							<option value="101">MEPL H21</option> 
 							<option value="102">MEPL H25</option>    
		 				</select>
					</td>
					</tr>
					<tr>
						<td>From Date :</td>
						<td> <input type="text" name="FromDatevatledger" value="<%=sdfFIrstDate.format(dddd) %>" id="FromDatevatledger" readonly="readonly" style="width: 200px;"/>  
						 </td>
					</tr>
					<tr>
						<td>To Date :</td>
						<td> <input type="text" name="ToDate_vatledger" value="<%=sdfFIrstDate.format(tdate) %>" id="ToDate_vatledger" readonly="readonly" style="width: 200px;"/> </td>
					</tr>
					<tr>
					<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD_vatledger" value="Get VAT Ledger Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
					</tr>
					<tr> 
					<td colspan="2" align="left"><span id="waitImage_vatledger" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
					</tr>
					</table>
				</form>
		 		
				 </div>
						<%
							}if(reportList.size()==0){
		%>
			<div id="tabs-18">
			<img alt="images/underconst.jpg" src="images/underconst.jpg"> 		
			</div>
		<%
			}
		%>
		
		<%--		
		<div id="tabs-4">
			<br/>
			<br/>
  <!-- 
 // *******************************************************************************************************************************
 // *********************************************** MONTLY RECIPTS REPORT FORM ***************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_MonthlyReceipt_Controller" method="post"  onSubmit="return validateGRNForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Monthly Receipt Report<br/></strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyGRN" style="font-size: 1.6ex;">
 				<option value=""> - - - - - Select - - - - -</option> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthGRN" style="font-size: 1.6ex;">
 		<option value=""> - - - - - Select - - - - -</option> 
 		<% 
 		String[] monthgrn = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String mmname = monthgrn[i]; 
 		%>
 			<option value="<%=i+1%>"><%=mmname %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearGRN" style="font-size: 1.6ex;">
 		<option value=""> - - - - - Select - - - - -</option>
 		<%
 		int yearGrn = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = yearGrn; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDGRN" value="Get Production Report" style="background-color: #BABABA;width: 255px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageGRN" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 	
	<!-- 
 // *******************************************************************************************************************************
  -->	 			 
		</div>
		
		<div id="tabs-6">
			<br/>
			<br/>
  <!-- 
 // *******************************************************************************************************************************
 // *********************************************** MONTHLY CASTING REJECTION REPORT FORM ***************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_CastingRejection_Controller" method="post"  onSubmit="return validateCastRejForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong style="font-size: 12px;">To Get Monthly Casting Rejection Report<br/></strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companycastRej" style="font-size: 1.6ex;">
 				<option value=""> - - - - - Select - - - - -</option> 
 				<option value="101">MEPL H21</option> 
 				<option value="102">MEPL H25</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthcastRej" style="font-size: 1.6ex;">
 		<option value=""> - - - - - Select - - - - -</option> 
 		<% 
 		String[] monthcastRej = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String mmname = monthcastRej[i]; 
 		%>
 			<option value="<%=i+1%>"><%=mmname %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearcastRej" style="font-size: 1.6ex;">
 		<option value=""> - - - - - Select - - - - -</option>
 		<%
 		int yearcastRej = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = yearcastRej; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDcastRej" value="Get Production Report" style="background-color: #BABABA;width: 255px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImagecastRej" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 	
	<!-- 
 // *******************************************************************************************************************************
  -->	 			 
		</div>		
		--%>
	</div>
	<%
}catch(Exception e){
	e.printStackTrace();
}
	%>
	<br/>
		<marquee behavior="alternate"><strong style="font-size: 16px; color: #38314A;font-family: Arial;">MIS OF MUTHA GROUP OF FOUNDRIES</strong></marquee>
</body>
</html>