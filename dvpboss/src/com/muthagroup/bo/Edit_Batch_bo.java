package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_Batch_dao;
import com.muthagroup.vo.Edit_Batch_vo;

public class Edit_Batch_bo {

	boolean flag=false;
	public boolean updateBatch(Edit_Batch_vo vo, HttpServletRequest request) {
		
		Edit_Batch_dao dao=new Edit_Batch_dao();
		
		System.out.println("data" +vo.getFeddback_RNo()+"\n"+vo.getFeedback_Details()+"\n"+vo.getTrial_id() );

		System.out.println("File input name = " +vo.getAttch_file_name());
		flag=dao.updateBatch(vo,request);
		
		return flag;
	}

}

