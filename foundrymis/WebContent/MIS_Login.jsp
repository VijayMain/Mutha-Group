<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<head>
<title>Login To MIS</title>
<link rel="stylesheet" href="js/jquery-ui.css">
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<script> 
	$(document).ready(function() {
		$("#fromdate").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#onDate_ots").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#todate").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#custdPlanDate").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_fromrm").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_torm").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_fromb").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_tob").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_frompurorder").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_topurorder").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#todate_amend").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#fromdate_amend").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_fromVBR").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#date_toVBR").datepicker({
			changeMonth : true,
			changeYear : true
		});
	});
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
</script>
<style type="text/css">
.tftable { 
	color: #333333;
	width: 40%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th { 
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: left;
}

.tftable tr {
	background-color: #ffffff;
}

.tftable td { 
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
}

.tftable tr:hover {
	background-color: #ffff99;
}
</style>
<script type="text/javascript">
	function validatedPlanForm() {
		var company = document.getElementById("companydPlan");
		var custdPlan = document.getElementById("custdPlan");

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDdPlan").disabled = false;
			document.getElementById("waitImagedPlan").style.visibility = "hidden";
			return false;
		}
		if (custdPlan.value == "0" || custdPlan.value == null
				|| custdPlan.value == "" || custdPlan.value == "null") {
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

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADD").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		}
		if (fromdate.value == "0" || fromdate.value == null
				|| fromdate.value == "" || fromdate.value == "null") {
			alert("Please Select Date From !!!");
			document.getElementById("ADD").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		}
		if (todate.value == "0" || todate.value == null || todate.value == ""
				|| todate.value == "null") {
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

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDDisp").disabled = false;
			document.getElementById("waitImageDisp").style.visibility = "hidden";
			return false;
		}
		if (month.value == "0" || month.value == null || month.value == ""
				|| month.value == "null") {
			alert("Please Select Month !!!");
			document.getElementById("ADDDisp").disabled = false;
			document.getElementById("waitImageDisp").style.visibility = "hidden";
			return false;
		}
		if (year.value == "0" || year.value == null || year.value == ""
				|| year.value == "null") {
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

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDProd").disabled = false;
			document.getElementById("waitImageProd").style.visibility = "hidden";
			return false;
		}
		if (month.value == "0" || month.value == null || month.value == ""
				|| month.value == "null") {
			alert("Please Select Month !!!");
			document.getElementById("ADDProd").disabled = false;
			document.getElementById("waitImageProd").style.visibility = "hidden";
			return false;
		}
		if (year.value == "0" || year.value == null || year.value == ""
				|| year.value == "null") {
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

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDGRN").disabled = false;
			document.getElementById("waitImageGRN").style.visibility = "hidden";
			return false;
		}
		if (month.value == "0" || month.value == null || month.value == ""
				|| month.value == "null") {
			alert("Please Select Month !!!");
			document.getElementById("ADDGRN").disabled = false;
			document.getElementById("waitImageGRN").style.visibility = "hidden";
			return false;
		}
		if (year.value == "0" || year.value == null || year.value == ""
				|| year.value == "null") {
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
		document.getElementById("waitImageb").style.visibility = "visible";

		return true;
	}
</script>
<script type="text/javascript">
	function validateMacRejForm() {
		var company = document.getElementById("companymacRej");
		var month = document.getElementById("monthmacRej");
		var year = document.getElementById("yearmacRej");

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDmacRej").disabled = false;
			document.getElementById("waitImagemacRej").style.visibility = "hidden";
			return false;
		}
		if (month.value == "0" || month.value == null || month.value == ""
				|| month.value == "null") {
			alert("Please Select Month !!!");
			document.getElementById("ADDmacRej").disabled = false;
			document.getElementById("waitImagemacRej").style.visibility = "hidden";
			return false;
		}
		if (year.value == "0" || year.value == null || year.value == ""
				|| year.value == "null") {
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

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		if (sup_order.value == "0" || sup_order.value == null
				|| sup_order.value == "" || sup_order.value == "null") {
			alert("Please Select Supplier !!!");
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		if (date_frompurorder.value == "0" || date_frompurorder.value == null
				|| date_frompurorder.value == ""
				|| date_frompurorder.value == "null") {
			alert("Please Select From Date !!!");
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		if (date_topurorder.value == "0" || date_topurorder.value == null
				|| date_topurorder.value == ""
				|| date_topurorder.value == "null") {
			alert("Please Select To Date !!!");
			document.getElementById("ADDp_order").disabled = false;
			document.getElementById("waitImagep_order").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDp_order").disabled = true;
		document.getElementById("waitImagep_order").style.visibility = "visible";

		return true;
	}

	function validVBR_Form() {
		var company = document.getElementById("companyVBR");
		var sup_order = document.getElementById("supVBR");
		var date_frompurorder = document.getElementById("date_fromVBR");
		var date_topurorder = document.getElementById("date_toVBR");

		// companyporder   sup_order   date_frompurorder   date_topurorder   ADDp_order   waitImagep_order

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDVBR").disabled = false;
			document.getElementById("waitImageVBR").style.visibility = "hidden";
			return false;
		}
		if (sup_order.value == "0" || sup_order.value == null
				|| sup_order.value == "" || sup_order.value == "null") {
			alert("Please Select Supplier !!!");
			document.getElementById("ADDVBR").disabled = false;
			document.getElementById("waitImageVBR").style.visibility = "hidden";
			return false;
		}
		if (date_frompurorder.value == "0" || date_frompurorder.value == null
				|| date_frompurorder.value == ""
				|| date_frompurorder.value == "null") {
			alert("Please Select From Date !!!");
			document.getElementById("ADDVBR").disabled = false;
			document.getElementById("waitImageVBR").style.visibility = "hidden";
			return false;
		}
		if (date_topurorder.value == "0" || date_topurorder.value == null
				|| date_topurorder.value == ""
				|| date_topurorder.value == "null") {
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

		if (company.value == "0" || company.value == null
				|| company.value == "" || company.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADDcastRej").disabled = false;
			document.getElementById("waitImagecastRej").style.visibility = "hidden";
			return false;
		}
		if (month.value == "0" || month.value == null || month.value == ""
				|| month.value == "null") {
			alert("Please Select Month !!!");
			document.getElementById("ADDcastRej").disabled = false;
			document.getElementById("waitImagecastRej").style.visibility = "hidden";
			return false;
		}
		if (year.value == "0" || year.value == null || year.value == ""
				|| year.value == "null") {
			alert("Please Select Year !!!");
			document.getElementById("ADDcastRej").disabled = false;
			document.getElementById("waitImagecastRej").style.visibility = "hidden";
			return false;
		}
		document.getElementById("ADDcastRej").disabled = true;
		document.getElementById("waitImagecastRej").style.visibility = "visible";

		return true;
	}

	function validateCatoutForm() {
		document.getElementById("ADDots").disabled = true;
		document.getElementById("waitImageots").style.visibility = "visible";
		return true;
	}
</script>
<script type="text/javascript">
	function validat_rmcomsume() {
		var companyrm = document.getElementById("companyrm");

		if (companyrm.value == "0" || companyrm.value == null
				|| companyrm.value == "" || companyrm.value == "null") {
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

		if (company_amend.value == "0" || company_amend.value == null
				|| company_amend.value == "" || company_amend.value == "null") {
			alert("Please Select Company !!!");
			document.getElementById("ADD_amend").disabled = false;
			document.getElementById("waitImage_amend").style.visibility = "hidden";
			return false;
		}
		if (fromdate_amend.value == "0" || fromdate_amend.value == null
				|| fromdate_amend.value == "" || fromdate_amend.value == "null") {
			alert("Please Select From Date !!!");
			document.getElementById("ADD_amend").disabled = false;
			document.getElementById("waitImage_amend").style.visibility = "hidden";
			return false;
		}
		if (todate_amend.value == "0" || todate_amend.value == null
				|| todate_amend.value == "" || todate_amend.value == "null") {
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
<script type="text/javascript">
	function navigateToHP(target, newWindow) {
		var url = 'http://192.168.0.7/homepage/';
		if (newWindow) {
			window.open(url, target, '--- attributes here, see below ---');
		} else {
			window[target].location.href = url;
		}
	}
</script>
</head>
<body style="font-family: Arial;"> 
	<div align="left" style="float: left; width: 20%"> 
	<input type="button" style="width: 200px; height: 35px;" value="HOMEPAGE" onclick="navigateToHP('window', false);"><br>
	</div>
	<div align="center" style="float: left; width: 55%">
		<img src="images/MIS_Login.png"><br /> <strong style="font-size: 15px; font-family: Arial; color: blue;">MUTHA GROUP OF FOUNDRIES</strong><br />
	</div>
	<div align="center" style="float: left; width: 24%;">
		<img src="images/MUTHA LOGO.JPG"><br>
		<b style="font-size: 16px; font-family: Arial; color: blue;">Mutha Group Satara</b>
	</div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<%
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");
		Date tdate = new Date();
		//-------------------------------------------------------- Date Logic ---------------------------------------------------------

		Calendar first_Datecal = Calendar.getInstance();
		first_Datecal.set(Calendar.DAY_OF_MONTH, 1);
		Date dddd = first_Datecal.getTime();

		String firstDate = sdfFIrstDate.format(dddd);
		String nowDate = sdfFIrstDate.format(tdate);

		//-----------------------------------------------------------------------------------------------------------------------------
	%>
	<div style="padding-left: 34%"> 
<br>
<form action="LoginToMiS_Controller" method="post">
		<table class="tftable" border="1" id="machineshopId">
			<tr align="left"  style="font-family: Arial;font-size: 15px;"> 
				<th colspan="5">Login To MIS System &#8658;</th> 
			</tr> 
			<tr style="font-family: Arial;font-size: 13px;">
				<td colspan="5"> 
				Login Name  : <input type="text" name="name" id="name" style="width: 200px;height: 25px;"><br>
				Password &nbsp;&nbsp;&nbsp;: <input type="password" name="pass" id="pass" style="width: 200px;height: 25px;"> <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit"  id="submit" value="Login" style="font-family: Arial;font-size: 16px;width: 150px;height:35px; ">
				</td>
			</tr>
			<tr align="left"  style="font-family: Arial;font-size: 15px;"> 
				<th colspan="5">
				<%
				if(request.getParameter("str")!=null){
				%>
				<strong style="color: red;"><%=request.getParameter("str") %></strong><br>
				<strong style="color: #A3802C;"><%=request.getParameter("str1") %></strong><br>
				<%	
				}
				%>
				</th> 
			</tr>  
		</table>
		</form> 
	</div>
	<br /> 
</body>
</html>