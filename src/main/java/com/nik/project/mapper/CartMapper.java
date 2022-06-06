package com.nik.project.mapper;

import java.util.List;

import com.nik.project.model.CartDTO;

public interface CartMapper {

	/* 장바구니 추가 */
	public int addCart(CartDTO cart) throws Exception;

	/* 장바구니 삭제 */
	public int deleteCart(int cartId);

	/* 장바구니 수량 수정 */
	public int modifyCount(CartDTO cart);

	/* 장바구니 목록 리스트 */
	public List<CartDTO> getCartList(String memberId);

	/* 장바구니 확인 */
	public CartDTO checkCart(CartDTO cart);

	/* 장바구니 제거(주문 처리) */
	public int deleteOrderCart(CartDTO dto);
}
