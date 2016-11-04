<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
<title>Foundry MIS HOME</title>
<link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
	});
	
	$(document).ready(
			  function () {
			    $( "#frompotwise" ).datepicker({
			      changeMonth: true,
			      changeYear: true 
			    });
			    $( "#topotwise" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#onDate_ots" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#onDate_MIS" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#DetailedFromDate_DetailedMIS" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#DetailedToDate_DetailedMIS" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#FromDate_ICS" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#ToDate_ICS" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });
			    $( "#custdPlanDate" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });     
			    $( "#FromDate_Exbr" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    }); 
			    $( "#ToDate_Exbr" ).datepicker({
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
			    $( "#FromDate_IntR" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				});
			    $( "#ToDate_IntR" ).datepicker({
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
		window.location = "MachineShop_Home.jsp";
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
	
</script>
<script type="text/javascript">
	function ClearList2(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function movedata(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('track_userlist');
			attribute2 = document.getElementById('selected_users');
		} else {
			attribute2 = document.getElementById('track_userlist');
			attribute1 = document.getElementById('selected_users');
		}

		//fill an array with old values
		for ( var i = 0; i < attribute2.length; i++) {
			temp1[current1++] = attribute2.options[i].value;
		}

		//assign new values to arrays
		for ( var i = 0; i < attribute1.length; i++) {
			if (attribute1.options[i].selected) {
				temp1[current1++] = attribute1.options[i].value;
			} else {
				temp2[current2++] = attribute1.options[i].value;
			}
		}

		//generating new options 
		for ( var i = 0; i < temp1.length; i++) {
			attribute2.options[i] = new Option();
			attribute2.options[i].value = temp1[i];
			attribute2.options[i].text = temp1[i];
			attribute2.options[i].selected = "selected";
		}

		//generating new options
		ClearList2(attribute1, attribute1);
		if (temp2.length > 0) {
			for ( var i = 0; i < temp2.length; i++) {
				attribute1.options[i] = new Option();
				attribute1.options[i].value = temp2[i];
				attribute1.options[i].text = temp2[i];
				attribute1.options[i].text = temp2[i];
			}
		}
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


function validatedPartPorderForm() {           
	var company = document.getElementById("companyporder");
	var sup_order = document.getElementById("sup_order");
	var date_frompurorder = document.getElementById("date_frompurorder");
	var date_topurorder = document.getElementById("date_topurorder");
 	
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
function validateCatoutForm(){       
		document.getElementById("ADDots").disabled = true;
		document.getElementById("waitImageots").style.visibility = "visible";		
		return true;
}


function validateForm() {
	var company = document.getElementById("company");
	var month = document.getElementById("month");
	var year = document.getElementById("year");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADD").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADD").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
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
function validateMouldForm() {
	var company = document.getElementById("companyMould");
	var month = document.getElementById("monthMould");
	var year = document.getElementById("yearMould");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDMould").disabled = false;
			document.getElementById("waitImageMould").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDMould").disabled = false;
			document.getElementById("waitImageMould").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDMould").disabled = false;
			document.getElementById("waitImageMould").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDMould").disabled = true;
		document.getElementById("waitImageMould").style.visibility = "visible";
		
		return true;
}		
</script>
<script type="text/javascript">
function validatepotwiseForm() {
	var company = document.getElementById("companypotwise");
	var frompotwise = document.getElementById("frompotwise");             
	var topotwise = document.getElementById("topotwise"); 
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDpotwise").disabled = false;
			document.getElementById("waitImagepotwise").style.visibility = "hidden";
			return false;
		}
		if (frompotwise.value=="0" || frompotwise.value==null || frompotwise.value=="" || frompotwise.value=="null") {
			alert("Please Provide Date From !!!"); 
			document.getElementById("ADDpotwise").disabled = false;
			document.getElementById("waitImagepotwise").style.visibility = "hidden";
			return false;
		}
		if (topotwise.value=="0" || topotwise.value==null || topotwise.value=="" || topotwise.value=="null") {
			alert("Please Provide To Date !!!"); 
			document.getElementById("ADDpotwise").disabled = false;
			document.getElementById("waitImagepotwise").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDpotwise").disabled = true;
		document.getElementById("waitImagepotwise").style.visibility = "visible";
		
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
function validateProd_vsRejForm() {
	var company = document.getElementById("companyDetailedMIS");
	var grade = document.getElementById("GradeDetailedMIS"); 
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADD_DetailedMIS").disabled = false;
			document.getElementById("LoadingDetailedMIS").style.visibility = "hidden";
			return false;
		}
		if (grade.value=="0" || grade.value==null || grade.value=="" || grade.value=="null") {
			alert("Please Select Grade !!!"); 
			document.getElementById("ADD_DetailedMIS").disabled = false;
			document.getElementById("LoadingDetailedMIS").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("ADD_DetailedMIS").disabled = true;
		document.getElementById("LoadingDetailedMIS").style.visibility = "visible";
		
		return true;
}		
</script>
<script type="text/javascript">
function validateIHRForm() {
	var company = document.getElementById("companyIHR");
	var month = document.getElementById("monthIHR");
	var year = document.getElementById("yearIHR");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDIHR").disabled = false;
			document.getElementById("waitImageIHR").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDIHR").disabled = false;
			document.getElementById("waitImageIHR").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDIHR").disabled = false;
			document.getElementById("waitImageIHR").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDIHR").disabled = true;
		document.getElementById("waitImageIHR").style.visibility = "visible";
		
		return true;
}		
</script> 
<script type="text/javascript">
function validateCRForm() {
	var company = document.getElementById("companyCR");
	var month = document.getElementById("monthCR");
	var year = document.getElementById("yearCR");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDCR").disabled = false;
			document.getElementById("waitImageCR").style.visibility = "hidden";
			return false;
		}
		if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
			alert("Please Select Month !!!"); 
			document.getElementById("ADDCR").disabled = false;
			document.getElementById("waitImageCR").style.visibility = "hidden";
			return false;
		}
		if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
			alert("Please Select Year !!!"); 
			document.getElementById("ADDCR").disabled = false;
			document.getElementById("waitImageCR").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDCR").disabled = true;
		document.getElementById("waitImageCR").style.visibility = "visible";
		
		return true;
}		
</script> 
<script type="text/javascript">
function validateMISForm() {
	var company = document.getElementById("companyMIS");
	var onDate_MIS = document.getElementById("onDate_MIS");       
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("ADDMIS").disabled = false;
			document.getElementById("waitImageMIS").style.visibility = "hidden";
			return false;
		}
		if (onDate_MIS.value=="0" || onDate_MIS.value==null || onDate_MIS.value=="" || onDate_MIS.value=="null") {
			alert("Please Select On Date !!!"); 
			document.getElementById("ADDMIS").disabled = false;
			document.getElementById("waitImageMIS").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("ADDMIS").disabled = true;
		document.getElementById("waitImageMIS").style.visibility = "visible";
		
		return true;
}		
</script>
<script type="text/javascript">
function validateMIS_ICS() {      
	var FromDate_ICS = document.getElementById("FromDate_ICS");
	var ToDate_ICS = document.getElementById("ToDate_ICS");       
	 
		if (FromDate_ICS.value=="0" || FromDate_ICS.value==null || FromDate_ICS.value=="" || FromDate_ICS.value=="null") {
			alert("Please Select From Date !!!"); 
			document.getElementById("ADD_ICS").disabled = false;
			document.getElementById("waitImage_ICS").style.visibility = "hidden";
			return false;
		}
		if (ToDate_ICS.value=="0" || ToDate_ICS.value==null || ToDate_ICS.value=="" || ToDate_ICS.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADD_ICS").disabled = false;
			document.getElementById("waitImage_ICS").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("ADD_ICS").disabled = true;
		document.getElementById("waitImage_ICS").style.visibility = "visible";
		
		return true;
}	


function validateMIS_WOWEB() {  
	var FromDate_ICS = document.getElementById("FromDate_Exbr");
	var ToDate_ICS = document.getElementById("ToDate_Exbr");       
	 
		if (FromDate_ICS.value=="0" || FromDate_ICS.value==null || FromDate_ICS.value=="" || FromDate_ICS.value=="null") {
			alert("Please Select From Date !!!"); 
			document.getElementById("ADD_Exbr").disabled = false;
			document.getElementById("waitImage_Exbr").style.visibility = "hidden";
			return false;
		}
		if (ToDate_ICS.value=="0" || ToDate_ICS.value==null || ToDate_ICS.value=="" || ToDate_ICS.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADD_Exbr").disabled = false;
			document.getElementById("waitImage_Exbr").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("ADD_Exbr").disabled = true;
		document.getElementById("waitImage_Exbr").style.visibility = "visible";		
		return true;
}	

function validateMIS_INR() {
	var FromDate_ICS = document.getElementById("FromDate_IntR");
	var ToDate_ICS = document.getElementById("ToDate_IntR");       
	 
		if (FromDate_ICS.value=="0" || FromDate_ICS.value==null || FromDate_ICS.value=="" || FromDate_ICS.value=="null") {
			alert("Please Select From Date !!!"); 
			document.getElementById("ADD_IntR").disabled = false;
			document.getElementById("waitImage_IntR").style.visibility = "hidden";
			return false;
		}
		if (ToDate_ICS.value=="0" || ToDate_ICS.value==null || ToDate_ICS.value=="" || ToDate_ICS.value=="null") {
			alert("Please Select To Date !!!"); 
			document.getElementById("ADD_IntR").disabled = false;
			document.getElementById("waitImage_IntR").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("ADD_IntR").disabled = true;
		document.getElementById("waitImage_IntR").style.visibility = "visible";		
		return true;
}	

function validateCashBook() {
		document.getElementById("ADD_cashbook").disabled = true;
		document.getElementById("waitImage_cashbook").style.visibility = "visible";		
		return true;
}

function validateBillWisePurchase() {
	document.getElementById("ADDbillwisepurchase").disabled = true;
	document.getElementById("waitImagebillwisepurchase").style.visibility = "visible";		
	return true;
}

function validateNewItemCreation() {
	document.getElementById("ADDnewERPItem").disabled = true;
	document.getElementById("waitnewERPItem").style.visibility = "visible";		
	return true;
}

function validateMRMEntries() {
	document.getElementById("ADDBudAdd").disabled = true;
	document.getElementById("waitImageBudAdd").style.visibility = "visible";		
	return true;
}

function validateMRMOP() {
	document.getElementById("ADDMRMOP").disabled = true;
	document.getElementById("waitImageMRMOP").style.visibility = "visible";		
	return true;
}

function validateSoftUsage() {			 
	var selected_users = document.getElementById("selected_users");
	var year = document.getElementById("year");     
	var month = document.getElementById("month");     
	 
	
	if (month.value=="0" || month.value==null || month.value=="" || month.value=="null") {
		alert("Please Select month !!!"); 
		document.getElementById("ADD_usage").disabled = false;
		document.getElementById("waitImage_usage").style.visibility = "hidden";
		return false;
	} 
	if (year.value=="0" || year.value==null || year.value=="" || year.value=="null") {
		alert("Please Select year !!!"); 
		document.getElementById("ADD_usage").disabled = false;
		document.getElementById("waitImage_usage").style.visibility = "hidden";
		return false;
	} 
	
		if (selected_users.value=="0" || selected_users.value==null || selected_users.value=="" || selected_users.value=="null") {
			alert("Please Select Users !!!"); 
			document.getElementById("ADD_usage").disabled = false;
			document.getElementById("waitImage_usage").style.visibility = "hidden";
			return false;
		}
		
		document.getElementById("ADD_usage").disabled = true;
		document.getElementById("waitImage_usage").style.visibility = "visible";		
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
<div style="width: 100%">
<a href="Logout.jsp" style="text-decoration: none;color: #110966;background-color: #F0F0AF;font-family: Arial;font-size: 12px;"><b>LogOut ( <%=uname %> )</b></a> 
</div>
<div align="left" style="float: left;width: 20%">
<br><input type="button" value="Machine Shop MIS System" onclick="navigateToMIS('window', false);" style="width: 200px;height: 40px;">
</div>
<div align="center" style="float:left; width: 55%"> 
<img src="images/foundry.png"><br/> 
<strong style="font-size: 12px;font-family:Arial; color: blue;">MUTHA GROUP OF FOUNDRIES</strong><br/> 
</div> 
<div align="center" style="float: left;width: 24%;">
<img src="images/MUTHA LOGO.JPG"><br><b style="font-size: 14px;font-family: Arial;color: blue;">Mutha Group Of Industries Satara</b>
</div>
<br/>
<br/> 
<br/>
<br/>
<br/> 
<br/>  
<%
//-------------------------------------------------------- Date Logic ---------------------------------------------------------

Calendar first_Datecal = Calendar.getInstance();   
first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
Date dddd = first_Datecal.getTime();  
SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
Date tdate = new Date();
 
String firstDate = sdfFIrstDate.format(dddd);
String nowDate = sdfFIrstDate.format(tdate);

	String[] months = new DateFormatSymbols().getMonths(); 
	int getcalmn = Calendar.getInstance().get(Calendar.MONTH);
	String getcalName = months[Calendar.getInstance().get(Calendar.MONTH)];
//----------------------------------------------------------------------------------------------------------------------------- 
ArrayList reportList = new ArrayList();
PreparedStatement ps = con.prepareStatement("select * from  mis_access_tbl  where  u_id =" + uid + " and mis_type_id=2 and Enable_Id=1");
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
		if(reportList.contains("Daily Production Report")){
		%>
			<li><a href="#tabs-1">Daily Prod.</a></li>
		<% 
		}if(reportList.contains("Dispatch Report")){
		%> 
			<li><a href="#tabs-2">Dispatch</a></li>
		<% 
		}if(reportList.contains("In-House Rejection Report")){
		%> 	 
			<li><a href="#tabs-3">In house Rejection</a></li>
			<% 
		}if(reportList.contains("Dispatch Plan Vs Sale Report")){
		%> 			
			<li><a href="#tabs-4">Dispatch Plan Vs Sale</a></li>
			<% 
		}if(reportList.contains("Customer Rejection Report")){
		%> 
			<li><a href="#tabs-5">Customer Rejection</a></li>
			<% 
		}if(reportList.contains("Mould Receipt Report")){
		%>  
			<li><a href="#tabs-6">Mould Receipt</a></li>
			<% 
		}if(reportList.contains("Production Vs. Rejection Report")){
		%>   
			<li><a href="#tabs-7">Production Vs Rejection</a></li>
			<% 
		}if(reportList.contains("Sister Company Sale Report")){
		%> 
			<li><a href="#tabs-8">Sister Company Sale</a></li>
			<% 
		}if(reportList.contains("POT Wise Production Report")){
		%> 
			<li><a href="#tabs-9">Pot wise Production</a></li>
			<% 
		}if(reportList.contains("Detailed MIS Report")){
		%> 
			<li><a href="#tabs-10">MIS Summary Details</a></li>
			<% 
		}if(reportList.contains("Category Wise Outstanding")){
		%> 
			<li><a href="#tabs-11">Category Wise Outstanding</a></li>
			<% 
		}if(reportList.contains("Work Order Wise Expected Boring Report")){
		%> 
			<li><a href="#tabs-12">Work Order wise expected boring</a></li>
		<% 
		}if(reportList.contains("Party Wise Purchase Order Report")){
		%>
			<li><a href="#tabs-13">Party Wise Purchase Order</a></li>
		<%
		}if(reportList.contains("Internal Rejection")){ 
		%> 	
			<li><a href="#tabs-15">Internal Rejection</a></li>
		<%
		}if(reportList.contains("In-house Software Usage")){ 
		%> 	
			<li><a href="#tabs-16">In-house Software Usage</a></li>
		<%
		}if(reportList.contains("CashBook Report")){
		%>
			<li><a href="#tabs-17">Cash Book Report</a></li> 
		<%
		}if(reportList.contains("MRM Operations")){
		%>
			<li><a href="#tabs-18">MRM Operations</a></li> 
		<%
		}if(reportList.contains("Bill Wise Purchase Details")){
		%>
				<li><a href="#tabs-19">Bill Wise Purchase Details</a></li> 
		<% 
		}if(reportList.contains("ERP New Item Creation")){
		%>
				<li><a href="#tabs-20">ERP New Item Creation</a></li> 
		<%
		}if(reportList.size()==0){
		%>
			<li><a href="#tabs-21">Work In Progress</a></li>
		<%
		}
		%>
		</ul>		
		<%
		if(reportList.contains("Daily Production Report")){
		%>
		<div id="tabs-1" align="left">
			<br/>
			<br/>
 <form action="Get_Daily_Prod_Controller" method="post"  onSubmit="return validateForm();">
 <!-- 
 // *******************************************************************************************************************************
 // ********************************************* Daily PRODUCTION REPORT FORM ****************************************************
 // *******************************************************************************************************************************
  -->
	<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong>To Get Daily Production Report<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="company">
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="month"> 
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<%
 		for (int i = 0; i < 12; i++) {
	   	String month = months[i]; 
 		%> 
		<option value="<%=i+1%>"><%=month %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="year"> 
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
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD" value="Get Daily Production Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
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
			}if(reportList.contains("Dispatch Report")){
		%>
		<div id="tabs-2">
			<br/>
			<br/>
		<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Dispatch Report REPORT FORM ***************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_Dispatch_Controller" method="post"  onSubmit="return validateDispForm();">
			<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong>To Get Dispatch Report<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyDisp">
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthDisp">
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] mm = new DateFormatSymbols().getMonths(); 
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
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDDisp" value="Get Dispatch Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
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
			}if(reportList.contains("In-House Rejection Report")){
		%> 
		<div id="tabs-3">
			<br/><br/>
				<!-- 
 // *******************************************************************************************************************************
 // *********************************************** In House Rejection FORM *******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_IHR_Controller" method="post"  onSubmit="return validateIHRForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get In-House Rejection Report<br/> </strong> <br/>
				 </td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyIHR">
 				 	<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthIHR">
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] mn = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String mmnam = mn[i]; 
 		%>
 			<option value="<%=i+1%>"><%=mmnam %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearIHR"> 
 		<%

 		int calyr = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = calyr; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 
			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDIHR" value="Get In House Rejection Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageIHR" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
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
				 <td colspan="2"><strong>To Get Dispatch Plan Vs Sale Report<br/> </strong> <br/>
				 </td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companydPlan" onchange="getAllCustomers(this.value)">
				<option value="">- - - - Select - - - - </option>
 			 	<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
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
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDdPlan" value="Get Dispatch Plan Vs Sale Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
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
			}if(reportList.contains("Customer Rejection Report")){
		%>
		<div id="tabs-5">
			<br/><br/>
			<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Customer Rejection FORM *******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_CR_Controller" method="post"  onSubmit="return validateCRForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get Customer Rejection Report<br/> </strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyCR">  
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthCR"> 
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] crmn = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String mmnamcr = crmn[i]; 
 		%>
 			<option value="<%=i+1%>"><%=mmnamcr %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearCR"> 
 		<%

 		int calyrcr = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = calyrcr; x >= 2011; x = x-1) { 
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 
			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDCR" value="Get Customer Rejection Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageCR" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
	
	<!-- 
 // *******************************************************************************************************************************
  -->				 
		</div>		
		
		
		<%
			}if(reportList.contains("Mould Receipt Report")){
		%>
		<div id="tabs-6">
			<br/><br/>
				<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Mould Receipt FORM *******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_Mould_Controller" method="post"  onSubmit="return validateMouldForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get Mould Receipt Report<br/> </strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyMould"> 
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="monthMould">
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<% 
 		String[] monthmould = new DateFormatSymbols().getMonths(); 
 		for (int i = 0; i < 12; i++) {
	   	String mmmould = monthmould[i];
 		%>
 			<option value="<%=i+1%>"><%=mmmould %></option>
		 <% 
	 			}
 		 %>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearMould"> 
 		<%
 		int yrmould = Calendar.getInstance().get(Calendar.YEAR); 
 		for(int x = yrmould; x >= 2011; x = x-1) {
 			%>
 		<option value="<%=x%>"><%=x %></option>
 			<%
 			}
 			%>
 			</select> 
				 </td>
			</tr> 
			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDMould" value="Get Mould Receipt Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageMould" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
	
	<!-- 
 // *******************************************************************************************************************************
  -->	
			
		</div>
		
			
		
		
<%
			}if(reportList.contains("Production Vs. Rejection Report")){
		%>
		<div id="tabs-7">
			<br/><br/>
  <!-- 
 // *******************************************************************************************************************************
 // *********************************************** Detailed MIS FORM No 2 ******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_DetailedMIS_Summary_Controller" method="post"  onSubmit="return validateProd_vsRejForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get Production Vs. Rejection Report<br/> </strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyDetailedMIS"> 
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr>
			<tr>
				<td>Grade :</td> 
				<td> 
				<select name="misGrade" id="GradeDetailedMIS">
 				<option value="all">All</option>
 				<option value="101">SG Iron</option> 
 				<option value="102">Cast Iron</option>  
 				<option value="104">Aluminium</option>  
 			</select>
				 </td>
			</tr> 
			<tr>    
				<td>From Date :</td>     
				<td> <input type="text" name="DetailedFromDate_MIS" value="<%=sdfFIrstDate.format(dddd) %>" id="DetailedFromDate_DetailedMIS" readonly="readonly" />  
				 </td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="DetailedToDate_MIS" value="<%=sdfFIrstDate.format(tdate) %>" id="DetailedToDate_DetailedMIS" readonly="readonly"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD_DetailedMIS" value="Get Production Vs. Rejection Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="LoadingDetailedMIS" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
	
	<!-- 
 // *******************************************************************************************************************************
  -->	
		</div> 
		
		
		<%
			}if(reportList.contains("Sister Company Sale Report")){
		%>
		<div id="tabs-8">
		<form action="InterCompany_Sale.jsp" method="post"  onSubmit="return validateMIS_ICS();">
		<br/>
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get Sister Company Sale Report<br/> </strong> <br/>
			</td>
			</tr>  
			<tr>
				<td>From Date :</td>
				<td> <input type="text" name="FromDate_ICS" value="<%=sdfFIrstDate.format(dddd) %>" id="FromDate_ICS" readonly="readonly"/>  
				 </td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="ToDate_ICS" value="<%=sdfFIrstDate.format(tdate) %>" id="ToDate_ICS" readonly="readonly"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD_ICS" value="Get Inter Company Sale" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImage_ICS" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	  		
		</div>
	 
	 
	 <%
			}if(reportList.contains("POT Wise Production Report")){
		%>
	 <div id="tabs-9">
			<br/><br/>
			
	<!-- 
 // *******************************************************************************************************************************
 // *********************************************** POT Wise Production FORM ******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_PotWise_Controller" method="post"  onSubmit="return validatepotwiseForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get POT Wise Production Report<br/> </strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companypotwise"> 
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr>   
			<tr>
				<td>From Date :</td>
				<td> <input type="text" name="fromDate" id="frompotwise" readonly="readonly" value="<%=sdfFIrstDate.format(dddd) %>"/>  
				 </td>
			</tr> 
			<tr>
				<td>From To :</td>
				<td> <input type="text" name="toDate" id="topotwise" readonly="readonly" value="<%=sdfFIrstDate.format(tdate) %>"/>  
				 </td>
			</tr>   
			<tr> 
			<td colspan="2" align="left"><input type="submit" name="ADD" id="ADDpotwise" value="Get Customer Rejection Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImagepotwise" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
	
	<!-- 
 // *******************************************************************************************************************************
  -->	

		</div>
	 
	 <%
			}if(reportList.contains("Detailed MIS Report")){
		%>
		<div id="tabs-10">
			<br/><br/>
			<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Detailed MIS FORM ******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_DetailedMIS_Controller" method="post"  onSubmit="return validateMISForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get MIS Report<br/> </strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyMIS"> 
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>On Date :</td>
				<td> <input type="text" name="onDate_MIS" value="<%=sdfFIrstDate.format(tdate) %>" id="onDate_MIS" readonly="readonly"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="left"><input type="submit" name="ADD" id="ADDMIS" value="Get MIS Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImageMIS" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	 
	
	<!-- 
 // *******************************************************************************************************************************
  -->	
		</div>
		  
	 <%
			}if(reportList.contains("Category Wise Outstanding")){
		%>
		<div id="tabs-11">
		 		<br/><br/>
			<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Category Wise Outstanding  ******************************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_CatWiseOut_Controller" method="post"  onSubmit="return validateCatoutForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get Category Wise Outstanding<br/> </strong> <br/>
			</td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyots"> 
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>On Date :</td>
				<td> <input type="text" name="onDate_ots" value="<%=sdfFIrstDate.format(tdate) %>" id="onDate_ots" readonly="readonly"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="left"><input type="submit" name="ADD" id="ADDots" value="Get Category Wise Outstanding" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImageots" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>						 
		</table>
	</form>
		</div>		
		<%
			}if(reportList.contains("Work Order Wise Expected Boring Report")){
		%>
		<div id="tabs-12">
				<form action="WorkOdrWSExpected_Boring_Controller" method="post"  onSubmit="return validateMIS_WOWEB();">
		<br/>
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Get Work Order Wise Expected Boring Report<br/> </strong> <br/>
			</td>
			</tr>  
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyExbr"> 
 				<option value="103">MFPL</option> 
 				<!-- <option value="105">DI</option>  -->
 				<!-- <option value="106">MEPL Unit III</option> -->  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>From Date :</td>
				<td> <input type="text" name="FromDate_Exbr" value="<%=sdfFIrstDate.format(dddd) %>" id="FromDate_Exbr" readonly="readonly" style="font-size: 10px; width: 200px;"/>  
				 </td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="ToDate_Exbr" value="<%=sdfFIrstDate.format(tdate) %>" id="ToDate_Exbr" readonly="readonly" style="font-size: 10px;width: 200px;"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD_Exbr" value="Get Work Order Wise Expected Boring" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImage_Exbr" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>	
		</div>
		
		
		<%
			}if(reportList.contains("Party Wise Purchase Order Report")){
		%>
		<div id="tabs-13">
		<br/><br/>
				<!-- 
 // *******************************************************************************************************************************
 // *********************************************** Party Wise Purchase Order Report **************************************
 // *******************************************************************************************************************************
  -->		
  <form action="Get_PartywsPurOrder_Controller" method="post"  onSubmit="return validatedPartPorderForm();">
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>Party Wise Purchase Order Report<br/> </strong> <br/>
				 </td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyporder" onchange="getAllSupplier(this.value)">
 				<option value=""> - - - - - Select - - - - -</option>
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>    
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
				 <span id="waitsup" style="visibility: hidden;"><strong style="color: blue; font-family: Arial;font-size: 12px;">Please Wait.....</strong></span>
				  </span>
				 
				 </td> 
			</tr>
			<tr>    
				<td>From Date :</td>     
				<td> <input type="text" name="date_frompurorder" value="<%=sdfFIrstDate.format(dddd) %>" id="date_frompurorder" readonly="readonly" style="font-size: 10px;width: 200px;"/>  
				 </td>
			</tr>
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="date_topurorder" value="<%=sdfFIrstDate.format(tdate) %>" id="date_topurorder" readonly="readonly" style="font-size: 10px;width: 200px;"/>  
				</td>
			</tr>  
  			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDp_order" value="Get Party Wise Purchase Order Report" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
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
			}if(reportList.contains("Internal Rejection")){
		%>
		<div id="tabs-15">
			<form action="InternalRejection_Controller" method="post"  onSubmit="return validateMIS_INR();">
		<br/>
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>Internal Rejection<br/> </strong> <br/>
			</td>
			</tr>  
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyIntR"> 
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>From Date :</td>
				<td> <input type="text" name="FromDate_IntR" value="<%=sdfFIrstDate.format(dddd) %>" id="FromDate_IntR" readonly="readonly" style="font-size: 10px;width: 200px;"/>  
				 </td>
			</tr> 
			<tr>
				<td>To Date :</td>
				<td> <input type="text" name="ToDate_IntR" value="<%=sdfFIrstDate.format(tdate) %>" id="ToDate_IntR" readonly="readonly" style="font-size: 10px;width: 200px;"/>  
				 </td>
			</tr>  
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD_IntR" value="Get Internal Rejection" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitImage_IntR" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>
		</div>
		<%
			}if(reportList.contains("In-house Software Usage")){
		%>
		 <div id="tabs-16">
			<form action="SoftwareUsage_Controller" method="post"  onSubmit="return validateSoftUsage();">
		<br/>
			<table class="tftable" style="border: 0px;">
				<tr>
				<td colspan="3"><b>TO GET IN-HOUSE SOFTWARE USAGES &#8658;</b></td>
			</tr>
			<tr>
				<td colspan="3"><b>Select Month :</b>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<select name="month" id="month"> 
 						<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 						<%
 								for (int i = 0; i < 12; i++) {
							   	String month = months[i]; 
 						%> 
						<option value="<%=i+1%>"><%=month %></option>
		 				<% 
	 						}
 						%>  
					 </select> 
				 </td>
			</tr> 
			<tr>
				<td colspan="3"><b>Select Year :</b> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="year" id="year"> 
 					<%

 					int year = Calendar.getInstance().get(Calendar.YEAR); 
 					for(int x = year; x >= 2013; x = x-1) { 
 					%>
 				<option value="<%=x%>"><%=x %></option>
 				<%
 					}
 				%>
 				</select> 
				 </td>
			</tr> 
			
			
		
							<tr>

								<td colspan="1"><b>Mutha Group Users List</b></td>
								<td></td>
								<td colspan="1"><b>Selected Users</b></td>
							</tr>
							<tr>
								<td colspan="1" align="left"><select id="track_userlist"
									name="track_userlist" multiple="multiple" size="8"
									style="width: 210px;font-family: Arial;font-size: 14px;background-color: #FDFFEB;" title="Mutha Group Users List"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
										<%
											PreparedStatement ps_users = con.prepareStatement("select distinct(u_name) from user_tbl where enable_id=1 order by u_name");
											ResultSet rs_users = ps_users.executeQuery();
											while (rs_users.next()) {
										%>
										<option value="<%=rs_users.getString("u_name")%>"><%=rs_users.getString("u_name")%></option>
										<%
											}
											ps_users.close();
											rs_users.close();
										%>
								</select></td>
								<td style="width: 50px;" align="center" align="center">
								<input value="    &gt;&gt;&gt;&gt;    " onclick="movedata('right', 'rep')"
									type="button" style="background-color: #A1E3AA;" title="Click to Select Users"><br><br> <input value="    &lt;&lt;&lt;&lt;    "
									onclick="movedata('left', 'rep')" type="button" style="background-color: #E8A5B4;" title="Click to Remove Selected Users"></td>
								<td colspan="1" align="right"><select
									id="selected_users" name="selected_users"
									multiple="multiple" size="8" style="width: 210px;font-family: Arial;font-size: 14px;background-color: #FDFFEB;"
									title="Selected Users"
									onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
									onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></select></td>
							</tr>
			
				   
			<tr> 
			<td colspan="3" align="center"><input type="submit" name="ADD" id="ADD_usage" value="Get Software usages for selected users" style="background-color: #BABABA;width: 285px;height: 35px;"/> </td>			
			</tr>
			<tr> 
			<td colspan="3" align="left"><span id="waitImage_usage" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>
		</div>
		<%		
			}if(reportList.contains("CashBook Report")){
		%>
			<div id="tabs-17">
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
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
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
			}if(reportList.contains("MRM Operations")){
		%>
			<div id="tabs-18" style="padding-left: 10px;padding-right: 10px;">
			
	<div style="float: left;width: 40%">
			
	<form action="MRMOperation_Controller" method="post"  onSubmit="return validateMRMOP();">
		<br/>
				<table class="tftable" style="border: 0px;">
		<tr>
				<td colspan="2"><strong>To Get MRM Operations Report<br/> </strong> <br/>
				 </td>
			</tr> 
			<tr>
				<td>Select Company :</td>
				<td> 
				<select name="company" id="companyMRMOP">
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr> 
			<tr>
				<td>Select Month :</td>
				<td>
		<select name="month" id="month_MRMOP"> 
 		<option value="<%=getcalmn+1%>"><%=getcalName%></option>
 		<%
 		for (int i = 0; i < 12; i++) {
	   	String month = months[i]; 
 		%> 
		<option value="<%=i+1%>"><%=month %></option>
		 <% 
	 			}
 		%>  
			 </select> 
				 </td>
			</tr> 
			<tr>
				<td>Select Year :</td>
				<td>
				<select name="year" id="yearMRMOP"> 
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
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDMRMOP" value="Get MRM Operations Report" style="background-color: #BABABA;width: 285px;height: 35px;font-weight: bold;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><span id="waitImageMRMOP" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>

	</form>
 	</div>
 		
 	<div style="float: right;width: 40%;">
 	
 	<form action="MRMOperation_Entries" method="post"  onSubmit="return validateMRMEntries();">
 	<br>
		<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>For MRM Operations Budget Entry &#8658;<br/> </strong> <br/></td>
			</tr>
			<tr>
				<td>Select Company :</td>
				<td>
				<select name="company" id="companyMRMOP">
 				<option value="103">MFPL</option> 
 				<option value="105">DI</option>
 				<option value="106">MEPL Unit III</option>  
 			</select>
				 </td>
			</tr>			
		<tr>
			<td>Select Year :</td>
			<td>
			<select name="year" id="yearMRMOP">
 			<%
 			String fyear="",fyearpass="";
 			for(int x = year; x >= year-1; x = x-1) {
 				fyear = x + "-" + (Integer.parseInt(String.valueOf(x).substring(String.valueOf(x).length()-2))+1);
 				fyearpass = String.valueOf(Integer.parseInt(String.valueOf(x))+1);
 			%>
 				<option value="<%=fyearpass%>"><%= fyear%></option>
 			<%
 				}
 			%>
 			</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDBudAdd" value="Budget Entry" style="background-color: #BABABA;width: 285px;height: 35px;font-weight: bold;"/> </td>
		</tr>
		<tr>
			<td colspan="2" align="center"><span id="waitImageBudAdd" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
		</tr>		 
		</table>
 	</form>
	</div>
	</div>
		<%	
			}if(reportList.contains("Bill Wise Purchase Details")){
		%>
			<div id="tabs-19">
			
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
 				<option value="103">MFPL</option>
 				<option value="105">DI</option> 
 				<option value="106">MEPL Unit III</option>  
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
			}if(reportList.contains("ERP New Item Creation")){
		%>
			<div id="tabs-20">
			
			<form action="ItemCreate_Controller" method="post" onSubmit="return validateNewItemCreation();">
			<br/>
			<table class="tftable" style="border: 0px;">
			<tr>
				<td colspan="2"><strong>To Create New Item in ERP<br/></strong> <br/>
			</td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADDnewERPItem" value="Click Here" style="background-color: #BABABA;font-weight:bold; width: 85px;height: 35px;"/> </td>
			</tr>
			<tr> 
			<td colspan="2" align="left"><span id="waitnewERPItem" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span> </td>
			</tr>
						 
		</table>
	</form>
			
			</div>
		<%
			}if(reportList.size()==0){
		%>
			<div id="tabs-21">
			<img alt="images/underconst.jpg" src="images/underconst.jpg"> 		
			</div>
		<%
			}
		%>	
	</div>	
		
	<%
}catch(Exception e){
	e.printStackTrace();
}
	%>
	<br><br> <br> <br> <br> <br> <br> <br> <br> <br>  <br> <br> <br> <br> <br> <br> 
		<marquee behavior="alternate"><strong style="font-size: 16px;font-family: Arial; color: #38314A;">MIS OF MUTHA GROUP OF FOUNDRIES</strong></marquee>
</body>
</html>