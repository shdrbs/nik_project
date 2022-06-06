package com.nik.project.service;

import java.util.List;

import com.nik.project.model.CateFilterDTO;
import com.nik.project.model.Criteria;
import com.nik.project.model.ProductVO;
import com.nik.project.model.SelectDTO;

public interface ProductService {

	/* 상품 검색 */
	public List<ProductVO> productGetList(Criteria cri);

	/* 상품 총 갯수 */
	public int productGetTotal(Criteria cri);

	/* 남성 카테고리 리스트 */
	public List<ProductVO> getCateCode1();

	/* 여성 카테고리 리스트 */
	public List<ProductVO> getCateCode2();

	/* 검색결과 카테고리 필터 정보 */
	public List<CateFilterDTO> getCateInfoList(Criteria cri);

	/* 상품 정보 */
	public ProductVO getProductInfo(int id);

	/* 상품 id 이름 */
	public ProductVO getProductIdName(int id);

	/* 평점순 상품 정보 */
	public List<SelectDTO> likeSelect();

	/* 최근등록순 상품 정보 */
	public List<SelectDTO> newProduct();

}
