package com.nik.project.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.Criteria;
import com.nik.project.model.ProductVO;
import com.nik.project.repository.AdminDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AdminMapperTest {

	@Autowired
	private AdminMapper mapper;
	
	@Autowired
	AdminDAO adminDao;

	/* 상품 등록 */
	/**
	 * @throws Exception
	 */
//	@Test
//	public void productRegistTest() throws Exception{
//
//		ProductVO product = new ProductVO();
//
//		product.setName("mapper 테스트");
//		product.setPubleYear("2021-03-18");
//		product.setCateCode("202001");
//		product.setPrice(20000);
//		product.setStock(300);
//		product.setDiscount(0.23);
//		product.setIntro("상품소개");
//
//		System.out.println("Before ProductVO :" + product);
//		
//		mapper.productRegist(product);
//		
//		System.out.println("After ProductVO :" + product);
//	}
	
	/* 카테고리 리스트 */
//	@Test
//	public void cateListTest() throws Exception{
//		
//		//System.out.println("cateList()..........." + mapper.cateList());
//		System.out.println("cateList()..........." + adminDao.cateList());
//		
//	}
	
	/* 상품 리스트 & 상품 총 갯수 */
//	@Test
//	public void productGetListTest() {
//		
//		Criteria cri = new Criteria();
//		
//		/* 검색조건 */
//		cri.setKeyword("치마");
//		
//		/* 검색 리스트 */
//		List list = mapper.productGetList(cri);
//		for(int i = 0; i < list.size(); i++) {
//			System.out.println("result......." + i + " : " + list.get(i));
//		}
//		
//		/* 상품 총 갯수 */
//		int result = mapper.productGetTotal(cri);
//		System.out.println("resutl.........." + result);
//	}
	
	/* 상품 조회 페이지 */
//	@Test
//	public void productGetDetailTest() {
//		
//		int id = 63;
//		
//		ProductVO result = mapper.productGetDetail(id);
//		
//		System.out.println("상품 조회 데이터 : " + result);
//		
//	}
	
	/* 상품 정보 수정 */
//	@Test
//	public void productModifyTest() {
//		
//		ProductVO ProductVO = new ProductVO();
//		
//		ProductVO.setId(63);
//		ProductVO.setName("mapper 테스트");
//		ProductVO.setPubleYear("2021-03-18");
//		ProductVO.setCateCode("103002");
//		ProductVO.setPrice(20000);
//		ProductVO.setStock(300);
//		ProductVO.setDiscount(0.23);
//		ProductVO.setIntro("책 소개 ");
//		
//		mapper.productModify(ProductVO);
//		
//	}
	
	/* 상품 정보 삭제 */
//	@Test
//	public void productDeleteTest() {
//		
//		int id = 63;
//		
//		int result = mapper.productDelete(id);
//		
//		if(result == 1) {
//			System.out.println("삭제 성공");
//		}
//		
//	}
	
	/* 이미지 등록 */
//	@Test
//	public void imageRegistTest() {
//		
//		AttachImageVO vo = new AttachImageVO();
//		
//		vo.setId(2211);
//		vo.setFileName("test");
//		vo.setUploadPath("test");
//		vo.setUuid("test2");
//		
//		mapper.imageRegist(vo);
//		
//	}
	
	/* 지정한 상품 이미지 삭제 */
//	@Test
//	public void deleteImageAllTest() {
//		
//		int id = 2231;
//		
//		mapper.deleteImageAll(id);
//		
//	}
	
	/* 어제자 날짜 이미지 리스트 */
//	@Test
//	public void checkImageListTest() {
//		
//		mapper.checkFileList();
//		
//	}
	
	/* 지정 상품 이미지 정보 얻기 */
	@Test
	public void getAttachInfoTest() {
		
		int id = 2233;
		
		List<AttachImageVO> list = mapper.getAttachInfo(id);
		
		System.out.println("list : " + list);
		
	}

}
