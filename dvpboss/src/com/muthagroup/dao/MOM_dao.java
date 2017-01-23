package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.connectionUtil.ConnectionUrl;
import com.muthagroup.vo.MOM_vo;

public class MOM_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());	
	public void MOM_Configure(MOM_vo bean, HttpSession session,
			HttpServletResponse response) {
		try {
			Connection con =null;
			Connection con_local =Connection_Utility.getConnection();;
		
			int str_input = bean.getComp();  
			
			if(str_input==1){
			con = ConnectionUrl.getMEPLH21ERP();
			}
			if(str_input==2){
			con = ConnectionUrl.getMEPLH25ERP();
			}
			if(str_input==3){
			con = ConnectionUrl.getFoundryERPNEWConnection();
			}
			if(str_input==4){
			con = ConnectionUrl.getK1ERPConnection();
			}
			if(str_input==5){
			con = ConnectionUrl.getDIERPConnection();
			} 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			
			PreparedStatement ps_partname = con.prepareStatement("select * from MSTMATERIALS where CODE='" + bean.getPartcode() + "'");
			ResultSet rs_partname = ps_partname.executeQuery();
			while (rs_partname.next()) {
				bean.setPartname(rs_partname.getString("NAME"));
			}
			
			System.err.println("data = = " + bean.getComp()+"  " + bean.getPartcode()+"  " + bean.getPartname()+"  " + bean.getMOM_date()+ "  " + uid+"  " +bean.getDoc_filename());
			
			PreparedStatement ps_addStories = con_local.prepareStatement("insert into dev_mom_tbl(company,part_code,part_name,mom_date,attached_date,created_by,attachment,attach_name,updated_date,department,enable,last_updated_by)values(?,?,?,?,?,?,?,?,?,?,?,?)");
			ps_addStories.setInt(1, bean.getComp());
			ps_addStories.setString(2, bean.getPartcode());
			ps_addStories.setString(3, bean.getPartname());
			ps_addStories.setDate(4, bean.getMOM_date());
			ps_addStories.setDate(5, curr_Date);
			ps_addStories.setInt(6, uid);   	
			ps_addStories.setBlob(7, bean.getBlob_doc());
			ps_addStories.setString(8, bean.getDoc_filename());
			ps_addStories.setDate(9, curr_Date);
			ps_addStories.setInt(10, 7);
			ps_addStories.setInt(11, 1);
			ps_addStories.setInt(12, uid);
			
			int up = ps_addStories.executeUpdate();
			
			if(up>0){
				String result ="MOM is configured ";
				response.sendRedirect("MOM_Sheet.jsp?result="+result);
			}else {
				String result ="Error Occurred !!!";
				response.sendRedirect("MOM_Configure.jsp?result="+result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}