package com.nik.project.mapper;

import java.util.List;

import com.nik.project.model.MemberVO;

public interface MypageMapper {

	/* 마이룸(회원 정보 출력) */
	public MemberVO mypageInfo(String memberId);
}
