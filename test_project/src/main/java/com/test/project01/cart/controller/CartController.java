package com.test.project01.cart.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.project01.cart.dto.CartListDto;
import com.test.project01.cart.service.CartService;
import com.test.project01.users.Dto.UsersDto;

@Controller
public class CartController {
	@Autowired
	private CartService service;
	
	//1. 장바구니 추가
	@RequestMapping(value = "/Users_Item/cart", method = RequestMethod.POST)
	public String addCart(@ModelAttribute("dto") CartListDto dto, HttpSession session) {
		UsersDto user=(UsersDto)session.getAttribute("userDto");
		String userId=user.getUserId();		
		//String userId=(String)session.getAttribute("userId");
		//dto.setUserId(userId);
		//장바구니에 기존 상품 있나 검사
		int count=service.countCart(dto.getItemNum(), userId);
		if(count == 0) {
			//없으면 추가
			service.addCart(dto);
		}else {
			//있으면 update
			service.updateCart(dto);
		}

		return "redirect:../shop/cartList.do";
	}
	
	//2. 장바구니 목록
	@RequestMapping("/shop/cartList")
	public ModelAndView getCartList(HttpSession session, Model model, ModelAndView mView) {
		UsersDto user=(UsersDto)session.getAttribute("userDto");
		String userId=user.getUserId();		
		//List<CartListDto> cartList=service.cartList(userId);
		//model.addAttribute("cartList", cartList);
		
		Map<String, Object> map=new HashMap<String, Object>();
		List<CartListDto> list=service.cartList(userId);
		int sumMoney=service.sumMoney(userId);
		
		int fee=sumMoney>= 50000 ? 0 : 2500;
		map.put("list", list);
		map.put("count", list.size());
		map.put("sumMoney", sumMoney);
		map.put("fee", fee);
		map.put("allPrice", sumMoney+fee);
		mView.setViewName("shop/cartList");
		mView.addObject("map", map);
		return mView;
		
		
	}
	
	//3. 장바구니 삭제
	@ResponseBody
	@RequestMapping(value="/shop/deleteEachCart", method=RequestMethod.POST)
	public Map<String, Object> deleteEachCart(@RequestParam(value="arrCheckBox[]")List<String> list) {
		for(int i=0; i<list.size(); i++) {
			service.deleteCart(Integer.parseInt(list.get(i)));
		}
		Map<String,Object> map=new HashMap<>();
		map.put("isSuccess", true);
		return map;
	}
	
	//4. 장바구니 수정
	@RequestMapping("/shop/updateCart")
	public String updateCart(@RequestParam int[] cartStock, @RequestParam int[] itemNum,
			HttpSession session) {
		//session 아이디
		//String userId=(String)session.getAttribute("userId");
		UsersDto user=(UsersDto)session.getAttribute("userDto");
		String userId=user.getUserId();	
		//레코드의 갯수만큼 반복문 실행
		for(int i=0; i<itemNum.length; i++) {
			CartListDto dto=new CartListDto();
			dto.setUserId(userId);
			dto.setCartStock(cartStock[i]);
			dto.setItemNum(itemNum[i]);
			service.modifyCart(dto);
		}
		return "redirect:cartList.do";
		
	}
	
	//바로 주문폼으로 넘어가게 하기
	@RequestMapping(value = "/Users_Item/cart2", method = RequestMethod.POST)
	public String User_addCart2(@ModelAttribute("dto") CartListDto dto, HttpSession session) {
		UsersDto user=(UsersDto)session.getAttribute("userDto");
		String userId=user.getUserId();		
		//String userId=(String)session.getAttribute("userId");
		//dto.setUserId(userId);
		//장바구니에 기존 상품 있나 검사
		int count=service.countCart(dto.getItemNum(), userId);
		if(count == 0) {
			//없으면 추가
			service.addCart(dto);
		}else {
			//있으면 update
			service.updateCart(dto);
		}

		return "redirect:../shop/orderform.do";
	}
}


