package com.muthagroup.bo;

import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import com.muthagroup.dao.Cab_ApproveDecline_Request_Customer_DAO;
import com.muthagroup.vo.Cab_ApproveDecline_Request_Customer_Vo;
//============================================================================-->
//========================= Business Object ==================================-->
//============================================================================-->
public class Cab_ApproveDecline_Request_Customer_BO {
	boolean flag = false;

	public boolean Cab_ApproveDecline(Cab_ApproveDecline_Request_Customer_Vo bean, HttpSession session,ArrayList appsellist) {
		Cab_ApproveDecline_Request_Customer_DAO dao = new Cab_ApproveDecline_Request_Customer_DAO();
		flag = dao.registerApproval(bean, session, appsellist);
		return flag;
	}
}
