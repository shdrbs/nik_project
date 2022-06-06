package com.nik.project.service;

import java.util.List;

import com.nik.project.model.MemberVO;

public interface MypageService {

	/* 마이룸(회원 정보 출력) */
	public MemberVO mypageInfo(String memberId);

	/* 마이룸(회원 정보 수정) */
	public void updateMember(MemberVO memberVO);
}
