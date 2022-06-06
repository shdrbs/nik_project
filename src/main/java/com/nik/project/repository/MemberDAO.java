package com.nik.project.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MemberDAO {

	@Autowired
	SqlSession sqlSession;

	/* 회원가입 */
	public void memberJoin(MemberVO member) {

		sqlSession.insert("com.nik.project.mapper.MemberMapper.memberJoin", member);
	}

	/* 아이디 중복 검사 */
	public int idCheck(String memberId) {

		return sqlSession.selectOne("com.nik.project.mapper.MemberMapper.idCheck", memberId);
	}

	/* 로그인 기능 구현 */
    public MemberVO memberLogin(MemberVO member) {

    	return sqlSession.selectOne("com.nik.project.mapper.MemberMapper.memberLogin", member);
    }

    /* 문자 주소 정보 */
	public MemberVO getMemberInfo(String memberId) {

    	return sqlSession.selectOne("com.nik.project.mapper.MemberMapper.getMemberInfo", memberId);
    }

	/* 회원 탈퇴 */
	public int memberDelete(String memberId) {

		return sqlSession.delete("com.nik.project.mapper.MemberMapper.memberDelete", memberId);
	}

}
