package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.add_FTD_vo;

public class add_FTD_dao {

	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	public void addFTD(HttpServletRequest request,
			HttpServletResponse response, add_FTD_vo vo) 
	{
		
		HttpSession session=request.getSession();
		
		int uid=0;
		
		uid=Integer.parseInt(session.getAttribute("uid").toString());
		
		try
		{
		
			int ft_var=0;
			int ftHist_var=0;
			int ftdMax=0;
			
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_addFTD=con.prepareStatement("insert into dev_foundrytoolingdata_tbl(Pattern_Avail,Pattern_Required,CoreBox_Avail,CoreBox_Required,Recpt_Date,Basic_Id,Created_By,Created_Date)values(?,?,?,?,?,?,?,?)");
			
			ps_addFTD.setInt(1, vo.getPat_avail());
			ps_addFTD.setInt(2, vo.getPat_req());
			ps_addFTD.setInt(3, vo.getCb_avail());
			ps_addFTD.setInt(4, vo.getCb_req());
			ps_addFTD.setDate(5,vo.getReceptDate());
			ps_addFTD.setInt(6,vo.getBasic_id());
			ps_addFTD.setInt(7, uid);
			ps_addFTD.setDate(8, Date);
			
			ft_var=ps_addFTD.executeUpdate();
			ps_addFTD.close();
			if(ft_var>0)
			{
				PreparedStatement ps_ftdmax=con.prepareStatement("select max(FTD_Id) from dev_foundrytoolingdata_tbl");
				ResultSet rs_frdmax=ps_ftdmax.executeQuery();
				while(rs_frdmax.next()){
					ftdMax=rs_frdmax.getInt("max(FTD_Id)");
				}
				ps_ftdmax.close();
				rs_frdmax.close();
								
				PreparedStatement ps_addFTD_Hist=con.prepareStatement("insert into dev_foundrytoolingdata_tbl_hist" +
						"(FTD_Id,Pattern_Avail,Pattern_Required,CoreBox_Avail,CoreBox_Required,Recpt_Date,Basic_Id,Created_By,Created_Date,Created_Date_Hist)values(?,?,?,?,?,?,?,?,?,?)");
				ps_addFTD_Hist.setInt(1, ftdMax);
				ps_addFTD_Hist.setInt(2, vo.getPat_avail());
				ps_addFTD_Hist.setInt(3, vo.getPat_req());
				ps_addFTD_Hist.setInt(4, vo.getCb_avail());
				ps_addFTD_Hist.setInt(5, vo.getCb_req());
				ps_addFTD_Hist.setDate(6, vo.getReceptDate());
				ps_addFTD_Hist.setInt(7, vo.getBasic_id());
				ps_addFTD_Hist.setInt(8, uid);
				ps_addFTD_Hist.setDate(9, Date);
				ps_addFTD_Hist.setDate(10, Date);
				ftHist_var = ps_addFTD_Hist.executeUpdate();
				ps_addFTD_Hist.close();
				
				if(ftHist_var>0)
				{
					System.out.println("foundry tooling is added with history...");
					
					response.sendRedirect("Activity_Sheet.jsp?hid="+vo.getBasic_id());
				}
				
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
	}

}
