<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Approval</title>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
	});
</script>
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: left;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
</head>
<body>
	<%
		//Email Configuration =======>>
		try {
			String cust_name="",part_name="",part_no="",project_lead="",machiningFrom="",machiningVendor="",casting_from="",
					cating_vendor="",related_person="",revision_no="",revision_date="",planned_startDate="",
					planned_endDate="",actual_StartDate="",actual_endDate="",
					marketing_approval="",po_cust="",posate_cust="",po_dev_date="";
			int ftct=0,ftctavl=0,fxCount=0,fxAvailCt=0,ctl=0,ctl_avil=0,gct=0,gctl_avail=0;
			int shedule=0;
			ArrayList mailId = new ArrayList();
			int statusMail = 0;
			int plant_id=0, cast_id=0,castVendor=0;
			int basic_id = Integer
					.parseInt(request.getParameter("sheetId"));

			System.out.println("Basic Id = " + basic_id);

			Date curr_Date = new java.sql.Date(System.currentTimeMillis());
			//--------------------------------------------------------------------------------------------------------------------
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps_mailRel = con
					.prepareStatement("select * from automail_rel_tbl where Software_Id=5");
			ResultSet rs_mailRel = ps_mailRel.executeQuery();
			while (rs_mailRel.next()) {

				PreparedStatement ps_automail = con
						.prepareStatement("select * from automail where Sr_no="
								+ rs_mailRel.getInt("Sr_no"));
				ResultSet rs_automail = ps_automail.executeQuery();
				while (rs_automail.next()) {

					mailId.add(rs_automail.getString("Email"));

					PreparedStatement ps_user = con
							.prepareStatement("select * from user_tbl where U_Id="+ rs_automail.getInt("U_Id"));
					ResultSet rs_user = ps_user.executeQuery();

					while (rs_user.next()) {

						PreparedStatement ps_check = con
								.prepareStatement("select * from dev_approval_tbl where basic_id="
										+ basic_id
										+ " and u_id="
										+ rs_user.getInt("U_Id"));
						ResultSet rs_check = ps_check.executeQuery();

						rs_check.last();
						int mb2 = rs_check.getRow();
						rs_check.beforeFirst();

						if (mb2 <= 0) {

							System.out.println("UId is = "
									+ rs_user.getInt("U_Id"));
							PreparedStatement ps_approval = con
									.prepareStatement("insert into dev_approval_tbl (U_Id,Basic_Id,Approval_Date,Approval_id) values(?,?,?,?)");
							ps_approval.setInt(1, rs_user.getInt("U_Id"));
							ps_approval.setInt(2, basic_id);
							ps_approval.setDate(3, curr_Date);
							ps_approval.setInt(4, 2);
							int aprl = ps_approval.executeUpdate();

							//--------------------------------------------------------------------------------------------------------------------
						}

						PreparedStatement ps_approval_hist = con
								.prepareStatement("insert into dev_approval_tbl_hist (U_Id,Basic_Id,Approval_Date,dev_approval_date_hist,Approval_id) values(?,?,?,?,?)");

						ps_approval_hist.setInt(1, rs_user.getInt("U_Id"));
						ps_approval_hist.setInt(2, basic_id);
						ps_approval_hist.setDate(3, curr_Date);
						ps_approval_hist.setDate(4, curr_Date);
						ps_approval_hist.setInt(5, 2);
						int aprl_hist = ps_approval_hist.executeUpdate();

					}
				}
			}
			boolean flag = true;
			System.out.println("list ===== > " +mailId);
			//-----------------------------------------------------------------------------------------------------------------
			PreparedStatement ps_getBasicInfo = con
								.prepareStatement("select * from dev_basicinfo_tbl where Basic_id="
										+ basic_id);
						ResultSet rs_getBasicInfo = ps_getBasicInfo.executeQuery();
						while (rs_getBasicInfo.next()) {
		 		PreparedStatement ps_getCustName = con
										.prepareStatement("select Cust_Name from customer_tbl where Cust_Id="
												+ rs_getBasicInfo.getInt("Cust_Id"));
								ResultSet rs_getCustName = ps_getCustName.executeQuery();
								while (rs_getCustName.next()) {
									cust_name =  rs_getCustName.getString("Cust_Name");
						}
								PreparedStatement ps_getPartName = con
										.prepareStatement("select Part_Name from cs_part_name_tbl where PartName_Id="
												+ rs_getBasicInfo.getInt("PartName_Id"));
								ResultSet rs_getPartName = ps_getPartName.executeQuery();
								while (rs_getPartName.next()) {
								part_name = rs_getPartName.getString("Part_Name");
						}

								PreparedStatement ps_getPartNo = con
										.prepareStatement("select Part_no from cs_part_no_tbl where PartNo_Id="
												+ rs_getBasicInfo.getInt("PartNo_Id"));
								ResultSet rs_getPartNo = ps_getPartNo.executeQuery();

								while (rs_getPartNo.next()) {
					  			part_no = rs_getPartNo.getString("Part_No");
						}
								PreparedStatement ps_getProjectLead = con
										.prepareStatement("select Project_Lead from dev_basic_projectlead_rel_tbl where basic_id="
												+ basic_id);
								ResultSet rs_getProjectLead = ps_getProjectLead
										.executeQuery();

								while (rs_getProjectLead.next()) {
									PreparedStatement ps_getUName = con
											.prepareStatement("select U_Name from User_Tbl where U_Id="
													+ rs_getProjectLead
															.getInt("Project_Lead"));
									ResultSet rs_getUName = ps_getUName.executeQuery();
									while (rs_getUName.next()) {
								project_lead = rs_getUName.getString("U_Name"); 
						}
								}

								PreparedStatement ps_plant = con
										.prepareStatement("select Plant_Id from  dev_basic_plant_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_plant = ps_plant.executeQuery();
								while (rs_plant.next()) {
									plant_id = rs_plant.getInt("Plant_Id");
								}

								
								if (plant_id != 0) {
					%>
					<%
						PreparedStatement ps_plantId = con
											.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
													+ plant_id);
									ResultSet rs_plantId = ps_plantId.executeQuery();
									while (rs_plantId.next()) {
						machiningFrom = rs_plantId.getString("Company_Name"); 
						}
					}
					 
					//--------------------------------------------------------------------------------------------------------------------------------------
								PreparedStatement machinVend = con
										.prepareStatement("select * from dev_basic_plantvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_machinVend = machinVend.executeQuery();
								rs_machinVend.last();
								int vd = rs_machinVend.getRow();
								rs_machinVend.beforeFirst();

								if (vd > 0) {

									while (rs_machinVend.next()) {

										PreparedStatement ps_plantvd = con
												.prepareStatement("select * from dev_plantvendor_tbl where plantvendor_id="
														+ rs_machinVend
																.getInt("plantvendor_id"));
										ResultSet rs_plantvd = ps_plantvd.executeQuery();
										while (rs_plantvd.next()) {
 								machiningVendor =	rs_plantvd.getString("plantvendor_name"); 
						}

									}
								}  
 
						PreparedStatement ps_cast = con
										.prepareStatement("select * from dev_basic_casting_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_cast = ps_cast.executeQuery();
								while (rs_cast.next()) {
									cast_id = rs_cast.getInt("Casting_From_Id");
								}

								PreparedStatement ps_castVendor = con
										.prepareStatement("select * from dev_basic_castingvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_castVendor = ps_castVendor.executeQuery();
								while (rs_castVendor.next()) {
									castVendor = rs_castVendor.getInt("CastingVendor_Id");
								} 
								if (cast_id != 0) {

									PreparedStatement ps_castingFrom = con
											.prepareStatement("select * from user_tbl_company where Company_Id="
													+ cast_id);
									ResultSet rs_castingFrom = ps_castingFrom
											.executeQuery();
									while (rs_castingFrom.next()) {
					casting_from = rs_castingFrom.getString("Company_Name");
						}
								}   
						//---------------------------------------------------------------------------------------------------------------------
								PreparedStatement ps_castVend = con
										.prepareStatement("select * from dev_basic_castingvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_castVend = ps_castVend.executeQuery();

								rs_castVend.last();
								int ctvd = rs_castVend.getRow();
								rs_castVend.beforeFirst();

								if (ctvd > 0) {
									while (rs_castVend.next()) {

										PreparedStatement p_castVendor = con
												.prepareStatement("select * from dev_castingvendor_tbl where castingvendor_id="
														+ rs_castVend
																.getInt("castingvendor_id"));
										ResultSet r_castVendor = p_castVendor
												.executeQuery();
										while (r_castVendor.next()) {
 								cating_vendor = r_castVendor.getString("castingvendor_name");
						}

									}
								}					
								PreparedStatement ps_getRelatedPerson = con
										.prepareStatement("select Related_Person from dev_basic_relperson_rel_tbl where basic_Id="
												+ basic_id);
								ResultSet rs_getRealtedPerson = ps_getRelatedPerson
										.executeQuery();

								rs_getRealtedPerson.last();
								int rtper = rs_getRealtedPerson.getRow();
								rs_getRealtedPerson.beforeFirst();

								while (rs_getRealtedPerson.next()) { 

									PreparedStatement ps_RelUName = con
											.prepareStatement("select * from user_tbl where U_Id="
													+ rs_getRealtedPerson
															.getInt("Related_Person"));
									ResultSet rs_RelUName = ps_RelUName.executeQuery();
									while (rs_RelUName.next()) {
										related_person = rs_RelUName.getString("U_Name");
									}
								}
				revision_no = rs_getBasicInfo.getString("Revision_No");
				revision_date = rs_getBasicInfo.getDate("Revision_Date").toString();
			planned_startDate = rs_getBasicInfo.getDate("Planned_Start_Date").toString(); 
			planned_endDate = rs_getBasicInfo.getDate("Planned_End_Date").toString();
			actual_StartDate = rs_getBasicInfo.getDate("Actual_Start_Date").toString();
			actual_endDate = rs_getBasicInfo.getDate("Actual_End_Date").toString();
			marketing_approval = rs_getBasicInfo.getString("Mkt_Approval");
			
			shedule = rs_getBasicInfo.getInt("Schedule_Per_Month");
			po_cust = rs_getBasicInfo.getString("PO_No_From_Cust");
			posate_cust = rs_getBasicInfo.getDate("PO_Date_From_Cust").toString();
			po_dev_date =  rs_getBasicInfo.getDate("PO_Rcvd_At_Dev_Date").toString();
			
			//---------------------------------------------------------------------------------------------------------------------------
			
			PreparedStatement ps_ft=con.prepareStatement("select * from dev_foundrytoolingdata_tbl where basic_id="+ basic_id);
			ResultSet rs_ft=ps_ft.executeQuery();
			while(rs_ft.next()){
				System.out.print("ftct" +  rs_ft.getInt("Pattern_Avail"));
				ftct = ftct + rs_ft.getInt("Pattern_Avail") + rs_ft.getInt("CoreBox_Avail"); 
				ftctavl = ftctavl + rs_ft.getInt("Pattern_Required") + rs_ft.getInt("CoreBox_Required");
			} 
			ftct=0; 
			ftctavl=0; 			
			PreparedStatement ps_oprelId=con.prepareStatement("select * from dev_opnandopnno_basic_rel_tbl where basic_id="+ basic_id);
			ResultSet rs_oprelId=ps_oprelId.executeQuery();
			while(rs_oprelId.next()){
			
				PreparedStatement ps_fxct=con.prepareStatement("select * from dev_fixturedata_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
				ResultSet rs_fxct = ps_fxct.executeQuery();
				while(rs_fxct.next()){
					fxCount= fxCount + rs_fxct.getInt("fixture_qty");
					fxAvailCt= fxAvailCt + rs_fxct.getInt("avail_qty");
					//System.out.println("Fixture Qty = "+basic_id+"\n" + rs_fxct.getInt("fixture_qty") + "\n add" + fxCount);
				}
			 	
				PreparedStatement ps_ctool=con.prepareStatement("select * from dev_cuttingtool_data_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
				ResultSet rs_ctool = ps_ctool.executeQuery();
				while(rs_ctool.next()){
					ctl= ctl + rs_ctool.getInt("ctool_quantity");
					ctl_avil= ctl_avil + rs_ctool.getInt("avail_qty"); 
				}
			
			
				PreparedStatement ps_gauges=con.prepareStatement("select * from dev_gaugedata_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
				ResultSet rs_gauges = ps_gauges.executeQuery();
				while(rs_gauges.next()){
					gct= gct + rs_gauges.getInt("gauge_quantity");
					gctl_avail= gctl_avail + rs_gauges.getInt("avail_qty"); 
				} 						 
			}
			ps_oprelId.close();
			rs_oprelId.close();  
			
			//---------------------------------------------------------------------------------------------------------------
			
			
		 		}
		%><% 
			//-----------------------------------------------------------------------------------------------------------------

			String host = "send.one.com";
			String user = "dvpboss@muthagroup.com";
			String pass = "dvpboss@xyz";

			String from = "dvpboss@muthagroup.com";
			String subject = "New DVP Sheet Approval required";
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************

			String[] recipients = new String[mailId.size()];

			for (int g = 0; g < mailId.size(); g++) {
				recipients[g] = mailId.get(g).toString();
			}

			// *********************************************************************************************

			Properties props = System.getProperties();
			props.put("mail.host", host);
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 2525);
			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(sessionDebug);
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from));
			InternetAddress[] addressTo = new InternetAddress[recipients.length];

			for (int i = 0; i < recipients.length; i++) {
				addressTo[i] = new InternetAddress(recipients[i]);

			}

			msg.setRecipients(Message.RecipientType.TO, addressTo);

			msg.setSubject(subject);
			msg.setSentDate(curr_Date);

		msg.setContent("<p><b style='color: #0D265E;font-size: 12px;'>This is an automatically generated email from DVPBOSS</b></p><table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"+
		"<th scope='col'>S.No</th>"+
		"<th scope='col'>Customer</th>"+
		"<th scope='col'>Part Name</th>"+
		"<th scope='col'>Part No</th>"+
		"<th scope='col'>Project Lead</th>"+
		"<th scope='col'>Machining From</th>"+
		"<th scope='col'>Machining Vendor</th>"+
		"<th scope='col'>Casting From</th>"+
		"<th scope='col'>Casting Vendor</th>"+
		"<th scope='col'>Related Person</th>"+
		"<th scope='col'>Revision No</th>"+
		"</tr>"+
"<tr style='font-size: 12px;text-align: center;'>"+
"<td>"+basic_id+"</td>"+
"<td>"+cust_name+"</td>"+
"<td>"+part_name+"</td>"+
"<td>"+part_no+"</td>"+
"<td>"+project_lead+"</td>"+
"<td>"+machiningFrom+"</td>"+
"<td>"+machiningVendor+"</td>"+
"<td>"+casting_from+"</td>"+
"<td>"+castVendor+"</td>"+
"<td>"+related_person+"</td>"+
"<td>"+revision_no+"</td>"+
"</tr>"+
		"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"+
			"<th scope='col'><strong>Revision Date</strong></th>"+
			"<th scope='col'><strong>Start Date (Planned)</strong></th>"+
			"<th scope='col'><strong>End Date (Planned) </strong></th>"+
			"<th><strong>Start Date (Actual) </strong></th>"+
			"<th><strong>End Date (Actual) </strong></th>"+
			"<th scope='col'><strong>Marketing<br /> Approval</strong></th>"+
			"<th scope='col'><strong>Schedule/<br /> Month</strong></th>"+
			"<th scope='col'><strong>PO No</strong></th>"+
			"<th scope='col'><strong>PO Date <br /></strong></th>"+
			"<th scope='col'><strong>PO Received<br />(Development)<br /></strong></th>"+
			"<th>&nbsp;</th>"+ 
		"</tr>"+
"<tr style='font-size: 12px;text-align: center;'>"+
"<td>"+revision_date+"</td>"+
"<td>"+planned_startDate+"</td>"+
"<td>"+planned_endDate+"</td>"+
"<td>"+actual_StartDate+"</td>"+
"<td>"+actual_endDate+"</td>"+
"<td>"+marketing_approval+"</td>"+
"<td>"+shedule+"</td>"+
"<td>"+po_cust+"</td>"+
"<td>"+posate_cust+"</td>"+
"<td>"+po_dev_date+"</td>"+
"<td></td>"+
"</tr></table>"+

"<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"+  
"<td colspan='2'><strong>Foundry Tooling</strong></td>"+
"<td colspan='2'><strong>Fixtures</strong></td>"+
"<td colspan='2'><strong>Cutting Tooling's</strong></td>"+
"<td colspan='2'><strong>Gauges</strong></td>"+ 
"</tr>"+
"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"+
"<td><strong>Reqd</strong></td>"+
"<td><strong>Avail</strong></td>"+ 
"<td><strong>Reqd</strong></td>"+
"<td><strong>Avail</strong></td>"+ 
"<td><strong>Reqd</strong></td>"+
"<td><strong>Avail</strong></td>"+ 
"<td><strong>Reqd</strong></td>"+
"<td><strong>Avail</strong></td>"+ 
"</tr>"+
"<tr style='font-size: 12px;text-align: center;'>"+
"<td>"+ftct+"</td>"+
"<td>"+ftctavl+"</td>"+
"<td>"+fxCount+"</td>"+
"<td>"+fxAvailCt+"</td>"+
"<td>"+ctl+"</td>"+
"<td>"+ctl_avil+"</td>"+
"<td>"+gct+"</td>"+
"<td>"+gctl_avail+"</td>"+
"</tr>"
+ 
"</table>"+
"<table>"+
	"<tr>"+
	"<td style='color:green;'><b>Approval is required For Approval </b><a href='http://192.168.0.7/dvpboss/'>Click Here</a></td>"+ 
	"</tr>"+
	"</table>"+
	"<table>"+
	"<tr>"+
	"<td><b>Thanks & Regards,</b></td>"+ 
	"</tr>"+ 
	"<tr>"+
	"<td style='font-size: 12px;'>Mutha Group Satara</td>"+
	"</tr>"+
	"</table>"+
	"<hr>"+
	"<table>"+
	"<tr>"+
	"<td><b>Disclaimer :</b></td>"+
	"</tr>"+
	"<tr>"+
	"<td><font style='font-size: 11px;color: #10114D;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</font></td>"+
	"</tr>"+
	"</table>","Text/html");

			try {

				Transport transport = mailSession.getTransport("smtp");

				if (transport.equals("")) {

					// transport.connect(host, user, pass);
					// transport.sendMessage(msg, msg.getAllRecipients());
					PreparedStatement ps_mailcheck = con
							.prepareStatement("update dev_approval_tbl set mail_status=0 where Basic_Id="
									+ basic_id);
					int mail = ps_mailcheck.executeUpdate();
					System.out.println("In Loop");

				} else {
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());

					PreparedStatement ps_mailcheck = con
							.prepareStatement("update dev_approval_tbl set mail_status=1 where Basic_Id="
									+ basic_id);
					int mail = ps_mailcheck.executeUpdate();

				}

				transport.close();
				flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			}

			PreparedStatement ps_mailStatus = con
					.prepareStatement("select * from dev_approval_tbl where Basic_Id="
							+ basic_id);
			ResultSet rs_mailstatus = ps_mailStatus.executeQuery();
			while (rs_mailstatus.next()) {
				statusMail = rs_mailstatus.getInt("mail_status");
			}
			System.out.println("status mail = " + statusMail);
			if (statusMail != 0) {
	%>
	<span id="getApr"><strong style="color: green;">Approval
			mail successfully sent </strong> </span>
	<%
		} else {
	%>

	<span id="getApr"><strong style="color: red;"> An error
			occurred while sending mail !!!</strong> </span>
	<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// *******************
	%>



</body>
</html>