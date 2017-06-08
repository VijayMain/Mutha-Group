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
<title>Supplier Summary</title>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<STYLE TYPE="text/css" MEDIA=all>
input {
	background-color: #e6e6ff;
}

textarea {
	background-color: #e6e6ff;
}

select {
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
function validateForm() {
	document.getElementById("submit").disabled = true; 
		return true;
}
</script>
</head>
<body style="font-family: Arial;">
<strong style="font-family: Arial;font-size: 14px;font-weight: bold;"><a href="ERPNew_Item.jsp" style="text-decoration: none;">&lArr; BACK</a></strong>
<%
if(request.getParameter("createdflag")!=null){
%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style="font-size: 12px;color:#1650d6"><%=request.getParameter("createdflag") %>........</strong>
<%
}
%>
	<%
		try {
			/* 1 approve, 0 declined */
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			Connection con = ConnectionUrl.getLocalDatabase();
			Connection conERP = ConnectionUrl.getBWAYSERPMASTERConnection();
			Date date = new Date();
			java.sql.Timestamp todaysDate = new java.sql.Timestamp(date.getTime());
			String hid_code = request.getParameter("hid_code");
			String ap_status = "",userName="";
			String app_code = "";
			int up = 0;
			PreparedStatement ps = null;
			ResultSet rs = null;

			ps = con.prepareStatement("select * from new_item_creation where code = " + Integer.parseInt(hid_code));
			rs = ps.executeQuery();
			while (rs.next()) {
				app_code = rs.getString("approval_status"); 
				userName = rs.getString("update_by");
			}

			String app_status = "";

			if (app_code.equalsIgnoreCase("1")) {
				app_status = "Approved"; 
			}
			if (app_code.equalsIgnoreCase("3")) {
				app_status = "Declined"; 
			}
			if (app_code.equalsIgnoreCase("0")) {
				app_status = "Pending";
				userName = "";
			}

			String reg_by = "", tranf_to = "", tds_method = "", excise_round = "", excise_cessround = "", service_taxround = "", service_cessround = "", vat_round = "", net_amountRound = "", is_overseas = "";
			int record_flag = 0;
			PreparedStatement ps_rec = con.prepareStatement("select * from new_item_creation where code="+ Integer.parseInt(hid_code));
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				reg_by = rs_rec.getString("registered_by");
				record_flag = rs_rec.getInt("created_inERP");
				
				if (rs_rec.getString("transf_h21") != null) {
					tranf_to = "MEPL H21" + ", " + tranf_to;
				}
				if (rs_rec.getString("transf_h25") != null) {
					tranf_to = "MEPL H25" + ", " + tranf_to;
				}
				if (rs_rec.getString("transf_mfpl") != null) {
					tranf_to = "MFPL" + ", " + tranf_to;
				}
				if (rs_rec.getString("transf_di") != null) {
					tranf_to = "DI" + ", " + tranf_to;
				}
				if (rs_rec.getString("transf_u3") != null) {
					tranf_to = "MEPL UNIT III" + ", " + tranf_to;
				}

				if (rs_rec.getString("tds_method") != null) {
					tds_method = "Applicable";
				}
				if (rs_rec.getString("excise_round") != null) {
					excise_round = "Applicable";
				}

				if (rs_rec.getString("excise_cessround") != null) {
					excise_cessround = "Applicable";
				}
				if (rs_rec.getString("service_taxround") != null) {
					service_taxround = "Applicable";
				}
				if (rs_rec.getString("service_cessround") != null) {
					service_cessround = "Applicable";
				}
				if (rs_rec.getString("vat_round") != null) {
					vat_round = "Applicable";
				}
				if (rs_rec.getString("net_amountRound") != null) {
					net_amountRound = "Applicable";
				}
				if (rs_rec.getString("is_overseas") != null) {
					is_overseas = "Applicable";
				}
			} 
String city_up = "", sup_cat = "", categ = "", tds_code = ""; 
if(uid==116 && record_flag!=1){
	%> 
	<form action="Created_inERP" method="post" onSubmit="return validateForm();">
	<input type="hidden" name="hid_code" id="hid_code" value="<%=hid_code%>">
	<input type="submit" name="submit" id="submit" value="Created In ERP" style="height: 30px;width: 200px;font-weight: bold;background-color: #76d7f3">
	</form> 
	<%
			}
	%>
<table border='1' width='80%' style='font-family: Arial;font-size: 12px;'>
		<tr
			style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th height='24'>Registered By</th>
			<th>Approval Status</th>
			<th>Transfer To</th>
		</tr>
		<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<td><%=reg_by%></td>
			<td><strong><%=app_status %></strong>(<%= userName %>)</td>
			<td><%= tranf_to %></td>
		</tr>
	</table>
	<table border='1' width='87%' style='font-family: Arial;'>
		<%
			ps_rec = con.prepareStatement("select * from new_item_creation where code=" + Integer.parseInt(hid_code));
				rs_rec = ps_rec.executeQuery();
				while (rs_rec.next()) {

					ps = conERP.prepareStatement("select * from MSTCOMMCITY where code='" + rs_rec.getString("supp_city") + "'");
					rs = ps.executeQuery();
					while (rs.next()) {
						city_up = rs.getString("NAME");
					}
					ps = conERP.prepareStatement("select * from MSTMATCATAG where code='" + rs_rec.getString("supp_category") + "'");
					rs = ps.executeQuery();
					while (rs.next()) {
						sup_cat = rs.getString("NAME");
					}
					if (rs_rec.getString("category").equalsIgnoreCase("0")) {
						categ = "Manufacturer";
					} else if (rs_rec.getString("category").equalsIgnoreCase(
							"1")) {
						categ = "Dealer/Traders";
					} else if (rs_rec.getString("category").equalsIgnoreCase(
							"2")) {
						categ = "Importer";
					} else if (rs_rec.getString("category").equalsIgnoreCase(
							"3")) {
						categ = "Other";
					}

					ps = conERP
							.prepareStatement("select * from CNFRATETDS where code='"
									+ rs_rec.getString("tds_code") + "'");
					rs = ps.executeQuery();
					while (rs.next()) {
						tds_code = rs.getString("NAME");
					}
%>
		<table border='1' width='80%' style='font-family: Arial;font-size: 12px;'>
			<tr>
				<td colspan='4' align='left' bgcolor='#999999'><strong>Supplier
						Details</strong></td>
			</tr>
			<tr>
				<td width='23%'><strong>Supplier Name</strong></td>
				<td colspan='3'><%= rs_rec.getString("supplier").toUpperCase()%></td>
			</tr>
			<tr>
				<td><strong>Supplier Short Name</strong></td>
				<td colspan='3'><%=rs_rec.getString("short_supplier").toUpperCase()%></td>
			</tr>
			<tr>
				<td><strong>Address</strong></td>
				<td colspan='3'><%= rs_rec.getString("supp_address").toUpperCase() %></td>
			</tr>
			<tr>
				<td><strong>City</strong></td>
				<td width='27%'><%= city_up %></td>
				<td width='21%'><strong>Pin Code</strong></td>
				<td width='29%'><%= rs_rec.getString("pin_supplier")%></td>
			</tr>
			<tr>
				<td><strong>Vendor Code</strong></td>
				<td><%=rs_rec.getString("vendor_code")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><strong>Phone Number</strong></td>
				<td><%=rs_rec.getString("supplier_phone1")%></td>
				<td><%=rs_rec.getString("supplier_phone2")%></td>
				<td><%=rs_rec.getString("supplier_phone3")%></td>
			</tr>
			<tr>
				<td><strong>Fax Number</strong></td>
				<td><%= rs_rec.getString("fax_supplier") %></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><strong>E-mail ID</strong></td>
				<td colspan='3'><%=rs_rec.getString("email_supplier")%></td>
			</tr>
			<tr>
				<td><strong>Web site</strong></td>
				<td colspan='3'><%= rs_rec.getString("website_supplier")%></td>
			</tr>
			<tr>
				<td><strong>Work Address</strong></td>
				<td colspan='3'><%=rs_rec.getString("work_address").toUpperCase()%></td>
			</tr>
			<tr>
				<td colspan='4' align='left' bgcolor='#999999'><strong>Taxation
						Details</strong></td>
			</tr>
			<tr>
				<td><strong>Credit Days</strong></td>
				<td><%=rs_rec.getString("credit_days")%></td>
				<td colspan='2'></td>
			</tr>
			<tr>
				<td><strong>TIN/SST Number</strong></td>
				<td><%= rs_rec.getString("tin_sst")%></td>
				<td><strong>Date</strong></td>
				<td>
				<%
				String tin_sst_date="";
				if(rs_rec.getString("tin_sst_date")!=""){
					tin_sst_date = rs_rec.getString("tin_sst_date").substring(8, 10) + "/" + rs_rec.getString("tin_sst_date").substring(5, 7) + "/" +  rs_rec.getString("tin_sst_date").substring(0, 4); 
				} 
				%>
				<label><%=tin_sst_date %></label>
				<%
				tin_sst_date="";
				%>
				</td>
			</tr>
			<tr>
				<td><strong>CST Number</strong></td>
				<td><%=rs_rec.getString("cst_number")%></td>
				<td><strong>Date</strong></td>
				<td> 
				<%
				String cst_number_date="";
				if(rs_rec.getString("cst_number_date")!=""){
					cst_number_date = rs_rec.getString("cst_number_date").substring(8, 10) + "/" + rs_rec.getString("cst_number_date").substring(5, 7) + "/" +  rs_rec.getString("cst_number_date").substring(0, 4); 
				}
				%>
				<label><%=cst_number_date %></label>
				<%
				cst_number_date="";
				%>
					
				</td>
			</tr>
			<tr>
				<td><strong>Service Tax Number</strong></td>
				<td><%=rs_rec.getString("service_tax")%></td>
				<td><strong>Date</strong></td> 
				<td> 
				<%
				String service_tax_date="";
				if(rs_rec.getString("service_tax_date")!=""){
					service_tax_date = rs_rec.getString("service_tax_date").substring(8, 10) + "/" + rs_rec.getString("service_tax_date").substring(5, 7) + "/" +  rs_rec.getString("service_tax_date").substring(0, 4); 
				} 
				%>
				<label><%=service_tax_date %></label>
				<%
				service_tax_date="";
				%>
				</td>
				
			</tr>
			<tr>
				<td><strong>ECC Number</strong></td>
				<td colspan='3'><%= rs_rec.getString("ecc_no")%></td>
			</tr>
			<tr>
				<td><strong>Excise Range</strong></td>
				<td><%= rs_rec.getString("excise_range") %></td>
				<td><strong>Division</strong></td>
				<td><%= rs_rec.getString("division") %></td>
			</tr>
			<tr>
				<td><strong>Collectorate</strong></td>
				<td colspan='3'><%= rs_rec.getString("collectorate")%></td>
			</tr>
			<tr>
				<td><strong>Supplier Category</strong></td>
				<td><%= sup_cat %></td>
				<td><strong>Category</strong></td>
				<td><%= categ %></td>
			</tr>
			<tr>
				<td><strong>PAN Number</strong></td>
				<td><%= rs_rec.getString("pan_no")%></td>
				<td><strong>TAN Number</strong></td>
				<td><%=rs_rec.getString("tan_no")%></td>
			</tr>
			<tr>
				<td><strong>LBT Number</strong></td>
				<td colspan='3'><%=rs_rec.getString("lbt_no")%></td>
			</tr>
			<tr>
				<td><strong>TDS Code</strong></td>
				<td colspan='3'><%=tds_code %></td>
			</tr>
			<tr>
				<td><strong>Industry Type</strong></td>
				<td colspan='3'><%= rs_rec.getString("indus_type")%></td>
			</tr>
			<tr>
				<td><strong>TDS Method</strong></td>
				<td colspan='3'><%=tds_method %>* Checked TDS Posting Entry Wise and Unchecked for TDS Debit Note</td>
			</tr>
			<tr>
				<td><strong>Excise Round</strong></td>
				<td><%= excise_round %></td>
				<td><strong>Excise Cess Round</strong></td>
				<td><%=excise_cessround%></td>
			</tr>
			<tr>
				<td><strong>Service Tax Round</strong></td>
				<td><%=service_taxround%></td>
				<td><strong>Service Cess Round</strong></td>
				<td><%=service_cessround%></td>
			</tr>
			<tr>
				<td><strong>VAT Round</strong></td>
				<td><%= vat_round %></td>
				<td><strong>Net Amount Round</strong></td>
				<td><%= net_amountRound %></td>
			</tr>
			<tr>
				<td><strong>Is Overseas<strong></td>
				<td colspan='3'><%= is_overseas%></td>

			</tr>
			<tr>
				<td colspan='4' align='left' bgcolor='#999999'><strong>Bank
						Details</strong></td>
			<tr>
				<td><strong>Account Name</strong></td>
				<td colspan='3'><%= rs_rec.getString("account_name")%></td>
			</tr>
			<tr>
				<td><strong>Account Number</strong></td>
				<td colspan='3'><%=rs_rec.getString("account_number")%></td>
			</tr>
			<tr>
				<td><strong>Bank Name</strong></td>
				<td colspan='3'><%=rs_rec.getString("bank_name")%></td>
			</tr>
			<tr>
				<td><strong>Branch</strong></td>
				<td colspan='3'><%=rs_rec.getString("branch")%></td>
			</tr>
			<tr>
				<td><strong>IFSC Code for RTGS</strong></td>
				<td colspan='3'><%= rs_rec.getString("ifsc_rtgs")%></td>
			</tr>
			<tr>
				<td><strong>IFSC Code NEFT</strong></td>
				<td colspan='3'><%=rs_rec.getString("ifsc_neft")%></td>
			</tr>
			<tr>
				<td><strong>MICR Code</strong></td>
				<td colspan='3'><%=rs_rec.getString("micr_code")%></td>
			</tr>
			<tr>
				<td><strong>Phone Number</strong></td>
				<td><%=rs_rec.getString("phone_number1")%></td>
				<td><%=rs_rec.getString("phone_number2")%></td>
				<td><%=rs_rec.getString("phone_number3")%></td>
			</tr>
			<tr>
				<td rowspan='3'><strong>Bank Address</strong></td>
				<td colspan='3'><%= rs_rec.getString("bank_address1")%></td>
			</tr>
			<tr>
				<td colspan='3'><%= rs_rec.getString("bank_address2")%></td>
			</tr>
			<tr>
				<td colspan='3'><%=rs_rec.getString("bank_address3")%></td>
			</tr> 
				<tr><td colspan='4' align='left' bgcolor='#c3c3c3'><strong>GST Details</strong></td></tr>
				<tr><td>Supplier GSTIN Registered ?</td><td colspan='3'><%= rs_rec.getString("gstin_reg") %></td>
				</tr><tr><td>GSTIN Number (If Yes)</td><td colspan='3'><%= rs_rec.getString("GSTIN_number") %></td>
				</tr><tr><td>Is Line Item GST Round</td><td colspan='3'><%= rs_rec.getString("line_itemgstround") %></td>
				</tr><tr><td>State</td><td colspan='3'><%= rs_rec.getString("state_gst") %></td></tr> 
		</table> 
	<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
	%>
</body>
</html>