package user;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;
import java.sql.Connection;

public class UserDAO {
	
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM USER WHERE userID = ?";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userID);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인 성공
				}
				else {
					return 0;//비밀번호 틀림
				}
			}
			return -1;//아이디 없음
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
		return -2;//DB 오류
	}
	
	public int join(UserDTO user) {
		String sql = "INSERT INTO USER VALUES (?, ?)";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, user.getUserID());
			ps.setString(2, user.getUserPassword());
			
			return ps.executeUpdate();//1이라는 값을 반환하면 회원가입 성공
			
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
		return -1;//회원가입 실패
	}

}
