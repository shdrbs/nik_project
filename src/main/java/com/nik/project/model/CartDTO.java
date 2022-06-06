package com.nik.project.model;

import java.util.List;

public class CartDTO {

	private int cartId;

	private String memberId;

	private int id;

	private int count;

	//product
	private String name;

	private int price;

	private double discount;

	// 추가
	private int salePrice;

	private int totalPrice;

	private int point;

    private int totalPoint;

    /* 상품 이미지 */
	private List<AttachImageVO> imageList;

	// 카트에 담긴 상품들의 총 가격, 총 할인가 계산
	public void initSaleTotal() {
		this.salePrice = (int) (this.price * (1-this.discount));
		this.totalPrice = this.salePrice*this.count;
		this.point = (int)(Math.floor(this.salePrice*0.05));
		this.totalPoint =this.point * this.count;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getSalePrice() {
		return salePrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public int getPoint() {
		return point;
	}

	public int getTotalPoint() {
		return totalPoint;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "CartDTO [cartId=" + cartId + ", memberId=" + memberId + ", id=" + id + ", count=" + count + ", name="
				+ name + ", price=" + price + ", discount=" + discount + ", salePrice=" + salePrice + ", totalPrice="
				+ totalPrice + ", point=" + point + ", totalPoint=" + totalPoint + ", imageList=" + imageList + "]";
	}

}
