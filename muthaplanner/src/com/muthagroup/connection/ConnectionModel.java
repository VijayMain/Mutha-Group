
package com.muthagroup.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionModel {
    static Connection con = null;

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintzilla", "root", "root");
        }
        catch (Exception e) {
            e.printStackTrace();
            System.out.println("Connection Failed");
        }
        return con;
    }
}
