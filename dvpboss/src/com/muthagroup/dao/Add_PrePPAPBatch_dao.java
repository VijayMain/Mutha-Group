package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_PPAPTrials_vo;

public class Add_PrePPAPBatch_dao {

	private static final java.sql.Date currDate = new java.sql.Date(
			System.currentTimeMillis());

	public boolean addBatch(Add_PPAPTrials_vo vo, HttpServletRequest request) {
		boolean flag = false;
		int uid = 0, maxId = 0, attachId = 0;
		HttpSession session = request.getSession();
		uid = Integer.parseInt(session.getAttribute("uid").toString());

		try {
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps_preppap = con
					.prepareStatement("insert into dev_preppap_trial_tbl(mc_allocation,preppap_pilot_lot,pilot_lot_feedback,ppap_batch_date,feedback_details,created_by,created_date,Basic_Id)values(?,?,?,?,?,?,?,?)");
			ps_preppap.setDouble(1, vo.getMc_allocation());
			ps_preppap.setInt(2, vo.getPpapbatch_lot());
			ps_preppap.setString(3, vo.getFeedback());
			ps_preppap.setDate(4, vo.getPpap_date());
			ps_preppap.setString(5, vo.getFeedback_details());
			ps_preppap.setInt(6, uid);
			ps_preppap.setDate(7, currDate);
			ps_preppap.setInt(8, vo.getBasic_id());
			int prep = ps_preppap.executeUpdate();

			if (prep > 0) {

				PreparedStatement ps = con
						.prepareStatement("select max(preppap_trial_id) from dev_preppap_trial_tbl");
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					maxId = rs.getInt("max(preppap_trial_id)");
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
						.prepareStatement("insert into dev_preppap_trial_attachment_tbl(Basic_Id,attachment,file_name,attached_by,attached_date,Enable_Id,preppap_trial_id)values(?,?,?,?,?,?,?)");
				ps_attachfile.setInt(1, vo.getBasic_id());
				ps_attachfile.setBlob(2, vo.getAttachment());
				ps_attachfile.setString(3, vo.getAttch_file_name());
				ps_attachfile.setInt(4, uid);
				ps_attachfile.setDate(5, currDate);
				ps_attachfile.setInt(6, 1);
				ps_attachfile.setInt(7, maxId);

				int att = ps_attachfile.executeUpdate();

				if (att > 0) {
					PreparedStatement ps_atId = con
							.prepareStatement("select max(preppap_trial_attach_id) from dev_preppap_trial_attachment_tbl");
					ResultSet rs_atId = ps_atId.executeQuery();
					while (rs_atId.next()) {
						attachId = rs_atId
								.getInt("max(preppap_trial_attach_id)");
					}

					PreparedStatement ps_attHist = con
							.prepareStatement("insert into dev_preppap_trial_attachment_tbl_hist (Basic_Id,attachment,file_name,attached_by,attached_date,attached_date_hist,Enable_Id,preppap_trial_attach_id,preppap_trial_id)values(?,?,?,?,?,?,?,?,?)");
					ps_attHist.setInt(1, vo.getBasic_id());
					ps_attHist.setBlob(2, vo.getAttachment());
					ps_attHist.setString(3, vo.getAttch_file_name());
					ps_attHist.setInt(4, uid);
					ps_attHist.setDate(5, currDate);
					ps_attHist.setDate(6, currDate);
					ps_attHist.setInt(7, 1);
					ps_attHist.setInt(8, attachId);
					ps_attHist.setInt(9, maxId);
					int attFileHist = ps_attHist.executeUpdate();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

}
