package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_Batch_vo;

import java.sql.*;

public class Add_Batch_dao {
	
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	boolean flag=false;
	public boolean addBatch(Add_Batch_vo vo, HttpServletRequest request) {
		
		int uid=0;
		
		HttpSession session=request.getSession();
		
		uid=Integer.parseInt(session.getAttribute("uid").toString());
		
		int addBatch_var=0;
		int addBatchHist_var=0;
		int maxId=0;
		
		int attach_var=0;
		int attachHist_var=0;
		
		int maxAttachId=0;
		
		try
		{
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_addBatch=con.prepareStatement("insert into dev_trial_tbl(trial_date,trial_quantity,basic_id,trial_feedback,feedback_report_no,created_by,created_date)values(?,?,?,?,?,?,?)");
			
			ps_addBatch.setDate(1, vo.getTrial_date());
			ps_addBatch.setInt(2, vo.getTrial_qty());
			ps_addBatch.setInt(3, vo.getBasic_id());
			ps_addBatch.setString(4, vo.getFeedback_Details());
			ps_addBatch.setString(5, vo.getFeddback_RNo());
			ps_addBatch.setInt(6, uid);
			ps_addBatch.setDate(7, Date);
			
			addBatch_var=ps_addBatch.executeUpdate();
			
			if(addBatch_var>0)
			{
				PreparedStatement ps_getMaxId=con.prepareStatement("select max(trial_id) from dev_trial_tbl");
				ResultSet rs_getMaxId=ps_getMaxId.executeQuery();
				
				while(rs_getMaxId.next())
				{
					maxId=rs_getMaxId.getInt("max(trial_id)");
				}
				rs_getMaxId.close();
				ps_getMaxId.close();
				
				PreparedStatement ps_addBatch_Hist=con.prepareStatement("insert into dev_trial_tbl_hist(trial_date,trial_qty,feedback_details,feedback_report_no,created_date,Basic_Id,created_date_hist,created_by,trial_id)values(?,?,?,?,?,?,?,?,?)"); 
				
				ps_addBatch_Hist.setDate(1, vo.getTrial_date());
				ps_addBatch_Hist.setInt(2, vo.getTrial_qty());
				ps_addBatch_Hist.setString(3, vo.getFeedback_Details());
				ps_addBatch_Hist.setString(4, vo.getFeddback_RNo());
				ps_addBatch_Hist.setDate(5, Date);
				ps_addBatch_Hist.setInt(6, vo.getBasic_id());
				ps_addBatch_Hist.setDate(7, Date);
				ps_addBatch_Hist.setInt(8, uid);
				ps_addBatch_Hist.setInt(9, maxId);
				
				addBatchHist_var=ps_addBatch_Hist.executeUpdate();
			}	
				
				if(addBatchHist_var>0 && vo.getAttch_file_name()!=null)
				{
					
					System.out.println("in file loop...");
					PreparedStatement ps_addAttachment=con.prepareStatement("insert into dev_trial_attachment_tbl(Basic_Id,attachment,file_name,attached_by,attached_date,Enable_Id,trial_id)values(?,?,?,?,?,?,?)");
					
					
					ps_addAttachment.setInt(1, vo.getBasic_id());
					ps_addAttachment.setBlob(2,vo.getTrial_attachment());
					ps_addAttachment.setString(3, vo.getAttch_file_name());
					ps_addAttachment.setInt(4, uid);
					ps_addAttachment.setDate(5, Date);
					ps_addAttachment.setInt(6,1);
					ps_addAttachment.setInt(7, maxId);
					
					
					attach_var=ps_addAttachment.executeUpdate();
					
					if(attach_var>0)
					{
						PreparedStatement ps_getMaxAttachId=con.prepareStatement("select max(trial_attachment_id) from dev_trial_attachment_tbl");
						ResultSet rs_getMaxAttachId=ps_getMaxAttachId.executeQuery();
						
						while(rs_getMaxAttachId.next())
						{
							maxAttachId=rs_getMaxAttachId.getInt("max(trial_attachment_id)");
						}
						rs_getMaxAttachId.close();
						ps_getMaxAttachId.close();
						
						PreparedStatement ps_addAttachHist=con.prepareStatement("insert into dev_trial_attachment_tbl_hist(Basic_Id,attachment,file_name,attached_by,attached_date,Enable_Id,trial_attachment_id,trial_id,Attached_date_hist)values(?,?,?,?,?,?,?,?,?)");
						
						ps_addAttachHist.setInt(1, vo.getBasic_id());
						ps_addAttachHist.setBlob(2, vo.getTrial_attachment());
						ps_addAttachHist.setString(3, vo.getAttch_file_name());
						ps_addAttachHist.setInt(4, uid);
						ps_addAttachHist.setDate(5, Date);
						ps_addAttachHist.setInt(6,1);
						ps_addAttachHist.setInt(7,maxAttachId);
						ps_addAttachHist.setInt(8,maxId);
						ps_addAttachHist.setDate(9, Date);
						
						
						attachHist_var=ps_addAttachHist.executeUpdate();
						
						if(attachHist_var>0)
						{
							flag=true;
						}
						
						
					}
					
					
					
				}
				else
				{
					flag=true;
				}
				
		
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return flag;
	}

}
