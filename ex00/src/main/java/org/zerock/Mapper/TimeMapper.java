package org.zerock.Mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

	@Select("SELECT SYSDATE FROM DUAL")
	public String getTime();
	
	public String getTime2();
}
