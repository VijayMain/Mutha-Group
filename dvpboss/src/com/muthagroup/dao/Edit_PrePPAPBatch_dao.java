package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_PPAPTrials_vo;

public class Edit_PrePPAPBatch_dao {

	private static final java.sql.Date currDate = new java.sql.Date(
			System.currentTimeMillis());

	public boolean editPreppapBatch(Add_PPAPTrials_vo vo,
			HttpServletRequest request) {
		boolean flag = false;
		int uid = 0, maxId = 0, attachId = 0;
		HttpSession session = request.getSession();
		uid = Integer.parseInt(session.getAttribute("uid").toString());

		try {
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps_preppap = con
					.prepareStatement("update dev_preppap_trial_tbl set mc_allocation=?,preppap_pilot_lot=?,pilot_lot_feedback=?,ppap_batch_date=?,feedback_details=?,created_by=?,created_date=? where Basic_Id="
							+ vo.getBasic_id() + " and preppap_trial_id="+vo.getPreppap_Id());
			ps_preppap.setDouble(1, vo.getMc_allocation());
			ps_preppap.setInt(2, vo.getPpapbatch_lot());
			ps_preppap.setString(3, vo.getFeedback());
			ps_preppap.setDate(4, vo.getPpap_date());
			ps_preppap.setString(5, vo.getFeedback_details());
			ps_preppap.setInt(6, uid);
			ps_preppap.setDate(7, currDate);
			int prep = ps_preppap.executeUpdate();

			if (prep > 0) {

				PreparedStatement ps = con
						.prepareStatement("select * from dev_preppap_trial_tbl where preppap_trial_id="
								+ vo.getPreppap_Id());
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					maxId = rs.getInt("preppap_trial_id");
				}
				PreparedStatement ps_preppapHist = con
						.prepareStatement("insert into dev_preppap_trial_tbl_hist(mc_allocation,preppap_pilot_lot,pilot_lot_feedback,ppap_batch_date,feedback_details,created_by,created_date,created_date_hist,Basic_Id,preppap_trial_id)values(?,?,?,?,?,?,?,?,?,?)");
				ps_preppapHist.setDouble(1, vo.getMc_allocation());
				ps_preppapHist.setInt(2, vo.getPpapbatch_lot());
				ps_preppapHist.setString(3, vo.getFeedback());
				ps_preppapHist.setDate(4, vo.getPpap_date());
				ps_preppapHist.setString(5, vo.getFeedback_details());
				ps_preppapHist.setInt(6, uid);
				ps_preppapHist.setDate(7, currDate);
				ps_preppapHist.setDate(8, currDate);
				ps_preppapHist.setInt(9, vo.getBasic_id());
				ps_preppapHist.setInt(10, maxId);
				int preppapHist = ps_preppapHist.executeUpdate();
				flag = true;
			}

			if (!vo.getAttch_file_name().equalsIgnoreCase("")) {
				PreparedStatement ps_attachfile = con
						.prepareStatement("update dev_preppap_trial_attachment_tbl set attachment=?,file_name=?,attached_by=?,attached_date=?,Enable_Id=? where Basic_Id="+vo.getBasic_id()+" and preppap_trial_id="+ vo.getPreppap_Id());
				ps_attachfile.setBlob(1, vo.getAttachment());
				ps_attachfile.setString(2, vo.getAttch_file_name());
				ps_attachfile.setInt(3, uid);
				ps_attachfile.setDate(4, currDate);
				ps_attachfile.setInt(5, 1);
				int att = ps_attachfile.executeUpdate();

				if (att > 0) {

					PreparedStatement ps_attHist = con
							.prepareStatement("insert into dev_preppap_trial_attachment_tbl_hist (Basic_Id,attachment,file_name,attached_by,attached_date,attached_date_hist,Enable_Id,preppap_trial_attach_id,preppap_trial_id)values(?,?,?,?,?,?,?,?,?)");
					ps_attHist.setInt(1, vo.getBasic_id());
					ps_attHist.setBlob(2, vo.getAttachment());
					ps_attHist.setString(3, vo.getAttch_file_name());
					ps_attHist.setInt(4, uid);
					ps_attHist.setDate(5, currDate);
					ps_attHist.setDate(6, currDate);
					ps_attHist.setInt(7, 1);
					ps_attHist.setInt(8, vo.getPreppap_AttachId());
					ps_attHist.setInt(9, vo.getPreppap_Id());
					int attFileHist = ps_attHist.executeUpdate();
					flag = true;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

}
