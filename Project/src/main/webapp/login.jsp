<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String userID = null;
	String userPassword = null;
	
	if(request.getParameter("userID") != null){
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null){
		userPassword = request.getParameter("userPassword");
	}

	if(userID == null || userID == ""){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디를 입력하지 않았습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	else if(userPassword == null || userPassword == ""){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호를 입력하지 않았습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}


	UserDAO userDAO = new UserDAO();
	int r = userDAO.login(userID, userPassword);
	if(r == 1) {//로그인을 성공한 경우
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	else if(r == 0){//비밀번호가 틀린 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀렸습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	else if(r == -1){//아아디가 없는 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	else if(r == -2){//데이터베이스 오류가 발생한 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>