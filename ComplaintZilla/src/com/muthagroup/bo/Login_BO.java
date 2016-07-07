package com.muthagroup.bo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Login_DAO;
import com.muthagroup.vo.Login_VO;

public class Login_BO {

	public void verify_Login(Login_VO bean, HttpSession session,
			HttpServletResponse response) {

		Login_DAO dao = new Login_DAO();
		dao.authenticate_Login(bean, session, response);

	}

}
