package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Add_Fixture_bo;
import com.muthagroup.bo.Edit_Fixture_bo;
import com.muthagroup.vo.Add_Fixture_vo;
import com.muthagroup.vo.Edit_Fixture_vo;

public class Edit_Fixture_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		boolean flag = false;

		String fixture = null;
		String fixture_no = null;
		String fixtpono = null;
		String new_fixture=null;
		String new_fixture_no=null;

		int mcdataid = 0;
		int rel_id = 0;
		int fixtqty = 0;
		int basic_id = 0;
		int fixavail_qty=0;
		new_fixture=request.getParameter("new_fixture");
		new_fixture_no=request.getParameter("new_fixture_no");
		
		fixavail_qty=Integer.parseInt(request.getParameter("fixt_availqty"));
		
		fixtpono = request.getParameter("fixtpono");
		fixture = request.getParameter("fixture");
		fixture_no = request.getParameter("fixture_no");

		if (request.getParameter("fixtqty") != null) {
			fixtqty = Integer.parseInt(request.getParameter("fixtqty"));
		}

		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date convertedDate = null;
			Edit_Fixture_vo vo = new Edit_Fixture_vo();
			convertedDate = formatter.parse(request.getParameter("quotdate"));

			final java.sql.Date quotdate = new java.sql.Date(
					convertedDate.getTime());

			convertedDate = formatter.parse(request.getParameter("podate"));

			final java.sql.Date podate = new java.sql.Date(
					convertedDate.getTime());

			convertedDate = formatter.parse(request
					.getParameter("targetrecdate"));

			final java.sql.Date targetrecdate = new java.sql.Date(
					convertedDate.getTime());

			if(!request.getParameter("actrecdate").equalsIgnoreCase("")){ 
				convertedDate = formatter.parse(request.getParameter("actrecdate"));
				final java.sql.Date actrecdate = new java.sql.Date(convertedDate.getTime());
				vo.setActrecdate(actrecdate);
				}else {
					vo.setActrecdate(null); 
				} 
			mcdataid = Integer.parseInt(request.getParameter("mcDataId"));
			rel_id = Integer.parseInt(request.getParameter("rel_id"));
			System.out.println("MAC DATA = " + mcdataid);
			basic_id = Integer.parseInt(request.getParameter("basic_id"));
			System.out.println("Basic Id  fixture = " + basic_id);
			

			vo.setNew_fixture(new_fixture);
			vo.setNew_fixture_no(new_fixture_no);
			vo.setFixtqty(fixtqty);
			vo.setRel_id(rel_id);
			vo.setFixAvail(fixavail_qty);
			vo.setFixtpono(fixtpono);
			vo.setFixture(fixture);
			vo.setFixture_no(fixture_no);
			vo.setMcdataid(mcdataid);
			vo.setPodate(podate);
			vo.setQuotdate(quotdate);
			vo.setTargetrecdate(targetrecdate);

			Edit_Fixture_bo bo = new Edit_Fixture_bo();

			flag = bo.addFixture(vo, request);

			if (flag == true) {
				System.out.println("Basic Id  fixture in loop = " + basic_id);
				response.sendRedirect("Activity_Sheet.jsp?hid=" + basic_id);
			} else {
				System.out.println("Error occured...");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
