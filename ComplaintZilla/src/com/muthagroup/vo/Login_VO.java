package com.muthagroup.vo;

import javax.servlet.http.HttpServletRequest;

public class Login_VO {

	private String Login_Name, Login_Password;
	private int U_Id, U_Dept;
	String Complaint_No = null;

	public String getComplaint_No() {
		return Complaint_No;
	}

	public void setComplaint_No(String complaint_No) {
		Complaint_No = complaint_No;
	}

	public int getU_Id() {
		return U_Id;
	}

	public void setU_Id(int u_Id) {
		U_Id = u_Id;
	}

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

	public int getU_Dept() {
		return U_Dept;
	}

	public void setU_Dept(int u_Dept) {
		U_Dept = u_Dept;
	}

	public Login_VO(HttpServletRequest request) {
		// this.U_Id=request.getParameter("U_Id");
		this.Login_Name = request.getParameter("Login_Name");
		this.Login_Password = request.getParameter("Login_Password");
		this.U_Dept = Integer.parseInt(request.getParameter("U_Dept"));
	}

}
