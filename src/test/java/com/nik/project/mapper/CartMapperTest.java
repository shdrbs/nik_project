package com.nik.project.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.model.CartDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartMapperTest {

	@Autowired
	private CartMapper mapper;

	/* 카트 추가 */
//	@Test
//	public void addCart() {
//		String memberId = "test";
//		int id = 2241;
//		int count = 10;
//
//		CartDTO cart = new CartDTO();
//		cart.setMemberId(memberId);
//		cart.setId(id);
//		cart.setCount(count);
//
//		int result = 0;
//		result = mapper.addCart(cart);
//
//		System.out.println("결과 : " + result);
//	}

	/* 카트 삭제 */
//	@Test
//	public void deleteCartTest() {
//		int cartId = 12;
//
//		mapper.deleteCart(cartId);
//	}

	/* 카트 수량 수정 */
//	@Test
//	public void modifyCartTest() {
//		int cartId = 13;
//		int count = 5;
//
//		CartDTO cart = new CartDTO();
//		cart.setCartId(cartId);
//		cart.setCount(count);
//
//		mapper.modifyCount(cart);
//	}

	/* 카트 목록 */
//	@Test
//	public void getCartTest() {
//
//		String memberId = "test";
//
//		List<CartDTO> list = mapper.getCart(memberId);
//		for(CartDTO cart : list) {
//			System.out.println(cart);
//			cart.initSaleTotal();
//			System.out.println("init cart : " + cart);
//		}
//	}

	/* 카트 확인 */
//	@Test
//	public void checkCartTest() {
//
//		String memberId = "test";
//		int id = 2241;
//
//		CartDTO cart = new CartDTO();
//		cart.setMemberId(memberId);
//		cart.setId(id);
//
//		CartDTO resutlCart = mapper.checkCart(cart);
//		System.out.println("결과 : " + resutlCart);
//	}

	/* 장바구니 제거(주문 처리) */
	@Test
	public void deleteOrderCart() {
		String memberId = "test";
		int id = 2238;

		CartDTO cdto = new CartDTO();
		cdto.setMemberId(memberId);
		cdto.setId(id);

		mapper.deleteOrderCart(cdto);

	}

}
