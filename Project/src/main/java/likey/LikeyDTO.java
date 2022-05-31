package likey;

public class LikeyDTO {
	String userID;
	int pID;
	String userIP;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getpID() {
		return pID;
	}
	public void setpID(int pID) {
		this.pID = pID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public LikeyDTO() {
	}
	
	public LikeyDTO(String userID, int pID, String userIP) {
		super();
		this.userID = userID;
		this.pID = pID;
		this.userIP = userIP;
	}
	
	
}
