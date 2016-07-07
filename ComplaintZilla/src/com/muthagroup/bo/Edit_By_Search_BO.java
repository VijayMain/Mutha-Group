package com.muthagroup.bo;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.dao.Edit_By_Search_DAO;
import com.muthagroup.vo.Edit_By_Search_VO;

public class Edit_By_Search_BO {

	public void searchComplaint(Edit_By_Search_VO bean,
			HttpServletRequest request, ServletContext sc, HttpServletResponse response)
	{
		Edit_By_Search_DAO dao = new Edit_By_Search_DAO();
		dao.editBySearch(bean,request, sc,response);

	}
}
