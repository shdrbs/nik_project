package com.nik.project.model;

import java.util.Date;
import java.util.List;

public class ProductVO {

	/* 상품 아이디 */
	private int id;

	/* 상품 이름 */
	private String name;

	/* 출시일 */
	private String publeYear;

	/* 카테고리 코드 */
	private String cateCode;

	/* 카테고리 이름 */
	private String cateName;

	/* 상품 가격 */
	private int price;

	/* 상품 재고 */
	private int stock;

	/* 상품 할인률(백분율) */
	private double discount;

	/* 상품 소개 */
	private String intro;

	/* 등록 날짜 */
	private Date regDate;

	/* 수정 날짜 */
	private Date updateDate;
	
	/* 이미지 정보 */
	private List<AttachImageVO> imageList;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPubleYear() {
		return publeYear;
	}

	public void setPubleYear(String publeYear) {
		this.publeYear = publeYear;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}


	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	
	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "ProductVO [id=" + id + ", name=" + name + ", publeYear=" + publeYear + ", cateCode=" + cateCode
				+ ", cateName=" + cateName + ", price=" + price + ", stock=" + stock + ", discount=" + discount
				+ ", intro=" + intro + ", regDate=" + regDate + ", updateDate=" + updateDate + ", imageList="
				+ imageList + "]";
	}

}
