package combine.dao;

import java.util.List;

import combine.dto.CombineDto;
import paging.PagingBean;
import util.ReplyDto;

public interface iCombineDao {

	public boolean intsertCombine(CombineDto dto);
	public boolean updateExCombine(CombineDto dto);
	public boolean updateCombine(CombineDto dto);
	public boolean deleteCombine(int seq);
	public CombineDto detailCombine(int seq);
	List<CombineDto> getCustomPagingList(PagingBean paging, String searchWord, String choice);
	public List<ReplyDto> getReplyList(int seq, PagingBean paging);
	public boolean insertCombineReply(ReplyDto dto, int seq, int auth);
	public boolean insertCombineAddReply(ReplyDto dto, int seq, int auth);
	public boolean deleteCombineReply(int seq);
}
