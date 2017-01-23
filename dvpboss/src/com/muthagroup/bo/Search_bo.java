package com.muthagroup.bo;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Search_dao;
import com.muthagroup.vo.Search_vo;

public class Search_bo 
{
	ArrayList<Integer> Basic_ids=new ArrayList<Integer>();
	public ArrayList<Integer> Search_Sheet(Search_vo vo, HttpServletRequest request) 
	{
		Search_dao dao=new Search_dao();
		Basic_ids.addAll(dao.Search_Sheet(vo,request));
		return Basic_ids;
	}
}
