package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_Machining_vo;

public class Edit_Machining_dao {

	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	boolean flag=false;
	
	public boolean editMachining(Edit_Machining_vo vo, HttpServletRequest request) 
	{
		
		try
		{
			HttpSession session=request.getSession();
			int maxMachineName_Id=0;
			
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			
			java.sql.Date createdDate=null;
			java.sql.Date createdMCData_Date=null;
			
			int updateMachineName_var=0;
			int AddMachineNameHist_var=0;
			boolean chkMachineName_flag=false;
			boolean addMachineName_Hist=false;
			boolean chkMachineName_flag1=false;
			
			int updateMCData_var=0;
			int mcdata_id=0;
			
			int updateMCDataHist_var=0;
			
			Connection con=Connection_Utility.getConnection();
			
			int newMachine_var=0;
			int newMachineHist_var=0;
			
			if(vo.getNew_machine_name()!=null)
			{
				System.out.println("new machine name Available.....");
				
				PreparedStatement ps_chkMachineName=con.prepareStatement("select machineName_id,machine_name from dev_machinename_mst_tbl");
				ResultSet rs_chkMachineName=ps_chkMachineName.executeQuery();
				while(rs_chkMachineName.next())
				{
					if(vo.getNew_machine_name().equalsIgnoreCase(rs_chkMachineName.getString("machine_name")))
					{
						maxMachineName_Id=rs_chkMachineName.getInt("machineName_id");
						chkMachineName_flag1=true;
					}
				}
				rs_chkMachineName.close();
				ps_chkMachineName.close();
				
				if(chkMachineName_flag1==false)
				{
									
				PreparedStatement ps_addMachineName=con.prepareStatement("insert into dev_machinename_mst_tbl(machine_name,created_by,created_date)values(?,?,?)");
				ps_addMachineName.setString(1, vo.getNew_machine_name());
				ps_addMachineName.setInt(2, uid);
				ps_addMachineName.setDate(3, Date);
				
				newMachine_var=ps_addMachineName.executeUpdate();
				
				if(newMachine_var>0)
				{
					
					
					PreparedStatement ps_getMaxId=con.prepareStatement("select max(machineName_id) from dev_machinename_mst_tbl");
					ResultSet rs_getMaxId=ps_getMaxId.executeQuery();
					while(rs_getMaxId.next())
					{
						maxMachineName_Id=rs_getMaxId.getInt("max(machineName_id)");
					}
					rs_getMaxId.close();
					ps_getMaxId.close();
					
					PreparedStatement ps_addMachineName_Hist=con.prepareStatement("insert into dev_machinename_mst_tbl_hist(machinename_id,machine_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addMachineName_Hist.setInt(1, maxMachineName_Id);
					ps_addMachineName_Hist.setString(2, vo.getNew_machine_name());
					ps_addMachineName_Hist.setInt(3, uid);
					ps_addMachineName_Hist.setDate(4, Date);
					ps_addMachineName_Hist.setDate(5, Date);
					
					newMachineHist_var=ps_addMachineName_Hist.executeUpdate();
					
					if(newMachineHist_var>0)
					{
						System.out.println("new machine name added .... max machine Name Id=="+maxMachineName_Id);
					}
				}

				}

			}
			else
			{
				
				PreparedStatement ps_chkMachineName=con.prepareStatement("select machineName_id,machine_name from dev_machinename_mst_tbl");
				ResultSet rs_chkMachineName=ps_chkMachineName.executeQuery();
				while(rs_chkMachineName.next())
				{
					if(vo.getMachine_name().equalsIgnoreCase(rs_chkMachineName.getString("machine_name")))
					{
						maxMachineName_Id=rs_chkMachineName.getInt("machineName_id");
						chkMachineName_flag=true;
					}
				}
				if(chkMachineName_flag==true)
				{
					System.out.println("Machine name matched.... max machine name id="+maxMachineName_Id);
				}
				else
				{
					PreparedStatement ps_getMachineName_Id=con.prepareStatement("select machinename_id,Created_date from dev_mcdata_tbl where basic_id="+vo.getBasic_id()+" and OpnNo_Opn_Rel_Id="+vo.getOpnno_opn_rel_id());
					ResultSet rs_getMachineName_Id=ps_getMachineName_Id.executeQuery();
					
						while(rs_getMachineName_Id.next())
					{
							maxMachineName_Id=rs_getMachineName_Id.getInt("machinename_id");
					}
				
						PreparedStatement ps_getOrgDate=con.prepareStatement("select created_date from dev_machinename_mst_tbl where machinename_id="+maxMachineName_Id);
						ResultSet rs_getOrgDate=ps_getOrgDate.executeQuery();
				
						while(rs_getOrgDate.next())
						{
							createdDate=rs_getOrgDate.getDate("created_date");
						}
				
				
						PreparedStatement ps_UpdateMachineName=con.prepareStatement("update dev_machinename_mst_tbl set machine_name=?,created_by=?,created_date=? where machinename_id="+maxMachineName_Id);
						
						ps_UpdateMachineName.setString(1, vo.getMachine_name());
						ps_UpdateMachineName.setInt(2, uid);
						ps_UpdateMachineName.setDate(3, Date);
				
						updateMachineName_var=ps_UpdateMachineName.executeUpdate();
				
						if(updateMachineName_var>0)
						{
							PreparedStatement ps_addMachineName_Hist=con.prepareStatement("insert into dev_machinename_mst_tbl_hist(machinename_id,machine_name,created_by,created_date,created_date_hist)value(?,?,?,?,?)");
					
							ps_addMachineName_Hist.setInt(1, maxMachineName_Id);
							ps_addMachineName_Hist.setString(2, vo.getMachine_name());
							ps_addMachineName_Hist.setInt(3, uid);
							ps_addMachineName_Hist.setDate(4, Date);
							ps_addMachineName_Hist.setDate(5, createdDate);
					
							AddMachineNameHist_var=ps_addMachineName_Hist.executeUpdate();
					
							if(AddMachineNameHist_var>0)
							{
								addMachineName_Hist=true;
								System.out.println("machine name history added....");
							}
					
						}
					}
			

				}
			
			
			PreparedStatement ps_getDateOfMCData=con.prepareStatement("select created_date,mcdata_id from dev_mcdata_tbl where basic_id="+vo.getBasic_id()+" and OpnNo_Opn_Rel_Id="+vo.getOpnno_opn_rel_id());
			ResultSet rs_getDateOfMCData=ps_getDateOfMCData.executeQuery();
			
			while(rs_getDateOfMCData.next())
			{
				createdMCData_Date=rs_getDateOfMCData.getDate("created_date");
				mcdata_id=rs_getDateOfMCData.getInt("mcdata_id");
			}
			rs_getDateOfMCData.close();
			ps_getDateOfMCData.close();
			
			
			PreparedStatement ps_updateMCData=con.prepareStatement("update dev_mcdata_tbl set machinename_id=?,CT_sec=?,MCs_Used=?,production_per_shift=?,MC_Required=?,MC_Allocated=?,created_by=?,created_date=?,machinecode_id=? where basic_id="+vo.getBasic_id()+" and OpnNo_Opn_Rel_Id="+vo.getOpnno_opn_rel_id());
			ps_updateMCData.setInt(1, maxMachineName_Id);
			ps_updateMCData.setDouble(2, vo.getCt_sec());
			ps_updateMCData.setInt(3, vo.getMc_used());
			ps_updateMCData.setDouble(4, vo.getProd_per_shift());
			ps_updateMCData.setDouble(5, vo.getMc_reqd());
			ps_updateMCData.setDouble(6, vo.getMc_allocated());
			ps_updateMCData.setInt(7, uid);
			ps_updateMCData.setDate(8, Date);
			ps_updateMCData.setInt(9, vo.getMcode());
			
			updateMCData_var=ps_updateMCData.executeUpdate();
			
			if(updateMCData_var>0)
			{
				PreparedStatement ps_addMCDataHist=con.prepareStatement("insert into dev_mcdata_tbl_hist(mcdata_id,machinename_id,ct_sec,MCs_used,production_per_shift,MC_required,mc_allocated,basic_id,created_by,created_date,created_date_hist,OpnNo_Opn_Rel_Id,machineCode_id)values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				ps_addMCDataHist.setInt(1, mcdata_id);
				ps_addMCDataHist.setInt(2, maxMachineName_Id);
				ps_addMCDataHist.setDouble(3, vo.getCt_sec());
				ps_addMCDataHist.setInt(4, vo.getMc_used());
				ps_addMCDataHist.setDouble(5, vo.getProd_per_shift());
				ps_addMCDataHist.setDouble(6, vo.getMc_reqd());
				ps_addMCDataHist.setDouble(7, vo.getMc_allocated());
				ps_addMCDataHist.setInt(8, vo.getBasic_id());
				ps_addMCDataHist.setInt(9, uid);
				ps_addMCDataHist.setDate(10, Date);
				ps_addMCDataHist.setDate(11,createdMCData_Date);
				ps_addMCDataHist.setInt(12, vo.getOpnno_opn_rel_id());
				ps_addMCDataHist.setInt(13, vo.getMcode());
				
				updateMCDataHist_var=ps_addMCDataHist.executeUpdate();
				
				if(updateMCDataHist_var>0)
				{
					flag=true;
					
					System.out.println("Machining data updated.. with history...");
				}
				
			}
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return flag;
		
	}
	
	
	

}
