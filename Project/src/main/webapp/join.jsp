<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}	
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
	int r = userDAO.join(new UserDTO(userID, userPassword));
	if(r == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 이미 존재합니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	else{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입을 축하합니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}

	
%>