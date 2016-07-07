package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.muthagroup.connectionModel.Connection_Utility;

public class Get_UName_dao {

	String uname=null;
	public String getUserName(int uid) 
	{
		try
		{
			Connection con=Connection_Utility.getConnection();
			
			PreparedStatement ps_getUname=con.prepareStatement("select u_name from User_Tbl where u_id="+uid);
			
			ResultSet rs_getUname=ps_getUname.executeQuery();
			
			while(rs_getUname.next())
			{
				uname=rs_getUname.getString("U_Name");
			}
			
		}catch(Exception e)
		{
			
		}
		return uname;
	}

}
