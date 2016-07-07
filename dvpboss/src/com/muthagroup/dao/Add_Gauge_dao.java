package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_Gauge_vo;

public class Add_Gauge_dao {

	boolean flag=false;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	public boolean addGauge(Add_Gauge_vo vo, HttpServletRequest request) 
	{
		try
		{
			Connection con=Connection_Utility.getConnection();
			
			int maxGaugeId=0;
			int uid=0;
			
			boolean chkGaugeFlag=false;
			boolean addGaugeFlag=false;
			HttpSession session=request.getSession();
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			
			PreparedStatement ps_chkGauge=con.prepareStatement("select gauge_id,gauge_name from dev_gauge_mst_tbl");
			
			ResultSet rs_chkGauge=ps_chkGauge.executeQuery();
			
			while(rs_chkGauge.next())
			{
				if(vo.getGauge_name().equalsIgnoreCase(rs_chkGauge.getString("gauge_name")))
				{
					maxGaugeId=rs_chkGauge.getInt("gauge_id");
					chkGaugeFlag=true;
				}
			}
			
			int addGauge_Var=0;
			int addGaugeHist_var=0;
			
			
			if(chkGaugeFlag==true)
			{
				addGaugeFlag=true;
				System.out.println("gauge matched....gauge id="+maxGaugeId);
				
			}
			else
			{
				PreparedStatement ps_addGauge=con.prepareStatement("insert into dev_gauge_mst_tbl(gauge_name,created_by,created_date)values(?,?,?)");
				ps_addGauge.setString(1, vo.getGauge_name());
				ps_addGauge.setInt(2, uid);
				ps_addGauge.setDate(3, Date);
				
				addGauge_Var=ps_addGauge.executeUpdate();
				
				if(addGauge_Var>0)
				{
					PreparedStatement ps_getGaugeMaxId=con.prepareStatement("select max(gauge_id) from dev_gauge_mst_tbl");
					ResultSet rs_getGaugeMaxId=ps_getGaugeMaxId.executeQuery();
					
					while(rs_getGaugeMaxId.next())
					{
						maxGaugeId=rs_getGaugeMaxId.getInt("max(gauge_id)");
					}
					rs_getGaugeMaxId.close();
					ps_getGaugeMaxId.close();
					
					PreparedStatement ps_addGaugeHist=con.prepareStatement("insert into dev_gauge_mst_tbl_hist(gauge_id,gauge_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					
					ps_addGaugeHist.setInt(1, maxGaugeId);
					ps_addGaugeHist.setString(2, vo.getGauge_name());
					ps_addGaugeHist.setInt(3, uid);
					ps_addGaugeHist.setDate(4, Date);
					ps_addGaugeHist.setDate(5, Date);
					
					addGaugeHist_var=ps_addGaugeHist.executeUpdate();
					
					if(addGaugeHist_var>0)
					{
						addGaugeFlag=true;
					}
				}
				
			}
			
			int addGData_var=0;
			int addGDataHist_var=0;
			int maxGData_Id=0;
			
			
			if(addGaugeFlag==true)
			{
				PreparedStatement ps_addGData=con.prepareStatement("insert into dev_gaugedata_tbl(gauge_id,gauge_quantity,customer_approval,gauge_po_date,gauge_target_date,gauge_receipt_date,basic_id,created_by,created_date,opnno_opn_rel_id,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?)");
				
				ps_addGData.setInt(1, maxGaugeId);
				ps_addGData.setInt(2, vo.getGauge_qty());
				ps_addGData.setString(3, vo.getCust_apr());
				ps_addGData.setDate(4, vo.getGauge_po_date());
				ps_addGData.setDate(5, vo.getGauge_trg_date());
				ps_addGData.setDate(6, vo.getGauge_rec_date());
				ps_addGData.setInt(7, vo.getBasic_id());
				ps_addGData.setInt(8, uid);
				ps_addGData.setDate(9, Date);
				ps_addGData.setInt(10, vo.getRel_id());
				ps_addGData.setInt(11, vo.getAvail_qty());
				
				addGData_var=ps_addGData.executeUpdate();
				
				if(addGData_var>0)
				{
					PreparedStatement ps_getMaxGData_Id=con.prepareStatement("select max(gd_id) from dev_gaugedata_tbl");
					ResultSet rs_getMaxGData_Id=ps_getMaxGData_Id.executeQuery();
					
					while(rs_getMaxGData_Id.next())
					{
						maxGData_Id=rs_getMaxGData_Id.getInt("max(gd_id)");
					}
					rs_getMaxGData_Id.close();
					ps_getMaxGData_Id.close();
					
					PreparedStatement ps_addGData_Hist=con.prepareStatement("insert into dev_gaugedata_tbl_hist(gd_id,gauge_quantity,customer_approval,gauge_po_date,gauge_target_date,gauge_receipt_date,basic_id,created_by,created_date,created_date_hist,gauge_id,opnno_opn_rel_id,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
					ps_addGData_Hist.setInt(1, maxGData_Id);
					ps_addGData_Hist.setInt(2, vo.getGauge_qty());
					ps_addGData_Hist.setString(3, vo.getCust_apr());
					ps_addGData_Hist.setDate(4, vo.getGauge_po_date());
					ps_addGData_Hist.setDate(5, vo.getGauge_trg_date());
					ps_addGData_Hist.setDate(6, vo.getGauge_rec_date());
					ps_addGData_Hist.setInt(7, vo.getBasic_id());
					ps_addGData_Hist.setInt(8, uid);
					ps_addGData_Hist.setDate(9, Date);
					ps_addGData_Hist.setDate(10, Date);
					ps_addGData_Hist.setInt(11, maxGaugeId);
					ps_addGData_Hist.setInt(12, vo.getRel_id());
					ps_addGData_Hist.setInt(13, vo.getAvail_qty());
					
					addGDataHist_var=ps_addGData_Hist.executeUpdate();
					
					if(addGDataHist_var>0)
					{
						flag=true;
						System.out.println("gauge Data added with history...");
					}
					
				}
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

}
