package com.muthagroup.connectionModel;

import java.sql.Connection;
import java.sql.DriverManager;

//============================================================================-->
//========================= Connection Utility =================================-->
//============================================================================-->
public class Connection_Utility {

	static Connection con = null;

	public static Connection getConnection() {

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintzilla", "root","root");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Connection Failed");
		}

		return con; // returns Connection

	}

}
