package model;

public class Photo_boardDTO {
	private int num; 
	private String title; 
	private String content; 
	private java.sql.Date postdate;
	private int visitcount;
	private String image;
	private String image_path;
	private String id;
	
	/*
	회원테이블과 join하여 이름을 가져오기 위해 DTO클래스에	
	name컬럼을 추가한다.
	*/
	
	private String name;

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
	 * @return the image
	 */
	public String getImage() {
		return image;
	}

	/**
	 * @param image the image to set
	 */
	public void setImage(String image) {
		this.image = image;
	}

	/**
	 * @return the image_path
	 */
	public String getImage_path() {
		return image_path;
	}

	/**
	 * @param image_path the image_path to set
	 */
	public void setImage_path(String image_path) {
		this.image_path = image_path;
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
	
	
	
}
