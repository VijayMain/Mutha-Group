package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_IMM_vo;

public class Add_IMM_dao {

	boolean flag = false;
	private static final java.sql.Date Date = new java.sql.Date(
			System.currentTimeMillis());

	public boolean addIMM(Add_IMM_vo vo, HttpServletRequest request) {
		try {
			int uid = 0;
			int addIMM_var = 0;
			int addIMMHist_var = 0;

			int maxIMM_Id = 0;

			HttpSession session = request.getSession();

			uid = Integer.parseInt(session.getAttribute("uid").toString());

			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_addIMM = con
					.prepareStatement("insert into dev_intmaterial_movement_tbl(material_type,discription,basic_id,created_by,created_date)values(?,?,?,?,?)");

			ps_addIMM.setString(1, vo.getMat_type());
			ps_addIMM.setString(2, vo.getMove_disc());
			ps_addIMM.setInt(3, vo.getBasic_id());
			ps_addIMM.setInt(4, uid);
			ps_addIMM.setDate(5, Date);

			addIMM_var = ps_addIMM.executeUpdate();

			if (addIMM_var > 0) {
				PreparedStatement ps_getMaxIMM_Id = con
						.prepareStatement("select max(mat_move_id) from dev_intmaterial_movement_tbl");
				ResultSet rs_getMaxIMM_Id = ps_getMaxIMM_Id.executeQuery();

				while (rs_getMaxIMM_Id.next()) {
					maxIMM_Id = rs_getMaxIMM_Id.getInt("max(mat_move_id)");
				}

				PreparedStatement ps_addIMM_Hist = con
						.prepareStatement("insert into dev_intmaterial_movement_tbl_hist(mat_move_id,material_type,discription,basic_id,created_by,created_date,created_date_hist)values(?,?,?,?,?,?,?)");
				ps_addIMM_Hist.setInt(1, maxIMM_Id);
				ps_addIMM_Hist.setString(2, vo.getMat_type());
				ps_addIMM_Hist.setString(3, vo.getMove_disc());
				ps_addIMM_Hist.setInt(4, vo.getBasic_id());
				ps_addIMM_Hist.setInt(5, uid);
				ps_addIMM_Hist.setDate(6, Date);
				ps_addIMM_Hist.setDate(7, Date);

				addIMMHist_var = ps_addIMM_Hist.executeUpdate();

				if (addIMMHist_var > 0) {
					flag = true;
					System.out.println("Imm Added with history....");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

}
