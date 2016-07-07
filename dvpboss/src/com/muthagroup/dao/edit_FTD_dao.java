package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.edit_FTD_vo;

public class edit_FTD_dao {

	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	public void editFTD(HttpServletRequest request,
			HttpServletResponse response, edit_FTD_vo vo) 
	{
		try
		{
			
			int uid=0;
			int edit_var=0;
			int ftHist_var=0;
			
			Date created_date_Hist=null;
			HttpSession session=request.getSession();
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_getOldData=con.prepareStatement("select created_date from dev_foundrytoolingdata_tbl where ftd_id="+vo.getFtd_id());
			
			ResultSet rs_getOldData=ps_getOldData.executeQuery();
			
			while(rs_getOldData.next())
			{
				created_date_Hist=rs_getOldData.getDate("created_Date");
			}
			rs_getOldData.close();
			ps_getOldData.close();
			
			PreparedStatement ps_editFTD=con.prepareStatement("update dev_foundrytoolingdata_tbl set Pattern_Avail=?,Pattern_Required=?,CoreBox_Avail=?,CoreBox_Required=?,Recpt_Date=?,Created_By=?,Created_Date=? where FTD_Id="+vo.getFtd_id());
			
			ps_editFTD.setInt(1, vo.getPat_avail());
			ps_editFTD.setInt(2, vo.getPat_req());
			ps_editFTD.setInt(3, vo.getCb_avail());
			ps_editFTD.setInt(4, vo.getCb_req());
			ps_editFTD.setDate(5, vo.getReceptDate());
			ps_editFTD.setInt(6, uid);
			ps_editFTD.setDate(7, Date);
			
			edit_var=ps_editFTD.executeUpdate();
			
			if(edit_var>0)
			{
				
				PreparedStatement ps_addFTD_Hist=con.prepareStatement("insert into dev_foundrytoolingdata_tbl_hist" +
						"(FTD_Id,Pattern_Avail,Pattern_Required,CoreBox_Avail,CoreBox_Required,Recpt_Date,Basic_Id,Created_By,Created_Date,Created_Date_Hist)values(?,?,?,?,?,?,?,?,?,?)");
				ps_addFTD_Hist.setInt(1, vo.getFtd_id());
				ps_addFTD_Hist.setInt(2, vo.getPat_avail());
				ps_addFTD_Hist.setInt(3, vo.getPat_req());
				ps_addFTD_Hist.setInt(4, vo.getCb_avail());
				ps_addFTD_Hist.setInt(5, vo.getCb_req());
				ps_addFTD_Hist.setDate(6, vo.getReceptDate());
				ps_addFTD_Hist.setInt(7, vo.getBasic_id());
				ps_addFTD_Hist.setInt(8, uid);
				ps_addFTD_Hist.setDate(9, Date);
				ps_addFTD_Hist.setDate(10, created_date_Hist);
				
				ftHist_var = ps_addFTD_Hist.executeUpdate();
				ps_addFTD_Hist.close();
				
				if(ftHist_var>0)
				{
					System.out.println("foundry tooling is added with history...");
					
					response.sendRedirect("Activity_Sheet.jsp?hid="+vo.getBasic_id());
				}
				//System.out.println("Data updated...");
			}
			
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
