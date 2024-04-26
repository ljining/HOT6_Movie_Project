//
//  MovieListCollectionViewCell.swift
//  Mega6Box
//
//  Created by 이유진 on 4/23/24.
//

import UIKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImages: UIImageView!
    
    func setUpPoster(input: String) {
        guard let url = URL(string: input) else {
            print("")
            return
        }
        self.posterImages.kf.setImage(with: url)
    }
}
