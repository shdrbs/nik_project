package com.nik.project.service;

import java.util.List;

import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;

public interface MemberService {

	/* 회원가입 */
	public void memberJoin(MemberVO member);

	/* 아이디 중복 검사 */
	public int idCheck(String memberId);

	/* 로그인 기능 구현 */
    public MemberVO memberLogin(MemberVO member);

    /* 주문자 정보 */
	public MemberVO getMemberInfo(String memberId);

	/* 회원 탈퇴 */
	public int memberDelete(String memberId);

}
