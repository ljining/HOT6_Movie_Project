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
    
    func setPoster(with imageURL: URL) {
        self.posterImages.kf.setImage(with: imageURL)
    }
}
