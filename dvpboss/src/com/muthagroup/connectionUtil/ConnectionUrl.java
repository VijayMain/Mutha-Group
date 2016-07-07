package com.muthagroup.connectionUtil;
 
import java.sql.*; 

public class ConnectionUrl {
	static Connection con = null;
	static Connection seqConn = null;

	public static Connection getLocalDatabase() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp_database", "root","root"); 
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}	
	public static Connection getK1FMShopConnection() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=K1FMSHOP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to K1FMShop");
		} catch (Exception e) {
			e.printStackTrace(); 
		} 
		return con; 
	}
	public static Connection getK1ERPConnection() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=K1ERP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to K1ERP");
		} catch (Exception e) {
			e.printStackTrace(); 
		} 
		return con; 
	}
	public static Connection getDIFMShopConnection() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=DIFMSHOP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to DIFMShop");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	public static Connection getDIERPConnection() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=DIERP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to DIERP");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	public static Connection getFoundryFMShopConnection() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=FOUNDRYFMSHOP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to FoundryFMShop");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	public static Connection getFoundryERPNEWConnection() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=FOUNDRYERPNEW;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to FOUNDRYERPNEW");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	public static Connection getMEPLH25ERP() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=H25ERP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to MEPLH25");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	public static Connection getMEPLH21ERP() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=ENGERP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to MEPLH21");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	
	
	public static Connection getMEPLH21FMShop() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=ENGFMSHOP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to ENGFMSHOP");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	public static Connection getMEPLH25FMShop() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=H25FMSHOP;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to H25FMSHOP");
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; 
	}
	
	public static Connection getENGH25CONSConnection() {
		try {   
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://192.168.0.6:1433;databaseName=ENGH25CONS;user=BWAYS;password=BWAYSKING321");
            System.out.println("Connection Occurred to K1ERP");
		} catch (Exception e) {
			e.printStackTrace(); 
		} 
		return con; 
	}
	
}
