//
//  BackDropCell.swift
//  Mega6Box
//
//  Created by 이유진 on 4/24/24.
//

import UIKit


class BackDropCell: UICollectionViewCell{
    @IBOutlet weak var backDropImage: UIImageView!
    
    func setupMovieImages() {
        backDropImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/qrGtVFxaD8c7et0jUtaYhyTzzPg.jpg"))
    }
}
