package com.muthagroup.vo;

import javax.servlet.http.HttpServletRequest;
//============================================================================-->
//========================= Virtual Object ===================================-->
//============================================================================-->
public class Login_vo {

	String Login_Name = null, Login_Password = null;

	public String getLogin_Name() {
		return Login_Name;
	}

	public void setLogin_Name(String login_Name) {
		Login_Name = login_Name;
	}

	public String getLogin_Password() {
		return Login_Password;
	}

	public void setLogin_Password(String login_Password) {
		Login_Password = login_Password;
	}

	public Login_vo(HttpServletRequest request) {
		this.Login_Name = request.getParameter("name");
		this.Login_Password = request.getParameter("password");
	}

}
