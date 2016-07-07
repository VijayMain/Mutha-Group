package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_Action_vo;

public class Edit_Action_Dao {

	String a_type=null,a_disc=null,c_no=null;
	int a_no=0;
	int i=0,j=0,U_Id=0;
	boolean flag=false;
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// get current date time with Date()
	Date date = new Date();
	// System.out.println("by date..:" + dateFormat.format(date));

	java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());
	public boolean update_Actio_Dao(Edit_Action_vo edit_a_vo, HttpSession session)
	{
		
		a_type=edit_a_vo.getA_type();
		a_disc=edit_a_vo.getA_disc();
		c_no=edit_a_vo.getC_no();
		a_no=edit_a_vo.getA_no();
		
		try 
		{
		Connection con = Connection_Utility.getConnection();
		
		Timestamp Action_Date = null;
		PreparedStatement ps_a_id= con.prepareStatement("select Action_Date,U_Id from Complaint_Tbl_Action where Action_Id="+a_no);
		ResultSet rs_a_id = ps_a_id.executeQuery();
		
		while (rs_a_id.next())
		{
			Action_Date = rs_a_id.getTimestamp("Action_Date");
			U_Id=rs_a_id.getInt("U_Id");
		}
		rs_a_id.close();
		ps_a_id.close();
		
		PreparedStatement ps_edit=con.prepareStatement("update Complaint_tbl_action set Action_Discription=?, Action_Type=?,Action_Date=? where Action_Id="+a_no);
		
		ps_edit.setString(1, a_disc);
		ps_edit.setString(2, a_type);
		ps_edit.setTimestamp(3, timestamp);
		
		i=ps_edit.executeUpdate();
		
		if(i>0)
		{
			PreparedStatement ps_addHist=con.prepareStatement("insert into Complaint_Tbl_Action_Hist(Action_Id,Complaint_No,U_Id,Action_Discription,Action_Date,Action_Type,Action_Date_Hist) values(?,?,?,?,?,?,?)");
			
			ps_addHist.setInt(1,a_no);
			ps_addHist.setString(2,c_no);
			ps_addHist.setInt(3,U_Id);
			ps_addHist.setString(4, a_disc);
			ps_addHist.setTimestamp(5,Action_Date);
			ps_addHist.setString(6, a_type);
			ps_addHist.setTimestamp(7,timestamp);
			
			j=ps_addHist.executeUpdate();
			
		}
		
		if(j>0)
		{
			flag=true;
		}
		
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return flag;
	
		
	}

}
