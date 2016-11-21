package com.muthagroup.dao;

import com.muthagroup.connection.ConnectionModel;
import com.muthagroup.vo.MuthaGroupVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale; 

public class MuthaGroupDAO {
    public ArrayList<ArrayList<String>> getReport(MuthaGroupVO vo) {
        ArrayList<ArrayList<String>> allList = new ArrayList<ArrayList<String>>();
        try {
            Connection con = ConnectionModel.getConnection();
            String sql = new String();
            PreparedStatement ps = null;
            ResultSet rs = null;
            int event_id = 0;
            //String event_creator="";
           
            sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \"),text,DATE_FORMAT(start_time,'%l:%i %p'), DATE_FORMAT(end_time,'%l:%i %p'),event_venue,event_desc FROM events_units";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ArrayList<String> list = new ArrayList<String>();
                event_id=rs.getInt("event_id");
                int i = 1;
                while (i <= 7) {
                    list.add(rs.getString(i));
                    ++i;
                }
              /*  sql = "SELECT event_creator FROM event_creator where event_id="+event_id+"";
                PreparedStatement ps1 = con.prepareStatement(sql);
                ResultSet rs1 = ps1.executeQuery();
                if(rs1.next())
                {
                	event_creator=rs1.getString("event_creator");
                	
                }
                list.add(event_creator);*/
                allList.add(list);
            }
            return allList;
        }
        catch (Exception e) {
            e.printStackTrace();
            return allList;
        }
    }

    public void saveEvent(ArrayList<String> list, int uid) {
        try {
        	Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            String date = list.get(0);
            String start = list.get(2);
            String end = list.get(3); 
//            String strDate =  date.substring(6,10) + "-" + date.substring(3, 5) + "-" + date.substring(0, 2);
            String strDate = date;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateMy = sdf.parse(strDate); 
            java.sql.Date sqlDate = new java.sql.Date(dateMy.getTime()); 
            SimpleDateFormat time = new SimpleDateFormat("hh:mm a");
            Date utilTime1=time.parse(start);
            Date utilTime2=time.parse(end);
            Time sqltime1=new Time(utilTime1.getTime());
            Time sqltime2=new Time(utilTime2.getTime());
            Connection con = ConnectionModel.getConnection();
            String sql = new String();
            ResultSet rs = null;
            PreparedStatement ps = null;
            int event_id =0;
            sql = "insert into events_units(event_date,text,start_time,end_time,event_venue,event_desc,enable_id,created_by,created_date) values(?,?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setDate(1, sqlDate);//date
            ps.setString(2, list.get(1));//text
            ps.setTime(3, sqltime1);//strat
            ps.setTime(4, sqltime2);//end
            ps.setString(5, list.get(4));//venue
            ps.setString(6, list.get(5));//details
            ps.setInt(7, 1);
            ps.setInt(8, uid);
            ps.setTimestamp(9, timestamp);
            ps.executeUpdate();
            
            sql = "select max(event_id) as code FROM events_units";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
        	   event_id=rs.getInt("code");
           }
            
            
            String users=list.get(5);//users list
            String[] userlist ;
            userlist = users.split(",");
            String creator= list.get(6);//creator
            
            String user_id = "",user_name="";
            String[] user_saparate = creator.split(",");             
 			for (int p = 0; p < user_saparate.length; p++) {
 				user_id = user_saparate[p].toString(); 
 				if(user_id!=""){
 				ps = con.prepareStatement("select * from user_tbl where U_Id="+Integer.parseInt(user_id));
 				rs = ps.executeQuery();
 				while (rs.next()) {
 					user_name = rs.getString("U_Name");
				} 				
 				sql = "insert into event_users(event_id,u_id,user_name) values(?,?,?)";
 	            ps = con.prepareStatement(sql);
 	            ps.setInt(1, event_id);
 	            ps.setInt(2, Integer.parseInt(user_id));
 	            ps.setString(3, user_name);
 	            ps.executeUpdate(); 				
 				user_id="";
 				user_name="";
 				}
 			}
            
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

	public ArrayList<ArrayList<String>> getTodayReport(MuthaGroupVO vo) {
		 ArrayList<ArrayList<String>> allList = new ArrayList<ArrayList<String>>();
	        try {
	            Connection con = ConnectionModel.getConnection();
	            String sql = new String();
	            PreparedStatement ps = null;
	            ResultSet rs = null;
	            int event_id = 0;
	          //  String event_creator="";
	            Date utiltoday = new Date();
	            String today= new SimpleDateFormat("yyyy-MM-dd").format(utiltoday);
	            
	            sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \"),text,DATE_FORMAT(start_time,'%l:%i %p'), DATE_FORMAT(end_time,'%l:%i %p'),event_venue,event_desc FROM events_units where event_date="+today+"";
	            ps = con.prepareStatement(sql);
	            rs = ps.executeQuery();
	            while (rs.next()) {
	                ArrayList<String> list = new ArrayList<String>();
	                event_id=rs.getInt("event_id");
	                int i = 1;
	                while (i <= 7) {
	                    list.add(rs.getString(i));
	                    ++i;
	                }
	               /* sql = "SELECT event_creator FROM event_creator where event_id="+event_id+"";
	                PreparedStatement ps1 = con.prepareStatement(sql);
	                ResultSet rs1 = ps1.executeQuery();
	                if(rs1.next())
	                {
	                	event_creator=rs1.getString("event_creator");
	                	
	                }
	                list.add(event_creator);*/
	                allList.add(list);
	            }
	            return allList;
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            return allList;
	        }
	}
}
