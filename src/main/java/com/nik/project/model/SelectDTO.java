package com.nik.project.model;

import java.util.List;

public class SelectDTO {

	/* 상품 id */
	private int id;

	/* 상품 이름 */
	private String name;

	/* 카테고리 이름 */
	private String cateName;

	/* 상품 평점 */
	private double ratingAvg;

	/* 상품 설명 */
	private String intro;

	/* 상품 이미지 */
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

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public double getRatingAvg() {
		return ratingAvg;
	}

	public void setRatingAvg(double ratingAvg) {
		this.ratingAvg = ratingAvg;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "SelectDTO [id=" + id + ", name=" + name + ", cateName=" + cateName + ", ratingAvg=" + ratingAvg
				+ ", intro=" + intro + ", imageList=" + imageList + "]";
	}

}
