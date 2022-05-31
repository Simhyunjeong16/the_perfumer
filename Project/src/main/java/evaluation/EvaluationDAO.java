package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	
	public int write(EvaluationDTO evaluationDTO) {
		String sql = "INSERT INTO perfume VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(2, evaluationDTO.getPerfumeName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(3, evaluationDTO.getBrandName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(4, evaluationDTO.getSeason().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(5, evaluationDTO.getUsePeriod().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(6, evaluationDTO.getEvaluationFactor().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(10, evaluationDTO.getScore1().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(11, evaluationDTO.getScore2().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			ps.setString(12, evaluationDTO.getScore3().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			
			return ps.executeUpdate();//성공하면 1 반환
			
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
		return -1;//DB 오류
	}
	
	
	public ArrayList<EvaluationDTO> getList(String evaluationFactor, String searchType, String search, int pageNumber){
		if(evaluationFactor.equals("전체")) {
			evaluationFactor = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		String sql = "";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			if(searchType.equals("최신순")) {
				sql = "SELECT * "
						+ "FROM perfume "
						+ "WHERE evaluationFactor LIKE ? "
						+ "AND CONCAT(perfumeName, brandName, evaluationTitle, evaluationContent) LIKE ? "
						+ "ORDER BY pID DESC LIMIT " + pageNumber * 5 + ", "  + pageNumber * 5 + 6;
			}
			else if(searchType.equals("공감순")) {
				sql = "SELECT * "
						+ "FROM perfume "
						+ "WHERE evaluationFactor LIKE ? "
						+ "AND CONCAT(perfumeName, brandName, evaluationTitle, evaluationContent) LIKE ? "
						+ "ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", "  + pageNumber * 5 + 6;
			}
			
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);

			if(evaluationFactor.equals("")) {
				ps.setString(1, "%" + evaluationFactor + "%");
			}
			else {//오드퍼퓸, 퍼퓸을 분별하기 위해서 사용
				ps.setString(1, evaluationFactor);
			}
			
			ps.setString(2, "%" + search + "%");
			rs = ps.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)
				);
				evaluationList.add(evaluation);
			}
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
		return evaluationList;
	}
	
	public int like(String pID) {
		String sql = "UPDATE perfume SET likeCount = likeCount + 1 WHERE pID = ?";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(pID));
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
		return -1;// db 오류
	}
	
	public int delete(String pID) {
		String sql = "DELETE FROM perfume WHERE pID = ?";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(pID));
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
		return -1;// db 오류
	}
	
	public String getUserID(String pID) {
		String sql = "SELECT userID FROM perfume WHERE pID = ?";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(pID));
			rs = ps.executeQuery();
			
			if(rs.next()) {
				 return rs.getString(1);
			}
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
		return null;// 존재하지 않는 강의평가글
	}
}
