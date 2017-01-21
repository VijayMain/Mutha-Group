package com.muthagroup.bo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Change_Request_DAO;
import com.muthagroup.dao.EDIT_Request_DAO;
import com.muthagroup.vo.change_Request_Vo;
//============================================================================-->
//========================= Business Object ==================================-->
//============================================================================-->
public class Change_Request_BO {

	public boolean changeRequest(change_Request_Vo bean, ArrayList app_list,
			ArrayList chang_list, HttpSession session, ArrayList trk_list) {

		boolean flag = false;
		try {

			// ********************************************************************************************************
			// ****************************************************************************************

			System.out.println("Approvers list ===== " + app_list.size());

			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			// ****************************************************************************************
			bean.setCR_Date(timestamp);
			System.out.println("change = " + chang_list + "app list = "
					+ app_list + "trk list = " + trk_list);
			Change_Request_DAO dao = new Change_Request_DAO();
			flag = dao.registerChange(bean, app_list, chang_list, session,
					trk_list);

			// ********************************************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	// *****************************************************************************************************************
	// Edit Request ======== >>>>>>>>
	// *****************************************************************************************************************

	public boolean Edit_changeRequest(change_Request_Vo bean,
			ArrayList app_list, ArrayList chang_list, HttpSession session,
			ArrayList trk_list) {
		boolean flag = false;
		try {

			EDIT_Request_DAO dao = new EDIT_Request_DAO();
			flag = dao.Edit_ChangeRequest(bean, app_list, chang_list, session,
					trk_list);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

}
