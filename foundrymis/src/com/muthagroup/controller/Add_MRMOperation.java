package com.muthagroup.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.MRMOperation_dao;
import com.muthagroup.vo.MRMOperation_vo;

public class Add_MRMOperation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			MRMOperation_dao dao = new MRMOperation_dao();
			MRMOperation_vo vo = new MRMOperation_vo();

			HttpSession session = request.getSession();
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			String para = request.getParameter("para");
			String year = request.getParameter("year");
			
			
			String comppass = request.getParameter("comppass");
			String yearpass = request.getParameter("yearpass");
			
			vo.setPasscomp(comppass);
			vo.setPassyear(yearpass);

			String Apr = request.getParameter("budget_1");
			String May = request.getParameter("budget_2");
			String Jun = request.getParameter("budget_3");
			String Jul = request.getParameter("budget_4");
			String Aug = request.getParameter("budget_5");
			String Sep = request.getParameter("budget_6");
			String Oct = request.getParameter("budget_7");
			String Nov = request.getParameter("budget_8");
			String Dec = request.getParameter("budget_9");
			String Jan = request.getParameter("budget_10");
			String Feb = request.getParameter("budget_11");
			String Mar = request.getParameter("budget_12");

			
			
			ArrayList budgetList = new ArrayList();
			budgetList.add(Apr);
			budgetList.add(May);
			budgetList.add(Jun);
			budgetList.add(Jul);
			budgetList.add(Aug);
			budgetList.add(Sep);
			budgetList.add(Oct);
			budgetList.add(Nov);
			budgetList.add(Dec);
			budgetList.add(Jan);
			budgetList.add(Feb);
			budgetList.add(Mar); 
			
			ArrayList mntcnt = new ArrayList();
			mntcnt.add(3);
			mntcnt.add(4);
			mntcnt.add(5);
			mntcnt.add(6);
			mntcnt.add(7);
			mntcnt.add(8);
			mntcnt.add(9);
			mntcnt.add(10);
			mntcnt.add(11);
			mntcnt.add(0);
			mntcnt.add(1);
			mntcnt.add(2); 
			
			vo.setParameter(para);
			vo.setYear(year);
			
			dao.addBudgetData(uid,vo,response,budgetList,mntcnt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
