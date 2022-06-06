package com.nik.project.model;

public class OrderItemDTO {

	/* 주문 번호 */
	private String orderId;

	/* 상품 이름 */
	private String name;

	/* 상품 번호 */
    private int id;

	/* 주문 수량 */
    private int count;

	/* orderItem 기본키 */
    private int orderItemId;

	/* 상품 한 개 가격 */
    private int price;

	/* 상품 할인 율 */
    private double discount;

	/* 상품 한개 구매 시 획득 포인트 */
    private int savePoint;

	/* DB테이블 존재 하지 않는 데이터 */

	/* 할인 적용된 가격 */
    private int salePrice;

	/* 총 가격(할인 적용된 가격 * 주문 수량) */
    private int totalPrice;

	/* 총 획득 포인트(상품 한개 구매 시 획득 포인트 * 수량) */
    private int totalSavePoint;

    public void initSaleTotal() {
		this.salePrice = (int) (this.price * (1-this.discount)); 	// 할인된 가격 계산
		this.totalPrice = this.salePrice*this.count;      			// 상품 총 합산 가격 계산
		this.savePoint = (int)(Math.floor(this.salePrice*0.05));	// 포인트 계산
		this.totalSavePoint =this.savePoint * this.count;			// 총 포인트 계간
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public int getSavePoint() {
		return savePoint;
	}

	public void setSavePoint(int savePoint) {
		this.savePoint = savePoint;
	}

	public int getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getTotalSavePoint() {
		return totalSavePoint;
	}

	public void setTotalSavePoint(int totalSavePoint) {
		this.totalSavePoint = totalSavePoint;
	}

	@Override
	public String toString() {
		return "OrderItemDTO [orderId=" + orderId + ", name=" + name + ", id=" + id + ", count=" + count
				+ ", orderItemId=" + orderItemId + ", price=" + price + ", discount=" + discount + ", savePoint="
				+ savePoint + ", salePrice=" + salePrice + ", totalPrice=" + totalPrice + ", totalSavePoint="
				+ totalSavePoint + "]";
	}

}
