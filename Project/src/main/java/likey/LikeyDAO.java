package likey;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;
import java.sql.Connection;

public class LikeyDAO {
	
	public int like(String userID, String pID, String userIP) {
		String sql = "INSERT INTO likey VALUES (?, ?, ?)";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, userID);
			ps.setString(2, pID);
			ps.setString(3, userIP);
			
			return ps.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			try {
				if(ps != null) {
					ps.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			try {
				if(rs != null) {
					rs.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;//추천 중복 오류
	}
}
