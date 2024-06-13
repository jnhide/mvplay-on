package com.mvp.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mvp.model.Criteria;
import com.mvp.model.MovieVO;
import com.mvp.model.PageVO;
import com.mvp.model.ReplyVO;
import com.mvp.service.MovieService;
import com.mvp.service.ReplyService;

@Controller
public class MovieController {
	
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private ReplyService replyService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	//리뷰 작성
	@GetMapping("/movie/replyWrite/{userId}")
	public String replyWriteWindowGET(@PathVariable("userId")String userId, int movieId, Model model) {
		MovieVO vo = movieService.getMovieIdTitle(movieId);
		model.addAttribute("movieId", movieId);
		model.addAttribute("userId",userId);
		
		return "/movie/replyWrite";
	}
	
	
	//리뷰 수정
	@GetMapping("/movie/replyUpdate")
	public String replyWriteGET(ReplyVO vo, Model model) throws Exception {
		MovieVO mvo = movieService.getMovieIdTitle(vo.getMovieId());
		model.addAttribute("movieInfo", mvo);
		model.addAttribute("replyInfo", replyService.getUpdateReply(vo.getReplyNum()));
		model.addAttribute("userId", vo.getUserId());
		
		return "/movie/replyUpdate";
		
	}
	

	@GetMapping("/movie/movieSearch")
	public void movieSearchGET(Criteria cri, Model model) throws Exception {
		logger.info("영화 검색 페이지");
		
		List searchList = movieService.searchMovie(cri);
		
		model.addAttribute("movieList",searchList);
		
        int total = movieService.getMovieTotal(cri);
		
		PageVO page = new PageVO(cri, total);
		
		model.addAttribute("page", page);

		
	}
	

	
	
}
