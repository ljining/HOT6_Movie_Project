//
//  MovieDetailViewController.swift
//  Mega6Box
//
//  Created by imhs on 4/23/24.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    var movieTitle: String = ""
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var profileView: UIView!
    
    let buttonWidth: CGFloat = 100  // 버튼의 가로 크기
    let buttonHeight: CGFloat = 100 // 버튼의 세로 크기
    let buttonSpacing: CGFloat = 5 // 버튼 간의 간격
    
    // 스크롤뷰 생성 및 설정
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTextView.layer.cornerRadius = 15
        
        // 스크롤뷰 생성 및 설정
        scrollView = UIScrollView(frame: CGRect(x: 0, y: buttonHeight, width: view.frame.width, height: buttonHeight))
        //scrollView = UIScrollView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 100))
        scrollView.showsHorizontalScrollIndicator = true // 수평 스크롤바 표시
        scrollView.delegate = self
        profileView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: profileView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor).isActive = true
        
        getMovieData("파묘")
    }
    
    func getMovieData(_ movieTitle: String) {
        NetworkController.shared.fetchSearchMovieId(movieId: 838209, apiKey: MovieApi.apiKey, language: MovieApi.language) { result in
            switch result {
            case .success(let movie):
                guard let backdropImage = URL(string: "\(MovieApi.imageUrl)\(movie.backdropPath)") else { return }
                
                var genres: String = ""
                for i in 0..<movie.genres.count {
                    if genres == "" {
                        genres += movie.genres[i].name
                    } else {
                        genres += ", " + movie.genres[i].name
                    }
                }
                print("genres: \(genres)")
                
                DispatchQueue.main.async {
                    self.backdropImageView.kf.setImage(with: backdropImage)
                    self.titleLabel.text = movie.title
                    self.releaseDateLabel.text = "\( movie.releaseDate) 개봉"
                    self.overviewTextView.text = movie.overview
                    self.genresLabel.text = genres
                }
                
            case .failure(let error):
                print("영화 목록을 가져오는데 실패했습니다: \(error)")
            }
        }
        
        // MARK: - 배우 이미지 불러오기
        NetworkController.shared.fetchSearchCredits(movieId: 838209, apiKey: MovieApi.apiKey) { result in
            switch result {
            case .success(let castList):
                //프로필 이미지가 있는 사람만 추리기 
                let list = castList.filter { $0.profilePath != nil }
                
                // 이미지뷰들을 스크롤뷰에 추가
                var contentWidth: CGFloat = 0
                for i in 0..<list.count {
                    if let castProfilePath = list[i].profilePath {
                        if let url = URL(string: "\(MovieApi.imageUrl)\(castProfilePath)") {
                            //print(url)
                            
                            let button = UIButton(type: .custom)
                            button.frame = CGRect(x: CGFloat(i) * (self.buttonWidth + self.buttonSpacing), y: 0, width: self.buttonWidth, height: self.buttonHeight)
                                                        
                            button.setTitle("\(list[i].name)", for: .normal)
                            button.tag = list[i].id
                            
                            button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside) // 버튼이 탭되었을 때의 액션을 설정
                            
                            DispatchQueue.main.async {
                                button.kf.setImage(with: url, for: .normal)
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
                print("failure: \(error)")
            }
        }
    }
    
    // MARK: - 배우 상세 정보 페이지로 이동
    @objc func buttonTapped(_ sender: UIButton) {
        let profileVC = ProfileViewController()
        profileVC.tempId = sender.tag
        profileVC.tempName = sender.titleLabel?.text
        present(profileVC, animated: true, completion: nil)
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    
}
