package org.zerock.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.zerock.Mapper.TimeMapper;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TimeMapperTests {

	@Autowired
	private TimeMapper timeMapper;

	@Test
	public void testgetTime() {
		log.info(timeMapper.getClass().getName());
		log.info(timeMapper.getTime());

	}

	@Test
	public void testgetTime2() {
		log.info("getTime2");
		log.info(timeMapper.getTime2());
	}
}