//
//  NetworkController.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import Foundation

// MARK: - TMDB와 통신하기
final class NetworkController {
    //싱글톤 패턴으로 만들기
    static let shared = NetworkController() //shared 이름의 정적 속성을 통해서 접근하도록
    private init() { }  //외부에서 NetworkController 클래스의 인스턴스를 생성하는 것을 막기 위해 사용
    
    // MARK: - 지금 상영중인 영화
    //https://api.themoviedb.org/3/movie/now_playing?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko&region=KR&page=1
    func fetchMovieNowPlaying(apiKey: String, language: String, region: String, page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        //1. API 요청 URL
        let urlString = "\(MovieApi.movieNowPlaying)?api_key=\(MovieApi.apiKey)&language=\(MovieApi.language)&region=\(region)&page=\(page)"
        
        //2. URL 생성
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        print("url: \(url)")
        
        //3. 작업 만들기
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 에러 처리
            if let error = error {
                completion(.failure(error))
                return
            }
            // 데이터 파싱
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    // JSON 응답을 MovieResults 구조체로 디코딩
                    let movieResults = try decoder.decode(MovieResults.self, from: data)
                    // 디코딩된 결과를 completion 핸들러에 전달
                    completion(.success(movieResults.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        //4. 작업 시작
        task.resume()
    }
    
    // MARK: - 영화명으로 영화 검색
    //https://api.themoviedb.org/3/search/movie?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko&query=파묘
    func fetchSearchMovie(apiKey: String, language: String, movieTitle: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        //1. API 요청 URL
        let urlString = "\(MovieApi.searchMovie)?api_key=\(MovieApi.apiKey)&language=\(MovieApi.language)&query=\(movieTitle)"
        
        //2. URL 생성
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        print("url: \(url)")
        
        //3. 작업 만들기
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 에러 처리
            if let error = error {
                completion(.failure(error))
                return
            }
            // 데이터 파싱
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    // JSON 응답을 MovieResults 구조체로 디코딩
                    let movieResults = try decoder.decode(MovieResults.self, from: data)
                    // 디코딩된 결과를 completion 핸들러에 전달
                    completion(.success(movieResults.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        //4. 작업 시작
        task.resume()
    }
    
    // MARK: - 영화 ID로 영화 검색
    //https://api.themoviedb.org/3/movie/838209?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko
    func fetchSearchMovieId(movieId: Int, apiKey: String, language: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        //1. API 요청 URL
        let urlString = "\(MovieApi.searchMovieId)/\(movieId)?api_key=\(MovieApi.apiKey)&language=\(MovieApi.language)"
        
        //2. URL 생성
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        print("url: \(url)")
        
        //3. 작업 만들기
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 에러 처리
            if let error = error {
                completion(.failure(error))
                return
            }
            // 데이터 파싱
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    // JSON 응답을 MovieResults 구조체로 디코딩
                    let movieResults = try decoder.decode(MovieResults.self, from: data)
                    // 디코딩된 결과를 completion 핸들러에 전달
                    completion(.success(movieResults.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        //4. 작업 시작
        task.resume()
    }
    
}
