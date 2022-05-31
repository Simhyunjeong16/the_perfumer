<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='loginform.jsp';");
		script.println("</script>");
		script.close();
		return;
	}	
	
	String perfumeName = null;
	String brandName = null;
	String season = null;
	String usePeriod = null;
	String evaluationFactor = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String score1 = null;
	String score2 = null;
	String score3 = null;
	
	if(request.getParameter("perfumeName") != null){
		perfumeName = request.getParameter("perfumeName");
	}
	if(request.getParameter("brandName") != null){
		brandName = request.getParameter("brandName");
	}
	if(request.getParameter("season") != null){
		season = request.getParameter("season");
	}
	if(request.getParameter("usePeriod") != null){
		usePeriod = request.getParameter("usePeriod");
	}
	if(request.getParameter("evaluationFactor") != null){
		evaluationFactor = request.getParameter("evaluationFactor");
	}
	if(request.getParameter("evaluationTitle") != null){
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent") != null){
		evaluationContent = request.getParameter("evaluationContent");
	}
	if(request.getParameter("totalScore") != null){
		totalScore = request.getParameter("totalScore");
	}
	if(request.getParameter("score1") != null){
		score1 = request.getParameter("score1");
	}
	if(request.getParameter("score2") != null){
		score2 = request.getParameter("score2");
	}
	if(request.getParameter("score3") != null){
		score3 = request.getParameter("score3");
	}
	
	
	if(perfumeName == null || brandName == null || season == null || usePeriod == null ||
			evaluationFactor == null || evaluationTitle == null || evaluationContent == null ||
			totalScore == null || score1 == null || score2 == null|| score3 == null ||
			evaluationTitle.equals("") || evaluationContent.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}

	EvaluationDAO evaluationDAO = new EvaluationDAO();
	int r = evaluationDAO.write(new EvaluationDTO(0, userID, perfumeName, brandName, season, usePeriod, evaluationFactor, evaluationTitle, evaluationContent, totalScore, score1, score2, score3, 0));
	if(r == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	else{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
		return;
	}

	
%>