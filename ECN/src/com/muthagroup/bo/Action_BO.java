package com.muthagroup.bo;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Action_DAO;
import com.muthagroup.vo.Action_VO;

//============================================================================-->
//========================= business Object ==================================-->
//============================================================================-->

public class Action_BO {
	boolean flag = false;
	int action_id = 0;
	Action_DAO dao = new Action_DAO();

	public int addAction(Action_VO bean, HttpSession session) {
		try {

			SimpleDateFormat formatter = new SimpleDateFormat(
					"dd-MM-yyyy HH:mm:ss");
			String pdate = null, adate = null;
			pdate = bean.getPdate();
			adate = bean.getAdate();
			System.out.println("Action Dates ==== " + pdate + " \ntesting === "
					+ adate);
			Timestamp ProposedDate = null, ActualDate = null;

			ProposedDate = new java.sql.Timestamp(formatter.parse(pdate)
					.getTime());

			ActualDate = new java.sql.Timestamp(formatter.parse(adate)
					.getTime());
			bean.setProposed_date(ProposedDate);
			bean.setActual_impl_date(ActualDate);

			System.out.println("Actual Impl Date = "
					+ bean.getActual_impl_date());
			System.out.println("Proposed Date = " + bean.getProposed_date());
			System.out.print("\n I am in  bo...");

			action_id = dao.addAction(bean, session);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return action_id;
	}
	//============================================================================--> 
	//======================= Add Actual operation BO =============================-->
	public int addActualOP(Action_VO bean, HttpSession session) {

		try {

			action_id = dao.add_ActualOP_dao(bean, session);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return action_id;
	}
}
