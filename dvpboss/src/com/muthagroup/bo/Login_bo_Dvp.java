package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.dao.Login_dao_Dvp;
import com.muthagroup.vo.Login_VO_Dvp;

public class Login_bo_Dvp {

	boolean flag=false; 
	public void checkLogin(HttpServletRequest request,
			HttpServletResponse response, Login_VO_Dvp vo) 
	{
		Login_dao_Dvp dao=new Login_dao_Dvp();
		
		dao.checkLogin(request,response,vo);
		

	}

}
