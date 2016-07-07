package com.muthagroup.bo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Login_DAO;
import com.muthagroup.vo.Login_vo;
//============================================================================-->
//========================= business Object ==================================-->
//============================================================================-->
public class Login_BO {

	public boolean checkLogin(Login_vo vo, HttpSession session, HttpServletResponse response) {

		boolean flag = false;

		try {

			Login_DAO dao = new Login_DAO();
			flag = dao.validateLogin(vo,session,response);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

}
