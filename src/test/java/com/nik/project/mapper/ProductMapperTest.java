package com.nik.project.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.model.Criteria;
import com.nik.project.model.ProductVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ProductMapperTest {

	@Autowired
	private ProductMapper mapper;

//	@Test
//	public void productListTest() {
//
//		Criteria cri = new Criteria();
//		// 테스트 키워드
//
//		String type = "T";
//		String keyword = "없음";
//		String catecode = "";
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setCateCode(catecode);
//		System.out.println("cri : " + cri);
//
//		List<ProductVO> list = mapper.productGetList(cri);
//		System.out.println("list : " + list);
//
//		System.out.println("====================");
//
//	}

	/* 카테고리 리스트 */
//	@Test
//	public void getCateListTest1() {
//
//		Criteria cri = new Criteria();
//
//		String type = "TC";
//		String keyword = "검정";
//		String cateCode="103001";
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setCateCode(cateCode);
//		//cri.setAuthorArr(mapper.getAuthorIdList(keyword));
//
//		String[] cateList = mapper.getCateList(cri)		;
//		for(String codeNum : cateList) {
//			System.out.println("codeNum ::::: " + codeNum);
//		}
//
//	}

	/* 카테고리 정보 얻기 */
	@Test
	public void getCateInfoTest1() {

		Criteria cri = new Criteria();

		String type = "TC";
		String keyword = "검정";
		String cateCode="103001";

		cri.setType(type);
		cri.setKeyword(keyword);
		cri.setCateCode(cateCode);

		mapper.getCateInfo(cri);

	}

	/* 상품 정보 */
//	@Test
//	public void getProductInfo() {
//		int id = 2241;
//		ProductVO productInfo = mapper.getProductInfo(id);
//		System.out.println("===========================");
//		System.out.println(productInfo);
//		System.out.println("===========================");
//
//	}

}
