package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.MRMOperation_vo;

public class MRMOperation_dao {
	private static final java.sql.Date currDate =new java.sql.Date(System.currentTimeMillis());
	public void addBudgetData(int uid, MRMOperation_vo vo,
			HttpServletResponse response, ArrayList budgetList, ArrayList mntcnt) {
		try {
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps_hist = null, ps_ins = null, ps_del = null;
			int his = 0,del = 0,ins=0;
			boolean flag = false;
			String status = "";
			
			PreparedStatement ps_para = con.prepareStatement("select * from mrmop_parameters where name='"+vo.getParameter()+"'");
			ResultSet rs_para = ps_para.executeQuery();
			while(rs_para.next()){
				vo.setParaId(rs_para.getInt("code"));
			}
			
			//System.out.println("Para Code = " + vo.getParaId() + "para = = " + vo.getParameter());
			
			PreparedStatement ps_prev = con.prepareStatement("select * from mrm_operation where foryear='"+vo.getYear()+"' and para_code="+vo.getParaId() + " and company='"+vo.getPasscomp()+"'");
			ResultSet rs_prev = ps_prev.executeQuery();
			while(rs_prev.next()){
					ps_hist = con.prepareStatement("insert into mrm_operation_hist"
						+ "(para_code,budget,created_by,created_date,history_date,month_cnt,foryear,deleted_by,company)values(?,?,?,?,?,?,?,?,?)");
					ps_hist.setInt(1, rs_prev.getInt("para_code"));
					ps_hist.setString(2, rs_prev.getString("budget")); 
					ps_hist.setInt(3, rs_prev.getInt("created_by"));
					ps_hist.setDate(4, rs_prev.getDate("created_date"));
					ps_hist.setDate(5, currDate);
					ps_hist.setString(6, rs_prev.getString("month_cnt"));
					ps_hist.setString(7, rs_prev.getString("foryear"));
					ps_hist.setInt(8, uid);
					ps_hist.setString(9, vo.getPasscomp());
					
					his = ps_hist.executeUpdate();
					flag = true;
			}
			if(flag==true){
				ps_del = con.prepareStatement("delete from mrm_operation where foryear='"+vo.getYear()+"' and para_code="+vo.getParaId() + " and company='"+vo.getPasscomp()+"'");
				del = ps_del.executeUpdate();
				flag = false;
			}
			
			for(int i=0;i<budgetList.size();i++){
				
				//System.out.println("budget list = " + budgetList.get(i));
				
				
			ps_ins = con.prepareStatement("insert into mrm_operation"
					+ "(para_code,budget,created_by,created_date,update_date,month_cnt,foryear,company)values(?,?,?,?,?,?,?,?)");
			ps_ins.setInt(1, vo.getParaId()); 
			ps_ins.setString(2, budgetList.get(i).toString()); 
			ps_ins.setInt(3, uid);
			ps_ins.setDate(4, currDate);
			ps_ins.setDate(5, currDate);
			ps_ins.setString(6, mntcnt.get(i).toString());
			ps_ins.setString(7, vo.getYear());
			ps_ins.setString(8, vo.getPasscomp());
			ins =ps_ins.executeUpdate(); 
			}
			
			if(ins>0){
				status = "Success...";
				response.sendRedirect("Budget_Entry.jsp?status="+status+"&comp="+vo.getPasscomp()+"&year="+vo.getPassyear());
			}else {
					status = "Error...";
					response.sendRedirect("Budget_Entry.jsp?status="+status+"&comp="+vo.getPasscomp()+"&year="+vo.getPassyear());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}