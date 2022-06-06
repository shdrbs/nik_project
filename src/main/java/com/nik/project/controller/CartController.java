package com.nik.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nik.project.model.CartDTO;
import com.nik.project.model.MemberVO;
import com.nik.project.service.CartService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/cart/")
@Slf4j
public class CartController {

	@Autowired
	private CartService cartService;

	/*
	 * 장바구니에 상품 등록
	 * 1. 등록 성공
	 * 2. 등록된 데이터 존재
	 * 5. 로그인 필요
	 */
	@PostMapping("add")
	@ResponseBody
	public String addCartPOST(CartDTO cart, HttpServletRequest request) {
		// 로그인 체크
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO)session.getAttribute("member");
		if(memberVO == null) {
			return "5";
		}

		// 카트 등록

		int result = cartService.addCart(cart);

		return result + "";
	}

	/* 장바구니 페이지 */
	@GetMapping("cart")
	public String cartPageGET(Model model, HttpSession session) {

		String memberId = ((MemberVO)session.getAttribute("member")).getMemberId();

		model.addAttribute("cartInfo", cartService.getCarList(memberId));

		return "/cart";
	}

	/* 장바구니 수량 수정 */
	@PostMapping("update")
	public String updateCartPOST(CartDTO cart) {

		cartService.modifyCount(cart);

		return "redirect:/cart/cart";

	}

	/* 장바구니 삭제 */
	@PostMapping("delete")
	public String deleteCartPOST(CartDTO cart) {

		cartService.deleteCart(cart.getCartId());

		return "redirect:/cart/cart";

	}

}
