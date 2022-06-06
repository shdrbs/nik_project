package com.nik.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nik.project.model.Criteria;
import com.nik.project.model.PageDTO;
import com.nik.project.model.ReplyDTO;
import com.nik.project.model.ReplyPageDTO;
import com.nik.project.model.UpdateReplyDTO;
import com.nik.project.repository.ReplyDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyDAO replyDao;

	/* 댓글 등록 */
	@Override
	public int registReply(ReplyDTO dto) {

		int result = replyDao.registReply(dto);

		setRating(dto.getId()); // 상품 평점 초기화 메서드 호출

		return result;
	}

	/* 댓글 존재 체크 */
	@Override
	public String checkReply(ReplyDTO dto) {

		Integer rdao = replyDao.checkReply(dto);

		if(rdao == null) {
			return "0";
		} else {
			return "1";
		}

	}

	/* 댓글 페이징 */
	@Override
	public ReplyPageDTO replyList(Criteria cri) {

		ReplyPageDTO dto = new ReplyPageDTO();

		dto.setList(replyDao.getReplyList(cri));
		dto.setPageInfo(new PageDTO(cri, replyDao.getReplyTotal(cri.getId())));

		return dto;
	}

	/* 댓글 수정 */
	@Override
	public int updateReply(ReplyDTO dto) {

		int result = replyDao.updateReply(dto);

		setRating(dto.getId()); // 상품 평점 초기화 메서드 호출

		return result;
	}

	/* 댓글 한개 정보(수정페이지) */
	@Override
	public ReplyDTO getUpdateReply(int replyId) {

		return replyDao.getUpdateReply(replyId);
	}

	/* 댓글 삭제 */
	@Override
	public int deleteReply(ReplyDTO dto) {

		int result = replyDao.deleteReply(dto.getReplyId());

		setRating(dto.getId()); // 상품 평점 초기화 메서드 호출

		return result;
	}

	/* 상품 평점 초기화 */
	// 상품을 등록, 수정, 삭제했을때 해당 상품의 평균 평점 값이 변경
	public void setRating(int id) {

		// 리뷰 평점 평균 값을 DB에서 불러와 ratingAvg변수에 저장
		Double ratingAvg = replyDao.getRatingAverage(id);

		if(ratingAvg == null) {
			ratingAvg = 0.0;
		}

		// 평점 소수점 계산  										// ratingAvg = 4.2568415
		ratingAvg = (double) (Math.round(ratingAvg*10));	// 43.0
		ratingAvg = ratingAvg / 10;							// 4.3

		UpdateReplyDTO urd = new UpdateReplyDTO();

		urd.setId(id);       			// 상품 번호
		urd.setRatingAvg(ratingAvg);	// 상품 평점 평균

		// DB적용
		replyDao.updateRating(urd);

	}

}
