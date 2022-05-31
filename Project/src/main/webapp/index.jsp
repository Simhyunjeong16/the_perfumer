<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>The perfumer</title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String evaluationFactor = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("evaluationFactor") != null){
		evaluationFactor = request.getParameter("evaluationFactor");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e){
			System.out.println("검색 페이지 오류 - " + e);
		}
		
	}
	

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
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">향수평가</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원 관리</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<%
							if(userID == null) {
						%>
							<a class="dropdown-item" href="./loginform.jsp">로그인</a>
							<a class="dropdown-item" href="./joinform.jsp">회원가입</a>
						<%
							} else {
						%>
							<a class="dropdown-item" href="./logoutform.jsp">로그아웃</a>
						<%
							}
						%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method = "get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="검색어를 입력하세요" aria-label="Search"/>
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="evaluationFactor" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="오드코롱" <% if(evaluationFactor.equals("오드코롱")) out.println("selected"); %>>오드코롱</option>
				<option value="오드뚜왈렛"<% if(evaluationFactor.equals("오드뚜왈렛")) out.println("selected"); %>>오드뚜왈렛</option>
				<option value="오드퍼퓸"<% if(evaluationFactor.equals("오드퍼퓸")) out.println("selected"); %>>오드퍼퓸</option>
				<option value="퍼퓸" <% if(evaluationFactor.equals("퍼퓸")) out.println("selected"); %>>퍼퓸</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="공감순" <% if(searchType.equals("공감순")) out.println("selected"); %>>공감순</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
		</form>
		
		<%
			ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
			evaluationList = new EvaluationDAO().getList(evaluationFactor, searchType, search, pageNumber);
		
			if(evaluationList != null){
				for(int i = 0; i < evaluationList.size(); i++){
					if(i == 5) break;
					EvaluationDTO evaluation = evaluationList.get(i);	
		%>
	
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						<%= evaluation.getPerfumeName() %>&nbsp;
						<small><%= evaluation.getBrandName() %></small>
					</div>
					<div class="col-4 text-right">
						종합결과 <span style="color: red;"><%= evaluation.getTotalScore() %></span>
					</div>
				</div>
			</div>
		</div>
		<div class="card-body bg-light">
			<h5 class="card-title">
				<%= evaluation.getEvaluationTitle() %>&nbsp;
				<small>(<%= evaluation.getSeason() %>에 <%= evaluation.getUsePeriod() %> 사용)</small>
			</h5>
			<p class="card-text">
				<%= evaluation.getEvaluationContent() %>
			</p>
			<div class="row">
				<div class="col-9 text-left">
					향기 <span style="color: red;"> <%= evaluation.getScore1() %></span>
					지속력 <span style="color: red;"> <%= evaluation.getScore2() %></span>
					발향력 <span style="color: red;"> <%= evaluation.getScore3() %></span>
					<span style="color: green;"> (공감👍 <%= evaluation.getLikeCount() %>)</span>
				</div>
				<div class="col-3 text-right">
					<a onclick="return confirm('공감하십니까?')" href="./like.jsp?pID=<%= evaluation.getpID() %>">공감</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href="./delete.jsp?pID=<%= evaluation.getpID() %>">삭제</a>
				</div>
			</div>
		</div>
		
		<%
				}
			}
		%>
		
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
		<%
			if(pageNumber <= 0){
		%>
		<a class="page-link disabled">이전</a>
		<%
			} else {
		%>
				<a class="page-link" href="./index.jsp?evaluationFactor=<%= URLEncoder.encode(evaluationFactor, "UTF-8") %>
				&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>
				&serarch=<%= URLEncoder.encode(search, "UTF-8") %>
				&pageNumber=<%= pageNumber-1 %>">이전</a>
		<%
			}
		%>
		</li>

		<li>
		<%
			if(evaluationList.size() < 6){
		%>
		<a class="page-link disabled">다음</a>
		<%
			} else {
		%>
				<a class="page-link" href="./index.jsp?evaluationFactor=<%= URLEncoder.encode(evaluationFactor, "UTF-8") %>
				&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>
				&serarch=<%= URLEncoder.encode(search, "UTF-8") %>
				&pageNumber=<%= pageNumber+1 %>">다음</a>
		<%
			}
		%>
		</li>
		
		
	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">향 평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./register.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>향수 이름</label>
								<input type="text" name="perfumeName" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>브랜드</label>
								<input type="text" name="brandName" class="form-control" maxlength="20">
							</div>
						</div>
						
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>평가 요소</label>
								<select name="evaluationFactor" class="form-control">
									<option value="오드코롱">오드코롱</option>
									<option value="오드뚜왈렛">오드뚜왈렛</option>
									<option value="오드퍼퓸">오드퍼퓸</option>
									<option value="퍼퓸" selected>퍼퓸</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>사용한 계절</label>
								<select name="season" class="form-control">
									<option value="봄">봄</option>
									<option value="여름" selected>여름</option>
									<option value="가을">가을</option>
									<option value="겨울">겨울</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
							<label>사용한 기간</label>
								<select name="usePeriod" class="form-control">
									<option value="1개월" selected>1개월</option>
									<option value="2개월">2개월</option>
									<option value="3개월">3개월</option>
									<option value="4개월">4개월</option>
									<option value="5개월">5개월</option>
									<option value="6개월">6개월</option>
									<option value="1년">1년</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
							<label>종합</label>
								<select name="totalScore" class="form-control">
									<option value="Super">Super</option>
									<option value="Good" selected>Good</option>
									<option value="Soso">Soso</option>
									<option value="Bad">Bad</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
							<label>향기</label>
								<select name="score1" class="form-control">
									<option value="Super">Super</option>
									<option value="Good" selected>Good</option>
									<option value="Soso">Soso</option>
									<option value="Bad">Bad</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
							<label>지속력</label>
								<select name="score2" class="form-control">
									<option value="Super">Super</option>
									<option value="Good" selected>Good</option>
									<option value="Soso">Soso</option>
									<option value="Bad">Bad</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
							<label>발향력</label>
								<select name="score3" class="form-control">
									<option value="Super">Super</option>
									<option value="Good" selected>Good</option>
									<option value="Soso">Soso</option>
									<option value="Bad">Bad</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 심현정 JSP 과제 All Rights Reserved.
	</footer>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>