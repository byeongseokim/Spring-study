package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;

	@GetMapping("/list")
	public String list(Model model) {

		log.info("list");
		model.addAttribute("list", service.getList());
		return "board/list";
	}

	// POST 방식으로 처리
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {

		log.info("reguster: " + board);

		service.register(board);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";
		// redirect: 접두어를 사용하면 MVC가 내부적으로 response.sendRedirect()를 처리해 주기 때문에 편리함
	}

	// get방식으로 접근 하지만 post 방식으로 동작하므로 @postMapping을 이용해서 처리
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify: " + board);

		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	// 삭제는 반드시 POST 방식으로만 처리함
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {

		log.info("remove..." + bno);
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	// post 방식으로 처리하지만, 입력받아야 하므로 GET 방식 추가
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping({"/get","modify"})
	public void get(@RequestParam("bno") Long bno, Model model) {
		
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}

}
