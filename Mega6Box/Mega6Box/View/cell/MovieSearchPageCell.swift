//
//  MovieSearchPageCell.swift
//  Mega6Box
//
//  Created by imhs on 4/27/24.
//

import UIKit

class MovieSearchPageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.cornerRadius = 20
    }
}
