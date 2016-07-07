package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import com.muthagroup.conn_Url.Connection_Util;

public class ConfigureVendor_Dao {

	public void setConfiguration(String comp, String report, ArrayList accesslist, HttpServletResponse response) {
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
			String vendorName = "";
			int up=0;
			
			PreparedStatement ps_del = con_Local.prepareStatement("delete from company_vendor_rel_tbl where company_id="+Integer.parseInt(comp));
			int delRp = ps_del.executeUpdate();
			
			
			for(int i=0;i<accesslist.size();i++){
			PreparedStatement ps_up = con_Local.prepareStatement("insert into company_vendor_rel_tbl(company_id,vendor_code,vendor_name,reports_id)values(?,?,?,?)");
			ps_up.setInt(1, Integer.parseInt(comp));
			ps_up.setString(2, accesslist.get(i).toString());
			
			ps_matName = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLACNO='"+accesslist.get(i).toString()+"'");
			rs_matName = ps_matName.executeQuery();
				while (rs_matName.next()) {
					vendorName = rs_matName.getString("SUBGL_LONGNAME");
				}				
			ps_up.setString(3, vendorName);
			ps_up.setInt(4, Integer.parseInt(report));
			
			up = ps_up.executeUpdate();
			}			
			if(up>0){
				String success = "Data inserted successfully....";
				response.sendRedirect("Comp_Vendor.jsp?success="+success); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
