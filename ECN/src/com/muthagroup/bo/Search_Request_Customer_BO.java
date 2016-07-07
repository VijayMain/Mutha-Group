package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Search_Request_Customer_DAO;
import com.muthagroup.dao.Search_Request_DAO;
import com.muthagroup.vo.Search_Request_Customer_Vo;
//============================================================================-->
//========================= business Object ==================================-->
//============================================================================-->
public class Search_Request_Customer_BO {

	boolean flag = false;
	
	public boolean searchResult(Search_Request_Customer_Vo bean,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		try {

			Search_Request_Customer_DAO dao = new Search_Request_Customer_DAO();
			flag = dao.searchRequestDAO(bean, session, request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

}
