package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	
	public static void initConnect() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws Exception {
		//String url = "jdbc:oracle:thin:@192.168.10.25:1521:xe";
		//String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		//String url = "jdbc:oracle:thin:@192.168.110.64:1521:xe";
		String user = "scott"; //계정
		String pw = "tiger"; //계정비번

		Connection conn = DriverManager.getConnection(url, user, pw);
		
		return conn;
	}
}
