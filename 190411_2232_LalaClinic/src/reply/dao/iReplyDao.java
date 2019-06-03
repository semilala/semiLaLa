package reply.dao;

import java.util.List;

import reply.dto.ReplyDto;

public interface iReplyDao {
	
	public boolean insertReply(int pseq, ReplyDto dto);	// 리뷰 작성
	public boolean replyAnswer(int seq, ReplyDto dto);	// 답글작성
	
	public List<ReplyDto> getReplyList(int pseq, String tname);	// 그 글의 댓글 출력 

	public boolean deleteReply(int seq);		// 리뷰 삭제
}
