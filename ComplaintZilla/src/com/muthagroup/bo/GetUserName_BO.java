package com.muthagroup.bo;

import com.muthagroup.dao.GetUserName_DAO;

public class GetUserName_BO {

	String name;
	int dept_id;

	public String getUserName(int uid) {
		GetUserName_DAO dao = new GetUserName_DAO();
		name = dao.getuserName(uid);
		return name;
	}
	
	public Integer getUserDeptID(int uid) {
		GetUserName_DAO dao = new GetUserName_DAO();
		dept_id = dao.getuser_DeptId(uid);
		return dept_id;
	}
}
