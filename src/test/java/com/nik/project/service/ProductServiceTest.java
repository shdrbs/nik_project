package com.nik.project.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.model.Criteria;
import com.nik.project.model.ProductVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ProductServiceTest {

	@Autowired
	private ProductService productService;

//	@Test
//	public void getCateInfoListTest1() {
//		Criteria cri = new Criteria();
//
//		String type = "TC";
//		String keyword = "테스트";
//		//String keyword = "없음";
//		//String cateCode="202001";
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		//cri.setCateCode(cateCode);
//
//		System.out.println("List<CateFilterDTO> : " + productService.getCateInfoList(cri));
//
//	}

//	@Test
//	public void getCateInfoListTest2() {
//		Criteria cri = new Criteria();
//
//		String type = "AC";
//		String keyword = "유홍준";
//		//String keyword = "머스크";
//		String cateCode = "103002";
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setCateCode(cateCode);
//
//		System.out.println("List<CateFilterDTO> : " + productService.getCateInfoList(cri));
//
//	}

//	@Test
//	public void getCateInfoListTest3() {
//		Criteria cri = new Criteria();
//
//		String type = "T";
//		String keyword = "테스트";
//		//String keyword = "없음";
//
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//
//		System.out.println("List<CateFilterDTO> : " + productService.getCateInfoList(cri));
//
//	}

	/*상품 상세 정보*/
	@Test
	public void getProductInfoTest() {

		int id = 2233;

		ProductVO productInfo = productService.getProductInfo(id);

		System.out.println("==결과==");
		System.out.println("전체 : " + productInfo);
		System.out.println("id : " + productInfo.getId() );
		System.out.println("이미지 정보 : " + productInfo.getImageList().isEmpty());

	}

}
