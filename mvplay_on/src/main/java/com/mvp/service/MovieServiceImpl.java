package com.mvp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvp.mapper.MovieMapper;
import com.mvp.model.Criteria;
import com.mvp.model.MovieVO;


@Service
public class MovieServiceImpl implements MovieService {
	
	@Autowired
	private MovieMapper mapper;
	
	
	//개별 구매
	@Override
	public MovieVO movieBuyDetail(int movieId) {
		return mapper.movieBuyDetail(movieId);
	}
		
	//영화 총 갯수
	@Override
	public int movieGetTotal(Criteria cri) {
			
		return mapper.movieGetTotal(cri);
			
	}
	
	//영화 리스트
	@Override
	public List<MovieVO> movieList() {
		
		return mapper.getMovieList();
	}
	
	//영화 조회
	@Override
	public MovieVO movieGetDetail(int movieId) {
		System.out.println("movieGetDetail"+movieId);
		return mapper.movieGetDetail(movieId);
	}
	
	//영화 ID&이름
	@Override
	public MovieVO getMovieIdTitle(int movieId) {
		return mapper.getMovieIdTitle(movieId);
	}
		
	/*영화 평점
	@Override
	public int movieGetRating() {
		return mapper.movieGetRating();
	}*/
	
	@Override
	public List<MovieVO> searchMovie(Criteria cri) {
		return mapper.searchMovie(cri);
	}
	
	@Override
	public int getMovieTotal(Criteria cri) throws Exception {
		return mapper.getMovieTotal(cri);
	}
	
	//영화 랭킹용
	@Override
	public List<MovieVO> movieRank() {
		return mapper.getMovieRank();
	}
	
	//영화 카테고리 리스트 출력 
	@Override
	public List<MovieVO> selectCate1() {
		return mapper.selectCate1();
	}
	
	//구매/대여 영화 최신순 정렬
	@Override
	public List<MovieVO> getPurchaseMovieList() {
		return mapper.getPurchaseMovieList();
	}
	//구매/대여 영화 랭킹
	@Override
	public List<MovieVO> getPurchaseMovieRank() {
		return mapper.getPurchaseMovieRank();
	}
	
	//구독 영화 최신순 정렬
	@Override
	public List<MovieVO> getSubscribeMovieList() {
		return mapper.getSubscribeMovieList();
	}
	//구독 영화 랭킹
	@Override
	public List<MovieVO> getSubscribeMovieRank() {
		// TODO Auto-generated method stub
		return mapper.getSubscribeMovieRank();
	}
	
}
