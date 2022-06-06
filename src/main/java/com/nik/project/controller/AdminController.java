package com.nik.project.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nik.project.model.AttachImageVO;
import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderCancelDTO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.PageDTO;
import com.nik.project.model.ProductVO;
import com.nik.project.service.AdminService;
import com.nik.project.service.MemberService;
import com.nik.project.service.OrderService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin/")
public class AdminController {

    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
	private AdminService adminService;

    @Autowired
	private OrderService orderService;

    @Autowired
    private MemberService memberService;

    /* 관리자 메인 페이지 */
    @GetMapping("main")
    public void adminMain() {
        logger.info("관리자 페이지 이동");
    }

    /* 상품 등록 페이지 */
    @GetMapping("productRegist")
    public void productRegist(Model model) throws Exception{
    	logger.info("상품 등록 페이지 접속");

    	ObjectMapper objm = new ObjectMapper();

    	List list = adminService.cateList();

    	String cateList = objm.writeValueAsString(list); // java객체를 String타입의 JSON형식 데이터로 변환

    	model.addAttribute("cateList", cateList);
    }

    /* 상품 등록 */
  	@PostMapping("productRegist.do")
  	public String productRegist(ProductVO productVO, RedirectAttributes rttr) {

  		logger.info("productRegist......" + productVO);

  		adminService.productRegist(productVO);

  		rttr.addFlashAttribute("regist_result", productVO.getName());

  		return "redirect:/admin/productManage";
  	}

    /* 상품 관리 페이지 */
    @GetMapping("productManage")
    public void productManage(Criteria cri, Model model) throws Exception{

        logger.info("상품 관리 페이지 접속");

        /* 상품 리스트 데이터 */
		List list = adminService.productGetList(cri);

		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}

		// 페이지 인터페이스 데이터
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.productGetTotal(cri)));

		logger.info("pageMaker : {}",new PageDTO(cri, adminService.productGetTotal(cri)));
		logger.info("상품 리스트 : {}", list.get(0));
    }

    /* 상품 조회,수정 페이지 */
	@GetMapping({"productDetail", "productModify"})
	public void productGetInfo(int id, Criteria cri, Model model) throws JsonProcessingException {

		logger.info("productGetInfo()........." + id);

		ObjectMapper mapper = new ObjectMapper(); // writeValueAsString() 사용하기 위해 선언

		/* 카테고리 리스트 데이터 */
		// 카테고리 데이터를 String타입의 JSON형식으로 변환해서 model객체 "cateList"에 저장
		model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));

		/* 목록 페이지 조건 정보 */
		model.addAttribute("cri", cri);

		/* 조회 페이지 정보(상품 정보) */
		model.addAttribute("productInfo", adminService.productGetDetail(id));

	}

	/* 상품 정보 수정 */
	@PostMapping("/productModify.do")
	public String productModifyPOST(ProductVO productVO, RedirectAttributes rttr) {

		logger.info("productModifyPOST.........." + productVO);

		int result = adminService.productModify(productVO);

		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/admin/productManage";

	}

	/* 상품 정보 삭제 */
	@PostMapping("/productDelete")
	public String productDeletePOST(int id, RedirectAttributes rttr) {

		logger.info("productDeletePOST..........");

		// DB에서 이미지 정보들을 가져와서 List타입의 변수 fileList에 저장
		List<AttachImageVO> fileList = adminService.getAttachInfo(id);

		// 이미지가 존재할 시 if문 실행
		if(fileList != null) {

			// 이미지 파일 경로를 저장할 Path 리스트 선언 및 초기화
			List<Path> pathList = new ArrayList();

			fileList.forEach(vo ->{
				// 원본 이미지
				Path path = Paths.get("C:\\develop\\work_space\\project\\nik_project\\upload",
						vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
				// 섬네일 이미지
				path = Paths.get("C:\\develop\\work_space\\project\\nik_project\\upload",
						vo.getUploadPath(), "thumbnail_" + vo.getUuid()+"_" + vo.getFileName());
				pathList.add(path);

			});

			pathList.forEach(path ->{
				path.toFile().delete(); // Path객체를 File객체로 변환 후 삭제
			});

		}

		int result = adminService.productDelete(id);

		rttr.addFlashAttribute("delete_result", result);

		return "redirect:/admin/productManage";

	}

	/* 첨부 파일 업로드 */
	// 반환 타입은 ResponseEntity객체이고 Http의 body에 추가될 데이터는 List<AttachImageVO>라는 의미이다
	// produces = MediaType.APPLICATION_JSON_UTF8_VALUE :서버에서 뷰로 반환하는 데이터를 UTF-8로 인코딩
	@PostMapping(value="uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {

		logger.info("uploadAjaxActionPOST..........");

		/* 이미지 파일 체크 */
		for(MultipartFile multipartFile: uploadFile) {

			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;

			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}

			if(!type.startsWith("image")) { // startsWith("image") : 체크 대상이 image로 시작할 경우 true를 반환

				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST); // 상태 코드 400
			}
		}

		String uploadFolder = "C:\\develop\\work_space\\project\\nik_project\\upload"; // 업로드 파일이 저장될 경로
////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 날짜 형식을 yyyy-MM-dd 변환하기 위해 선언
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// 오늘 날짜 데이터를 얻기 위해 선언 및 초기화
		Date date = new Date(); // ex) Tue May 17 12:18:16 KST 2022

		// SimpleDateFormat의 format 메서드를 호출해서 인자 값으로 오늘날짜 date변수를 부여하면 String 타입으로 반환된다.
		String str = sdf.format(date); // ex) "2022-05-15"

		// replace() : 변환(치환)
		// File.separator : 실행되는 환경에 따라 그에 맞는 경로 구분자를 반환('/'리눅스, '\'윈도우)
		String datePath = str.replace("-", File.separator);
////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/* 폴더 생성 */
		// c:\\upload\\yyyy\\MM\\dd 경로의 디렉터리를 대상으로 하는 File 객체로 초기화해줌
		// 첫 번째 인자로 부모 경로엔 uploadFoler 변수를 두 번째 인자로 자식 경로인 datePath 변수를 부여
		File uploadPath = new File(uploadFolder, datePath);

		// uploadPath.mkdirs();을 그대로 사용하게 되면 폴더가 있어도 사용자가 업로드 할 때마다 폴더를 생성함 이를 방지하기 위해
		// File 클래스에서 대상 파일 혹은 디렉터리가 존재하는지 유무를 반환하는 exists() 메서드를 활용하여
		// if문을 작성을 하고 if구현부에 폴더를 생성하는 코드를 작성
		if(uploadPath.exists() == false) {
			// mkdirs() : 여러개의 폴더를 생성
			uploadPath.mkdirs(); // ex) 부모 경로인 "D:\\nik\\upload" 아래에 2022\\05\\15폴더 생성
		}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/* 이미지 정보 담는 객체 */
		List<AttachImageVO> list = new ArrayList();

		/* 업로드 파일 저장 */
		for(MultipartFile multipartFile : uploadFile) {

			/* 이미지 정보 객체 */
			AttachImageVO vo = new AttachImageVO();

			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);

			/* uuid 적용 파일 이름 */
			// 랜덤한 uuid를 생성하고 String타입으로 변환(uuid는 생성 시 uuid타입이라 String타입으로 변환해줌)
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);

			uploadFileName = uuid + "_" + uploadFileName; // ex) dsf1-54sdf48-sd4f8_파일이름.확장자명

			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);

			/* 파일 저장 */
			// transferTo() : IOException와 IllegalStateException을 일으킬 가능성있기 때문에 try-catch문 작성
			try {
				// transferTo() : 파일을 저장(파일을 저장 할려면 파일 위치와 파일 이름을 알아야 한다)
				multipartFile.transferTo(saveFile);
				/*
				// 방법 1
				// 썸네일 이미지가 저장될 경로와 썸네일 이미지 이름을 thumbnailFile에 저장
				File thumbnailFile = new File(uploadPath, "thumbnail_" + uploadFileName); // "thumbnail_" + "uuid_" + "원본파일 이름. 이미지 타입"

				// ImageIO 클래스는 이미지를 읽어오거나 생성(작성?) 할 수 있도록 도와주는 메서드
				// BufferedImage : 이미지 데이터를 처리하거나 조작에 필요한 값과 메서드를 제공
				BufferedImage bo_image = ImageIO.read(saveFile); // 파일로 부터 이미지를 읽어온다

				// 비율
				int ratio = 3;
				// 넓이 높이
				// getWidth(), getHeight() : 이미지의 넓이,높이 값을 가져온다
				int width = bo_image.getWidth() / ratio; // bo_image의 넓이를 3으로 나눈다(3배 작게)
				int height = bo_image.getHeight() / ratio;

				// 일종의 크기를 지정하여 흰색 도화지를 만드는 것과 같다
				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);

				// Graphics2D : 그림을 그리는데 필요로 한 설정값과 메서드를 제공
				// 앞서 만든 도화지를 사용하기 위한 준비
				Graphics2D graphic = bt_image.createGraphics();

				// 도화지에 이미지를 그리는 과정
				// 첫번째 인자 : 그려놓고자 하는 이미지
				// 두번째, 세번째 인자 : 그림을 어느 좌표부터 그릴 것인가(x,y)
				// 네번째, 다섯번째 인자 : 그림(이미지)의 넓이와 높이
				// 여섯번째 인자 : ImageObserver 객체 : 이미지의 정보를 전달받아서 이미지를 업데이트시키는 역할 일반적인 경우 null
				graphic.drawImage(bo_image, 0, 0, width, height, null);

				// 썸네일 이미지 파일 저장
				// 첫번째 인자 : 파일에 저장할 이미지
				// 두번째 인자 : 이미지를 어떠한 형식으로 저장할 것이지 지정
				// 세번째 인자 :
				ImageIO.write(bt_image, "jpg", thumbnailFile);
				*/

				// 방법 2
				// 썸네일 이미지가 저장될 경로와 썸네일 이미지 이름을 thumbnailFile에 저장
				File thumbnailFile = new File(uploadPath, "thumbnail_" + uploadFileName);

				// 파일로 부터 이미지를 읽어온다
				BufferedImage bo_image = ImageIO.read(saveFile);

				//비율
				int ratio = 3;
				//넓이 높이
				int width = bo_image.getWidth() / ratio;
				int height = bo_image.getHeight() / ratio;

				Thumbnails.of(saveFile)            // 원본 이미지파일로 부터
		        		  .size(width, height)     // 넓이, 높이가 200, 200인
		        		  //.rotate(90)
		        		  //.watermark(Positions.BOTTOM_RIGHT, ImageIO.read(new File("watermark.png")), 0.5f)
		        		  //.outputQuality(0.8)
		        		  .toFile(thumbnailFile);  // 썸네일 이미지 얻기(저장)

			} catch (Exception e) {
				e.printStackTrace();
			}

			list.add(vo);
		}

		// Http의 body에 추가될 데이터는 List<AttachImageVO>이고 상태 코드가 OK(200)인 ResponseEntity객체 생성
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK); // 상태 코드 200

		return result;
	}

	/* 이미지 파일 삭제 */
	// HTTP Body에 String 데이터를 추가하기 위해 타입 매개 변수로서 String을 부여
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){

		logger.info("deleteFile........" + fileName);

		File file = null;

		try {

			/* 썸네일 파일 삭제 */
			file = new File("C:\\develop\\work_space\\project\\nik_project\\upload\\"
					+ URLDecoder.decode(fileName, "UTF-8")); // 첫 번째 파라미터는 디코딩할 대상 문자열 데이터
															 // 두 번째 파라미터는 대상 문자열 데이터가 어떠한 타입으로 인코딩 되었는지에 대한 정보를 부여
															 // 리턴 타입은 디코딩된 문자열(String) 데이터
			file.delete(); // 썸네일 이미지 삭제

			/* 원본 파일 삭제 */
			// getAbsolutePath() : 대상 File 객체의 경로를 문자열(String) 타입의 데이터로 반환
			String originFileName = file.getAbsolutePath().replace("thumbnail_", "");

			logger.info("originFileName : " + originFileName);

			// 본 파일을 대상으로 하는 File 객체를 생성 후 이를 기존에 선언하고 사용하였던 file 참조 변수가 참조
			file = new File(originFileName);

			file.delete(); // 원본 이미지 삭제

		} catch(Exception e) {

			e.printStackTrace();

			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}

		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	/* 주문 현황 페이지 */
	@GetMapping("/orderList")
	public String orderListGET(Criteria cri, Model model) {

		List<OrderDTO> list = adminService.getOrderList(cri);

		if(!list.isEmpty()) {

			model.addAttribute("list", list);
			model.addAttribute("pageMaker", new PageDTO(cri, adminService.getOrderTotal(cri)));

		} else {

			model.addAttribute("listCheck", "empty");
		}

		return "/admin/orderList";
	}

	/* 주문삭제 */
	@PostMapping("/orderCancel")
	public String orderCancelPOST(OrderCancelDTO dto, HttpSession session) {

		orderService.orderCancel(dto);

		MemberVO mvo = memberService.getMemberInfo(dto.getMemberId());

		session.setAttribute("member", mvo);

		return "redirect:/admin/orderList?keyword="
		+ dto.getKeyword() + "&amount=" + dto.getAmount() + "&pageNum=" + dto.getPageNum();

	}

	/* 회원 리스트 페이징 */
    @GetMapping("memberManage")
    public void memberGetList(Criteria cri, Model model) throws Exception{

        logger.info("회원 관리 페이지 접속"+cri);

        /* 회원 리스트 데이터 */
		List list = adminService.memberGetList(cri);
		logger.info("list : "+list);

		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}

		// 페이지 인터페이스 데이터
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.memberTotal(cri)));

		logger.info("pageMaker : {}",new PageDTO(cri, adminService.memberTotal(cri)));
		logger.info("상품 리스트 : {}", list.get(0));
    }

    /* 회원 수정 페이지 */
	@GetMapping("memberModify")
	public void memberGetInfo(String memberId, Criteria cri, Model model) {

		logger.info("memberGetInfo()........." + memberId);
		/* 목록 페이지 조건 정보 */

		model.addAttribute("cri", cri);

		/* 조회 페이지 정보(상품 정보) */
		model.addAttribute("memberInfo", adminService.memberGetModify(memberId));

	}

	/* 회원 정보 수정 */
	@PostMapping("memberModify.do")
	public String memberModifyPOST(MemberVO memberVO, RedirectAttributes rttr) {

		logger.info("memberModifyPOST.........." + memberVO);

		int result = adminService.memberModify(memberVO);

		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/admin/memberManage";

	}

	/* 상품 정보 삭제 */
	@PostMapping("memberDelete")
	public String memberDeletePOST(String memberId, RedirectAttributes rttr) {

		logger.info("memberModifyPOST.........." + memberId);

		int result = adminService.memberDelete(memberId);

		rttr.addFlashAttribute("delete_result", result);

		return "redirect:/admin/memberManage";
	}

}