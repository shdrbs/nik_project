package com.nik.project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.CateFilterDTO;
import com.nik.project.model.Criteria;
import com.nik.project.model.ProductVO;
import com.nik.project.model.SelectDTO;
import com.nik.project.repository.AdminDAO;
import com.nik.project.repository.AttachDAO;
import com.nik.project.repository.ProductDAO;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDAO productDao;

	@Autowired
	private AttachDAO attachDao;

	@Autowired
	private AdminDAO adminDao;

	/* 상품 검색 */
	@Override
	public List<ProductVO> productGetList(Criteria cri) {

		log.info("productGetList().......");

		// 검색한 상품 정보들을 DB에서 가져와서 List타입의 변수 list에 저장
		List<ProductVO> list = productDao.productGetList(cri);

		list.forEach(product -> {

			// DB에서 가져온 상품정보 id를 변수 id에 저장
			int id = product.getId();

			// 이미지 정보를 참조하는 List를 생성하고 DB에서 이미지 정보를 가져와서 저장
			List<AttachImageVO> imageList = attachDao.getAttachList(id);

			// 이미지 정보를 상품정보가 담긴 list변수에 하나씩 저장
			product.setImageList(imageList);

		});

		return list;
	}

	/* 상품 총 갯수 */
	@Override
	public int productGetTotal(Criteria cri) {

		log.info("productGetTotal().......");

		return productDao.productGetTotal(cri);
	}

	/* 남성 카테고리 리스트 */
	@Override
	public List<ProductVO> getCateCode1() {

		log.info("getCateCode1().........");

		return productDao.getCateCode1();
	}

	/* 여성 카테고리 리스트 */
	@Override
	public List<ProductVO> getCateCode2() {

		log.info("getCateCode2().........");

		return productDao.getCateCode2();
	}

	/* 검색결과 카테고리 필터 정보 */
	@Override
	public List<CateFilterDTO> getCateInfoList(Criteria cri) {

		log.info("getCateInfoList : "+ cri);

		List<CateFilterDTO> filterInfoList = new ArrayList<CateFilterDTO>();
		log.info("filterInfoList : "+ filterInfoList);

		String[] typeArr = cri.getType().split("");
		log.info("cricri : "+ cri);

		List<CateFilterDTO> list = productDao.getCateList(cri);

		//String[] cateList = productMapper.getCateList(cri);

		String tempCateCode = cri.getCateCode();

		log.info("cri : "+ cri);
		log.info("tempCateCode : "+ tempCateCode);
		List<CateFilterDTO> filterInfo = productDao.getCateInfo(cri);
		filterInfoList.addAll(filterInfo);
		System.out.println("filterInfoList : "+filterInfoList);
		cri.setCateCode(tempCateCode);

		return filterInfoList;
	}

	/* 상품 정보 */
	@Override
	public ProductVO getProductInfo(int id) {

		ProductVO productInfo = productDao.getProductInfo(id);

		productInfo.setImageList(adminDao.getAttachInfo(id));

		return productInfo;
	}

	/* 상품 id 이름 */
	@Override
	public ProductVO getProductIdName(int id) {

		return productDao.getProductIdName(id);
	}

	/* 평점순 상품 정보 */
	@Override
	public List<SelectDTO> likeSelect() {

		List<SelectDTO> list = productDao.likeSelect();

		list.forEach(dto -> {

			int id = dto.getId();

			List<AttachImageVO> imageList = attachDao.getAttachList(id);

			dto.setImageList(imageList);

		});

		return list;
	}

	@Override
	public List<SelectDTO> newProduct() {

		List<SelectDTO> list = productDao.newProduct();

		list.forEach(dto -> {

			int id = dto.getId();

			List<AttachImageVO> imageList = attachDao.getAttachList(id);

			dto.setImageList(imageList);

		});

		return list;
	}


}
