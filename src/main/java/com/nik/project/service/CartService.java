package com.nik.project.service;

import java.util.List;

import com.nik.project.model.CartDTO;
import com.nik.project.model.Criteria;
import com.nik.project.model.OrderDTO;

public interface CartService {

	/* 장바구니 추가 */
	public int addCart(CartDTO cart);

	/* 장바구니 정보 리스트 */
	public List<CartDTO> getCarList(String memberId);

	/* 장바구니 수량 수정 */
	public int modifyCount(CartDTO cart);

	/* 장바구니 삭제 */
	public int deleteCart(int cartId);

}
