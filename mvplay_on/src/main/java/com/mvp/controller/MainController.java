package com.mvp.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvp.model.MemberVO;
import com.mvp.model.MovieVO;
import com.mvp.model.PurchaseVO;
import com.mvp.model.RatingVO;
import com.mvp.model.WishListVO;
import com.mvp.service.MemberService;
import com.mvp.service.MovieService;
import com.mvp.service.PurchaseService;
import com.mvp.service.RatingService;
import com.mvp.service.WishListService;

@Controller
public class MainController {
	 
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private RatingService ratingService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PurchaseService purchaseService;
	
	//위시리스트 확인
	@Autowired
	private WishListService wishService;
	

	//기존 매핑
	@RequestMapping("/main")
	public void list(HttpServletRequest request) {
		List<MovieVO> movieList = movieService.movieList();
		List<MovieVO> movieRank = movieService.movieRank();
		request.setAttribute("movieList", movieList);
		request.setAttribute("movieRank", movieRank);
		
	}
	

	@GetMapping(value = {"/movie/movieDetail", "/movie/purchaseDetail","/movie/moviePlay"})
	public void movieGetInfoGET(HttpServletRequest request, int movieId, Model model) {
		logger.info("movie Get Info");
		//세션 가져오기!!
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		if(mvo != null) { //세션이 있는 경우
			RatingVO rvo = new RatingVO();
			
			//세션이 있는 경우 고객이 선택한 별점을 ratingInfo에 넣음
			rvo.setUserId(mvo.getUserId());
			rvo.setMovieId(movieId);
			RatingVO myRatingVO =ratingService.selectRating(rvo);
			
			//고객의 별점 정보를 넣음
			model.addAttribute("ratingInfo", myRatingVO);
			
			//위시리스트 확인
			//1. 기존 위시리스트 값이 있는지 없는지 검색
			WishListVO wvo = new WishListVO();
			wvo.setUserId(rvo.getUserId());
			wvo.setMovieId(movieId);
			WishListVO myWishVO = wishService.selectUserWish(wvo);
			//2. 위시리스트가 있다면 모델에 담음
			if (myWishVO !=null) {
				model.addAttribute("wishInfo", myWishVO);
			}else {
				model.addAttribute("wishInfo", null);
			}
			
			
			//구매기록 확인 
			PurchaseVO pvo = new PurchaseVO();
			pvo.setUserId(mvo.getUserId());
			pvo.setMovieId(movieId);
			int checkPurchase = purchaseService.checkPurchase(pvo);
			if(checkPurchase>0) {
				//오늘 날짜
				Date now = new Date();
				
				//만료일 확인
				PurchaseVO date = purchaseService.purchaseCheckDate(pvo);
				Date expiredDate = date.getExpiredDate();
				
				boolean result = expiredDate.after(now);
				
				model.addAttribute("purchase_result", result);
			}else {
				model.addAttribute("purchase_result", false);
			}
		}
		
		MovieVO vo = movieService.movieGetDetail(movieId);
		model.addAttribute("movieInfo", vo);
		
	}
	
	
	@GetMapping("/movie/purchaseMain")
	public void getPurchaseMain(HttpServletRequest request) throws Exception {
		logger.info("getPurchaseMain");
		
		List<MovieVO> movieList = movieService.getPurchaseMovieList();
		List<MovieVO> movieRank = movieService.getPurchaseMovieRank();
		List<MovieVO> cate1List = movieService.selectCate1();
		
		request.setAttribute("movieList", movieList);
		request.setAttribute("movieRank", movieRank);
		request.setAttribute("cate1List", cate1List);
	}
	
	@GetMapping("/movie/subscribeMain")
	public void getSubscribeMainPage(HttpServletRequest request) {
		logger.info("get subscribe Main");
		
		List<MovieVO> movieList = movieService.getSubscribeMovieList();
		List<MovieVO> movieRank = movieService.getSubscribeMovieRank();
		List<MovieVO> cate1List = movieService.selectCate1();
		
		request.setAttribute("movieList", movieList);
		request.setAttribute("movieRank", movieRank);
		request.setAttribute("cate1List", cate1List);
		
		
	}
	
	//평가(nav)
	@GetMapping("/movie/ratingMain")
	public void getRating(HttpServletRequest request, Model model) throws Exception {
		logger.info("getRatingMain");
		//세션 가져오기!!
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		if(mvo!=null) { //세션이 있는 경우
			List<MovieVO> movieList = memberService.getUserRatingList(mvo);
			
			if(movieList.isEmpty()) {
				model.addAttribute("result", "emptyList");
				
			}else {
				model.addAttribute("movieList", movieList);
				model.addAttribute("result", "notEmpty");
			}
		}
		else {
			//로그인이 없으면 결과창 empty
			model.addAttribute("result", "empty");
		}
		
	}
	
	@GetMapping("/movie/wishList")
	public void getWishList(HttpServletRequest request, Model model) throws Exception {
		logger.info("getWishList");
		
		//세션 가져오기!!
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		if(mvo!=null) { //세션이 있는 경우
			List<MovieVO> movieList = memberService.getUserWishList(mvo);
			
			if(movieList.isEmpty()) {
				model.addAttribute("result", "emptyList");
			}else {
				model.addAttribute("movieList", movieList);
				model.addAttribute("result", "notEmpty");
			}

		}
		else {
			//로그인이 없으면 결과창 empty
			model.addAttribute("result", "empty");
		}
		
	}
	
	
}
