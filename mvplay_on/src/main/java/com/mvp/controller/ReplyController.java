package com.mvp.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mvp.model.Criteria;
import com.mvp.model.ReplyPageVO;
import com.mvp.model.ReplyVO;
import com.mvp.service.MovieService;
import com.mvp.service.ReplyService;

@RestController
@RequestMapping("/movie")
public class ReplyController {

private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Autowired
	private ReplyService RepService;
	
	//댓글 등록
	@PostMapping("/replyWrite")
	public void replyWritePOST(ReplyVO vo) {
		logger.info("replyWritePOST");
		RepService.writeReply(vo);
	}
	
	@GetMapping(value = "/replyWrite")
	public void replyWrite() throws Exception {
		logger.info("reply write");
		
		//rttr.addAttribute("movieId",vo.getMovieId());
		
	}	
	
	//댓글 체크
	@PostMapping("/check")
	public String replyCheckPOST(ReplyVO vo) {
		return RepService.checkReply(vo);
	}
	
	//댓글 수정
	@PostMapping("/replyUpdate")
	public void replyUpdatePOST(ReplyVO vo) {
		RepService.replyUpdate(vo);
	}
	
	
	//댓글 삭제
	@PostMapping("/replyDelete")
	public void replyDeletePOST(ReplyVO vo) {
		RepService.replyDelete(vo);
	}
	
	//댓글 리스트
	@GetMapping(value = "/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ReplyPageVO replyListPOST(Criteria cri) {
		logger.info("reply list");
		return RepService.replyList(cri);
	}
	
}
