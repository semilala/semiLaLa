package custom.dao;

import java.util.List;

import custom.dto.CustomDto;
import paging.PagingBean;
import util.ReplyDto;

public interface iCustomDao {

	
	public boolean insertCustom(CustomDto dto);
	public boolean deleteCustom(int seq);
	//public List<CustomDto> allPrint();
	public CustomDto detail(CustomDto dto);
	public boolean update(CustomDto dto);
	public List<CustomDto> getCustomPagingList(PagingBean paging, String searchWord, String choice);
	
	public boolean updateExCustom(CustomDto dto);
	
	public boolean insertCustomRelpy(ReplyDto dto, int auth);
	public List<ReplyDto> replyDetail(int pseq);
	public boolean replyDelte(int seq,int pseq);
	
}
