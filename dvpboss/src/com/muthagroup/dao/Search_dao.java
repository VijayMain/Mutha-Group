package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Search_vo;

public class Search_dao {

	
	public ArrayList<Integer> Search_Sheet(Search_vo vo, HttpServletRequest request) 
	{
		ArrayList<Integer> Basic_Ids=new ArrayList<Integer>();
		try
		{
			int uid=0;			
			HttpSession  session=request.getSession();

			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_getIds=null;
			ResultSet rs_getIds=null;
			
			//*********************************************
			// only basic id available
			//*********************************************
			if(vo.getBasic_id()!=0 && vo.getCust_id()==0 && vo.getDate_From()==null && vo.getDate_To()==null && vo.getPartName_id()==0 && vo.getPartNo_id()==0)
			{
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where basic_id="+vo.getBasic_id());
				rs_getIds=ps_getIds.executeQuery();
			}
			//*********************************************
			// only Cust id and two dates available
			//*********************************************
			else if(vo.getCust_id()!=0 && vo.getDate_From()!=null && vo.getDate_To()!=null && vo.getPartNo_id()==0 && vo.getPartName_id()==0 && vo.getBasic_id()==0)
			{
				System.out.println("In cust Loop");
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where cust_id="+vo.getCust_id()+" and Created_Date between '"+vo.getDate_From()+"' and '"+vo.getDate_To()+"'");
				rs_getIds=ps_getIds.executeQuery();
				
			}
			//*********************************************
			// Cust id,partName_id and two dates available
			//*********************************************
			else if(vo.getCust_id()!=0 && vo.getPartName_id()!=0 && vo.getDate_From()!=null && vo.getDate_To()!=null && vo.getPartNo_id()==0 && vo.getBasic_id()==0)
			{
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where Cust_Id="+vo.getCust_id()+" and PartName_Id="+vo.getPartName_id()+" and Created_Date between '"+vo.getDate_From()+"' and '"+vo.getDate_To()+"'");
				rs_getIds=ps_getIds.executeQuery();
			}
			//*********************************************
			// Cust id,partNo_id and two dates available
			//*********************************************
			else if(vo.getCust_id()!=0 && vo.getPartNo_id()!=0 && vo.getDate_From()!=null && vo.getDate_To()!=null && vo.getPartName_id()==0 && vo.getBasic_id()==0)
			{
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where Cust_Id="+vo.getCust_id()+" and PartNo_Id="+vo.getPartNo_id()+" and Created_Date between '"+vo.getDate_From()+"' and '"+vo.getDate_To()+"'");
				rs_getIds=ps_getIds.executeQuery();
			}
			//*********************************************
			// Cust id,partNo_id,partName_id and two dates available
			//*********************************************
			else if(vo.getCust_id()!=0 && vo.getPartName_id()!=0 && vo.getPartNo_id()!=0 && vo.getDate_From()!=null && vo.getDate_To()!=null && vo.getBasic_id()==0)
			{
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where Cust_Id="+vo.getCust_id()+" and PartName_Id="+vo.getPartName_id()+" and PartNo_Id="+vo.getPartNo_id()+" and Created_Date between '"+vo.getDate_From()+"' and '"+vo.getDate_To()+"'");
				rs_getIds=ps_getIds.executeQuery();
			}
			//*********************************************
			//only partNo_id and two dates available
			//*********************************************
			else if(vo.getCust_id()==0 && vo.getPartName_id()==0 && vo.getPartNo_id()!=0 && vo.getDate_From()!=null && vo.getDate_To()!=null && vo.getBasic_id()==0)
			{
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where PartNo_Id="+vo.getPartNo_id()+" and Created_Date between '"+vo.getDate_From()+"' and '"+vo.getDate_To()+"'");
				rs_getIds=ps_getIds.executeQuery();
			}
			//*********************************************
			// only partName_id and two dates available
			//*********************************************
			else if(vo.getCust_id()==0 && vo.getPartName_id()!=0 && vo.getPartNo_id()==0 && vo.getDate_From()!=null && vo.getDate_To()!=null && vo.getBasic_id()==0)
			{
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where PartName_Id="+vo.getPartName_id()+" and Created_Date between '"+vo.getDate_From()+"' and '"+vo.getDate_To()+"'");
				rs_getIds=ps_getIds.executeQuery();
			}
			//*********************************************
			// partNo_id,partName_id and two dates available
			//*********************************************
			else if(vo.getCust_id()==0 && vo.getPartName_id()!=0 && vo.getPartNo_id()!=0 && vo.getDate_From()!=null && vo.getDate_To()!=null && vo.getBasic_id()==0)
			{
				ps_getIds=con.prepareStatement("select basic_id from dev_basicinfo_tbl where PartName_Id="+vo.getPartName_id()+" and PartNo_Id="+vo.getPartNo_id()+" and Created_Date between '"+vo.getDate_From()+"' and '"+vo.getDate_To()+"'");
				rs_getIds=ps_getIds.executeQuery();
			}
			while(rs_getIds.next())
			{
				Basic_Ids.add(rs_getIds.getInt("Basic_id"));
				System.out.println("Basic ids"+Basic_Ids);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return Basic_Ids;
		
	}

}
