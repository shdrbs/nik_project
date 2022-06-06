package com.nik.project.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.model.CartDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartServiceTest {

	@Autowired
	private CartService cartService;

	//등록 테스트
	@Test
	public void addCartTest() {
		//given
		String memberId = "aaa";
		int id = 2241;
		int count = 5;

		CartDTO dto = new CartDTO();
		dto.setMemberId(memberId);
		dto.setId(id);
		dto.setCount(count);

		//when
		int result = cartService.addCart(dto);

		//then
		System.out.println("** result : " + result);

	}
}
