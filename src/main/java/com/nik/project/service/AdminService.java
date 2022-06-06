package com.nik.project.service;

import java.util.List;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.CateVO;
import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.ProductVO;

public interface AdminService {

	// 상품 등록
	public void productRegist(ProductVO productVO);

	// 카테고리 리스트
	public List<CateVO> cateList();

	// 상품 리스트
	public List<ProductVO> productGetList(Criteria cri);

	// 상품 총 개수
	public int productGetTotal(Criteria cri);

	// 상품 조회 페이지
	public ProductVO productGetDetail(int id);

	// 상품 정보 수정
	public int productModify(ProductVO productVO);

	// 상품 정보 삭제
	public int productDelete(int id);

	// 지정 상품 이미지 정보 얻기
	public List<AttachImageVO> getAttachInfo(int id);

	/* 주문 상품 리스트 */
	public List<OrderDTO> getOrderList(Criteria cri);

	/* 주문 총 갯수 */
	public int getOrderTotal(Criteria cri);

	/* 회원 리스트 페이징 */
	public List<MemberVO> memberGetList(Criteria cri);

	/* 회원 총 인원수 */
	public int memberTotal(Criteria cri);

	/* 회원 수정 페이지*/
	public MemberVO memberGetModify(String memberId);

	/* 회원 정보 수정 기능 */
	public int memberModify(MemberVO memberVO);

	/* 회원 정보 삭제 */
	public int memberDelete(String memberId);
}
