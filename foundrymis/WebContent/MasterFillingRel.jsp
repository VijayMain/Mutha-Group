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
<title>Master</title> 
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
	 
		function showState(str) {
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
					document.getElementById("soft").innerHTML = xmlhttp.responseText;  
				}
			};
			xmlhttp.open("POST", "ItemMaster_Selected.jsp?q=" + str, true);
			xmlhttp.send();
		};
</script>
<script type="text/javascript">
	function ClearList(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function move(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('software_name');
			attribute2 = document.getElementById('software_selected');
		} else {
			attribute2 = document.getElementById('software_name');
			attribute1 = document.getElementById('software_selected');
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
		ClearList(attribute1, attribute1);
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
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		Connection con = Connection_Utility.getConnection();
		Connection con_local = ConnectionUrl.getLocalDatabase();
		PreparedStatement ps_uname = con.prepareStatement("select U_Name from User_tbl where U_Id=" + uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}
%>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Master ERP Item Creation ERP System</strong> 
<br/>
<strong style="font-family: Arial;font-size: 14px;font-weight: bold;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr; BACK</a></strong>
&nbsp;&nbsp;&nbsp;<b style="font-size: 11px;color: #555306">Note : Please Use Mozilla Firefox Web Browser for full control.......</b>
<br>
<div style="overflow: scroll;background-color: white;width:58%;height:100%; float:left">
  <form action="Master_configureController" method="post" id="myForm" name="myForm"> 
 			<br>
				<table align="center">
					<thead> 
						<tr>
							<td align="left"><b>Select Material Type :</b></td>
							<td align="left">
	<select name="matType" id="matType"  onchange="showState(this.value)" style="height: 25px;font-family: sans-serif;font-size: 15px;background-color: #e1e1e1;font-weight: bold;">
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
			</select></td>
						</tr>
					</thead>
				</table>
				<div id="soft">
					<table align="center">
						<tr>
							<td colspan="1"><b>MIS Report</b></td>
							<td></td>
							<td colspan="1"><b>Selected MIS Report</b></td>
						</tr> 
						<tr>
							<td colspan="1" align="left">
							<select id="software_name" name="software_name" multiple="multiple" size="5"
								style="width: 250px;height: 250px;font-size: 13px;font-family: Arial;" title="MIS Report"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"> 
									<%
									PreparedStatement ps_soft = con_local.prepareStatement("select * from  erp_itemmaster_list");
									ResultSet rs_soft = ps_soft.executeQuery();
									while (rs_soft.next()) {
									%>
									<option value="<%=rs_soft.getString("lable")%>"><%=rs_soft.getString("lable")%></option>
									<%
										}
									%>
							</select>
							</td>
							<td  align="center">
								<input value="&#8658;" onclick="move('right', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 15px;"><br>
								<input value="&#8656;" onclick="move('left', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 15px;"></td>
							<td colspan="1" align="right">
							<select id="software_selected" name="software_selected" multiple="multiple" size="5"
								style="width: 250px;height: 250px;font-size: 13px;font-family: Arial;" title="Selected MIS Report"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
							</select>
							</td>
						</tr>
					</table>
				</div>
				<table>

					<tr>
						<td align="center" style="width: 1000px; height: 30px;"><input type="submit" value="Save" style="width: 200px;height: 35px;">
						</td>
					</tr>

				</table>
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