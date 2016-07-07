package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_PPAPTrials_vo;
import java.sql.*;

public class Add_PPAPTrials_dao {
	boolean flag = false;
	private static final java.sql.Date currDate = new java.sql.Date(
			System.currentTimeMillis());

	public boolean addPrePPAP(Add_PPAPTrials_vo vo, HttpServletRequest request) {

		try {
			HttpSession session = request.getSession();
			int uid = 0;

			int addPPAP_var = 0;
			int addPPAPHist_var = 0;
			int max_PPAP_Id = 0,attachId=0;
			uid = Integer.parseInt(session.getAttribute("uid").toString());

			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_addPrePPAP = con
					.prepareStatement("insert into dev_ppap_trial_tbl(mc_allocation,ppap_pilot_lot,pilot_lot_feedback,ppap_batch_date,feedback_details,Handover_toProd,created_by,created_date,Basic_Id)values(?,?,?,?,?,?,?,?,?) ");
			ps_addPrePPAP.setDouble(1, vo.getMc_allocation());
			ps_addPrePPAP.setInt(2, vo.getPpapbatch_lot());
			ps_addPrePPAP.setString(3, vo.getFeedback());
			ps_addPrePPAP.setDate(4, vo.getPpap_date());
			ps_addPrePPAP.setString(5, vo.getFeedback_details());
			ps_addPrePPAP.setDate(6, vo.getHandover_toprod_date());
			ps_addPrePPAP.setInt(7, uid);
			ps_addPrePPAP.setDate(8, currDate);
			ps_addPrePPAP.setInt(9, vo.getBasic_id());

			addPPAP_var = ps_addPrePPAP.executeUpdate();

			if (addPPAP_var > 0) {
				PreparedStatement ps_getMaxId = con
						.prepareStatement("select max(ppap_trial_id) from dev_ppap_trial_tbl");
				ResultSet rs_getMaxId = ps_getMaxId.executeQuery();

				while (rs_getMaxId.next()) {
					max_PPAP_Id = rs_getMaxId.getInt("max(ppap_trial_id)");
				}
				rs_getMaxId.close();
				ps_getMaxId.close();

				PreparedStatement ps_addPrePPAP_Hist = con
						.prepareStatement("insert into dev_ppap_trial_tbl_hist(mc_allocation,ppap_pilot_lot,pilot_lot_feedback,ppap_batch_date,feedback_details,handover_toProd,created_by,created_date,created_date_hist,Basic_Id,ppap_trial_id)values(?,?,?,?,?,?,?,?,?,?,?)");

				ps_addPrePPAP_Hist.setDouble(1, vo.getMc_allocation());
				ps_addPrePPAP_Hist.setInt(2, vo.getPpapbatch_lot());
				ps_addPrePPAP_Hist.setString(3, vo.getFeedback());
				ps_addPrePPAP_Hist.setDate(4, vo.getPpap_date());
				ps_addPrePPAP_Hist.setString(5, vo.getFeedback_details());
				ps_addPrePPAP_Hist.setDate(6, vo.getHandover_toprod_date());
				ps_addPrePPAP_Hist.setInt(7, uid);
				ps_addPrePPAP_Hist.setDate(8, currDate);
				ps_addPrePPAP_Hist.setDate(9, currDate);
				ps_addPrePPAP_Hist.setInt(10, vo.getBasic_id());
				ps_addPrePPAP_Hist.setInt(11, max_PPAP_Id);

				addPPAPHist_var = ps_addPrePPAP_Hist.executeUpdate();
				flag = true;

			}
			if (!vo.getAttch_file_name().equalsIgnoreCase("")) {
				PreparedStatement ps_attachfile = con
						.prepareStatement("insert into dev_ppap_trial_attachment_tbl(Basic_Id,attachment,file_name,attached_by,attached_date,Enable_Id,ppap_trial_id)values(?,?,?,?,?,?,?)");
				ps_attachfile.setInt(1, vo.getBasic_id());
				ps_attachfile.setBlob(2, vo.getAttachment());
				ps_attachfile.setString(3, vo.getAttch_file_name());
				ps_attachfile.setInt(4, uid);
				ps_attachfile.setDate(5, currDate);
				ps_attachfile.setInt(6, 1);
				ps_attachfile.setInt(7, max_PPAP_Id);

				int att = ps_attachfile.executeUpdate();

				if (att > 0) {
					PreparedStatement ps_atId = con
							.prepareStatement("select max(ppap_trial_attach_id) from dev_ppap_trial_attachment_tbl");
					ResultSet rs_atId = ps_atId.executeQuery();
					while (rs_atId.next()) {
						attachId = rs_atId
								.getInt("max(ppap_trial_attach_id)");
					}

					PreparedStatement ps_attHist = con
							.prepareStatement("insert into dev_ppap_trial_attachment_tbl_hist (Basic_Id,attachment,file_name,attached_by,attached_date,attached_date_hist,Enable_Id,ppap_trial_attach_id,ppap_trial_id)values(?,?,?,?,?,?,?,?,?)");
					ps_attHist.setInt(1, vo.getBasic_id());
					ps_attHist.setBlob(2, vo.getAttachment());
					ps_attHist.setString(3, vo.getAttch_file_name());
					ps_attHist.setInt(4, uid);
					ps_attHist.setDate(5, currDate);
					ps_attHist.setDate(6, currDate);
					ps_attHist.setInt(7, 1);
					ps_attHist.setInt(8, attachId);
					ps_attHist.setInt(9, max_PPAP_Id);
					int attFileHist = ps_attHist.executeUpdate();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

}
