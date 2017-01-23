package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_Others_vo;
import java.sql.*;

public class Edit_Others_dao 
{
	boolean flag=false;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	public boolean updateOthers(Edit_Others_vo vo, HttpServletRequest request) {
		
		try
		{
			
			Connection con=Connection_Utility.getConnection();
			HttpSession session=request.getSession();
			
			int uid=0;
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			
			
			Date orgDate=null;
			
			int od_id1=0;
			
			int updateOther_var=0;
			int addHistOther_var=0;
			
			PreparedStatement ps_getOthrDetails=con.prepareStatement("select od_id,created_date from dev_otherdata_tbl where basic_id="+vo.getBasic_id()+" and opnno_opn_rel_id="+vo.getRel_id());
			ResultSet rs_getOthrDetails=ps_getOthrDetails.executeQuery();
			
			while(rs_getOthrDetails.next())
			{
				od_id1=rs_getOthrDetails.getInt("od_id");
				orgDate=rs_getOthrDetails.getDate("created_date");
			}
			rs_getOthrDetails.close();
			ps_getOthrDetails.close();
			
			PreparedStatement ps_updateOther=con.prepareStatement("update dev_otherdata_tbl set other_discription=?,created_by=?,created_date=? where basic_id="+vo.getBasic_id()+" and opnno_opn_rel_id="+vo.getRel_id());
			ps_updateOther.setString(1, vo.getOther());
			ps_updateOther.setInt(2, uid);
			ps_updateOther.setDate(3, Date);
			
			updateOther_var=ps_updateOther.executeUpdate();
			
			if(updateOther_var>0)
			{
				PreparedStatement ps_addOther_Hist=con.prepareStatement("insert into dev_otherdata_tbl_hist(od_id,other_discription,created_by,created_date,created_date_hist,basic_id,opnno_opn_rel_id) values(?,?,?,?,?,?,?)");
				ps_addOther_Hist.setInt(1, od_id1);
				ps_addOther_Hist.setString(2, vo.getOther());
				ps_addOther_Hist.setInt(3, uid);
				ps_addOther_Hist.setDate(4, Date);
				ps_addOther_Hist.setDate(5, orgDate);
				ps_addOther_Hist.setInt(6, vo.getBasic_id());
				ps_addOther_Hist.setInt(7, vo.getRel_id());
				
				addHistOther_var=ps_addOther_Hist.executeUpdate();
				
				if(addHistOther_var>0)
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
