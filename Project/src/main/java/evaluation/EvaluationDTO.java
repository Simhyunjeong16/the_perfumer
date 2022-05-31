package evaluation;

public class EvaluationDTO {
	
	int pID;
	String userID;
	String perfumeName;
	String brandName;
	String season;
	String usePeriod;
	String evaluationFactor;
	String evaluationTitle;
	String evaluationContent;
	String totalScore;
	String score1;
	String score2;
	String score3;
	int likeCount;
	
	public int getpID() {
		return pID;
	}
	public void setpID(int pID) {
		this.pID = pID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPerfumeName() {
		return perfumeName;
	}
	public void setPerfumeName(String perfumeName) {
		this.perfumeName = perfumeName;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public String getUsePeriod() {
		return usePeriod;
	}
	public void setUsePeriod(String usePeriod) {
		this.usePeriod = usePeriod;
	}
	public String getEvaluationFactor() {
		return evaluationFactor;
	}
	public void setEvaluationFactor(String evaluationFactor) {
		this.evaluationFactor = evaluationFactor;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getScore1() {
		return score1;
	}
	public void setScore1(String score1) {
		this.score1 = score1;
	}
	public String getScore2() {
		return score2;
	}
	public void setScore2(String score2) {
		this.score2 = score2;
	}
	public String getScore3() {
		return score3;
	}
	public void setScore3(String score3) {
		this.score3 = score3;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public EvaluationDTO() {
	}
	
	public EvaluationDTO(int pID, String userID, String perfumeName, String brandName, String season, String usePeriod,
			String evaluationFactor, String evaluationTitle, String evaluationContent, String totalScore, String score1,
			String score2, String score3, int likeCount) {
		super();
		this.pID = pID;
		this.userID = userID;
		this.perfumeName = perfumeName;
		this.brandName = brandName;
		this.season = season;
		this.usePeriod = usePeriod;
		this.evaluationFactor = evaluationFactor;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.totalScore = totalScore;
		this.score1 = score1;
		this.score2 = score2;
		this.score3 = score3;
		this.likeCount = likeCount;
	}
	
	
}
