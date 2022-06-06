package com.nik.project.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.ProductVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminServiceTest {
	
	@Autowired
	private AdminService service;
	
	/* 상품 등록 & 상품 이미지 등록 테스트 */
	@Test
	public void productRegistTest() {
		
		ProductVO product = new ProductVO();
		
		// 상품 정보
		product.setName("service 테스트");
		product.setPubleYear("2021-03-18");
		product.setCateCode("202001");
		product.setPrice(20000);
		product.setStock(300);
		product.setDiscount(0.23);
		product.setIntro("책 소개 ");
		

		// 이미지 정보
		List<AttachImageVO> imageList = new ArrayList<AttachImageVO>(); 
		
		AttachImageVO image1 = new AttachImageVO();
		AttachImageVO image2 = new AttachImageVO();
		
		image1.setFileName("test Image 1");
		image1.setUploadPath("test image 1");
		image1.setUuid("test1111");
		
		// 일부러 에러를 내기 위해서 DB에 지정한 varchar2(50)사이즈 보다 긴 문자열 입력
		image2.setFileName("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		image2.setUploadPath("test image 2");
		image2.setUuid("test2222");
		
		imageList.add(image1);
		imageList.add(image2);
		
		product.setImageList(imageList);
		
		// productRegist() 메서드 호출
		service.productRegist(product);
		
		System.out.println("등록된 VO2 : " + product);
		
	}

}
