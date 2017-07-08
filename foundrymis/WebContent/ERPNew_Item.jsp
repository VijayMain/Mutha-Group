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
<title>ERP New Supplier</title> 
<link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<script>
	$(function() {
		$("#tabs").tabs();
	});						         
	 $(function() {
		 $( "#tin_sst_date").datepicker({
		      changeMonth: true,
		      changeYear: true
		});
		    $( "#cst_number_date").datepicker({
			      changeMonth: true,
			      changeYear: true
			});
		    $( "#service_tax_date").datepicker({
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
	var supp_address = document.getElementById("supp_address"); 
	var supp_city = document.getElementById("supp_city");
	/* var work_address = document.getElementById("work_address"); */
	var credit_days = document.getElementById("credit_days");
	var tin_sst = document.getElementById("tin_sst");
	var tin_sst_date = document.getElementById("tin_sst_date"); 
	var cst_number = document.getElementById("cst_number"); 
	var cst_number_date = document.getElementById("cst_number_date"); 
	var service_tax = document.getElementById("service_tax"); 
	var service_tax_date = document.getElementById("service_tax_date");
	var supp_category = document.getElementById("supp_category"); 
	var purpose = document.getElementById("purpose"); 
	var category = document.getElementById("category"); 
	var pan_no = document.getElementById("pan_no"); 
	var tds_code = document.getElementById("tds_code"); 
	var indus_type = document.getElementById("indus_type");
	var meplH21 = document.getElementById("meplH21").checked;
	var meplH25 = document.getElementById("meplH25").checked;
	var mfpl = document.getElementById("mfpl").checked;
	var di = document.getElementById("di").checked;
	var meplunitIII = document.getElementById("meplunitIII").checked;
	
	   
	var GSTIN_number = document.getElementById("GSTIN_number"); 
	var state_gst = document.getElementById("state_gst"); 
	
	
		if (supplier.value=="0" || supplier.value==null || supplier.value=="" || supplier.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Supplier Name !!!");  
			return false;
		}
		if (supp_address.value=="0" || supp_address.value==null || supp_address.value=="" || supp_address.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Address !!!");  
			return false;
		}
		if (supp_city.value=="" || supp_city.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide City !!!");  
			return false;
		}
		/*	
		if (work_address.value=="0" || work_address.value==null || work_address.value=="" || work_address.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Work Address !!!");
			return false;
		}
		*/
		if (credit_days.value=="0" || credit_days.value==null || credit_days.value=="" || credit_days.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Credit Days !!!");  
			return false;
		}
		if (tin_sst.value!="" && tin_sst_date.value=="") {
			document.getElementById("submit").disabled = false;
			alert("If TIN/SST Number is available, Date is mandatory !!!");  
			return false;
		}
		if (cst_number.value!="" && cst_number_date.value=="") {
			document.getElementById("submit").disabled = false;
			alert("If CST Number is available, Date is mandatory !!!");  
			return false;
		}
		if (service_tax.value!="" && service_tax_date.value=="") {
			document.getElementById("submit").disabled = false;
			alert("If Service Tax Number is available, Date is mandatory !!!");  
			return false;
		}
		if (supp_category.value=="0" || supp_category.value==null || supp_category.value=="" || supp_category.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Supplier Category !!!");  
			return false;
		}
		if (purpose.value=="0" || purpose.value==null || purpose.value=="" || purpose.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Purpose  !!!");  
			return false;
		}
		if (category.value==null || category.value=="" || category.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Category !!!");
			return false;
		}
		if (pan_no.value=="0" || pan_no.value==null || pan_no.value=="" || pan_no.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide PAN Number !!!");
			return false;
		}			   
		if (tds_code.value=="0" || tds_code.value==null || tds_code.value=="" || tds_code.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide TDS Code !!!");
			return false;
		}
		if (indus_type.value=="0" || indus_type.value==null || indus_type.value=="" || indus_type.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide Industry Type !!!");
			return false;
		}
		            
		if (meplH21==false && meplH25==false && mfpl==false && di==false && meplunitIII==false) {
			document.getElementById("submit").disabled = false;
			alert("After supplier creation, which company it belongs to / Transfer to !!!");
			return false;
		}
		
		   
		
		if (GSTIN_number.value=="0" || GSTIN_number.value==null || GSTIN_number.value=="" || GSTIN_number.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Provide GSTIN Number !!!");  
			return false;
		}
		if (state_gst.value=="0" || state_gst.value==null || state_gst.value=="" || state_gst.value=="null") {
			document.getElementById("submit").disabled = false;
			alert("Please Provide State  !!!");  
			return false;
		}
}
 
function get_allAvailSuppliers(name) {
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
			document.getElementById("autofind").innerHTML = xmlhttp.responseText; 
		}
	};
	xmlhttp.open("POST", "Get_allAvailUsers.jsp?q=" + name, true);  
	xmlhttp.send(); 
}

function getSupplier(str) {
	if(str!=""){
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
			document.getElementById("autofind").innerHTML = xmlhttp.responseText; 
		}
	};
	xmlhttp.open("POST", "GetSelectedApproval_List.jsp?q=" + str, true);
	xmlhttp.send();
	}
}; 
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
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">To create new Supplier in ERP System</strong> 
<br/>
<strong style="font-family: Arial;font-size: 14px;font-weight: bold;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr; BACK</a></strong>
&nbsp;&nbsp;&nbsp;<b style="font-size: 11px;color: #555306">Note : Please Use Mozilla Firefox Web Browser for full control.......</b>
<br>
<div style="overflow: scroll;background-color: white;width:58%;float:left">

<form action="ItemCreation_Approval" method="post"  onSubmit="return validateNewItemForm();"  enctype="multipart/form-data">
<table class="tftable" style="border: 0px;">
  <tr>
    <th colspan="4" align="left">To add new supplier  ( <a href="ERPNew_Item.jsp" style="font-family: Arial;font-size: 12px;color: green;">Reset</a> )</th>
    </tr>
    <tr>
      <td colspan="4" align="left" bgcolor="#c3c3c3"><strong>Supplier Details</strong></td>
    </tr>
    <tr>
    <td width="23%">Supplier Name <b style="color: red;">*</b> </td>
    <td colspan="3"><input type="text" name="supplier" id="supplier" style="text-transform: uppercase;" size="60" onKeyUp="get_allAvailSuppliers(this.value)"> </td>
    </tr>
    <tr>
      <td>Supplier Short Name</td>
      <td colspan="3"><input type="text" name="short_supplier" id="short_supplier"  style="text-transform: uppercase;"></td>
      </tr>
    <tr>
      <td>Address <b style="color: red;">*</b> </td>
      <td colspan="3"><textarea name="supp_address"  style="text-transform: uppercase;" id="supp_address" rows="2" cols="40"></textarea></td>
      </tr>
    <tr>
      <td>City <b style="color: red;">*</b> </td>
      <td width="27%">
      <select name="supp_city" id="supp_city">
      <option value="">- - - - Select - - - - </option>
      <%
      ps = con.prepareStatement("select * from MSTCOMMCITY order by NAME");
      rs = ps.executeQuery();
      while(rs.next()){
      %>
      <option value="<%=rs.getString("CODE")%>"><%=rs.getString("NAME")%></option>
      <%
      }
      %>
      </select>      </td>
      <td width="21%">Pin Code</td>
      <td width="29%"><input type="text" name="pin_supplier" id="pin_supplier" maxlength="6" onkeypress ="return validatenumerics(event);"></td>
      </tr>
    <tr>
      <td>Vendor Code</td>
      <td><input type="text" name="vendor_code" id="vendor_code"></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>
    <tr>
      <td>Phone Number</td>
      <td><input type="text" name="supplier_phone1" id="supplier_phone1"  maxlength="10"  onkeypress ="return validatenumerics(event);"></td>
      <td><input type="text" name="supplier_phone2" id="supplier_phone2" maxlength="10"  onkeypress ="return validatenumerics(event);"></td>
      <td><input type="text" name="supplier_phone3" id="supplier_phone3" maxlength="10"  onkeypress ="return validatenumerics(event);"></td>
      </tr>
    <tr>
      <td>Fax Number</td>
      <td><input type="text" name="fax_supplier" id="fax_supplier"  maxlength="11"></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>
    <tr>
      <td>E-mail ID</td>
      <td colspan="3"><input type="text" name="email_supplier" id="email_supplier" size="40"></td>
      </tr>
    <tr>
      <td>Website</td>
      <td colspan="3"><input type="text" name="website_supplier" id="website_supplier" size="40"></td>
      </tr>
    <tr>
      <td>Work Address</td>
      <td colspan="3"><textarea name="work_address" id="work_address" rows="2" cols="40" style="text-transform: uppercase;"></textarea></td>
      </tr>
    <tr>
      <td colspan="4" align="left" bgcolor="#c3c3c3"><strong>Taxation Details</strong></td>
      </tr>
    <tr>
      <td>Credit Days <b style="color: red;">*</b> </td>
      <td colspan="3"><input type="text" name="credit_days" id="credit_days" size="5"  style="text-align: right;"   onkeypress ="return validatenumerics(event);" maxlength="3"></td>
      </tr>
    <tr>
      <td>TIN/SST Number</td>
      <td><input type="text" name="tin_sst" id="tin_sst" maxlength="12" style="text-transform: uppercase;"></td>
      <td>Date</td>
      <td><input type="text" name="tin_sst_date" id="tin_sst_date" readonly="readonly"></td>
      </tr>
    <tr>
      <td>CST Number</td>
      <td><input type="text" name="cst_number" id="cst_number" maxlength="12" style="text-transform: uppercase;"></td>
      <td>Date</td>
      <td><input type="text" name="cst_number_date" id="cst_number_date"  readonly="readonly"></td>
      </tr>
    <tr>
      <td>Service Tax Number</td>
      <td><input type="text" name="service_tax" id="service_tax" maxlength="15" style="text-transform: uppercase;"></td>
      <td>Date</td>
      <td><input type="text" name="service_tax_date" id="service_tax_date"  readonly="readonly"></td>
      </tr>
    <tr>
      <td>ECC Number</td>
      <td colspan="3"><input type="text" name="ecc_no" id="ecc_no" maxlength="15" style="text-transform: uppercase;"></td>
      </tr>
    <tr>
      <td>Exceise Range</td>
      <td><input type="text" name="excise_range" id="excise_range" style="text-transform: uppercase;"></td>
      <td>Division</td>
      <td><input type="text" name="division" id="division" style="text-transform: uppercase;"></td>
      </tr>
    <tr>
      <td>Collectorate</td>
      <td colspan="3"><input type="text" name="collectorate" id="collectorate" style="text-transform: uppercase;"></td>
      </tr>
    <tr>
      <td>Supplier Category <b style="color: red;">*</b> </td>
      <td><select name="supp_category" id="supp_category">
       <option value="">- - - - Select - - - - </option>
      <%
      ps = con.prepareStatement("select * from MSTMATCATAG");
      rs = ps.executeQuery();
      while(rs.next()){
      %>
      <option value="<%=rs.getString("CODE")%>"><%=rs.getString("NAME")%></option>
      <%
      }
      %>
      </select></td>
      <td>Purpose <b style="color: red;">*</b></td>
      <td><input type="text" name="purpose" id="purpose" style="text-transform: uppercase;"></td>
      </tr>
    <tr>
      <td>Category <b style="color: red;">*</b></td>
      <td><select name="category" id="category">
         <option value="">- - - - Select - - - - </option>
					<Option Value="0">Manufacturer</Option>
					<Option Value="1">Dealer/Traders</Option>
					<Option Value="2">Importer</Option>
					<Option Value="3">Other</Option>
      </select></td>
      <td>PAN Number <b style="color: red;">*</b></td>
      <td><input type="text" name="pan_no" id="pan_no" maxlength="10" style="text-transform: uppercase;"></td>
      </tr>
    <tr>
      <td>LBT Number</td>
      <td><input type="text" name="lbt_no" id="lbt_no" maxlength="15" style="text-transform: uppercase;"></td>
      <td>TAN Number</td>
      <td><input type="text" name="tan_no" id="tan_no" maxlength="10" style="text-transform: uppercase;"></td>
    </tr>
    <tr>
      <td>TDS Code <b style="color: red;">*</b> </td>
      <td colspan="3"><select name="tds_code" id="tds_code">
      <option value="">- - - - Select - - - - </option>
      <%
      ps = con.prepareStatement("select * from CNFRATETDS");
      rs = ps.executeQuery();
      while(rs.next()){
      %>
      <option value="<%=rs.getString("CODE")%>"><%=rs.getString("NAME")%></option>
      <%
      }
      %>
      </select>      </td>
      </tr>
    <tr>
      <td>Industry Type <b style="color: red;">*</b> </td>
      <td colspan="3"><select name="indus_type" id="indus_type">
        <option value="SSI">SSI</option>
        <option value="NON SSI">NON SSI</option>
      </select></td>
      </tr>
    <tr>
      <td>TDS Method</td>
      <td colspan="3"><input type="checkbox" name="tds_method" id="tds_method">* Checked TDS Posting Entry Wise and Unchecked for TDS Debit Note</td>
      </tr>
    
    <tr>
      <td>Excise Round</td>
      <td><input type="checkbox" name="excise_round" id="excise_round"></td>
      <td>Excise Cess Round</td>
      <td><input type="checkbox" name="excise_cessround" id="excise_cessround"></td>
    </tr>
    <tr>
      <td>Service Tax Round</td>
      <td><input type="checkbox" name="service_taxround" id="service_taxround"></td>
      <td>Service Cess Round</td>
      <td><input type="checkbox" name="service_cessround" id="service_cessround"></td>
    </tr>
    <tr>
      <td>VAT Round</td>
      <td><input type="checkbox" name="vat_round" id="vat_round"></td>
      <td>Net Amount Round</td>
      <td><input type="checkbox" name="net_amountRound" id="net_amountRound"></td>
    </tr>
    <tr>
      <td>Is Overseas</td>
      <td colspan="3"><input type="checkbox" name="is_overseas" id="is_overseas"></td>
    </tr> 
    <tr>
      <td colspan="4" align="left" bgcolor="#c3c3c3"><strong>Extra Information</strong></td>
      </tr>
    <tr>
      <td>Any Relatives in Mutha Group</td>
      <td colspan="3">
      <input type="radio" name="relativeinMutha" id="relativeinMutha" value="yes">Yes &nbsp; &nbsp;
      <input type="radio" name="relativeinMutha" id="relativeinMutha" value="no">No &nbsp; &nbsp;
      If Yes Name : <input type="text" name="relative_name" id="relative_name" size="30" maxlength="50" style="text-transform: uppercase;">      </td>
    </tr>
    <tr>
      <td>Turnover p.a.(Last 3)</td>
      <td colspan="3"><%=year-1 %><input type="hidden" name="turnYear1" id="turnYear1" value="<%=year-1%>">
      <input type="text" name="turnover1" id="turnover1" size="11" maxlength="11" onkeypress ="return validatenumerics(event);">
      <%=year-2 %><input type="hidden" name="turnYear2" id="turnYear2" value="<%=year-2%>">
      <input type="text" name="turnover2" id="turnover2" size="11" maxlength="11" onkeypress ="return validatenumerics(event);">
      <%=year-3 %><input type="hidden" name="turnYear3" id="turnYear3" value="<%=year-3%>">
      <input type="text" name="turnover3" id="turnover3" size="11" maxlength="11" onkeypress ="return validatenumerics(event);">      </td>
    </tr>
    <tr>
      <td>Owner's Name</td>
      <td colspan="3"><input type="text" name="owners_name" id="owners_name" size="40"></td>
    </tr>
    <tr>
      <td colspan="4" align="left" bgcolor="#c3c3c3"><strong>Bank Details</strong></td>
    <tr>
      <td>Account Name</td>
      <td colspan="3"><input type="text" name="account_name" id="account_name" size="40"></td>
      </tr>
    <tr>
      <td>Account Number</td>
      <td colspan="3"><input type="text" name="account_number" id="account_number" size="40"></td>
    </tr>
    <tr>
      <td>Bank Name</td>
      <td colspan="3"><input type="text" name="bank_name" id="bank_name" size="40"></td>
    </tr>
    <tr>
      <td>Branch</td>
      <td colspan="3"><select name="branch" id="branch">
      <option value="">- - - - Select - - - - </option>
       <%
      ps = con.prepareStatement("select * from MSTCOMMCITY order by NAME");
      rs = ps.executeQuery();
      while(rs.next()){
      %>
      <option value="<%=rs.getString("CODE")%>"><%=rs.getString("NAME")%></option>
      <%
      }
      %> 
      </select></td>
    </tr>
    <tr>
      <td>IFSC Code for RTGS</td>
      <td colspan="3"><input type="text" name="ifsc_rtgs" id="ifsc_rtgs" size="40"></td>
    </tr>
    <tr>
      <td>IFSC Code NEFT</td>
      <td colspan="3"><input type="text" name="ifsc_neft" id="ifsc_neft" size="40"></td>
    </tr>
    <tr>
      <td>MICR Code</td>
      <td colspan="3"><input type="text" name="micr_code" id="micr_code" size="40"></td>
    </tr>
    <tr>
      <td>Phone Number</td>
      <td><input type="text" name="phone_number1" id="phone_number1"  maxlength="10" onkeypress ="return validatenumerics(event);"></td>
      <td><input type="text" name="phone_number2" id="phone_number2"  maxlength="10" onkeypress ="return validatenumerics(event);"></td>
      <td><input type="text" name="phone_number3" id="phone_number3"  maxlength="10" onkeypress ="return validatenumerics(event);"></td>
    </tr>
    <tr>
      <td rowspan="3">Bank Address</td>
      <td colspan="3"><input type="text" name="bank_address1" id="bank_address1" size="40"></td>
    </tr>
    <tr>
      <td colspan="3"><input type="text" name="bank_address2" id="bank_address2" size="40"></td>
    </tr>
    <tr>
      <td colspan="3"><input type="text" name="bank_address3" id="bank_address3" size="40"></td>
    </tr>
    
    <tr>
      <td>Attach cheque/other for ref.</td>
      <td colspan="3"><input type="file" name="attachment" id="attachment" size="40"></td>
    </tr>
   
   
    <!--
    		GST Data Details ======>  
    --->
    <tr>
      <td colspan="4" align="left" bgcolor="#c3c3c3"><strong>GST Details</strong></td>
    </tr>
    <tr>
      <td>Supplier GSTIN Registered ?</td>
      <td colspan="3">&nbsp;&nbsp;
	  <input type="radio" name="gstin_reg" id="gstin_regyes" value="yes">Yes &nbsp; &nbsp;
      <input type="radio" name="gstin_reg" id="gstin_regno" value="no">No &nbsp;  
	</td>
    </tr>
    <tr>
      <td>GSTIN Number</td>
      <td colspan="3"><input type="text" name="GSTIN_number" id="GSTIN_number" size="30" maxlength="50" style="text-transform: uppercase;"></td>
    </tr>
    <tr>
      <td>Is Line Item GST Round</td>
      <td colspan="3"> &nbsp; &nbsp;
      <input type="radio" name="line_itemgstround" id="line_itemgstroundyes" value="yes">Yes &nbsp; &nbsp;
      <input type="radio" name="line_itemgstround" id="line_itemgstroundno" value="no">No &nbsp;
      </td>
    </tr>
    <tr>
      <td>State</td>
      <td colspan="3">
      <select name="state_gst" id="state_gst" style="font-weight: bold;">
      	<option value="">- - - - Select - - - - </option>
      <%
      ps = con.prepareStatement("select * from MSTCOMMSTATE");
      rs = ps.executeQuery();
      while(rs.next()){
      %>
      <option value="<%=rs.getString("NAME")%>"><%=rs.getString("NAME")%> <%=rs.getString("CODE")%></option>
      <%
      }
      %>
      </select>
      </td>
    </tr>   
   <!-- -------------------------------------------------------------------------------------------------------------------------------------------------------- -->
 
    <!--
    		Transfer data to company selected  
    --->
    
    <tr>
      <td colspan="4" align="left" bgcolor="#c3c3c3"><strong>After Creation, Transfer Supplier To</strong></td>
    </tr>
    <tr>
      <td colspan="4">
      <br>
      <input type="checkbox" name="meplH21" id="meplH21"> MEPL H21  &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="checkbox" name="meplH25" id="meplH25"> MEPL H25  &nbsp;&nbsp; &nbsp;&nbsp; 
      <input type="checkbox" name="mfpl" id="mfpl"> MFPL  &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="checkbox" name="di" id="di"> DI  &nbsp;&nbsp; &nbsp;&nbsp;
      <input type="checkbox" name="meplunitIII" id="meplunitIII"> MEPL UNIT III
      <br> <br>      </td>
    </tr>
   
    <tr>
      <td>&nbsp;</td>
      <td colspan="3"><input type="submit" name="submit" id="submit" value="Submit for Approval" style="font-weight:bold;height: 29px;width: 200px;background-color: #9ae9ef;"></td>
    </tr>
  </table>
  </form>
</div>
<div style="height:550px; overflow: scroll;background-color: white;width:41%;float:right;">
<form action="Supplier_Summary.jsp" method="post" name="edit" id="edit">
<input type="hidden" name="hid_code" id="hid_code"> 
<span id="autofind">
<table class="tftable" style="border: 0px;">
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
  created_erp=0;
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