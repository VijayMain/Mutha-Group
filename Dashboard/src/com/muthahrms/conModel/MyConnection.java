package com.muthahrms.conModel;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class MyConnection {
	static Connection con = null;

	public static Connection getHRMSConnection() { 
			try{
				InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream("Variables.properties");
				Properties properties = new Properties(); 
				properties.load(in); 
				Class.forName(properties.getProperty("dbdriver"));
				con = DriverManager.getConnection(properties.getProperty("dburl"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
