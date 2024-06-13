package com.mvp.service;

import java.util.List;

import com.mvp.model.Criteria;
import com.mvp.model.MovieVO;

public interface MovieService {
	//개별 구매 
	public MovieVO movieBuyDetail(int movieId);
			
	//영화 총 갯수
	public int movieGetTotal(Criteria cri);
	
	//영화 리스트
	public List<MovieVO> movieList();
	
	//영화 조회
	public MovieVO movieGetDetail(int movieId);
	
	//영화 ID&이름
	public MovieVO getMovieIdTitle(int movieId);

	//영화 제목 검색
	public List<MovieVO> searchMovie(Criteria cri);
	
	//영화 검색 페이징용
	public int getMovieTotal(Criteria cri) throws Exception;
	
	//영화 랭킹용
	public List<MovieVO> movieRank();
	
	//영화 카테고리 출력
	public List<MovieVO> selectCate1();
	
	//구매/대여 영화 최신순 정렬
	public List<MovieVO> getPurchaseMovieList();
	
	//구매/대여 영화 랭킹 정렬
	public List<MovieVO> getPurchaseMovieRank();
	
	//구독 영화 최신순 정렬
	public List<MovieVO> getSubscribeMovieList();
	
	//구독 영화 랭킹 정렬
	public List<MovieVO> getSubscribeMovieRank();
	
}
