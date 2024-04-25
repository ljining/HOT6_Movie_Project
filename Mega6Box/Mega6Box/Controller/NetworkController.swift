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
    
    
    //컴플리션핸들러는 비동기작업을 했을때 비동기작업이 언제 끝나는지 알수 없으니 컴플리션핸들러를 통해서 비동기 작업이 끝났구나! 알수 있어서 다음작업을 할수있게 해줍니다.
    //지난 강의에서 사용하던 배열로 리턴했을때 배열에 값이 없는 이유가 네트워크 작업이 비동기라서 배열로 전달하기 전에 다음작업이 실행되어버려서 항상 배열에 값이 없는걸로 출력이 됐는데 컴플리션핸들러를 사용하면! 배열에 값을 알 수 있습니다! 
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
                    completion(.success(movieResults.results))  //컴플리션 여기부분이 아까보신 중괄호 안에 들어가는 내용, 구조체를 전\달해 줍니다.
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
    func fetchSearchMovieId(movieId: Int, apiKey: String, language: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
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
                    let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                    // 디코딩된 결과를 completion 핸들러에 전달
                    completion(.success(movieDetail))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        //4. 작업 시작
        task.resume()
    }
    
    // MARK: - 영화배우이름으로 영화배우 검색 (영화배우 ID 확인)
    //https://api.themoviedb.org/3/search/person?api_key=d3997ec594f8168a935621b953f7712b&language=ko-ko&query=최민식
    func fetchSearchPerson(apiKey: String, language: String, name: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        //1. API 요청 URL
        let urlString = "\(MovieApi.searchPerson)?api_key=\(MovieApi.apiKey)&language=\(MovieApi.language)&query=\(name)"
        
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
                    // JSON 응답을 MovieResults 구조체로 디코딩, 구조체에 값이 들어갑니다
                    let personResults = try decoder.decode(PersonResults.self, from: data)
                    // 디코딩된 결과를 completion 핸들러에 전달
                    completion(.success(personResults.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        //4. 작업 시작
        task.resume()
    }
    
    
    // MARK: - 영화배우 ID로 이미지 검색
    //https://api.themoviedb.org/3/person/64880/images?api_key=d3997ec594f8168a935621b953f7712b
    //static let personImage = "https://api.themoviedb.org/3/person/"
    func fetchPersonImages(id: Int, apiKey: String, completion: @escaping (Result<PersonImage, Error>) -> Void) {
        //1. API 요청 URL
        let urlString = "\(MovieApi.personImage)\(id)/images?api_key=\(MovieApi.apiKey)"
        
        //2. URL 생성
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        print("이미지url: \(url)")
        
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
                    //let decoder = JSONDecoder()
                    // JSON 응답을 MovieResults 구조체로 디코딩
                    let personImage = try JSONDecoder().decode(PersonImage.self, from: data)
                    // 디코딩된 결과를 completion 핸들러에 전달
                    //completion(.success(personImage.profiles))
                    completion(.success(personImage))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        //4. 작업 시작
        task.resume()
    }
        
    // MARK: - 영화ID로 출연 배우 검색
    //https://api.themoviedb.org/3/movie/838209/credits?api_key=d3997ec594f8168a935621b953f7712b
    //static let searchCredits = "https://api.themoviedb.org/3/movie/"
    func fetchSearchCredits(movieId: Int, apiKey: String, completion: @escaping (Result<[Cast], Error>) -> Void) {
        //1. API 요청 URL
        let urlString = "\(MovieApi.searchCredits)\(movieId)/credits?api_key=\(MovieApi.apiKey)"
        
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
                    let creditData = try decoder.decode(Credit.self, from: data)
                    // 디코딩된 결과를 completion 핸들러에 전달
                    completion(.success(creditData.cast))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        //4. 작업 시작
        task.resume()
    }
}
