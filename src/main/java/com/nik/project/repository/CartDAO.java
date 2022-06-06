package com.nik.project.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.CartDTO;
import com.nik.project.model.Criteria;
import com.nik.project.model.OrderDTO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CartDAO {

	@Autowired
	private SqlSession sqlSession;

	/* 장바구니 추가 */
	public int addCart(CartDTO cart) throws Exception{

		return sqlSession.insert("com.nik.project.mapper.CartMapper.addCart", cart);
	}

	/* 장바구니 삭제 */
	public int deleteCart(int cartId) {

		log.info("service : "+cartId);
		int i = sqlSession.delete("com.nik.project.mapper.CartMapper.deleteCart", cartId);
		log.info("service i : "+i);
		return i;
	}

	/* 장바구니 수량 수정 */
	public int modifyCount(CartDTO cart) {

		return sqlSession.update("com.nik.project.mapper.CartMapper.modifyCount", cart);
	}

	/* 장바구니 목록 리스트 */
	public List<CartDTO> getCartList(String memberId) {

		return sqlSession.selectList("com.nik.project.mapper.CartMapper.getCartList", memberId);
	}

	/* 장바구니 확인 */
	public CartDTO checkCart(CartDTO cart) {

		return sqlSession.selectOne("com.nik.project.mapper.CartMapper.checkCart", cart);
	}

	/* 장바구니 제거(주문) */
	public int deleteOrderCart(CartDTO dto) {

		return sqlSession.delete("com.nik.project.mapper.CartMapper.deleteOrderCart", dto);
	}

}
