package com.nik.project.model;

import java.util.List;

public class OrderPageItemDTO {

	/* 뷰로부터 전달받을 값 */
    private int id;

    private int count;

	/* DB로부터 꺼내올 값 */
    private String name;

    private int price;

    private double discount;

	/* 만들어 낼 값 */
    private int salePrice;

    private int totalPrice;

    private int point;

    private int totalPoint;

    /* 상품 이미지 */
	private List<AttachImageVO> imageList;

    public void initSaleTotal() {
		this.salePrice = (int) (this.price * (1-this.discount));
		this.totalPrice = this.salePrice*this.count;
		this.point = (int)(Math.floor(this.salePrice*0.05));
		this.totalPoint =this.point * this.count;
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

	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getTotalPoint() {
		return totalPoint;
	}

	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "OrderPageItemDTO [id=" + id + ", count=" + count + ", name=" + name + ", price=" + price + ", discount="
				+ discount + ", salePrice=" + salePrice + ", totalPrice=" + totalPrice + ", point=" + point
				+ ", totalPoint=" + totalPoint + ", imageList=" + imageList + "]";
	}

}
