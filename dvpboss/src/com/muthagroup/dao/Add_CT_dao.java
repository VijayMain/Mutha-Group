package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_CT_vo;

public class Add_CT_dao 
{
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	boolean flag=false;
	public boolean addCT(Add_CT_vo vo, HttpServletRequest request) 
	{
		HttpSession session=request.getSession();
		int uid=Integer.parseInt(session.getAttribute("uid").toString());

		try
		{
			int maxTool_id=0;
			boolean chkCTFlag=false;
			int addTool_var=0;
			int addToolHist_var=0;
			boolean addTool_Flag=false;
			
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_chkCT=con.prepareStatement("select ctool_Id,tool_name from dev_cutting_tool_mst_tbl");
			
			ResultSet rs_chkCT=ps_chkCT.executeQuery();
			
			while(rs_chkCT.next())
			{
				if(vo.getCutting_tool().equalsIgnoreCase(rs_chkCT.getString("tool_name")))
				{
					maxTool_id=rs_chkCT.getInt("ctool_id");
					chkCTFlag=true;
				}
			}
			rs_chkCT.close();
			ps_chkCT.close();
			
			if(chkCTFlag==true)
			{
				System.out.println("tool name matched ... toolId== "+maxTool_id);
				addTool_Flag=true;
			}
			else
			{
				PreparedStatement ps_addToolName=con.prepareStatement("insert into dev_cutting_tool_mst_tbl(tool_name,created_by,created_date)values(?,?,?)");
				
				ps_addToolName.setString(1, vo.getCutting_tool());
				ps_addToolName.setInt(2, uid);
				ps_addToolName.setDate(3, Date);
				
				addTool_var=ps_addToolName.executeUpdate();
				
				if(addTool_var>0)
				{
					PreparedStatement ps_getMaxToolId=con.prepareStatement("select max(ctool_Id) from dev_cutting_tool_mst_tbl");
					
					ResultSet rs_getMaxToolId=ps_getMaxToolId.executeQuery();
					
					while(rs_getMaxToolId.next())
					{
						maxTool_id=rs_getMaxToolId.getInt("max(ctool_Id)");
					}
					rs_getMaxToolId.close();
					ps_getMaxToolId.close();

					PreparedStatement ps_addToolNameHist=con.prepareStatement("insert into dev_cutting_tool_mst_tbl_hist(ctool_id,tool_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					
					ps_addToolNameHist.setInt(1, maxTool_id);
					ps_addToolNameHist.setString(2, vo.getCutting_tool());
					ps_addToolNameHist.setInt(3, uid);
					ps_addToolNameHist.setDate(4, Date);
					ps_addToolNameHist.setDate(5, Date);
					
					addToolHist_var=ps_addToolNameHist.executeUpdate();
					
					if(addToolHist_var>0)
					{
						addTool_Flag=true;
					}
				}
			}
			
			int maxCT_Id=0;
			int addCTData_var=0;
			int addCTDataHist_var=0;
			
			
			if(addTool_Flag==true)
			{
				PreparedStatement ps_addCTData=con.prepareStatement("insert into dev_cuttingtool_data_tbl(ctool_id,ctool_quantity,ctool_po_date,ctool_target_date,ctool_receipt_date,fd_id,created_by,created_date,ctool_po_no,opnno_opn_rel_id,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?)");
				
				ps_addCTData.setInt(1, maxTool_id);
				ps_addCTData.setInt(2, vo.getTool_qty());
				ps_addCTData.setDate(3, vo.getPo_date());
				ps_addCTData.setDate(4, vo.getTarget_tool_date());
				ps_addCTData.setDate(5, vo.getTool_recpt_date());
				ps_addCTData.setInt(6, vo.getFd_id());
				ps_addCTData.setInt(7, uid);
				ps_addCTData.setDate(8, Date);
				ps_addCTData.setString(9, vo.getTool_pono());
				ps_addCTData.setInt(10, vo.getRel_id());
				ps_addCTData.setInt(11, vo.getAvailtoolqty());
				
				addCTData_var=ps_addCTData.executeUpdate();
				
				if(addCTData_var>0)
				{
					PreparedStatement ps_getMaxCTData_Id=con.prepareStatement("select max(ctd_id) from dev_cuttingtool_data_tbl");
					ResultSet rs_getMaxCTData_Id=ps_getMaxCTData_Id.executeQuery();
					
					while(rs_getMaxCTData_Id.next())
					{
							maxCT_Id=rs_getMaxCTData_Id.getInt("max(ctd_id)");
					}
					rs_getMaxCTData_Id.close();
					ps_getMaxCTData_Id.close();
					
					PreparedStatement ps_addCTData_Hist=con.prepareStatement("insert into dev_cuttingtool_data_tbl_hist(ctd_id,ctool_id,ctool_quantity,ctool_po_date,ctool_Target_date,ctool_receipt_date,fd_id,created_by,created_date,ctool_po_no,created_date_hist,opnno_opn_rel_id,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?,?,?) ");
					
					ps_addCTData_Hist.setInt(1, maxCT_Id);
					ps_addCTData_Hist.setInt(2, maxTool_id);
					ps_addCTData_Hist.setInt(3, vo.getTool_qty());
					ps_addCTData_Hist.setDate(4, vo.getPo_date());
					ps_addCTData_Hist.setDate(5, vo.getTarget_tool_date());
					ps_addCTData_Hist.setDate(6, vo.getTool_recpt_date());
					ps_addCTData_Hist.setInt(7, vo.getFd_id());
					ps_addCTData_Hist.setInt(8, uid);
					ps_addCTData_Hist.setDate(9, Date);
					ps_addCTData_Hist.setString(10, vo.getTool_pono());
					ps_addCTData_Hist.setDate(11, Date);
					ps_addCTData_Hist.setInt(12, vo.getRel_id());
					ps_addCTData_Hist.setInt(13, vo.getAvailtoolqty());
					addCTDataHist_var=ps_addCTData_Hist.executeUpdate();
					
					if(addCTDataHist_var>0)
					{
						flag=true;
						System.out.println("CT Data added with history ....");
					}
				}
			}
			else
			{
				System.out.println("Error.....");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

}
