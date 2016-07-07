package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import java.text.*;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Register_VO;
import com.muthagroup.vo.UserVO;

public class Complaint_History_DAO {

	Connection con = null;
	PreparedStatement ps = null, ps1 = null;
	ResultSet rs = null, rs1 = null;
	boolean flag = false;
	Date C_History_Date = null;

	public boolean insert_History(Register_VO beans, UserVO userVO, int uid,
			int stat_id, int def_id) {
		try {

			// ***********************************************************************

			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			System.out.println("****************************************");
			System.out.println(C_History_Date + "\n"
					+ userVO.getComplaint_Number() + "\n" + uid + "\n"
					+ beans.getCust_id() + "\n" + beans.getItem_id() + "\n"
					+ def_id + "\n" + beans.getReceived() + "\n"
					+ beans.getDiscription() + "\n" + beans.getRelated() + "\n"
					+ beans.getAssigned() + "\n" + beans.getCategory() + "\n"
					+ beans.getDate() + "\n" + stat_id + "\n"
					+ beans.getCust_comp_id() + "\n" + beans.getDate() + "\n"
					+ beans.getSeverity());

			// ************************************************************************
			con = Connection_Utility.getConnection();

			ps = con.prepareStatement("insert into complaint_tbl_history(C_History_Date,Complaint_No,U_Id,Cust_Id,Item_Id,Defect_Id,Complaint_Received_By,Complaint_Description,Complaint_Related_To,Complaint_Assigned_To,Category_Id,Status_Id,Company_Id,Complaint_Date,P_Id)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			ps.setTimestamp(1, timestamp);
			ps.setString(2, userVO.getComplaint_Number());
			ps.setInt(3, uid);
			ps.setInt(4, beans.getCust_id());
			ps.setInt(5, beans.getItem_id());
			ps.setInt(6, def_id);
			ps.setString(7, beans.getReceived());
			ps.setString(8, beans.getDiscription());
			ps.setInt(9, beans.getRelated());
			ps.setInt(10, beans.getAssigned());
			ps.setInt(11, beans.getCategory());
			ps.setInt(12, stat_id);
			ps.setInt(13, beans.getCust_comp_id());
			ps.setTimestamp(14, beans.getDate());
			ps.setInt(15, beans.getSeverity());

			int update = ps.executeUpdate();

			if (update > 0) {
				System.out.println("Data In history");
				flag = true;
			} else {
				System.out.println("Data lost in history");
				return flag;
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return flag;

	}
}
