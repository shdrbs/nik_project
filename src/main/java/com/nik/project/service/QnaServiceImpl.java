package com.nik.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import com.nik.project.model.QnaVO;
import com.nik.project.repository.QnaDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class QnaServiceImpl implements QnaService{

	@Autowired
	private QnaDAO qnaDao;

	@Inject
	TransactionTemplate txTemplate;

	/**
	 * 개인 게시글 목록(리스트) 조회
	 *
	 * @param id 회원 아이디
	 * @return 게시글 리스트
	 */
	public List<QnaVO> listQna(String memberId) {

		log.info("QnaService.listQna");

		return qnaDao.listQna(memberId);
	}

	/**
	 * 개인 개별 게시글 조회
	 *
	 * @param qseq 게시글 아이디
	 * @return 게시글 VO 객체
	 */
	public QnaVO getQna(int qseq) {

		log.info("QnaService.getQna");
		return qnaDao.getQna(qseq);
	}

	/**
	 * 개인 개별 게시글 작성(쓰기)
	 *
	 * @param qnaVO QnA VO 객체
	 * @return 게시글 작성 성공 여부
	 */
	public boolean insertQna(QnaVO qnaVO) {

		log.info("QnaService.insertQna");


		boolean flag = false;

		if (qnaDao.insertQna(qnaVO)==true) {

			log.info("게시글 저장 성공");
			flag = true;
		} else {
			log.info("게시글 저장 실패");
			flag = false;
		}

		return flag;

	}

	/**
	 * 관리자 : 게시글 목록 조회 (페이징)
	 *
	 * @param page 현재 페이지
	 * @param limit 페이지 당 게시글 수
	 * @return 게시글 목록(리스트)
	 */
	public List<QnaVO> listQnaByPaging(int page, int limit) {

		log.info("QnaService.listQnaByPaging");

		return qnaDao.listQnaByPaging(page, limit);
	}

	/**
	 * 관리자 : 총 QnA 수
	 *
	 * @return QnA 목록(리스트) 수
	 */
	public int getTotalQnasCount() {

		log.info("QnaService.getTotalQnasCount");

		return qnaDao.getTotalQnasCount();
	}

	/**
	 * 관리자 : 개별 게시글 수정(댓글(답글) 작성)
	 *
	 * @param qseq 게시글 번호(아이디)
	 * @param reply 답글(댓글) 내용
	 * @return 게시글 댓글 작성 성공 여부
	 */
    public boolean updateQna(int qseq, String reply) {

    	log.info("QnaService.updateQna");


		boolean flag = false;

		if (qnaDao.updateQna(qseq, reply) == true) {

			log.info("게시글 답글 저장(수정) 성공");
			flag = true;
		} else {
			log.info("게시글 답글 저장(수정) 실패");
			flag = false;
		}

		return flag;
    }

}

