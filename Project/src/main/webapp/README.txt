
[물리 모델링]

CREATE DATABASE project;

<회원 테이블>
-> user 패키지 생성(UserDAO, UserDTO)

USER 테이블명
userID 문자
userPassword 문자

CREATE TABLE USER(
	userID varchar(20) PRIMARY KEY,
	userPassword varchar(64) NOT NULL
);


<향수 테이블>
-> evaluation 패키지 생성(EvaluationDAO, EvaluationDTO)

PERFUME 테이블명
pID 숫자
userID 문자
perfumeName 문자
brandName 문자
season 문자
usePeriod 문자
evaluationFactor 문자
evaluationTitle 문자
evaluationContent 문자
totalScore 문자
score1 문자
score2 문자
score3 문자
likeCount 숫자

CREATE TABLE PERFUME(
	pID int PRIMARY KEY AUTO_INCREMENT,
	userID varchar(20) NOT NULL,
	perfumeName varchar(50) NOT NULL,
	brandName varchar(50) NOT NULL,
	season varchar(5),
	usePeriod varchar(5),
	evaluationFactor varchar(10),
	evaluationTitle varchar(50),
	evaluationContent varchar(2048),
	totalScore varchar(10) NOT NULL,
	score1 varchar(10) NOT NULL,
	score2 varchar(10) NOT NULL,
	score3 varchar(10) NOT NULL,
	likeCount int  NOT NULL default 0
);

<공감 정보 저장 테이블>
-> likey 패키지 생성(LikeyDAO, LikeyDTO)

LIKEY 테이블명
userID 문자
pID 숫자
userIP 문자

CREATE TABLE LIKEY(
	userID varchar(20),
    pID int,
	userIP varchar(50),
    PRIMARY KEY (userID, pID)
);


[URL 설계]
1. 메인 화면 : index.jsp
2. 로그인 폼 : loginform.jsp
3. 로그인 : login.jsp (select)
4. 회원가입 폼 : joinform.jsp
5. 회원가입 : join.jsp (insert)
6. 로그아웃 폼 : logoutform.jsp
7. 글 삭제 : delete.jsp (delete)
8. 등록하기 : register.jsp (insert)
9. 공감버튼 : like.jsp (insert)


[기능]
1. 회원가입
2. 로그인
3. 로그아웃
4. 향 평가 등록하기
5. 향 평가 목록보기 (필터링 기능 : 향수 분류 기준, 최신순/공감순, 검색내용)
6. 향 평가 삭제하기 (자신이 쓴 평가 글만 삭제 가능)
7. 향 평가 공감하기 (한번만 공감이 가능하며, 자기자신도 공감이 가능)
8. 검색 기능 (전체검색(페이지 오른쪽 위에 위치), 상세검색(필터링))

