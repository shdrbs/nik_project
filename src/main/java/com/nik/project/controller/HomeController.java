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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.Criteria;
import com.nik.project.model.PageDTO;
import com.nik.project.model.ProductVO;
import com.nik.project.service.AttachService;
import com.nik.project.service.ProductService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private ProductService productService;

	/* main 페이지  */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

		logger.info("메인 페이지 진입");

		/* navbar 출력 */
		model.addAttribute("cate1", productService.getCateCode1());
		model.addAttribute("cate2", productService.getCateCode2());

		/* 메인화면 상품 이미지, 가격, 설명 등 출력 */
		// 평점순 상품
		model.addAttribute("ls", productService.likeSelect());
		// 최근등록순 상품
		model.addAttribute("newProduct", productService.newProduct());

		return "main";
	}

}
