package com.nik.project.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nik.project.model.AttachImageVO;
import com.nik.project.model.CartDTO;
import com.nik.project.model.MemberVO;
import com.nik.project.model.OrderCancelDTO;
import com.nik.project.model.OrderDTO;
import com.nik.project.model.OrderItemDTO;
import com.nik.project.model.OrderPageItemDTO;
import com.nik.project.model.ProductVO;
import com.nik.project.repository.AttachDAO;
import com.nik.project.repository.CartDAO;
import com.nik.project.repository.MemberDAO;
import com.nik.project.repository.OrderDAO;
import com.nik.project.repository.ProductDAO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderDAO orderDao;

	@Autowired
	private AttachDAO attachDao;

	@Autowired
	private MemberDAO memberDao;

	@Autowired
	private CartDAO cartDao;

	@Autowired
	private ProductDAO productDao;

	/* 주문 페이지 */
	@Override
	public List<OrderPageItemDTO> getProductInfo(List<OrderPageItemDTO> orders) {

		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();

		for(OrderPageItemDTO ord : orders) {

			OrderPageItemDTO productInfo = orderDao.getProductInfo(ord.getId());

			productInfo.setCount(ord.getCount());

			productInfo.initSaleTotal();

			List<AttachImageVO> imageList = attachDao.getAttachList(productInfo.getId());

			productInfo.setImageList(imageList);

			result.add(productInfo);
		}

		return result;
	}

	/* 주문 */
	@Override
	@Transactional
	public void order(OrderDTO ord) {

		/* 사용할 데이터가져오기 */
		/* 회원 정보 */
		MemberVO member = memberDao.getMemberInfo(ord.getMemberId());

		/* 주문 정보 */
		List<OrderItemDTO> ords = new ArrayList<>();
		for(OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItem = orderDao.getOrderInfo(oit.getId());
			// 수량 셋팅
			orderItem.setCount(oit.getCount());
			// 기본정보 셋팅
			orderItem.initSaleTotal();
			// 상품 이름 설정
			orderItem.setName(oit.getName());
			//List객체 추가
			ords.add(orderItem);
		}
		/* OrderDTO 셋팅 */
		ord.setOrders(ords);
		ord.getOrderPriceInfo();
		log.info("ord: "+ord.getOrders());

		/*DB 주문,주문상품(,배송정보) 넣기*/

		/* orderId만들기 및 OrderDTO객체 orderId에 저장 */
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddmm");
		String orderId = member.getMemberId() + format.format(date);
		ord.setOrderId(orderId);

		/* db넣기 */
		orderDao.registOrder(ord);						//product_order 등록
		for(OrderItemDTO oit : ord.getOrders()) {		//product_orderItem 등록
			oit.setOrderId(orderId);
			orderDao.registOrderItem(oit);
		}

		/* 비용 포인트 변동 적용 */

		/* 비용 차감 & 변동 돈(money) Member객체 적용 */
		int calMoney = member.getMoney();
		calMoney -= ord.getOrderFinalSalePrice();
		member.setMoney(calMoney);

		/* 포인트 차감, 포인트 증가 & 변동 포인트(point) Member객체 적용 */
		int calPoint = member.getPoint();
		calPoint = calPoint - ord.getUsePoint() + ord.getOrderSavePoint();	// 기존 포인트 - 사용 포인트 + 획득 포인트
		member.setPoint(calPoint);

		/* 변동 돈, 포인트 DB 적용 */
		orderDao.deductMoney(member);

		/* 재고 변동 적용 */
		for(OrderItemDTO oit : ord.getOrders()) {
			/* 변동 재고 값 구하기 */
			ProductVO pvo = productDao.getProductInfo(oit.getId());
			pvo.setStock(pvo.getStock() - oit.getCount());
			/* 변동 값 DB 적용 */
			orderDao.deductStock(pvo);
		}

		/* 장바구니 제거 */
		for(OrderItemDTO oit : ord.getOrders()) {
			CartDTO dto = new CartDTO();
			dto.setMemberId(ord.getMemberId());
			dto.setId(oit.getId());

			cartDao.deleteOrderCart(dto);
		}

	}

	/* 주문취소 */
	@Override
	@Transactional
	public void orderCancel(OrderCancelDTO dto) {

		/* 주문, 주문상품 객체 */
		/*회원*/
		MemberVO mvo = memberDao.getMemberInfo(dto.getMemberId()); // 회원 아이디 저장
		/*주문상품*/
		List<OrderItemDTO> ords = orderDao.getOrderItemInfo(dto.getOrderId()); // 주문한 상품 리스트 저장

		for(OrderItemDTO ord : ords) {
			ord.initSaleTotal(); // 할인가, 포인트 등 계산
		}
		/* 주문 */
		OrderDTO odto = orderDao.getOrder(dto.getOrderId()); // 상품 번호 저장

		odto.setOrders(ords); // 주문한 상품 리스트를 OrderDTO에 저장

		odto.getOrderPriceInfo(); // 상품비용,적립 포인트,배송비용,최종비용 계산

		/* 주문상품 취소 DB */
		orderDao.orderCancel(dto.getOrderId());

		/* 돈, 포인트, 재고 변환 */
		/* 돈 */
		int calMoney = mvo.getMoney();             // 회원의 현재 돈을 불러온다
		calMoney += odto.getOrderFinalSalePrice(); // 회원의 현재 돈에 결제했던 상품금액을 더한다
		mvo.setMoney(calMoney);					   // 더한 금액을 회원의 돈에 저장

		/* 포인트 */
		int calPoint = mvo.getPoint();
		calPoint = calPoint + odto.getUsePoint() - odto.getOrderSavePoint();
		mvo.setPoint(calPoint);

		/* 돈, 포인트 DB적용 */
		orderDao.deductMoney(mvo);

		/* 재고 */
		for(OrderItemDTO ord : odto.getOrders()) {
			ProductVO pvo = productDao.getProductInfo(ord.getId());
			pvo.setStock(pvo.getStock() + ord.getCount());
			orderDao.deductStock(pvo);
		}

	}

}
