package com.test.project01.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.project01.review.dto.ReviewDto;
import com.test.project01.review.dto.ReviewJoinDto;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	@Autowired
	SqlSession session;
	
	@Override
	public List<ReviewJoinDto> getList(ReviewJoinDto dto) {
		return session.selectList("review.getList",dto);
	}

	@Override
	public int getCount(ReviewJoinDto dto) {
		int count=session.selectOne("review.getCount",dto);
		return count;
	}

	@Override
	public void insert(ReviewDto dto) {
		session.insert("review.insert",dto);
	}

	@Override
	public ReviewDto getData(int reviewNum) {
		return session.selectOne("review.getData",reviewNum);
	}

	@Override
	public void update(ReviewDto dto) {
		session.update("review.update",dto);
	}

	@Override
	public void delete(int reviewNum) {
		session.delete("review.delete",reviewNum);
	}

	@Override
	public int getCount2(ReviewJoinDto dto) {
		int count=session.selectOne("review.getCount2",dto);
		return count;
	}

	@Override
	public List<ReviewJoinDto> getList2(ReviewJoinDto dto) {
		return session.selectList("review.getList2",dto);
		
	}

	
	
}