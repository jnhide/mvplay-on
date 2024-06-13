package com.mvp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mvp.model.MemberVO;
import com.mvp.model.WishListVO;
import com.mvp.service.WishListService;

@Controller
@RequestMapping("/movie/*")
public class WishListController {
	private static final Logger logger = LoggerFactory.getLogger(WishListController.class);
	
	@Autowired
	private WishListService wishService;
	
	//보고싶어요 등록 
	@ResponseBody
	@PostMapping("/wish")
	public ResponseEntity<String> postMovieWish(HttpServletRequest request, WishListVO wvo, RedirectAttributes rttr) {
		logger.info("위시리스트 wvo::"+wvo);
		
		//세션 가져오기!!
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		if(mvo != null) { //세션이 있는 경우
			//기존 평가 검색 
			
			//0. 값이 있다면 인서트 or 삭제 판단
			//1. 기존 위시리스트 값이 있는지 없는지 검색
			WishListVO myWishVO = new WishListVO();
			myWishVO = wishService.selectUserWish(wvo);
			
			//2. 기존에 위시리스트가 없다면 인서트
			if (myWishVO ==null) {
				wishService.insertWishList(wvo);
				rttr.addFlashAttribute("wish_result", "보고싶어요에 등록되었습니다.");
				
			}else {
				//기존 위시리스트가 있다면 삭제
				wvo.setId(myWishVO.getId());
				wishService.deleteWishList(wvo);
				rttr.addFlashAttribute("wish_result", "보고싶어요에서 삭제되었습니다.");
			}
			return new ResponseEntity<>("ok", HttpStatus.OK);
		}

		//로그인 하지 않은 경우 
		return new ResponseEntity<>("로그인을 해주세요", HttpStatus.BAD_REQUEST);
	}

}
