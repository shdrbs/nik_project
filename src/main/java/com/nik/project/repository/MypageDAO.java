package com.nik.project.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MypageDAO {

	@Autowired
	private SqlSession sqlSession;

	/* 마이룸(회원 정보 출력) */
	public MemberVO mypageInfo(String memberId) {

		return sqlSession.selectOne("com.nik.project.mapper.MypageMapper.mypageInfo", memberId);
	}

	/* 마이룸(회원 정보 수정) */
	public void updateMember(MemberVO memberVO) {

		log.info("MemberDAO.updateMember");

		sqlSession.update("com.nik.project.mapper.MypageMapper.updateMember", memberVO);
	}

}
