package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 
import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Stories_vo; 

public class Stories_dao { 
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());	
	public boolean attach_File(Stories_vo bean, HttpSession session, HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			
			PreparedStatement ps_addStories = con.prepareStatement("insert into homepage_stories_tbl (created_by,heading,details,doc_filename,doc,photo_filename,photo,created_date,enable_id,visible_fromdate,visible_todate,priority,acc_all,acc_h21,acc_h25,acc_mfpl,acc_unit3,acc_di,acc_dept)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps_addStories.setInt(1, uid);
			ps_addStories.setString(2, bean.getHeading());
			ps_addStories.setString(3, bean.getDetails());
			ps_addStories.setString(4, bean.getDoc_filename());
			ps_addStories.setBlob(5, bean.getBlob_doc());
			ps_addStories.setString(6, bean.getPhotofilename());
			ps_addStories.setBlob(7, bean.getBlob_photo());
			ps_addStories.setDate(8, curr_Date);
			ps_addStories.setInt(9, 1);
			ps_addStories.setDate(10, bean.getDate_from());
			ps_addStories.setDate(11, bean.getDate_to());
			ps_addStories.setInt(12, bean.getPriority());
			ps_addStories.setInt(13, bean.getAcc_all());
			ps_addStories.setInt(14, bean.getAcc_h21());
			ps_addStories.setInt(15, bean.getAcc_h25());
			ps_addStories.setInt(16, bean.getAcc_mfpl());
			ps_addStories.setInt(17, bean.getAcc_unit3());
			ps_addStories.setInt(18, bean.getAcc_di());
			ps_addStories.setInt(19, bean.getAcc_dept()); 
			int up =	ps_addStories.executeUpdate();			
			
			if(up>0){
				response.sendRedirect("homepage.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
