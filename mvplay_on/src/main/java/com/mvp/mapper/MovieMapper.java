package com.mvp.mapper;

import java.util.List;

import com.mvp.model.Criteria;
import com.mvp.model.MovieVO;

public interface MovieMapper {
	//구매 정보
	public MovieVO movieBuyDetail(int movieId);
	
	//영화 검색
	public List<MovieVO> getMovieList();
	
	//영화 총 갯수
	public int movieGetTotal(Criteria cri);

	//영화 조회
	public MovieVO movieGetDetail(int movieId);
	
	//영화 ID&이름
	public MovieVO getMovieIdTitle(int movieId);
	
	/*영화 평점
	public int movieGetRating();*/
	
	//영화 제목 검색
	public List<MovieVO> searchMovie(Criteria cri);
	
	//영화 검색 페이징용
	public int getMovieTotal(Criteria cri) throws Exception;
	
	//영화 랭킹용
	public List<MovieVO> getMovieRank();
}
