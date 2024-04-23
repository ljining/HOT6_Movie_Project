//
//  Constants.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

// MARK: - API 주소
public enum MovieApi {
    static let apiKey = "d3997ec594f8168a935621b953f7712b"
    static let language = "ko-ko"
    static let region = "KR"
    
    // MARK: - 지금 상영중인 영화
    //https://api.themoviedb.org/3/movie/now_playing?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko&region=KR&page=1
    static let movieNowPlaying = "https://api.themoviedb.org/3/movie/now_playing"
    
    // MARK: - 영화명으로 영화 검색
    //https://api.themoviedb.org/3/search/movie?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko&query=파묘
    static let searchMovie = "https://api.themoviedb.org/3/search/movie"
    
    // MARK: - 영화 ID로 영화 검색
    //https://api.themoviedb.org/3/movie/838209?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko
    static let searchMovieId = "https://api.themoviedb.org/3/movie/"
    
    // MARK: - 영화배우이름으로 영화배우 검색 (영화배우 ID 확인)
    //https://api.themoviedb.org/3/search/person?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko&query=최민식
    static let searchPerson = "https://api.themoviedb.org/3/search/person"
    
    // MARK: - 영화배우 ID로 이미지 검색
    //https://api.themoviedb.org/3/person/64880/images?api_key=d3997ec594f8168a935621b953f7712b
    static let personImage = "https://api.themoviedb.org/3/person/"
    
    // MARK: - 영화ID로 출연 배우 검색
    //https://api.themoviedb.org/3/movie/838209/credits?api_key=d3997ec594f8168a935621b953f7712b
    static let searchCredits = "https://api.themoviedb.org/3/movie/"
    
    // MARK: - 이미지 주소
    static let imageUrl = "https://image.tmdb.org/t/p/original"
}
