package com.muthagroup.dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.New_sheet_vo;

public class New_sheet_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(
			System.currentTimeMillis());
	public  void add_newSheetInfo(HttpSession session, New_sheet_vo vo, HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection();
			int upd=0,his=0,ins=0,stat=0,companyid=0;
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			
			PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
			ResultSet rs_uname=ps_uname.executeQuery();
			while(rs_uname.next())
			{
				companyid = rs_uname.getInt("Company_Id"); 
			}
			rs_uname.close();
			ps_uname.close();
			
			Date date = new Date();
			Calendar cal = Calendar.getInstance();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
			
			PreparedStatement ps_maxcount=con.prepareStatement("select * from hr_attendance_data_tbl where attendance_date='"+vo.getAttendance_date()+"'");
			ResultSet rs_maxcount=ps_maxcount.executeQuery();
				rs_maxcount.last();
				int avail = rs_maxcount.getRow();
				rs_maxcount.beforeFirst();
			if(avail>0){
				System.out.println("Already available page");
				while(rs_maxcount.next()){
				PreparedStatement ps_inshist=con.prepareStatement("insert into hr_attendance_data_tbl_hist" +
						"(File_Name,DeleteStatus,done_by,change_date,Attendance_data_id,history_date) values(?,?,?,?,?,?)");
				ps_inshist.setString(1, rs_maxcount.getString("File_Name"));
				ps_inshist.setInt(2, stat);
				ps_inshist.setInt(3, uid);
				ps_inshist.setDate(4, curr_Date);
				ps_inshist.setInt(5, rs_maxcount.getInt("Attendance_data_id"));		
				ps_inshist.setDate(6, rs_maxcount.getDate("attendance_date")); 
				his = ps_inshist.executeUpdate();
				ps_inshist.close();
				}
				
				PreparedStatement ps_updaterec=con.prepareStatement("update hr_attendance_data_tbl set Delete_Status=0 where attendance_date='"+vo.getAttendance_date()+"'");
				upd = ps_updaterec.executeUpdate();
				
				PreparedStatement ps_ins=con.prepareStatement("insert into hr_attendance_data_tbl (Attachment,File_Name,u_id,Delete_Status,attendance_date,attached_date,company_id) values(?,?,?,?,?,?,?)");
				ps_ins.setBlob(1, vo.getFile_blob());
				ps_ins.setString(2, vo.getFile_Name_ext());
				ps_ins.setInt(3, uid);
				ps_ins.setInt(4, 1);
				ps_ins.setDate(5, vo.getAttendance_date());
				ps_ins.setDate(6, curr_Date);
				ps_ins.setInt(7, companyid);
				ins = ps_ins.executeUpdate();
				ps_ins.close();
				
				int ct=0;
				PreparedStatement ps_maxt=con.prepareStatement("select max(Attendance_data_id) from hr_attendance_data_tbl where attendance_date='"+vo.getAttendance_date()+"'");
				ResultSet rs_maxct=ps_maxt.executeQuery();
				while(rs_maxct.next()){
					ct=rs_maxct.getInt("max(Attendance_data_id)");
				}
				ps_maxt.close();
				rs_maxct.close();
				
				PreparedStatement ps_inshist=con.prepareStatement("insert into hr_attendance_data_tbl_hist" +
						"(File_Name,DeleteStatus,done_by,change_date,Attendance_data_id,history_date) values(?,?,?,?,?,?)");
				ps_inshist.setString(1, vo.getFile_Name_ext());
				ps_inshist.setInt(2, 1);
				ps_inshist.setInt(3, uid);
				ps_inshist.setDate(4, curr_Date);
				ps_inshist.setInt(5, ct);		
				ps_inshist.setDate(6, curr_Date);
				his = ps_inshist.executeUpdate();
				ps_inshist.close();
			}else {
				System.out.println("New entry ...");
				PreparedStatement ps_ins=con.prepareStatement("insert into hr_attendance_data_tbl (Attachment,File_Name,u_id,Delete_Status,attendance_date,attached_date,company_id) values(?,?,?,?,?,?,?)");
				ps_ins.setBlob(1, vo.getFile_blob());
				ps_ins.setString(2, vo.getFile_Name_ext());
				ps_ins.setInt(3, uid);
				ps_ins.setInt(4, 1);
				ps_ins.setDate(5, vo.getAttendance_date());
				ps_ins.setDate(6, curr_Date);
				ps_ins.setInt(7, companyid);
				ins = ps_ins.executeUpdate();
				ps_ins.close();
				
				int ct=0;
				PreparedStatement ps_maxt=con.prepareStatement("select max(Attendance_data_id) from hr_attendance_data_tbl where attendance_date='"+vo.getAttendance_date()+"'");
				ResultSet rs_maxct=ps_maxt.executeQuery();
				while(rs_maxct.next()){
					ct=rs_maxct.getInt("max(Attendance_data_id)");
				}
				ps_maxt.close();
				rs_maxct.close();
				
				PreparedStatement ps_inshist=con.prepareStatement("insert into hr_attendance_data_tbl_hist" +
						"(File_Name,DeleteStatus,done_by,change_date,Attendance_data_id,history_date) values(?,?,?,?,?,?)");
				ps_inshist.setString(1, vo.getFile_Name_ext());
				ps_inshist.setInt(2, 1);
				ps_inshist.setInt(3, uid);
				ps_inshist.setDate(4, curr_Date);
				ps_inshist.setInt(5, ct);		
				ps_inshist.setDate(6, curr_Date);
				his = ps_inshist.executeUpdate();	
				ps_inshist.close();
			} 
			ps_maxcount.close();
			rs_maxcount.close();			
			con.close();
			if(ins>0 && his>0){
				String success = "Data inserted successfully....";
				response.sendRedirect("HR_Home.jsp?success="+success);
			}else {
				String error = "Failed !!!";
				response.sendRedirect("HR_Home.jsp?error="+error);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
