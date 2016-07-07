package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.muthagroup.connectionModel.Connection_Utility;

public class Get_UName_dao {

	public String get_UName(Integer uid){
		String name="";
		try {
			Connection con=Connection_Utility.getConnection();
			PreparedStatement ps=con.prepareStatement("select * from user_tbl where U_Id="+uid);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				name = rs.getString("U_Name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return name;	
	}
	
}
