package com.nik.project.service;

import java.util.List;

import com.nik.project.model.QnaVO;

public interface QnaService {

	public List<QnaVO> listQna(String memberId);

	public QnaVO getQna(int qseq);

	public boolean insertQna(QnaVO qnaVO);

	public List<QnaVO> listQnaByPaging(int page, int limit);

	public int getTotalQnasCount();

	public boolean updateQna(int qseq, String reply);

}
