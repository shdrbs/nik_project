package com.nik.project.mapper;

import java.util.List;

import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.OrderItemDTO;
import com.nik.project.model.OrderPageItemDTO;
import com.nik.project.model.ProductVO;

public interface OrderMapper {

	/* 주문 상품 정보 */
	public OrderPageItemDTO getProductInfo(int id);

	/* 주문 상품 정보(주문 처리) */
	public OrderItemDTO getOrderInfo(int id);

	/* 주문 테이블 등록 */
	public int registOrder(OrderDTO ord);

	/* 주문 아이템 테이블 등록 */
	public int registOrderItem(OrderItemDTO orid);

	/* 주문 금액 차감 */
	public int deductMoney(MemberVO mvo);

	/* 주문 재고 차감 */
	public int deductStock(ProductVO pvo);

	/* 주문 취소 */
	public int orderCancel(String orderId);

	/* 주문 상품 정보(주문취소) */
	public List<OrderItemDTO> getOrderItemInfo(String orderId);

	/* 주문 정보(주문취소) */
	public OrderDTO getOrder(String orderId);

}
