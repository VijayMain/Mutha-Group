package com.muthagroup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Edit_By_Search_Others_BO;
import com.muthagroup.vo.Edit_By_Search_Others_VO;

public class Edit_By_Search_Others_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	int cust_id = 0, p_id = 0, status_id = 0, company_id = 0;
	
	String complaint_no=null;
	Timestamp start_date=null,end_date=null;
	String start_date1=null,end_date1=null;
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		try {

			company_id = Integer.parseInt(request.getParameter("company_name"));
			cust_id = Integer.parseInt(request.getParameter("cust_name"));
			status_id = Integer.parseInt(request.getParameter("status"));
			p_id = Integer.parseInt(request.getParameter("severity"));
			
			complaint_no=request.getParameter("complaint_no");
			
			start_date1=request.getParameter("start_date");
			end_date1=request.getParameter("end_date");
			
			
			SimpleDateFormat formatter = new SimpleDateFormat(
					"dd-MM-yyyy HH:mm:ss");
			Timestamp date1 = null, date2 = null;
			
			
			if(start_date1!="")
			{
			
				start_date = new java.sql.Timestamp(
					formatter.parse(start_date1).getTime());

				// Get Date in DD/MM/YYYY format
				
					date1=start_date;
			}
			else
			{
				date1=null;
			}
			
			
			if(end_date1!="")
			{
				end_date = new java.sql.Timestamp(
					formatter.parse(end_date1).getTime());
					date2=end_date;
			}
			else
			{
				date2=null;
			}
			
			// String date1 = d4 + "/" + m1 + "/" + y1;
			// String date2 = d5 + "/" + m2 + "/" + y2;

			System.out.println("Customer name :" + cust_id);
			System.out.println("Complaint Severity :" + p_id);
			System.out.println("Status id :" + status_id);
			System.out.println("company id :" + company_id);
			System.out.println("complaint_no :"+complaint_no);
			System.out.println("from date :" + date1);
			System.out.println("to date :" + date2);

			Edit_By_Search_Others_VO bean = new Edit_By_Search_Others_VO(
					request);

			bean.setComplaint_no(complaint_no);
			bean.setCompany_id(company_id);
			bean.setCust_id(cust_id);
			bean.setStatus_id(status_id);
			bean.setP_id(p_id);
			bean.setDate1(date1);
			bean.setDate2(date2);

			Edit_By_Search_Others_BO bo = new Edit_By_Search_Others_BO();

			ServletContext sc = getServletContext();

			bo.searchComplaint(bean, request, sc, response);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("Search controller failed !!!!");
		}
		finally
		{
			out.close();
		}

	}

}
