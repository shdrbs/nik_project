package com.nik.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nik.project.model.MemberVO;
import com.nik.project.service.MypageService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/mypage/")
@Log4j2
public class MypageController {

	@Autowired
	private MypageService mypageService;

	/* 마이룸(회원정보 페이지) */
	@GetMapping("mypage")
    public String mypage(Model model, HttpSession session) {

		String memberId = ((MemberVO)session.getAttribute("member")).getMemberId();

		MemberVO mvo = mypageService.mypageInfo(memberId);

    	model.addAttribute("member", mvo);

    	return "/mypage/mypage";
    }

	/* 마이룸(회원정보 수정 페이지) */
	@GetMapping("mypageModify")
	public String mypageModify() {

		return "/mypage/mypageModify";
	}

	/* 마이룸(회원정보 수정 기능) */
	@PostMapping("mypageModify.do")
	public String updateProc(MemberVO memberVO, HttpSession session) {

		MemberVO member = (MemberVO) session.getAttribute("member");

		String memberId = member.getMemberId();
		memberVO.setMemberId(memberId);

		log.info("memberVO : "+memberVO);
		log.info("memberVO : "+memberId);

		mypageService.updateMember(memberVO);

		return "redirect:/mypage/mypage";
	}

}
