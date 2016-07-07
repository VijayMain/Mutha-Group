package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.muthagroup.connectionModel.Connection_Utility;

public class GetUserName_DAO {

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String name = null;
	int dept_id=0;

	public String getuserName(int uid) {
		try { 
			con = Connection_Utility.getConnection();
			System.out.println("Get Connection");
			
			ps = con.prepareStatement("select U_Name from user_tbl where U_Id="+uid);
			rs=ps.executeQuery();
			while(rs.next())
			{
				name=rs.getString("U_Name"); 
			}
			ps.close();
			rs.close();
		} catch (Exception e) 
		{
			e.printStackTrace();
		}  
	
		return name;
	}

	public int getuser_DeptId(int uid) {
		try { 
			con = Connection_Utility.getConnection();
			System.out.println("Get Connection");
			
			ps = con.prepareStatement("select Dept_Id from user_tbl where U_Id="+uid);
			rs=ps.executeQuery();
			while(rs.next())
			{
				dept_id = rs.getInt("Dept_Id"); 
			}
			ps.close();
			rs.close();
		} catch (Exception e) 
		{
			e.printStackTrace();
		}  
		return dept_id;
	}
	}
