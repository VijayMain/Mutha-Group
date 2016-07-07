package com.muthagroup.bo;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.dao.Edit_By_Search_Others_DAO;
import com.muthagroup.vo.Edit_By_Search_Others_VO;

public class Edit_By_Search_Others_BO {

	public void searchComplaint(Edit_By_Search_Others_VO bean,
			HttpServletRequest request, ServletContext sc, HttpServletResponse response)
	{
		Edit_By_Search_Others_DAO dao = new Edit_By_Search_Others_DAO();
		dao.editBySearch(bean,request, sc,response);

	}
}
