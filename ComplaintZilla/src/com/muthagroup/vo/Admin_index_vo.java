package com.muthagroup.vo;

import javax.servlet.http.HttpServletRequest;

public class Admin_index_vo {

	private int company=0 , customer_id=0 ,dept=0,u_id=0;
	private String user_name = null, email = null,
			login_name = null, password = null, company_Name = null,
			customer_name = null, customer_email = null, iten_name = null,
			defect = null, catagory_name = null,
			cat_init = null, Action_Type = null,
			Deparment=null;
	int user_designation = 0;
	public Admin_index_vo(HttpServletRequest request)
	{
		this.company = Integer.parseInt(request.getParameter("company"));
		this.user_name = request.getParameter("user_name");
		this.user_designation = Integer.parseInt(request.getParameter("user_designation"));
		this.dept=Integer.parseInt(request.getParameter("dept"));		
		this.email = request.getParameter("email");
		this.login_name = request.getParameter("login_name");
		this.password = request.getParameter("password");
		
	}

	public String getDeparment() {
		return Deparment;
	}

	public void setDeparment(String deparment) {
		Deparment = deparment;
	}

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	public int getDept() {
		return dept;
	}

	public void setDept(int dept) {
		this.dept = dept;
	}

	public String getAction_Type() {
		return Action_Type;
	}

	public void setAction_Type(String action_Type) {
		Action_Type = action_Type;
	}

	public String getCatagory_name() {
		return catagory_name;
	}

	public void setCatagory_name(String catagory_name) {
		this.catagory_name = catagory_name;
	}

	public String getCat_init() {
		return cat_init;
	}

	public void setCat_init(String cat_init) {
		this.cat_init = cat_init;
	}

	public String getDefect() {
		return defect;
	}

	public void setDefect(String defect) {
		this.defect = defect;
	}

	

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public String getIten_name() {
		return iten_name;
	}

	public void setIten_name(String iten_name) {
		this.iten_name = iten_name;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public String getCustomer_email() {
		return customer_email;
	}

	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}

	public Admin_index_vo() {
	}

	public String getCompany_Name() {
		return company_Name;
	}

	public void setCompany_Name(String company_Name) {
		this.company_Name = company_Name;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	

	public int getUser_designation() {
		return user_designation;
	}

	public void setUser_designation(int user_designation) {
		this.user_designation = user_designation;
	}

	public int getCompany() {
		return company;
	}

	public void setCompany(int company) {
		this.company = company;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLogin_name() {
		return login_name;
	}

	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
