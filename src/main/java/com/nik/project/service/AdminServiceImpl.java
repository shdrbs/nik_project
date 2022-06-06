package com.nik.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.CateVO;
import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.ProductVO;
import com.nik.project.repository.AdminDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminDAO adminDao;

	// 상품 등록
	@Transactional
	@Override
	public void productRegist(ProductVO productVO) {

		log.info("(srevice)product........");

		adminDao.productRegist(productVO);

		log.info("서비스 이미지 정보 {}",productVO);

//		if(productVO.getImageList() == null || productVO.getImageList().size() <= 0) {
//			return;
//		}

		// 람다식 활용한 for문
		productVO.getImageList().forEach(attach ->{

			attach.setId(productVO.getId());
			adminDao.imageRegist(attach);
		});

		// for문
//		for(AttachImageVO attach : productVO.getImageList()) {
//
//			attach.setId(productVO.getId());
//			adminDao.imageRegist(attach);
//		}

	}

	// 카테고리 리스트
	@Override
	public List<CateVO> cateList() {

		log.info("(service)cateList........");

		return adminDao.cateList();
	}

	// 상품 리스트
	@Override
	public List<ProductVO> productGetList(Criteria cri) {

		log.info("productGetList()...........");

		return adminDao.productGetList(cri);
	}

	// 상품 총 개수
	@Override
	public int productGetTotal(Criteria cri) {

		log.info("productGetTotal()...........");

		return adminDao.ProductGetTotal(cri);
	}

	// 상품 조회 페이지
	@Override
	public ProductVO productGetDetail(int id) {

		log.info("(service)productGetDetail......." + id);

		return adminDao.productGetDetail(id);
	}

	// 상품 정보 수정
	@Transactional
	@Override
	public int productModify(ProductVO productVO) {

		int result = adminDao.productModify(productVO); // 상품 정보 수정 쿼리 호출

		// 상품 정보 수정을 성공했고 이미지가 있을 경우
		if(result == 1 && productVO.getImageList() != null && productVO.getImageList().size() > 0) {

			adminDao.deleteImageAll(productVO.getId()); // 상품 이미지 삭제

			// 람다식 반복문
			productVO.getImageList().forEach(attach -> {

				log.info("attach {} ",attach);
				attach.setId(productVO.getId()); // productVO의 id값을 attach에 set하고
				adminDao.imageRegist(attach);    // 이미지 등록 인자로 attach 삽입

			});

		}

		return result;
	}

	// 상품 정보 삭제
	@Override
	@Transactional
	public int productDelete(int id) {

		log.info("productDelete..........");

		adminDao.deleteImageAll(id); 		// 이미지 삭제

		return adminDao.productDelete(id);	// 상품 정보 삭제
	}

	// 지정 상품 이미지 정보 얻기
	@Override
	public List<AttachImageVO> getAttachInfo(int id) {

		log.info("getAttachInfo........");

		return adminDao.getAttachInfo(id);
	}

	/* 주문 상품 리스트 */
	@Override
	public List<OrderDTO> getOrderList(Criteria cri) {

		return adminDao.getOrderList(cri);
	}

	/* 주문 총 갯수 */
	@Override
	public int getOrderTotal(Criteria cri) {

		return adminDao.getOrderTotal(cri);
	}

	/* 회원 리스트 페이징 */
	@Override
	public List<MemberVO> memberGetList(Criteria cri) {

		return adminDao.memberGetList(cri);
	}

	/* 회원 총 인원수 */
	@Override
	public int memberTotal(Criteria cri) {

		return adminDao.memberTotal(cri);
	}

	/* 회원 수정 페이지 */
	@Override
	public MemberVO memberGetModify(String memberId) {

		return adminDao.memberGetModify(memberId);
	}

	/* 회원 정보 수정 */
	@Override
	public int memberModify(MemberVO memberVO) {

		return adminDao.memberModify(memberVO);
	}

	/* 회원 정보 삭제 */
	@Override
	public int memberDelete(String memberId) {

		return adminDao.memberDelete(memberId);
	}
}
