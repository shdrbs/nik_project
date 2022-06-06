package com.nik.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDAO memberDao;

	/* 회원가입(회원 정보 삽입) */
	@Override
	public void memberJoin(MemberVO member) {
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

		String rawPw = "";           // 인코딩 전 비밀번호
        String encodePw = "";        // 인코딩 후 비밀번호

        rawPw = member.getMemberPw();            // 비밀번호 데이터 얻음
        encodePw = pwEncoder.encode(rawPw);      // 비밀번호 인코딩
        member.setMemberPw(encodePw);            // 인코딩된 비밀번호 member객체에 다시 저장

		memberDao.memberJoin(member);
	}

	/* 아이디 중복 검사 */
	@Override
	public int idCheck(String memberId) {

		return memberDao.idCheck(memberId);
	}

	/* 로그인 기능 구현 */
	@Override
	public MemberVO memberLogin(MemberVO member) {

		return memberDao.memberLogin(member);
	}

	/* 주문자 정보 */
	@Override
	public MemberVO getMemberInfo(String memberId) {

		return memberDao.getMemberInfo(memberId);
	}

	/* 회원 탈퇴 */
	@Override
	public int memberDelete(String memberId) {

		return memberDao.memberDelete(memberId);
	}

}
