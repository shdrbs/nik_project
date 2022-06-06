package com.nik.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.CateFilterDTO;
import com.nik.project.model.Criteria;
import com.nik.project.model.ProductVO;
import com.nik.project.model.SelectDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ProductDAO {

	@Autowired
	private SqlSession sqlSession;

	/* 상품 검색 */
	public List<ProductVO> productGetList(Criteria cri) {

		return sqlSession.selectList("com.nik.project.mapper.ProductMapper.productGetList", cri);
	}

	/* 상품 총 갯수 */
	public int productGetTotal(Criteria cri) {

		return sqlSession.selectOne("com.nik.project.mapper.ProductMapper.productGetTotal", cri);
	}

	/* 남성 카테고리 리스트 */
	public List<ProductVO> getCateCode1() {

		return sqlSession.selectList("com.nik.project.mapper.ProductMapper.getCateCode1");
	}

	/* 여성 카테고리 리스트 */
	public List<ProductVO> getCateCode2() {

		return sqlSession.selectList("com.nik.project.mapper.ProductMapper.getCateCode2");
	}

	/* 검색 대상 카테고리 리스트 */
	public List<CateFilterDTO> getCateList(Criteria cri) {

		log.info("productDAO cri : " + cri);
		return sqlSession.selectList("com.nik.project.mapper.ProductMapper.getCateList", cri);
	}

	/* 카테고리 정보(+검색대상 갯수) */
	public List<CateFilterDTO> getCateInfo(Criteria cri) {

		return sqlSession.selectList("com.nik.project.mapper.ProductMapper.getCateInfo", cri);
	}

	/* 상품 정보 */
	public ProductVO getProductInfo(int id) {

		return sqlSession.selectOne("com.nik.project.mapper.ProductMapper.getProductInfo",id);
	}

	/* 상품 id 이름 */
	public ProductVO getProductIdName(int id) {

		return sqlSession.selectOne("com.nik.project.mapper.ProductMapper.getProductIdName",id);
	}

	/* 평점순 상품 정보 */
	public List<SelectDTO> likeSelect() {

		return sqlSession.selectList("com.nik.project.mapper.ProductMapper.likeSelect");
	}

	/* 최근등록순 상품 정보 */
	public List<SelectDTO> newProduct() {

		return sqlSession.selectList("com.nik.project.mapper.ProductMapper.newProduct");
	}
}
