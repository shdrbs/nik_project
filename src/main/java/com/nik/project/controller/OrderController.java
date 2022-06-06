package com.nik.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.OrderPageDTO;
import com.nik.project.service.MemberService;
import com.nik.project.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private MemberService memberService;

	/* 주문 페이지 */
	@GetMapping("/order/{memberId}")
	public String orderPgaeGET(@PathVariable("memberId") String memberId, OrderPageDTO opd, Model model) {

		model.addAttribute("orderList", orderService.getProductInfo(opd.getOrders()));
		model.addAttribute("memberInfo", memberService.getMemberInfo(memberId));

		return "/order";

	}

	/* 상품 결제 */
	@PostMapping("/order")
	public String orderPagePost(OrderDTO od, HttpServletRequest request) {

		orderService.order(od);

		MemberVO mvo = new MemberVO();
		mvo.setMemberId(od.getMemberId());

		HttpSession session = request.getSession();

		try {
			MemberVO memberLogin = memberService.memberLogin(mvo);
			memberLogin.setMemberPw("");
			session.setAttribute("member", memberLogin);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return "redirect:/";
	}

}
