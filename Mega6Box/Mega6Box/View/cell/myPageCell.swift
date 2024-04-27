//
//  myPageCell.swift
//  Mega6Box
//
//  Created by 김태담 on 4/24/24.
//

import Foundation
import UIKit

class myPageCell:UITableViewCell {
    
    @IBOutlet weak var Cellimage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var num: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.Cellimage.layer.cornerRadius = 20
    }
    
    func getMovieData(_ movieId: Int) {
        NetworkController.shared.fetchSearchMovieId(movieId: movieId, apiKey: MovieApi.apiKey, language: MovieApi.language) { result in
            switch result {
            case .success(let movieData):
                print("내가 불러온 데이터: \(movieData)")
                
                if let url = URL(string: "\(MovieApi.imageUrl)\(movieData.posterPath)") {
                    print("url: \(url)")
                    
                    //영화 장르 확인
                    var genres: String = ""
                    for i in 0..<movieData.genres.count {
                        if genres == "" {
                            genres += movieData.genres[i].name
                        } else {
                            genres += ", " + movieData.genres[i].name
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.Cellimage.kf.setImage(with: url)
                        self.title.text = movieData.title
                    }
                }
                
            case .failure(let error):
                print("영화데이터를 받아오는데 실패했습니다.: \(error)")
            }
        }
    }
}
