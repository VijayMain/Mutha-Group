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
	 
	 function get_FormSelected(name) {
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
					document.getElementById("itemSelected").innerHTML = xmlhttp.responseText; 
				}
			};
			xmlhttp.open("POST", "Master_Ajax.jsp?q=" + name, true);  
			xmlhttp.send();
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
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">New Item Creation in ERP System</strong> 
<br/>
<strong style="font-family: Arial;font-size: 14px;font-weight: bold;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr; BACK</a></strong>
&nbsp;&nbsp;&nbsp;<b style="font-size: 11px;color: #555306">Note : Please Use Mozilla Firefox Web Browser for full control.......</b>
<br>
<div style="overflow: scroll;background-color: white;width:70%;float:left">
<form action="ItemERP_Creation" method="post"  onSubmit="return validateNewItemForm();"  enctype="multipart/form-data">
<table class="tftable" style="width: 100%">
  <tr>
    <th colspan="4" align="left">
    		<strong>Select Material Type :</strong>  
			<select name="matType" id="matType" style="height: 25px;font-family: sans-serif;font-size: 15px;background-color: #e1e1e1;"  onchange="get_FormSelected(this.value)">
			<option value=""> - - - Select - - - </option>
			<%
			Connection conMaster = ConnectionUrl.getBWAYSERPMASTERConnection();
			PreparedStatement ps_mst = conMaster.prepareStatement("select * from CNFMATERIALS");
			ResultSet rs_mst = ps_mst.executeQuery();
			while(rs_mst.next()){
			%>
			<option value="<%=rs_mst.getString("CODE")%>" style="font-family: sans-serif;font-size: 15px;"><%=rs_mst.getString("NAME").toUpperCase()%></option>
			<%
			}
			%>
			</select>
			&nbsp;&nbsp;( <a href="New_ItemGenerate.jsp" style="font-family: Arial;font-size: 13px;color: green;">Reset</a> )
    </th>
 </tr>
    <!-- <tr>
      <td>Purpose <b style="color: red;">*</b></td>
      <td colspan="3"><input type="text" name="purpose" id="purpose" size="50" style="text-transform: uppercase;"></td>
      </tr> 
    <tr>
      <td>Attach cheque/other for ref.</td>
      <td colspan="3"><input type="file" name="attachment" id="attachment" size="40"></td>
    </tr> 
    		Transfer data to company selected -
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
      <br><br>      
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td colspan="3"><input type="submit" name="submit" id="submit" value="Submit for Approval" style="font-weight:bold;height: 29px;width: 200px;background-color: #9ae9ef;"></td>
    </tr>
    -->
  </table>
  
  
  <div id="itemSelected">
  
  </div>
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