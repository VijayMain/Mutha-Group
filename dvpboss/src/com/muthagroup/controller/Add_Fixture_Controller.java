package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Add_Fixture_bo;
import com.muthagroup.vo.Add_Fixture_vo;

public class Add_Fixture_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	boolean flag;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String fixture = null;
		String fixture_no = null;
		String fixtpono = null;

		// Date quotdate=null;
		// Date podate=null;
		// Date targetrecdate=null;
		// Date actrecdate=null;
		
		int basic_id=0;
		int mcdataid = 0;
		int rel_id = 0;
		int fixtqty=0;
		int fixavail_qty=0;
		fixtpono = request.getParameter("fixtpono");
		fixture = request.getParameter("fixture");
		fixture_no = request.getParameter("fixture_no");
		fixavail_qty =Integer.parseInt(request.getParameter("fx_avail"));

		if(request.getParameter("basic_id")!=null)
		{
			basic_id=Integer.parseInt(request.getParameter("basic_id"));
		}
		if(request.getParameter("fixtqty")!=null)
		{
			fixtqty=Integer.parseInt(request.getParameter("fixtqty"));
		}
		
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date convertedDate = null;
			Add_Fixture_vo vo = new Add_Fixture_vo();
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
			
			
			vo.setFix_qty(fixtqty);
			vo.setRel_id(rel_id);
			vo.setFixAvail(fixavail_qty);
			vo.setFixtpono(fixtpono);
			vo.setFixture(fixture);
			vo.setFixture_no(fixture_no);
			vo.setMcdataid(mcdataid);
			vo.setPodate(podate);
			vo.setQuotdate(quotdate);
			vo.setTargetrecdate(targetrecdate);

			Add_Fixture_bo bo = new Add_Fixture_bo();

			flag = bo.addFixture(vo, request);

			if (flag == true) {
				response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
			} else {
				System.out.println("Error at Fixture controller....");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
