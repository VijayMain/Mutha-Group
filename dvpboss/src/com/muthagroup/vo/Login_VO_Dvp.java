package com.muthagroup.vo;

public class Login_VO_Dvp {
	
	String uname=null;
	String pwd=null;
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	@Override
	public String toString() {
		return "Login_VO_Dvp [uname=" + uname + ", pwd=" + pwd + "]";
	}
	
	

}
