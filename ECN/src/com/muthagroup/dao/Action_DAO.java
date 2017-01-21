package com.muthagroup.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import com.muthagroup.connectionUtility.*;
import com.muthagroup.vo.Action_Customer_VO;
import com.muthagroup.vo.Action_VO;
//============================================================================-->
//============================ Action Data Access Model =============================-->
//============================================================================-->
public class Action_DAO {

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date date = new Date();
	java.sql.Timestamp today_date = new java.sql.Timestamp(date.getTime());

	Connection con = Connection_Utility.getConnection();
	
	public int addAction(Action_VO bean, HttpSession session) {
		int ActionId = 0;
		try {
			Timestamp proposed_Date = bean.getProposed_date();
			System.out.println("\nproposed_date :" + proposed_Date);

			Timestamp actual_impl_Date = bean.getActual_impl_date();
			System.out.println("\n Impl_date :" + actual_impl_Date);

			String action_Disc = bean.getAction_disc();
			System.out.println("\n Action :" + action_Disc);

			Timestamp crr_Date = bean.getCrrDate();
			System.out.println("\n current_date :" + crr_Date);

			int u_id = Integer.parseInt(session.getAttribute("uid").toString());

			System.out.println("\n User Id :" + u_id);

			int cr_No = Integer.parseInt(session.getAttribute("crno")
					.toString());
			System.out.println("\n Request No :" + cr_No);

			
			

			PreparedStatement ps_addAction = null;
			PreparedStatement ps_addAction_hist = null;

			ps_addAction = con
					.prepareStatement("insert into cr_tbl_action(CR_No,Action_Discription,U_Id,Proposed_Date,Actual_Impl_Date,Action_Date,proposed_Output,Actual_Output)values(?,?,?,?,?,?,?,?)");

			ps_addAction.setInt(1, cr_No);
			ps_addAction.setString(2, action_Disc);
			ps_addAction.setInt(3, u_id);
			ps_addAction.setTimestamp(4, proposed_Date);
			ps_addAction.setTimestamp(5, actual_impl_Date);
			ps_addAction.setTimestamp(6, today_date);
			ps_addAction.setString(7, bean.getProp_output());
			ps_addAction.setString(8, bean.getActual_Output());

			int i = ps_addAction.executeUpdate();

			System.out.println("first query is executed...");

			ps_addAction_hist = con
					.prepareStatement("insert into cr_tbl_action_hist(CR_No,Action_Discription,U_Id,Proposed_Date,Actual_Impl_Date,Action_Date_Original,Acton_Date_Hist,proposed_Output,Actual_Output)values(?,?,?,?,?,?,?,?,?)");

			ps_addAction_hist.setInt(1, cr_No);
			ps_addAction_hist.setString(2, action_Disc);
			ps_addAction_hist.setInt(3, u_id);
			ps_addAction_hist.setTimestamp(4, proposed_Date);
			ps_addAction_hist.setTimestamp(5, actual_impl_Date);
			ps_addAction_hist.setTimestamp(6, today_date);
			ps_addAction_hist.setTimestamp(7, today_date);
			ps_addAction_hist.setString(8, bean.getProp_output());
			ps_addAction_hist.setString(9, bean.getActual_Output());

			int j = ps_addAction_hist.executeUpdate();

			System.out.println("Second query is executed...");

			PreparedStatement ps_ActionId = con
					.prepareStatement("select max(CR_Action_Id) from cr_tbl_action");

			ResultSet rs_ActionId = ps_ActionId.executeQuery();

			while (rs_ActionId.next()) {
				ActionId = rs_ActionId.getInt("max(CR_Action_Id)");

				System.out.println("action id in dao.. :" + ActionId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("Send Action Id..." + ActionId);
		return ActionId;
	}

	public void attach_File(Action_VO bean, HttpSession session) {
		try {
			PreparedStatement ps_file = null;
			String sr = session.getAttribute("uid").toString();
			int uid = Integer.parseInt(sr);
			

			String file_Name = bean.getFile_Name_ext();
			int del = 1;

			// ****************************************************************************************************************************
			// Save attachment to database
			// ****************************************************************************************************************************
			InputStream file_blob1 = bean.getFile_blob();
			ps_file = con
					.prepareStatement("insert into cr_tbl_action_attachment(Cr_Action_Id,Atachment,Attach_Date,delete_status,File_Name,cr_no)values(?,?,?,?,?,?)");
			ps_file.setInt(1, bean.getActionId());
			ps_file.setBinaryStream(2, file_blob1);
			ps_file.setTimestamp(3, today_date);
			ps_file.setInt(4, del);
			ps_file.setString(5, bean.getFile_Name_ext());
			ps_file.setInt(6,
					Integer.parseInt(session.getAttribute("crno").toString()));
			int k = ps_file.executeUpdate();
			// ****************************************************************************************************************************

			PreparedStatement ps_del = con
					.prepareStatement("delete from cr_tbl_action_attachment where File_Name='"
							+ "" + "'");
			ps_del.executeUpdate();

			// ****************************************************************************************

			PreparedStatement ps_history = con
					.prepareStatement("insert into cr_tbl_action_attachment_hist(CR_Attach_Date_Hist,CR_Attach_Date_Original,CR_Action_Id,Delete_Status,File_name,CR_No)values(?,?,?,?,?,?) ");
			ps_history.setTimestamp(1, today_date);
			ps_history.setTimestamp(2, today_date);
			ps_history.setInt(3, bean.getActionId());

			ps_history.setInt(4, del);
			ps_history.setString(5, bean.getFile_Name_ext());
			ps_history.setInt(6,
					Integer.parseInt(session.getAttribute("crno").toString()));

			int l = ps_history.executeUpdate();

			PreparedStatement ps_del1 = con
					.prepareStatement("delete from cr_tbl_action_attachment_hist where File_Name='"
							+ "" + "'");
			ps_del1.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public int add_ActualOP_dao(Action_VO bean, HttpSession session) {
		int action_id=0;
		int i=0;
		
		int cr_No=0,u_id=0;
		String action_Disc=null,Prop_output=null,Actual_Output=null;
		Timestamp proposed_Date=null,actual_impl_Date=null,Action_Date_Original=null;
		
		try{
			PreparedStatement ps_addActOP = con
					.prepareStatement("Update cr_tbl_action set Actual_Impl_Date=?,Actual_Output=? where CR_Action_Id="+bean.getAction_No());

			ps_addActOP.setTimestamp(1, bean.getActaul_ImplDate_Act());
			ps_addActOP.setString(2, bean.getActual_Output());

			i=ps_addActOP.executeUpdate();
			
			if(i>0)
			{
				PreparedStatement ps_getActioDetails=con.prepareStatement("select * from cr_tbl_action where CR_Action_Id="+bean.getAction_No());
				
				ResultSet rs_getActioDetails=ps_getActioDetails.executeQuery();
				while(rs_getActioDetails.next())
				{
					cr_No=rs_getActioDetails.getInt("CR_No");
					action_Disc=rs_getActioDetails.getString("Action_Discription");
					u_id=rs_getActioDetails.getInt("U_Id");
					proposed_Date=rs_getActioDetails.getTimestamp("Proposed_Date");
					actual_impl_Date=rs_getActioDetails.getTimestamp("Actual_Impl_Date");
					Action_Date_Original=rs_getActioDetails.getTimestamp("Action_Date");
					Prop_output=rs_getActioDetails.getString("proposed_Output");
					Actual_Output=rs_getActioDetails.getString("Actual_Output");
				}
				PreparedStatement ps_addAction_histOP = con
						.prepareStatement("insert into cr_tbl_action_hist(CR_No,Action_Discription,U_Id,Proposed_Date,Actual_Impl_Date,Action_Date_Original,Acton_Date_Hist,proposed_Output,Actual_Output)values(?,?,?,?,?,?,?,?,?)");

				ps_addAction_histOP.setInt(1, cr_No);
				ps_addAction_histOP.setString(2, action_Disc);
				ps_addAction_histOP.setInt(3, u_id);
				ps_addAction_histOP.setTimestamp(4, proposed_Date);
				ps_addAction_histOP.setTimestamp(5, actual_impl_Date);
				ps_addAction_histOP.setTimestamp(6, Action_Date_Original);
				ps_addAction_histOP.setTimestamp(7, today_date);
				ps_addAction_histOP.setString(8,Prop_output);
				ps_addAction_histOP.setString(9,Actual_Output);

				
				
				action_id=bean.getAction_No();
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return action_id;
	}

}
