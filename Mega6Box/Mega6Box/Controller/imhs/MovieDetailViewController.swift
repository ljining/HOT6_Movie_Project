//
//  MovieDetailViewController.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import UIKit
import Kingfisher


class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    var tempMovieId: Int?
    var movieId: Int = 0
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var bookingButton: UIButton!
    
    let buttonWidth: CGFloat = 100  // 버튼의 가로 크기
    let buttonHeight: CGFloat = 100 // 버튼의 세로 크기
    let buttonSpacing: CGFloat = 5 // 버튼 간의 간격
    
    // 스크롤뷰 생성 및 설정
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        //movieId = 1017163   //범죄도시4
        //movieId = 838209   //파묘
        //movieId = 1011985       //쿵푸팬더4
        
        if let id = tempMovieId {
            movieId = id
        }
        
        setUI()                 //UI 설정
        getMovieData(movieId)   //영화 정보 가져오기
    }
    
    // MARK: UI 설정
    func setUI() {
        //bookingButton.layer.cornerRadius = 10
        
        //배우 프로필 사진이 담기는 스크롤뷰 생성 및 설정
        scrollView = UIScrollView(frame: CGRect(x: 0, y: buttonHeight, width: view.frame.width, height: buttonHeight))
        scrollView.showsHorizontalScrollIndicator = true // 수평 스크롤바 표시
        
        profileView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: profileView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor).isActive = true
        
        overviewTextView.layer.cornerRadius = 15
    }
    
    // MARK: - 영화 정보 가져오기
    func getMovieData(_ movieId: Int) {
        NetworkController.shared.fetchSearchMovieId(movieId: movieId, apiKey: MovieApi.apiKey, language: MovieApi.language) { result in
            switch result {
            case .success(let movie):
                guard let backdropImage = URL(string: "\(MovieApi.imageUrl)\(movie.backdropPath)") else { return }
                
                //영화 장르 확인
                var genres: String = ""
                for i in 0..<movie.genres.count {
                    if genres == "" {
                        genres += movie.genres[i].name
                    } else {
                        genres += ", " + movie.genres[i].name
                    }
                }
                
                DispatchQueue.main.async {
                    self.backdropImageView.kf.setImage(with: backdropImage)
                    self.titleLabel.text = movie.title
                    self.releaseDateLabel.text = "개봉: \( movie.releaseDate)"
                    self.overviewTextView.text = movie.overview
                    self.genresLabel.text = "장르: \(genres)"
                }
                
            case .failure(let error):
                print("영화 정보를 가져오는데 실패했습니다.: \(error)")
            }
        }
        
        // MARK: - 배우 이미지 불러오기
        NetworkController.shared.fetchSearchCredits(movieId: movieId, apiKey: MovieApi.apiKey) { result in
            switch result {
            case .success(let list):
                //프로필 이미지가 있는 사람만 추리기
                let castList = list.filter { $0.profilePath != nil }
                                
                // 이미지뷰들을 스크롤뷰에 추가
                var contentWidth: CGFloat = 0
                
                for i in 0..<castList.count {
                    if let castProfilePath = castList[i].profilePath {
                        if let url = URL(string: "\(MovieApi.imageUrl)\(castProfilePath)") {
                                                        
                            let button = UIButton(type: .custom)
                            button.frame = CGRect(x: CGFloat(i) * (self.buttonWidth + self.buttonSpacing), y: 0, width: self.buttonWidth, height: self.buttonHeight)
                                                        
                            //프로필 페이지에서 배우 정보를 가져오기 위해 id, name 지정
                            button.setTitle("\(castList[i].name)", for: .normal)
                            button.tag = castList[i].id
                            
                            button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside) // 배우 프로필 선택 시 상세 정보 화면으로 이동
                            
                            DispatchQueue.main.async {
                                button.kf.setImage(with: url, for: .normal) //배우프로필 사진
                                button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                                button.layer.borderWidth = 1
                                button.layer.cornerRadius = 50
                                button.clipsToBounds = true
                                
                                self.scrollView.addSubview(button)
                                contentWidth += self.buttonWidth + self.buttonSpacing
        
                                // 스크롤뷰의 contentSize 설정
                                self.scrollView.contentSize = CGSize(width: contentWidth, height: self.buttonHeight)
                            }
                        }
                    }
                }
                
            case .failure(let error):
                print("배우 이미지 정보를 가져오는데 실패했습니다.: \(error)")
            }
        }
    }
    
    // MARK: - 배우 상세 정보 화면으로 이동
    @objc func buttonTapped(_ sender: UIButton) {
        let profileVC = ProfileViewController()
        profileVC.tempId = sender.tag          //배우ID
        profileVC.tempName = sender.titleLabel?.text  //배우이름
        profileVC.modalPresentationStyle = .fullScreen //이동할 화면을 풀 스크린으로 만들기
        present(profileVC, animated: true, completion: nil)
    }
    
    // MARK: - 예매하기 선택 시 화면 이동
    @IBAction func bookingButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MovieReservationPage", bundle: Bundle.main)
        guard let reservationVC = storyboard.instantiateViewController(withIdentifier: "MoiveReservationViewController") as? MoiveReservationViewController else { return }
            
        reservationVC.tempMovieId = movieId
        
        present(reservationVC, animated: true)
    }
}
