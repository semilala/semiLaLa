package down.dao;

import java.util.List;

import down.dto.DownDto;
import paging.PagingBean;
import util.ReplyDto;

public interface iDownDao {

	public List<DownDto> getDownPagingList(PagingBean paging, String choice, String findWord); //목록출력
	public boolean insertDown(DownDto dto); //글입력
	public DownDto detailDown(int seq); //디테일
	
	public boolean updateExDown(DownDto dto); //파일수정 x
	public boolean updateUpDown(DownDto dto); //파일수정 o
	
	public List<ReplyDto> getReplyList(int seq, PagingBean paging); //댓글목록
	public boolean insertDownReply(ReplyDto dto, int seq, int auth); //댓글입력
	
	public boolean insertDownAddReply(ReplyDto dto, int seq);
	
	public boolean deleteDown(int seq, String tname); //본문글 삭제 (아직안됌)
	public boolean deleteDownReply(int seq); //댓글 개별삭제
}
