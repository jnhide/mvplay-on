package com.mvp.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mvp.model.AskBoardVO;
import com.mvp.model.MemberVO;
import com.mvp.service.AskBoardService;


@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private AskBoardService askbservice;
	

	/*개인게시판 목록 페이지 접속(페이징)*/
	@GetMapping("/ownList")
	public void AsksboardownListGET(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
	    MemberVO mvo = (MemberVO)session.getAttribute("member");
	    String userId = mvo.getUserId();
	    
	    List<AskBoardVO> boardList = askbservice.ownList(userId);
	    
	    if(!boardList.isEmpty()) {
			model.addAttribute("ownList", boardList);	
		}else {
			model.addAttribute("listCheck", "empty");
		}

		/*
		 * int total = askbservice.askboardGetTotal(cri); PageVO pageMake = new
		 * PageVO(cri, total); model.addAttribute("pageMaker", pageMake)
		 */;

	    
	}

	/*게시판 등록 페이지 접속*/
	@GetMapping("/enroll")
	public void AskboardEnrollGET() {
		log.info("게시판 등록 페이지 진입");
	}
	
	/* 게시판 등록 */
    @PostMapping("/enroll")
    public String boardEnrollPOST(AskBoardVO board, RedirectAttributes rttr) {
        
        log.info("AskBoardVO : " + board);
        
        askbservice.enroll(board);
        
        rttr.addFlashAttribute("result", "enroll success");
        
        return "redirect:/board/ownList";
        
    }
    
    /*게시판 조회*/
    @GetMapping("/get")
    public void askboardGetPageGET(int ano, Model model) {
    	model.addAttribute("pageInfo", askbservice.select(ano));
    	
    	//model.addAttribute("cri", cri);
    }
    
    /*게시판 수정 페이지 이동*/
    @GetMapping("/modify")
    public void askboardModifyGET(int ano, Model model) {
    	model.addAttribute("pageInfo", askbservice.select(ano));
    }
    
    /*게시글 수정*/
    @PostMapping("/modify")
    public String askboardModifyPOST(AskBoardVO board, RedirectAttributes rttr) {
    	log.info("board"+ board);
    	
    	askbservice.modify(board);
    	rttr.addFlashAttribute("result", "modify success");
    	return "redirect:/board/ownList";
    }
    
    /*페이지 삭제*/
    @PostMapping("/delete")
    public String askboardDeletePOST(int ano, RedirectAttributes rttr) {
    	askbservice.delete(ano);
    	rttr.addFlashAttribute("result","delete success");
    	return "redirect:/board/ownList";
    }
    
    
}
