package com.muthagroup.bo;

import com.muthagroup.dao.Get_UName_dao;

public class Get_UName_bo 
{
	String uname=null;
	public String get_UName(int uid)
	{
		Get_UName_dao dao=new Get_UName_dao();
		uname=dao.getUserName(uid);
		
		return uname;
	}
}
