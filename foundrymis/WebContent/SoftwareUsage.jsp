<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.security.acl.LastOwnerException"%>
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
<title>In-house Software Usage</title> 
<STYLE TYPE="text/css" MEDIA=all>
.td1 { 
	font-size: 10px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
.tftable tr {
	background-color: white;
	font-size: 10px;
}

.th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
}

A:link {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

A:visited {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

.div_freezepanes_wrapper {
	font-size:10px;
	position: relative; 
	width: 80%;
	height: 540px;
	overflow: hidden;
	background: #fff;
	border-style: ridge; 
}

.div_verticalscroll {
	font-size:10px;
	position: absolute;
	right: 0px;
	width: 18px;
	height: 100%;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonUp {
	width: 20px;
	position: absolute;
	top: 2px;
}

.buttonDn {
	width: 20px;
	position: absolute;
	bottom: 22px;
}

.div_horizontalscroll {
	font-size:10px;
	position: absolute;
	bottom: 0px;
	width: 0%;
	height: 0px;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonRight {
	width: 20px;
	position: absolute;
	left: 0px;
	padding-top: 2px;
}

.buttonLeft {
	width: 20px;
	position: absolute;
	right: 22px;
	padding-top: 2px;
}
</STYLE>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<%  
try{ 
	ArrayList arr = new ArrayList();
	if (request.getAttribute("users") != null) {
		arr = (ArrayList) request.getAttribute("users"); 
	} else {
		System.out.println("There are no values in the arraylist");
	}
	String fst_date = request.getAttribute("fst_date").toString();
	String lst_date = request.getAttribute("lst_date").toString();
	String fst_disp = request.getAttribute("fst_disp").toString();
	String lst_disp = request.getAttribute("lst_disp").toString();
	int cz=0,ecn=0,dvp=0,itt=0;
	Connection con = Connection_Utility.getConnection();
	%>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">&nbsp;&nbsp;&nbsp;
User Wise In-House Software Usage Report from <%=fst_disp %> to <%=lst_disp %></strong><br/>
 
<strong style="font-family: Arial;font-size: 15px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;&nbsp;BACK</a> 
</strong> 
		<div style="background-color: white;padding-left: 20px;height: 530px;overflow: scroll;"> 
			 
			<table id="t1" border="1" cellpadding=2 style="width:30%; border: 1px solid #000;">  
				 <tr style="font-family: Arial;font-size: 12px;"> 
					<th scope="col" class="th">Software Name</th>
					<th scope="col" class="th">Counts</th>  
				</tr>
			<%
			ArrayList uID = new ArrayList();
			String comma = ""; 
			
			StringBuilder commaSepValueBuilder = new StringBuilder();
			for(int i=0;i<arr.size();i++){
			%>
				<tr style="font-family: Arial;font-size: 13px;"> 
					<td scope="col" colspan="2" align="left" bgcolor="#CADBE6"><b><%=arr.get(i).toString() %> &#8658;</b></td>  
				</tr>			
			<%
			PreparedStatement ps_getusers_id = con.prepareStatement("select * from user_tbl where U_Name like '%"+arr.get(i).toString()+"%' and enable_id=1");
			ResultSet rs_getuID = ps_getusers_id.executeQuery();
			while(rs_getuID.next()){ 
				uID.add(rs_getuID.getInt("U_Id"));
			}
			ps_getusers_id.close();
			rs_getuID.close();
			
			//Looping through the list
			for ( int j = 0; j< uID.size(); j++){ 
			  commaSepValueBuilder.append(uID.get(j)); 
			  if ( j != uID.size()-1){
			    commaSepValueBuilder.append(", ");
			  }
			} 
			
			PreparedStatement pscz = con.prepareStatement("select count(*) from complaint_tbl where U_Id in("+commaSepValueBuilder.toString()+") and Complaint_Date between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rscz = pscz.executeQuery();
			while(rscz.next()){
				cz = rscz.getInt("count(*)");
			}
			pscz.close();
			rscz.close();
			
			PreparedStatement pscz1 = con.prepareStatement("select count(*) from complaint_tbl_action where U_Id in("+commaSepValueBuilder.toString()+") and Action_Date between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rscz1 = pscz1.executeQuery();
			while(rscz1.next()){
				cz = cz + rscz1.getInt("count(*)");
			}
			pscz1.close();
			rscz1.close();
			
			PreparedStatement psecn = con.prepareStatement("select count(*) from cr_tbl where U_Id in("+commaSepValueBuilder.toString()+") and CR_Date between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn = psecn.executeQuery();
			while(rsecn.next()){
				ecn = rsecn.getInt("count(*)");
			}
			psecn.close();
			rsecn.close();
			
			PreparedStatement psecn1 = con.prepareStatement("select count(*) from cr_tbl_action where U_Id in("+commaSepValueBuilder.toString()+") and Action_Date between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn1 = psecn1.executeQuery();
			while(rsecn1.next()){
				ecn = ecn + rsecn1.getInt("count(*)");
			}
			psecn.close();
			rsecn.close();
			
			PreparedStatement psecn_cust = con.prepareStatement("select count(*) from  crc_tbl  where U_Id in("+commaSepValueBuilder.toString()+") and CRC_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn_cust = psecn_cust.executeQuery();
			while(rsecn_cust.next()){
				ecn = ecn + rsecn_cust.getInt("count(*)");
			}
			psecn_cust.close();
			rsecn_cust.close();
			
			PreparedStatement psecn_cust1 = con.prepareStatement("select count(*) from  crc_tbl_action  where U_Id in("+commaSepValueBuilder.toString()+") and  Action_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn_cust1 = psecn_cust1.executeQuery();
			while(rsecn_cust1.next()){
				ecn = ecn + rsecn_cust1.getInt("count(*)");
			}
			psecn_cust1.close();
			rsecn_cust1.close();
			
			PreparedStatement psecn_appr = con.prepareStatement("select count(*) from  cr_tbl_approval  where U_Id in("+commaSepValueBuilder.toString()+") and  CR_Approval_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn_appr = psecn_appr.executeQuery();
			while(rsecn_appr.next()){
				ecn = ecn + rsecn_appr.getInt("count(*)");
			}
			psecn_appr.close();
			rsecn_appr.close();
			
			PreparedStatement psecn_appr1 = con.prepareStatement("select count(*) from  crc_tbl_approval  where U_Id in("+commaSepValueBuilder.toString()+") and  CRC_Approval_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn_appr1 = psecn_appr1.executeQuery();
			while(rsecn_appr1.next()){
				ecn = ecn + rsecn_appr1.getInt("count(*)");
			}
			psecn_appr1.close();
			rsecn_appr1.close();
			
			PreparedStatement psecn_it = con.prepareStatement("select count(*) from  it_user_requisition  where U_Id in("+commaSepValueBuilder.toString()+") and  Req_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn_it = psecn_it.executeQuery();
			while(rsecn_it.next()){
				itt = rsecn_it.getInt("count(*)");
			}
			psecn_it.close();
			rsecn_it.close();
			
			PreparedStatement psecn_it1 = con.prepareStatement("select count(*) from  it_requisition_remark_tbl  where Done_By like '%"+arr.get(i).toString()+"' and  Remark_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rsecn_it1 = psecn_it1.executeQuery();
			while(rsecn_it1.next()){
				itt = itt + rsecn_it1.getInt("count(*)");
			}
			psecn_it1.close();
			rsecn_it1.close();
			
			PreparedStatement ps_dvp = con.prepareStatement("select count(*) from  dev_basicinfo_tbl  where Created_By in("+commaSepValueBuilder.toString()+") and  Created_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp = ps_dvp.executeQuery();
			while(rs_dvp.next()){
				dvp = rs_dvp.getInt("count(*)");
			}
			ps_dvp.close();
			rs_dvp.close();
			
			PreparedStatement ps_dvp1 = con.prepareStatement("select count(*) from  dev_approval_tbl  where U_Id in("+commaSepValueBuilder.toString()+") and  Approval_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp1 = ps_dvp1.executeQuery();
			while(rs_dvp1.next()){
				dvp = dvp + rs_dvp1.getInt("count(*)");
			}
			ps_dvp1.close();
			rs_dvp1.close();
			
			PreparedStatement ps_dvp_op = con.prepareStatement("select count(*) from  dev_opn_opnno_rel_tbl  where Created_By in("+commaSepValueBuilder.toString()+") and  Created_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_op = ps_dvp_op.executeQuery();
			while(rs_dvp_op.next()){
				dvp = dvp + rs_dvp_op.getInt("count(*)");
			}
			ps_dvp_op.close();
			rs_dvp_op.close();
			
			PreparedStatement ps_dvp_mcinfo = con.prepareStatement("select count(*) from  dev_mcdata_tbl  where created_by in("+commaSepValueBuilder.toString()+") and  created_date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_mcinfo = ps_dvp_mcinfo.executeQuery();
			while(rs_dvp_mcinfo.next()){
				dvp = dvp + rs_dvp_mcinfo.getInt("count(*)");
			}
			ps_dvp_mcinfo.close();
			rs_dvp_mcinfo.close();
			
			PreparedStatement ps_dvp_fix = con.prepareStatement("select count(*) from  dev_fixturedata_tbl  where created_by  in("+commaSepValueBuilder.toString()+") and  created_date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_fix = ps_dvp_fix.executeQuery();
			while(rs_dvp_fix.next()){
				dvp = dvp + rs_dvp_fix.getInt("count(*)");
			}
			ps_dvp_fix.close();
			rs_dvp_fix.close();
			
			PreparedStatement ps_dvp_ctool = con.prepareStatement("select count(*) from  dev_cuttingtool_data_tbl  where created_by  in("+commaSepValueBuilder.toString()+") and  created_date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_ctool = ps_dvp_ctool.executeQuery();
			while(rs_dvp_ctool.next()){
				dvp = dvp + rs_dvp_ctool.getInt("count(*)");
			}
			ps_dvp_ctool.close();
			rs_dvp_ctool.close();
			
			PreparedStatement ps_dvp_gauge = con.prepareStatement("select count(*) from  dev_gaugedata_tbl  where created_by  in("+commaSepValueBuilder.toString()+") and  created_date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_gauge = ps_dvp_gauge.executeQuery();
			while(rs_dvp_gauge.next()){
				dvp = dvp + rs_dvp_gauge.getInt("count(*)");
			}
			ps_dvp_gauge.close();
			rs_dvp_gauge.close();
			
			PreparedStatement ps_dvp_other = con.prepareStatement("select count(*) from  dev_otherdata_tbl  where created_by  in("+commaSepValueBuilder.toString()+") and  created_date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_other = ps_dvp_other.executeQuery();
			while(rs_dvp_other.next()){
				dvp = dvp + rs_dvp_other.getInt("count(*)");
			}
			ps_dvp_other.close();
			rs_dvp_other.close();
			
			PreparedStatement ps_dvp_internal = con.prepareStatement("select count(*) from  dev_intmaterial_movement_tbl  where created_by  in("+commaSepValueBuilder.toString()+") and  created_date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_internal = ps_dvp_internal.executeQuery();
			while(rs_dvp_internal.next()){
				dvp = dvp + rs_dvp_internal.getInt("count(*)");
			}
			ps_dvp_internal.close();
			rs_dvp_internal.close();
			
			PreparedStatement ps_dvp_fndtool = con.prepareStatement("select count(*) from  dev_foundrytoolingdata_tbl  where Created_By  in("+commaSepValueBuilder.toString()+") and  Created_Date  between '"+fst_date+"' and '"+lst_date+"'");
			ResultSet rs_dvp_fndtool = ps_dvp_fndtool.executeQuery();
			while(rs_dvp_fndtool.next()){
				dvp = dvp + rs_dvp_fndtool.getInt("count(*)");
			}
			ps_dvp_fndtool.close();
			rs_dvp_fndtool.close();
			%>
			 	<tr style="font-family: Arial;font-size: 11px;">
			 		<td scope="col" align="left" width="250">ComplaintZilla</td>
					<td scope="col" align="right"><%=cz %></td>
				</tr> 
				<tr style="font-family: Arial;font-size: 11px;">
			 		<td scope="col" align="left">ECN</td>
					<td scope="col" align="right"><%=ecn %></td>
				</tr>
				<tr style="font-family: Arial;font-size: 11px;">
			 		<td scope="col" align="left">IT Tracker</td>
					<td scope="col" align="right"><%=itt %></td>
				</tr>
				<tr style="font-family: Arial;font-size: 11px;">
			 		<td scope="col" align="left">DVP BOSS</td>
					<td scope="col" align="right"><%=dvp %></td>
				</tr>
			<%
			comma="";
			uID.clear();
			commaSepValueBuilder.setLength(0);
				}
			%>	
			</table> 	
<% 
} catch (Exception e) {
e.printStackTrace();   
}
%>
		</div>
		<br> <br>
</body>
</html>