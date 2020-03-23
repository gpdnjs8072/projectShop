package com.test.project01.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.project01.cart.dao.CartDao;
import com.test.project01.cart.dto.CartListDto;

@Service
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDao dao;
	//1.장바구니 추가
	@Override
	public void addCart(CartListDto dto) {
		dao.addCart(dto);
	}
	//2.장바구니 목록
	@Override
	public List<CartListDto> cartList(String userId) {
		return dao.cartList(userId);
	}
	//3.장바구니 삭제
	@Override
	public void deleteCart(int cartNum) {
		dao.deleteCart(cartNum);
	}
	//장바구니 수정
	@Override
	public void modifyCart(CartListDto dto) {
		dao.modifyCart(dto);
	}
	//장바구니 상품 확인
	@Override
	public int countCart(int itemNum, String userId) {
		return dao.countCart(itemNum, userId);
	}
	//장바구니 상품 수량 변경
	@Override
	public void updateCart(CartListDto dto) {
		dao.updateCart(dto);
	}
<<<<<<< HEAD
=======
	//장바구니 금액 합계
	@Override
	public int sumMoney(String userId) {
		return dao.sumMoney(userId);
	}
>>>>>>> refs/remotes/origin/yun2
}
