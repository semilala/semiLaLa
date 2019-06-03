package paging;

public class PagingUtil {

public static PagingBean setPagingInfo(PagingBean paging) {
		
		paging.setCountPerPage(10);		// [1]	-> : 10 한화면에 10개의 글
		paging.setBlockCount(10);		// [1] ~ [10] : 한화면에 페이지갯수가 10개(하단)
		
		paging.setStartNum(
				 paging.getTotalCount() - (paging.getNowPage()-1) * paging.getCountPerPage() 
				 );
		System.out.println("startNum: " + paging.getStartNum());
		/*
			23 -> / 10	-> 2
			23 -> % 10 > 0 -> + 1	==> 3
					 
			23 - (1 - 1) * 10 = 23 			23	23~14?
			23 - (2 - 1) * 10 = 13			13	13~4?
			23 - (3 - 1) * 10 = 3			3	3~1?
						
						[1][2][3]		
		*/
		return paging;
	}
	
}
