package com.nik.project.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {

	//회원 id
	private String memberId;

	//회원 비밀번호
	private String memberPw;

	//회원 이름
	private String memberName;

	//회원 연락처
	private String memberPhone;

	//회원 이메일
	private String memberMail;

	//회원 우편번호
	private String memberAddr1;

	//회원 주소
	private String memberAddr2;

	//회원 상세주소
	private String memberAddr3;

	// 관리자 구분(0:일반사용자, 1:관리자)
	private int adminCk;

	//등록일자
	private Date regDate;

	//회원 돈
	private int money;

	//회원 포인트
	private int point;

}