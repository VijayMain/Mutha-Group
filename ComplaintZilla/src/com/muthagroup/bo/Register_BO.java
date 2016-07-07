package com.muthagroup.bo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Register_Complaint_DAO;
import com.muthagroup.vo.Register_VO;
import com.muthagroup.vo.UserVO;

public class Register_BO {

	public String regComplaint(Register_VO beans, HttpSession session) {
		boolean flag = false;
		String comp_no = null;
		Register_Complaint_DAO dao = new Register_Complaint_DAO();
		String str = dao.getCust_Name(beans.getCust_id());

		// **************************************************************
		// get customer name (first three chars)
		String name = str.substring(0, 3);
		System.out.println(name);

		// get date format in dd-mm-yyyy for complaint registered date
		Date date = Calendar.getInstance().getTime();
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String today = formatter.format(date);
		String date11 = today.substring(0, 2) + today.subSequence(3, 5)
				+ today.substring(6, 10);
		System.out.println("Format = " + date11);
		// **************************************************************

		// **************************************************************
		// Counts for Complaint registration

		UserVO userVO = new UserVO();

		Register_Complaint_DAO dao2 = new Register_Complaint_DAO();
		String Count = dao2.Get_Count();
		System.out.println("Complaint count is = " + Count);
		// ***************************************************************

		// ****************************************************************
		// Create Complaint number
		comp_no = name + date11 + Count;
		System.out.println("Complaint Number BO = " + comp_no);
		userVO.setComplaint_Number(comp_no);
		System.out.println(userVO.getComplaint_Number());
		// *****************************************************************

		// Register Complaint
		flag = dao.saveToDatabase(beans, userVO, session);
		if (flag == true) {
			return comp_no;
		}
		return comp_no;
	}
}
