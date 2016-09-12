package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BillWisePurchase_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// *************************************************************************************************************
			String company = "";
			company = request.getParameter("company");

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			Date datefrom = formatter.parse(request.getParameter("FromDatebillwisepurchase"));
			Date dateto = formatter.parse(request.getParameter("ToDatebillwisepurchase"));

			String from = new SimpleDateFormat("yyyyMMdd").format(datefrom);
			String to = new SimpleDateFormat("yyyyMMdd").format(dateto);

			String date_from = from.replaceAll("[-+.^:,]", "");
			String date_to = to.replaceAll("[-+.^:,]", "");

			// *************************************************************************************************************

			if (company != "") {
				response.sendRedirect("Billwisepurchase.jsp?comp=" + company + "&from=" + date_from + "&to=" + date_to);
			}
			// Example : 
			// exec "DIERP"."dbo"."Sel_PurchaseRegister";1 '105', '0', '0', '1165,1169,11610,1167,1164,1163,11613,1161,1162,11612,1166,11616', '20160801', '20160911', 0

		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	}
}
