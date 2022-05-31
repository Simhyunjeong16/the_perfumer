<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%!
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>

<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}	
	
	request.setCharacterEncoding("UTF-8");
	String pID = null;

	if(request.getParameter("pID") != null){
		pID = request.getParameter("pID");
	}
	
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	int r = likeyDAO.like(userID, pID, getClientIP(request));
	
	if(r == 1) {
		r = evaluationDAO.like(pID);
		if(r == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('공감버튼을 눌렀습니다.');");
			script.println("location.href = 'index.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 공감을 눌렀습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>