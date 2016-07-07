package com.muthagroup.bo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Complaint_Action_Dao;
import com.muthagroup.vo.Complaint_Action_VO;

public class Complaint_Action_BO {

	@SuppressWarnings("unused")
	public boolean actionUpdate(Complaint_Action_VO actionvo, String complaint_no, HttpSession session) {
		boolean flag = false;
		// **********************************************************************************
		// System date
		Date date = Calendar.getInstance().getTime();
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String today = formatter.format(date);
		System.out.println(today);
		// **********************************************************************************

		// time Required
		String time_req = actionvo.getDays() + ":" + actionvo.getHours();
		// ***********************************************************************************

		Complaint_Action_Dao actiondao = new Complaint_Action_Dao();
//		flag = actiondao.insertAction(actionvo, today, complaint_no,time_req,session);
		return flag;
	}

}
