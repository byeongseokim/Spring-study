package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {  // Criteria는 검색의 기준을 의미함 
	
	// pageNum과 amount 값을 같이 전달 하는 용도
	private int pageNum;
	private int amount;
	
	public Criteria() {
		this(1,10); // 1페이지 10개
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

}
