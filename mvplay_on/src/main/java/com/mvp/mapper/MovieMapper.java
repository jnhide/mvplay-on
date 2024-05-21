package com.mvp.mapper;

import java.util.List;

import com.mvp.model.Criteria;
import com.mvp.model.MovieVO;

public interface MovieMapper {
	/*구매 정보
	public MovieVO movieGetDetail(int movieId);*/ 
	
	//영화 검색
	public List<MovieVO> getMovieList();
	
	//영화 총 갯수
	public int movieGetTotal(Criteria cri);

	//영화 조회
	public MovieVO movieGetDetail(int movieId);
	
	//영화 정보 가져오기
	public List<MovieVO> movieGetInfo(int movieId);
	/*영화 평점
	public int movieGetRating();*/
}
