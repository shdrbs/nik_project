package com.nik.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.CateVO;
import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.ProductVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class AdminDAO {

	@Autowired
	private SqlSession sqlSession;

	/* 상품 등록 */
	public void productRegist(ProductVO productVO) {

		sqlSession.insert("com.nik.project.mapper.AdminMapper.productRegist", productVO);
	}

	/* 카테고리 리스트 */
	public List<CateVO> cateList(){

		return sqlSession.selectList("com.nik.project.mapper.AdminMapper.cateList");
	}

	/* 상품 리스트 */
	public List<ProductVO> productGetList(Criteria cri) {

		return sqlSession.selectList("com.nik.project.mapper.AdminMapper.productGetList", cri);
	}

	/* 상품 총 개수 */
	public int ProductGetTotal(Criteria cri) {

		return sqlSession.selectOne("com.nik.project.mapper.AdminMapper.productGetTotal", cri);
	}

	/* 상품 조회 페이지 */
	public ProductVO productGetDetail(int id) {

		return sqlSession.selectOne("com.nik.project.mapper.AdminMapper.productGetDetail", id);
	}

	/* 상품 정보 수정 */
	public int productModify(ProductVO productVO) {

		return sqlSession.update("com.nik.project.mapper.AdminMapper.productModify", productVO);
	}

	/* 상품 정보 삭제 */
	public int productDelete(int id) {

		return sqlSession.delete("com.nik.project.mapper.AdminMapper.productDelete", id);
	}

	/* 이미지 등록 */
	public int imageRegist(AttachImageVO attach) {

		return sqlSession.insert("com.nik.project.mapper.AdminMapper.imageRegist", attach);
	}

	/* 지정한 상품 이미지 전체 삭제 */
	public int deleteImageAll(int id) {

		return sqlSession.delete("com.nik.project.mapper.AdminMapper.deleteImageAll", id);
	}

	/* 어제자 날짜 이미지 리스트 */
	public List<AttachImageVO> checkFileList() {

		return sqlSession.selectList("com.nik.project.mapper.AdminMapper.checkFileList");
	}

	/* 지정 상품 이미지 정보 얻기 */
	public List<AttachImageVO> getAttachInfo(int id){

		return sqlSession.selectList("com.nik.project.mapper.AdminMapper.getAttachInfo", id);
	}

	/* 주문 상품 리스트 */
	public List<OrderDTO> getOrderList(Criteria cri) {

		return sqlSession.selectList("com.nik.project.mapper.AdminMapper.getOrderList", cri);
	}

	/* 주문 총 갯수 */
	public int getOrderTotal(Criteria cri) {

		return sqlSession.selectOne("com.nik.project.mapper.AdminMapper.getOrderTotal", cri);
	}

	/* 회원 리스트 페이징 */
	public List<MemberVO> memberGetList(Criteria cri){

		return sqlSession.selectList("com.nik.project.mapper.AdminMapper.memberGetList", cri);
	}

	/* 회원 총 인원 */
	public int memberTotal(Criteria cri){

		return sqlSession.selectOne("com.nik.project.mapper.AdminMapper.memberTotal", cri);
	}

	/* 회원 수정 페이지 */
	public MemberVO memberGetModify(String memberId) {

		return sqlSession.selectOne("com.nik.project.mapper.AdminMapper.memberGetModify", memberId);
	}

	/* 회원 수정 기능 */
	public int memberModify(MemberVO memberVO) {

		return sqlSession.update("com.nik.project.mapper.AdminMapper.memberModify", memberVO);
	}

	/* 회원 정보 삭제 */
	public int memberDelete(String memberId) {

		return sqlSession.delete("com.nik.project.mapper.AdminMapper.memberDelete", memberId);
	}

}
