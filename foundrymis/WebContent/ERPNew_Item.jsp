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
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>MRM Operations</title> 
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
function ValidationMRM_Para() {
	var para = document.getElementById("para"); 
	 
		if (para.value=="0" || para.value==null || para.value=="" || para.value=="null") {
			alert("Please Provide Parameter First !!!");  
			return false;
		}
		return true;
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
		PreparedStatement ps=null;
		ResultSet rs = null;
	%>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">To create new item's in ERP System</strong> 
<br/>
<strong style="font-family: Arial;font-size: 14px;font-weight: bold;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr; BACK</a></strong>
<br>
<div style="overflow: scroll;background-color: white;width:58%;float:left">
<form action="ItemCreation_Approval" method="post">
<table class="tftable" style="border: 0px;">
  <tr>
    <th colspan="4" align="left">To add new supplier</th>
    </tr>
    <tr>
      <td colspan="4" align="left" bgcolor="#999999"><strong>Supplier Details</strong></td>
      </tr>
    <tr>
    <td width="23%">Supplier Name</td>
    <td colspan="3"><input type="text" name="supplier" id="supplier" style="text-transform: uppercase;" size="60" onkeyup="get_allAvailSuppliers(this.value)"> </td>
    </tr>
    <tr>
      <td>Supplier Short Name</td>
      <td colspan="3"><input type="text" name="short_supplier" id="short_supplier"  style="text-transform: uppercase;"></td>
      </tr>
    <tr>
      <td>Address</td>
      <td colspan="3"><textarea name="supp_address"  style="text-transform: uppercase;" id="supp_address" rows="2" cols="40"></textarea></td>
      </tr>
    <tr>
      <td>City</td>
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
      <td><input type="text" name="phone_supplier" id="phone_supplier"  onkeypress ="return validatenumerics(event);"></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>
    <tr>
      <td>Fax Number</td>
      <td><input type="text" name="fax_supplier" id="fax_supplier"></td>
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
      <td colspan="4" align="left" bgcolor="#999999"><strong>Taxation Details</strong></td>
      </tr>
    <tr>
      <td>Credit Days</td>
      <td colspan="3"><input type="text" name="credit_days" id="credit_days" size="5"  style="text-align: right;"   onkeypress ="return validatenumerics(event);" maxlength="3"></td>
      </tr>
    <tr>
      <td>TIN/SST Number</td>
      <td><input type="text" name="tin_sst" id="tin_sst" maxlength="12"></td>
      <td>Date</td>
      <td><input type="text" name="tin_sst_date" id="tin_sst_date" readonly="readonly"></td>
      </tr>
    <tr>
      <td>CST Number</td>
      <td><input type="text" name="cst_number" id="cst_number" maxlength="12"></td>
      <td>Date</td>
      <td><input type="text" name="cst_number_date" id="cst_number_date"  readonly="readonly"></td>
      </tr>
    <tr>
      <td>Service Tax Number</td>
      <td><input type="text" name="service_tax" id="service_tax" maxlength="15"></td>
      <td>Date</td>
      <td><input type="text" name="service_tax_date" id="service_tax_date"  readonly="readonly"></td>
      </tr>
    <tr>
      <td>ECC Number</td>
      <td colspan="3"><input type="text" name="ecc_no" id="ecc_no" maxlength="15"></td>
      </tr>
    <tr>
      <td>Exceise Range</td>
      <td><input type="text" name="excise_range" id="excise_range"></td>
      <td>Division</td>
      <td><input type="text" name="division" id="division"></td>
      </tr>
    <tr>
      <td>Collectorate</td>
      <td colspan="3"><input type="text" name="collectorate" id="collectorate"></td>
      </tr>
    <tr>
      <td>Supplier Category</td>
      <td><select name="supp_category" id="supp_category">
       <option value="">- - - - Select - - - - </option>
      <%
      ps = con.prepareStatement("select * from MSTCUSTCATAG");
      rs = ps.executeQuery();
      while(rs.next()){
      %>
      <option value="<%=rs.getString("CODE")%>"><%=rs.getString("NAME")%></option>
      <%
      }
      %>
      </select></td>
      <td>Category</td>
      <td><select name="category" id="category">
       <option value="">- - - - Select - - - - </option> 
      </select> 
		</td>
      </tr>
    <tr>
      <td>PAN Number</td>
      <td><input type="text" name="pan_no" id="pan_no" maxlength="10"></td>
      <td>TAN Number</td>
      <td><input type="text" name="tan_no" id="tan_no" maxlength="10"></td>
      </tr>
    <tr>
      <td>LBT Number</td>
      <td colspan="3"><input type="text" name="lbt_no" id="lbt_no" maxlength="15"></td>
      </tr>
    <tr>
      <td>TDS Code</td>
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
      </select> 
      </td>
      </tr>
    <tr>
      <td>Industry Type</td>
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
      <td colspan="4" align="left" bgcolor="#999999"><strong>Bank Details</strong></td>
    <tr>
      <td>Account Name*</td>
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
      <td><input type="text" name="phone_number1" id="phone_number1"></td>
      <td colspan="2"><input type="text" name="phone_number2" id="phone_number2"></td>
    </tr>
    <tr>
      <td rowspan="3">Bank Address</td>
      <td colspan="3"><input type="text" name="bank_address1" id="bank_address1" size="40"></td>
    </tr>
    <tr>
      <td colspan="3"><input type="text" name="bank_address2" id="bank_address2" size="40"></td>
    </tr>
    <tr>
      <td colspan="3"><input type="text" name="bank_address3" id="bank_address13" size="40"></td>
    </tr>
    
    <tr>
      <td>&nbsp;</td>
      <td colspan="3"><input type="submit" name="submit" id="submit" value="Submit for Approval" style="font-weight:bold;height: 29px;width: 200px;background-color: #9ae9ef;"></td>
    </tr>
  </table>
  </form>
</div> 
<div style="height:550px; overflow: scroll;background-color: white;width:41%;float:right;"> 	
<span id="autofind">	
<table class="tftable" style="border: 0px;">
  <tr>
    <th>Available</th>
  </tr>
  <tr>
  <td>&nbsp;</td>
  </tr>
</table>
</span>
</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	%>
</body>
</html>