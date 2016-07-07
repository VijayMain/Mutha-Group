package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_Others_vo;

public class Add_Others_dao {
	
	boolean flag=false;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	
	public boolean addOthers(Add_Others_vo vo, HttpServletRequest request) 
	{
		
		try
		{
			HttpSession session=request.getSession();
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_addOther=con.prepareStatement("insert into dev_otherdata_tbl(other_discription,created_by,created_date,basic_id,opnno_opn_rel_id)values(?,?,?,?,?)");
			ps_addOther.setString(1, vo.getOthers());
			ps_addOther.setInt(2, uid);
			ps_addOther.setDate(3, Date);
			ps_addOther.setInt(4, vo.getBasic_id());
			ps_addOther.setInt(5, vo.getRel_id());
			
			int i=ps_addOther.executeUpdate();
			int maxOther_id=0;
			if(i>0)
			{
				PreparedStatement ps_getMaxOther_id=con.prepareStatement("select max(od_id) from dev_otherdata_tbl");
				ResultSet rs_getMaxOther_id=ps_getMaxOther_id.executeQuery();
				while(rs_getMaxOther_id.next())
				{
					maxOther_id=rs_getMaxOther_id.getInt("max(od_id)");
				}
				
				PreparedStatement ps_addOther_Hist=con.prepareStatement("insert into dev_otherdata_tbl_hist(od_id,other_discription,created_by,created_date,created_date_hist,basic_id,opnno_opn_rel_id)values(?,?,?,?,?,?,?)");
				
				ps_addOther_Hist.setInt(1, maxOther_id);
				ps_addOther_Hist.setString(2, vo.getOthers());
				ps_addOther_Hist.setInt(3, uid);
				ps_addOther_Hist.setDate(4, Date);
				ps_addOther_Hist.setDate(5, Date);
				ps_addOther_Hist.setInt(6, vo.getBasic_id());
				ps_addOther_Hist.setInt(7, vo.getRel_id());
				
				int j=ps_addOther_Hist.executeUpdate();
				
				if(j>0)
				{
					flag=true;
				}
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

}
