package com.nik.project.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.nik.project.model.MemberVO;

public class CartInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {


		HttpSession session = request.getSession();

		MemberVO memberVO = (MemberVO)session.getAttribute("member");
		String errMsg = "";

		if(memberVO == null) {
			// 에러 메시지
			errMsg = "로그인을 해야 가능합니다.";

			request.setAttribute("err_msg", errMsg); // 에러메시지를 "err_msg"에 저장
			request.setAttribute("move_path", "/");  // 메인페이지 경로를 "move_path"에 저장

			// 에러 페이지 => 로그인 페이지로 이동
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/error/error.jsp");
			rd.forward(request, response);

			return false;

		} else {
			return true;
		}
	}

}
