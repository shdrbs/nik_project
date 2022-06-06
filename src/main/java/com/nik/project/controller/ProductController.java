package com.nik.project.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.Criteria;
import com.nik.project.model.PageDTO;
import com.nik.project.model.ProductVO;
import com.nik.project.model.ReplyDTO;
import com.nik.project.service.AttachService;
import com.nik.project.service.ProductService;
import com.nik.project.service.ReplyService;

@Controller
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private AttachService attachService;

	@Autowired
	private ProductService productService;

	@Autowired
	private ReplyService replyService;

	/* 이미지 출력 */
	// 이미지 파일을 주고 받을려면 byte타입을 사용
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){

		logger.info("getImage()........"+ fileName);

		// 기본경로 + 유동경로(2022\\05\\15) + 파일이름
		File file = new File("C:\\develop\\work_space\\project\\nik_project\\upload\\" + fileName);

		//  뷰로 반환할 ResponseEntity 객체의 주소를 저장할 참조 변수를 선언하고 null로 초기화
		ResponseEntity<byte[]> result = null;

		try {

			// ResponseEntity에 Response의 header와 관련된 설정의 객체를 추가해주기 위해서 HttpHeaders를 인스턴스화 한 후 참조 변수를 선언하여 대입
			HttpHeaders header = new HttpHeaders();

			// header의 Content Type 속성 값에 이미지 파일 MIME TYPE을 추가해주기 위해서 HttpHeader 클래스에 있는 add() 메서드를 사용
			// add()의 첫번째 파라미터는 Response header의 '속성명'을, 두 번째 파라미터에는 해당 '속성명'에 부여할 값(value)을 삽입
			header.add("Content-type", Files.probeContentType(file.toPath()));

			// 출력할 대상 이미지 파일, header 객체, 상태 코드를 인자 값으로 부여한 생성자를 통해 ResponseEntity 객체를 생성하여 앞서 선언한 ResponseEntity 참조 변수에 대입
			// FileCopyUtils.copyToByteArray() : 대상 파일을 복사하여 byte타입으로 반환
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK); // 상태 코드 200

		}catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}

	/* 이미지 정보 반환 */
	// 반환해주는 데이터가 JSON형식이 되도록 지정해주기 위해 produces속성 추가
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int id){

		logger.info("getAttachList.........." + id);

		// 리턴 값으로  getAttachList(id) 메서드를 통해 반환받은 이미지 정보와 상태 코드가 OK 데이터를 담고 있는 ResponeEntity 객체를 부여
		return new ResponseEntity<List<AttachImageVO>>(attachService.getAttachList(id), HttpStatus.OK);

	}

	/* 상품 검색 */
	@GetMapping("/search")
	public String searchProductGET(Criteria cri, Model model) {

		logger.info("cri : " + cri);

		// 검색한 단어가 들어간 DB정보를 가져옴
		List<ProductVO> list = productService.productGetList(cri);
		logger.info("pre list : " + list);

		if(!list.isEmpty()) { // 검색한 결과가 있을 경우

			model.addAttribute("list", list);
			logger.info("list : " + list);

		} else { // 검색한 결과가 없을 경우

			model.addAttribute("listcheck", "empty");

			return "/search";
		}

		model.addAttribute("pageMaker", new PageDTO(cri, productService.productGetTotal(cri)));

		String[] typeArr = cri.getType().split("");
		logger.info("typeArr : " + cri.getType());

		for(String s : typeArr) {
			if(s.equals("T")||s.equals("C")||s.equals("TC")) {
				model.addAttribute("filter_info", productService.getCateInfoList(cri));
			}
		}

		return "/search";

	}

	/* 상품 상세 */
	@GetMapping("/productDetail/{id}")
	public String productDetailGET(@PathVariable("id")int id, Model model) {

		logger.info("productDetailGET()..........");

		model.addAttribute("productInfo", productService.getProductInfo(id));

		return "/productDetail";
	}

	/* 리뷰 쓰기(팝업창) */
	@GetMapping("/replyRegist/{memberId}")
	public String replyRegistWindowGET(@PathVariable("memberId")String memberId, int id, Model model) {

		ProductVO pvo = productService.getProductIdName(id);

		model.addAttribute("productInfo", pvo);
		model.addAttribute("memberId", memberId);

		return "/replyRegist";
	}

	/* 리뷰 수정 팝업창 */
	@GetMapping("/replyUpdate")
	public String replyUpdateWindowGET(ReplyDTO dto, Model model) {

		ProductVO pvo = productService.getProductIdName(dto.getId());

		model.addAttribute("productInfo", pvo);
		model.addAttribute("replyInfo", replyService.getUpdateReply(dto.getReplyId()));
		model.addAttribute("memberId", dto.getMemberId());

		return "/replyUpdate";
	}

}
