package member.dao;

import java.util.List;

import combine.dto.CombineDto;
import custom.dto.CustomDto;
import member.dto.MemberDto;
import paging.PagingBean;
import review.dto.ReviewDto;

public interface iMemberDao {

	public MemberDto loginCheck(String id, String pwd);
	public boolean idSameCheck(String id);
	public boolean insertMember(MemberDto dto);
	
	public MemberDto myDetail(String id); //회원 디테일
	public boolean myUpdate(MemberDto dto); //회원 수정
	public boolean myDelete(String id); //회원 탈퇴
	
	public List<MemberDto> adminAllPrint(PagingBean paging, String choice, String findWord); //관리자 전체목록
	public MemberDto adminDetail(String id); //관리자 디테일
	public boolean adminUpdate(MemberDto dto); //관리자 수정
	
	public List<MemberDto> memberAllPrint(PagingBean paging, String choice, String findWord); //회원 전체목록
	
	public List<CombineDto> myCombineList(String id, PagingBean paging, String sWord, String sOption); //내글목록-상담및예약
	public List<ReviewDto> myReviewList(String id, PagingBean paging, String sWord, String sOption); //내글목록-시술후기
	public List<CustomDto> myCustomList(String id, PagingBean paging, String sWord, String sOption); //내글목록-고객소리함
	
	public boolean myDelAllReply(String id); //회원탈퇴 - 내댓글 모조리 삭제
	//public 
}
