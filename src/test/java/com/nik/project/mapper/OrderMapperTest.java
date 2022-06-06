package com.nik.project.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.OrderItemDTO;
import com.nik.project.model.ProductVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OrderMapperTest {

	@Autowired
	private OrderMapper mapper;

	/* 상품 정보(주문 처리) */
//	@Test
//	public void getOrderInfoTest() {
//
//		 OrderItemDTO orderInfo = mapper.getOrderInfo(2241);
//
//		 System.out.println("result : " + orderInfo);
//	}

	/* product_order 테이블 등록 */
//	@Test
//	public void registOrderTest() {
//
//		OrderDTO ord = new OrderDTO();
//		List<OrderItemDTO> orders = new ArrayList();
//
//		OrderItemDTO order1 = new OrderItemDTO();
//
//		order1.setId(2241);
//		order1.setCount(5);
//		order1.setPrice(70000);
//		order1.setDiscount(0.1);
//		order1.initSaleTotal();
//
//		ord.setOrders(orders);
//
//		ord.setOrderId("2022_test1");
//		ord.setAddressee("test");
//		ord.setMemberId("test");
//		ord.setMemberAddr1("test");
//		ord.setMemberAddr2("test");
//		ord.setMemberAddr3("test");
//		ord.setOrderState("배송중비");
//		ord.getOrderPriceInfo();
//		ord.setUsePoint(1000);
//
//		mapper.registOrder(ord);
//
//	}

	/* product_orderitem 테이블 등록 */
//	@Test
//	public void registOrderItemTest() {
//
//		OrderItemDTO oid = new OrderItemDTO();
//
//		oid.setOrderId("2022_test1");
//		oid.setId(2241);
//		oid.setCount(1);
//		oid.setPrice(70000);
//		oid.setDiscount(0.1);
//
//		oid.initSaleTotal();
//
//		mapper.registOrderItem(oid);
//
//	}

	/* 회원 돈, 포인트 정보 변경 */
//	@Test
//	public void deductMoneyTest() {
//
//		MemberVO mvo = new MemberVO();
//
//		mvo.setMemberId("test");
//		mvo.setMoney(500000);
//		mvo.setPoint(10000);
//
//		mapper.deductMoney(mvo);
//	}

	/* 상품 재고 변경 */
	@Test
	public void deductStockTest() {
		ProductVO pvo = new ProductVO();

		pvo.setId(2234);
		pvo.setStock(77);

		mapper.deductStock(pvo);
	}

}
