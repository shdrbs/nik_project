package com.nik.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.AttachImageVO;

@Repository
public class AttachDAO {
	
	@Autowired
	private SqlSession sqlSession;

	// 이미지 데이터 반환
	public List<AttachImageVO> getAttachList(int id){
		
		return sqlSession.selectList("com.nik.project.mapper.AttachMapper.getAttachList", id);
	}
}
