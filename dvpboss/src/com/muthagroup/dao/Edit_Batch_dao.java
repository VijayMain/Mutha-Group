package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_Batch_vo;

import java.sql.*;

public class Edit_Batch_dao {

	private static final java.sql.Date curr_Date = new java.sql.Date(
			System.currentTimeMillis());
	boolean flag = false;

	public boolean updateBatch(Edit_Batch_vo vo, HttpServletRequest request) {

		HttpSession session = request.getSession();

		int uid = 0;

		uid = Integer.parseInt(session.getAttribute("uid").toString());

		Date OrgDate = null;

		int update_var = 0;
		int addHist_var = 0;

		try {
			// System.out.println("final 5");
			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_getOrgDate = con
					.prepareStatement("select created_date from dev_trial_tbl where trial_id="
							+ vo.getTrial_id());
			ResultSet rs_getOrgDate = ps_getOrgDate.executeQuery();

			while (rs_getOrgDate.next()) {
				OrgDate = rs_getOrgDate.getDate("created_date");
			}
			rs_getOrgDate.close();
			ps_getOrgDate.close();

			PreparedStatement ps_updateTrial = con
					.prepareStatement("update dev_trial_tbl set trial_date=?,trial_quantity=?,basic_id=?,trial_feedback=?,feedback_report_no=?,created_by=?,created_date=? where trial_id="
							+ vo.getTrial_id());

			ps_updateTrial.setDate(1, vo.getTrial_date());
			ps_updateTrial.setInt(2, vo.getTrial_qty());
			ps_updateTrial.setInt(3, vo.getBasic_id());
			ps_updateTrial.setString(4, vo.getFeedback_Details());
			ps_updateTrial.setString(5, vo.getFeddback_RNo());
			ps_updateTrial.setInt(6, uid);
			ps_updateTrial.setDate(7, curr_Date);

			update_var = ps_updateTrial.executeUpdate();

			if (update_var > 0) {
				// System.out.println("final 4");
				PreparedStatement ps_addBatch_Hist = con
						.prepareStatement("insert into dev_trial_tbl_hist(trial_date,trial_qty,feedback_details,feedback_report_no,created_date,Basic_Id,created_date_hist,created_by,trial_id)values(?,?,?,?,?,?,?,?,?)");

				ps_addBatch_Hist.setDate(1, vo.getTrial_date());
				ps_addBatch_Hist.setInt(2, vo.getTrial_qty());
				ps_addBatch_Hist.setString(3, vo.getFeedback_Details());
				ps_addBatch_Hist.setString(4, vo.getFeddback_RNo());
				ps_addBatch_Hist.setDate(5, curr_Date);
				ps_addBatch_Hist.setInt(6, vo.getBasic_id());
				ps_addBatch_Hist.setDate(7, OrgDate);
				ps_addBatch_Hist.setInt(8, uid);
				ps_addBatch_Hist.setInt(9, vo.getTrial_id());
				addHist_var = ps_addBatch_Hist.executeUpdate();
				flag = true;
			}

			if (!vo.getAttch_file_name().equalsIgnoreCase("")) {
				
				
				int trialAttachmentId =0;
				
				PreparedStatement ps_attachDate=con.prepareStatement("select * from dev_trial_attachment_tbl where trial_id="+vo.getTrial_id());
				ResultSet rs_attachDate=ps_attachDate.executeQuery();
				while(rs_attachDate.next()){
					OrgDate=rs_attachDate.getDate("attached_date");
					trialAttachmentId=rs_attachDate.getInt("trial_attachment_id");
				}
				
				PreparedStatement ps_attach = con
						.prepareStatement("update dev_trial_attachment_tbl set Basic_Id=?,attachment=?,file_name=?,attached_by=?,attached_date=?,Enable_Id=? where trial_id="
								+ vo.getTrial_id());
				ps_attach.setInt(1, vo.getBasic_id());
				ps_attach.setBlob(2, vo.getTrial_attachment());
				ps_attach.setString(3, vo.getAttch_file_name());
				ps_attach.setInt(4, uid);
				ps_attach.setDate(5, curr_Date);
				ps_attach.setInt(6, 1);
				
				int file=ps_attach.executeUpdate();
				
				PreparedStatement ps_attachHist=con.prepareStatement("insert into dev_trial_attachment_tbl_hist(Basic_Id,attachment,file_name,attached_by,attached_date,Enable_Id,trial_id,Attached_date_hist,trial_attachment_id)values(?,?,?,?,?,?,?,?,?)");
				ps_attachHist.setInt(1, vo.getBasic_id());
				ps_attachHist.setBlob(2, vo.getTrial_attachment());
				ps_attachHist.setString(3, vo.getAttch_file_name());
				ps_attachHist.setInt(4, uid);
				ps_attachHist.setDate(5, curr_Date);
				ps_attachHist.setInt(6, 1);
				ps_attachHist.setInt(7, vo.getTrial_id());
				ps_attachHist.setDate(8, OrgDate);
				ps_attachHist.setInt(9, trialAttachmentId);
				
				int file_hist=ps_attachHist.executeUpdate();
				flag=true;
			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		return flag;
	}

}
