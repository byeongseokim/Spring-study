package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	// 테스트 전에 해당 번호의 게시물이 존재하는지 반드시 확인 할 것
	private Long[] bnoArr = { 1L, 2L, 3L, 4L, 5L };

	@Autowired
	public ReplyMapper mapper;

	@Test
	public void testCreate() {

		IntStream.rangeClosed(1, 10).forEach(i -> {

			ReplyVO vo = new ReplyVO();

			// 게시물의 번호
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글테스트" + i);
			vo.setReplyer("replyer" + i);

			mapper.insert(vo);
		});
	}

	@Test
	public void testMapper() {

		log.info(mapper);
	}

	@Test
	public void testRead() {

		Long targetRno = 5L;

		ReplyVO vo = mapper.read(targetRno);

		log.info(vo);
	}

	@Test
	public void testDelete() {

		Long targetRno = 1L;

		mapper.delete(targetRno);
	}

	@Test
	public void testUpdate() {

		Long targetRno = 10L;

		ReplyVO vo = mapper.read(targetRno);

		vo.setReply("Update Reply");

		int count = mapper.update(vo);

		log.info("UPDATE COUNT: " + count);
	}

	@Test
	public void testList() {

		Criteria cri = new Criteria();

		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);

		replies.forEach(reply -> log.info(reply));
	}

}
