package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.MOM_vo;

public class MOM_Update_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());	
	public void MOM_Configure(MOM_vo bean, HttpSession session,
			HttpServletResponse response) {
		try {
			Connection con_local =Connection_Utility.getConnection();
		 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_addHistory = con_local.prepareStatement("insert into dev_mom_history_tbl" +
					"(title,description,created_by,mom_attached,attach_name,attach_date,enable,update_date,mom_code)values(?,?,?,?,?,?,?,?,?)");
			ps_addHistory.setString(1, bean.getTitle());
			ps_addHistory.setString(2, bean.getDescription());
			ps_addHistory.setInt(3, uid);
			ps_addHistory.setBlob(4, bean.getBlob_doc());
			ps_addHistory.setString(5, bean.getDoc_filename());
			ps_addHistory.setDate(6, curr_Date);
			ps_addHistory.setInt(7, 1);
			ps_addHistory.setDate(8, curr_Date);
			ps_addHistory.setInt(9, bean.getHid());
			
			int up = ps_addHistory.executeUpdate();
			
			if(up>0){
				String result ="Done...";
				response.sendRedirect("MOM_History.jsp?result="+result+"&hid="+bean.getHid());
			}else {
				String error ="Error Occurred !!!";
				response.sendRedirect("MOM_History.jsp?error="+error+"&hid="+bean.getHid());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}