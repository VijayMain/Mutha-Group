package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_Gauge_vo;
import java.sql.*;

public class Edit_Gauge_dao 
{
	boolean flag=false;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	
	public boolean updateGauge(Edit_Gauge_vo vo, HttpServletRequest request) 
	{
		
		try
		{
		
			Connection con=Connection_Utility.getConnection();
			
			int maxGauge_Id=0;
			
			int newGauge_var=0;
			int newGauneHist_var=0;
			
			
			boolean chkGaugeName_flag=false;
			boolean chkGaugeName_flag1=false;
			
			HttpSession session=request.getSession();
			
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			if(vo.getNew_gauge_name()!=null)
			{
				System.out.println("new gauge available...");
				
				PreparedStatement ps_chkGaugeName=con.prepareStatement("select gauge_name,gauge_id from dev_gauge_mst_tbl");
				ResultSet rs_chkGaugeName=ps_chkGaugeName.executeQuery();
				while(rs_chkGaugeName.next())
				{
					if(rs_chkGaugeName.getString("Gauge_Name").equalsIgnoreCase(vo.getNew_gauge_name()))
					{
						maxGauge_Id=rs_chkGaugeName.getInt("gauge_id");
						chkGaugeName_flag1=true;
					}
				}
				rs_chkGaugeName.close();
				ps_chkGaugeName.close();
				
				if(chkGaugeName_flag1==false)
				{
					PreparedStatement ps_addNewGauge=con.prepareStatement("insert into dev_gauge_mst_tbl(gauge_name,created_by,created_date)values(?,?,?)");
					
					ps_addNewGauge.setString(1, vo.getNew_gauge_name());
					ps_addNewGauge.setInt(2, uid);
					ps_addNewGauge.setDate(3, Date);
					
					newGauge_var=ps_addNewGauge.executeUpdate();
					
					if(newGauge_var>0)
					{
						PreparedStatement ps_getMaxId=con.prepareStatement("select max(gauge_id) from dev_gauge_mst_tbl");
						ResultSet rs_getMaxId=ps_getMaxId.executeQuery();
						
						while(rs_getMaxId.next())
						{
							maxGauge_Id=rs_getMaxId.getInt("max(gauge_id)");
						}
						rs_getMaxId.close();
						ps_getMaxId.close();
						
						PreparedStatement ps_addNewGauge_Hist=con.prepareStatement("insert into dev_gauge_mst_tbl_hist(gauge_id,gauge_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
						
						ps_addNewGauge_Hist.setInt(1,maxGauge_Id);
						ps_addNewGauge_Hist.setString(2, vo.getNew_gauge_name());
						ps_addNewGauge_Hist.setInt(3, uid);
						ps_addNewGauge_Hist.setDate(4, Date);
						ps_addNewGauge_Hist.setDate(5, Date);
						
						newGauneHist_var=ps_addNewGauge_Hist.executeUpdate();
						
						if(newGauneHist_var>0)
						{
							System.out.println("new gauge added with hist... gauge Id="+maxGauge_Id);
						}
						
					}
				}
			}
			else
			{
			
			PreparedStatement ps_chkGaugeName=con.prepareStatement("select gauge_name,gauge_id from dev_gauge_mst_tbl");
			ResultSet rs_chkGaugeName=ps_chkGaugeName.executeQuery();
			while(rs_chkGaugeName.next())
			{
				if(rs_chkGaugeName.getString("Gauge_Name").equalsIgnoreCase(vo.getGauge_name()))
				{
					maxGauge_Id=rs_chkGaugeName.getInt("gauge_id");
					chkGaugeName_flag=true;
				}
			}
			rs_chkGaugeName.close();
			ps_chkGaugeName.close();
			
			
			Date orgDate_GName=null;
			int update_GName=0;
			int addHist_GName=0;
			
			if(chkGaugeName_flag==true)
			{
				System.out.println("Gauge Name matched.... Gauge Id..."+maxGauge_Id);
			}
			else
			{
				PreparedStatement ps_getGauge_Id=con.prepareStatement("select gauge_id from dev_gaugedata_tbl where GD_Id="+vo.getGD_Id());
				ResultSet rs_getGauge_Id=ps_getGauge_Id.executeQuery();
				
				while(rs_getGauge_Id.next())
				{
					maxGauge_Id=rs_getGauge_Id.getInt("gauge_id");
				}
				rs_getGauge_Id.close();
				ps_getGauge_Id.close();
				
				PreparedStatement ps_getHist_Date=con.prepareStatement("select created_date from dev_gauge_mst_tbl where gauge_Id="+maxGauge_Id);
				ResultSet rs_getHist_Date=ps_getHist_Date.executeQuery();
				
				while(rs_getHist_Date.next())
				{
					orgDate_GName=rs_getHist_Date.getDate("created_date");
				}
				rs_getHist_Date.close();
				ps_getHist_Date.close();
				
				PreparedStatement ps_updateGName=con.prepareStatement("update dev_gauge_mst_tbl set gauge_name=?,created_by=?,created_date=? where gauge_id="+maxGauge_Id);
				
				ps_updateGName.setString(1, vo.getGauge_name());
				ps_updateGName.setInt(2, uid);
				ps_updateGName.setDate(3, Date);
				
				update_GName=ps_updateGName.executeUpdate();
				
				if(update_GName>0)
				{
					PreparedStatement ps_addHistGName=con.prepareStatement("insert into dev_gauge_mst_tbl_hist(gauge_id,gauge_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					
					ps_addHistGName.setInt(1, maxGauge_Id);
					ps_addHistGName.setString(2, vo.getGauge_name());
					ps_addHistGName.setInt(3, uid);
					ps_addHistGName.setDate(4,Date);
					ps_addHistGName.setDate(5,orgDate_GName);
					
					addHist_GName=ps_addHistGName.executeUpdate();
					
					if(addHist_GName>0)
					{
						System.out.println("gauge not matched updated and history added....gauge id="+maxGauge_Id);
					}
				}
				
			}
			}
			Date orgDate_GData=null;
			int updateGData_var=0;
			int addGDataHist_Var=0;
			int rel_id=0;
			
			PreparedStatement ps_getGDataDate=con.prepareStatement("select created_date,opnno_opn_rel_id from dev_gaugedata_tbl where GD_ID="+vo.getGD_Id());
			ResultSet rs_getGDataDate=ps_getGDataDate.executeQuery();
			
			while(rs_getGDataDate.next())
			{
				rel_id=rs_getGDataDate.getInt("opnno_opn_rel_id");
				orgDate_GData=rs_getGDataDate.getDate("created_date");
			}
			rs_getGDataDate.close();
			ps_getGDataDate.close();
			
			
			PreparedStatement ps_updateGData=con.prepareStatement("update dev_gaugedata_tbl set gauge_id=?,gauge_quantity=?,customer_approval=?,gauge_po_date=?,gauge_target_date=?,gauge_receipt_date=?,created_by=?,created_date=?,avail_qty=? where GD_ID="+vo.getGD_Id());
			
			ps_updateGData.setInt(1, maxGauge_Id);
			ps_updateGData.setInt(2, vo.getGauge_qty());
			ps_updateGData.setString(3, vo.getCust_apr());
			ps_updateGData.setDate(4, vo.getGauge_po_date());
			ps_updateGData.setDate(5,vo.getGauge_trg_date());
			ps_updateGData.setDate(6, vo.getGauge_rec_date());
			ps_updateGData.setInt(7, uid);
			ps_updateGData.setDate(8, Date);
			ps_updateGData.setInt(9, vo.getAvail_qty());
			updateGData_var=ps_updateGData.executeUpdate();
			
			if(updateGData_var>0)
			{
				PreparedStatement ps_addGData_Hist=con.prepareStatement("insert into dev_gaugedata_tbl_hist(gd_id,gauge_quantity,customer_approval,gauge_po_date,gauge_target_date,gauge_receipt_date,basic_id,created_by,created_date,created_date_hist,gauge_id,opnno_opn_rel_id,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				ps_addGData_Hist.setInt(1, vo.getGD_Id());
				ps_addGData_Hist.setInt(2, vo.getGauge_qty());
				ps_addGData_Hist.setString(3, vo.getCust_apr());
				ps_addGData_Hist.setDate(4, vo.getGauge_po_date());
				ps_addGData_Hist.setDate(5,vo.getGauge_trg_date());
				ps_addGData_Hist.setDate(6, vo.getGauge_rec_date());
				ps_addGData_Hist.setInt(7, vo.getBasic_id());
				ps_addGData_Hist.setInt(8, uid);
				ps_addGData_Hist.setDate(9, Date);
				ps_addGData_Hist.setDate(10, orgDate_GData);
				ps_addGData_Hist.setInt(11, maxGauge_Id);
				ps_addGData_Hist.setInt(12, rel_id);
				ps_addGData_Hist.setInt(13, vo.getAvail_qty());
				
				addGDataHist_Var=ps_addGData_Hist.executeUpdate();
				
				if(addGDataHist_Var>0)
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
