package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	
	public static Connection getConnection() {
		try {
			String URL =  "jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false";
			String id = "root";
			String pwd = "1234";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(URL, id, pwd);
			return con;
			
		} catch (Exception e) {
			System.out.println("db 오류 발생" + e);
		}
		
		return null;
	}
}
