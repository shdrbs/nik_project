package com.nik.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.OrderItemDTO;
import com.nik.project.model.OrderPageItemDTO;
import com.nik.project.model.ProductVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class OrderDAO {

	@Autowired
	private SqlSession sqlSession;

	/* 주문 상품 정보 */
	public OrderPageItemDTO getProductInfo(int id) {

		return sqlSession.selectOne("com.nik.project.mapper.OrderMapper.getProductInfo", id);
	}

	/* 주문 상품 정보(주문 처리) */
	public OrderItemDTO getOrderInfo(int id) {

		return sqlSession.selectOne("com.nik.project.mapper.OrderMapper.getOrderInfo", id);
	}

	/* 주문 테이블 등록 */
	public int registOrder(OrderDTO ord) {

		return sqlSession.insert("com.nik.project.mapper.OrderMapper.registOrder", ord);
	}

	/* 주문 아이템 테이블 등록 */
	public int registOrderItem(OrderItemDTO orid) {

		return sqlSession.insert("com.nik.project.mapper.OrderMapper.registOrderItem", orid);
	}

	/* 주문 금액 차감 */
	public int deductMoney(MemberVO mvo) {

		return sqlSession.update("com.nik.project.mapper.OrderMapper.deductMoney", mvo);
	}

	/* 주문 재고 차감 */
	public int deductStock(ProductVO pvo) {

		return sqlSession.update("com.nik.project.mapper.OrderMapper.getProductInfo", pvo);
	}

	/* 주문 취소 */
	public int orderCancel(String orderId) {

		return sqlSession.update("com.nik.project.mapper.OrderMapper.orderCancel", orderId);
	}

	/* 주문 상품 정보(주문취소) */
	public List<OrderItemDTO> getOrderItemInfo(String orderId) {

		return sqlSession.selectList("com.nik.project.mapper.OrderMapper.getOrderItemInfo", orderId);
	}

	/* 주문 정보(주문취소) */
	public OrderDTO getOrder(String orderId) {

		return sqlSession.selectOne("com.nik.project.mapper.OrderMapper.getOrder", orderId);
	}
}
