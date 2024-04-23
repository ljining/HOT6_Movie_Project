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
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieData("파묘")
    }
    
    func getMovieData(_ movieTitle: String) {
        NetworkController.shared.fetchSearchMovie(apiKey: MovieApi.apiKey, language: MovieApi.language, movieTitle: movieTitle) { result in
            switch result {
             case .success(let movies):
                 print("검색 영화: ")
                 for movie in movies {
                     print("- \(movie.title)")
                     print("- \(MovieApi.imageUrl)\(movie.backdropPath)")
                     print("- \(movie.releaseDate) 개봉")
                     guard let backdropImage = URL(string: "\(MovieApi.imageUrl)\(movie.backdropPath)") else { return }
                                          
                     DispatchQueue.main.async {
                         self.backdropImageView.kf.setImage(with: backdropImage)
                         self.titleLabel.text = movie.title
                         self.releaseDateLabel.text = "\( movie.releaseDate) 개봉"
                         self.overviewTextView.text = movie.overview
                         //self.runtimeLabel.text = movie.runtime
                     }
                     
                 }
             case .failure(let error):
                 print("영화 목록을 가져오는데 실패했습니다: \(error)")
             }
        }
    }
}
