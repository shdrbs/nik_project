package com.nik.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.Criteria;
import com.nik.project.model.ReplyDTO;
import com.nik.project.model.UpdateReplyDTO;

@Repository
public class ReplyDAO {

	@Autowired
	private SqlSession sqlSession;

	/* 댓글 등록 */
	public int registReply(ReplyDTO dto) {

		return sqlSession.insert("com.nik.project.mapper.ReplyMapper.registReply", dto);
	}

	/* 댓글 존재 체크 */
	public Integer checkReply(ReplyDTO dto) {

		return sqlSession.selectOne("com.nik.project.mapper.ReplyMapper.checkReply", dto);
	}

	/* 댓글 페이징 */
	public List<ReplyDTO> getReplyList(Criteria cri) {

		return sqlSession.selectList("com.nik.project.mapper.ReplyMapper.getReplyList", cri);
	}

	/* 댓글 총 갯수(페이징) */
	public int getReplyTotal(int id) {

		return sqlSession.selectOne("com.nik.project.mapper.ReplyMapper.getReplyTotal", id);
	}

	/* 댓글 수정 */
	public int updateReply(ReplyDTO dto) {

		return sqlSession.update("com.nik.project.mapper.ReplyMapper.updateReply", dto);
	}

	/* 댓글 한개 정보(수정페이지) */
	public ReplyDTO getUpdateReply(int replyId) {

		return sqlSession.selectOne("com.nik.project.mapper.ReplyMapper.getUpdateReply", replyId);
	}

	/* 댓글 삭제 */
	public int deleteReply(int replyId) {

		return sqlSession.delete("com.nik.project.mapper.ReplyMapper.deleteReply", replyId);
	}

	/* 평점 평균 구하기 */
	public Double getRatingAverage(int id) {

		return sqlSession.selectOne("com.nik.project.mapper.ReplyMapper.getRatingAverage", id);
	}

	/* 평점 평균 반영하기 */
	public int updateRating(UpdateReplyDTO dto) {

		return sqlSession.update("com.nik.project.mapper.ReplyMapper.updateRating", dto);
	}
}
