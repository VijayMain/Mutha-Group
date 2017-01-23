package com.muthagroup.dao;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_CT_vo;

public class Edit_CT_dao {
	boolean flag=false;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	public boolean editCT(Edit_CT_vo vo, HttpServletRequest request) {
		
		try
		{
			HttpSession session=request.getSession();
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			
			Connection con = Connection_Utility.getConnection();
			
			String tool_name=null;
			int ctool_id=0;
			boolean ctool_flag=false;
			
			Date CT_Date=null;
			
			int updateCT_var=0;
			int addCThist_var=0;
			int newCT_var=0;
			int newCTHist_var=0;
			boolean ctool_flag1=false;
			
		if(vo.getNew_cuttingtool()!=null)
		{
			System.out.println("new ct available....");
			
			
			
			
			
				PreparedStatement ps_chkCT=con.prepareStatement("select ctool_id,tool_name from dev_cutting_tool_mst_tbl");
				ResultSet rs_chkCT=ps_chkCT.executeQuery();
				
				while(rs_chkCT.next())
				{
					if(vo.getNew_cuttingtool().equalsIgnoreCase(rs_chkCT.getString("tool_name")))
					{
						ctool_id=rs_chkCT.getInt("ctool_id");
						ctool_flag1=true;
					}
					
				}
				rs_chkCT.close();
				ps_chkCT.close();
				
				if(ctool_flag1==false)
				{
					PreparedStatement ps_addNewCT=con.prepareStatement("insert into dev_cutting_tool_mst_tbl(tool_name,created_by,created_date)values(?,?,?)");
					ps_addNewCT.setString(1, vo.getNew_cuttingtool());
					ps_addNewCT.setInt(2, uid);
					ps_addNewCT.setDate(3,Date);
					
				newCT_var=ps_addNewCT.executeUpdate();
				if(newCT_var>0)
				{
				PreparedStatement ps_getMaxID=con.prepareStatement("select max(ctool_Id) from dev_cutting_tool_mst_tbl");
				ResultSet rs_getMaxID=ps_getMaxID.executeQuery();
				
				while(rs_getMaxID.next())
				{
					ctool_id=rs_getMaxID.getInt("max(ctool_Id)");
				}
				rs_getMaxID.close();
				ps_getMaxID.close();
				
				PreparedStatement ps_addNewCTHist=con.prepareStatement("insert into dev_cutting_tool_mst_tbl_hist(ctool_id,tool_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
				ps_addNewCTHist.setInt(1, ctool_id);
				ps_addNewCTHist.setString(2, vo.getNew_cuttingtool());
				ps_addNewCTHist.setInt(3, uid);
				ps_addNewCTHist.setDate(4, Date);
				ps_addNewCTHist.setDate(5, Date);
				
				newCTHist_var=ps_addNewCTHist.executeUpdate();
				
				if(newCTHist_var>0)
				{
					System.out.println("new ct Added .... ctool id=="+ctool_id);
				}

				}
				
			}
		}
		else
		{
			PreparedStatement ps_chkCT=con.prepareStatement("select ctool_id,tool_name from dev_cutting_tool_mst_tbl");
			ResultSet rs_chkCT=ps_chkCT.executeQuery();
			
			while(rs_chkCT.next())
			{
				if(vo.getCutting_tool().equalsIgnoreCase(rs_chkCT.getString("tool_name")))
				{
					ctool_id=rs_chkCT.getInt("ctool_id");
					
					ctool_flag=true;
				}
				
			}
			rs_chkCT.close();
			ps_chkCT.close();
			
			if(ctool_flag==true)
			{
				System.out.println("tool name matched.... tool id="+ctool_id);
			}
			else
			{
				PreparedStatement ps_getCtool_Id=con.prepareStatement("select ctool_id from dev_cuttingtool_data_tbl where ctd_id="+vo.getCtd_id());
				ResultSet rs_getCtool_Id=ps_getCtool_Id.executeQuery();
				while(rs_getCtool_Id.next())
				{
					ctool_id=rs_getCtool_Id.getInt("ctool_id");
					
				}
				
					
				PreparedStatement ps_getCTDate=con.prepareStatement("select created_date from dev_cutting_tool_mst_tbl where ctool_id="+ctool_id);
				
				ResultSet rs_getCTDate=ps_getCTDate.executeQuery();
				
				while(rs_getCTDate.next())
				{
					CT_Date=rs_getCTDate.getDate("created_date");
				}
				rs_getCTDate.close();
				ps_getCTDate.close();
				
				PreparedStatement ps_updateCT=con.prepareStatement("update dev_cutting_tool_mst_tbl set tool_name=?,created_by=?,created_date=? where ctool_Id="+ctool_id);
				
				ps_updateCT.setString(1, vo.getCutting_tool());
				ps_updateCT.setInt(2, uid);
				ps_updateCT.setDate(3, Date);
				
				updateCT_var=ps_updateCT.executeUpdate();
				
				if(updateCT_var>0)
				{
					PreparedStatement ps_addCTHist=con.prepareStatement("insert into dev_cutting_tool_mst_tbl_hist(ctool_id,tool_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addCTHist.setInt(1, ctool_id);
					ps_addCTHist.setString(2, vo.getCutting_tool());
					ps_addCTHist.setInt(3, uid);
					ps_addCTHist.setDate(4, Date);
					ps_addCTHist.setDate(5,CT_Date);
					
					addCThist_var=ps_addCTHist.executeUpdate();
					
					if(addCThist_var>0)
					{
						System.out.println("CT updated.... History added... id="+ctool_id);
					}
					
				}
			}
		}
			
		
			int CTData_id=0;
			Date CTData_Date=null;
			
			int updateCTData_var=0;
			int addCTDataHist_var=0;
			int rel_id=0;
			int fd_id=0;
			PreparedStatement ps_getCTData=con.prepareStatement("select fd_id,opnno_opn_rel_id,created_date from dev_cuttingtool_data_tbl where ctd_id="+vo.getCtd_id());
			ResultSet rs_getCTData=ps_getCTData.executeQuery();
			
			while(rs_getCTData.next())
			{
				rel_id=rs_getCTData.getInt("opnno_opn_rel_id");
				fd_id=rs_getCTData.getInt("fd_id");
				CTData_Date=rs_getCTData.getDate("created_date");
			}
			rs_getCTData.close();
			ps_getCTData.close();
			
			PreparedStatement ps_updateCTData=con.prepareStatement("update dev_cuttingtool_data_tbl set ctool_id=?,ctool_quantity=?,ctool_po_date=?,ctool_target_date=?,ctool_receipt_date=?,created_by=?,created_date=?,ctool_po_no=?,avail_qty=? where ctd_id="+vo.getCtd_id());
			ps_updateCTData.setInt(1, ctool_id);
			ps_updateCTData.setInt(2, vo.getTool_qty());
			ps_updateCTData.setDate(3, vo.getPo_date());
			ps_updateCTData.setDate(4, vo.getTarget_tool_date());
			ps_updateCTData.setDate(5, vo.getTool_recpt_date());
			ps_updateCTData.setInt(6, uid);
			ps_updateCTData.setDate(7, Date);
			ps_updateCTData.setString(8, vo.getTool_pono());
			ps_updateCTData.setInt(9, vo.getAvailtoolqty());
			
			updateCTData_var=ps_updateCTData.executeUpdate();
			
			if(updateCTData_var>0)
			{
				System.out.println("CT Data Updated....");
				
				PreparedStatement ps_addCTHist=con.prepareStatement("insert into dev_cuttingtool_data_tbl_hist(ctd_id,ctool_id,ctool_quantity,ctool_po_date,ctool_Target_date,ctool_receipt_date,fd_id,created_by,created_date,ctool_po_no,created_date_hist,opnno_opn_rel_id,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				ps_addCTHist.setInt(1, vo.getCtd_id());
				ps_addCTHist.setInt(2, ctool_id);
				ps_addCTHist.setInt(3, vo.getTool_qty());
				ps_addCTHist.setDate(4, vo.getPo_date());
				ps_addCTHist.setDate(5, vo.getTarget_tool_date());
				ps_addCTHist.setDate(6, vo.getTool_recpt_date());
				ps_addCTHist.setInt(7, fd_id);
				ps_addCTHist.setInt(8, uid);
				ps_addCTHist.setDate(9, Date);
				ps_addCTHist.setString(10, vo.getTool_pono());
				ps_addCTHist.setDate(11, CTData_Date);
				ps_addCTHist.setInt(12,rel_id);
				ps_addCTHist.setInt(13,vo.getAvailtoolqty());
				
				addCTDataHist_var=ps_addCTHist.executeUpdate();
				
				if(addCTDataHist_var>0)
				{
					System.out.println("CT data updated... history added....");
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
