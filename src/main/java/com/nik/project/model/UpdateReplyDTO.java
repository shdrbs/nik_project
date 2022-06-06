package com.nik.project.model;

public class UpdateReplyDTO {

	private int id;

	private double ratingAvg;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getRatingAvg() {
		return ratingAvg;
	}

	public void setRatingAvg(double ratingAvg) {
		this.ratingAvg = ratingAvg;
	}

	@Override
	public String toString() {
		return "UpdateReplyDTO [id=" + id + ", ratingAvg=" + ratingAvg + "]";
	}

}
