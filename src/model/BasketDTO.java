package model;

public class BasketDTO {
	private int goods_num;
	private String id;
	private int amount; //수량
	private int total; //총 가격 amount * price
	private String image_path;
	private String name;
	private int saved; //적립금
	private int price; //가격
	
	/**
	 * @return the price
	 */
	public int getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(int price) {
		this.price = price;
	}
	/**
	 * @return the saved
	 */
	public int getSaved() {
		return saved;
	}
	/**
	 * @param saved the saved to set
	 */
	public void setSaved(int saved) {
		this.saved = saved;
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
	 * @return the goods_num
	 */
	public int getGoods_num() {
		return goods_num;
	}
	/**
	 * @param goods_num the goods_num to set
	 */
	public void setGoods_num(int goods_num) {
		this.goods_num = goods_num;
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
	 * @return the amount
	 */
	public int getAmount() {
		return amount;
	}
	/**
	 * @param amount the amount to set
	 */
	public void setAmount(int amount) {
		this.amount = amount;
	}
	/**
	 * @return the total
	 */
	public int getTotal() {
		return total;
	}
	/**
	 * @param total the total to set
	 */
	public void setTotal(int total) {
		this.total = total;
	}
	
	
}
