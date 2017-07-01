package com.muthagroup.dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import com.muthagroup.connectionUtil.ConnectionUrl;
import com.muthagroup.vo.Masterconfigure_vo;

public class Masterconfigure_dao {
	private static final java.sql.Date currDate =new java.sql.Date(System.currentTimeMillis());
	public boolean addAccess(HttpSession session, Masterconfigure_vo vo) {
 
		boolean flag = false, flag1 = false;
		ArrayList soft = new ArrayList();
		try {
			Connection con_local = ConnectionUrl.getLocalDatabase(); 
			soft = vo.getSoft();
			String matType = vo.getMatType();  
			int registerer_id = 0;
			int company_id = 0;
			int j = 0;
			int cnt = 0;
			int cnt1 = 0;
			String uname="";
			registerer_id = Integer.parseInt(session.getAttribute("uid").toString());
			Connection conuid = com.muthagroup.connectionModel.Connection_Utility.getConnection();
			PreparedStatement ps_uname=conuid.prepareStatement("select * from User_tbl where U_Id="+registerer_id);
			ResultSet rs_uname=ps_uname.executeQuery();
			while(rs_uname.next())
			{
				uname=rs_uname.getString("U_Name"); 
			}
			
			Iterator it = soft.iterator(); 
			PreparedStatement ps_chkUser = con_local.prepareStatement("select count(*) from erp_itemmaster_rel where master_code='"+ matType +"'");
			ResultSet rs_chkUser = ps_chkUser.executeQuery(); 
			while (rs_chkUser.next()) {
				cnt1 = rs_chkUser.getInt("count(*)");
			} 
			if (cnt1 > 0) {
				PreparedStatement ps_deluser = con_local.prepareStatement("delete from erp_itemmaster_rel where master_code='"+ matType +"'");
				ps_deluser.executeUpdate();
				flag1 = true;
			} else {
				flag1 = true;
			}

			if (flag1 == true) {
				
				while (it.hasNext()) { 
					PreparedStatement ps_getSoftId = con_local.prepareStatement("Select *  from erp_itemmaster_list  where name='" +  it.next().toString() + "'");
					ResultSet rs_getSoftId = ps_getSoftId.executeQuery();
					while (rs_getSoftId.next()) {
						PreparedStatement ps_addAccess = con_local.prepareStatement("insert into erp_itemmaster_rel(list_id,list_name,list_lable,master_code,enable,creator,date_log)values(?,?,?,?,?,?,?)");
						ps_addAccess.setInt(1, rs_getSoftId.getInt("code"));
						ps_addAccess.setString(2, rs_getSoftId.getString("name"));
						ps_addAccess.setString(3,  rs_getSoftId.getString("lable"));
						ps_addAccess.setString(4, matType);
						ps_addAccess.setInt(5, 1);
						ps_addAccess.setString(6, uname);
						ps_addAccess.setDate(7, currDate);

						j = ps_addAccess.executeUpdate();
						if (j > 0) {
							cnt++;
						}
					}
				}
				if (soft.size() == cnt) {
					flag = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag; 
	}
}
