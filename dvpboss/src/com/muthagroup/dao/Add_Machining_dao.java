package com.muthagroup.dao;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_Machining_vo;

public class Add_Machining_dao {
	
	
	boolean flag=false;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());

	public boolean addMachiningData(Add_Machining_vo vo, HttpServletRequest request) 
	{
		try
		{
			boolean chkMachineNameFlag=false;
			int maxMachineNameId=0;
			int uid=0;
			int chkMachineName_var=0; 
			int addMachineNameHist_var=0;
			HttpSession session=request.getSession();
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_chkMachineName=con.prepareStatement("select machinename_id,machine_name from dev_machinename_mst_tbl");
			
			ResultSet rs_chkMachineName=ps_chkMachineName.executeQuery();
			
			while(rs_chkMachineName.next())
			{
				if(rs_chkMachineName.getString("machine_name").equalsIgnoreCase(vo.getMachine_name()))
				{
					chkMachineNameFlag=true;
					maxMachineNameId=rs_chkMachineName.getInt("MachineName_Id");
				}
			}
			
			if(chkMachineNameFlag==true)
			{
				System.out.println("machine name matched..."+maxMachineNameId);
			}
			else
			{
				PreparedStatement ps_addMachineName=con.prepareStatement("insert into dev_machinename_mst_tbl(machine_name,created_by,created_date)values(?,?,?)");
				ps_addMachineName.setString(1, vo.getMachine_name());
				ps_addMachineName.setInt(2, uid);
				ps_addMachineName.setDate(3, Date);
				
				chkMachineName_var=ps_addMachineName.executeUpdate();
				
				
				if(chkMachineName_var>0)
				{
					PreparedStatement ps_getMaxMachineId=con.prepareStatement("select max(MachineName_Id) from dev_machinename_mst_tbl");
					ResultSet rs_getMaxMachineId=ps_getMaxMachineId.executeQuery();
					
					while(rs_getMaxMachineId.next())
					{
						maxMachineNameId=rs_getMaxMachineId.getInt("max(MachineName_Id)");
					}
					
					PreparedStatement ps_addMAchineNameHist=con.prepareStatement("insert into dev_machinename_mst_tbl_hist(machinename_id,machine_name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addMAchineNameHist.setInt(1, maxMachineNameId);
					ps_addMAchineNameHist.setString(2, vo.getMachine_name());
					ps_addMAchineNameHist.setInt(3, uid);
					ps_addMAchineNameHist.setDate(4, Date);
					ps_addMAchineNameHist.setDate(5, Date);
					
					addMachineNameHist_var=ps_addMAchineNameHist.executeUpdate();
					
					if(addMachineNameHist_var>0)
					{
						System.out.println("Machine name history added ... max MachineName Id= "+maxMachineNameId);
					}
				}
			}
			
			int addMCData_var=0;
			int addMCDataHist_var=0;
			int maxMCDataId=0;
			
			PreparedStatement ps_addMCData=con.prepareStatement("insert into dev_mcdata_tbl(machinename_id,CT_sec,MCs_Used,production_per_shift,MC_Required,MC_Allocated,basic_id,created_by,created_date,OpnNo_Opn_Rel_Id,machinecode_id)values(?,?,?,?,?,?,?,?,?,?,?)");
			ps_addMCData.setInt(1, maxMachineNameId);
			ps_addMCData.setDouble(2, vo.getCt_sec());
			ps_addMCData.setInt(3, vo.getMc_used());
			ps_addMCData.setDouble(4, vo.getProd_per_shift());
			ps_addMCData.setDouble(5, vo.getMc_reqd());
			ps_addMCData.setDouble(6, vo.getMc_availability());
			ps_addMCData.setInt(7, vo.getBasic_id());
			ps_addMCData.setInt(8, uid);
			ps_addMCData.setDate(9, Date);
			ps_addMCData.setInt(10,vo.getOpnno_opn_rel_id());
			ps_addMCData.setInt(11,vo.getMcode());
			
			addMCData_var=ps_addMCData.executeUpdate();
			
			if(addMCData_var>0)
			{
				PreparedStatement ps_getMaxMCData_Id=con.prepareStatement("select max(mcdata_id) from dev_mcdata_tbl");
				ResultSet rs_getMaxMCData_Id=ps_getMaxMCData_Id.executeQuery();
				
				while(rs_getMaxMCData_Id.next())
				{
					maxMCDataId=rs_getMaxMCData_Id.getInt("max(mcdata_id)");
				}
				
				PreparedStatement ps_addMCDataHist=con.prepareStatement("insert into dev_mcdata_tbl_hist(mcdata_id,machinename_id,ct_sec,MCs_used,production_per_shift,MC_required,mc_allocated,basic_id,created_by,created_date,created_date_hist,OpnNo_Opn_Rel_Id,machinecode_id)values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps_addMCDataHist.setInt(1, maxMCDataId);
				ps_addMCDataHist.setInt(2, maxMachineNameId);
				ps_addMCDataHist.setDouble(3, vo.getCt_sec());
				ps_addMCDataHist.setInt(4, vo.getMc_used());
				ps_addMCDataHist.setDouble(5, vo.getProd_per_shift());
				ps_addMCDataHist.setDouble(6, vo.getMc_reqd());
				ps_addMCDataHist.setDouble(7, vo.getMc_availability());
				ps_addMCDataHist.setInt(8, vo.getBasic_id());
				ps_addMCDataHist.setInt(9, uid);
				ps_addMCDataHist.setDate(10, Date);
				ps_addMCDataHist.setDate(11, Date);
				ps_addMCDataHist.setInt(12,vo.getOpnno_opn_rel_id());
				ps_addMCDataHist.setInt(13,vo.getMcode());
				
				addMCDataHist_var=ps_addMCDataHist.executeUpdate();
				
				if(addMCDataHist_var>0)
				{
					System.out.println("machining data added with history....");
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
