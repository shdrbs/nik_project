package com.nik.project.service;

import java.util.List;

import com.nik.project.model.OrderCancelDTO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.OrderPageItemDTO;

public interface OrderService {

	/* 주문 정보 */
	public List<OrderPageItemDTO> getProductInfo(List<OrderPageItemDTO> orders);

	/* 주문 */
	public void order(OrderDTO ord);

	/* 주문 취소 */
	public void orderCancel(OrderCancelDTO dto);

}
