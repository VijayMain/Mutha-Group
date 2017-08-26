<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.01 Transitional//EN http://www.w3.org/TR/html4/loose.dtd>
<html>
<head>
<title>Dashboard</title>
</head>
<body bgcolor=#DEDEDE style="font-family: Arial;">

	<table border='1' width='97%' style='font-family: Arial;'>
		<tr
			style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th height='24'>Registered By</th>
			<th>Approval Status</th>
			<th>Transfer To</th>
		</tr>
		<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<td>"+reg_by+"</td>
			<td><strong>"+ap_status + "</strong> by " + userName+"</td>
			<td>" + tranf_to + "</td>
		</tr>
		<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th height='24'>Requested By</th>
			<th>Requested Department</th>
			<th>Purpose </th>
		</tr>
		<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<td>"+req_user +"</td>
			<td> "+req_dept +"</td>
			<td>" + purpose + "</td>
		</tr>
	</table>

	<table border='1' width='97%' style='font-family: Arial;'>
		<tr>
			<td colspan='4' align='left' bgcolor='#999999'><strong>Supplier
					Details</strong></td>
		</tr>
		<tr>
			<td width='23%'><strong>Supplier Name</strong></td>
			<td colspan='3'>"+rs_rec.getString("supplier").toUpperCase()+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Supplier Short Name</strong></td>
			<td colspan='3'>"+rs_rec.getString("short_supplier").toUpperCase()+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Address</strong></td>
			<td colspan='3'>"+rs_rec.getString("supp_address").toUpperCase()+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>City</strong></td>
			<td width='27%'>"+city_up+"&nbsp;</td>
			<td width='21%'><strong>Pin Code</strong></td>
			<td width='29%'>"+rs_rec.getString("pin_supplier")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Vendor Code</strong></td>
			<td>"+rs_rec.getString("vendor_code")+"&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Phone Number</strong></td>
			<td>"+rs_rec.getString("supplier_phone1")+"&nbsp;</td>
			<td>"+rs_rec.getString("supplier_phone2")+"&nbsp;</td>
			<td>"+rs_rec.getString("supplier_phone3")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Fax Number</strong></td>
			<td>"+rs_rec.getString("fax_supplier")+"&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><strong>E-mail ID</strong></td>
			<td colspan='3'>"+rs_rec.getString("email_supplier")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Website</strong></td>
			<td colspan='3'>"+rs_rec.getString("website_supplier")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Work Address</strong></td>
			<td colspan='3'>"+rs_rec.getString("work_address").toUpperCase()+"&nbsp;</td>
		</tr>
		<tr>
			<td colspan='4' align='left' bgcolor='#999999'><strong>Taxation
					Details</strong></td>
		</tr>
		<tr>
			<td><strong>Credit Days</strong></td>
			<td>"+rs_rec.getString("credit_days")+"&nbsp;</td>
			<td colspan='2'></td>
		</tr>
		<tr>
			<td><strong>Supplier Category</strong></td>
			<td>"+sup_cat+"&nbsp;</td>
			<td><strong>Category</strong></td>
			<td>"+categ+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>PAN Number</strong></td>
			<td>"+rs_rec.getString("pan_no")+"&nbsp;</td>
			<td><strong>TAN Number</strong></td>
			<td>"+rs_rec.getString("tan_no")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>TDS Code</strong></td>
			<td colspan='3'>"+tds_code+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Industry Type</strong></td>
			<td colspan='3'>"+rs_rec.getString("indus_type")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>TDS Method</strong></td>
			<td colspan='3'>tds_method +"* Checked TDS Posting Entry Wise
				and Unchecked for TDS Debit Note</td>
		</tr>
		<tr>
			<td><strong>Net Amount Round</strong></td>
			<td>"+net_amountRound+"&nbsp;</td>
			<td><strong>Is Overseas</strong></td>
			<td>"+is_overseas+"&nbsp;</td>
		</tr>
		<tr>
			<td colspan='4' align='left' bgcolor='#999999'><strong>Bank
					Details</strong></td>
		<tr>
			<td><strong>Account Name</strong></td>
			<td colspan='3'>"+rs_rec.getString("account_name")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Account Number</strong></td>
			<td colspan='3'>"+rs_rec.getString("account_number")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Bank Name</strong></td>
			<td colspan='3'>"+rs_rec.getString("bank_name")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Branch</strong></td>
			<td colspan='3'>"+rs_rec.getString("branch")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>IFSC Code for RTGS</strong></td>
			<td colspan='3'>"+rs_rec.getString("ifsc_rtgs")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>IFSC Code NEFT</strong></td>
			<td colspan='3'>"+rs_rec.getString("ifsc_neft")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>MICR Code</strong></td>
			<td colspan='3'>"+rs_rec.getString("micr_code")+"&nbsp;</td>
		</tr>
		<tr>
			<td><strong>Phone Number</strong></td>
			<td>"+rs_rec.getString("phone_number1")+"&nbsp;</td>
			<td>"+rs_rec.getString("phone_number2")+"&nbsp;</td>
			<td>"+rs_rec.getString("phone_number3")+"&nbsp;</td>
		</tr>
		<tr>
			<td rowspan='3'><strong>Bank Address</strong></td>
			<td colspan='3'>"+rs_rec.getString("bank_address1")+"&nbsp;</td>
		</tr>
		<tr>
			<td colspan='3'>"+rs_rec.getString("bank_address2")+"&nbsp;</td>
		</tr>
		<tr>
			<td colspan='3'>"+rs_rec.getString("bank_address3")+"&nbsp;</td>
		</tr>
		<tr>
			<td colspan='4' align='left' bgcolor='#c3c3c3'><strong>GST
					Details</strong></td>
		</tr>
		<tr>
			<td>Supplier GSTIN Registered ?</td>
			<td colspan='3'>"+rs_rec.getString("gstin_reg")+"</td>
		</tr>
		<tr>
			<td>GSTIN Number (If Yes)</td>
			<td colspan='3'>"+rs_rec.getString("GSTIN_number")+"</td>
		</tr>
		<tr>
			<td>Is Line Item GST Round</td>
			<td colspan='3'>"+rs_rec.getString("line_itemgstround")+"</td>
		</tr>
		<tr>
			<td>State</td>
			<td colspan='3'>"+rs_rec.getString("state_gst")+"</td>
		</tr> 
	</table>
</body>
</html>