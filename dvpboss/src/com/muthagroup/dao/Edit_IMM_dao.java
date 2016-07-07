package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_IMM_vo;
import java.sql.*;

public class Edit_IMM_dao {

	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	boolean flag=false;
	public boolean updateIMM(Edit_IMM_vo vo, HttpServletRequest request) 
	{
		try
		{
			int uid=0;
			Date OrgDate=null;
			
			int IMM_var=0;
			int IMMHist_Var=0;
			
			HttpSession session=request.getSession();
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_getIMMOrgDate=con.prepareStatement("select created_date from dev_intmaterial_movement_tbl where mat_move_id="+vo.getIMM_Id());
			ResultSet rs_getIMMOrgDate=ps_getIMMOrgDate.executeQuery();
			
			while(rs_getIMMOrgDate.next())
			{
				OrgDate=rs_getIMMOrgDate.getDate("created_date");
			}
			rs_getIMMOrgDate.close();
			ps_getIMMOrgDate.close();
			
			PreparedStatement ps_editIMM=con.prepareStatement("update dev_intmaterial_movement_tbl set material_type=?,discription=?,created_by=?,created_date=? where mat_move_id="+vo.getIMM_Id());
			ps_editIMM.setString(1, vo.getMat_type());
			ps_editIMM.setString(2, vo.getMove_disc());
			ps_editIMM.setInt(3, uid);
			ps_editIMM.setDate(4, Date);
			
			IMM_var=ps_editIMM.executeUpdate();
			
			if(IMM_var>0)
			{
				PreparedStatement ps_IMMHist=con.prepareStatement("insert into dev_intmaterial_movement_tbl_hist(mat_move_id,material_type,discription,basic_id,created_by,created_date,created_date_hist)values(?,?,?,?,?,?,?)");
				
				ps_IMMHist.setInt(1, vo.getIMM_Id());
				ps_IMMHist.setString(2, vo.getMat_type());
				ps_IMMHist.setString(3, vo.getMove_disc());
				ps_IMMHist.setInt(4, vo.getBasic_id());
				ps_IMMHist.setInt(5, uid);
				ps_IMMHist.setDate(6, Date);
				ps_IMMHist.setDate(7, OrgDate);
				
				IMMHist_Var=ps_IMMHist.executeUpdate();
				
				if(IMMHist_Var>0)
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
