package com.muthagroup.bo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Change_Request_DAO;
import com.muthagroup.dao.Customer_Request_DAO;
import com.muthagroup.vo.Customer_Request_VO;
//============================================================================-->
//========================= Business Object ==================================-->
//============================================================================-->
public class Customer_Request_BO {

	public boolean changeRequest(Customer_Request_VO bean, ArrayList app_list,
			ArrayList chang_dept, HttpSession session) {
		boolean flag = false;
		try {

			// ********************************************************************************************************
			// ****************************************************************************************
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());
			// System.out.println("by TIMESTAMP..:" + timestamp);

			// ****************************************************************************************
			bean.setCRC_Date(timestamp);
			System.out.println("change = " + chang_dept.size() + "app list = "
					+ app_list.size());
			Customer_Request_DAO dao = new Customer_Request_DAO();
			flag = dao.registerChange(bean, app_list, chang_dept, session);

			// ********************************************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean EditchangeRequest(Customer_Request_VO bean,
			ArrayList app_list, ArrayList chang_dept, HttpSession session) {
		boolean flag = false;
		try {

			// ********************************************************************************************************
			// ****************************************************************************************
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			System.out.println("by date..:" + dateFormat.format(date));

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			System.out.println("by TIMESTAMP..:" + timestamp);

			// ****************************************************************************************
			bean.setCRC_Date(timestamp);
			System.out.println("change = " + chang_dept.size() + "app list = "
					+ app_list.size());
			Customer_Request_DAO dao = new Customer_Request_DAO();
			flag = dao.EditregisterChange(bean, app_list, chang_dept, session);

			// ********************************************************************************************************

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

}
