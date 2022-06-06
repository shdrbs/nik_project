package com.nik.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import com.nik.project.mapper.MypageMapper;
import com.nik.project.model.MemberVO;
import com.nik.project.repository.MypageDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MypageServiceImpl implements MypageService {

	@Autowired
	private MypageDAO mypageDao;

	/* 마이룸(회원 정보 출력) */
	@Override
	public MemberVO mypageInfo(String memberId) {

		return mypageDao.mypageInfo(memberId);
	}

	/* 마이룸(회원 정보 수정) */
	public void updateMember(MemberVO memberVO) {

		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

		String rawPw = "";           // 인코딩 전 비밀번호
        String encodePw = "";        // 인코딩 후 비밀번호

        rawPw = memberVO.getMemberPw();          // 비밀번호 데이터 얻음
        encodePw = pwEncoder.encode(rawPw);      // 비밀번호 인코딩
        memberVO.setMemberPw(encodePw);          // 인코딩된 비밀번호 member객체에 다시 저장

		mypageDao.updateMember(memberVO);
	}

}
