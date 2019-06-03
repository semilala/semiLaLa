package review.dao;

import java.util.List;

import paging.PagingBean;
import review.dto.ReviewDto;

public interface iReviewDao {
	public List<ReviewDto> getReviewList();	// 리뷰게시판 목록
	
	public List<ReviewDto> allPrint(String choice, String searchWord);	// 리뷰게시판 목록(검색)
	
	public List<ReviewDto> getReviewPagingList(PagingBean paging, String searchWord, String choice); // 리뷰게시판 페이징(검색)
	
	public boolean insertReview(ReviewDto dto); // 리뷰게시판 글쓰기
	public void updateReadcount(int seq);	// 조횟수
	//public List<ReviewDto> getReivews(int seq);	// 리뷰 디테일 + 댓글
	public boolean updateReview(ReviewDto dto); // 리뷰게시판 업데이트
	public boolean updateExReview(ReviewDto dto); // 리뷰게시판 업데이트
	public ReviewDto getReivew(int seq);	// 선택한 리뷰
	
	public boolean deleteReview(int seq);	//	 리뷰 삭제
	
	
}
