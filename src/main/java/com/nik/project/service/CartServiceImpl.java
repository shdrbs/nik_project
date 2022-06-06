package com.nik.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.CartDTO;
import com.nik.project.repository.AttachDAO;
import com.nik.project.repository.CartDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CartServiceImpl implements CartService{

	@Autowired
	private CartDAO cartDao;

	@Autowired
	private AttachDAO attachDao;

	/* 장바구니 추가 */
	@Override
	public int addCart(CartDTO cart) {

		// 장바구니 데이터 체크
		CartDTO checkCart = cartDao.checkCart(cart);

		if(checkCart != null) {
			return 2;
		}

		// 장바구니 등록 & 에러 시 0반환
		try {
			return cartDao.addCart(cart);
		} catch (Exception e) {
			return 0;
		}
	}

	/* 장바구니 정보 리스트 */
	@Override
	public List<CartDTO> getCarList(String memberId) {

		List<CartDTO> cart = cartDao.getCartList(memberId);

		for(CartDTO dto : cart) {

			dto.initSaleTotal();

			/* 이미지 정보 얻기 */
			int id = dto.getId();

			List<AttachImageVO> imageList = attachDao.getAttachList(id);

			dto.setImageList(imageList);
		}

		return cart;
	}

	/* 장바구니 수량 수정 */
	@Override
	public int modifyCount(CartDTO cart) {

		return cartDao.modifyCount(cart);
	}

	/* 장바구니 삭제 */
	@Override
	public int deleteCart(int cartId) {

		return cartDao.deleteCart(cartId);
	}
}
