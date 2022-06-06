package com.nik.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nik.project.model.MemberVO;
import com.nik.project.model.QnaVO;
import com.nik.project.service.QnaService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/qna/")
@Slf4j
public class QnaController {

	@Autowired
	private QnaService qnaService;

	@RequestMapping("qnaList")
	public String qnaList(HttpSession session, Model model) {

		log.info("qnaList");

		String memberId = ((MemberVO)session.getAttribute("member")).getMemberId();
		model.addAttribute("qnaList", qnaService.listQna(memberId));

		return "/qna/qna_list";
	}

	@RequestMapping("qnaView")
	public String qnaView(int qseq, Model model) {

		log.info("qnaView");

		model.addAttribute("qnaVO", qnaService.getQna(qseq));

		return "/qna/qna_view";
	}

	@RequestMapping("qnaWriteForm")
	public String qnaWriteForm() {

		log.info("qnaWriteForm");
		return "/qna/qna_write";
	}

	@RequestMapping("qnaWrite")
	public String qnaWrite(QnaVO qnaVO, HttpSession session, Model model) {

		log.info("qnaWrite : " + qnaVO);
		String msg = "";
		String movePath = "";

		String memberId = ((MemberVO)session.getAttribute("member")).getMemberId();
		qnaVO.setMemberId(memberId);

		if (qnaService.insertQna(qnaVO) == true) {

			msg = "게시글 저장에 성공하였습니다";
			movePath = "/qna/qnaList";

		} else {

			msg = "게시글 저장에 실패하였습니다";
			movePath = "/qna/qnaWriteForm";
		}

		model.addAttribute("err_msg", msg);
		model.addAttribute("move_path", movePath);

		return "/error/error";
	}
}