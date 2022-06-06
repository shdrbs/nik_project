package com.nik.project.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nik.project.model.Criteria;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.PageDTO;
import com.nik.project.service.CartService;
import com.nik.project.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member/")
public class MemberController {

	@Autowired
	private MemberService memberservice;

	@Autowired
    private JavaMailSender mailSender;

	@Autowired
	private CartService cartService;

	//회원가입 페이지 이동
	@GetMapping("join")
	public void loginGET() {

		log.info("회원가입 페이지 진입");

	}

	//회원가입
	@PostMapping("join")
	public String joinPOST(MemberVO member) throws Exception{

		log.info("join 진입");

        /* 회원가입 쿼리 실행 */
        memberservice.memberJoin(member);

		return "redirect:/";

	}

	//로그인 페이지 이동
	@GetMapping("login")
	public void joinGET() {

		log.info("로그인 페이지 진입");

	}

	// 아이디 중복 검사
	@PostMapping("memberIdChk")
	@ResponseBody
	public String memberIdChkPOST(String memberId) throws Exception{

		log.info("memberIdChk() 진입");

		int result = memberservice.idCheck(memberId);

		log.info("결과값 = " + result);

		if(result != 0) {

			return "fail";	// 중복 아이디가 존재

		} else {

			return "success";	// 중복 아이디 x

		}

	} // memberIdChkPOST() 종료

	// 이메일 인증
    @GetMapping("mailCheck")
    @ResponseBody
    public String mailCheckGET(String email) throws Exception{

        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");

        /* 인증번호(난수) 생성 */
        Random random = new Random();
		/* 111111 ~ 999999 범위의 숫자를 얻기 위해서 */
        int checkNum = random.nextInt(888888) + 111111;
        log.info("인증번호 " + checkNum);

        /* 이메일 보내기 */
        String setFrom = "noin0527@naver.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content =
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" +
                "인증 번호는 " + checkNum + "입니다." +
                "<br>" +
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

        try {

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);

        }catch(Exception e) {
            e.printStackTrace();
        }

        String num = Integer.toString(checkNum);

        return num;
    }

    // 로그인
    @PostMapping("login.do")
    public String memberLogin(String memberPw, HttpServletRequest request, MemberVO member, RedirectAttributes rttr) {

        log.info("login 메서드 진입");
        log.info("전달된 데이터 : {}" + member);
        log.info("memberPW : " + memberPw);

        HttpSession session = request.getSession();

        BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

        String rawPw = "";
        String encodePw = "";

        MemberVO memberVO = memberservice.memberLogin(member);    // 제출한아이디와 일치하는 아이디 있는지

        if(memberVO != null) { // 일치하는 아이디 존재시

            rawPw = member.getMemberPw();        		// 사용자가 제출한 비밀번호
            encodePw = memberVO.getMemberPw();        	// 데이터베이스에 저장한 인코딩된 비밀번호

            if(true == pwEncoder.matches(rawPw, encodePw)) {  // 비밀번호 일치여부 판단

            	memberVO.setMemberPw("");                     // 인코딩된 비밀번호 정보 지움
                session.setAttribute("member", memberVO);     // session에 사용자의 정보 저장
                session.setAttribute("memberPw", memberPw);
                log.info("비밀번호 : "+memberVO);
                return "redirect:/";        // 메인페이지 이동


            } else {

                rttr.addFlashAttribute("result", 0);
                return "redirect:/member/login";    // 로그인 페이지로 이동
            }

        } else { // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)

            rttr.addFlashAttribute("result", 0);
            return "redirect:/member/login";    // 로그인 페이지로 이동
        }

    } //

    /*회원 탈퇴*/
    @GetMapping("delete.do")
    public String memberInactive(String memberId, HttpSession session) {

    	log.info("memberId"+memberId);

    	memberservice.memberDelete(memberId);

    	session.invalidate();

    	return "redirect:/";
    }

    // 메인페이지 로그아웃
    @GetMapping("logout.do")
    public String logoutMainGET(HttpSession session) {

    	log.info("logoutMainGET메서드 진입");

    	session.invalidate(); // session에 저장된 정보 삭제

        return "redirect:/";
    }

    // gnb_area 로그아웃 메서드
    @PostMapping("logout.do")
    public String logoutPOST(HttpSession session) {

        log.info("gnb 로그아웃 메서드 진입");

        session.invalidate();

        return "redirect:/";
    }

}
