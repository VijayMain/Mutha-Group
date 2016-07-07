package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse; 

import com.muthagroup.connectionUtil.ConnectionUrl;

public class ImportHollidays_dao {
	private static final java.sql.Date currDate =new java.sql.Date(System.currentTimeMillis());
	public void saveDate(int uid, String holli_date, String comppass, String yearpass, String remark, HttpServletResponse response) {
		try {
			Connection conloc = ConnectionUrl.getLocalDatabase();
			
			int dd = Integer.parseInt(holli_date.substring(8,10));
			int mm = Integer.parseInt(holli_date.substring(5,7));
			int yyyy = Integer.parseInt(holli_date.substring(0,4));
			String success = "";
			boolean flag = false;
			int up=0;
			
			PreparedStatement ps_chk = conloc.prepareStatement("select * from montlyweekdays_tbl where month="+ mm  +" and day="+  dd  +" and year="+  yyyy);
			ResultSet rs_chk = ps_chk.executeQuery();
			while(rs_chk.next()){
				success = "Already available !!!";
				flag = true;
				response.sendRedirect("Budget_Entry.jsp?comp="+comppass+"&year="+yearpass + "&success="+success);
			}
			if(flag==false){
			
			ps_chk = conloc.prepareStatement("insert into montlyweekdays_tbl (month,hollidays,day,year,remark,created_by,dateupload)values(?,?,?,?,?,?,?)");
			ps_chk.setInt(1, mm);
			ps_chk.setInt(2, 1);
			ps_chk.setInt(3, dd);
			ps_chk.setInt(4, yyyy);
			ps_chk.setString(5, remark);
			ps_chk.setString(6, String.valueOf(uid));
			ps_chk.setDate(7, currDate);
			
			up = ps_chk.executeUpdate();
			
			if(up>0){
				success = "Success....";
				response.sendRedirect("Budget_Entry.jsp?comp="+comppass+"&year="+yearpass + "&success="+success);
			}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
