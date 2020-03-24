package com.test.project01.master.category.Dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.project01.master.category.Dto.ItemDto;
import com.test.project01.master.category.Dto.ItemViewDto;
import com.test.project01.master.category.Dto.Item_OrderDetail_Dto;
import com.test.project01.master.category.Dto.User_Orders_Dto;
import com.test.project01.master.category.Dto.categoryDto;
import com.test.project01.order.dto.OrderDetailDto;


@Repository
public class categoryDaolmpl implements categoryDao{
	
	@Autowired
	private SqlSession session;

	@Override
	public List<categoryDto> categoryList() {	
		List<categoryDto> list = session.selectList("category.list");
		return list;
	}

	@Override
	public void itemInsert(ItemDto dto) {
		session.insert("category.itemInsert", dto);
	}

	@Override
	public List<ItemDto> itemList() {
		List<ItemDto> list = session.selectList("category.itemSelect");
		return list;
	}

	@Override
	public ItemDto itemViewData(int itemNum) {
		return session.selectOne("category.itemViewContent", itemNum);
	}

	@Override
	public ItemViewDto itemViewList(int itemNum) {
		return session.selectOne("category.itemViewData", itemNum);
	}

	@Override
	public void ItemUpdate(ItemDto dto) {
		session.update("category.itemUpDate", dto);
	}

	@Override
	public void ItemDelete(int itemNum) {
		session.delete("category.itemDelete", itemNum);
	}

	@Override
	public void upResult(User_Orders_Dto dto) {
		session.update("category.resultUpDate");
	}

	@Override
	public void minusCount(OrderDetailDto detailDto) {
		session.update("category.minusCount",detailDto);
	}

	@Override
	public List<User_Orders_Dto> userList() {
		List<User_Orders_Dto> userList = session.selectList("category.select_user_orders");
		return userList;
	}

	@Override
	public List<Item_OrderDetail_Dto> item_orderList() {
		List<Item_OrderDetail_Dto> itemList=session.selectList("category.select_item_order_detail");
		return itemList;
	}
	
	
}
