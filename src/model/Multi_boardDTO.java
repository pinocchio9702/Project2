package model;

public class Multi_boardDTO {
	private int num;
	private String id;
	private String title;
	private String content;
	private java.sql.Date postdate;
	private String file;
	private String file_path;
	
	
	
	
	/**
	 * @return the file_path
	 */
	public String getFile_path() {
		return file_path;
	}
	/**
	 * @param file_path the file_path to set
	 */
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	private int visitcount;
	private String check_board;
	
	
	/*
	회원테이블과 join하여 이름을 가져오기 위해 DTO클래스에	
	name컬럼을 추가한다.
	*/
	
	private String name;
	private String email;
	
	
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the num
	 */
	public int getNum() {
		return num;
	}
	/**
	 * @param num the num to set
	 */
	public void setNum(int num) {
		this.num = num;
	}
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * @return the postdate
	 */
	public java.sql.Date getPostdate() {
		return postdate;
	}
	/**
	 * @param postdate the postdate to set
	 */
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	/**
	 * @return the file
	 */
	public String getFile() {
		return file;
	}
	/**
	 * @param file the file to set
	 */
	public void setFile(String file) {
		this.file = file;
	}
	/**
	 * @return the visitcount
	 */
	public int getVisitcount() {
		return visitcount;
	}
	/**
	 * @param visitcount the visitcount to set
	 */
	public void setVisitcount(int visitcount) {
		this.visitcount = visitcount;
	}
	/**
	 * @return the check_board
	 */
	public String getCheck_board() {
		return check_board;
	}
	/**
	 * @param check_board the check_board to set
	 */
	public void setCheck_board(String check_board) {
		this.check_board = check_board;
	}
	
	
	
}
