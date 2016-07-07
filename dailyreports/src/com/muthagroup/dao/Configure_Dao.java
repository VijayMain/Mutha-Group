package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.conn_Url.Connection_Util;
 

public class Configure_Dao {

	public void setConfiguration(String comp, int reportid, ArrayList accesslist, HttpServletResponse response) {
		try {
			Connection con = null,con_Local=null;
			con_Local = Connection_Util.getLocalDatabase();
			
			if(comp.equalsIgnoreCase("101")){	
				con = Connection_Util.getMEPLH21ERP();
			}
			if(comp.equalsIgnoreCase("102")){	
				con = Connection_Util.getMEPLH25ERP();
			}		 
			if(comp.equalsIgnoreCase("103")){
				con = Connection_Util.getFoundryERPNEWConnection();
			}
			if(comp.equalsIgnoreCase("105")){	
				con = Connection_Util.getDIERPConnection();
			}
			if(comp.equalsIgnoreCase("106")){	
				con = Connection_Util.getK1ERPConnection();
			}
			
			PreparedStatement ps_matName = null;
			ResultSet rs_matName = null;
			String matName = "",refmat_code="";
			int up=0;
			
			PreparedStatement ps_del = con_Local.prepareStatement("delete from dailyreports_config_tbl where company_id="+comp+" and reports_id="+reportid);
			int delRp = ps_del.executeUpdate();
			
			
			for(int i=0;i<accesslist.size();i++){
			PreparedStatement ps_up = con_Local.prepareStatement("insert into dailyreports_config_tbl(reports_id,matcode,matname,company_id,ref_matcode)values(?,?,?,?,?)");
			ps_up.setInt(1, reportid);
			ps_up.setString(2, accesslist.get(i).toString()); 
			ps_matName = con.prepareStatement("select * from MSTMATERIALS where MATERIAL_TYPE in(101,103,104) and CODE='"+accesslist.get(i).toString()+"'");
			rs_matName = ps_matName.executeQuery();
			while (rs_matName.next()) {
					matName = rs_matName.getString("Name");
			}
			rs_matName.close();
			PreparedStatement ps_bom = con.prepareStatement("select * from MSTMATBOMRAW where MAT_CODE='"+accesslist.get(i).toString()+"'");	
			ResultSet rs_bom =ps_bom.executeQuery();
			while (rs_bom.next()) {
				refmat_code = rs_bom.getString("REF_MATCODE");
			}
			rs_bom.close();
			ps_up.setString(3, matName);
			ps_up.setInt(4, Integer.parseInt(comp));
			ps_up.setString(5, refmat_code);
			up = ps_up.executeUpdate();
			}
			if(up>0){
				String success = "Data inserted successfully....";
				response.sendRedirect("Configure.jsp?success="+success); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void setConfig_subReport(String comp, int reportid,
			ArrayList accesslist, HttpServletResponse response, HttpServletRequest request) {
		try {
			Connection con = null,con_Local=null;
			con_Local = Connection_Util.getLocalDatabase();
			
			String from = request.getParameter("datefrom");
			String to = request.getParameter("tofrom");   
			String matsub = request.getParameter("custsub");   
			
			String mat_code ="",cust_code="";
			int up=0;
			
			//	System.out.println("data = " + from + " = " + to + " = " + matsub);
			
			if(comp.equalsIgnoreCase("101")){
				con = Connection_Util.getMEPLH21ERP();
			}
			if(comp.equalsIgnoreCase("102")){	
				con = Connection_Util.getMEPLH25ERP();
			}		 
			if(comp.equalsIgnoreCase("103")){
				con = Connection_Util.getFoundryERPNEWConnection();
			}
			if(comp.equalsIgnoreCase("105")){	
				con = Connection_Util.getDIERPConnection();
			}
			if(comp.equalsIgnoreCase("106")){	
				con = Connection_Util.getK1ERPConnection();
			}
			 
			
			
			
			PreparedStatement ps_access = null;
			ResultSet rs_access = null;
			
			ps_access = con.prepareStatement("select * from MSTMATERIALS where NAME='"+matsub+"' and MATERIAL_TYPE=101");
			rs_access = ps_access.executeQuery();
			while (rs_access.next()) {
				mat_code = rs_access.getString("CODE");
			} 
			
			PreparedStatement ps_del = con_Local.prepareStatement("delete from dailyreports_config_tbl where company_id="+comp+" and reports_id="+reportid + " and matname='"+matsub+"'");
			int delRp = ps_del.executeUpdate();
			
			for(int i=0;i<accesslist.size();i++){
			
				ps_access = con.prepareStatement("select * from MSTACCTGLSUB where SUBGL_LONGNAME='"+accesslist.get(i).toString()+"'");
				rs_access = ps_access.executeQuery();
				while (rs_access.next()) {
					cust_code = rs_access.getString("SUB_GLACNO");
				}
				
				ps_access = con_Local.prepareStatement("insert into dailyreports_config_tbl (reports_id,matcode,matname,company_id,cust_name,cust_code)values(?,?,?,?,?,?)");
				ps_access.setInt(1, reportid);
				ps_access.setString(2, mat_code);
				ps_access.setString(3, matsub);
				ps_access.setInt(4, Integer.parseInt(comp));
				ps_access.setString(5, accesslist.get(i).toString());
				ps_access.setString(6, cust_code);
				
				up = ps_access.executeUpdate();				
			}
			
			if(up>0){
				String success = "Data inserted successfully....";
				response.sendRedirect("Configure.jsp?success="+success); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}